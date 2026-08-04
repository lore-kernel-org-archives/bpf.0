Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDB43FADF6
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785864083; cv=none; b=hfW/Orod+x2F2wKxxnyU21ffzDOsl/WdOHUfOSDee9PjHp1TEfv7affFqBbXKzQmAAQlnpv81+95sZuCUcz7Zov+U6ckQUkxzdV4AKPH7aE+0n1xZTAmFlDDizyeOIwJf67kNn6KTDhfKEfNk3FShyzLkKQExfj83MWvfAUji0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785864083; c=relaxed/simple;
	bh=u7OT/y/P3otT6CIY81GvZ8D5DhMpZfWmpqCuArhZc14=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GkjPcMpJoFbaw6J9zpCp4/aPxObdW5p2oyfWXm+9q7P9KKQutGAO41P2zRPnj5l7oKcSuDwcYCpO4vXd+SsVpe11AZjxsuMpNQ8SpxV64lCLB7Z9W9i37ExdlDTRDSNV+0wqqid8+Ue8b9mzMHzxvniS4AOzptYFX/YFPUw0xhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYcC98W4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYcC98W4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442151F000E9;
	Tue,  4 Aug 2026 17:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785864069;
	bh=uB3aW1Ti/Yt3a/BVjzDhVHwqEWQErPp+6yZnOYYvOx8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KYcC98W4AZsE98BIfdVg2Nxs2lh79o2M8M8VPnk9gyURS7mjau9p0XmEq+FW2bb7q
	 YgDOPBDvMjSM1HaDGlmKNbjP6sTjIt4ksfi31oDMAk96MR163ptCihEp4DAZXSKvyJ
	 dMOOPDVnsP/F+CAmiwAWqK7VtHwpqpIZ5Pp4ElZ7PeLUX7KfEUhod/9zZtOWDpIbKC
	 37P56UFs17wHmDiQCzZohlBhV6z0vVdoGITNm4QvB8fA6DjVjNCQ0xmzPz4BB4YE1Q
	 Iw4F7X0x8reitRBx62jZ5HjR/gzB+/YetjbYVD272VESg3AjPIP3LQ/5zCPDpZIuky
	 LYbsSAynubOvQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v5 3/8] selftests/bpf: factor the
 permissive-mode skip suffix into a helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykola Lysenko" <nickolay.lysenko@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260804170156.1709916-4-nickolay.lysenko@gmail.com>
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
 <20260804170156.1709916-4-nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 17:21:08 +0000
Message-Id: <20260804172109.442151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing space in SKIP message output due to GNU Make's function arg=
ument whitespace stripping.
--

--- Patch [3]: [RFC PATCH bpf-next v5 3/8] selftests/bpf: factor the permis=
sive-mode skip suffix into a helper ---
commit 5a41b62fa6a5d8d794a18de41a7ff9bb6b7087f6
Author: Mykola Lysenko <nickolay.lysenko@gmail.com>

selftests/bpf: factor the permissive-mode skip suffix into a helper

This commit factors out the duplicated skip logic used for permissive builds
into a common skip_on_fail macro in the Makefile.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -49,6 +49,14 @@ SKIP_CRYPTO	?=3D
>  BPF_STRICT_BUILD ?=3D 1
>  PERMISSIVE :=3D $(filter 0,$(BPF_STRICT_BUILD))
> =20
> +# Permissive-mode recipe suffix: on failure, remove the target, emit a
> +# SKIP marker and report success so the rest of the build continues.
> +# $(1) - SKIP tag (BPF, TEST, BENCH, SKEL, LINK, ...)
> +# $(2) - optional extra files to remove alongside the target
> +# $(3) - optional note appended to the SKIP message
> +skip_on_fail =3D $(if $(PERMISSIVE),|| { $(RM) $@ $(2); \
> +	printf '  %-12s %s\n' 'SKIP-$(1)' '$(notdir $@)$(if $(3), $(3))' 1>&2; =
})

[Severity: Low]
Will GNU Make strip the leading space before $(3) in this if statement?

Since Make strips leading whitespace after commas in function arguments, it
appears the optional note gets appended directly to the target name without
any separation space.

[ ... ]

> @@ -1012,8 +1002,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
>  		 $(OUTPUT)/usdt_2.o \
>  		 #
>  	$(call msg,BINARY,,$@)
> -	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@ $(i=
f $(PERMISSIVE),|| \
> -		($(RM) $@; printf '  %-12s %s\n' 'SKIP-LINK' '$(notdir $@) (some bench=
marks may have been skipped)' 1>&2))
> +	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@ $(c=
all skip_on_fail,LINK,,(some benchmarks may have been skipped))

[Severity: Low]
Because of the stripped whitespace mentioned above, will the console output
for this rule now print as "bench(some benchmarks may have been skipped)"
instead of "bench (some benchmarks may have been skipped)"?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804170156.1709=
916-1-nickolay.lysenko@gmail.com?part=3D3
