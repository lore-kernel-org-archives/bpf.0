Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DECB2BE053
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 06:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785912743; cv=none; b=tAzQjrAOyxLo0v3MamBLLx2gXr0BVGybz6qCBpTPuwl1TaQNj6h+AclwqIYKf82u1QvX1NZY0CUvAjk4FZdJPWtMB7zAyI4ATeSKICHeJfR4NzsXx52PMOIKjISol5VUbYird1YW+swsfrCbdiaJn6UMgEKsqbkkgh7J4Puhvkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785912743; c=relaxed/simple;
	bh=+W0SwqtLeEwLjxu5QUJlMD9V9SdFzL0P4fd7aAdrcrg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B3ut6DW56gAC/S3ge/NzwRUAUeElHTkTB3/JJlxubx/NdTluvWQ24khiGK9nMIEdjoOQqJS2rw8+3TdrncIsBe0CKV/MHtevXaWs9P2OLFuhpAJ5grCwvxdxj32pbN3RegPYcOWxvDkCFUyqzXOMozZAv+9Pp36L7o2sSqhWI48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTJPcQom; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTJPcQom"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso763256a91.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 23:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785912742; x=1786517542; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KrnusHwGmR4P9qX3hZR0Yep3rBRjRgiWJzdpTBWbJ3g=;
        b=GTJPcQomoB8FrkOnjHfN1wyQCqYTdZJLeNRnvGkkm3kF1ocDg0kdXGGRan4SNm6OsW
         svww+r3noD2mMf3uzhZCQNAAhjqkkAaB5nP3vArhhl0yEGtOcRfFmfFzooch3qfzLSjj
         8mP3zL7g8SFoIdeE59FVApr68Mcjm5FmgvCPQp1vw1vrQgFwqZjwFnKGW1xVHBze2BL8
         l5SQGVPMQ9wgLPLzq4LbsD0OVq40bPCJlSNMu33jA98E13SoSKFznPlBK3fivvjUJUth
         DwzgVQbml79SkW8z22qc5B4MplJlyseXYbuq2/YNgYVx7jEg3pvUWwQ0jcs1TaQUcytj
         Cw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785912742; x=1786517542;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KrnusHwGmR4P9qX3hZR0Yep3rBRjRgiWJzdpTBWbJ3g=;
        b=UE7+w6m2sQKI3fOj2v5hjYygBq7xBy8S1OCqRUDxe5v+cTcZ9hrq6WITl2UlnqDdmb
         oizoRf9WZHuDW0Fcg39CMEzC0hgxa5oYmVLFi1q+H9F4ZLxl2oS5ZJ1d0QnQcgHXbcxb
         n/al2EYIbw7ldsBZc4J7sDstN/Eyq8+eE/IqkcPRtMAsg+by9tW4u4bJWlOu/77z6uC5
         Oj7eRRSiJA6GIY3A1OmiLjsPI+zBwfjIYpL1fww25epXjsHWkhKoYh8q3/PQ0OCtOPK7
         y5zuZTO9W4xd3iZeD5C6KLSFlMo9MioHeM76HzGkmDvdN3RRLDaztaqw+QjN4CLNqqRY
         sbVg==
X-Forwarded-Encrypted: i=1; AHgh+RoOyRUCPHMkCn+RZD01G273s1uBJyPL5Xh7a4r2XUB4SCR26kMG5UsBY+TbDL8RN94mx80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1f4LeMjV0atrtRBwfK7NcEhS5FnOxu1oq50U4LtTrGDSf/qzU
	LfggLNYURbE/q3iETuvNoTMbpV5iiCgTVye52ta+yPneQ/CVJjx6d3Vr
