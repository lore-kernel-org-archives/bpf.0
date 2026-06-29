Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EA7390209
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731717; cv=pass; b=lJXmUelzCTUIVQ2zcXX2p1WXLx/3Jiu6nUgv/2tJWqvPeWCawI1HdAHgY7n9opMhZ0e4eEtomVz56Mgc6X12+YIa7WqdFYjXqZYEU0WQJbaW7vwqy8W5g9Zi3+RBD690XxoztNhOZbmD09b2Y8Bp48camLm27c6ss/BVrPFPCeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731717; c=relaxed/simple;
	bh=9Vv/eaKlg6X4T1rOp02wyv1wk9KlPMUJfFj1DnAsepc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMlkM8YpDyX0oLCbg+Zt27Bvn8vhtGoFF9HbgIZo/lduMHgoI+ij4qw/MaKYP78JZHxhAnmVDu/MULHgGW43r/c2qnb4MmXcEJgbVJyHa6+LnwYMrgBj/RUORKt7r5ai3pn2bkjXFjLHgBynOWKHoTiLHGYw6XEIjOMAcazjUto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gzp1cNoK; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gzp1cNoK"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aeb688ae83so6311e87.1
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 04:15:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782731714; cv=none;
        d=google.com; s=arc-20260327;
        b=XXjxSDMNg6R3QsbXqRs9NyR7IZh9xWCt56deQM++q3QHDcl1m/fzESVIiT2ONXdCvE
         opz04kgsAeRAblA7xcgNKnBaEHfmZsZGbw7+7v6YOeUB/FNsTbgFLCWd832rR24jwORp
         30gthEzaWahEfaDy8QcU5v9J/UBvFamUFjbOG87B4m/IVzir0HDsMAQ2rj3S67fmUS5m
         ZAnyvE4EqGkUzco5IgGACTzeYP+QVw/2Yb3VQ2MMoUPTp1VgDoXAmF1lrQ9xk4E6Yt8Y
         Pu3JBFF6FdEaqil85TCaQWrpe2dXZxrMYpEcaZUyg7BCZnwqRAEFWItITl4sV6euitnR
         cKjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Zkm7N/eZj9MVZ8x8VdjlxYKMNNBfoby/nt3wdpmHmHE=;
        fh=VRppxwCrT5AEzh2q0gs7tuXtXpisgZX9fAzaCIqgw+M=;
        b=azObb5VnQwUdHlBjLrARBWvJE66+awV1Dym6/sdf0APEsaAV44mMz1gCc6YtqGok2t
         AoLZuatAnrLjcPXp08b9SiWxGFENqooBJ4cnVjX8x4P2lVwC5GCGb0pcjjtEkQ6xxhR+
         OAOkntWNhabYhmyFrgvFjvTNDmo7ikX4vjkgme4+E8yh1OgLmxurT9hDWYAKq87B1pJZ
         T+70iLF8qrfghL7CyVmkkzqAoV/KTkGyFUVfXmmurdrldog7lyhKPTTl8CxOX3j1/6bs
         PVyE6U5nhI/iGVbG9yWjtAlnhXAJAzfhGyH49PgZ9AhOVrMrPucD2LzWmXG6HgYUtb0Y
         spBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782731714; x=1783336514; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zkm7N/eZj9MVZ8x8VdjlxYKMNNBfoby/nt3wdpmHmHE=;
        b=gzp1cNoKjGHBSlwbLoXkEPTxoO2ZcbGkbvvUxWCar18Q9aq+pGzhFvJg0lamwho8hc
         bmeYVHXoN5fQLzFM8F74nQ8KXlC3fX8K5l1F+95x0SsLo8dxHDB0gCKhZ2K8LhCsK7yz
         Yd266lQALUo/0e6B0Od2NbH8NgZ3x9fzgE4hNXfh2zDznt4+/krkT2Rr3sOQzsdP93Oq
         p9mX4yPGCC5jAZWvq+hz1ZKrjm69M900vp5ZHmGvDI0HtOP65bLcf4yaXWS13/w+pODS
         VgxN6ZVnaJyJ4HRlvgynyH7hLFenuGR5gtSKLD0tYzYrPttT9Wgj1w0TPDeUKVrQuPWH
         1wWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782731714; x=1783336514;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zkm7N/eZj9MVZ8x8VdjlxYKMNNBfoby/nt3wdpmHmHE=;
        b=Bz05xCIBx3l1YdNMIYsKsGO+04deP4LQaEwX0ZhbBfRV+OGPC31suHFkThg0Nrw7of
         Duneei2FvL2FsN8MzJ19qQqu+O3Ad5mL+bQWJNhatL/quSXL2F9Fz5Xum8ERTCBw0Gkw
         Oc6VA6N5UEapsmh4KfKfuGaGURAd6hQJ2drPG+vqk2iVE03dc/prOFHvYebHeDPNChTm
         18ISAOmxDplshngymtX4VPw0bKgTGzEGayop0N78jQYpbASdKsgVGdAL1kDCzyMafwbf
         d2fXWd8l9H4azmyqxpWZasbwQeB2UM3P0yks0e4/TpPn7zwc0Yf9F9/qBfC6PlShgQb4
         UTkA==
