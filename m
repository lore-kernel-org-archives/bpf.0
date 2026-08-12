Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566873112A5
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538119; cv=none; b=plotSo1VlOnic8eoUY/hKh7WTERAdlz+ph9ToSKyqBx2M3239FnUP0TBoubqMbLg0EqIntMazpjiFignH+00QdcjKWjd5yTm6+b103AKPpI9tkdz9odl7mVbeGtoe4c/uvOUKU/nM0ZVRzihe4BUnmyJppt0/E2NYD49phttxnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538119; c=relaxed/simple;
	bh=aqn+lHEmhjYi9FIvLJoeBwHbK4BWFK11Coz21GNmB7M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MS3wCamiyQZ+Iz4IbD9Eriobwp6ImzNyDu7NhQrkXYNC1p06VTR6jxpCo+cKOxX4E6ixY2XWZ5dutvSVeNzzbeAyKJ1/vnJZKEVk7cRpQ46kfQRY5bn92xKcjZZ452680A4yFCBGL4qC56KY5/h6bEfge4gqssS5a6z59wppV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mU/ZwNV4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mU/ZwNV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1411F000E9;
	Wed, 12 Aug 2026 12:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786538118;
	bh=qIv6n+/MAy99SEW50tzSxyCWYnqiKwvv3/DWLbochC0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mU/ZwNV44bfD7MKNo2RC4J2Ltu6O8p1b9sAkITirffZoVXBo9Q/NARVr9jzryEwcw
	 PKe9bCYfjBIzffiQTA6W/YEM5cShwYOOc1KTKH6456UERamU2TEo1GhtmGCDuDW1FE
	 MVsRXGOjd2b0q0Yxw48I+cveQD5j319Z7VNdfI82FGU3alrX0Viyy6+PCD7+41vgmP
	 Mr8l6PaJcymta2aWcJ4d9tJD9qaoxXN68tIvkb0VIEPWTUrLbb+EfEDZHuxNM43ITb
	 y5fxINdDN/H97XqF4FHmfNx6QSrmuLn6R70S7nT4NmHvO2SBUhlW4pWCdqMx4MQiNo
	 MIo3PnfgWMy8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] Docs: changes.rst: rename file and references and
  add links
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manuel Ebner" <manuelebnerli@mailbox.org>
Cc: bpf@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260812121603.1633270-2-manuelebnerli@mailbox.org>
References: <20260812120805.1631430-3-manuelebnerli@mailbox.org>
 <20260812121603.1633270-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 12:35:17 +0000
Message-Id: <20260812123517.CD1411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Newly created symlinks point to absolute paths specific to the auth=
or's local machine instead of relative paths.
- [Low] Sphinx :ref: targets were renamed in referencing files, but the cor=
responding anchor labels in the target documents were not updated, which br=
eaks the documentation build.
--

--- Patch [1]: [PATCH 1/5] Docs: changes.rst: rename file and references an=
d  add links ---
commit c768ca54c0ac770b2315f64aa918063f10522512
Author: Manuel Ebner <manuelebnerli@mailbox.org>

Docs: changes.rst: rename file and references and add links

This commit renames changes.rst to software-requirements.rst to better refl=
ect
its content. It updates references in documentation, translations, and scri=
pts,
and sets up symlinks for backward compatibility.

> diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-g=
uide/README.rst
> index 77fec1de6dc86..9d1e1938b23d0 100644
> --- a/Documentation/admin-guide/README.rst
> +++ b/Documentation/admin-guide/README.rst
> @@ -52,7 +52,7 @@ Documentation
>   - There are various README files in the Documentation/ subdirectory:
>     these typically contain kernel-specific installation notes for some
>     drivers for example. Please read the
> -   :ref:`Documentation/process/changes.rst <changes>` file, as it
> +   :ref:`Documentation/process/software-requirements.rst <software-requi=
rements>` file, as it
                                                              ^^^^^^^^^^^^^=
^^^^^^^^

[Severity: Low]
Does this update break the documentation build? The target document still u=
ses
the legacy label .. _changes: instead of .. _software-requirements: .

[ ... ]

> diff --git a/Documentation/process/changes.rst b/Documentation/process/ch=
anges.rst
> new file mode 120000
> index 0000000000000..ef3fa664d434d
> --- /dev/null
> +++ b/Documentation/process/changes.rst
> @@ -0,0 +1 @@
> +/home/manuel/linux/Documentation/process/software-requirements.rst
\ No newline at end of file

[Severity: Low]
Does this symlink point to an absolute path on your local machine? This will
be broken for anyone checking out the repository since the path will not ex=
ist
on their system. Should this be a relative path instead?

[ ... ]

> diff --git a/Documentation/process/software-requirements.rst b/Documentat=
ion/process/software-requirements.rst
> new file mode 100644
> index 0000000000000..1ca8c5f73ad00
> --- /dev/null
> +++ b/Documentation/process/software-requirements.rst
> @@ -0,0 +1,575 @@
> +.. _changes:
    ^^^^^^^^^^

[Severity: Low]
Should this anchor label be updated to .. _software-requirements: so the new
references can find it?

[ ... ]

> diff --git a/Documentation/translations/it_IT/process/changes.rst b/Docum=
entation/translations/it_IT/process/changes.rst
> new file mode 120000
> index 0000000000000..d949784418927
> --- /dev/null
> +++ b/Documentation/translations/it_IT/process/changes.rst
> @@ -0,0 +1 @@
> +/home/manuel/linux/Documentation/translations/it_IT/process/software-req=
uirements.rst
\ No newline at end of file

[Severity: Low]
Are there multiple absolute symlinks here? This also points to a local path
that will fail for other users.

[ ... ]

> diff --git a/Documentation/translations/it_IT/process/howto.rst b/Documen=
tation/translations/it_IT/process/howto.rst
> index f51288602ee3d..37ca98764932f 100644
> --- a/Documentation/translations/it_IT/process/howto.rst
> +++ b/Documentation/translations/it_IT/process/howto.rst
> @@ -96,7 +96,7 @@ Di seguito una lista di file che sono presenti nei sorg=
ente del kernel e che
>      minimo necessario per configurare e generare il kernel. I novizi
>      del kernel dovrebbero iniziare da qui.
> =20
> -  :ref:`Documentation/translations/it_IT/process/changes.rst <it_changes=
>`
> +  :ref:`Documentation/translations/it_IT/process/software-requirements.r=
st <itsoftware-requirements>`

[Severity: Low]
This link is updated to use the <itsoftware-requirements> label, but the
target document still defines .. _it_changes: . Will this cause a Sphinx
reference error during the documentation build?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812120805.1631=
430-3-manuelebnerli@mailbox.org?part=3D1
