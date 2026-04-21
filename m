Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E043BE15D
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770001; cv=none; b=ajUzAG/r0q/1LPG8ij9jk1l47o5PtKw7Zx3QAdxZx9qkvYrT8nqO/RGzVwdXwRa7fDvvi9zMgkyNobN3ITzB8k5OEn4bzs/3hd5JssWNNGzYcEGoIrM/AEONn5ole4nrZXIbgKtqA++FSRCta5oUuZZAahXSGgZJDnQrL7geZFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770001; c=relaxed/simple;
	bh=yf2UTcI/GUg+5BoEWyyubbSl5j9GD9tN8zrx4vw75Go=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JfOIxjww4hqwoSUQbGzlx2W1h7dS6UCNcaXt5MyFa6gxy1KeVPFrv622Foog/zHkYvPGkH78cPX9SLlt5KnrEur4AEAfSGP1UjJpZcACFlKGq4Eb842oyAx1o6GCL3V52CTz/wIgdHfnx9eChpr6zD3HAdnrus+0cMm4CISgKNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9eJRADV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9eJRADV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94393C2BCB0;
	Tue, 21 Apr 2026 11:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776770001;
	bh=yf2UTcI/GUg+5BoEWyyubbSl5j9GD9tN8zrx4vw75Go=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Y9eJRADVApHKN0o8xVmt6O8w70fQ1HDwthMspJB5axhf6k8diYUPPYTkvW9F/XSUJ
	 Nnj2hs68fVrAqdjipOfR2kywm9SxxT0DVv5NsiyfVElO0mOd9MzSTbQDLJ8dtJu3l1
	 t2jlPXXGFXR87fym+1YNSWVmXS27Bbzf6JVzyWBS9ZZYzQ3nhHsHM3j471F2XVq/LC
	 iojAwvGdboWrKMSsQLD8bkqNwqSkWCUKrCwGPBDYuxkPayBQnq1F5wEoXXi8WVI1Os
	 KylyoR2qfLQmpSVbzHxl0r+SwUxcmkodwaZgqR3d4gyUk9IVU1lM1YLL4wyC18jshY
	 rTWEp6x+0KwjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 2/6] net: move netfilter
 nf_reject6_fill_skb_dst to core ipv6
Reply-To: sashiko@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420105816.72168-3-mahe.tardy@gmail.com>
References: <20260420105816.72168-3-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 11:13:21 +0000
Message-Id: <20260421111321.94393C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Unchecked access to `skb->dev` causes a NULL pointer dereference k=
ernel panic.
- [High] Dereferencing `ipv6_hdr(skb)->saddr` without prior linearization c=
hecks leads to out-of-bounds reads or page faults.
--

commit 71316e9661f6289f37134f91e40b833968dfa0d5
Author: Mahe Tardy <mahe.tardy@gmail.com>

net: move netfilter nf_reject6_fill_skb_dst to core ipv6

This commit moves and renames nf_reject6_fill_skb_dst to
ip6_route_reply_fetch_dst in ipv6/route.c. This allows the function
to be reused in subsequent patches by BPF kfuncs.

[ ... ]

> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 19eb6b7022278..41871fddec4d6 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c

[ ... ]

> @@ -2721,6 +2721,24 @@ struct dst_entry *ip6_route_output_flags(struct ne=
t *net,
>  }
>  EXPORT_SYMBOL_GPL(ip6_route_output_flags);
> =20
> +int ip6_route_reply_fetch_dst(struct sk_buff *skb)
> +{
> +	struct dst_entry *result;
> +	struct flowi6 fl =3D {
> +		.daddr =3D ipv6_hdr(skb)->saddr

Is it possible for the IPv6 header to span paged fragments here?

If the packet header isn't guaranteed to be in the linear data area, and
there are no linearization checks like pskb_may_pull() before accessing
ipv6_hdr(), could this read out-of-bounds memory or cause a page fault
when processing undersized or fragmented packets supplied by BPF programs?

> +	};
> +	int err;
> +
> +	result =3D ip6_route_output(dev_net(skb->dev), NULL, &fl);

Could skb->dev be NULL in contexts where this function will be used?

Since this is being exported for use by BPF kfuncs, it might be called from
program types where the device reference is not retained, such as socket
filters. If skb->dev is NULL in these contexts, won't dev_net(skb->dev)
cause a NULL pointer dereference?

> +	err =3D result->error;
> +	if (err)
> +		dst_release(result);
> +	else
> +		skb_dst_set(skb, result);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(ip6_route_reply_fetch_dst);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420105816.7216=
8-1-mahe.tardy@gmail.com?part=3D2
