Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D54322B7D
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974110; cv=none; b=rJWJHST/NID109ZSDtNSw+WoQNkXiPpDD8toQT0NJwf8n3u0mq6Flqh0tchVAahekgn9P7PSkAXLRK5ImcjvG5QEGAm6qSePIhGr9iVV+q+pG5WKwpR1OaHEWYR5rZEfRMawcvYUYKzkNV4dtmTf7Qng7zq4Etv4pnoMmSmy1ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974110; c=relaxed/simple;
	bh=K16Ya1BsnAqC71vv+OoNGhnanF83nNwQfw6RlRanbno=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rkWNe27dqGIB09KryYrZT/Lm/ojweQpjA/jT/tGfsuD+yoEg8zl/L9vHlUMNuRw/wvXv8tOqgYypMcrBJ5ZbWfVulct+3mF0C7SnJPcTwJCQrKastZ2JbMcUUK0yqGg2gU+LYBQQO9GT0NRIpKUoCbeenMJRA3YqmtVmGVFz/FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIKTwsQd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIKTwsQd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54432C2BCB9;
	Tue,  5 May 2026 09:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777974110;
	bh=K16Ya1BsnAqC71vv+OoNGhnanF83nNwQfw6RlRanbno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KIKTwsQds8o/OVLAhTrk4nJrNIAprK76Ja5RHDBjpgSWj4S61JIw4sTfB9EoR+zh6
	 KXP0GxqL0aUwEaVISEhbRgoriCT5sv/B89MBC7hQpdCJHWy3K+lSLAht16ZZXquOzs
	 BpxXT595AVGxhidueC86vuPdhTQ599cCRpjv6MCjSQowb74GCOlPs2rqPh++pCEbue
	 LAYp7BTlQrmMLsSCTP39jF3BLTz5ZExtAFnhlW1hFgW/V/hMTvvSWBApugihFIjR5Y
	 U7n/LxFrmUPtmoFvwcBrP1qap6x7+v8LwVg1Z0x2z7Pfu32W0UZ2M32QlGlyvfx1rk
	 gMotmTX26YX4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/14] module: update timestamp of modules.order
 after modules are built
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505-module-hashes-v5-11-e174a5a49fce@weissschuh.net>
References: <20260505-module-hashes-v5-11-e174a5a49fce@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 09:41:49 +0000
Message-Id: <20260505094150.54432C2BCB9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Touching `modules.order` in `Makefile.modfinal` causes unnecessary=
 rebuilds of `Module.symvers` on subsequent `make` invocations.
--

commit c15348209a95736a85efe8f0905f610fb5def492
Author: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

module: update timestamp of modules.order after modules are built

This commit ensures modules.order is always newer than the module .ko files
by touching it after modules are built, allowing other rules to use it as a
prerequisite.

> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index b09040ccddd2b..44a382689a5aa 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -66,6 +66,13 @@ endif
> =20
>  targets +=3D $(modules:%.o=3D%.ko) $(modules:%.o=3D%.mod.o) .module-comm=
on.o
> =20
> +# Update modules.order when a module is (re-)built.
> +# Allow using it as target dependency.
> +targets +=3D modules.order
> +__modfinal: modules.order
> +modules.order: $(modules:%.o=3D%.ko)
> +	@touch $@

Does this cause an unnecessary rebuild of Module.symvers on subsequent make
invocations?

In scripts/Makefile.modpost, Module.symvers depends on modules.order. During
a build, Makefile.modpost is executed strictly before Makefile.modfinal.=20

When a module is rebuilt, touching modules.order here updates its modificat=
ion
time to be newer than the previously generated Module.symvers. On the next
make invocation, even without source changes, Makefile.modpost will see
modules.order as newer than Module.symvers.

Will this trigger modpost to execute unnecessarily, degrading incremental
build performance by forcing an extra settling build to reach a clean state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505-module-has=
hes-v5-0-e174a5a49fce@weissschuh.net?part=3D11