X-Forwarded-Encrypted: i=1; AHgh+Rp2dZBUseiajv0OBRxHzoszmgU4vDc4csDIZtWVZ7e71cA05wfde3dao+Jr8UgD9CO28yI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhili+KoxJUH0Ssq2BZptTH9orlJl1G73m7BG8omeF2px35qIs
	R923+UxKUIyWT73XOpD1s+K/mFFAL799541v0lxosM7KyLJx0CN5fYTf3zAXlc3AOi1H48YPJqS
	I+aoayqI9jZN99SBfIOmx/zNq74QZHLVVQEV26qv0
X-Gm-Gg: AfdE7ckBYclyPKk6Q37A2Bg+m05c9zGcPeFmjI9zQgBqLHHLyVSuB/vle9NkHn7uDiv
	yZixA4mOyHBxutFEVxzZWv0rdgzl49p3nV4t7pTV7sZJ9ZDI6mbbYXvUBvMrRTo6zAzcacODH+2
	cFjoaEP4liiUX+Fzcbycp/LGOtl8MK3XIAlZ89jx4HOabo8/IjwEMuxMIXejpVeWWVqrUaYTbEU
	8Fg1OSCSQgCP1wYunxg0aJaGJr3m7hXUGrEORZfYKdJZxD90s60IKkxBtpMeNbnAmerUHe7p/bf
	qKvyp3mJ/5jzzp7EB/TAjTBanh1m
X-Received: by 2002:a05:6512:359a:b0:5ae:ae6f:8b09 with SMTP id
 2adb3069b0e04-5aeae6f8b37mr78967e87.10.1782731713304; Mon, 29 Jun 2026
 04:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629072300.1664622-1-clecigne@google.com> <DM4SPRMB00455DAA85BD5AEE9784C6EB82E82@DM4SPRMB0045.namprd11.prod.outlook.com>
In-Reply-To: <DM4SPRMB00455DAA85BD5AEE9784C6EB82E82@DM4SPRMB0045.namprd11.prod.outlook.com>
From: Clement Lecigne <clecigne@google.com>
Date: Mon, 29 Jun 2026 13:15:01 +0200
X-Gm-Features: AVVi8Cf1nNdNlNLJvQsbCPpORY22DyKkWr3R0pUYFLmnRD39Y1TjSq31DtTXpBg
Message-ID: <CAHuCGd=KJqrem_WTdZ6LSeTpdaSauw1JXe9EB3x6QRtVvFbTLg@mail.gmail.com>
Subject: Re: [PATCH v3] xsk: fix memory corruptions in net/core/xdp.c
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
Cc: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, 
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "horms@kernel.org" <horms@kernel.org>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009058d906556292a8"

