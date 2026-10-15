Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775D32AE76
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 01:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029066; cv=none; b=tBTeAGai/PBA6ESs7D7CHxjfRgmsg3HKs4u2NRJldXOIZ54l1BjL6POs838bQjcrEOtpANX+kOUCXD+wBIl6SzCbMs1mCCIJE2Z1tf4/oNvWSZyEttGIlMktSt6xCYyuZBvZ4RQMfp24Q01Fs9xuBvStPh+75qdsCy4C/RTHHRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029066; c=relaxed/simple;
	bh=9zjS5P6OXqycVI6ZXdoP5QjFVdv5GRhQKy92tkoflhE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=X3RCABd1pxu9PrhTJCh45cuYb7GyxPPx+8RwiXViTIeF+hOgaE5O4NygFXtg8/mtlefLtzZd95i5NVLk9nD88WA0s8XBlTkhoPabIge3etR770LPOY1utBBI0I4yFlADT7z4a8/KTqtDcqepLCu/Uik326xueMjE9Qukaw/Njhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D45BOFYM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D45BOFYM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E5C1F000C4;
	Thu, 15 Oct 2026 01:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792029065;
	bh=hIBM9jLkTrEBoCpY8GWYSY3J8towiOKzUkirGhlWbOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D45BOFYMnDx6STXp1vax8JsssBVBgt4NOkpE4RC/YS+SA0TKCjT2IfrMrDdzVDRwF
	 UCDGZW5y7VgY5D6P61yLAbjFpSdjcmXGeFpw7iqCVngb/X10DFuIIwhT5RRGekrI5y
	 klZIJiXRQDX55Y40zAlU10rSq0NwvKMszKObCNJXApc1JWkVYOyhXRneXRjtvHcwZj
	 jqQEIt7riw2B3Z3QFx+h7geDclwK0dPMX1BZ6Mt6NIIviSqLtgqxr5LlQ0TSTau4qB
	 mdqunJzO2Qfc64dDJCHa+9y2REpK61iub2A1GUOPnACFUS4HJkNizYNSfblFa4KPsg
	 4oQ4aFk0P7Xew==
Message-ID: <sashiko-outbox-172124@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: Test freeing a
 struct_ops map under a running prog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiliang Yuan" <odys.yuan@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261015-selftests-bpf-struct-ops-assoc-timer-v3-2-efe643d4b2a3@gmail.com>
References: <20261015-selftests-bpf-struct-ops-assoc-timer-v3-0-efe643d4b2a3@gmail.com>
 <20261015-selftests-bpf-struct-ops-assoc-timer-v3-2-efe643d4b2a3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 01:51:04 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: Infinite loop in selftest on bpf_prog_test_run_opts failure
--

commit baed672ead379b019d7064743fc22c2ee377b163
Author: Qiliang Yuan <odys.yuan@gmail.com>

    selftests/bpf: Test freeing a struct_ops map under a running prog
   =20
    st_ops_assoc_in_timer_no_uref drops every reference to the struct_ops
    map while a timer callback of its prog calls .test_1 through the
    association, and checks that the callback ends up with no struct_ops.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc=
.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
> index 461ded7223515..987117091c676 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
> @@ -157,10 +158,13 @@ static void test_st_ops_assoc_in_timer_no_uref(void)
>  	/*
>  	 * Run .test_1 by calling kfunc bpf_kfunc_multi_st_ops_test_1_prog_arg(=
) and checks
>  	 * the return value. .test_1 will also schedule timer_cb that runs .tes=
t_1 again.
> -	 * timer_cb will run 500ms after syscall_prog runs, when the user space=
 no longer
> -	 * holds a reference to st_ops_map.
> +	 * timer_cb will run timer_ns after syscall_prog runs and, with wait_ma=
p_free, every
> +	 * timer_ns after that until the map is freed. With 500ms, it first run=
s when the
> +	 * user space no longer holds a reference to st_ops_map.
>  	 */
> -	skel->bss->timer_ns =3D 500000000;
> +	skel->bss->timer_ns =3D timer_ns;
> +	skel->bss->wait_map_free =3D wait_map_free;
> +	skel->bss->spin_loops =3D spin_loops;
>  	err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.syscall_prog=
), NULL);
>  	ASSERT_OK(err, "bpf_prog_test_run_opts");

[Severity: Medium]
Will this lead to an infinite loop if bpf_prog_test_run_opts() fails?

The ASSERT_OK macro merely logs errors without aborting execution.
If bpf_prog_test_run_opts() fails to execute the test program, the code will
continue to the loop further down in run_st_ops_assoc_in_timer_no_uref():

	/* Check the return of the kfunc after timer_cb runs */
	while (!READ_ONCE(skel->bss->timer_cb_run))
		sched_yield();

Since the program never executed, timer_cb_run will remain 0, and the test
suite will hang indefinitely instead of failing cleanly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-selftests-=
bpf-struct-ops-assoc-timer-v3-0-efe643d4b2a3@gmail.com?part=3D2
