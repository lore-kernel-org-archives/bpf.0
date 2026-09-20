Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A983A875B
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789915170; cv=none; b=N7BMUUThhl4js401o7sh3mgXbq3ABseWhewKCPp5yr6uy1YwwI1DnTweIDGX0aSBzL5+reyuP+qJyQAwoCZK9/Ni1VQUGddh/iXwj+h9DsVz9uEcoPzKpMu41E7qrJFNhHCR3uYJ+eFN7Q5eUW/eRjLCNsSrG4StNh1XdFNN1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789915170; c=relaxed/simple;
	bh=u1kdhxAW1U3XGDuZ21n2dZC+HZB9Z7CTtC4H1gYDLWw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Neb647fuNiJN0aKj8JaS8IQ3Gf2cEjK6jK1iuNQ5WtbLtpBq8gOcyyvB975PYJ80gUp0D2qlM7kRflwvMGElw9sYH/rnNEFWIX9+JTW8UWr52r5uVRNS8bEQD1jYCcxytaZxFd6XMpVK0nkqf20FA/hE6FJEUrzOp4H1/9WWhvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hui30IPk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hui30IPk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7191F00893;
	Sun, 20 Sep 2026 14:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789915167;
	bh=7sQy/FmJST11aPgAcu81kzCGlYLawsb6ti9aamQ4luU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hui30IPkcCsPHBZQlQ9On7tPnWEKJcSwu8zngqX+IdKnWTaeLaFFQjn3Oze+NnhIS
	 0ovlbomPK8I0wLcylNEkVcocF2FFH3YWxeUxm7cZ/abZXgLUzf44M35ibxxl4wsptt
	 4Ofl1WGhKoZEKjiruJmldUr5WMKEndwmvN7TJ5EiWBfslkR2thDZ7pSFrb5Ctt+2Fn
	 U4jIzCQv52y33u43kBAwJAxxE3K9InBJ7+9XHUxEZBonjZHPEXG1VzCRbpZoMismEx
	 CxGYUob+92qaQax8RzapHljB8vDIo9G6Gr6hM8xUqewKqDPwi6iHhfP2fhK50y08BN
	 4NI8NzMPiFopQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next 5/9] net-timestamp: use pskb_copy to avoid
 polluting the orig skb's start time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260919143732.11772-6-kerneljasonxing@gmail.com>
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
 <20260919143732.11772-6-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 14:39:26 +0000
Message-Id: <20260920143927.4A7191F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: missing tx_flags and tskey initialization after pskb_copy()
--

commit 25f6ea681d5fbb36cc3d7e6a5d0bca7daa16f7a1
Author: Jason Xing <kerneljasonxing@gmail.com>

net-timestamp: use pskb_copy to avoid polluting the orig skb's start time

This commit changes the behavior of __skb_tstamp_tx() when both net
timestamping and BPF timestamping v2 are enabled. It uses pskb_copy()
instead of skb_clone() to create the error-queue skb, ensuring it gets a
separate skb_shared_info block to prevent hardware TX timestamp writes from
clobbering start_time.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index dbbe10277d51d..a38c98554ff82 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5749,7 +5749,10 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
[ ... ]
>  			skb =3D alloc_skb(0, GFP_ATOMIC);
>  	} else {
> -		skb =3D skb_clone(orig_skb, GFP_ATOMIC);
> +		if (static_branch_unlikely(&bpfts_v2_needed_key) && hwtstamps)
> +			skb =3D pskb_copy(orig_skb, GFP_ATOMIC);
> +		else
> +			skb =3D skb_clone(orig_skb, GFP_ATOMIC);

[Severity: High]
Will this leave tx_flags and tskey uninitialized when the pskb_copy() path
is taken?

Unlike skb_clone(), pskb_copy() creates a new zero-initialized
skb_shared_info block, omitting the copying of metadata like tskey and
tx_flags.

Later in __skb_tstamp_tx(), the explicit copying of these fields is bypassed
because the pskb_copy() fallback path means tsonly is false:

        if (tsonly) {
                skb_shinfo(skb)->tx_flags |=3D skb_shinfo(orig_skb)->tx_fla=
gs &
                                             SKBTX_ANY_TSTAMP;
                skb_shinfo(skb)->tskey =3D skb_shinfo(orig_skb)->tskey;
        }

Because these fields remain zero on the newly copied SKB, will this break
the SOF_TIMESTAMPING_OPT_ID socket option functionality by reporting an
invalid or zero timestamp ID (ee_data) to userspace when a hardware
timestamp is generated?

>  		if (skb_orphan_frags_rx(skb, GFP_ATOMIC)) {
>  			kfree_skb(skb);
>  			return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919143732.1177=
2-1-kerneljasonxing@gmail.com?part=3D5
