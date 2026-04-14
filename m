Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1401439023F
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176387; cv=none; b=EVWhRXaRohDkU5qq8+EeAq67hw5WOyVqBEyUHqS8e9MHTAajYJIU68fSEhjbtuJqn/vt7aYlbZ8Gt/qOChn5YzBRxkgDaARYvt/XYiSqrJZyT8HtE4GmJarZNZeWmi++YpKD6Bs98+7vslk+rnpdLKK98Y6ajr35ZAixtkq5sKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176387; c=relaxed/simple;
	bh=a6y7mGTafP6AvQul2uqHt0Il53p1IzT2DBolKdqquCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcuP5yY9p5TmIsMkbiQRbPe8GTbZBrCR/x3TVUvOz12EKE3UD6nXK+zz7mcHmvZCgyNXAq40FL+qLn78KtVKwD8qmq9FSDuhz3/xx5NCp5opG7p/sFX4eCiDrv1gdg82pTx4g5r+MpqbHRtGVVaFlW+Q+sLK2ybWoMFEncCyXSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LBbdmYkr; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LBbdmYkr"
Message-ID: <fef2c9a0-c609-49f4-a165-890aaecfbfd8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776176383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7e0SyEehxZxmmkmjj/3ZAV2njyRr1WilI5G3VFvKG0=;
	b=LBbdmYkrTjsqofVaUPal63mHxzKqKdCEl/AKubguX/bh2vqSRdZ7sLYQ8mh6G/oMRfE3is
	MyI6L9tnf7za34JMB7RAYnTP6onHoCIt56fE6jGAT45BP/izmUsd7uEiZD9vjzXuF+CoUF
	2P+0yZCGsmhIviHw4vgLo3CAQ0hdUVI=
Date: Tue, 14 Apr 2026 22:19:22 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Introduce global percpu data
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 yonghong.song@linux.dev, song@kernel.org, eddyz87@gmail.com, qmo@kernel.org,
 dxu@dxuuu.xyz, kernel-patches-bot@fb.com, martin.lau@kernel.org,
 clm@meta.com, ihor.solodrai@linux.dev
References: <20260414132421.63409-3-leon.hwang@linux.dev>
 <72dbcacc4cf2e76dc9de3c045e2fe1f3454d8880197b0db92c7d994ca82dcab0@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <72dbcacc4cf2e76dc9de3c045e2fe1f3454d8880197b0db92c7d994ca82dcab0@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/4/14 22:10, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 1757c5720503..8ec24d63a2c4 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -6362,7 +6362,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>>  			if (tnum_is_const(reg->var_off) &&
>>  			    bpf_map_is_rdonly(map) &&
>>  			    map->ops->map_direct_value_addr &&
>> -			    map->map_type != BPF_MAP_TYPE_INSN_ARRAY) {
>> +			    map->map_type != BPF_MAP_TYPE_INSN_ARRAY &&
>> +			    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY) {
> 
> This correctly prevents constant folding of percpu array values in
> check_mem_access().  However, should the same exclusion also be
> added to const_reg_xfer() in kernel/bpf/const_fold.c?
> 
> That function has a parallel constant folding path via
> bpf_map_direct_read() that only excludes BPF_MAP_TYPE_INSN_ARRAY:
> 
> kernel/bpf/const_fold.c:const_reg_xfer() {
>     ...
>     case BPF_LDX:
>         ...
>         if (!bpf_map_is_rdonly(map) ||
>             !map->ops->map_direct_value_addr ||
>             map->map_type == BPF_MAP_TYPE_INSN_ARRAY ||
>             off < 0 || off + size > map->value_size ||
>             bpf_map_direct_read(map, off, size, &val, is_ldsx)) {
>                 *dst = unknown;
>                 break;
>         }
>     ...
> }
> 
> Since percpu_array_map_ops now has map_direct_value_addr set,
> bpf_map_direct_read() would dereference the raw percpu base pointer
> directly, rather than the actual per-cpu address.  For a frozen
> read-only percpu array, the constant-folded value could differ from
> what the program reads at runtime after the BPF_MOV64_PERCPU_REG
> fixup converts the address to the correct per-cpu copy.
> 
> In the v3 series, bpf_map_direct_read() itself had a guard
> (map->map_type != BPF_MAP_TYPE_ARRAY), which protected all callers.
> The v4 moved this to caller-side checks but appears to have missed
> const_reg_xfer().
> 
> 
Correct.

Will add a guard in bpf_map_direct_read() in the next revision:

	if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
		return -EINVAL;

Thanks,
Leon

