Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739DD47CC64
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517193; cv=none; b=BSx6Aey/KUmqwclpwWh+H3ivfvGK+jnxoFYYWPOwQxG5nT88oEEpQ/VnCNAg6Y8B/DSr8DsY4T4dDL/OuwVdn1b6JX4Uy0ffT1PmXgPJAuQ+dcTKeNyaKc37go9eTi834iimh5P3Moz/et7Q8lw/+2FO8RLiaT5T5hkbOngQZIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517193; c=relaxed/simple;
	bh=ybnlZpPjoOWPZrPehfQVWpLEAYCoCwwbP4xydzOBmlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcDrEfUEyXe8NkG3CTfghtZyG0WLpPkgipZnfzBiJgsS+iyEbZ1UCQg0NCbMd/7bE5i1pDigmxx2MO3L0zJOe5dzE98dA0SIZvavVhP2qvB9SUn7gJxOpK8SeYaz2XVUU6sDTgHw0FI/kw4Aq+r4NblzYOwjXKfpCdynlTAQ/4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M+l0elol; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M+l0elol"
Message-ID: <35a091e5-49cb-4890-a5e1-0de3a96b5d97@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778517189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4uplCsF1SM0jtzlwmEZpydQlDRcHYDqRQoiUSonAJCE=;
	b=M+l0elolf37627ANCOqHYS+xEhkWNusN4b21hfZv+N6Eqz13iXaISAFPSRkR1RQgEQimpN
	HarFG18qhCs8pzl1h4p9yZlvZ9NmEOATYjhF0BcTCJ8OXkWRopdloC7D9cmAyDsh51pYHZ
	UYOSmd/zaljnkzayeZMOZC69Wqo78DQ=
Date: Mon, 11 May 2026 09:33:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 06/24] bpf: Refactor jmp history to use
 dedicated spi/frame fields
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260511053301.1878610-1-yonghong.song@linux.dev>
 <20260511053332.1884123-1-yonghong.song@linux.dev>
 <DIFZDSS2F9P4.9J051GNVD30G@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DIFZDSS2F9P4.9J051GNVD30G@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/11/26 6:17 PM, Alexei Starovoitov wrote:
> On Sun May 10, 2026 at 10:33 PM PDT, Yonghong Song wrote:
>> Move stack slot index (spi) and frame number out of the flags field
>> in bpf_jmp_history_entry into dedicated bitfields. This simplifies
>> the encoding and makes room for new flags.
>>
>> Previously, spi and frame were packed into the lower 9 bits of the
>> 12-bit flags field (3 bits frame + 6 bits spi), with INSN_F_STACK_ACCESS
>> at BIT(9) and INSN_F_DST/SRC_REG_STACK at BIT(10)/BIT(11).
>> But this has no room for an INSN_F_* flag for stack arguments.
>>
>> To resolve this issue, bpf_jmp_history_entry field idx is narrowed to
>> 20 bits (sufficient for insn indices up to 1M), and the freed bits hold
>> spi (6 bits) and frame (3 bits) as dedicated struct fields. The flags
>> enum is simplified accordingly:
>>    INSN_F_STACK_ACCESS  -> BIT(0)
>>    INSN_F_DST_REG_STACK -> BIT(1)
>>    INSN_F_SRC_REG_STACK -> BIT(2)
>> which allows more room for additional INSN_F_* flags.
>>
>> bpf_push_jmp_history() now takes explicit spi and frame parameters
>> instead of encoding them into flags. The insn_stack_access_flags(),
>> insn_stack_access_spi(), and insn_stack_access_frameno() helpers are
>> removed.
>>
>> No functional change.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf_verifier.h | 34 ++++++++++++++--------------------
>>   kernel/bpf/backtrack.c       | 24 +++++++++---------------
>>   kernel/bpf/states.c          |  2 +-
>>   kernel/bpf/verifier.c        | 23 +++++++++++------------
>>   4 files changed, 35 insertions(+), 48 deletions(-)
>>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index f9020a4ea005..adf00585a627 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -435,31 +435,22 @@ struct bpf_func_state {
>>   
>>   #define MAX_CALL_FRAMES 8
>>   
>> -/* instruction history flags, used in bpf_jmp_history_entry.flags field */
>> +/* instruction history flags, used in bpf_jmp_history_entry.flags field.
>> + * Frame number and SPI are stored in dedicated fields of bpf_jmp_history_entry.
>> + */
>>   enum {
>> -	/* instruction references stack slot through PTR_TO_STACK register;
>> -	 * we also store stack's frame number in lower 3 bits (MAX_CALL_FRAMES is 8)
>> -	 * and accessed stack slot's index in next 6 bits (MAX_BPF_STACK is 512,
>> -	 * 8 bytes per slot, so slot index (spi) is [0, 63])
>> -	 */
>> -	INSN_F_FRAMENO_MASK = 0x7, /* 3 bits */
>> -
>> -	INSN_F_SPI_MASK = 0x3f, /* 6 bits */
>> -	INSN_F_SPI_SHIFT = 3, /* shifted 3 bits to the left */
>> +	INSN_F_STACK_ACCESS = BIT(0),
>>   
>> -	INSN_F_STACK_ACCESS = BIT(9),
>> -
>> -	INSN_F_DST_REG_STACK = BIT(10), /* dst_reg is PTR_TO_STACK */
>> -	INSN_F_SRC_REG_STACK = BIT(11), /* src_reg is PTR_TO_STACK */
>> -	/* total 12 bits are used now. */
>> +	INSN_F_DST_REG_STACK = BIT(1), /* dst_reg is PTR_TO_STACK */
>> +	INSN_F_SRC_REG_STACK = BIT(2), /* src_reg is PTR_TO_STACK */
>>   };
>>   
>> -static_assert(INSN_F_FRAMENO_MASK + 1 >= MAX_CALL_FRAMES);
>> -static_assert(INSN_F_SPI_MASK + 1 >= MAX_BPF_STACK / 8);
>> -
>>   struct bpf_jmp_history_entry {
>> -	u32 idx;
>>   	/* insn idx can't be bigger than 1 million */
>> +	u32 idx : 20;
>> +	u32 frame : 3;	/* stack access frame number */
>> +	u32 spi : 6;	/* stack slot index (0..63) */
>> +	u32 : 3;
>>   	u32 prev_idx : 20;
>>   	/* special INSN_F_xxx flags */
>>   	u32 flags : 12;
> If so, should 'flags' width be reduced as well?
> We don't need to burn 12 bits after this conversion ?
> 3 bits for flags will do?

Right, the next patch will add a flag for STACK_ARG. So
total 4 bits for flags. Will make the change.

