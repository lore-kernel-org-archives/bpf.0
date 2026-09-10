Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B0739DBD6
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789034158; cv=none; b=ZY2SZenjevHaA1u0+qHJzotCdfc8D9gi0X+Diw01CchTMreXNqg50jjKFOwvz2dDZW9BwolRgzzXkB/Jk4H+na0xpTfF7DN1jDhZMuaNDk6uXXFAxR7rEJ+tpFhgM67Z0+UFVPBokYpjHd6Rjn8s9D9CuCcrRXAQkLlSLVB7jMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789034158; c=relaxed/simple;
	bh=mjSP08xdA2J33Rh3F2vMqK12uIOpRprEEpqM3lKry4o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nfkFH9/+ll+LfdCH4jFkY98IgIvmgFw+NdEbVFaptE6Pf+tD8/ZvcyNJ6WnNHWMcLu+S1IncEzFwTiH2hRNGwkL77bD5FYG2eaD7dA6HriBfCBaQO0PkaG3GSJyedMArvGanbmBoWiXKDZvT/saJxtvaXadsQw9fZRoIWCAYyiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZiZTPqg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZiZTPqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706F11F000FF;
	Thu, 10 Sep 2026 09:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789034156;
	bh=5hz54RcL5izzOAf2F420hwG1TB+gRmj7XXk2XoZ7yPY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VZiZTPqgCIlPusQky2CsCps4pf745D0j9gHZcEQYfk/DUC1+JcPPJBzRhRKEoFRCQ
	 eMCgamHT8zD4FWYMXyrtZQPLSGhOSwzxunjnAt2SXqxqC3Nd18rL9HjLwLWDm3lzXt
	 lx8tzZNOmstgVpBFH3a1w6u2I56cLAUgqe5DFp6E/AynZtH5YPw2zSYM6LJw3TB+NJ
	 OZuork4ZSbO/MiTJdaKLErnkEx7iiOQwaotQTcYoMojOdazlKt7BbV9aJyzuCe6Xai
	 NfjzbTo4wfIhdcAE0ypZjJKZekv279b8OaqAX/doC8Yxk8UDFwmyPFoPOVW09sx+DH
	 JdAYQ8yFibYtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 bpf-next] bpf, x86: Use global buffer for trampoline
 size generation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260910094353.1256316-1-jolsa@kernel.org>
References: <20260910094353.1256316-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:55:56 +0000
Message-Id: <20260910095556.706F11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Concurrent calls to arch_bpf_trampoline_size() write to the glob=
ally shared, unsynchronized `trampoline_size_image` buffer, resulting in a =
data race (Undefined Behavior) and cache-line contention.
--

commit 4c6aeb9264cf2877d767fb9a021802485dd9d3a7
Author: Jiri Olsa <jolsa@kernel.org>

bpf, x86: Use global buffer for trampoline size generation

This commit changes the BPF trampoline size calculation to use a single,
globally allocated executable memory buffer instead of allocating a tempora=
ry
one per invocation. This change aims to improve attachment time during trac=
ing
by eliminating the overhead of repeated memory allocations and frees.

Link: https://lore.kernel.org/bpf/20260907160538.922450-1-jolsa@kernel.org/

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index bba351944202c..9f9b1456dab0d 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
[ ... ]
> @@ -35,6 +36,21 @@ void __asan_store8(void *p);
> =20
>  static bool all_callee_regs_used[4] =3D {true, true, true, true};
> =20
> +static void *trampoline_size_image;
> +
> +static int __init init_trampoline_size_image(void)
> +{
> +	/*
> +	 * The generated trampoline contains calls and jumps with 32bit relative
> +	 * offsets, so the scratch image must be in the execmem range.
> +	 * On x86, module data and executable memory share the same address ran=
ge,
> +	 * so using EXECMEM_MODULE_DATA to get writable memory.
> +	 */
> +	trampoline_size_image =3D execmem_alloc(EXECMEM_MODULE_DATA, PAGE_SIZE);

[Severity: Medium]
Is this global allocation safe against concurrent access? Multiple threads
could compute trampoline sizes concurrently, for example when attaching BPF
programs to kernel functions that hash to different buckets in
trampoline_locks, or when concurrently updating different struct_ops maps.

> +	return trampoline_size_image ? 0 : -ENOMEM;
> +}
> +late_initcall(init_trampoline_size_image);
[ ... ]
> @@ -4000,24 +4016,14 @@ int arch_bpf_trampoline_size(const struct btf_fun=
c_model *m, u32 flags,
>  			     struct bpf_tramp_nodes *tnodes, void *func_addr)
>  {
>  	struct bpf_tramp_image im;
> -	void *image;
> -	int ret;
> =20
> -	/* Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
> -	 *
> -	 * We cannot use kvmalloc here, because we need image to be in
> -	 * module memory range.
> -	 * Since it must be writable use execmem_alloc(EXECMEM_MODULE_DATA)
> -	 * that returns writable memory in the module address space.
> -	 */
> -	image =3D execmem_alloc(EXECMEM_MODULE_DATA, PAGE_SIZE);
> -	if (!image)
> +	if (!trampoline_size_image)
>  		return -ENOMEM;
> =20
> -	ret =3D __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, im=
age,
> -					    m, flags, tnodes, func_addr);
> -	execmem_free(image);
> -	return ret;
> +	return __arch_prepare_bpf_trampoline(&im, trampoline_size_image,
> +					     trampoline_size_image + PAGE_SIZE,
> +					     trampoline_size_image, m, flags,
> +					     tnodes, func_addr);
>  }

[Severity: Medium]
When __arch_prepare_bpf_trampoline() writes to trampoline_size_image, could
this lead to a data race if called concurrently?

Since trampoline_size_image is globally shared and no lock protects it here,
writers in emit_code() might overwrite each other's data:

arch_bpf_trampoline_size()
  __arch_prepare_bpf_trampoline()
    emit_code()
      *(u32 *)ptr =3D bytes;

While the memory contents aren't executed, concurrent writes will cause
undefined behavior and cache-line ping-ponging, which could trigger KCSAN
warnings and crash systems with panic_on_warn enabled. Should this use a
per-CPU buffer or have explicit synchronization?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910094353.1256=
316-1-jolsa@kernel.org?part=3D1
