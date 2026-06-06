Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D1C12FF69;
	Sat,  6 Jun 2026 01:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780707685; cv=none; b=tyTxhSlIXM5gpWZOpLEXtgdDboVARf9CwCsxISYF1OnIPvWsORAYnboJERV7jy9rOIsvm3Z9TW96A+uhfAGpXfFo6FRKev/h5MaHL/jmaehDx+BYLVtO49E8pjAFHZyuvdCF0hW4cDGxjIZZhZTPeld7J1Y8oKsXmWpcY0SVUt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780707685; c=relaxed/simple;
	bh=U8hghVSpcja56ghpE7q84MFVd6oP5O+PNH9aanVuZEY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dck2HnxV29cGVKncp+/fwDCDON8zZc+to8VJYHRlygdrBCNrWO60RtzC1OyryX8LkHRzn2hxrbP0QhNdMNFHqwWNK8WhF9+h3W5DAthCdBH3vyPhgtxK8OssGEezo02LPwqD4EM7YjSuGLG0EYIqv5K+XRJ9ZyYnBfLa0GtWVPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lv5+4M19; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lv5+4M19"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590881F00893;
	Sat,  6 Jun 2026 01:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780707680;
	bh=+Nt6l01toDGWdcFulXmhiFjmSN1rUVnk9yeA9v8ncaU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lv5+4M19w+VXoQ+ZP/H++Zn9NWLpsWLSRdFU9Ou3p6HJ0wfSPRBF9P/ZUUi6BodYp
	 sKkLo05g056aeDNiwSnVkK28OsMvKqfico45ttP+quJaeaBO3xBX7LB0D2XoTl4K6S
	 w4E0gkVhrtpq86PeeT69uMcPHpFykHVx4VywLDYW0PKB4FWweX9EPtieWc06VBPOkX
	 1kwP4ZvYyyNyM0OVRLbJDtQBvIYfNzJZwsVHK8Q1kMAMjScI+LDwtFeGv2D7mG6pK/
	 EeYhNhbOJoU5Zfzn6pdRCcXT77ntdf+Us6+3sSmjq/h7hXuZAbIccWZMt2jCn7jihg
	 GVT8cY5OD+jAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 01/14] dt-bindings: net: qca,qca808x: Add
 regulator properties
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, bpf@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260605010022.968612-2-elder@riscstar.com>
References: <20260605010022.968612-2-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 01:01:19 +0000
Message-Id: <20260606010120.590881F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The device tree example incorrectly assigns a 1.8V regulator phandl=
e to a 1.05V supply property.
--

commit 9408235f22241ddbd72a22ee2611a98eece3d7f2
Author: Daniel Thompson <daniel@riscstar.com>

dt-bindings: net: qca,qca808x: Add regulator properties

This commit adds four power rail supply properties (avdd18, vdd, vdd18, and=
=20
vdd125) to the QCA808x ethernet PHY device tree binding. It also updates th=
e=20
example section to demonstrate how to configure the power supplies.

> diff --git a/Documentation/devicetree/bindings/net/qca,qca808x.yaml b/Doc=
umentation/devicetree/bindings/net/qca,qca808x.yaml
> index e2552655902a3..3c1b7eca33caf 100644
> --- a/Documentation/devicetree/bindings/net/qca,qca808x.yaml
> +++ b/Documentation/devicetree/bindings/net/qca,qca808x.yaml
[ ... ]
> @@ -25,6 +25,18 @@ properties:
>      enum:
>        - ethernet-phy-id004d.d101
> =20
> +  avdd18-supply:
> +    description: 1.8v analog power supply.
> +
> +  vdd-supply:
> +    description: 1.05v power supply.
> +
[ ... ]
> @@ -39,6 +51,8 @@ examples:
>              compatible =3D "ethernet-phy-id004d.d101";
>              reg =3D <0>;
> =20
> +            vdd-supply =3D <&phy_vreg_1v8>;
> +

[Severity: Low]
Is this the intended phandle for the vdd-supply property in this example?

The property description defines vdd-supply as a 1.05v power supply, but the
example assigns what appears to be a 1.8v regulator (&phy_vreg_1v8) to it.
Could this discrepancy lead developers to copy-paste an overvoltage
configuration into their actual board device trees?

>              leds {
>                  #address-cells =3D <1>;
>                  #size-cells =3D <0>;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605010022.9686=
12-1-elder@riscstar.com?part=3D1
