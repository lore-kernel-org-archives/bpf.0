Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751170;
	b=vHMSdJuSx9DeIwiF3NCu9GfmB5V4w0H+ZV2YsJMHfEtu3Wzd87xE6y1uYrfuAY4zxee0
	 SLj58ULwnjSi8dXeMZXoKvhz6HJp2Xnv2UkZoDeYLlJCAF7fgNzKE+Urx2AqZNANXiLeN
	 P0nJiyFHEZLjfBAPV/JCL1bkV0sENezmi74wGoPxdi77oNF4os8iS6BLMAxKpmkWQ1Obm
	 FnwrKwUs2L1jJPxkX/XDiA5rfXI7SuzknB52zkM0b6R2yZXdXODApaIsQF5zryt0Byz2R
	 35MAYStvnGhAtPQjt2xOCNF5VTT5tm9bH24wBHLlM4NFHSl9dv8YTIkKJaIb+IpqTnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751170;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EcAf1i7ybCsA89reAR6uRyuT0z0tenbdn7GumDJHokc=;
	b=QUNArbE6oC6SbB+KfIHnFh7331sTIaMW3Af2pKWxRvJzxUyz2Jl/QS38KcQ/lr41WEQ7
	 hfmSkSexcgVhJo0TMhBnne2xVR+z1m6cGaNmyqjTGDxfkGGT6zSdaGo7TlEf3NTUhF/wz
	 YJBExGdXpJYJ0nbNspsS2iwQxWXwJuwMbtEkrlE+Ywk/WtfgCoo0fmtntSDEfCqx9oSPG
	 J5J9g+DNChcT5Jtm+dghvJsxqtETFSkUz9N8GUSEv6eedxsEc5vkXb1yEImiTYjJB2fcY
	 HGokANsBLtBzsCTHQCD0F8p1nPISURiv/nto1KY5PSH4d4Wn0QeuAhvkXPA4CYbEpbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R0K+HpOr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7C6606A324
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 00:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R0K+HpOr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E3E1F00919;
	Wed,  4 Nov 2026 00:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793751169;
	bh=EcAf1i7ybCsA89reAR6uRyuT0z0tenbdn7GumDJHokc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=R0K+HpOrlrnC8PsB2QypujiwrysNm2zk1OwwnmRb9H5wiVnf58gfEg/zWscEtsiZp
	 XD09NX2HiWNCF5kFdLAK0dPSsrmH3O2M2o6ZNFROQ4Nz9EXM+1uXhfFO+k6CPIyoD+
	 RsyrkRDdief45WA34fPjtIDmajk9UUbJQgcn9DLTOiI2lokREbA7sEyQ0iNKqKBuZo
	 ka7WIFh5xlvjj/v5zz06nxpGC1wUePmn1ijmGwfN3jDbKycxRHj3IkMxDiXH1ZXSjj
	 a3bFOKEgfsho/VLxRMBcXxwH625+hUar0GzEL5auwzBHcp5v7eJUsXFwIB6m5SUHt5
	 qUK6NpxBqXSfg==
Message-ID: <sashiko-outbox-196291@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 32/37] bpf: Allow BPF_MAX_SUBPROGS targets of a
 read from a table of functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261103234104.208239-33-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
 <20261103234104.208239-33-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 00:12:49 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: __free(kfree) variable declared as NULL at top of check_func_p=
tr_read()
--

commit 6a9289c982c1e888c820e75173835d8cb92fc098
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Allow BPF_MAX_SUBPROGS targets of a read from a table of functions

This commit raises BPF_MAX_FUNC_PTR_TARGETS from 64 to BPF_MAX_SUBPROGS and
allocates the targets array dynamically in check_func_ptr_read() instead of
keeping it on the stack.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 93ca0126a3108..d503dc7cea1f8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -7114,17 +7114,20 @@ static int check_func_ptr_read(struct bpf_verifie=
r_env *env, struct bpf_reg_stat
>  	struct bpf_reg_state *regs =3D cur_regs(env);
>  	struct bpf_map *map =3D reg->map_ptr;
>  	struct bpf_verifier_state *branch;
> -	int subprog, targets[BPF_MAX_FUNC_PTR_TARGETS];
> +	u16 *targets __free(kfree) =3D NULL;
>  	struct bpf_func_ptr *ptrs;
>  	u32 i, cnt, n =3D 0;
>  	u64 o, lo, hi;
> -	int err;
> +	int err, subprog;
> =20
>  	ptrs =3D bpf_map_range_func_ptrs(env, map, min_off, max_off - min_off +=
 size, &cnt);
>  	if (!ptrs)
>  		return -ENOENT;
>  	if (cnt > BPF_MAX_FUNC_PTR_RANGE)
>  		goto overlap;
> +	targets =3D kmalloc_array(BPF_MAX_FUNC_PTR_TARGETS, sizeof(*targets), G=
FP_KERNEL_ACCOUNT);
> +	if (!targets)
> +		return -ENOMEM;

[Severity: Low]
This isn't a bug, but in check_func_ptr_read() in kernel/bpf/verifier.c,
targets is declared with __free(kfree) =3D NULL at the top of the function
and then assigned after a goto overlap check, while the rest of the
function continues to use goto overlap for error handling.

Per the cleanup.h conventions, should targets be defined and initialized
in a single statement at the point of allocation, and should mixing
__free() with goto-based error handling in the same function be avoided?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234104.2082=
39-1-alexei.starovoitov@gmail.com?part=3D32
