Received: from mta0.migadu.com (out-118.mta0.migadu.com [91.218.175.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5B13CE4A3
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004519; cv=none; b=qsklX2BMm+5WMnvFaYjOeiVtTh6wVgsYVzdybC1w/73pdKYVf+S+MYMOObCLjH3TaUdj1r8PWa5eEyzdCWBmGQQvwv8BAr2hcqs+jtK3LvD4rSCefEUtKCn3A4ULJRsw5H5an+FRf1TqhxKT336Y1BsaaxJXdr8KZEynmWKeDvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004519; c=relaxed/simple;
	bh=5WsujCch+x+MVyvQWwannOvSu+sLlIUaLaQNYvQE3r4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWykSdAqgIZaapeU/Ro5Iw69ISqItswFgdG8sfhHya+PG2zTs0FaImHaMWKuvTX8bRHOj7DALjY5LLuAJ/yk/sO937hoBDugQBisUfQROPVSoi3cir/JYdEaXEydsSiVL+4jh+6k435JM6gZ5jJqAVg0wpCLstAs2W+0i6nLlwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YpzJ2wM6; arc=none smtp.client-ip=91.218.175.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YpzJ2wM6"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5WsujCch+x+MVyvQWwannOvSu+sLlIUaLaQNYvQE3r4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790004515; v=1; x=1790609315;
 b=YpzJ2wM6vyGMEEPEdBp7o5gtU7EUxG73+bDB9G7QIREfvN5hOYwciknUFN0XS92YdIkLaupA
 f798dTLHbzGwigUdpAUdLMwUXf/j+8a3M3JC3INmvj/EvFL033dNmU0TDBjJR8NUFjPPUMU+cXu
 Vlyiuhj4FSB0nsDhruC4+fAo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e422fe8beb9831a4;
	Mon, 21 Sep 2026 15:28:35 +0000
X-Mizu-Trace-ID: e422fe8beb9831a4
X-Migadu-Flow: FLOW_OUT
Message-ID: <28cfcb20-8be7-42a5-8096-7996447724f7@linux.dev>
Date: Mon, 21 Sep 2026 08:28:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 01/20] bpf: Accept the compiler's exception
 cleanup table at program load
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260920054231.865520-1-yonghong.song@linux.dev>
 <07aee6cc56444ca1d1bf88284b8df9d9fdaa94ddd7f00c50eef6b7a20479632e@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <07aee6cc56444ca1d1bf88284b8df9d9fdaa94ddd7f00c50eef6b7a20479632e@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/19/26 11:32 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 6330b7d745c5..a69cc0427575 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1669,6 +1669,9 @@ union bpf_attr {
>>   		 * verification.
>>   		 */
>>   		__s32		keyring_id;
>> +		__aligned_u64	cleanup_info;	/* exception cleanup table */
>> +		__u32		cleanup_info_rec_size; /* userspace bpf_cleanup_info size */
>> +		__u32		cleanup_info_cnt; /* number of bpf_cleanup_info records */
>>   	};
>>
>>   	struct { /* anonymous struct used by BPF_OBJ_* commands */
>> @@ -7599,6 +7602,12 @@ struct bpf_line_info {
>>   	__u32	line_col;
>>   };
>>
>> +struct bpf_cleanup_info {
>> +	__u32	begin_off;
>> +	__u32	end_off;
>> +	__u32	landing_pad_off;
>> +};
>> +
> This isn't a bug, but would it be worth a short comment on struct
> bpf_cleanup_info spelling out that the offsets are instruction indices,
> that the range is [begin_off, end_off), and that records must arrive
> sorted and non-overlapping with the landing pad outside every range?

The above bpf_attr already has related information.

>
> A producer other than LLVM has to read check_cleanup_info() to discover
> the rules, and insn_off in struct bpf_core_relo in the same header is
> documented as a byte offset (line 7750: "instruction offset (in
> bytes)"), so the unit is genuinely ambiguous at a glance.
>
> [ ... ]
>
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index 6330b7d745c5..a69cc0427575 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -7599,6 +7602,12 @@ struct bpf_line_info {
>>   	__u32	line_col;
>>   };
>>
>> +struct bpf_cleanup_info {
>> +	__u32	begin_off;
>> +	__u32	end_off;
>> +	__u32	landing_pad_off;
>> +};
>> +
> Same here.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35492765538

