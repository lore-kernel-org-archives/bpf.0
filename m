Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392420;
	b=nIYI21+XpCPCmvfkY+kmer/hvWb36DEkW6tRUJce+GkBGLt7P25Qu6KPl65f86QcXIGt
	 9/OlH6izV46j9E8M2udhIBQPAg7+aBr3NPuVYajc+lQZyM1XbIWu34/1YIoXoF5goJC77
	 3qA8skYjpFt+CZ7NTxUINlLZg05Azg84su/hiY5PuQK7uLQoH8vW1Ca89dVieTaPGAuqy
	 CmGkPOna1f5lILoTknrwU6/8i/0im/r3jkMf0GjXIR1oNrqbEDZR5zjUPAqYXVKS0oQmY
	 Wp19jphte1y355RalZ7rdO1Nfmyxgq1bSQb3u5SPlJBWB+mJWmkieB/b/HM0Lf/Ukmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392420;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HDi8ZVZjNbKpIBnMKtUQF/R1VqY6UeYoQjUlv9lhtfk=;
	b=EPmIGHKmUU6bQOOpBxIE/VpoqaSHRk1bA44+atjF6mHH/SGlJWK+k3/2mnrVbx3I2w2l
	 a8424USNQ+K+eF28I1FRgxvx7BD+fKKZzxbbmsVI9rn3ONSmnTDX637biDvJP/cR/Y8P1
	 KIp4WQAwQ+JntBtVeck/XVobLn/3WKI4BssSsep7Yt7cv+3jDo3hDsIpzu2brWgBwjGvV
	 DK3nHfgi8BDu3BdqS9wTe2sGd7feaob0H4Tl2nFUBJkEqqTqtKO3OLYkpQQo0zic8Vw9K
	 bCPrvXj3bYdO2VHID4kkP6lE77CXTDiUdLCj+/A0Nj6vrm4EoW61/vSzcTwPaTe/XpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XWmlI7xQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F930606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XWmlI7xQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E611F00A05;
	Wed, 11 Nov 2026 10:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794392419;
	bh=HDi8ZVZjNbKpIBnMKtUQF/R1VqY6UeYoQjUlv9lhtfk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XWmlI7xQ0aq6kKeZAzoss5DdqloOb19a1sbS+s1nofKZ6isGzDTOejTgCL1YTxY+A
	 kCkvWlWrb1wtvhz5ebaxrlB0Bc1OQxJ8OMxfebGCX6SlhXoh5DqxMLFK04rhd803f+
	 h8I+3vtk1E2lfFY2n0y10LL4nNkta00NtFlid3++Cv/LwbzPxYyfZ0HcLkwJfwtCL3
	 jt/vlr3v5eHicPdLD3q5I9TjGdUQOOhkQny6OjgHdVmAoKH827by2EbJx8YbdPWILg
	 l9pEE1XAG5T5dzD1MYR5vaT8BVviJGn668qJaEuDx4IIfKwaPtyWyd/omKFBT+ofnq
	 hQU7kfwKs2+Ow==
Message-ID: <sashiko-outbox-208776@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next v2 2/4] xdp: return status from
 generic_xdp_tx()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Slawomir Stepien" <sst@poczta.fm>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261110101941.1059662-3-sst@poczta.fm>
References: <20261110101941.1059662-1-sst@poczta.fm>
 <20261110101941.1059662-3-sst@poczta.fm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 10:20:19 +0000
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
- [Low] bpf: multi-line comment style in xdp_do_generic_redirect()
--

commit 7706c10738f14b3774b96acd08e32f9887becd24
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

xdp: return status from generic_xdp_tx()

This commit changes generic_xdp_tx() to return 0 when the packet or all its
validated segments are handed to the driver, or a negative errno on failure,
while keeping xdp_do_generic_redirect() returning 0.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index aca8160b26a1a..b7241cbfd8f13 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4883,6 +4883,13 @@ int xdp_do_generic_redirect(struct net_device *dev=
, struct sk_buff *skb,
> =20
>  		skb->dev =3D fwd;
>  		_trace_xdp_redirect(dev, xdp_prog, ri->tgt_index);
> +		/* generic_xdp_tx() consumes the skb: either the driver took it,
> +		 * or the transmit failed and generic_xdp_tx() traced the drop,
> +		 * counted it in the target's tx_dropped and freed the skb.
> +		 * Returning its error would make our caller free the skb again,
> +		 * so report success, as native XDP does once a frame has been
> +		 * handed to the target device.
> +		 */
>  		generic_xdp_tx(skb, xdp_prog, XDP_REDIRECT);
>  		return 0;
>  	}

[Severity: Low]
This isn't a bug, but BPF coding style puts the opening /* of a multi-line
comment on its own line with the comment text starting on the next line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110101941.1059=
662-1-sst@poczta.fm?part=3D2
