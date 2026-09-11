Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283A04A43F3
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145247; cv=none; b=PbncnjYume9RJq4oXHnAeNlGP+3FKPhTBNrQVZ7E2y0rpNFMXfuGqsvgU82tzZFC00W9BaRhFffmKVdFyHcBrsBPSmZuqhwEtJH1LKblWW3jrljJaXmP/IKBNLWR7I0m1u8+WhxFk6RSQ9PHRoG/GKeFDCdfRtsGlC9+QTzeKFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145247; c=relaxed/simple;
	bh=CANybaM5o3iHp/pVcGfKheTt6otRk+91iTQOgJi7ps8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=e6q6JFeZ2ZguBhy0tNVSR0n3LwIw8tux31BxfeDlKiAQiQpCLl1G3Fl+lXSjUkn4V0g9RqoWOLKc9/KJtOuiRAyf2zqhDB9qYxHvGSnzNcYnUsnsiPG+9FrwH1iIWxIUxOzB/NBBjQgqSCKG4bFV9ET91UwbrYzLzXmaoWH6ECQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWfIWzbs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWfIWzbs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347A51F000FF;
	Fri, 11 Sep 2026 16:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789145244;
	bh=deBk9ITn87eQCp/oyahGFGTffZxyTGfJ3WW8wp1FJoo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lWfIWzbswlyIh+HYgYypTGfPUMZiS9T4eKCboEcGSfPlKgSZUFLXGjsX5PMdJmPQb
	 y/RVJN7zXg93IIKa65gdDC1QXWDgr+UGolFI5kKiqcS8wo6ZKjI1Q6sNaObXVT9BVt
	 4Ih3kRWSpWHdT+eogMHH/cGF3bCXd9YEcUvuwAYJKwjml2H6otSZc8qJ072iKCJIog
	 /TlUZ9UP386wU8Sn8dRUVOwgx5RqW4JAYtFfHv5jQH5NzyZ3i6KMR9sOi0lBBNulvY
	 ByyASxmQiOQPtU+rMn/p8hTEvdyUTgU9jAdD1iLFluAty/X3eer3R1VJgy61rmfysz
	 GgAh0hHy9U4mA==
Content-Type: multipart/mixed; boundary="===============6592194633517518590=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d4a8dbbae302e4a8038e8162764432030a5b2eb51c2ec1c81fc0e1f926879eb7@mail.kernel.org>
In-Reply-To: <20260911155030.2012652-1-yonghong.song@linux.dev>
References: <20260911155030.2012652-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 15/15] selftests/bpf: Temporary hack to disable register mismatch in arm64
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 11 Sep 2026 16:47:24 +0000 (UTC)

--===============6592194633517518590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Temporary hack to disable register mismatch in arm64
>
> There are 3 kfuncs like below:
>    __u64 bpf_kfunc_call_test_i128_arg_odd(__u64 a, __int128 v, __u64 b) __ksym;
>    __u64 bpf_kfunc_call_test_i128_arg_shift(__u64 a, __int128 v, __u64 b, __u64 c,
>                                             __u64 d) __ksym;
>    __u64 bpf_kfunc_call_test_i128_arg_ovf(__u64 a, __int128 v, __u64 b, __u64 c,
>                                           __u64 d, __u64 e, __u64 f) __ksym;
> which requires that '__int128 v' must be 16-byte align on arm64.
>
> Current pahole will reject BTF generation since pahole expects
> '__int128 v' has start register 'x1' while arm64 abi requires 'x2'.
> Hence, btf generation will fail.
>
> This patch is a hack to disable a few related tests to satisfy CI.
> The following is the fix in pahole:
>   https://lore.kernel.org/bpf/20260911040955.339939-1-yonghong.song@linux.dev/
> Once pahole patch is merged, this patch can be discarded.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

The changelog states the patch is a temporary hack that 'can be
discarded' once the pahole fix is merged, but the patch is submitted as
the last patch of the series with no marker keeping it out of a merge.
Should this have [DO NOT APPLY] or RFC in the subject, or a note under
the --- line where non-applied notes belong?

