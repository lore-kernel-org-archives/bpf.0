Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B44E3161A1;
	Thu, 13 Aug 2026 04:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786594938; cv=none; b=P/wbHu88W0tqWIxvyqQZAYDTxmXOOKY+qbFIZr54k6YdE7iRVdCcr/bVvrKR7iFDQs5iIOXO98gSuBO35Mn74rz2ODTlBi0J/yc0eFioosKfAnOK4/s6Ow2AQTu3y0kPZCOxh+4Cm99QIKmg2qPReUp7nVZA+bUJ0fpJtFxOMCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786594938; c=relaxed/simple;
	bh=8/CThzcwjP/n2dV55Z7Pgm1TqMQRvS+r8njctRZbUl4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HgsS9WVwgj8XurgdZoY31U3MbN0nvlaJ0IzG2E7bcwka+UqB0StgN3brmL5MSw3lTwNuk+7vQfKiMVvkU+rHwYulSEps/KgPrOg7Ce1u47EoPflrKYiGpdY12b/kCVPaE8UtTxTdaoA8qc0G4Z2EvfwjGOq51hBqbdZcImmtuOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLe/Kr/v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLe/Kr/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F045D1F000E9;
	Thu, 13 Aug 2026 04:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786594937;
	bh=oW7mP/rU2eofMKMV7cZE0c3XtKLa8h9IxEsJA9APjxk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RLe/Kr/vZ3eyCXOUvR/E+E3hpc4F34Yn2v5Y/OYbQk54IDsXoNCxtN3ppSmD+SvS+
	 Xly5fPDiFNngrWA7MErduUuxsMWzwbtoV7eSMISyWeykKakJ29R1pXx02k1ITJWTBX
	 cihA+z/uI8V/mcFxODUcF4jpeF2doZWRwlD3OH8X2RRdOXb6hxpfiMZKPnDwOzkA1X
	 EpAF4fTtGqAaUBhKKx7efTpxiftbxqc/BKQzdgMJkXlvUfU8KxJXNqD/JFEvdpHFFw
	 5m3NMNYiEfOixv2X3redqr0jGzCW+SDCNs8TGrwswTqWj43NGvpYOm3u+8i3ZR21LG
	 HNRFpBhTGCOeg==
Content-Type: multipart/mixed; boundary="===============8567251041317960685=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e4db83128d3bcfecbccffcc5da7a3634df4566e3b4af1d6c178d9f3468a99ef0@mail.kernel.org>
In-Reply-To: <20260813032613.2755-3-zhaofuyu@vivo.com>
References: <20260813032613.2755-3-zhaofuyu@vivo.com>
Subject: Re: [RFC PATCH bpf-next v2 2/2] selftests/bpf: add tests for selective kmod BTF loading
From: bot+bpf-ci@kernel.org
To: zhaofuyu@vivo.com,bpf@vger.kernel.org,andrii@kernel.org,alan.maguire@oracle.com
Cc: ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,yatsenko@meta.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,zhaofuyu@vivo.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 04:22:15 +0000 (UTC)

--===============8567251041317960685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
> new file mode 100644
> index 0000000000000..d875fcce6681d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
> @@ -0,0 +1,52 @@

[ ... ]

> +static void kmod_btfs_nonexist(void)
> +{
> +	struct kmod_btfs_nonexist *kmod_btfs_nonexist_skel;
> +
> +	kmod_btfs_nonexist_skel = kmod_btfs_nonexist__open_and_load();
> +	ASSERT_NULL(kmod_btfs_nonexist_skel, "kmod_btfs_nonexist__open_and_load");
> +}

On the path where this assertion unexpectedly fails (i.e. the skeleton
loads when it should not), does the bpf_object leak?  There is no
'kmod_btfs_nonexist__destroy()' call before the function returns.

The other two subtests (kmod_btfs_pass and kmod_btfs_mix) call
'__destroy()'.  Test_progs runs hundreds of subtests in one process,
so leaked fds stay open for the rest of the run.  The usual pattern is:

	if (!ASSERT_NULL(skel, "kmod_btfs_nonexist__open_and_load"))
		kmod_btfs_nonexist__destroy(skel);

Also, the ASSERT_NULL check accepts any load failure at all.  Without
privileges, load_module_btfs() returns 0 early ('skipping module BTFs
loading, missing privileges'), so '__open_and_load()' returns NULL and
this subtest passes without exercising '.kmod_btfs' handling.  The same
is true if vmlinux BTF is unavailable, ftrace cannot hook the target,
or there is a typo in the SEC() name.

The positive baseline that rules those out lives in kmod_btfs_pass, but
test_progs subtests are individually selectable:

	./test_progs -t kmod_btfs/kmod_btfs_nonexist

so running this subtest alone gives green with no baseline.  Would it
be clearer to check the error more precisely (find_kernel_btf_id()
returns -ESRCH here), or load a known-good variant inside the same
subtest?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/kmod_btfs_mix.c b/tools/testing/selftests/bpf/progs/kmod_btfs_mix.c
> new file mode 100644
> index 0000000000000..f445cf56ab161
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/kmod_btfs_mix.c
> @@ -0,0 +1,15 @@

[ ... ]

> +/* mix of duplicated and unneeded modules */
> +DEFINE_KMOD_BTFS(_needed_kmods) = { "bpf_testmod", "bpf_testmod", "bpf_test_no_cfi" };

Is 'bpf_test_no_cfi' loaded when this subtest runs?  Looking at
test_progs.c, load_bpf_testmod() at lines 2083-2092 loads only
bpf_testmod.ko.  The bpf_test_no_cfi.ko module is inserted and
immediately removed by prog_tests/test_struct_ops_no_cfi.c via
open()/finit_module()/delete_module().

That means the third entry has no module BTF in the system and exercises
the same path as the 'module_nonexist' entry in kmod_btfs_nonexist.c:
the name is simply never matched in load_module_btfs().

That leaves the interesting case untested: a module whose BTF is present
but which the program does not need, which would prove libbpf actually
skips it as the commit message advertises ('providing a mix of repeated
and extra module names').  Would naming a module that is guaranteed
loaded exercise that path?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31664172915
--===============8567251041317960685==--
