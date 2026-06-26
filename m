Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A263750B9
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782465187; cv=pass; b=GRtaR8ViLir6HR2bgw8Gn0scKjYhB6SHGBAPANK6LrOo9SQrHi5b/tWFRZPZsrb+VttybVTjHIppQVs5VuaM/YTFbUgij2jqtvxJlH2/jhIgOaB/kG9tvgLppsI5YuRd8BU1IK/8A2pxFL3ekC8H9F0fQ1K5sW40jsMzkDY3wWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782465187; c=relaxed/simple;
	bh=OLhYGKWzB8w4uxu1F59lgCA3NykBpSvHmYWqyw3u6ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glcSXWrKnIlNKFGjFpktuzYPqAM0lpD57BnqM8JgIbsqL2VRHrxgz5Nq6FN0jrhqEz2Jvb1WlW3cheXsPw1/BKh1DmzgZhPmB/IOV/GfTz/Y0Z3NHz1FUODR5+6HxfrwDUTerMJYaJ2Pfbb4LhtM+b86xYjsyE1ySSyEJFpyAY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W6xT/AGH; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W6xT/AGH"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aea5e76497so2900e87.1
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 02:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782465183; cv=none;
        d=google.com; s=arc-20260327;
        b=SKF/G5r522adKKUtBsj8hUo8unzlNtGk/aPlpNvbqh/n4rPRywGHxB/sAn0pWWT/we
         wtWHSdIBvnwg8jrnBCA2apOvsfWBVdJdixPZiV96Z6rijZ71/sew7fQGAnOr4vDnIOcH
         UGRYPTUOg9UMPxf321uiLftXpnt/QBIkmmH0juezGK8uK0mHkYTMS1IcE4e7dr/EGb//
         P3NRI0QJVlP1ByMUoKVFwhsGG7KwP9e/DnCpAtByiJnftVwuMdTCRL3MRhgTZyGzMrh8
         +IoGx0+zLFu4KEl02vckS/RwQayceVtkVpMFYXL0s77Balk1A3C9Q4iRaPX8lbGahIAa
         2M7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=O4mob5cGI6thYQZ8o/lTgPDBPP1KVlbfLWJqWGvK5Q0=;
        fh=146eZUv6n9dIP/iy7FcUmY2g2+OF0VN3yDtdQR439MU=;
        b=VJ8p9O8IoQZZ3R7FlacB/SIglQIneiEt2yJK6JziFo2GmAvG2Pssnj3ygQzTRTjd7i
         lFBwyUyZEFNi2KpQh8KjFz/5ZXY0qWc46YRAbPMbYGKq/09Ec9G/+zNeFgmkjt5VGchm
         cT19MTqfxRq/f88w8+NWHhbn+ZskNmf7cdno8uZWq6Gfz121upK/OjE5EKDuNU1S2UHa
         lORmtrsYOVVFcPs3mrmT42C/Ri2x46oduVQoOnbmP37DO+rLISYwa8U8n9fGLYsPv1jf
         fauUhHsUC+JiDV1x+ClMbj55UsyrHItUpqAjKbTCvpeb053v/9/qlYmEXt/IzDlazQCf
         CsFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782465183; x=1783069983; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O4mob5cGI6thYQZ8o/lTgPDBPP1KVlbfLWJqWGvK5Q0=;
        b=W6xT/AGHrDIg+lTQ/6Mk4iADFIOEl5hOeylpmwc72IiBygQWu15EXVHwGmcXbD4KqL
         2vc2evlJidQ1RiMqqr3xK81G1VI6pPgWD6Xk5ZIUmI+OaCfV1GoW4Olv+9DUQROTQyeN
         n4ZqrLzMcttkYhWcYnPCbwWHXzp+hToOStu9HM4DuiWdT7PvP7CE/MgP4OAxS7/X95jH
         fqrnLvlkvenyvlKrehgJwoW2IZ+EKJiKezYQceH1AHRjj+HNqLzmqVQN6Y9iuQJT6fy8
         NLIehikaqsEGbiIECjxuqOn/C21cmPB5/eYKdziubPDVIa+M9C0VVTFJgDAu7M7FRR7s
         2vEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782465183; x=1783069983;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O4mob5cGI6thYQZ8o/lTgPDBPP1KVlbfLWJqWGvK5Q0=;
        b=s86780L3iyGhgkhlASc+ZyXGKBlPtipfm/O/OEYahxlfEV8a9R8ULEJMvgqLAiBnQ+
         +YhC/FaPS5gpWyPSXOo0kXVGSwPN4OcmXQdHA2KGcjKmc+4nRSrLksGp7BQy/klN8iAc
         GChNkyTAe62ZOA0bDdjOzi+Yt9pAR4Qui/I2asFU4TPXHyRQSuSXCTmcVP81VTKIimgf
         M0PBHnpiHYbC4Hg01EgKYcfoRwO3UcgLHTjLfJEya090svGSVNnvxPwseQSucPC6DRy0
         x28ygWFWGqb7tF6CKXtNodWP9TO6UCQG0jRPQIpkM9TkA1YoM1GcYhtl7Y8yho8XKCA5
         mkGg==
