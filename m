Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDB04EDCD6;
	Mon, 28 Sep 2026 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613084; cv=none; b=nADBBM287AV066SOCnbO4fzQquzHSXwixoegjJeMEofmTe1VYAzanjcgxlCns8ZEZdJy3PYBVJodaz3JOtoqZOZMcAiGFsF1qLR3Qb9CN+/HoNGlusNCCoBYHELDiS8LOyUr5nZSmvvxpcqYvaGymLFUQa38yd2Vyz4oiLRxmts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613084; c=relaxed/simple;
	bh=qPBI/zh+Lgn2YvS8JOKlw5PHw0KtSgSTml6EMkj5BYw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TlFpGPfkiM55Hbd2D3BrSXzggdxSFm50uu09s8smSy5qp5bXZRWE5ag282t5P3hLIoHwlof4N0JbzhJz1h14WfiDC4MP0Y5v0NwfOEGuiemLbV5knnZBNlhsLE/3cp95nNjKZ2RRDiYLqVrUxRGzTl3vWklKCiJEomMsPxQNUiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRuSkJvi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRuSkJvi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C711F000FF;
	Mon, 28 Sep 2026 16:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613083;
	bh=EnF1lpL8yOAVbciKvQW9ui5UiqpwepMChIPZqx1gRuM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IRuSkJvi7ERiOqzVWjSyCEYf/Y3fU2wxA8HSAlOJeLzpvLiMiLQz6WqeeV6/iqh/3
	 K81zJGtHSru8y3T0VPdTZN//WVr2UP59X1HbCpDsPv7JRIZHZIumOetrnGFI2SeYdA
	 tRYXuOOoMCpPwpsZbNwqTT80Ohq4RmMpvgIgQZE1Hrx4b3suEX6sXahcM27rnfJC43
	 HBpiplZ14fI6+TJpcp2d59zYMCI4nqf++Bddnv/2+C8hIQQ4F7LaRwQYWB20qCWP31
	 Sq9pDWwTyGLiRA/ia6ov7KcRT5qlUJ+hHzFZDX6+DItsGp9b5j/+9S+p0a86lw0yFb
	 STTXG75+jNG7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH DO NOT MERGE 6/6] arm64: dts: broadcom: Add Raspberry Pi
 ILI9881C DSI panel overlays
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxime Ripard" <mripard@kernel.org>
Cc: bpf@vger.kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260928-drm-mipi-dsi-panel-ebpf-v1-6-5244926aace4@kernel.org>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <20260928-drm-mipi-dsi-panel-ebpf-v1-6-5244926aace4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:31:22 +0000
Message-Id: <20260928163123.04C711F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt: node names use underscores instead of hyphens
--

commit 13a81e24cfdf82fcd1a6606b31ae481417af3552
Author: Maxime Ripard <mripard@kernel.org>

arm64: dts: broadcom: Add Raspberry Pi ILI9881C DSI panel overlays

This commit adds device tree overlays for the Raspberry Pi 5-inch and
7-inch MIPI-DSI panels on the Raspberry Pi 4 Model B. It introduces a
shared dtsi for the common display MCU and backlight components.

> diff --git a/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b-dsi-ili9881.dts=
i b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b-dsi-ili9881.dtsi
> new file mode 100644
> index 0000000000000..bd08e22581a31
> --- /dev/null
> +++ b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b-dsi-ili9881.dtsi

[ ... ]

> +&{/} {
> +	panel_backlight: panel_backlight {

[Severity: Low]
Should this node name use hyphens instead of underscores, such as
panel-backlight? Devicetree naming conventions generally prefer hyphens,
and using underscores here triggers node_name_chars_strict warnings when
building the device trees with standard strict dtc checks enabled.

> +		compatible =3D "pwm-backlight";
> +		brightness-levels =3D <0 31>;

[ ... ]

> +&i2c0_1 {
> +	status =3D "okay";
> +
> +	display_mcu: display_mcu@45 {

[Severity: Low]
Similarly, could this node be named display-mcu@45 instead? Replacing the
underscore with a hyphen avoids dtc compiler warnings for invalid node
name characters.

> +		compatible =3D "raspberrypi,touchscreen-panel-regulator-v2";
> +		reg =3D <0x45>;
> +		gpio-controller;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-drm-mipi-d=
si-panel-ebpf-v1-0-5244926aace4@kernel.org?part=3D6
