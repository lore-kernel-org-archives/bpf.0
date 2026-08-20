Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03468391E7B
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250330; cv=none; b=UMFIIArvpzop5Ycsu+QFrieNjJVvjL+gBuwtvmMq60hVPge01GlJSHLYLDk/0Ca6EdqSLmwCIgitVza29TibGAnIkTCDDXaSmHKKUnA9gFfAjZsE2e0NDb3Ci1Wei0aUzzy3eRMY0S/CM8UdahfXVpbRe+uQzUfn9aVKL1JKWO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250330; c=relaxed/simple;
	bh=ItkmceOa6PF0hafqNv/HENpBIQvUU6VsrrSFvZSXJ+U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XXvSK9sBwsf7M2gbcqVQAJRc/vGFKwxN1roIbxG3pKSJzTOPH70x1+q0dibIK7wFIGoMOzKciu+v8qOGu8sRNeyV8xy/Omq5Nmq7mV3lAXNOrU4ZtT7UQQgEcWLRjY9pshKeuxGPOtYGtxs8iI5kxInakcISZLlCe30GViFKfaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrL9g0bS; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrL9g0bS"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-382ef647e20so112139a91.1
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 11:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787250328; x=1787855128; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=necPZCDUxXpaJc9xcDXsM/DZHCx0YmzQTDb4jA22BZg=;
        b=mrL9g0bSmTLbn8GDe+hysClh3M/9TBIOHtyo4jfu/SRhaFYdDnQrjdVeBog/w3dly9
         vz4tnwX79A7Up0fjmn6FqLKgQxXSwSSYjiQ3xHUStx8j2iUHplwaP4KCGVs0nlnyDVkI
         BjWFoMa+UgBH6MnI9e8kxXaXtcRjUz1VQZlvAgciL3fVnML+2tXyVPRmsiHDTRr8Rckq
         rIF2h3QSzi17jowfy4E4wn7vlGFNYJdUUXpIUPC7TBDlEo+zymKg4xUXwF4RusdXNnW3
         opaWG9sAS8Tvh1YwSY1oBBCZsdtIO2rFml9kKvl5kXvku7yDJL/mG3syEtwKc9oDjzs3
         lKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787250328; x=1787855128;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=necPZCDUxXpaJc9xcDXsM/DZHCx0YmzQTDb4jA22BZg=;
        b=K1ZA3wZ+tQsuBKCLz+GL33wXEaJ4Gw9m3Ig+9WsDONc7lR+V4xhTglaaglCJULfSVG
         cFBMzVo5tSq3YcetmBp/8SUYt4ppuU66UsmduYn7gomhQ1HHvzjdloXosnXrg62GMIDW
         Z5pBXEUNafuUSmB/ri1pHTyda5tebhpG9luXKQeHGZi9QKRCl/HWVkaaXtOHG2X6HpzV
         LzpJBGXciCuzQIw3JZH8NvGrlSHErJp+Wdw3iuppO9hDlphZNWoHLgMrJ7kx3Vamhgwp
         gn6riTgZxPv2w5UjTQ2yBN9MjM8F3Cgeua2N6ylo+qIN/c6U65aZDAyEny6jD1EHwhli
         zcWw==
X-Forwarded-Encrypted: i=1; AHgh+RoLgJfXx7QZLFup69YZYSlSNxb96COTExcNO5yguVVHE1Frie1ExS/GBw8A5b9vVozazd8=@vger.kernel.org
X-Gm-Message-State: AFuF++nRViYhcJgoEWZ1d46a6wr/BUiBTlkMLaOC6EOrU48vANnW6PPr
	QZlGcZ8xm+8+VniBiG2JujYnYPWSBoPnLW7adhX9zCs5PoupEo5VGNHD
X-Gm-Gg: AR+sD13sanW6FgeBKJ0XAG3jIqk4mt9WOwmvZ63PvHDsLFS9LlipsxALMgfk8Bjlnk3
	xaZnikWU4gHE/cdlvc0Gh850VYKEkTfwx332b1xKCP4KdW3bB5wjUnAKXKaB32TuywZesUSjnMp
	xnBZS+hlx74k1VUv8/IHykivPc4NiWB5BpQnvp03EVyJ9gEl9cdZf1AuzB5lmgej1gdAr4L3l7t
	RddBP+PNzynR1aNjTdg7mdUKxFj/CytJ1Ujio2OKUkDAu7DaV1tTsBiZFdw95IBczw+Gzq0PBjG
	6IUn82qwKPqVp8F8+kuzRHqpeimzN1GMMrCpueMJGjh4oSpJQp+arS6FayoYKU77PcBW+4whpbF
	FPW4rylgk6KPKwbGa/3PDspEbjiJ07W2BM/wj/6UXL4vkLy5cCDCbsQaVcHGb6E9S9bEMzFkAeS
	Qb/NozSUY9EktMmh9B6OTmW2PcxXK7/2IF/rgwJC4liyGNZnqCb8kFdZMoXYmcxjnoLOQ7UZ2Cu
	PX2OzpSSLQ4+ljPN0MDUfq0qct/73iftqrG3tYgbhfkYw==
X-Received: by 2002:a17:90b:3912:b0:392:e5b1:d833 with SMTP id 98e67ed59e1d1-395c3738b35mr576958a91.13.1787250328314;
        Thu, 20 Aug 2026 11:25:28 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:89bc:48d2:9457:6223? ([2620:10d:c090:500::6:c5ba])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf15ff5dsm18788102eec.25.2026.08.20.11.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:25:27 -0700 (PDT)
