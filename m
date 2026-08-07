Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C799442363
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108935; cv=none; b=OBl6lncZFGex+OVCCoRbzcVIzG4TZJScB3T48oNunqtNms1eV0gUVvlvx7PdJLwPMfifsXB8tfyKQOhZasySS28VQudE1Ta1LatNs8Z4FKU5OBsb4liWkZg36h1uFMDBGkn9FSZOO1oRke2Y2wn99PpwV0n3F5q+7/MGpSm/7Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108935; c=relaxed/simple;
	bh=ArICWOVvCyChFSoEN4G98C4WdRthTy7HGWz7868J6es=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O35KUIql0jcjOWzTuV3+ymoksFTG8/fP7JcKwj7ikGzp+LtbGXXnhMW94jyhAM2qS9L/fCjGZKCUoqRgpBXfi9+qE0JSzZ01j2kZnvUGtDggRKvOiypc2Q5OaR1YU6i2IBu7lpu/Gyza3lW3uc1VMxy8KIuhOBvWl1Fyz3Gc99c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRgv+NlS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRgv+NlS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5845E1F000E9;
	Fri,  7 Aug 2026 13:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786108931;
	bh=8xfXlCbOXeRYlk2+q6Vg+843GukcRUidW0Nl0fCYAhk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XRgv+NlSsUhGAGFPapO7eD2DFl4vhYuOgKdzIK3ZO6gxgNXLdsFN2c7hX5JnJq8U9
	 vvF+N+v8RcE5KDA7YuYw+RKSCkIETzSR1a/JXZL+vbJkxaIIeYvF8lspYftmzm5C9m
	 +wCduaidvJbdXeRjaX+SbKFRF/VPxx+Y9RdAUMUXMwfiSiQrAPVF67I/Tu9ZEoreW0
	 yyQWaQhgDJqaFj6tNY25XEWJGTCTBOC6nDfTh6jtQWp3Mbbx0jfit8VTWqqhHg8ul0
	 w+phCYBdzzQlmdDQ8wW0Oj3q4Dw89K3c5O7tY14CpmaGp8MTx1Pkly16v7F3vafjV0
	 5NkiOKJi0tgvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 1/1] net: cap advertised IP tunnel headroom
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiling Zou" <zhilinz@nebusec.ai>
Cc: bpf@vger.kernel.org
In-Reply-To: <0ac01576f92412e8fa35cc3eb44336797a9d11d0.1786021595.git.zhilinz@nebusec.ai>
References: <0ac01576f92412e8fa35cc3eb44336797a9d11d0.1786021595.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 13:22:10 +0000
Message-Id: <20260807132211.5845E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch introduces a setup-time cap for IP tunnel headroom t=
o prevent 16-bit SKB header offset wrapping, but relies on `pskb_expand_hea=
d()` to handle headroom growth at runtime. This fix is incomplete. An attac=
ker can still wrap the 16-bit offsets at runtime by stacking thousands of t=
unnels (e.g., using user namespaces) and bypassing the recursion limits via=
 delayed queueing disciplines (`netem`). Since `pskb_expand_head()` adds pa=
dded headroom (e.g., 64 bytes) that often exceeds the pushed header size (e=
.g., 40 bytes for IPv6), the total accumulated headroom wraps the 16-bit of=
fset (65535) well before `skb->len` reaches the 65535 IP maximum MTU limit =
that would otherwise trigger fragmentation. When the 16-bit `mac_header` wr=
aps to a small value, it points into the uninitialized memory of the headro=
om allocated via `kmalloc_reserve`. Subsystems like `AF_PACKET` will then d=
eliver this uninitialized kernel memory to userspace.
--

--- Patch [1]: [PATCH net v3 1/1] net: cap advertised IP tunnel headroom ---
commit 19f57a4a48f9a12f973f74a2e052b267cba3faed
Author: Zhiling Zou <zhilinz@nebusec.ai>
Subject: net: cap advertised IP tunnel headroom

This commit caps the advertised needed_headroom for IP tunnel devices to
512 bytes. This is intended to prevent the 16-bit skb header offsets from
overflowing when large headrooms are derived from a stack of lower devices.

> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index d708b66e55cda..85e3455cea259 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -629,8 +629,7 @@ struct metadata_dst *iptunnel_metadata_reply(struct m=
etadata_dst *md,
>  int skb_tunnel_check_pmtu(struct sk_buff *skb, struct dst_entry *encap_d=
st,
>  			  int headroom, bool reply);
> =20
> -static inline void ip_tunnel_adj_headroom(struct net_device *dev,
> -					  unsigned int headroom)
> +static inline unsigned int ip_tunnel_limit_headroom(unsigned int headroo=
m)
>  {
>  	/* we must cap headroom to some upperlimit, else pskb_expand_head
>  	 * will overflow header offsets in skb_headers_offset_update().
> @@ -640,6 +639,14 @@ static inline void ip_tunnel_adj_headroom(struct net=
_device *dev,
>  	if (headroom > max_allowed)
>  		headroom =3D max_allowed;
> =20
> +	return headroom;
> +}

[Severity: Critical]
This is a pre-existing issue, but does capping the headroom at configuration
time fully prevent the 16-bit offsets from wrapping at runtime?

The commit message notes that capping the value is safe because the transmit
path will still expand the skb if more headroom is needed.

However, couldn't a user stack thousands of tunnels (e.g., in a user
namespace) and bypass recursion limits using delayed queueing disciplines l=
ike
netem?

If this happens, pskb_expand_head() would be called repeatedly. Because it
adds padded headroom that often exceeds the pushed header size, the accumul=
ated
headroom offsets could still overflow the 16-bit fields before skb->len
reaches the 65535 IP maximum MTU limit.

When the offset wraps during the runtime update:

net/core/skbuff.c:skb_headers_offset_update() {
    ...
    if (skb_mac_header_was_set(skb))
        skb->mac_header +=3D off;
    ...
}

Could this cause the mac_header to point into uninitialized kmalloc memory
that might then be leaked to userspace via subsystems like af_packet?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0ac01576f92412e8fa3=
5cc3eb44336797a9d11d0.1786021595.git.zhilinz@nebusec.ai?part=3D1
