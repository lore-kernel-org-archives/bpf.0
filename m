Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D42547255F
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656666; cv=none; b=gMyB7f71kN29+a6B39HPCJC5YCtpIqfYg5YkBABpQvJLdM34Ht/HJe2wKXY7gpG5uO84ZghPaR4X3hQOxFItwVcV0Bu/+gA+5rzA25BsQFwtX1XALr4x0fj4HC3kyvkt5dSBup4zlFc4zyxIlwisUk1qdUM36eNA11STZV7wovM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656666; c=relaxed/simple;
	bh=lLCON9pRg1cyeY7neNjdke2EpEJX9e3Kc4a2t7DUMHY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZyNf/Tu4V2XhrC6uC9q0RPsPZwPBO4sonFhgTpdrU2zuijyyytGVzDMZdjuoHXoHvvAEOYmVvFIQzCntzY7VL2yezcwbrfp3i7g9RJhLQUGj87RtxDxjbacHEvtsRlTSIapTOJP66YtB61pQwLNxWRUiTkU55+btVSP88g0c4J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esUYVib5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esUYVib5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228B91F000E9;
	Tue, 21 Jul 2026 17:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784656665;
	bh=LjuEHzgu9y9tx4Y+FZ+Bs2TFSRPuu/lyufmsBM4FGag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=esUYVib5Xih+5HNalU+7Mg6Sd/IlzH7x2DaFjWoA8ctyOnpk2D1vFHvaVZPScgPLm
	 SWfJQhVrbymH4JR1Tt9sBE7nZXt+dtL7Fjq+TffaZNzSg4nBZDUMoeRZbMEKb3lgwf
	 xAFt88IsDb0r7Mx49F4CpXVcaOVE22aV5QxAcx5qesC/miZ/fH/ApBal/aR1FBlHYG
	 salwaJnZwgiDECdf3k+YNVG6OEa5/KHIFEYqyQh8Db5gg7rrIj0msO98CCqPjuOVvO
	 2taCp4QQCPtMVgE8XY8hkFJMpdyfJ9HHwmmkYWeB/1+EQhq+nJ9ovLvkjPLJeQEN5D
	 iCVB38nnm67BQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 1/3] selftests/bpf: extract BPF skeleton
 generation into a helper script
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykola Lysenko" <nickolay.lysenko@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260721174909.8044-2-nickolay.lysenko@gmail.com>
References: <20260721174909.8044-1-nickolay.lysenko@gmail.com>
 <20260721174909.8044-2-nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:57:44 +0000
Message-Id: <20260721175745.228B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly extracted `gen_bpf_skel.sh` script is not listed as a pre=
requisite for the skeleton header targets.
--

--- Patch [1]: [RFC PATCH bpf-next 1/3] selftests/bpf: extract BPF skeleton=
 generation into a helper script ---
commit 4513e1c5bea1eb3326128c6ae08f7e1f230247fb
Author: Mykola Lysenko <nickolay.lysenko@gmail.com>

selftests/bpf: extract BPF skeleton generation into a helper script

This commit extracts the duplicate skeleton generation pipeline from the
Makefile into a standalone shell script. This simplifies the rules by
replacing them with calls to gen_bpf_skel.sh using different flags.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index b642ee489ea64..e3a27403cd481 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
[ ... ]
> @@ -631,81 +631,38 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
>  					  $$($$<-$2-CFLAGS),$(TRUNNER_BINARY))
> =20
>  $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
[ ... ]
> +	$(Q)BPFTOOL=3D$$(BPFTOOL) ./gen_bpf_skel.sh --tag '$(TRUNNER_BINARY)'	\

[Severity: Low]
Should gen_bpf_skel.sh be added as a prerequisite for $(TRUNNER_BPF_SKELS)
and the other skeleton targets?

Without the script in the dependencies list, modifying the script itself
won't trigger a rebuild of the existing .skel.h and .lskel.h files.
This could lead to stale builds during development if the script's logic
is updated.

> +		--name $$(notdir $$(<:.bpf.o=3D)) --infix linked			\
> +		--skel $$@ --subskel $$(@:.skel.h=3D.subskel.h) $$< $(if $(PERMISSIVE)=
,|| { \
> +		$$(RM) $$@ $$(@:.skel.h=3D.subskel.h);				\
> +		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; })
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721174909.8044=
-1-nickolay.lysenko@gmail.com?part=3D1