X-Gm-Gg: AR+sD112OFa1nKJb54lPaHp3BhWzJsax1HRUfJu8NNHuRDyNpCgMkurGf87VkrfLSa6
	vNCU8/nZw9UHOavz9dLvgjctPpdikG6riB9tYDMaRpZJXaI3MzN0lzkIoHwc8lGhapFHnBuCUpU
	+udRD4iL3p2vpL5rNVl/caubPGHJ8QB80/ON2XwdRUDlfQZ7czjazeUOONY/N9TkSgZO48HhHDN
	V2wlhYg6SXyGi0IP3E0bNcftscWeC0RhDL8kUdg0cSlP+hy0QOtdDzyOadP4ykoi5Iw99rU7DcX
	Pa7AN+6Fp0DEDh7yaVwpKrHRo60OeCBUcNnhgYk4VqKhfsvagFyRXGV/JICZR0AlPVCiLeuHcU+
	txoP4XKjaS9T8sWhB5U1HyUxErwausrrzEfPexIJoz5272ZEfJuoITUYb5x92oZKDFSRRgJz4uf
	FgTn6MrHvEPq+UJV721gpbvDPQwG13e/5My7vwfxUSFmTp89JGh5NVL3W4/z4TPTEZYXE56Jbj7
	pCcGFzQWRf62TuV
X-Received: by 2002:a17:90b:1dc4:b0:38e:49c0:75a7 with SMTP id 98e67ed59e1d1-3903c537808mr4556575a91.8.1785912741596;
        Tue, 04 Aug 2026 23:52:21 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903917ae54sm2151196a91.8.2026.08.04.23.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 23:52:21 -0700 (PDT)
Message-ID: <fd14689efe162687c9a6dda514815d381b659dad.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 7/9] selftests/bpf: Add struct_ops __arena
 and __arena_nullable argument tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis	 <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 04 Aug 2026 23:52:18 -0700
In-Reply-To: <20260803125115.2264733-8-memxor@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
	 <20260803125115.2264733-8-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-03 at 14:51 +0200, Kumar Kartikeya Dwivedi wrote:
> From: Tejun Heo <tj@kernel.org>
>=20
> Add test_arena and test_arena_nullable members to bpf_testmod_ops3 with
> arena-tagged stub arguments and kfuncs that forward a caller-provided
> pointer to them. The kfuncs take arena-tagged arguments, so each round
> trip exercises both conversion directions end to end: the kfunc receives
> a kernel arena address and the trampoline converts it back to an arena
> pointer for the callback.
>=20
> The non-nullable callback dereferences its argument with no NULL branch
> and captures the raw ctx value, which the trigger program compares
> against the arena offset of the passed object, pinning the exact
> (u32)(kaddr - kern_vm_start) conversion. The nullable callback verifies
> that only a true kernel NULL arrives as NULL. Failure coverage: a
> program with no arena is rejected when it loads. The tests run on x86-64
> and skip elsewhere, as the programs fail verification where the JIT
> lacks arena argument support.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...

> diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/test=
ing/selftests/bpf/progs/arena_kfunc.c
> index e7250c5197ab..15d48151797d 100644
> --- a/tools/testing/selftests/bpf/progs/arena_kfunc.c
> +++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
> @@ -235,16 +235,26 @@ int arena_arg_bad_reg(void *ctx)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && \
> +	defined(__BPF_FEATURE_STACK_ARGUMENT)
> =C2=A0SEC("syscall")
> =C2=A0__arch_x86_64
> =C2=A0__failure __msg("arena pointer cannot be a stack argument")
> =C2=A0int arena_arg_stack(void *ctx)
> =C2=A0{
> -#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> =C2=A0	bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> =C2=A0	bpf_kfunc_arena_stack_arg_test(1, 2, 3, 4, 5, (u64 *)1);
> -#endif
> =C2=A0	return 0;
> =C2=A0}
> +#else
> +SEC("syscall")
> +__arch_x86_64
> +__description("arena_arg_stack: not supported, dummy test")
> +__success
> +int arena_arg_stack(void *ctx)
> +{
> +	return 0;
> +}
> +#endif

Nit: should this be a part of the first selftests patch?

...
