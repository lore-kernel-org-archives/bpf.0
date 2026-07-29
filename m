Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42013233944
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 03:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785295900; cv=pass; b=i1VSHSh+5K2efZHv/oKqY2CClyNpVQqZpt1eAUq7mVG7LqomtR3Ap/M0qxDOGEitqkN4K9mxi+WjX7UAzTEwgjJCxBYDKOu9yz/e7cDDoatNkXPnlXgwUgMdA/eHpx8m/FfG8393lRDYyMR3Gd73XHAIXvNBMA9s6IoStjXBYH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785295900; c=relaxed/simple;
	bh=8INSsvIsr0EcFor0KjhMqLit17i8jgQhYiGlfRY+r1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gz6QB4/nWa019tSFiJ8ClLBrOvtzsXy5wjzPG0FFHpAmqRteebmuZeBXMfRSx9/WnHQUslJp9vW7JynD1/Zu2a0XYZQemKGfRGfw535xbRWzUyvj2aSzgC6nMo8HbwzbHZJzQmb9mFLPJJID4hdv7H3lCDr9dRaEwpzUr6+L89k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZkFzDLJ; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZkFzDLJ"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6689402c7bfso460401d50.1
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 20:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785295898; cv=none;
        d=google.com; s=arc-20260327;
        b=Uct7S5NFC/SINFdkkcmf8L74qxkOd+7YDiWDL3NsSn00TkCELyG4yYgxH/Z6R/tq3b
         YjCTnXcrKM9MymSfhLDpPHrZDs+699tWPL5R9H/uZjaeCcNr9a3CLlPQF7+fh0J5OTwH
         +sskwSNFO0/o9om8Rts2GogxMQqoU3b5P5fWZBm5/HF8A73zzq0C+AC6HoMD2sz6TVk+
         Cwcg4MmaZjiLIlfhtGFogOwFRv3pz7Fzx+XXYWoC7qoYfO6tF3iDillfWdxRyHuNz/Yr
         65m3h4iNfMIB3apw/tseweJh8mQ2mgaud9qidF0UJQyDZdtMSgjs3YpCefyHSPdppw4P
         BGyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pe0CzKtFSobq234+zo2ouN0uSG2sSCPEWeoFaE53a50=;
        fh=mWZleR1vIa+bHHjpTNl40vDfbWLAjQx1tM91pFt+tk4=;
        b=iYlkyaESbe7ld5Q92vZ1OzBsO+KJBlXTFzpSjKy2IjtufpXGEOB4XbQonKsqXii+Z8
         YiBmzUqLsYn6wJsk5pYrTwmSiX7V0GCyBHymTsG+HrbctCJO13h3j9Ic8JsnJmfUS+FD
         GfZ5dEROazBd2E7Dqq88IbFFnhL9CSSG0EGRrhpiAkorX2eBWsNyqjM834YfNeE4xdMk
         cI+Os4NVqxRBCG5OQatJEIqSjTjD1J6xley7m5RT3zp1BeNJrc37PGmMwtCX/cYLPbXG
         w7sjy2mp5NSTsCD2TRlftviG3jvRU3aB1TwtJeKNtwssF99cpNev9aYc0tC2bU87tzAI
         k/Kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785295898; x=1785900698; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pe0CzKtFSobq234+zo2ouN0uSG2sSCPEWeoFaE53a50=;
        b=LZkFzDLJYcHyEVQjUK2tiKOjy7g93DUrCPtLUfOlKgu79bnoTMVwilsZVc8hrngfNM
         ADOlYWZA3nrXD1n+8NY/xS0vkN0Qp63wg23bsn0nvHU0qtDh5avpk6hxEjlc5s3FDXMz
         oKBYX/GiJW104aKxw32AK6W6TJco/J+A4eBos1lRYZhbJJqP22ZgscRYXYz62TSrzucY
         ckTDgmyNQ0OFbuYwbGUSsxBxfy3t8vyWZdvECPQ+ET322LT2n7E+kvdIJ5X6+lwAdhRw
         33VItxbVf1TDbxYqV2P6aplA6tZKMCL0umNJjy9Wi25WpbMsaGxr1xYh+N3cvSfnmpdW
         vBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785295898; x=1785900698;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pe0CzKtFSobq234+zo2ouN0uSG2sSCPEWeoFaE53a50=;
        b=jIBMmvM0EDfaWBjJcpDPMg5vB3PXMyH8WfIEXXAzaO1IYBxebdEtWn3xiP5gyTj0NU
         1QKSHwnho0Fvs1YxHodGAsTLqCYkvnhhLpWisSlhpuyie0WhC1ivgRCmvCH1a/LLcmRF
         gJO2pbQKWHbnhKrWq+NSY4q0kWsR6kX5JCsN17T+/TQKbQWRC/Dw7Rx6qZHBrYMuV3nV
         uIUoBJ+N0JY7o8hnTts/PP8+BiNRQeh2704tjhXZkRrtkvebPL4T/+wK/kjX/McIXDbh
         JRWfIxPd8tIEkwSos5D+Bga4z5WsneHVB+qPpoXhfxbwk/+ztom6ol+JlEhAwsKpfLCk
         O/XQ==
