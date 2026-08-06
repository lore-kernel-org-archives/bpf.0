Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD031381AE4
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 04:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785990579; cv=none; b=AzfwuIEu8e3LiqRuhs+ZaTKJKIaGRF+3+odXFuaYLVKvf6TOVXW0xqW4q1cZQ33T0Ggjl4B6uEplfkC4qj/EdSnyP4+yoHXAFNHnBQ20p+udGrqcoTivj3i/KTz31Loo1GJTdjToec+o6b3bzSLzdxnv7W9wc2bBMGJxuMrruHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785990579; c=relaxed/simple;
	bh=M9JbnndcKOn4XfWQ6BUUZvNsRvl2NDNOBqtcwoeTM+4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sQtdypKreNAJBbvt5oDEm8GGCnogGPsxaHjD8NWjTcIie8Ij/P6fcPwnBRaYrbDstbrmh6SPo432bevAgCMPJDGhynxGW/d4mctxB/p4JGDed8lpTSe/1LW9TtTiv6tVdqpnn2MLbS6nwV1BEou5VM4HeZhSFXrDZZX2Yw+Qgvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NV0TRUys; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NV0TRUys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3A81F000E9;
	Thu,  6 Aug 2026 04:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785990578;
	bh=GinDxxKmafwtD22U6OCdgIf+pD4aqcRP+TlicVwAvhQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NV0TRUyssjzX1rhO3qa5bg4bOzAN5eLvKrKQ7yq2PEza0JB11YRgXARhSo2NBrM5Q
	 7CJo5zkiXQ3PXBqN0bKHDQyhWlC3KzVSTSB3PmZIsb2+/t+UFmwFISNHDAJE4z6fHf
	 CBST5fTk4jsf6X6VJgVOE1Ev3Y3sbRG+4DlDjs8UMyNJw1p9E3iZ/KmfiKu0Qlxiti
	 UJF2LXR3skVH1ozWiYVmQQ5ZrevoSiBa2auceh3SqlbANdAGGRZRkPkjXNiNuxs5CM
	 d8vccQyvuXuK7EKJ6Yz9jvQRXbVQ/SmtLVyoi7TewX7dT3rtpFe8VT3n7bQNp6pk9v
	 8t+PW+pE4EPZQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 2/2] selftests/bpf: add tests for selective
 kmod BTF loading
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fuyu Zhao" <zhaofuyu@vivo.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260806042042.3239428-3-zhaofuyu@vivo.com>
References: <20260806042042.3239428-1-zhaofuyu@vivo.com>
 <20260806042042.3239428-3-zhaofuyu@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 04:29:37 +0000
Message-Id: <20260806042938.3B3A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The test `test_kmod_btfs` depends on the `bpf_testmod` kernel mo=
dule being available, but does not check `env.has_testmod` before running.
- [Low] Multi-line comment does not follow BPF subsystem style guidelines.
--

--- Patch [2]: [RFC PATCH bpf-next 2/2] selftests/bpf: add tests for select=
ive kmod BTF loading ---
commit 35262af12350c47550b117d06e881e0de422cb5d
Author: Fuyu Zhao <zhaofuyu@vivo.com>

selftests/bpf: add tests for selective kmod BTF loading

This commit adds test cases to verify the new .kmod_btfs section logic in
libbpf. It covers scenarios with valid, non-existent, and duplicated module
BTF targets to ensure robust loading and parsing.

> diff --git a/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c b/tools/t=
esting/selftests/bpf/prog_tests/kmod_btfs.c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
[ ... ]
> +static void kmod_btfs_mix(void)
> +{
> +	struct kmod_btfs_mix *kmod_btfs_mix_skel;
> +
> +	kmod_btfs_mix_skel =3D kmod_btfs_mix__open_and_load();
> +	if (!ASSERT_OK_PTR(kmod_btfs_mix_skel, "kmod_btfs_mix__open_and_load"))
> +		return;
> +
> +	kmod_btfs_mix__destroy(kmod_btfs_mix_skel);
> +}
> +
> +void test_kmod_btfs(void)
> +{
> +	if (test__start_subtest("kmod_btfs_pass"))

[Severity: Medium]
Since this test depends on bpf_testmod being available, should we check
env.has_testmod at the start of the test and skip it if not found?

Without it, running the selftests on a system where the test module is not
built or fails to load might cause erroneous test failures instead of being
gracefully skipped.

> +		kmod_btfs_pass();
> +
> +	if (test__start_subtest("kmod_btfs_nonexist"))
> +		kmod_btfs_nonexist();
> +
> +	if (test__start_subtest("kmod_btfs_mix"))
> +		kmod_btfs_mix();
> +}

> diff --git a/tools/testing/selftests/bpf/progs/kmod_btfs_nonexist.c b/too=
ls/testing/selftests/bpf/progs/kmod_btfs_nonexist.c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/kmod_btfs_nonexist.c
[ ... ]
> +SEC("fexit/bpf_testmod_loop_test")
> +int test_kmod_btfs_nonexist(void *ctx)
> +{
> +	return 0;
> +}
> +
> +/* This should fail to load, because .kmod_btfs does not contain
> + * the needed module 'bpf_testmod'.
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the BPF
subsystem style guidelines?

The BPF guidelines usually require the opening /* to be on its own line.

> +DEFINE_KMOD_BTFS(_needed_kmods) =3D { "module_nonexist" };
> +
> +char _license[] SEC("license") =3D "GPL";

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806042042.3239=
428-1-zhaofuyu@vivo.com?part=3D2
