Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0382DEA6B
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438970; cv=none; b=nM+7tZeeqKYWmvw5eFmt9VMnC1rOGvvC8A5TPjKWRkdYm0+KxC6HbnuR6mpSzxSCFQ17he45XPrai2Dg0L5zyQADdf7ltA0SKHTQvddch44T3klNAntO6lL+jSoTlH21dkYVo8Ec4V1G6UXHcJYWBmPVSs0kgbKHbjQm5VlEx/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438970; c=relaxed/simple;
	bh=AbW8PH9YvNl9RGkfU1BF8dzJeOiLBLTfAjpALVz9OBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qUD8MJzuODmtiLfF7g0pKm4VLciEntDUmsuqDe3VknsWxBpl+yfWkk7/OFOP0bZOfmkwE9uGCadiPukSV0Iz6pT49kgHePes1g+DXuDVsK0w+kotxCNYM9XJNxw/4cP/XRciPP+OaV9QCFDpzcKHedTJFIx56WYScNywRUXSFz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=fcYkReGN; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="fcYkReGN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=hq6JmyxODnLk22Q9LyrnAZTqshLcZrUkaLv1rU4xlCg=; b=fcYkReGN5GFBsu6YlAbhQ5X4ov
	7efOtzdcSJNtZENVxAVqWN2ZOrJShK7iAwYZevmZfMpMp8+mqs2Y5JpCdBysBvOkp0OZmQrCO0/ce
	Ol6/haLQujauxeysul0YH6RCVDiHFUZK7WyeXcwCieagHF8TAOngpHMHj80HfMPs8dDkzXxwJnqBe
	fXr8N1/mHjms2udvBUGbl6BrqJLon5Y6S6Xx5KAoLpd0DctfLZrPjTY5+NZmR+LRkB1p/mpkceWlc
	xh0mvAIpVThKh19xAMbSlEYKjlrxdE9aL0FABFTQ9cAJMAkqFzVR6NxJ7ABi1fTNs86hofysGNkgB
	ml+YJKFg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wtiNd-00089q-2e;
	Tue, 11 Aug 2026 11:02:41 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wtiNc-000Abf-2S;
	Tue, 11 Aug 2026 11:02:41 +0200
Message-ID: <452ca00a-1937-42fa-921b-b1c642bf5f6b@iogearbox.net>
Date: Tue, 11 Aug 2026 11:02:40 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Derive the atomic load register in
 one place
To: bot+bpf-ci@kernel.org, memxor@gmail.com
Cc: eddyz87@gmail.com, puranjay@kernel.org, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, martin.lau@kernel.org,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
References: <20260810221811.481040-1-daniel@iogearbox.net>
 <7da705ca01f2e33034afa325b543583f7458d8061e64c18584eeb787fe83d15d@mail.kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <7da705ca01f2e33034afa325b543583f7458d8061e64c18584eeb787fe83d15d@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28089/Tue Aug 11 08:25:05 2026)

On 8/11/26 1:38 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index 4edba8182db1b..15d83684c6e94 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -414,6 +414,30 @@ static inline bool bpf_atomic_is_load_acq(const struct bpf_insn *insn)
>>   	       insn->imm == BPF_LOAD_ACQ;
>>   }
>>
>> +/*
>> + * Given an instruction @insn, return the number of the BPF register that a
>> + * BPF_ATOMIC reads the value at its memory operand into, or -1 if there is
>> + * no such register. That is the register a BPF_PROBE_ATOMIC has to clear when
>> + * the access faults. Like bpf_atomic_is_load_acq(), @insn is not assumed to
>> + * be a BPF_ATOMIC here.
>> + */
>> +static inline int bpf_atomic_load_reg(const struct bpf_insn *insn)
>> +{
>> +	if (BPF_CLASS(insn->code) != BPF_STX ||
>> +	    (BPF_MODE(insn->code) != BPF_ATOMIC &&
>> +	     BPF_MODE(insn->code) != BPF_PROBE_ATOMIC))
>> +		return -1;
>> +
>> +	switch (insn->imm) {
>> +	case BPF_LOAD_ACQ:
>> +		return insn->dst_reg;
>> +	case BPF_CMPXCHG:
>> +		return BPF_REG_0;
>> +	default:
>> +		return (insn->imm & BPF_FETCH) ? insn->src_reg : -1;
>> +	}
>> +}
>> +
>>   /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
>>
>>   #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index 661e2d13a6042..c4bd70befbb5c 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
>> @@ -49,16 +49,7 @@ static int insn_def_regno(const struct bpf_insn *insn)
>>   	case BPF_ST:
>>   		return -1;
>>   	case BPF_STX:
>> -		if (BPF_MODE(insn->code) == BPF_ATOMIC ||
>> -		    BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) {
>> -			if (insn->imm == BPF_CMPXCHG)
>> -				return BPF_REG_0;
>> -			else if (insn->imm == BPF_LOAD_ACQ)
>> -				return insn->dst_reg;
>> -			else if (insn->imm & BPF_FETCH)
>> -				return insn->src_reg;
>> -		}
>> -		return -1;
>> +		return bpf_atomic_load_reg(insn);
>>   	default:
>>   		return insn->dst_reg;
>>   	}
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index add3affc57035..73a2e8bb1782a 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -6485,21 +6485,16 @@ static int check_atomic_rmw(struct bpf_verifier_env *env,
>>   		return -EACCES;
>>   	}
>>
>> -	if (insn->imm & BPF_FETCH) {
>> -		if (insn->imm == BPF_CMPXCHG)
>> -			load_reg = BPF_REG_0;
>> -		else
>> -			load_reg = insn->src_reg;
>> -
>> +	/*
>> +	 * A negative load_reg means that this instruction accesses a memory
>> +	 * location but doesn't actually load it into a register.
>> +	 */
>> +	load_reg = bpf_atomic_load_reg(insn);
>> +	if (load_reg >= 0) {
>>   		/* check and record load of old value */
>>   		err = check_reg_arg(env, load_reg, DST_OP);
>>   		if (err)
>>   			return err;
>> -	} else {
>> -		/* This instruction accesses a memory location but doesn't
>> -		 * actually load it into a register.
>> -		 */
>> -		load_reg = -1;
>>   	}
>>
>>   	dst_reg = cur_regs(env) + insn->dst_reg;
> 
> This isn't a bug, but since the point of bpf_atomic_load_reg() is to keep
> this derivation in one place, would it be worth converting the remaining
> instances in const_fold.c and liveness.c as well?
> 
> Both files have the same three-way BPF_CMPXCHG/BPF_LOAD_ACQ/BPF_FETCH
> mapping behind a BPF_STX + BPF_MODE == BPF_ATOMIC guard. In const_fold.c
> around line 204-209 it marks the register as unknown, and in liveness.c
> around line 1212-1217 it marks the register as none. Each could read as
> 'int r = bpf_atomic_load_reg(insn); if (r >= 0) <clear r>;' instead of
> repeating the switch.
Ack, I have it locally in a v3 of the series.
