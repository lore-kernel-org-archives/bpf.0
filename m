Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284324;
	b=0cA0PyCsY0yaT+J6X6PO5KHyEVjCQuPphFODci762eJTNxSXB/iMo2pt0E9ZO0tERuQT
	 eHJ2hI8MntxRKBVpKuc5uTO3A6e8B3rkrH2111sS0n+5UWXphzc7fiQ8xmNhBSPDZF3aJ
	 6hSBLaY4RzzHFIzINuAbzkECQaMcNQTHvc790Dgf2X9Z+02M6CbjdjoP8SLC/d/1+ma4v
	 xUINYhOkDVC0pbjoaVI8thrnjNWDgQX40g+HzPbXHytWkQGGOmoJ0tPrFRx4bmOhsab+W
	 lZwKYCmOM+UC6MY0AyTOsq0M5tQfbANYES6OGGqLs408h+OUI01N8/v+y8I9gj00Hzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284324;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FCMfrEanvNuZKrktY3H61P3qHIYd7p2HmCkNinB/LRU=;
	b=4N69xQZA9l1/d4i2p/TbkFv7YjIjeG3RtVfQN18GGdQYlHuPII0iTPh7MaezksQzXuuB
	 LwABpzm53UqMRx9OEU2UnReAlPhB6/4O/puU6oXZ+nRKNkhBBCF9B5P9xvtwIrtTWt5ZI
	 GsmZNbIopqbOrM5jyS8ZqDtajuPGNhNBCHryOKmVgDwmtY2zyRmHMxJTjgKh+7/DFFhOD
	 76rmIaLp9uku2xZuhOw+fIh9aBQOwq+/mZoIhyvXSRL1LQTaTOcpCOz3drvYEu2GS6dmJ
	 P7GjUC+MNbVJaxEC/VEalZ6+4bdPN5cEIemh7134aLoUmqbGapvig4XrVESnb4R4HHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bahJoU4F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21349606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 04:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bahJoU4F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9B91F0089F;
	Tue, 10 Nov 2026 04:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284323;
	bh=FCMfrEanvNuZKrktY3H61P3qHIYd7p2HmCkNinB/LRU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bahJoU4FjVh14oWl9tyP6mySmCdyMcqc+jFvoXghgBKMYPDgYy7JzhgBK9+4Ln04C
	 IeoqNM9sBi7SkfQemb8phMj8JCnpzA2MapUImxF0YY3xpKz5fdXVw8kHG2tw8RRGgz
	 p/7RHveO/jRXMQj4qjWr1ZEckKnANJ5bsbeorwxqFyzgXJ0sxreMJ9vObvDnjv0RJI
	 XeSMKy6bGRmt2AMQ+Kwwr2yEe4nyp4cucFPlr+BoYwLwV6tMmYbJ1BiX6GuP2qBaE2
	 yhQKenj/6+vgIAlZCM6ZtyGN0mFEJoUi/C24q2E5IeD1cvmYNId/K1jPI20OtrxUwX
	 IE3vGeObfx0Qg==
Message-ID: <sashiko-outbox-206183@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 01/15] xdp: reserve an skb core extension area
 after the xdp_frame
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tianyi Gao" <tianyi@cloudflare.com>, bpf@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <115997f55d63b507ce54fbe9e22900b59016f3c3.1794281983.git.tianyi@cloudflare.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <115997f55d63b507ce54fbe9e22900b59016f3c3.1794281983.git.tianyi@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:18:42 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] xdp: multi-line comment style violation in include/net/xdp.h
--

commit c815cea2f0a60c677b6335d7bc98d4ff8c9346df
Author: Tianyi Gao <tianyi@cloudflare.com>

xdp: reserve an skb core extension area after the xdp_frame

This commit reserves an skb core extension area in the XDP headroom after
struct xdp_frame and updates XDP head, metadata, and pull-data helpers to
preserve it.

Link: https://lore.kernel.org/all/1d5521eb-84fc-4417-a3f5-6366694d160a@kern=
el.org/

> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 07231adfb5f82..c888353425d42 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -81,6 +81,9 @@ enum xdp_buff_flags {
>  	 * XDP program is not attached.
>  	 */
>  	XDP_FLAGS_FRAGS_UNREADABLE	=3D BIT(2),
> +	XDP_FLAGS_HAS_SKB_EXT		=3D BIT(3), /* skb core extension header
> +						   * is valid
> +						   */
>  };

[ ... ]

> @@ -450,6 +464,37 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct x=
dp_buff *xdp)
>  	return xdp_frame;
>  }
> =20
> +/* skb core extensions: RX metadata that an XDP program stores in the
> + * headroom right after the xdp_frame, for the skb that is built later.
> + */

[Severity: Low]
This isn't a bug, but BPF coding style puts the opening /* of multi-line
comments on its own line, with the comment text starting on the next line,
for both XDP_FLAGS_HAS_SKB_EXT and the comment above enum xdp_skb_ext_id.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794281983.gi=
t.tianyi@cloudflare.com?part=3D1
