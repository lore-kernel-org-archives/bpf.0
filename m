Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E5751C05E
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663410; cv=none; b=Jy7Wi0slIX1KxtzJaeeJRd9j2ZOUwlQmrgTjl6LcIibkkBb47e66Jb/Xz5u6eoZ6YrRUEsQ2uPu63z40Sw2N6yrzm/ojezAKPhnN5+FHpN7bEd8co0dmPhq6ysYPt1O0hJO93aYsbzcS0U8AoSj3QSgHuReVEb4I5lgm57DsLww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663410; c=relaxed/simple;
	bh=+iABt4BOj6aQWov7nVO01fUlSMsBGCCNZAnSRQnJj1w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DZDd3gGjrWs/Z3/utGQjfODQrRhR0cktWv4Y/ihll+05mti4Y5GKxzvdHafxxRoth6xYMzPzOewQe6qczVuVhlbm1M31qwpZz/wUGPo2BGuMj6+QkVY2/sKZ78ms9EhUEBoBgVZ/Cc83BZKbybfn4+Zfxs42Xh6qrXjlKqkvhAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YewECwLa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YewECwLa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3278C1F00893;
	Thu, 17 Sep 2026 16:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789663408;
	bh=8RObWTwF7+ypL0Z8yAkT2PNZc+SqAIkjZBcB3iVIVzo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YewECwLay25NYbryK4SD7JCo93a6dyElpqnvdPs+g7aC0homRuATyD2sAl2UlkZJP
	 XOzTpnxEsg9vIX7G95ozyYmMFnzLXrTsTOqJSftUe2gV8KQsuk+Gz/GTBA9IbetVoF
	 S4aCO86nJR5khGdM1ZL/e56ptShgMNBGGe53t9iYXZNxe/uSnUtEgqxJkIdTBb47sn
	 JMZ4+jPitNy6J+Wtyw9npQFzcWUE7GyxAl3NSV61zlyq7DtK1vGWnGguo+8e04+IM0
	 uw5MMiccQstsfZ56+JaZ0KuglxmvZmB9K51xtk/z0ZEObHL31KpNgCRqqc1jhiIWnM
	 4Z+Gid93u4hxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] bpf: fix TOCTOU in IPv6 SRH encapsulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ren Wei" <weir@nebusec.ai>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917163408.252431-1-weir@nebusec.ai>
References: <cover.1789646866.git.rakukuip@gmail.com>
 <20260917163408.252431-1-weir@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:43:27 +0000
Message-Id: <20260917164328.3278C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: unbounded GFP_ATOMIC allocation in bpf_push_seg6_encap()
--

commit 40c18c9d1b350ea4f5c75479e1a7e19a9afce134
Author: Luxiao Xu <rakukuip@gmail.com>

bpf: fix TOCTOU in IPv6 SRH encapsulation

This commit addresses a TOCTOU bug in BPF SRH encapsulation by duplicating
the user-supplied SRH using kmemdup() before validation. This prevents
concurrent map updates from altering the header while in use.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 532405988fd98..cbae40d545817 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6878,16 +6878,22 @@ static const struct bpf_func_proto bpf_xdp_check_=
mtu_proto =3D {
>  #if IS_ENABLED(CONFIG_IPV6_SEG6_BPF)
>  static int bpf_push_seg6_encap(struct sk_buff *skb, u32 type, void *hdr,=
 u32 len)
>  {
> -	int err;
> -	struct ipv6_sr_hdr *srh =3D (struct ipv6_sr_hdr *)hdr;
> +	struct ipv6_sr_hdr *srh;
> +	int err =3D -EINVAL;
> +
> +	srh =3D kmemdup(hdr, len, GFP_ATOMIC);

[Severity: Medium]
Could this lead to high-order page allocation failures? The unvalidated
length parameter is passed directly to an atomic memory allocator before
being validated.

If a privileged BPF program calls bpf_lwt_push_encap() with a large length
sourced from an array map, the verifier allows this since it is only bounded
by the map value size limit. Passing this length to kmemdup() before the
bounds check in seg6_validate_srh() restricts it can trigger atomic
allocation failures, leading to dmesg spam or a kernel panic if
panic_on_warn is set.

> +	if (!srh)
> +		return -ENOMEM;
> =20
>  	if (!seg6_validate_srh(srh, len, false))
> -		return -EINVAL;
> +		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917163408.2524=
31-1-weir@nebusec.ai?part=3D1
