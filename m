Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DFC320CAD
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376449; cv=none; b=EJfZkfouRGlBlF/Ab5Ckpd+0HC2EGr8ncVMPhUD6o+7efnc/MjyNcflRo/XiTxjJdyaeg9GuQY2KZaulVHVBhRa8J/rGh7K8isWLF6ZdoU75f99a6O7hfgbwzoqvUWeu8VcBwrTHUnXulWyRYjziw1aZaiM+SgKMk/M12n+D4B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376449; c=relaxed/simple;
	bh=y32g1BFOEQwZwA+ylYrbONZoJwvSeXbrNljlyTloAw8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QtKqNlUTYwwwttMjPaT09aNkYQtXHl9txy6dNAWIu8+UnyRxoahoTbnx1kr/i36J3Ytv/twlI2IlRo0DwtkUIVdKgnSmmdmNfbL8fFccQvwPMFgT9vxY7mPq3fyYdkDQKNl/nrAOXIrgFnT81+z9i6Lr/IeygmPrzt4ydVT7BU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsszzSON; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsszzSON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BA21F000E9;
	Thu, 21 May 2026 15:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779376447;
	bh=COtL2M8oafcLaSKNkpy/CfCgk/6xX/u27WXQsHJPJ7E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KsszzSONdE69CaLl2Hfb0qEC3mOwctlIXlNIZRvTI3dhS0GEiLozprlJSSy5q5acn
	 dR7nER8EHL7trKE2oFcx0I3XSWcI8y8yKheJSCJ968WzeiUHXFYfd/WZOUUB3irQFw
	 1KnsmjTgPnZJINCQHcMzl5qjTXNGY6gr5OBp+35oY0b/KmXSE92bo3OKl4bLPciGfm
	 5jsvZh5X1Mc3aHqWBT0xCukFw1mB7RS8D6ynXARzdmWuOMU7FHKMk8GZBWfiFEqMXL
	 XaCYCDqqvWsx+HdpfzmFosc0Ueq209ouKdurtWhhcrUktMryx7xjao4gpeNcJL/u8y
	 hssEGaLde/JcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 16/20] unwind_user/sframe: Add support for SFrame V3
 flexible FDEs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521142546.3908498-17-jremus@linux.ibm.com>
References: <20260521142546.3908498-17-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 15:14:06 +0000
Message-Id: <20260521151406.E1BA21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Mismatch between SFrame V3 flexible FDE control word specificati=
on in the commit message and the actual implementation.
- [Low] The patch uses undefined macros `SFRAME_REG_SP` and `SFRAME_REG_FP`=
 and includes a missing architecture header, breaking the build.
--

commit 82ce04f2a50a8ff116e0ca155714efff95332739
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/sframe: Add support for SFrame V3 flexible FDEs

This commit introduces support for SFrame V3 flexible FDEs, which encode CF=
A,
RA, and FP tracking information using FRE data words or padding words. It
adds logic to read flexible FDE control words and initialize the appropriate
CFA and rule data structures.

>     This enables the following flexible CFA and FP/RA recovery rules:
>     - CFA =3D register + offset       // reg_p=3D1, deref_p=3D0
>     - CFA =3D *(register + offset)    // reg_p=3D1, deref_p=3D1
>     - FP/RA =3D *(CFA + offset)       // reg_p=3D0, deref_p=3D0

[Severity: Medium]
Is this description in the commit message accurate?

The commit message states that the FP/RA rule uses reg_p=3D0, deref_p=3D0.
However, the implementation for this rule in __read_flex_fde_fre_datawords()
uses ra_ctl =3D 2, which corresponds to deref_p=3D1.=20

Also, the commit message later notes that reg_p=3D0 and deref_p=3D0 is actu=
ally
an invalid padding word.

Could the commit message be updated to match the code's behavior to avoid
confusing future maintainers debugging the SFrame unwinder?

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index daa97d8b02316..b623dca072daa 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c
> @@ -12,6 +12,7 @@
>  #include <linux/mm.h>
>  #include <linux/string_helpers.h>
>  #include <linux/sframe.h>
> +#include <asm/unwind_user_sframe.h>
>  #include <linux/unwind_user_types.h>

[Severity: Low]
Does this include break the build for intermediate commits?

This architecture header, along with the SFRAME_REG_SP and SFRAME_REG_FP
macros used later in this patch, do not appear to exist in the tree at this
commit.

Although this is fixed later in the patch series by the commit that enables
sframe unwinding on x86, missing headers and undefined macros break git
bisectability.=20

Should these definitions be introduced in an earlier patch or within this
one so that this patch compiles cleanly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521142546.3908=
498-1-jremus@linux.ibm.com?part=3D16