--0000000000009058d906556292a8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 12:34=E2=80=AFPM Fijalkowski, Maciej
<maciej.fijalkowski@intel.com> wrote:
>
> >
> > From: Cl=C3=A9ment Lecigne <clecigne@google.com>
> >
> > Commit 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion"=
)
> > introduced a vulnerability in the handling of XDP_PASS for AF_XDP zero-=
copy
> > frames.
> >
> > Note: Currently, this specific AF_XDP zero-copy conversion path is only
> > reachable from the drivers/net/ethernet/intel/ice and
> > drivers/net/ethernet/intel/idpf drivers.
> >
> > When building an skb, xdp_build_skb_from_zc() uses the chunk size
> > (xdp->frame_sz) for the allocation. However, napi_build_skb() automatic=
ally
> > reserves space at the end of the allocation for the skb_shared_info
> > structure.
> >
> > Most high performance UMEM applications use 4K chunks, where the
> > corruption cannot happen. However, if the UMEM is configured with 2KB
> > chunks (a very common configuration to maximize packet density in memor=
y),
> > a standard 1500 MTU packet will trigger the corruption because the requ=
ired
> > space exceeds the 2048 byte chunk size:
> >
> > Headroom (256) + Packet (1514) + skb_shared_info (320) =3D 2090 bytes
> >
> > Because 2090 bytes > 2048 bytes and __skb_put() does not perform bounds
> > checking, the memcpy() writes past the available linear data area and
> > corrupts the skb_shared_info structure. This can lead to arbitrary code
> > execution if pointers like destructor_arg are overwritten.
> >
> > Additionally, in xdp_copy_frags_from_zc(), the allocation size is set
> > strictly to the fragment size (len), but the subsequent memcpy() uses
> > LARGEST_ALIGN(len). This mismatch results in an out-of-bounds write of
> > up to 7 bytes, which triggers KASAN warnings and is unsafe despite typi=
cal
> > page pool allocator padding.
> >
> > Fix the skb allocation in xdp_build_skb_from_zc() by dynamically
> > calculating the exact truesize required using SKB_HEAD_ALIGN() to
> > properly account for the headroom, the LARGEST_ALIGN(len), and the
> > skb_shared_info overhead.
> >
> > Fix the out-of-bounds write in xdp_copy_frags_from_zc() by rounding up
> > the allocation request using LARGEST_ALIGN(len) to match the copy
> > operation.
> >
> > Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion"=
)
> > CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> > CC: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Cl=C3=A9ment Lecigne <clecigne@google.com>
>
> Hi Clement,
>
> Do you have a reproducer for mentioned issue or is it only a fix from
> theoretical POV?
>
> To be clear, we were addressing headroom issues in this series:
> https://lore.kernel.org/bpf/20260402154958.562179-1-maciej.fijalkowski@in=
tel.com/
>
> so I wanted to ask if you are able to have this malformed setup for
> 2k chunk size. That series should not allow for that.

I didn't manage to build a malformed setup and only used a LKM to reproduce
the issue artificially. I shared some more details with you privately.

Thanks,
-clem