X-Forwarded-Encrypted: i=1; AHgh+RoFCMQmtM9qpI8tGxzn3oUxyOeA4NqEN+EVQQFt0LgVO43CxXEyQF3PwG6zz2WhZG8WcIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7FIwqBai49xTMrRWPCt4YSWpfhS6X1blQyir9x5xRxYX+Q8J6
	g1hTnVtEx3i1OItlu1EUBF7F16OpNg3Bt0TPOoXk9+lRoW29kBOux4x9gqXjeX43bDCr5W8rvX0
	ETvSdrfjdRPl8d7OGGhMQNaiYW5Lcr4IyCoBBZLG3
X-Gm-Gg: AfdE7cmYR0WXBu7Erk9iE8cVmtKBS707XbQMtiLSVJZ7CLuKiM/NTq/zDJGUmoumqBK
	kQOtvCXNQRg3vSfwnWT8gb8nUsuDqMcJJ8H9C5KtAlvo0NXJHzrAIFe3ub2H3Gu9Wq9u71skBwT
	1tKNwM7IlvQ656590QCE5ednqLEOwrm+/fMicunzc0Z3IltRUyIQAH4Ek+nhH4ohw03UWTM0tJ5
	D22Hf/SAaHxFgl5n+6lDRcGafixi1tq5y++aTYJPFKtWpjvLNwRRMiu/3USc4g8kWcLNnkrVJkF
	g/04ZTacnJCYQIbs3LVk9RCrhk6G
X-Received: by 2002:ac2:456a:0:b0:5a4:ec:53d9 with SMTP id 2adb3069b0e04-5aea5fe7a9emr88981e87.1.1782465182286;
 Fri, 26 Jun 2026 02:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624084130.2382335-1-clecigne@google.com> <0922ce5d-48d8-44e7-983c-e547f3126ef4@intel.com>
In-Reply-To: <0922ce5d-48d8-44e7-983c-e547f3126ef4@intel.com>
From: Clement Lecigne <clecigne@google.com>
Date: Fri, 26 Jun 2026 11:12:49 +0200
X-Gm-Features: AVVi8Cea6r6zGHHUj0FyCIL0dgSbuA9BG8cFc9PHIMcnT5nR3UChhQNNMDxDSpU
Message-ID: <CAHuCGdms7oynvu1zk=5Qbw+rHEyHaFYx6Bi5tuQYZ0Nc7Pchdw@mail.gmail.com>
Subject: Re: [PATCH] xsk: fix memory corruptions in net/core/xdp.c
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: edumazet@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kuba@kernel.org, sdf@fomichev.me, 
	horms@kernel.org, john.fastabend@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000135369065524843d"

--000000000000135369065524843d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Olek!

I submitted a v2 of the patch directly as a reply to this thread by
mistake, do you still want me to post this new version separately?

On Thu, Jun 25, 2026 at 5:14=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Clement Lecigne <clecigne@google.com>
> Date: Wed, 24 Jun 2026 08:41:28 +0000
>
> > From: Cl=C3=A9ment Lecigne <clecigne@google.com>
> >
> > Commit 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion"=
)
> > introduced a vulnerability in the handling of XDP_PASS for AF_XDP zero-=
copy
> > frames.
> >
> > Note: Currently, this specific AF_XDP zero-copy conversion path is only
> > reachable from the drivers/net/ethernet/intel/ice driver.
>
> idpf uses this, too (every driver based on libeth_xdp in general,
> currently these two).

