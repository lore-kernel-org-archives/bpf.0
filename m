Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33EA3E314A
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786657961; cv=none; b=hp/Fkhk9f8FTU//3X82TZoGitUbm+Z5Y4zLOHiwSINfd4u/us34VAHEqBie4u3IlVw5T4R9RdobJWsUq9vmnuPDuztcO92YZVoI0bBosFR3x44IsYIGUPAnDNK6kAWMJ6pKl5TcLD7qfgEraf1Pqz3UyPH0fPUPsv5xV4yis0QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786657961; c=relaxed/simple;
	bh=T0JlLEDaVIlw/VTpVYKVNJSNkxWXNOPlnavHqxjfdd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqLIqRCUeX5zhqWvWR2agMVQ11dqIcgcnv1sGBVbKWLBSDDOfnqi2yqex3C4QgiwWSsxQZIjYyLAX6O3eXjwOWtF3D73PxcBouYAUblMmkTm8l3j59EwN4ZYNXl/eRs2a3TiPhhHeqqrksvPfBELCFcjfy1uutB2AujjBbfxQB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=D338bIgL; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="D338bIgL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=EpcdGKmaztv1bgMpQcXWkQ/1Fnhlpz4DlwGV0GOG4SI=; b=D338bIgLJOcaEY6DsAlPJr3xPk
	HZxHcyqUIjsLhcBv1FVp+8N7duJRfsYvRqzP0fByofvZaUXq7KGKp5oEysbMmJqI43uRyHEWURmV9
	2O2vf00XsLiytpQ1piG2qKBH5z3JsKKek9hx/M7ZWh+J9s28p+WaHc02tzvf1H+KJQGruFaAtoYeV
	lL/n6A3m8azpMD0BHw0HNl7gLqJklxMPw8cUBtzuhxPvoxjecwGR/QBdRIqrVtZ7/PW49zAhqIty/
	F6dcRBr5yOtSq8UQbmpLfDPRBbDiLA8mBDvZ7EK9fLsxx8nDadQX/D1f8DPE5bmBbROCzGS/dsG1l
	7gCEbJyA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wudLk-000Lik-2E;
	Thu, 13 Aug 2026 23:52:32 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wudLj-000Gxn-2Q;
	Thu, 13 Aug 2026 23:52:32 +0200
Message-ID: <4bd515ff-ef68-43e0-a985-dc0429f77435@iogearbox.net>
Date: Thu, 13 Aug 2026 23:52:31 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/4] bpf: Merge pointer types also when both are
 PTR_TO_MEM
To: bot+bpf-ci@kernel.org, eddyz87@gmail.com
Cc: memxor@gmail.com, bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260813204032.644949-2-daniel@iogearbox.net>
 <e69c09e324eddec182636a166bb50d7cdbb7828220155efdbc996fb0eeccdade@mail.kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <e69c09e324eddec182636a166bb50d7cdbb7828220155efdbc996fb0eeccdade@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28091/Thu Aug 13 08:25:54 2026)

On 8/13/26 11:44 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 1f2ed6164305e..5daca4ef27278 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -17096,6 +17096,17 @@ static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type typ
>>   		 * save type to validate intersecting paths
>>   		 */
>>   		*prev_type = type;
>> +	} else if (*prev_type != type && allow_trust_mismatch &&
>> +		   is_ptr_to_mem_or_btf_id(type) &&
>> +		   is_ptr_to_mem_or_btf_id(*prev_type)) {
> 
> Does this condition still leave a gap when the other side is one of
> the remaining reg_type_mismatch_ok() base types?
> 
> Looking at reg_type_mismatch_ok() in verifier.c, it returns false only for
> PTR_TO_CTX, PTR_TO_SOCKET, PTR_TO_SOCK_COMMON, PTR_TO_TCP_SOCK, PTR_TO_XDP_SOCK,
> PTR_TO_BTF_ID and PTR_TO_ARENA. Everything else (PTR_TO_MAP_VALUE, PTR_TO_STACK,
> PTR_TO_PACKET, PTR_TO_BUF, PTR_TO_TP_BUFFER, PTR_TO_MAP_KEY, PTR_TO_FLOW_KEYS)
> is "mismatch ok".
> 
> For such a type paired with PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED at the
> same BPF_LDX:
> 
>    is_ptr_to_mem_or_btf_id(*prev_type) would be false, so this new branch
>    would be skipped
> 
>    reg_type_mismatch() would be false (both sides are mismatch_ok), so
>    nothing is recorded either
> 
>    *prev_type keeps the type of whichever path was verified first
> 
> If that first path was PTR_TO_MAP_VALUE, bpf_convert_ctx_accesses() in
> kernel/bpf/fixups.c falls into the default case - no BPF_PROBE_MEM rewrite
> and no exception table entry - and the untrusted path then takes a plain
> faulting load.
> 
> The commit message says this is being fixed, but doesn't this exact panic
> stay reachable? The existing selftest ldx_is_ok_bad_addr() in
> tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c already loads from
> bpf_rdonly_cast(0, 0) and relies on the PROBE_MEM rewrite; the map-value
> half is just a post-NULL-check bpf_map_lookup_elem() result.
> 
> Should the merge also fire when only one side is PTR_TO_MEM or PTR_TO_BTF_ID
> and that side may_fault_on_deref(), or should such a mix be rejected
> outright?

I'll check this one tomorrow in more detail. Fwiw, the other bot+bpf-ci
reviews are non-issues.

>> +		/*
>> +		 * Have to support a use case when one path through the
>> +		 * program yields a TRUSTED pointer while another is
>> +		 * UNTRUSTED. Merge them into a type which keeps the
>> +		 * BPF_PROBE_MEM/BPF_PROBE_MEMSX rewrite when either
>> +		 * side needs it.
>> +		 */
>> +		*prev_type = merge_ptr_types(type, *prev_type);
>>   	} else if (reg_type_mismatch(type, *prev_type)) {
> 
> [ ... ]
