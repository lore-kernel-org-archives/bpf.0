Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57F8391E59
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785866389; cv=none; b=tkymZbnbUuKzmn2PJ9iFVae4nHfkpLk6qOwJNrh801vnflkz6kGvmCobP1PnbnY6rMiEaaBv9gXfqxFHCb6UVw4tj+CC3XW6DcLzt17IGllW896QjPRW/7HQ5YHMUOCSlnBQXPzYzzJfI+g9asL3q5Nq4KzlIoj9m8vkb5Kqy4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785866389; c=relaxed/simple;
	bh=4F6IzxP26RgMNdWgvB0R7Wb1hzSuMYwULKE2wF+ENeI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dzWtXRC55ytZ0tqkGyldNtL9pVtDq1anAWE0tB0mMUi/u2cEWUv5AKDTKIuknunLlozhUBbnunmA7qoPKSkB7Ef6QTtS5l9hdLBDguKPzD8XOMQcyfWV7MkF4mR7f7sCX//Etwn+86e5Il9LpSta8ICAYbspKU/tznUfp7UOZJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evASAbg/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evASAbg/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFF11F000E9;
	Tue,  4 Aug 2026 17:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785866388;
	bh=Mx+uqurkkwxwS+yYl+F5wqUvaiohErAiAOoKwI80jjc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=evASAbg/8y/XsIJqgbgr5fXyoRaihcoi0fuOGY/W0/lu3oI0SLnqcYobLNbFV52rX
	 uSv9q4C3DymSTBHSMJTWB9tV3FhHIXLIdRYCcBCMbHNex8kl0xQw8b4JdtB3Vm2ul9
	 yoXpdmxmDPif56cnqpyj2ld3SQ5yCo5uqKcS8CapVKOZNZJXFc5WnUAbuOFo4ILKac
	 BvxNvZrQVYIjtl2IWocCIDFwzL/YegHDBn32SQydxLrbsAAO6VFsXLjZwB1m71Gu6p
	 gHShWJAP0eOsmi7EKlXeC6yhYqT67pEFVXcWC/53IZvKXnMCU5PQgKSFiUw7P0snV9
	 NPSKaSIoYHjLA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v5 6/8] selftests/bpf: extract BPF skeleton
 generation into a helper script
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykola Lysenko" <nickolay.lysenko@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260804170156.1709916-7-nickolay.lysenko@gmail.com>
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
 <20260804170156.1709916-7-nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 17:59:47 +0000
Message-Id: <20260804175948.3AFF11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch introduces a behavior change in permissive mode that r=
esults in noisy build logs and redundant error messages, contradicting the =
commit message claim that 'behavior is unchanged'. Additionally, a script c=
omment references a non-existent file.
--

--- Patch [6]: [RFC PATCH bpf-next v5 6/8] selftests/bpf: extract BPF skele=
ton generation into a helper script ---
commit e4a593d3d0bfe3675d723364cb65f81a2812b866
Author: Mykola Lysenko <nickolay.lysenko@gmail.com>

selftests/bpf: extract BPF skeleton generation into a helper script

This commit extracts the BPF skeleton generation steps into a dedicated she=
ll
script (gen_bpf_skel.sh) to reduce Makefile complexity and escaping issues.=
 It
handles regular, light, signed light, and linked skeletons through script
flags.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 0ee02eeac6bca..dbde2f6bd044d 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> -$(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
> -	$(Q)$(if $(PERMISSIVE),if [ ! -f $$< ]; then			\
> -		$$(RM) $$@ $$(@:.skel.h=3D.subskel.h);			\
> -		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
> -		exit 0;							\
> -	fi;)								\
> -	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY)] $$(notdir $$@)' 1=
>&2; \
> -	$$(BPFTOOL) gen object $$(<:.o=3D.linked1.o) $$< &&		\

[ ... ]

> +$(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) gen_bpf_skel.sh | $(T=
RUNNER_OUTPUT)
> +	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
> +	$(Q)BPFTOOL=3D$$(BPFTOOL) ./gen_bpf_skel.sh				\
> +		--name $$(notdir $$(<:.bpf.o=3D))					\
> +		--skel $$@ --subskel $$(@:.skel.h=3D.subskel.h) $$< $$(call skip_on_fa=
il,SKEL,$$(@:.skel.h=3D.subskel.h))

[Severity: Medium]
Does this change in permissive mode behavior contradict the commit message
which states "behavior is unchanged"?

Previously, if a .bpf.o file failed to compile in permissive mode, the
skeleton generation recipe would quietly check for the missing file, print
SKIP-SKEL, and exit early without executing bpftool.

With the missing-file guard removed, the recipe now unconditionally prints
GEN-SKEL and calls gen_bpf_skel.sh. This invokes bpftool on a missing file,
causing it to fail loudly to stderr before the skip_on_fail suffix catches
the exit code. This results in noisy build logs and redundant error message=
s.

> diff --git a/tools/testing/selftests/bpf/gen_bpf_skel.sh b/tools/testing/=
selftests/bpf/gen_bpf_skel.sh
> new file mode 100755
> index 0000000000000..e234f3a57d46b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/gen_bpf_skel.sh
> @@ -0,0 +1,93 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0

[ ... ]

> +# The bpftool binary is taken from $BPFTOOL (default: bpftool from PATH).
> +# On failure all outputs and intermediates are removed and the script
> +# exits non-zero; permissive-mode skipping is the caller's business
> +# (see skip_on_fail in Makefile.buildvars).

[Severity: Medium]
Is the reference to Makefile.buildvars correct here?

The file Makefile.buildvars does not exist. It looks like skip_on_fail is
actually defined directly in tools/testing/selftests/bpf/Makefile.

> +
> +set -u

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804170156.1709=
916-1-nickolay.lysenko@gmail.com?part=3D6
