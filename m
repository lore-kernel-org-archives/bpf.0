Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DD83EDAA4
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369155; cv=none; b=P0yMRVIWiPFTe8QaUtbYHm+N+LWAmHypUKCy5rpSEiebizzqhs6pRhIsIRZWFmTUMwVGp5W2VP7GpWjoNd58xLzm1CGE4WctEkHbdMmoiSnh4o5sATtNPXcT950Uw8bglipSIpGhoJmT1i888vKhzQiqq2hhTe3uSf1yCXoysA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369155; c=relaxed/simple;
	bh=FilhRYSMEl2ASdJ3pfNjcSXnzxfOl35HRDqP/OadlTk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a3KVQ57rnztwnaate7g6ptDaAS6Q0hUPuZbfeJOFw8gkPNVC/c5mtwLZQHzitNvFsXJTz+qoybRJ45GN3ze3soAjZzzgXdcMuvDKxNBRD4K9JReNHbEEWQpb7DdoEFAHIq4SaqASalvCd8vnHhAYZSbmWBK2SImh064rCv/I518=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sX/5LVji; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sX/5LVji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D56C2BCAF;
	Thu, 16 Apr 2026 19:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776369154;
	bh=FilhRYSMEl2ASdJ3pfNjcSXnzxfOl35HRDqP/OadlTk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sX/5LVjiDJV+vz5eAylaSFPBjtvmbZ+iGNDV3eF4MJC5toxcaZ4lmEbiPi/HKKmVg
	 zQJD5lVjtk5Kt00sI8idfkNbao/SfbLQmmZu2uixB8/KMuhxbf73sK1ETqmVDLtyzG
	 D/zTKBv7agZF2pSviECl1TN5mwF+Lkr5fR6qhKbqClB6L076lS8WaxysMn1Q8AVSPT
	 4Jada2veyqKEMKTwAiRiK+9y1LszbwWkB9Wfe3QoS/FbakAG9sg3AiNYsRj/L042cf
	 fxN3TBVSCnHhaNGVF4C5ikHtGCtB/xldcTPkhdsEDkvN2ZyImcq3Mj30Ehvo2nEd8Z
	 eEcdyuvLt5vkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 02/11] selftests/bpf: Fix test_kmods KDIR to
 honor O= and distro kernels
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416-selftests-bpf_misconfig-v7-2-a078e18012e4@suse.com>
References: <20260416-selftests-bpf_misconfig-v7-2-a078e18012e4@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 19:52:33 +0000
Message-Id: <20260416195234.54D56C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Overloading of O=3D incorrectly aliases the selftest output direct=
ory to the kernel build directory.
- [Medium] Relative paths passed to O=3D are incorrectly resolved against t=
he sub-make's working directory.
--

commit 7a429745e6e5a3d1081ae76477bd32a034698ba8
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Fix test_kmods KDIR to honor O=3D and distro kernels

This commit modifies the test_kmods Makefile to respect the O=3D and
KBUILD_OUTPUT variables for locating the correct kernel build directory.
It falls back to /lib/modules/$(uname -r)/build when neither an explicit
build directory nor an in-tree Module.symvers is present.

> diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/test=
ing/selftests/bpf/test_kmods/Makefile
> index 63c4d3f6a12f6..ba6f6ed6ab8c0 100644
> --- a/tools/testing/selftests/bpf/test_kmods/Makefile
> +++ b/tools/testing/selftests/bpf/test_kmods/Makefile
> @@ -1,5 +1,7 @@
>  TEST_KMOD_DIR :=3D $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST=
)))))
> -KDIR ?=3D $(abspath $(TEST_KMOD_DIR)/../../../../..)
> +SRCTREE_KDIR :=3D $(abspath $(TEST_KMOD_DIR)/../../../../..)
> +KMOD_O :=3D $(abspath $(or $(O),$(KBUILD_OUTPUT)))

If a user specifies a relative path like "make O=3Dout", will this resolve
incorrectly against the sub-make's current working directory instead of the
parent directory?

Since abspath is evaluated inside the test_kmods sub-make, a relative
O=3Dout would evaluate to .../test_kmods/out instead of .../bpf/out,
potentially breaking out-of-tree builds. Does the path need to be
resolved to an absolute path before the sub-make transition?

Additionally, when building selftests out-of-tree via
"make O=3D/tmp/selftests -C tools/testing/selftests", O=3D strictly defines=
 the
selftests output directory.

Since O takes precedence in $(or $(O),$(KBUILD_OUTPUT)), will it shadow a
valid KBUILD_OUTPUT? This could cause kbuild to fail due to a missing
.config or Module.symvers in the selftests directory.

Could the Makefile differentiate the selftest output directory from the
kernel build directory, or verify that $(KMOD_O) actually contains a
prepared kernel build before forcing kbuild to use it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416-selftests-=
bpf_misconfig-v7-0-a078e18012e4@suse.com?part=3D2