Done.

>
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
> > calculating the exact truesize required: the sum of the headroom, the
> > packet length, and the skb_shared_info overhead, properly aligned via
> > SKB_DATA_ALIGN.
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
> > ---
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index 9890a30584ba..f36d1fb875ab 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -699,7 +699,7 @@ static noinline bool xdp_copy_frags_from_zc(struct =
sk_buff *skb,
> >       for (u32 i =3D 0; i < nr_frags; i++) {
> >               const skb_frag_t *frag =3D &xinfo->frags[i];
> >               u32 len =3D skb_frag_size(frag);
> > -             u32 offset, truesize =3D len;
> > +             u32 offset, truesize =3D LARGEST_ALIGN(len);
>
> I think you need to re-sort this to keep RCT, now that the truesize
> initialization is way longer than it was.

Done.

>
>                 const skb_frag_t *frag =3D &xinfo->frags[i];
>                 u32 offset, len =3D skb_frag_size(frag);
>                 u32 truesize =3D LARGEST_ALIGN(len);
>                 struct page *page;
>
> >               struct page *page;
> >
> >               page =3D page_pool_dev_alloc(pp, &offset, &truesize);
>
> BTW usually LARGEST_ALIGN() aligns to 16, I've never seen a bigger one.
> IIRC Page Pool never returns a truesize aligned to a smaller value. But
> if you're really able to trigger this, it probably does?
>
> > @@ -740,7 +740,9 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_bu=
ff *xdp)
> >  {
> >       const struct xdp_rxq_info *rxq =3D xdp->rxq;
> >       u32 len =3D xdp->data_end - xdp->data_meta;
> > -     u32 truesize =3D xdp->frame_sz;
> > +     u32 headroom =3D xdp->data_meta - xdp->data_hard_start;
> > +     u32 truesize =3D SKB_DATA_ALIGN(headroom + len) +
> > +                    SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>
> Ah now I get it: xdp->frame_sz doesn't account the shinfo for
> single-buffer frames, only for multi-buffer ones. The fix looks correct,
> but I'd use SKB_HEAD_ALIGN() since it does exactly what you're
> open-coding here and sort the declarations:

Good idea, done.


>
> {
>         u32 hr =3D xdp->data_meta - xdp->data_hard_start;
>         const struct xdp_rxq_info *rxq =3D xdp->rxq;
>         u32 len =3D xdp->data_end - xdp->data_meta;
>         u32 truesize =3D SKB_HEAD_ALIGN(hr + len);
>         struct sk_buff *skb =3D NULL;
>         struct page_pool *pp;
>         int metalen;
>         void *data;
>
>         if (!IS_ENABLED(CONFIG_PAGE_POOL))
>                 return NULL;
>
>         ...
>
> >       struct sk_buff *skb =3D NULL;
> >       struct page_pool *pp;
> >       int metalen;
> > @@ -762,7 +764,7 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_bu=
ff *xdp)
> >       }
> >
> >       skb_mark_for_recycle(skb);
> > -     skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
> > +     skb_reserve(skb, headroom);
> >
> >       memcpy(__skb_put(skb, len), xdp->data_meta, LARGEST_ALIGN(len));
>
> Thanks,
> Olek

Thanks,
-clem

--000000000000135369065524843d
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
iTANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQglB4+KQiF37oCfoig7R3OovUT7+Uf
s1Cmrzv1Uj07DrYwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
NjI2MDkxMzAzWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAL2kNFURkUzWDBrESMXuCd9XRkYLKU2CyKvJiKiUrCVnJGkbBJ9Xb/vpPFknHUNSq
d8jwytagSgyDXfYx1KFLZuIMMoBzadc2TsvPg4linPyAdHBpgPcJEnORU8AYSVr88UrjmD16Z7rS
JLr2L1qvUISHyYtalCEoSnlt7nBAAnDq6vRIEinLOvPIXOkiyh9wJURTiM1FFugFVJSSGs1fcu8U
upVzEhM02nQE7okc5oU/UYur8xU19Rv4eyIleooyHf5cvfqeJGc8aj+6W1dAAOw7V0yDOj0a0Kab
eLBa9onAqEpcjVTpsc1sMo4pcYgiFnpXwIiQTP8W9Yi8YrlX6A==
--000000000000135369065524843d--
