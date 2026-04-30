Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462EE41C30D
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777556495; cv=none; b=Mkq5BkMI3wCDf6m8Qe0iWCdfQWtsfFvgxuhyhVfEUO+xc6z6FJ6kYASnQmeGeJN4p9PES6SKPGXSdW610MsF2lb/k68gah3S0mdOJHnA1KwRTtesmvZHgbhEL6ttrq7oWjkR44NSKmDkkoAF/f0tvHmzw/o1OPnelB2ESukCUFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777556495; c=relaxed/simple;
	bh=mhk33mtzD8g4vzwSfKVIfBBgXit6/xNJrz6wTbAeFLk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MgqF+gKAZS1bj3uA1k7d2vokR+2XconIy5HZ4eovffATie1pmp8+dzzPlop+5AfEUFev8Z1DBbv6MPczkCEARqVE7NUQp91VrN4/51kfl61vn6nG90CXGNKTH8oMNGMLE7HtSkMMMG3dUbzOFyq1zpGD2CgpvUaYHlqnjU4wzYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQbWoFc+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQbWoFc+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77EEC2BCB3;
	Thu, 30 Apr 2026 13:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777556494;
	bh=mhk33mtzD8g4vzwSfKVIfBBgXit6/xNJrz6wTbAeFLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gQbWoFc+wcUCJs00WPAdSUyI8Dk5PzzcBReKer797bGA3hmloxl6vFxXPuEa+MVsj
	 8Ay8t+xunYJDT4OalQV+7poc+rSuqtTeFjp/EToePAmdZMZNGGlqzrCdcrAAZ/VNNU
	 e2pNsuBtkzRjKW/BTU+Y4KBBm2YwV813OBl4ZuSZdOdg4DXeutOLHQBh6FjdNi8Cms
	 04O/8LshBdW5cJc7yxDbX6qG6SXoggfTLzw7xGH2aNvDsSoC3ZjGWFdhLFkDwslQQ3
	 JPTHf/XobNeGLtJa7EIrC+o4/lRKImOYiudqT6RGFbRTN/HMW1g5JrHbTqXhm4IvDq
	 xU7qR5kDyUITg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v10 05/11] selftests/bpf: Make skeleton headers
 order-only prerequisites of .test.d
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260430-selftests-bpf_misconfig-v10-5-cd302a31af16@suse.com>
References: <20260430-selftests-bpf_misconfig-v10-5-cd302a31af16@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 13:41:34 +0000
Message-Id: <20260430134134.C77EEC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Changing BPF skeletons to order-only prerequisites of `.test.d` =
can cause test files to compile against stale `.skel.h` files or fail to co=
mpile entirely.
- [Medium] The commit message's justification for keeping `$(BPFOBJ)` as a =
normal prerequisite relies on a factual misunderstanding of GNU Make semant=
ics.
--

commit 8d292a14fcd0b996b2eefecd2620dba48edb8cd2
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Make skeleton headers order-only prerequisites of .test.d

This commit moves the BPF skeleton dependencies to be order-only prerequisi=
tes
for the generated .test.d files. It intends to prevent build failures when
skeletons are intentionally skipped.

> $$(BPFOBJ) is intentionally kept as a normal prerequisite: a libbpf
> rebuild legitimately invalidates .test.d, since libbpf header changes
> can affect the headers .test.o sees. Only the skeleton headers are
> moved to order-only.

Does updating .test.d actually force .test.o to rebuild?

In the current Makefile structure, .test.d is attached as an order-only
prerequisite to .test.o. In GNU Make, an order-only prerequisite being
updated does not force its dependent targets to rebuild.

It seems .test.o actually rebuilds upon libbpf changes because GCC's
-MMD flag dynamically embeds explicit paths to the libbpf headers as
normal prerequisites inside the .d file itself, rather than relying on
.test.d invalidation.

> Note that adding a new BPF skeleton via a modified existing local header
> still works correctly: GNU make builds order-only prerequisites that do
> not exist (the order-only qualifier only suppresses timestamp-driven
> rebuilds, not existence-driven builds), so a brand-new .skel.h listed in
> TRUNNER_BPF_SKELS is generated even when .test.d is otherwise up to date.

Will GNU Make actually build the order-only prerequisites if the target
itself is already up to date?

If a local header is modified, .test.d is not considered out of date
because it only depends on the .c file and global headers. If the target
(.test.d) does not need to be rebuilt, Make does not evaluate or build
its order-only prerequisites at all.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 9a4d8bea0c184..608e6dff03926 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -726,11 +726,11 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:		=
	\
>  $(TRUNNER_TEST_OBJS:.o=3D.d): $(TRUNNER_OUTPUT)/%.test.d:			\
>  			    $(TRUNNER_TESTS_DIR)/%.c			\
>  			    $(TRUNNER_EXTRA_HDRS)			\
> +			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)		\
>  			    $(TRUNNER_BPF_SKELS)			\
>  			    $(TRUNNER_BPF_LSKELS)			\
>  			    $(TRUNNER_BPF_LSKELS_SIGNED)		\
> -			    $(TRUNNER_BPF_SKELS_LINKED)			\
> -			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)
> +			    $(TRUNNER_BPF_SKELS_LINKED)

Can this regression cause test files to compile against stale skeleton
headers or fail to compile entirely?

If a developer modifies an existing local header to include a new skeleton
header, the .test.o file is considered out of date because its previously
generated .d file tracks the local header. However, the .test.d target
does not track the local header, so Make considers it up to date.

Because .test.d is up to date, Make skips evaluating its order-only
prerequisites (the skeletons). Make then proceeds to build .test.o before
the new skeleton is generated, leading to either a compilation failure or
a silent build corruption where the test runs against a stale BPF object.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430-selftests-=
bpf_misconfig-v10-0-cd302a31af16@suse.com?part=3D5