>
> I think this is the second time someone is trying to fix this area of cod=
e,
> so it is not a nack or something, let us fix this, but I wanted to have
> us on the same page.
>
> Thanks,
> Maciej
>
> > ---
> > Changes since v2:
> >  - Used LARGEST_ALIGN to calculate the len to account for the aligned
> > memcpy.
> >  - Fixed the commit message to include the idpf driver.
> >
> > Changes since v1:
> >  - Used SKB_HEAD_ALIGN to properly calculate the required allocation si=
ze
> >    including the skb_shared_info overhead.
> >  - Re-ordered variable declarations.
> >
> > ---
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index 9890a30584ba..7e39f17ad407 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -698,8 +698,8 @@ static noinline bool xdp_copy_frags_from_zc(struct
> > sk_buff *skb,
> >
> >       for (u32 i =3D 0; i < nr_frags; i++) {
> >               const skb_frag_t *frag =3D &xinfo->frags[i];
> > -             u32 len =3D skb_frag_size(frag);
> > -             u32 offset, truesize =3D len;
> > +             u32 offset, len =3D skb_frag_size(frag);
> > +             u32 truesize =3D LARGEST_ALIGN(len);
> >               struct page *page;
> >
> >               page =3D page_pool_dev_alloc(pp, &offset, &truesize);
> > @@ -738,9 +738,10 @@ static noinline bool xdp_copy_frags_from_zc(struct
> > sk_buff *skb,
> >   */
> >  struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
> >  {
> > +     u32 headroom =3D xdp->data_meta - xdp->data_hard_start;
> >       const struct xdp_rxq_info *rxq =3D xdp->rxq;
> > -     u32 len =3D xdp->data_end - xdp->data_meta;
> > -     u32 truesize =3D xdp->frame_sz;
> > +     u32 len =3D LARGEST_ALIGN(xdp->data_end - xdp->data_meta);
> > +     u32 truesize =3D SKB_HEAD_ALIGN(headroom + len);
> >       struct sk_buff *skb =3D NULL;
> >       struct page_pool *pp;
> >       int metalen;
> > @@ -762,7 +763,7 @@ struct sk_buff *xdp_build_skb_from_zc(struct
> > xdp_buff *xdp)
> >       }
> >
> >       skb_mark_for_recycle(skb);
> > -     skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
> > +     skb_reserve(skb, headroom);
> >
> >       memcpy(__skb_put(skb, len), xdp->data_meta,
> > LARGEST_ALIGN(len));
> >
>

--0000000000009058d906556292a8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
8hR5AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNjbGVjaWduZUBnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFCP+vH1KZhNM
AUDfE/ufrYigVK2rMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQCI
BpunU2TNkKMYJMUbxxxbZw282GTtrDVlZUatr2Uv7TUhqokrMdAv1gQZ0wqIAQs6xp7uUHj2klvk
tsZ2D9AiWvxSeAUbfcVHrnX5uVL4twUWycFEEi1kEWXGiuci/kgiXeUB/kLppu5vkbm9NBiGjpkr
t4Lz+Z7+Q4KMrs0H5dCLxU3RldQXVKgleU6yVVGN/6iBXr28NOrMTDYLOWQ2Qz+Szc3huy3T5Nes
ZyoocXn88QLRXn3Zq0pLl/0qEc4QFYykUWu55Lk8YpDQGsyKQlKkExNtRFp3oDPTV1F5MCstoaJ6
Nx5RIs+afbDZANnqxkOotDAmLKbZO2WmQJ/7PbD2d0jQmhbK59MiBBz67EeRYPhlIYyhEastC9Az
Dkr1ZbVTS1XIV4NaSbcmcnedl4Nf92bOmAzlz63C7FVpDwg8pHAo+trmtxQPaVFRrJRiIs/YYsGk
aKIMmqfg42WRtv94LJihfyxBMWitfpryCeEDojvdUYJ5XCt6tKI7RUY76MAlsXS0Aa+S1/d/EsnL
uWwrPVxn6LgBhJ1OegCVYpM58nWlQMxM/KDZuvuOYqRlRVlo6sdDuSouGWAaQFdu8szWZXp9HCYm
hNN36RQsOA5pqj8TBkCmvDnJbZFrR6i8pwwRs1eJOcLnOs8caLbqJRjfV0RxJgOzKsTJxe49hDGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQASjYzFGxUNLLe8gAaQkl
iTANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgbMsndQLGamFtMNef6H9VnXUpfBan
ZB0/BwiV2aGs7WwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
NjI5MTExNTE0WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEABX4mlMWSd/qBMshkZbtR4zTNs8tGYXJBtaK38GREnWBagq8vfgk1WPjXkFMicTd2
xkZ/EmetTiO4gj/cBfjzn1aIrVbU1b+NdtnncOKgBZ1N5dHUbt6CJfE5c+LgpkGynoOpdonmbui6
nKsDmFQjQ4DscwuJpqZaO+4GfzCqyzdZh/HX1I4huT4U7vlZMrdG4FuU5rG4gcU/sUgIZoaqK3+F
fISHDmxdxfRu+tnXqMUuYDC7b7BP7kDLWXSKNZ/Su7V7vS/gfdrDZAm6G+Rw2QrjVypPwf1VK4QT
kntZ6mcvM76SyBBhj20K5vDMJuSJ2Yul01QzSVkIu0gPipXCew==
--0000000000009058d906556292a8--
