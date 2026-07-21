Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA29B415F14
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 19:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784661554; cv=none; b=HccvlP15sUEMPVg5w7UN/2dp3uKCJf2753zIqdjjh1hWjkS/s9ENPPhPbZ68vOZ6wTvX9cXQky1RXzXhtHTDzu+FIqldf2FO+dr3xMUoXnW+L64lFoqkmQIq5VKrk9uqsTjRanYx8iePc4eqbazPsoUiNLmaE7jnnUhXLp+GnBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784661554; c=relaxed/simple;
	bh=jCDpKVpGl99L51cNz1fX1yunmLqv1EhekdNED6LXgSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=McePNpvLa/J45S/JOtne4D/vI3tkwyt5oHC0qbRPRL3tmftRB399u6X7i59fbnvtMJFwavIEbY9r2A74zCraY+8RwI12RuAjyeAkt7Ju0cnM1S5vtW1/IKeMxSRhzhR9lbSN84Pc6ZfUqUuBAbNCISMMRzFyxFL4UUlFx+bMrV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVrXd/5E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVrXd/5E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508C31F000E9;
	Tue, 21 Jul 2026 19:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784661552;
	bh=nqgod7uO7L3e/u7DWlFgAzka0lwgb3vwPCk8fVW/jEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=EVrXd/5Ela7gg5U3U+GG3iwzd7h4IS5r6CJgixsXuEKs9Gf2HmLUM4eugPpiR2U4c
	 a3X1slgVA2GFcAf1e3FGl6ToXRCwna5fVZnktiIOmbqM5LnOnI5//UCBhZCoPf8tjv
	 3BPVDAtPL3gZ58dk3de65aROjoV2KRjXowmrmGErECumzGJMJ4nUukR5lvaAKHKesx
	 j269eRw0ootq3FH9ubujCQrkjnyohM4M/IQhCZNWPrAHRAt0ir6f6pvm1ZXDKM3aWo
	 WQlHlms31+53Ah4itGmcBNU3MRy9a4lAtdWcxrETNDT3aEdM1KQh/r9NoEwH/n9AVX
	 VVfSVoI91p6eA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eduard
 Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 kkd@meta.com, kernel-team@meta.com, Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next] libarena: Use compiler
 load-acquire/store-release in bpf_atomic.h
In-Reply-To: <20260721185705.1365329-1-memxor@gmail.com>
References: <20260721185705.1365329-1-memxor@gmail.com>
Date: Tue, 21 Jul 2026 20:19:05 +0100
Message-ID: <m2v7a89mmu.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> Teach libarena's BPF atomic primitives to use compiler builtins for
> load-acquire and store-release when Clang advertises
> __BPF_FEATURE_LOAD_ACQ_STORE_REL. Older compilers continue to use the
> existing barrier-based fallback.
>
> Notably, as BPF programs begin running on arm64, it is better to use the
> more appropriate variants since we can no longer rely on x86 TSO ordering.
>
> Commit 880442305a39 ("bpf: Introduce load-acquire and store-release instr=
uctions")
> introduced support, hence kernels from 6.15 onwards are needed when
> compiling with compilers supporting these instructions. We have
> relatively recent kernel version requirements in libarena anyway, and
> have not cut first release, hence declare such a dependency.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../selftests/bpf/libarena/include/bpf_atomic.h  | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h b/=
tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
> index b7b230431929..ec8d606e7ce3 100644
> --- a/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
> +++ b/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
> @@ -86,6 +86,21 @@ extern bool CONFIG_X86_64 __kconfig __weak;
>  /* Control dependency provides LOAD->STORE, provide LOAD->LOAD */
>  #define smp_acquire__after_ctrl_dep() ({ smp_rmb(); })
>
> +#if defined(__BPF_FEATURE_LOAD_ACQ_STORE_REL)
> +#define __BPF_HAVE_LOAD_ACQUIRE_STORE_RELEASE 1
> +#endif
> +
> +#ifdef __BPF_HAVE_LOAD_ACQUIRE_STORE_RELEASE
> +/*
> + * Clang advertises this feature when it can lower acquire/release atomic
> + * builtins to BPF_LOAD_ACQ/BPF_STORE_REL. Older compilers keep using the
> + * barrier-based fallback below. The generated instructions require kern=
el
> + * verifier/JIT support added in Linux 6.15; compile for an older BPF CP=
U to
> + * keep using the fallback when targeting older kernels.
> + */
> +#define smp_load_acquire(p) __atomic_load_n((p), __ATOMIC_ACQUIRE)
> +#define smp_store_release(p, val) __atomic_store_n((p), (val), __ATOMIC_=
RELEASE)

__atomic_load_n(&some_struct, =E2=80=A6) is a compile error. we should do t=
he
more generic version:

#define smp_load_acquire(p)					\
	({							\
		__unqual_scalar_typeof(*p) __val;		\
		__atomic_load(p, &__val, __ATOMIC_ACQUIRE);	\
		__val;						\
	})

#define smp_store_release(p, v)					\
	({							\
		__unqual_scalar_typeof(*p) __val =3D (v);		\
		__atomic_store(p, &__val, __ATOMIC_RELEASE);	\
	})

Thanks,
Puranjay
