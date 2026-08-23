Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F230927A92D
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787518402; cv=none; b=I238SDYYrUtrrx55MvTCFy/fj+99vCND/wzh0KndSBQ53gWzlIG/riUrXqmeNae+Y6Eeg5wdjkvBd1nflSVN/ViV2U8XnQEeLgq1bWGTBPry6946VUnjdZKJTkR3a4yCcHctVIwZzRJnnYyXzgwm9gB983pStQue7pWYWSWo6bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787518402; c=relaxed/simple;
	bh=Zl7q29bHYhIMWcciUbGoA8FjvMvYbKMWxWxIHZ97ScI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dSxJN7tpmPqf2MJRjd60BMU2kgYKWN1bAzA6haoqMxJ+iZjNVrrOomHzr02R3KzN1jK6jfeTe+8UO+hNgbQZnreQSjiJ8DuXLXGJ4SJ4Pd8X9dyrnZEc+GQkRTKcN0opxvi9dPAtwmzm9XdhEWHMhlqVSs1jxc9lfpKZE93vW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoJs9PGR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoJs9PGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D491F000E9;
	Sun, 23 Aug 2026 20:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787518400;
	bh=sIDYXg6BfpzzTTI0rP7769+LuIo2LTiRLtmQKCI3Ivs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SoJs9PGRFDY04/2EgAGP4rWzHYIk29INAVhHd2Ym6GVNJEaxL0GUZD5SkileDtvGm
	 1PO8VYT3polxdP+N/X8/TGLvgXMkNMd2d6yueGJaQirec9d6Ufy5qUm2t/cuaie5gt
	 L3EGBCPv9WDP4XcbT/X2v3w8LHtCIkuhDDG+eEl+X95X7bMBRkyQMARvxFhvChCFch
	 8fYowCVwAWbeu3/C6AwgTgqcJQTqrt+Ot64eQ8mZImxleS3eqEnOobWpaPosFa5wJY
	 ZKh4Ig/RF0Qq7KF3sFye3VYWm2dJbMElHPcCzDDMH24JeZOSIEpcm0l/NxfX8TDZ29
	 r8Hq/dZ0AjOkg==
Content-Type: multipart/mixed; boundary="===============5769583648148096049=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bed7a2884d1dc2b8beed35030d9f7b7f2056e381bb875f80588a344411f4d574@mail.kernel.org>
In-Reply-To: <20260823194241.3415152-9-nickolay.lysenko@gmail.com>
References: <20260823194241.3415152-9-nickolay.lysenko@gmail.com>
Subject: Re: [PATCH bpf-next v7 8/9] selftests/bpf: move shared build definitions into Makefile.buildvars
From: bot+bpf-ci@kernel.org
To: nickolay.lysenko@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,memxor@gmail.com,nickolay.lysenko@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 23 Aug 2026 20:53:20 +0000 (UTC)

--===============5769583648148096049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 79d6c61a930a7bcff9e424734672a09c86fbdcf2
> Author: Mykola Lysenko <nickolay.lysenko@gmail.com>
> Date:   Sun Aug 23 12:42:40 2026 -0700
>
>     selftests/bpf: move shared build definitions into Makefile.buildvars
>
>     Move the build definitions a test runner needs - tree layout and
>     tool locations, flag assembly, feature probes, signing key paths, the
>     permissive-mode helpers - into Makefile.buildvars, in their current
>     order, as preparation for building each test runner instance in its
>     own sub-make: the definitions become includable by more than one
>     makefile. No rules or recipes are changed.
>
>     The include sits directly after ../lib.mk, ahead of the
>     ../../../build/Makefile.feature evaluation, so the definitions are in
>     place for everything the top Makefile parses afterwards - in particular
>     the LLVM feature probe captures srctree and PKG_CONFIG from their new
>     location, and the top Makefile's remaining uses of both are all
>     recipe-time expansions. Two evaluation-time changes follow from
>     the new position and a third is made on the way, each commented in
>     place: CFLAGS and LDFLAGS are
>     reassembled around a snapshot taken before lib.mk, keeping the
>     pre-split order;
>     CLANG_SYS_INCLUDES becomes an immediate assignment (its inputs are
>     final by this point, and expanding it forks shells); and the
>     CLANG_HAS_ARENA_ASAN probe now sees CLANG as resolved from
>     LLVM=<suffix-or-path> rather than the bare 'clang' default it saw
>     above the include, while the CLANG_CPUV4 probe, needed before lib.mk,
>     keeps the old behavior.
>
>     BPF_GCC, TEST_KMODS and the knobs the runner never reads (SKIP_*,
>     submake_extras, TEST_KMOD_TARGETS, the VMLINUX_BTF block) stay in the
>     Makefile - the first two are needed before lib.mk is included, where
>     Makefile.buildvars cannot yet be, and reach the runners from there once
>     a later patch adds them: TEST_KMODS exported in the environment, BPF_GCC
>     as the bpf_gcc flavor's compiler parameter. Definitions that reach no
>     runner, directly or as a sub-make parameter, also stay - except
>     HOST_INCLUDE_DIR, which moves with the conditional block it shares
>     with the host build directories - and the four that derive from
>     Makefile.buildvars values sit in a block right after the include.
>
>     Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
>     Assisted-by: Claude:claude-fable-5 shellcheck
>     Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>

This isn't a bug, but the second paragraph has some lines that look
unfinished mid-paragraph ("place: CFLAGS and LDFLAGS are" at 29
columns, then "pre-split order;" at 16 columns), as if the text was
edited but not rewrapped. Would it help to reflow those lines?

The third paragraph walks through which variables moved and which
stayed ("BPF_GCC, TEST_KMODS and the knobs the runner never reads...
also stay - except HOST_INCLUDE_DIR..."), restating what the diff shows.
The key detail - that BPF_GCC and TEST_KMODS must be defined before
../lib.mk - is there, but it's somewhat buried in the inventory. Would
trimming the list and keeping just the reason make this clearer?

> diff --git a/tools/testing/selftests/bpf/Makefile.buildvars b/tools/testing/selftests/bpf/Makefile.buildvars
> new file mode 100644
> index 0000000000000..dc0be9ee72bc0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/Makefile.buildvars
> @@ -0,0 +1,184 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Shared toolchain, path and flag definitions for the BPF selftests
> +# build, included by both Makefile and Makefile.runner. Definitions
> +# follow the order they had in the Makefile before the split.
> +
> +TOOLSDIR := $(abspath ../../..)

[ ... ]

> +# Before the split these definitions sat above the ../lib.mk include:
> +# they appended to the flags inherited from the environment, and
> +# lib.mk's additions (USERCFLAGS/USERLDFLAGS among them) came last.
> +# This file is parsed after lib.mk at the top level and in its place
> +# in the runner sub-makes, so the same order is rebuilt here. The
> +# includer snapshots the inherited flags in INHERITED_CFLAGS and

This isn't a bug, but the header and several comments are written from
the patch's point of view rather than as documentation of the current
state. The header says definitions "follow the order they had in the
Makefile before the split", and this block starts with "Before the
split these definitions sat above the ../lib.mk include". A reader
arriving later has no "before" to compare against.

The header also says this file is "included by both Makefile and
Makefile.runner", but Makefile.runner doesn't exist until the next
commit. If someone lands here during a bisect, that sentence is
inaccurate.

Would these comments read better stated as the current invariant ("lib.mk
appends to CFLAGS/LDFLAGS; this file's additions must come first, so
the includer snapshots them in INHERITED_*"), and should the header
mention Makefile.runner only once it exists?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32662817569
--===============5769583648148096049==--
