Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793608122;
	b=jWpVwNLbHcsenuHDoJD9wy3tWvMNH6kyWrB2X7op9+xo+xdlcoRM0mouFI+VhGerlnuI
	 pLxWw8QyXl5o6AuVeV3IRNPgGd7iYVEKCCpEeZjDUQUxzzNptw5IHICi4S8xse+uKmLAZ
	 YURZ8glPTYE+MjwOSurdvrwUFwT3gs+xBMQxBPbooVNhf0imGH9GMjMgsLim8bsL/5+WW
	 +zr0179Akkm74RvhyD0fNxIDb1sJDm4gZ7NEjlAoVu+4t+H473GOV2t0OFO13wA+2T6Em
	 oX4rjCOrkPaOG9phwXw/ukHk8aJvI7sT+cQByve+okr5/oJMgCATgZ7nyR9ESsmWX2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608122;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HVDKHlisotpga7i3OCTRmdVxylQw8ERqkGZPSy066rA=;
	b=5fzhscUWkJlfdIUhcJa8StjC6/omrbYQsJNxp+X6UEY0neT1UMdfAJX5mOVo9xhEfYzi
	 bS1K+yTqsbTD4K1WQqSPKq6j2AThgEXyqohKozTXsxl8jwizHSdyijog0rlMwpoz60mU6
	 xOfXq10oVqLgzsmIbVcahJFgYadrUES53ULK/RFkl1Em4DdoTBKgOgfPObVMV8wyAeJ0q
	 lRT8qWa8dUU2k5A5NA7ZRot4L7iWeGVzYA0SKCQCNDJ5EKt0QWQi53BBaQDHHr6sCHkPV
	 WPDGvXIixXUc/0G5JALHL07Q6+/pH3orOOVblvGEYNboBLXsXsmY7H54Y3MFdFtQu1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMbCTaYd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390F4606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 08:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMbCTaYd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB381F000C1;
	Mon,  2 Nov 2026 08:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793608121;
	bh=HVDKHlisotpga7i3OCTRmdVxylQw8ERqkGZPSy066rA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iMbCTaYdoh2Sv0GJzSLBBSFmiJRUoW+rpYmf5p5fOqKyiOQyWCt71dMFS1AVpGMbi
	 CbXwGQJODC5oA3q8zILJWKA4FPUDPn/ZqgIlWUTXdqs/qnCnVL4jy18tWgLa7WL8F2
	 V/OJOaQhM4YA0kspLyJThuJWhSqHk2sHIKm4vVjhudz+d/Gz3KFJp9ye3rPR/YC3b4
	 5uLZaIkV4FlSlPPhUZga7djlWMDycAu1UjgLjxkoxe+z9FVPElqTd5V3CaFQmYefp6
	 qflBGaCnoqCsXqBAQRz/gLmkeOLD57sVIQ9wGNV4kPXQ2hMfLqsQI2j5PorPbt8KFg
	 Qr5Rg9wmUXhWQ==
Message-ID: <sashiko-outbox-193107@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 1/2] selftests/bpf: Handle EOPNOTSUPP
 gracefully in test_loader
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261102081230.7063-2-yangtiezhu@loongson.cn>
References: <20261102081230.7063-1-yangtiezhu@loongson.cn>
 <20261102081230.7063-2-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 08:28:41 +0000
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
- [Medium] selftests/bpf: indiscriminate EOPNOTSUPP skip in run_subtest()
--

commit 4fea47634d9e4204dd230efbc533c57d0013c98f
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

selftests/bpf: Handle EOPNOTSUPP gracefully in test_loader

This commit updates run_subtest() in test_loader to call test__skip() when
bpf_object__load() fails with errno =3D=3D EOPNOTSUPP in the
!subspec->expect_failure path.

> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
> index d24e4fedae46f..021818afbd3bf 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -1474,6 +1474,10 @@ void run_subtest(struct test_loader *tester,
>  			goto tobj_cleanup;
>  		}
>  	} else {
> +		if (err < 0 && errno =3D=3D EOPNOTSUPP) {
> +			test__skip();
> +			goto tobj_cleanup;
> +		}

[Severity: Medium]
Does checking errno =3D=3D EOPNOTSUPP after bpf_object__load() in the
!subspec->expect_failure branch mask real verifier, BTF, CO-RE, and JIT
regressions while still leaving __failure and __prepare_priv subtests
broken when BPF_MAP_TYPE_ARENA is unsupported?

In tools/lib/bpf/libbpf.c, bpf_object__load() executes both
bpf_object_prepare() (BTF loading, CO-RE relocations, and
bpf_object__create_maps()) and bpf_object__load_progs() (program
verification and JIT compilation). During these steps, -EOPNOTSUPP is
returned for many conditions unrelated to missing platform hardware
extensions, such as add_kfunc_call(), require_callx_jit(),
process_timer_func(), sanitize_check_bounds(), check_hmul_jit(), and
check_attach_btf_id() in kernel/bpf/verifier.c, convert_ctx_accesses() in
kernel/bpf/fixups.c, btf_validate_return_type() and btf_scan_decl_tags()
in kernel/bpf/btf.c, check_struct_ops_btf_id() in
kernel/bpf/bpf_struct_ops.c, and bpf_core_apply_relo_insn() in
tools/lib/bpf/relo_core.c. Skipping any !subspec->expect_failure subtest
on EOPNOTSUPP will cause regressions in those paths to be silently skipped
instead of failing.

At the same time, when BPF_MAP_TYPE_ARENA is unsupported on the platform,
arena_map_alloc() in kernel/bpf/arena.c returns -EOPNOTSUPP during
bpf_object_prepare() -> bpf_object__create_maps(), so bpf_object__load()
aborts before bpf_object__load_progs() is called and leaves
tester->log_buf empty. For __failure subtests in objects declaring an
arena map (such as access_through_number in
tools/testing/selftests/bpf/progs/verifier_arena.c or arena_arg_bad_reg in
tools/testing/selftests/bpf/progs/arena_kfunc.c), run_subtest() takes the
subspec->expect_failure branch:

tools/testing/selftests/bpf/test_loader.c:run_subtest() {
	...
	if (subspec->expect_failure) {
		if (!ASSERT_ERR(err, "unexpected_load_success")) {
			emit_verifier_log(tester->log_buf, false /*force*/);
			goto tobj_cleanup;
		}
	}
	...
	err =3D validate_msgs(tester->log_buf, &subspec->expect_msgs,
			    emit_verifier_log);
}

Here ASSERT_ERR() succeeds on the map creation error, and validate_msgs()
then fails because the verifier never ran and tester->log_buf is empty.
Similarly, if unpriv && spec->prepare_priv is set, bpf_object__prepare()
in run_subtest() fails at ASSERT_OK(err, "obj_prepare") before reaching
bpf_object__load():

tools/testing/selftests/bpf/test_loader.c:run_subtest() {
	...
	if (unpriv && spec->prepare_priv) {
		err =3D bpf_object__prepare(tobj);
		if (!ASSERT_OK(err, "obj_prepare"))
			goto tobj_cleanup;
	...
}

In addition, because run_subtest() enables map autocreation for all maps
in tobj in privileged mode, any object declaring an arena map alongside
unrelated non-arena subtests (such as compute_live_registers.c,
verifier_zext.c, and verifier_ldsx.c) will fail map creation in
bpf_object_prepare() and skip all non-arena subtests in that object when
BPF_MAP_TYPE_ARENA is unsupported.

Would it be better to explicitly probe for BPF_MAP_TYPE_ARENA support
(similar to libbpf_probe_bpf_map_type(BPF_MAP_TYPE_ARENA, NULL) in
test_verifier_hmul_arena() in
tools/testing/selftests/bpf/prog_tests/verifier_hmul_arena.c) or handle
unsupported map creation specifically, rather than catching all EOPNOTSUPP
errors from bpf_object__load()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102081230.7063=
-1-yangtiezhu@loongson.cn?part=3D1