X-Forwarded-Encrypted: i=1; AHgh+RpSxR3wlpuPRfGM9GWqQm+AXNftO9aSqwfou2ZrgGvrfWOhnnSpDIAkVRWQwbHsxz5H7/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydkf91AsQ1l5hDp5MJjCaFeVxKiYsFLcN7bJ9KIaTb8b1MjHUK
	UdeIA3Lndwr2H4MXflzNkn5Qqh5kFRMXV6o/J2DSw1OfriecYLqGgKQ3/q7ckCgNVZz69ncGRCv
	vvOxKrujwzyC/Z3QfEOAtnjo8DOoDuGE=
X-Gm-Gg: AR+sD12CqnGUR4uQ2UUZuk9/7pUVwdIQ1Rsig7nMLPGqzduX+p3m4ieVPelmW4FdLwa
	2ZInYeC4LykOVyD5QW+BWaXG/DaQSwZVJvAcsXLOkcRnbXRDB1UWUZ7WtJJKGwbnUzcHpTZ2tlR
	jMAnL5MuBzXV7aCqFDh0b4oA1JGP00YKSW4cvIhR5g+Lqbg8inxjvzzN43HT5kfVOfbAoGl4Vs4
	SlEILw/+5vcSpQAadq4udgr1pGntTh7wz3fpWMjavPXFkZWdCqyCCjqnvfXRr+kwbdhoFtF79xs
	ik5O2QKq+nFkbGb+xcIWP0Vw3nSxPjLcwBCQPklCKVVXRyqCtrIdPnIfTghHDH0J7a/QJIfFBOw
	WVbu3WCDnM6wa8OXn1qA=
X-Received: by 2002:a05:690e:4295:20b0:667:b57b:8697 with SMTP id
 956f58d0204a3-669057f5bc3mr1697637d50.61.1785295898162; Tue, 28 Jul 2026
 20:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727032535.13469-1-sun.jian.kdev@gmail.com>
 <20260727032535.13469-3-sun.jian.kdev@gmail.com> <amcIoG59kgi4CJbo@lore-desk>
In-Reply-To: <amcIoG59kgi4CJbo@lore-desk>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 29 Jul 2026 11:31:28 +0800
X-Gm-Features: AUfX_mzCCj-Rhe2GnR_T5jwxAsRWw1WjvNw_V50aUcanGkk---NpUHWw-SrR344
Message-ID: <CABFUUZG+g_g_7N9D477vJW2c141-WhWL2JG8oc-y3OoF9QePdA@mail.gmail.com>
Subject: Re: [PATCH net 2/2] veth: fix skb length accounting after XDP frag adjustment
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, toke@redhat.com, 
	maciej.fijalkowski@intel.com, matt@readmodwrite.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 3:28=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
>
> On Jul 26, Sun Jian wrote:
> > veth exposes non-linear skb fragments through an xdp_buff. If an XDP
> > program adjusts the fragment area, veth_xdp_rcv_skb() copies
> > xdp_frags_size back to skb->data_len but leaves skb->len containing the
> > old fragment contribution.
> >
> > After a fragment shrink, this makes skb_headlen() larger than the actua=
l
> > linear area. In the reproduced UDP receive path, __skb_datagram_iter()
> > copied 1024 bytes past the actual linear tail to userspace, starting at
> > struct skb_shared_info. The copied bytes included the affected skb's
> > nr_frags, xdp_frags_size and a kernel pointer from
> > skb_shinfo(skb)->frags[0]. Real packet data was displaced by the same
> > amount and truncated at the end.
> >
> > Subtract the old data_len before replacing it and add the new data_len
> > afterwards, keeping skb->len and skb->data_len synchronized.
> >
> > A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened b=
y
> > 1024 bytes from its fragment area. Before the fix, all 10 runs produced
> > corrupted payloads. After the fix, all 10 runs matched the expected
> > payload exactly.
> >
> > Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept =
non-linear skb")
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/r/20260720141859.19FF41F000E9@smtp.kernel=
.org
> > Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > ---
> >  drivers/net/veth.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > index 00e34afd858e..a956498a073b 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> > @@ -871,12 +871,14 @@ static struct sk_buff *veth_xdp_rcv_skb(struct ve=
th_rq *rq,
> >               __skb_put(skb, off); /* positive on grow, negative on shr=
ink */
> >
> >       /* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> > -      * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> > +      * (e.g. bpf_xdp_adjust_tail), update skb length fields here.
> >        */
> > +     skb->len -=3D skb->data_len;
> >       if (xdp_buff_has_frags(xdp))
> >               skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> >       else
> >               skb->data_len =3D 0;
> > +     skb->len +=3D skb->data_len;
>
> nit: same here, you can this one just in the if () branch.
>
> Regards,
> Lorenzo
>
> >
> >       skb->protocol =3D eth_type_trans(skb, rq->dev);
> >
> > --
> > 2.43.0
> >
Hi Lorenzo,

Thanks. I will address this in v2.

Thanks,
Sun Jian
