Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB2137FF4B
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682969; cv=pass; b=JI8rgC+C5N8ESyBhYUIRXgyHr7bHce6Z/eUP03uC3FT2EwKjah4FDNblLIYg4Nd+lDy7SKJpXaW/KxfOQobvIcpGiA862gx8D4fFCz/NXx/5v64oiG9TH51ty6oCnE9PluKXPc5UQn6SJ9FzkelqSVL8M2cE1CNrzOD1N9mAPo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682969; c=relaxed/simple;
	bh=+tGN2Gbd5XNQv6kqDrk16jTZ7vSM1i8VmXiPpbOw1tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPBUiHCFRqcQoYTo+/beaUhs0fgDduNs98Dtx9ID0/T+IxHxdpNu4GDM4rPFTHi+t/B4fno6rxZ7IYqhUTf4KkMF29KxBzNuNyPrMHRsFm+gzdySXZvI1uVutx7uNPfF03eBGtS8Ys2iEczmquOTkX+RrUvygeAH/2SAidwVqLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVnPf/tv; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVnPf/tv"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7e87602f26aso26158057b3.1
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 11:09:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780682967; cv=none;
        d=google.com; s=arc-20240605;
        b=ChNlsIxebcurYUOSzQ47kSBp/1xTcpLCutN1IaAIEvJmaZqpT3pyIE49u2uNFc8Pcm
         04rmFJ7OthRgKA6Dc4nwHtkbgOMF9cEzEzAt/YQ0ZhED5m2ImRRbHXilq6qOwhGQSWBR
         BmemprrqQu6XYhq8W2GWXA6kjUbvFMb71fqM5q75g2V32OCXpkimc1cpj3KtXOijfq97
         3PHMfS2SxKO0JnusohSTJGalDEIT2Y4gqYTevbouFwgZ8VbWUgcS5hGWy8Ux4NdFxZsn
         hMrcrNOx+KS5ElXqgGuwrDHXrAVevFf+9RkoNLCbVUr7gxz3fVUjsHjkWnC77ADG9TPq
         +tQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+tGN2Gbd5XNQv6kqDrk16jTZ7vSM1i8VmXiPpbOw1tQ=;
        fh=UfBe2+e/5ghTvC+JepclslHpufHIzXUaqfqWAfEoLqU=;
        b=OUwUZ8IGSuGZuGtJWvWTRljRNHdr+yvXcdOZMywu7EbH4K/A7nchxbc6aymhyUoA8t
         Gi6RzQkeyUqlkkqrX2x0WRbh3ZzgfW2+OxSf+pE8X2L95GgNUr9H4O6fso2rfwF8gfbs
         QwzJe6lF8cWbFSfwzi/G5mSh7xWrnldab5by0dRMlVFnZXkof31TRyMGuKnaIA1J+TyN
         l+V4RFGw09xee6KAvyy3SFWRgHMc7hqwPNaE66ZJ1WvKHhOlxcJw9D8i3MI4ffO7ajHL
         YgtyxklhbGtUslRSP5Y0XSzd24vFM1O2RGMQUQisa/WP09NqtEqUpHyGTLQQqfIwWaoV
         cvvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780682967; x=1781287767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tGN2Gbd5XNQv6kqDrk16jTZ7vSM1i8VmXiPpbOw1tQ=;
        b=SVnPf/tvPQYmQaWHp4ty5uYXx7IgrDg2mOyurFfQq/I697476IlxV0eP/F+qvoTfnY
         DN6wl4sR/Y9FEOotH5CeCCZShfsvXIgqoSZ2U17PFAkP46IaDFJejh06WNLu5p7iPKp3
         K5i1TX3saHtRBdKsGLvH+VXjSFo2nX0PN4KsUwcerPcOlxG3wif6xF/ByKU58gjd+qBe
         CFMukAsd8PlrU5YdeMsMZMWye02yTHQCNhe8K+0R1OFckOTgK/s9kG48tqmUQIJtbT0x
         Nuodrq8t53RBlYPm9mpG7yL5UM79JimsCj+i6z60SUZVaVXJ9Qx0LXmN55fig8zV+u47
         3+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780682967; x=1781287767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+tGN2Gbd5XNQv6kqDrk16jTZ7vSM1i8VmXiPpbOw1tQ=;
        b=a0qK7aUISZ3Lst7o/ckC5UY/sRMv7YQ82CGLGTz1NFTyXSMaT3uxNrBNqkXD67PHb1
         SM8jZ2DByYFV9RyDsY377LgGgP7QF5ppBKcYlra3GZeNsBzd+Za1ylRQTppXYhDF4GyP
         OLGtGi/+O3ieuk8divny9qdWfokYwIoULJkdec2waH8xuttFOx5x9uYI66g22mbCmvs7
         0G5Ns7+yWCaYf3Ssg8Rkj/UNlAFu49b3wSW6eHbeTknWMnsTo6UCoOtmpcEUs89F3tPS
         dhpwzQSYCc75/+unHeuRwl8fYj6ihyTV1mjF0VVdqxKkv4VwkXNGhvHUt9NGrRYEyVqj
         2+jA==
