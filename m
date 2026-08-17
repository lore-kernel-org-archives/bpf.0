Received: from mta0.migadu.com (out-218.mta0.migadu.com [91.218.175.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860FB23D28C
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 03:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786937420; cv=none; b=hLjYU3YoGZsCkMKwInZXSlcY8in4OduXxRXLYRdYBvFFmeavz2x5gCKEYieOztdd1cjAUG0yyHN4CofouanteEZa6CR1OXhR+vHSEvGNIc810tu1EIecOQh+Pi6314iBohKRlng1tu8mFs1WXxm4g+h0VcyCHBbI5K2dA0NY/qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786937420; c=relaxed/simple;
	bh=RhjojIJgrymAodRf2vve7RP15JmhT2jV2jY2PzVEHps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8HyesK0C3N2i6o0MDmseOoEm7gt1IMtb+e2+Bxq3ZgIZthCTCrUk6nx4e19u2QUWTUdjTwo3qf48HPmbd/XxB0L5CVa/whdIbKtgcoDabpg3Bkoc6ozQDjOXekN7pu/h1QmfNYC+qhf+AlJN42mHFz2lPwtIbhIay4rZjOXqH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P5uclJ34; arc=none smtp.client-ip=91.218.175.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P5uclJ34"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RhjojIJgrymAodRf2vve7RP15JmhT2jV2jY2PzVEHps=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786937416; v=1; x=1787542216;
 b=P5uclJ34UIOv0nQ1EZr7pYRYXVTi1o20SJ/v6hBRnE1i5hp66bErwOZjYkCbD+rB3qsMtsvc
 D9Pg5dopWqbH5F1bXWyUtwG6b5DSeyzXRWH2L3d9kyBOddtzUqqIbuzahAeYP/lmM74zb5Ll4r+
 Si3evxs8VtXj6yECvQs7AYSI=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:382:861c:7f36:14e1:cf55:e233:293b] (2600:382:861c:7f36:14e1:cf55:e233:293b)
	by smtp.migadu.com with ESMTPS id 14f70a3c1c84449a;
	Mon, 17 Aug 2026 03:30:16 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <f9562029-545b-42ee-b099-0cc766790b12@linux.dev>
Date: Sun, 16 Aug 2026 20:30:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 03/11] bpf: Wire up JIT support for 16-byte
 kfunc returns
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
 <20260813200225.1994805-1-yonghong.song@linux.dev>
 <20260814012040.1F4921F000E9@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260814012040.1F4921F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/13/26 6:20 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The verifier fails to initialize BPF_REG_2 for 16-byte kfunc returns, and completely fails to initialize both BPF_REG_0 and BPF_REG_2 if the kfunc returns a 16-byte struct.
> --
>
> --- Patch [3]: [PATCH bpf-next v5 03/11] bpf: Wire up JIT support for 16-byte kfunc returns ---
> commit fc27c41d2405fa63fb5ef7aa5e34586ccf98e0bd
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Wire up JIT support for 16-byte kfunc returns
>
> This commit adds JIT support for 16-byte kfunc returns by placing the
> second half of the return value in the BPF R2 register. It introduces
> architecture-specific capabilities and enables support for x86-64, arm64,
> and riscv64. The verifier is also updated to reject unsupported 16-byte
> returns.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 57d14480ded29..161d77791bc62 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -2854,6 +2854,18 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
>>   	err = btf_distill_func_proto(&env->log, kfunc.btf, kfunc.proto, kfunc.name, &func_model);
>>   	if (err)
>>   		return err;
>> +	if (func_model.ret_size > 8) {
>> +		if (kfunc.flags && (*kfunc.flags & KF_FASTCALL)) {
>> +			verbose(env, "kfunc %s with >8-byte return is not supported with KF_FASTCALL\n",
>> +				kfunc.name);
>> +			return -EOPNOTSUPP;
>> +		}
>> +		if (!bpf_jit_supports_kfunc_ret_reg_pair()) {
>> +			verbose(env, "kfunc %s with >8-byte return is not supported by JIT\n",
>> +				kfunc.name);
>> +			return -EOPNOTSUPP;
>> +		}
>> +	}
> [Severity: High]
> Does the verifier need updates in check_kfunc_call() to track the initialization
> of BPF_REG_2 for these larger returns?
>
> When evaluating the kfunc return type in check_kfunc_call(), the verifier
> currently appears to miss marking BPF_REG_2 as initialized for 16-byte scalar
> returns:
>
> kernel/bpf/verifier.c:check_kfunc_call() {
>      if (btf_type_is_scalar(t)) {
>          mark_reg_unknown(env, regs, BPF_REG_0);
>          ...
>      } else if (btf_type_is_ptr(t)) {
>          ...
>      } else if (btf_type_is_void(t)) {
>          ...
>      }
> }
>
> Furthermore, if the kfunc returns a 16-byte struct, the code falls through
> completely without initializing either BPF_REG_0 or BPF_REG_2.
>
> Since all CALLER_SAVED_REGS are cleared to NOT_INIT earlier during the call,
> won't this cause the verifier to incorrectly reject valid BPF programs that
> attempt to read these return values?
>
We should be okay here. The actual aggregate returning 16-byte struct is enabled
in later patch "bpf: Enable aggregate return types up to 16 bytes".

