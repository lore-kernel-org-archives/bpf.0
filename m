Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8529843E4B9
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517637; cv=none; b=p5s34EHV0K9gIRe2I4DkbMyUeMoW3k8Km/PxMW3I8t+Nz7YarCCKX50gr5V4P/Vlh2gOzqhGykEhFXALdOeQ0kl/1f9PjXFaXNLX8ArmXFqMCKVw91lNgjDZZHdH607Q+D9Gl14OL6LSWX3Tgu42YEXTK5aogZCWYHBqBZBxppU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517637; c=relaxed/simple;
	bh=2pC0IeKaFlErtKbBaf57pAfOsPphHNrSGTbOEY0Izcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxIdrbtpAGe4JNUKpSHcwT+cXt7cvq4Dmjn0iDMFS6M/4lmFYs07KOIFw5EDkszoX84ufCWAPkql148snWGD5TzKupri4kYANGhkLFS4Ge2fIdfAkulEj1LmNIAZG9xnETjcGbJIajV9olgP4HeiyR2DbmmqqaiByaCF4joR6Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JRbsaRDN; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JRbsaRDN"
Message-ID: <1d94f7ea-03e1-4739-b2e9-08e8903a1ac6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778517633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9naalMX3xIOQxcFrbJKf/SxMlpzUS1bJ586DtaHLINI=;
	b=JRbsaRDN7Ib/2NK9iNVv5A6ImRGhKl5J+R3t5SGYG7KaAphnWsz+2LI3OiDdLcwmoBABu7
	JeF5qKiJInqbmLsC4kh4eYLZgrDPBg+tHJm5tP+uYjGO3sK4mpeZKx+2K8s7343ktcFPNo
	wYb+b9b91cK2PwhoQB2vLB637zit0eo=
Date: Mon, 11 May 2026 09:40:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 09/24] bpf: Extend liveness analysis to track
 stack argument slots
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260511053301.1878610-1-yonghong.song@linux.dev>
 <20260511053348.1885300-1-yonghong.song@linux.dev>
 <DIFZQSR5B66I.26PF8V3P74KSK@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DIFZQSR5B66I.26PF8V3P74KSK@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/11/26 6:34 PM, Alexei Starovoitov wrote:
> On Sun May 10, 2026 at 10:33 PM PDT, Yonghong Song wrote:
>> @@ -1071,8 +1105,24 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   	struct arg_track *dst = &at_out[insn->dst_reg];
>>   	struct arg_track *src = &at_out[insn->src_reg];
>>   	struct arg_track none = { .frame = ARG_NONE };
>> -	int r;
>> -
>> +	int r, slot;
>> +
>> +	/* Handle stack arg stores and loads. */
>> +	if (is_stack_arg_st(insn) || is_stack_arg_stx(insn)) {
>> +		slot = stack_arg_off_to_slot(insn->off);
>> +		if (slot >= 0) {
>> +			if (is_stack_arg_stx(insn))
>> +				at_out[MAX_BPF_REG + slot] = at_out[insn->src_reg];
>> +			else
>> +				at_out[MAX_BPF_REG + slot] = none;
>> +		}
>> +		return;
>> +	}
>> +	if (is_stack_arg_ldx(insn)) {
>> +		slot = stack_arg_off_to_slot(insn->off);
>> +		at_out[insn->dst_reg] = (slot >= 0) ? at_stack_arg_entry[slot] : none;
>> +		return;
>> +	}
>>   	if (class == BPF_ALU64 && BPF_SRC(insn->code) == BPF_K) {
> claude doesn't have a taste.
> Please use 'else if' like the rest of the function and remove both 'return'.

Ack.

>
>>   		if (code == BPF_MOV) {
>>   			*dst = none;
>> @@ -1297,6 +1347,14 @@ static int record_load_store_access(struct bpf_verifier_env *env,
>>   	struct arg_track resolved, *ptr;
>>   	int oi;
>>   
>> +	/*
>> +	 * Stack arg insns use dst_reg=BPF_REG_PARAMS(11), but at[11] tracks
>> +	 * the value stored in stack arg slot 0, not a memory base pointer.
>> +	 * Skip to avoid misinterpreting that value as an FP-derived pointer.
> The comment is confusing. 'not a memory base pointer'? what does it mean?

at[11] intends to track stack arg slot 0, but at '11' also corresponds to
r11. I will rewrite to make it clear.

>
>> +	 */
>> +	if (is_stack_arg_stx(insn) || is_stack_arg_st(insn) || is_stack_arg_ldx(insn))
>> +		return 0;
>> +
>> -/* Return true if any of R1-R5 is derived from a frame pointer. */
>> +/* Return true if any of R1-R5 or stack args is derived from a frame pointer. */
>>   static bool has_fp_args(struct arg_track *args)
>>   {
>>   	for (int r = BPF_REG_1; r <= BPF_REG_5; r++)
>>   		if (args[r].frame != ARG_NONE)
> let's make it consisten with below and use arg_is_fp here?

Sure.

>
>>   			return true;
>> +	for (int r = 0; r < MAX_STACK_ARG_SLOTS; r++)
>> +		if (arg_is_fp(&args[MAX_BPF_REG + r]))
>> +			return true;
>>   	return false;
>>   }

