Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C66F38E5DA
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776287733; cv=none; b=ApYcIaEZ2naZWgK/LgMNjw/Bzoima8kATGvBrkvoRFlcHpsTeJy4yrTE3YfaCsYQy1Pj0w6SYuwkT7Co7DWDCWSLwaZ3Zg7PoeSgdrERvJBZltcRxRchNM88SDSNmMJ/22Dg7/S4zwFq8kcdIdCY3sd53Cl81x1K6qbkx74pH48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776287733; c=relaxed/simple;
	bh=eo4qJy3M4jczQcTdwEp8sHyDei5d5JWwBMmQ4Gb/42k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X81QtYxnF+5B9Fs/qA1KrN5ZrIAzw7m7zIhVEVI2CvA14HkMHFBXVthNyY7aUWsG4ezdCqBhyAKPxK4aRSZ0okHm0iNyPgXTQywvyKLETBUcGAQZMlKKAwySXrzUlABQ5I4mzgi8VY1Htg/Rlm+TkmLs0J3r5I0sVTCUeRV3A+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWm1kYgB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWm1kYgB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56BEC19424;
	Wed, 15 Apr 2026 21:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776287732;
	bh=eo4qJy3M4jczQcTdwEp8sHyDei5d5JWwBMmQ4Gb/42k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sWm1kYgByjdoRo1pcdSSkwlfWbmRx5sZj+ec0U0npXhd/GlPdJBDwkDvHvyn450ry
	 EWdeNshL+nO709TXR+NJm1BDYum54SVuY+YHXWK/2dkBet41ptQErEVYuosyxpQbXc
	 11tsD7L7sTSq5jn2iK7r3grMUjQaoEjO7V9GTNVX9toRk9IaSLFOcJ4YR51dNDZxhA
	 m2ayKirZDihqTIhYoxy9xCyH1595PHv8DYxEUPF9VNRBNl83OKXpSj11h6jN5NMoZZ
	 6/GOhMK8yPWKkOJRzRGiW8Xzj0uwuoE/K0p6aTOv2zOmDLO5YOK+s88GoJ7dIPfzEU
	 CLG4KtXmGZqLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 03/11] selftests/bpf: Tolerate BPF and
 skeleton generation failures
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260415-selftests-bpf_misconfig-v5-3-03d0a52a898a@suse.com>
References: <20260415-selftests-bpf_misconfig-v5-3-03d0a52a898a@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 21:15:32 +0000
Message-Id: <20260415211532.A56BEC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Silent masking of skeleton generation failures when PERMISSIVE is =
disabled (strict mode).
- [High] Stale skeleton artifacts are left on disk on incremental builds wh=
en prerequisite BPF objects fail to compile.
--

commit 3cf9cc67632ce30dc796d085a5a01c842575cf10
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Tolerate BPF and skeleton generation failures

Some BPF programs cannot be built on distro kernels because required BTF
types or features are missing. Make BPF object and skeleton generation best
effort: emit SKIP-BPF or SKIP-SKEL, remove failed outputs so downstream rul=
es
can detect absence, and continue with remaining tests.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 5c4cdf1dafc8b..a305d13409e4b 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
[ ... ]
> @@ -598,47 +602,77 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
>  					  $$($$<-$2-CFLAGS),$(TRUNNER_BINARY))
> =20
>  $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
> -	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
> -	$(Q)$$(BPFTOOL) gen object $$(<:.o=3D.linked1.o) $$<
> -	$(Q)$$(BPFTOOL) gen object $$(<:.o=3D.linked2.o) $$(<:.o=3D.linked1.o)
> -	$(Q)$$(BPFTOOL) gen object $$(<:.o=3D.linked3.o) $$(<:.o=3D.linked2.o)
> -	$(Q)diff $$(<:.o=3D.linked2.o) $$(<:.o=3D.linked3.o)
> -	$(Q)$$(BPFTOOL) gen skeleton $$(<:.o=3D.linked3.o) name $$(notdir $$(<:=
.bpf.o=3D)) > $$@
> -	$(Q)$$(BPFTOOL) gen subskeleton $$(<:.o=3D.linked3.o) name $$(notdir $$=
(<:.bpf.o=3D)) > $$(@:.skel.h=3D.subskel.h)
> -	$(Q)rm -f $$(<:.o=3D.linked1.o) $$(<:.o=3D.linked2.o) $$(<:.o=3D.linked=
3.o)
> +	$(Q)$(if $(PERMISSIVE),if [ ! -f $$< ]; then			\
> +		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
> +		exit 0;							\
> +	fi;)								\

If $$< is missing during an incremental build because a previous permissive=
 run
failed to compile it, does exiting 0 here leave a stale .skel.h on disk?

Since $@ is not removed before exiting, it appears downstream targets might
incorrectly compile against the stale skeleton instead of failing or skippi=
ng.

> +	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY)] $$(notdir $$@)' 1=
>&2; \
> +	$$(BPFTOOL) gen object $$(<:.o=3D.linked1.o) $$< &&		\
> +	$$(BPFTOOL) gen object $$(<:.o=3D.linked2.o) $$(<:.o=3D.linked1.o) && \
> +	$$(BPFTOOL) gen object $$(<:.o=3D.linked3.o) $$(<:.o=3D.linked2.o) && \
> +	diff $$(<:.o=3D.linked2.o) $$(<:.o=3D.linked3.o) &&		\
> +	$$(BPFTOOL) gen skeleton $$(<:.o=3D.linked3.o) name $$(notdir $$(<:.bpf=
.o=3D)) > $$@ && \
> +	$$(BPFTOOL) gen subskeleton $$(<:.o=3D.linked3.o) name $$(notdir $$(<:.=
bpf.o=3D)) > $$(@:.skel.h=3D.subskel.h) $(if $(PERMISSIVE),|| { \
> +		$$(RM) $$@ $$(@:.skel.h=3D.subskel.h); \
> +		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
> +	}); \
> +	rm -f $$(<:.o=3D.linked1.o) $$(<:.o=3D.linked2.o) $$(<:.o=3D.linked3.o)

When PERMISSIVE is disabled, does the generated shell command chain hide
generation failures?

Because the $(if) block evaluates to nothing in strict mode, the generated
command ends with a semicolon:

> > $$(@:.skel.h=3D.subskel.h) ; \
> rm -f ...

If bpftool or diff fails earlier in the && chain, the shell will skip to the
semicolon and execute rm -f. Since rm -f always succeeds, it will return ex=
it
code 0, which seems like it would cause make to silently ignore actual
compilation regressions in strict mode.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415-selftests-=
bpf_misconfig-v5-0-03d0a52a898a@suse.com?part=3D3
