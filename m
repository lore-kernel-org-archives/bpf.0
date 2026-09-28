Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A814EDCD6;
	Mon, 28 Sep 2026 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613077; cv=none; b=RnDT6/ABFIbsLIged8BPjlLzwaq3Rv00U7czz9QSQsjf36A3USaCLgrocvSqCoAWt88P3cFI7j/Ra93K/C2P3AbH5RqfxLebJo3bZsQarbJCBEAyh92D9R5VsOgrLUDBB4h1jRqoDVnXVe9V7Ugbu0nNk8BP7Gq++HzUMgJmCIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613077; c=relaxed/simple;
	bh=jxr4W06vcfBL19u+U8WQUniKMdmeStDAti5e3Y5oKXQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EiTiVvKd9IjDEDZATZIrYM0g4CJcQJDurEfQRMzvc1Hj/+YaBMTrjftqpTyqkftUFAJweQjSX9PNkaLTztxD6HYFTJaiycpSkLRV6AQZ5fWmc/0x0HcJ6v49KvyJU4GdHlFiRTT0MqWfUo1FGYYY7jvzEbW0S1TAFMSy4sLUJr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEnwEpkb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEnwEpkb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFACC1F000FF;
	Mon, 28 Sep 2026 16:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613076;
	bh=b9+3FkzlI/wIWQJcNTEFtgC0MrVxpEcwVbCYCmj7aIE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lEnwEpkbgMvdLF3/EK74V3v15X6gXZIi+Zf856Yrs47RwjjuSgxlT+E79RS2BbbK3
	 OILcuPuOCbulZMrVj6umC8YLlyUl2IrsnC01NNU/BSNT+MupLcZLKylkPysghNsTh7
	 J4Xp8qB6s2yB0mfvUYvy+sVN+ZFIy7+V8j34TgLy1CsYDPmoxhxMfKfYcvgPAhNG1U
	 wBQGm+mULAgCgqdwVhNez4ImjCTdXPqUlnuTrQ6XPza2V2XHXwnWj+T10eivUr3tBo
	 P9pNc3qJ5mbwE7QSZSsjt29Znf+xcrGvUYGCtCuHVXRDaukhBGMVeKEw8NAkCpHGcM
	 zFM9DN4O7IjLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] drm/panel: dsi-bpf: Add BPF program build
 infrastructure and helper header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, devicetree@vger.kernel.org, bpf@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260928-drm-mipi-dsi-panel-ebpf-v1-3-5244926aace4@kernel.org>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <20260928-drm-mipi-dsi-panel-ebpf-v1-3-5244926aace4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:31:15 +0000
Message-Id: <20260928163115.AFACC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/panel: dsi-bpf: panel_bpf_mipi_dsi_dcs_write_byte macro prev=
ents error handling
- [Low] build: Makefile misses vmlinux.h in clean target and uses undefined=
 variable
--

commit 94b9d5177a6ef3a698ad45fa764e652b0d0dbae4
Author: Maxime Ripard <mripard@kernel.org>

drm/panel: dsi-bpf: Add BPF program build infrastructure and helper header

Add the BPF-side header panel-bpf-mipi-dsi.h and a standalone
Makefile for building panel BPF programs. The header provides
section name macros (PANEL_BPF_MIPI_DSI_PREPARE, etc.), the
PANEL_BPF_MIPI_DSI_OPS() struct_ops declaration macro, extern
declarations for all the kfuncs, and some convenience macros.

> diff --git a/drivers/gpu/drm/panel/bpf/progs/Makefile b/drivers/gpu/drm/p=
anel/bpf/progs/Makefile
> new file mode 100644
> index 0000000000000..74190ee618abd
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/bpf/progs/Makefile
[ ... ]
> +clean:
> +	$(call msg,CLEAN)
> +	$(Q)rm -rf $(OUTPUT) $(TARGETS)

[Severity: Low]
Will this clean target leave a dirty working tree? The generated vmlinux.h
artifact is not removed when executing make clean.

> +
> +%.bpf.o: %.bpf.c vmlinux.h $(BPFOBJ) | $(OUTPUT)
> +	$(call msg,BPF,$@)
> +	$(Q)$(CLANG) -g -O2 --target=3Dbpf -Wall -Werror $(INCLUDES)		\
> +		     -Wno-microsoft-anon-tag					\
> +		     -fms-extensions						\
> +		     -c $(filter %.c,$^) -o $@ &&				\
> +	$(LLVM_STRIP) -g $@
> +
> +vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)

[Severity: Low]
Is the INCLUDE_DIR order-only dependency defined? It appears to resolve to
an empty string since it is not defined in this Makefile.

[ ... ]
> diff --git a/drivers/gpu/drm/panel/bpf/progs/panel-bpf-mipi-dsi.h b/drive=
rs/gpu/drm/panel/bpf/progs/panel-bpf-mipi-dsi.h
> new file mode 100644
> index 0000000000000..e2b03afef2c8c
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/bpf/progs/panel-bpf-mipi-dsi.h
[ ... ]
> +/* Send a DCS command with a single byte payload. */
> +#define panel_bpf_mipi_dsi_dcs_write_byte(ctx, cmd, val)		\
> +	do {								\
> +		const __u8 _v =3D (val);					\
> +		panel_bpf_mipi_dsi_dcs_write((ctx), (cmd), &_v, 1);	\
> +	} while (0)

[Severity: Medium]
Could the panel_bpf_mipi_dsi_dcs_write_byte macro prevent callers from
checking for and handling DSI transmission errors?

By wrapping panel_bpf_mipi_dsi_dcs_write in a do-while loop, the integer
return value is dropped. This causes initialization routines to blindly pro=
ceed
even if the panel is detached or unresponsive, as BPF programs invoking this
macro cannot assign or evaluate its result.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-drm-mipi-d=
si-panel-ebpf-v1-0-5244926aace4@kernel.org?part=3D3
