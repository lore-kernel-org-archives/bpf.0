Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C851340401
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791532117; cv=none; b=eyxglcbfvjpr7uQIOXmLmrUU+83whlMdoXsfyZvmtDO3xpHLtIwkrNA64BYdOUI0oen0+IkyBf6sD1YsN20LVNhP/BAIHgMkVxQuMFxoQ/FJ85wDJs8dbBPB1XxAVY/RZY7Jfciwa1h9d+gH1bMWuVr4yKBrvRkf8/1p7Z2SC2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791532117; c=relaxed/simple;
	bh=hDfN5VI6K69Pg6Ioy7M5CHN3YvrIsH7S1DhDaqoifZY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ahksifFjJJ3MgZaqdOnfjEKl3FhHeFOeczdoU6aoqcf2UQzzQzhzhJgL2J1vUJAYmJUfNnMkUnWOQiD/zq1Xk6GQQu620dDj7pNUe1KyR76TiLiLxfG6Bwe1siHKje8WkjBXnTD2eytyzN66R/nZgjla548rLRGa4AO0mEETv4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/KTPUk2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/KTPUk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672361F000FF;
	Fri,  9 Oct 2026 07:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791532115;
	bh=MJZKVhjhstZRxuKTay416R3/NhQ2MDdhh9X83jYVOXk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=R/KTPUk2iQZpDLEf3DJwQrXGcOmas0adbWEk8KF6itdEsl4RJhCWI0bZi0TeknhK0
	 wcBpLmMi9l8UtAkhDcmFzE47dcyO+Kur/sJMLVD3Q53LQgpBBbxqQ5mbqoIaZl9r3H
	 yWhSqZlD3eK/koxM2TrjinSWMA+hF3NTlUUOzuRD3zNUI5xeHlKQcdJdM5/AFqk81i
	 xdcgQDrASwgKM8+nqZ9Mmgzah6Q25BQZZ+1Du4UPFmKKvobdkqK1KhL6IIQSK5cSNe
	 NdIwWl9+C5ebdg3AhSNQIP7Okw6MNrCwAbFKmb2TstPJ70NymvAU0pFmNhz15G+t49
	 lqCVdjyT1MlUA==
Content-Type: multipart/mixed; boundary="===============2950585191075928114=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <18d9233ff61909ba7ef175caaa63248c2e70abfb0fe7d56a4fdb350d43eaa44c@mail.kernel.org>
In-Reply-To: <20261009064211.1239307-1-yonghong.song@linux.dev>
References: <20261009064211.1239307-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 1/5] selftests/bpf: Test by-value __int128 kfunc arguments at an odd slot
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 07:48:34 +0000 (UTC)

--===============2950585191075928114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test by-value __int128 kfunc arguments at an odd slot

TL;DR: On arm64 with an older pahole, the two new kfuncs lack BTF, so
bpf_testmod.ko may fail to build or load, losing all bpf_testmod selftests,
not just the new ones.

> On arm64 the first two kfuncs get BTF only with the pahole patch
> "dwarf_loader: Skip the argument register the arm64 ABI leaves as a hole"
> [2], in pahole master after v1.32. An older pahole finds the argument
> after the __int128 in an unexpected register, x4 rather than x3, and
> leaves the function out of BTF, so the tests fail to load there.

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c

[ ... ]

> @@ -1763,6 +1786,9 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_deep)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_ii)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arg)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg)
> +BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_odd)
> +BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_odd_many)
> +BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_stack_hole)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_pad)

Is the failure on arm64 with an older pahole really limited to the two new
tests?

Both bpf_kfunc_call_test_i128_arg_odd and
bpf_kfunc_call_test_i128_arg_odd_many are added to
bpf_testmod_check_kfunc_ids, the module's main kfunc set.

With no BTF FUNC for them, resolve_btfids only warns ("no BTF func for
kfunc ..." in collect_kfuncs() and "unresolved symbol ..." in id_patch())
and leaves their set8 ids at 0.  With CONFIG_WERROR=y, scripts/Makefile.btf
passes --fatal_warnings, so bpf_testmod.ko would fail to build.

Otherwise, at module load bpf_testmod_init() calls
register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_testmod_kfunc_set),
and __register_btf_kfunc_id_set() checks every entry:

    for (i = 0; i < kset->set->cnt; i++) {
        ret = btf_check_kfunc_protos(btf, btf_relocate_id(btf, kset->set->pairs[i].id), ...);
        if (ret)
            goto err_out;
    }

btf_check_kfunc_protos() does:

    func = btf_type_by_id(btf, func_id);
    if (!func || !btf_type_is_func(func))
        return -EINVAL;

Id 0 resolves to btf_void in the base BTF (btf_relocate_id() maps 0 to 0),
so this returns -EINVAL.

That would reject the whole set, bpf_testmod_init() would return the error,
and bpf_testmod.ko would not load.  test_progs then prints "Selftests
relying on bpf_testmod.ko will be skipped", so every bpf_testmod-dependent
selftest on arm64 would be lost, not only the two new ones.  The same
configuration worked before this patch.

Could the two arm64-hole kfuncs go into a separate kfunc set whose
registration failure is tolerated?  Alternatively, should the commit message
say that bpf_testmod.ko as a whole needs the newer pahole on arm64, rather
than "the tests fail to load there"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37897160282
--===============2950585191075928114==--
