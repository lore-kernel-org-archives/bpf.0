Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30ED3E0C47
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783543428; cv=none; b=oKpT4205MmZMShd+2uwEIZCijyas40p9W7e6zEcolrPJJDF5oe2VGero6PtmWZ5MzZsWAO/0IkmZByuaDwTILU1h2dKjBROG18PK3z9kuX3tCmvgF0h4Dy99JAO3mo2I61YzpU7HcL0R8llzf4cY/HuCLNOqY16BZe/DpaZnz4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783543428; c=relaxed/simple;
	bh=f4wIk/KVj0hy/aVjS1GvyXOpQmQGY94YdscJH7oMN/8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TAf9ghDD4f1xjzTMNQKgVhL/8clYQb6TdBmb1F122WdkGZzWz31+MWPscUZlFoo9N136IEnW78GyDipq+tDqACRfsZ0WaBE+xMVjrmpnEu4GZEYJh/DZv4VNQ4TS23tyQCySmBGJ2BtW+FzTRHpSV5r8WfC1mHO2LasQMJof/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRrUtH9f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRrUtH9f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8114D1F000E9;
	Wed,  8 Jul 2026 20:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783543422;
	bh=6+FaYTVrU2Gedte4rjP80WJT6OPk5XlnbdKjxlqIhTU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MRrUtH9fB7sRU3vMJFLMFIb8Yifqfjc1INh3LprkbAnJua9zLa5N/CoWkaNzrf58u
	 Z2hDoQZkXnuv4cb54uf/33AcZ1MgeJ/2t1s18UVgQQrxnKpnIzcV9oq71/ULQo+fVn
	 +nVEbqK4A3iK4QXjQD+vuRM049hHdCNVarnro3WZ13euzFkfmj1LZa7wLo23IGBzrd
	 rqVIUBC5j7SJPRw6NDQ6h0ZdLKpquGJaRexPW7o2i9YEjxfC7eLkU9ur2W+4w7KKqo
	 mzZwc3O3h4bjYTrIatzEV9PNuPJRfK83m55dEbBkAPxbMPE8s6yJ0Idl3o7b41p6gp
	 mMOJ4HTHqcRvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 1/6] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Vdovin" <deliran@verdict.gg>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708203410.45121-2-deliran@verdict.gg>
References: <20260708203410.45121-1-deliran@verdict.gg>
 <20260708203410.45121-2-deliran@verdict.gg>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 20:43:42 +0000
Message-Id: <20260708204342.8114D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added multi-line comment for `enum xdp_checksum` violates=
 the strict BPF subsystem multi-line comment style.
--

--- Patch [1]: [PATCH bpf-next v4 1/6] netlink: specs: Add XDP RX checksum =
capability to XDP metadata specs ---
commit bd15750c5adb8990bb2bd31725238a0442a743f1
Author: Lorenzo Bianconi <lorenzo@kernel.org>

netlink: specs: Add XDP RX checksum capability to XDP metadata specs

Introduce XDP RX checksum capability to XDP metadata specs. It adds
the xmo_rx_checksum netdev callback to allow eBPF programs to retrieve
the RX checksum result computed by the hw NIC.

> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index aa742f413c358..e255ff7861310 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
[ ... ]
> @@ -643,12 +647,26 @@ enum xdp_rss_hash_type {
>  	XDP_RSS_TYPE_L4_IPV6_SCTP_EX =3D XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3=
_DYNHDR,
>  };
> =20
> +/* Please note the driver is required to invalidate the checksum if the =
NIC
> + * reports CHECKSUM_UNNECESSARY or CHECKSUM_COMPLETE and the eBPF program
> + * modifies the packet since it can change some fields validated by the
> + * checksum.
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment for enum xdp_checksum
violate the BPF subsystem comment style? The preferred kernel style for
multi-line comments has the opening /* on its own line:

/*
 * Please note the driver is required to invalidate the checksum if the NIC
 * reports CHECKSUM_UNNECESSARY...
 */

> +enum xdp_checksum {
> +	XDP_CHECKSUM_NONE		=3D BIT(CHECKSUM_NONE),
> +	XDP_CHECKSUM_UNNECESSARY	=3D BIT(CHECKSUM_UNNECESSARY),
> +	XDP_CHECKSUM_COMPLETE		=3D BIT(CHECKSUM_COMPLETE),
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708203410.4512=
1-1-deliran@verdict.gg?part=3D1