A few smaller notes: 'must be 16-byte align' should read '16-byte
aligned', and the pahole reference would normally be a Link: tag.

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c b/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c
> index 2100f0ab1abe..59f56ab39413 100644
> --- a/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c
> +++ b/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c
> @@ -50,6 +50,7 @@ int aggregate_arg_kfunc_int128(struct __sk_buff *skb)
>  	return 0;
>  }
>
> +#if 0
>  /*
>   * arm64 rounds the register number up to an even one for an argument
>   * aligned to 16 bytes, so it wants this __int128 in x2 and x3.

Five #if 0 regions are added and none carries an in-tree comment
explaining the disable. The reason (the pahole dependency), the fact
that it's meant to be reverted, and the link to the pahole fix exist
only in the commit message. Once applied, the tree contains unexplained
dead code with nothing that would prompt anyone to re-enable it after
the pahole fix lands. Should each #if 0 have a short comment or TODO
naming the toolchain dependency, or could these use a
version/arch-conditional guard rather than a blanket #if 0?

> @@ -70,6 +71,7 @@ int aggregate_arg_kfunc_int128_odd(struct __sk_buff *skb)
>
>  	return 0;
>  }
> +#endif
>
>  #endif /* __SIZEOF_INT128__ */
>
> @@ -152,6 +154,7 @@ int aggregate_arg_kfunc_split8(struct __sk_buff *skb)
>
>  #ifdef __SIZEOF_INT128__
>
> +#if 0
>  /*
>   * The same hole, with enough arguments after the __int128 that the shift
>   * reaches the registers the BPF convention counts as stack slots: arm64

The three programs disabled here (aggregate_arg_kfunc_int128_odd,
aggregate_arg_kfunc_int128_shift, and aggregate_arg_kfunc_int128_ovf)
are the only tests that observably exercise the arm64 even-register
round-up added by 7189ec8b9091 in this same series.

Looking at bpf_jit_place_args() in kernel/bpf/core.c, it applies the
round-up only for args flagged BTF_FMODEL_ALIGN16_ARG, i.e. __int128 by
value:

    if (align16 && abi->even_reg_align)
            nregs_used = round_up(nregs_used, 2);

arm64_arg_abi sets .even_reg_align = true. Of the __int128 kfunc tests
that remain enabled:

  - aggregate_arg_kfunc_int128 -> bpf_kfunc_call_test_i128_arg(u64, u64,
    __int128): nregs_used is 2 at the __int128, round_up(2, 2) == 2, so
    placement is the identity and emit_kfunc_arg_moves() emits nothing.

  - aggregate_arg_kfunc_int128_pad ->
    bpf_kfunc_call_test_i128_arg_pad(7 x u64, __int128): nregs_used is
    7, round_up(7, 2) == 8, but 7 + 2 > 8 already forces the argument
    wholly onto the stack, so the round-up changes nothing observable;
    only the even_stack_align path is covered.

After this commit, does the arm64 register-shift path (the headline
behaviour of the arm64 patch in this series) and the
alignment-hole-pushes-an-argument-to-the-stack path have any test
coverage on any architecture?

The surrounding code already uses #if defined(__x86_64__) ||
defined(__aarch64__) (bpf_testmod.c and earlier in the same file), and
BPF progs are built with -D__TARGET_ARCH_$(SRCARCH). Would an arm64-only
guard (plus dropping __arch_arm64 from the affected programs) keep the
x86-64 arm of these tests running?

> @@ -193,6 +196,7 @@ int aggregate_arg_kfunc_int128_ovf(struct __sk_buff *skb)
>
>  	return 0;
>  }
> +#endif
>
>  /*
>   * Both conventions pad the stack to align this __int128, and the BPF
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index baccee6fdad4..c367442ce086 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -1039,6 +1039,7 @@ __bpf_kfunc u64 bpf_kfunc_call_test_i128_arg(u64 a, u64 b, __int128 v)
>  	return a + b + (u64)((unsigned __int128)v >> 64) + (u64)v;
>  }
>
> +#if 0
>  __bpf_kfunc u64 bpf_kfunc_call_test_i128_arg_odd(u64 a, __int128 v, u64 b)
>  {
>  	return a + b + (u64)((unsigned __int128)v >> 64) + (u64)v;

[ ... ]

> @@ -1735,9 +1737,11 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_deep)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_ii)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arg)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg)
> +#if 0
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_odd)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_shift)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_ovf)
> +#endif
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_pad)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arg_nofit)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arg_tail)
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> index 195ec37d5bbc..0f098045856e 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> @@ -234,11 +234,13 @@ struct prog_test_ret_ii bpf_kfunc_call_test_ret_ii(int a, int b) __ksym;
>  __u64 bpf_kfunc_call_test_pair_arg(__u64 a, struct prog_test_pair_arg s, __u64 b) __ksym;
>  #ifdef __SIZEOF_INT128__
>  __u64 bpf_kfunc_call_test_i128_arg(__u64 a, __u64 b, __int128 v) __ksym;
> +#if 0
>  __u64 bpf_kfunc_call_test_i128_arg_odd(__u64 a, __int128 v, __u64 b) __ksym;
>  __u64 bpf_kfunc_call_test_i128_arg_shift(__u64 a, __int128 v, __u64 b, __u64 c,
>  					 __u64 d) __ksym;
>  __u64 bpf_kfunc_call_test_i128_arg_ovf(__u64 a, __int128 v, __u64 b, __u64 c,
>  				       __u64 d, __u64 e, __u64 f) __ksym;
> +#endif
>  __u64 bpf_kfunc_call_test_i128_arg_pad(__u64 a, __u64 b, __u64 c, __u64 d, __u64 e,
>  				       __u64 f, __u64 g, __int128 v) __ksym;
>  #endif

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34620351527
--===============6592194633517518590==--