X-Forwarded-Encrypted: i=1; AFNElJ/jVZXld/hDZ30Frsr9KQRogV1yN6PyChYfV6zVEGqFkzu1w4mTq3shie9AQQmJD3Bio+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVabjk8C40VzPFJTuE6i93Q959rNRhebnlsPdlrBkn2FeGcPqe
	J61LafGe3uePNkUF8/ugowR9kCfWq3WGuhea3oJgdy4+ZVFrHdcP//u4xcg1FOQKPISllw/Xx5l
	Rf8UPHBViMdHtUgPEsF3/2il9EtCnCEk=
X-Gm-Gg: Acq92OFfbBpCLmADY0MBuM96lCieSQpFaVEgu2cQyOzJgMZ5oxH11coNkXrRdxjz1eA
	91nfCkd8BvN0+hq09RgaI0F0RSHpTVuuN+24K9b5LdVB+h3nF/95cPoJDC/zm9bcD9xuarFaRzC
	dUw5NzVJklkI+S5ARdNbwiy5dle+mEfY2rHaPGwdsaycv2p2oMtyrA25oy+w2ZxDukL54QYtcHe
	b0s9TowGsTupMz8NeetZBHXNXTEE+DhMVF+A4elzHrDfUm1+Q3rC8iKMoHpxeA+1iUgXDniVNNa
	1r0I4a5CDMFDC377F6b5ZvybueA/hyd55tfiZ042goAO
X-Received: by 2002:a05:690c:600f:b0:7bd:a6ea:c50c with SMTP id
 00721157ae682-7ed516400b7mr27415387b3.15.1780682967473; Fri, 05 Jun 2026
 11:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604220904.1032145-3-ameryhung@gmail.com> <a5988106169c7350f39a4d07b36b679a5fb39cda49ca371cb79c23da7b63971d@mail.kernel.org>
 <b4302a13ccae77b304a09b47c58565c8ff1970c2.camel@gmail.com>
 <CAMB2axPLpxk8fh-Qp2sGwtsZBCE42DLo+h8pB+ObffLifP9aZg@mail.gmail.com>
 <CAMB2axOOG3ptDkWvTDpGut+EmDeroe3GPR3obb-Br_Dg1aGmgw@mail.gmail.com> <6d86c2fae9be63eb110ebd5b3fc19bc4cf1de2dc.camel@gmail.com>
In-Reply-To: <6d86c2fae9be63eb110ebd5b3fc19bc4cf1de2dc.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 5 Jun 2026 11:09:16 -0700
X-Gm-Features: AVHnY4J3-fQZb3RAbqdWeoIKN6ciyIVNP6qjMWxwAp_5IUqS_2V4BVceYK8dAzc
Message-ID: <CAMB2axN3phpufSt5SFj60Q19w=1NWpOks4ykgZ2Q1zS_5K300Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, 
	kernel-team@meta.com, ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 11:04=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2026-06-05 at 10:57 -0700, Amery Hung wrote:
>
> [...]
>
> > Actually, looking at it a bit more. I think I would hold on changing
> > check_ids().
> >
> > This patch should not increase idmap usage. parent_id refers to id and
> > therefore check_ids(parent_id) will reuse an existing slot.
> >
> > The id_map is indeed more likely to be triggered since there is also
> > an intermediate reference for reference dynptr introduce during the
> > refactor, but that should still be very unlikely under normal usage.
> > check_ids() also already fails in this scenario by returning false. So
> > overall, I am not sure if we need to change it.
> >
> > WDYT?
>
> I agree that it should be fine to just return false from check_ids()
> if there is no space in the idmap. However, since not all ids
> correspond to register/stack slots anymore, I think that
> WARN_ON_ONCE(1) should be removed.

Ack. I will drop WARN_ON_ONCE(1).