Message-ID: <57a57ed806a954de19774b7c0833dc1742560cd2.camel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: fix REG INVARIANTS VIOLATION on
 speculative pointer arithmetic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: Hiker Cl <clhiker365@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko	 <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>,  Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai	 <ihor.solodrai@linux.dev>, Shuah
 Khan <shuah@kernel.org>, Paul Chaignon	 <paul.chaignon@gmail.com>, Amery
 Hung <ameryhung@gmail.com>, Shung-Hsi Yu	 <shung-hsi.yu@suse.com>, KaFai
 Wan <kafai.wan@linux.dev>, Daniel Wade	 <danjwade95@gmail.com>,
 linux-kernel@vger.kernel.org, 	linux-kselftest@vger.kernel.org
Date: Thu, 20 Aug 2026 11:25:25 -0700
In-Reply-To: <20260819125840.286434-1-jiayuan.chen@linux.dev>
References: <20260819125840.286434-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-19 at 20:58 +0800, Jiayuan Chen wrote:
> Take the following unprivileged program as an example:
>=20
> 	r0 =3D bpf_map_lookup_elem(...)	/* PTR_TO_MAP_VALUE, offset 0 */
> 	...
> 	14: r0 +=3D r1			/* r1 is a bounded scalar */
> 	15: r9 =3D r0
>=20
> Loading it triggers a verifier warning from reg_bounds_sanity_check():
>=20
> 	verifier bug: REG INVARIANTS VIOLATION (alu): const subreg tnum out
> 	of sync with range bounds r64=3D{.base=3D0x0, .size=3D0x0}
> 	r32=3D{.base=3D0x0, .size=3D0xffffffff} var_off=3D(0x0, 0x0)
>=20
> What happens:
>=20
> 1. Processing insn 14 (r0 +=3D r1) in adjust_ptr_min_max_vals(), the new
>    offset is computed into dst_reg's var_off and 32/64-bit ranges.
>=20
> 2. Because pointer registers do not track 32-bit subregister bounds,
>    __mark_reg32_unbounded() first sets r32 to the full range; r32 is
>    re-derived from the offset at the end of the function by
>    reg_bounds_sync().
>=20
> 3. On the unprivileged path, sanitize_ptr_alu() is called and, via
>    sanitize_speculative_path() -> push_stack(), snapshots the current
>    register state and schedules the next instruction (insn 15) to be
>    verified directly as a speculative path.
>=20
> 4. That snapshot is taken between step 2 and the final reg_bounds_sync():
>    at this point dst_reg's var_off still holds the (const) original
>    offset while r32 has just been blanked to the full range, i.e. the two
>    are out of sync. When the speculative path later verifies insn 15
>    (r9 =3D r0), the inconsistent state reaches reg_bounds_sanity_check() =
and
>    trips the warning.
>=20
> var_off and the 32-bit range must always be consistent. There are two
> ways to keep the snapshot consistent:
>=20
>   1. sync var_off and r32 before the snapshot so they match, or
>   2. leave r32 at its original (already consistent) value and blank it
>      only after the snapshot.
>=20
> The whole point of sanitize_ptr_alu() is to insert a harmless masking
> sequence that keeps the access in bounds under speculation, so the state
> it snapshots should faithfully represent that. Take approach 2: move
> __mark_reg32_unbounded() to after sanitize_ptr_alu(), so the speculative
> snapshot keeps the pointer's original, consistent r32. The non-speculativ=
e
> path is unchanged: r32 is still blanked before the offset is applied and
> re-derived by reg_bounds_sync().
>=20
> Fixes: 5f99f312bd3b ("bpf: add register bounds sanity checks and sanitiza=
tion")
> Reported-by: Hiker Cl <clhiker365@gmail.com>
> Closes: https://lore.kernel.org/bpf/CAGM=3DxGB1fJ9kT8XTitVo74B0WGqgjkoUHd=
LwzytwV0AyqeVApw@mail.gmail.com/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/verifier.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d17f14b35b79..d79038a8da10 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14558,9 +14558,6 @@ static int adjust_ptr_min_max_vals(struct bpf_ver=
ifier_env *env, struct bpf_insn
>  		return -EINVAL;
>  	}
> =20
> -	/* pointer types do not carry 32-bit bounds at the moment. */
> -	__mark_reg32_unbounded(dst_reg);
> -
>  	if (sanitize_needed(opcode)) {
>  		ret =3D sanitize_ptr_alu(env, insn, ptr_reg, off_reg, dst_reg,
>  				       &info, false);
> @@ -14568,6 +14565,14 @@ static int adjust_ptr_min_max_vals(struct bpf_ve=
rifier_env *env, struct bpf_insn
>  			return sanitize_err(env, insn, ret);
>  	}
> =20
> +	/* Pointer types do not carry 32-bit bounds at the moment. Blank r32
> +	 * only after sanitize_ptr_alu() may have snapshotted dst_reg into a
> +	 * speculative path: otherwise that snapshot freezes a const offset
> +	 * with an unbounded r32, which later trips reg_bounds_sanity_check().
> +	 * reg_bounds_sync() below re-derives r32 from the updated offset.
> +	 */

Nit: comment is a bit too verbose. "... otherwise reg_bounds_sanity_check()
     might hit some constraints violations" should have been enough.

> +	__mark_reg32_unbounded(dst_reg);
> +
>  	switch (opcode) {
>  	case BPF_ADD:
>  		/*
