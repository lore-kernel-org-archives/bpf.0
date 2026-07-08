Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E896A3DA7C5
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783543318; cv=none; b=pHGzulSD+ShUupmkaFhGUbIZKrKZd93HIJQ2wcEndpZ4RlhGFcJDhz6GI5xoSIzO8XQOqHDImORRl5Asl7stgwH2dp5eFvxg8m4wmbYDYTegYOULhOuTCCpI3IfpuWRODAe5MxDu4KQRn3pP/EFo/+0cgMnqWZfb50ObPa5g9k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783543318; c=relaxed/simple;
	bh=G/QbEyIfvrqYvO7Tvun8/+SwyD6j0/2TwGaQ7Lw/pgU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VVyyxNbxTfIF0O2QrpKuPQIz8tiJvmjI6Mgqu1qUBUQLpl3Gd1+n/0gPuCSPS+SDfIM9T6FgklwaN+PrHOJKCiKOC5UUtqxt3UL0c+IIuAnJIxB8XR3h8rM2s+Aa+Jv8yXJkID9W14RyGGdeanVFyA7FgdiBKD+j79EtrRKac3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8h9yV/A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8h9yV/A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659C11F000E9;
	Wed,  8 Jul 2026 20:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783543316;
	bh=xTM2gY0p4yzybiVkkK89471eKxk7xEH2aHHkUnInQwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G8h9yV/AAfsR+xxawsORtaKbgar0yC18Vrv18QQWIYAja6HuZit+J3Q8Q3etPCAt1
	 QPB8gJVYxY2inzwL29gMyNpmjUZKIgghH9OnZbE4OmM0RWIHGQayfl4kY2Z3wZJFkY
	 8/rg8swxG2bO2Knusmhxm/Q8DpohTX29qi3cib2ZvUGUMC1vHRii/CxcuUpr9RNXDn
	 kXFU+/JU4OESNLRWaeaIGaBZIcgJJxwenZ97V1IweB4a1JEP8+lgaTInnfc2ny6gVh
	 SomrjJH6b30ZNuJ4UCoMaF/X2L3cxkpnWWZWRm3xIqVaxqZAei3CESsflZ8O7HsxeR
	 9XuXNTGDIBZZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 6/6] selftests: drv-net: add XDP RX checksum
 metadata tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Vdovin" <deliran@verdict.gg>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708203410.45121-7-deliran@verdict.gg>
References: <20260708203410.45121-1-deliran@verdict.gg>
 <20260708203410.45121-7-deliran@verdict.gg>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 20:41:55 +0000
Message-Id: <20260708204156.659C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comments in BPF code use the incorrect style (text on th=
e same line as the opening `/*`).
--

--- Patch [6]: [PATCH bpf-next v4 6/6] selftests: drv-net: add XDP RX check=
sum metadata tests ---
commit 534009eb94d734041b26454f61107825d2b5f78e
Author: Vladimir Vdovin <deliran@verdict.gg>

selftests: drv-net: add XDP RX checksum metadata tests

This commit extends the xdp_metadata.py driver test with coverage for
bpf_xdp_metadata_rx_checksum(). It adds an xdp_rx_csum program to read
the RX checksum verdict and tests both valid and invalid RX checksum
scenarios on supported devices.

> diff --git a/tools/testing/selftests/net/lib/xdp_metadata.bpf.c b/tools/t=
esting/selftests/net/lib/xdp_metadata.bpf.c
> index f71f59215239f..70decae0a6637 100644
> --- a/tools/testing/selftests/net/lib/xdp_metadata.bpf.c
> +++ b/tools/testing/selftests/net/lib/xdp_metadata.bpf.c
[ ... ]
> @@ -40,6 +41,24 @@ struct {
>  	__uint(max_entries, 4);
>  } map_rss SEC(".maps");
> =20
> +/* RX checksum results: key 0 =3D ip_summed bitmask, key 1 =3D hw cksum =
value,
> + * key 2 =3D cksum level, key 3 =3D packet count, key 4 =3D error count.
> + */

[Severity: Low]
This isn't a bug, but the modern BPF multi-line comment style requires
the opening /* to be on its own line. Could this be updated so the text
starts on the next line?

> +enum {
> +	CSUM_KEY_IP_SUMMED =3D 0,
> +	CSUM_KEY_CKSUM =3D 1,
[ ... ]
> @@ -55,8 +74,20 @@ enum xdp_rss_hash_type {
>  	XDP_RSS_L4_ICMP =3D 1U << 8,
>  };
> =20
> +/* Mirror of enum xdp_checksum from include/net/xdp.h.
> + * Needed because the enum is not part of UAPI headers.
> + */

[Severity: Low]
This isn't a bug, but this multi-line comment also has text on the same
line as the opening /*. Could this follow the preferred BPF multi-line
comment style?

> +enum xdp_checksum {
> +	XDP_CHECKSUM_NONE =3D 1U << 0,
> +	XDP_CHECKSUM_UNNECESSARY =3D 1U << 1,
[ ... ]
> @@ -78,41 +109,39 @@ static __always_inline __u16 get_dest_port(void *l4,=
 void *data_end,
>  	return 0;
>  }
> =20
> -SEC("xdp")
> -int xdp_rss_hash(struct xdp_md *ctx)
> +/* Return true when the packet matches the L4 protocol and destination
> + * port configured in map_xdp_setup (zero/unset filters match anything).
> + */

[Severity: Low]
This isn't a bug, but the opening /* should be on its own line here as well
to match the preferred BPF comment style.

> +static __always_inline bool xdp_match_setup(struct xdp_md *ctx)
>  {
>  	void *data_end =3D (void *)(long)ctx->data_end;
>  	void *data =3D (void *)(long)ctx->data;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708203410.4512=
1-1-deliran@verdict.gg?part=3D6
