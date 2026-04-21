Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC4D3C3BF4
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775609; cv=pass; b=r3n/W5ZQ0wk1EQV6dp+skSiSKXT1g73kNQc5UK/e5p1uE5HJV8099j6sFMhUhi4bMWSKbBgtZBKUHRnsO8XG60WnJwKA3UnJDV77/Ppz4AsAXZIozyzOluLRTIZph+M5JUFm5gcKlamfcZmibUyDiAYEfkVKU1IxjjeEXp9gcYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775609; c=relaxed/simple;
	bh=QKhrKmLJ8uvOBD3yo0buw5CSe/PN95d4YOSFY7J22wE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIk9Qe+9ww5+mB5kTchB23WdP3lh4BRrPNhoHM9gnkeNYYXHOCDS5QzjfajbkDGLbdflGS0bPfJZHnJ4m1ChZnhoDpupaKuCE4oUbbgzOKeYZMXf4W/fqHBDJ9UsIHB9sT9slVzZAAJBkTvtbyDgBFL1Xyzs45UvIe65PwnzKqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpf6520e; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpf6520e"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a40b2bc96dso5160188e87.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 05:46:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776775606; cv=none;
        d=google.com; s=arc-20240605;
        b=CEAW0zzW9RmRhKaH8l/uxj26xd9EargmNMwz0dyqOIv2C3mggCmccqDDq/joy57uTL
         halSZ8ovLo1NUyJI1J+Q9Ie0pSUV1Kmys5Orm/V2ejNhiKgnEsSyMZWIM0aWBY95DPGB
         h/Y1RgKArKnO5RER4wKFPyQzrnq8YmVprbY8wsVbrruzYMWEt3JXaL0dXKvk1vg1lb7I
         TZJr8q8CcBQVENX/s53hP9MsQGvpLGtWo093o4vW30yfuwIUnJS4QooJzhZ0lB0Juewt
         cGn4vDp/Cy5aYRylmfJ7ia0/NnPQCDShWsDSblcKl/L4hbpHS8mc5mPH6dCZPxweVkVI
         JTug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sKNxcZnpQRKJin6AtPmQmdcGPEHcDYeHh+yBhiH6NjM=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=VpHZaonyQpIuV9XVSHNvk1WfutXm0PNNHt0moRH+VjnZUnJeJt2POrfNX7HCEBebNQ
         T1rMcH9/E6biKS9MocCzWwnqMokUYe9Ho+PFU0ispF9gn3cUWdpT5RJYNLEmVcYb2gsY
         o7h7YFJTOF4Fitx0PVMgCa5AYfKStSNzTmfBGrNz+bpCnfzt/qNlna57AGTIuCqIMZ/u
         umXjhMGzlsxahLnGznaqFXpI8T7hd8AAq9Wk7rNuepZnKbHpXeX3IRSBqOQx8YbYg+br
         NchHF7aUKO8e1tZ0J9EcaXTSqr8CrtCrZo16eVUDcbxy0Y7PohC+EZpLTSE0a8mL4Ujt
         NSCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776775606; x=1777380406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKNxcZnpQRKJin6AtPmQmdcGPEHcDYeHh+yBhiH6NjM=;
        b=cpf6520eTTvSOlFjYFwuwmdij2S0X5r1rbXelApl8YqewwE6CgvvXpqIvAMBlS5y3i
         +RYt23vEmkUZyZU5+QMHPaWQGgh08fIhK908a8CR86pHoATRO3Bmp0E6rd49wFDJK7zX
         kVpcTptkxCkhtXfqDcqmtwJMS1JRrmjy7u7UczbsX2Qte5vLK44hmTmdnRHWSTdzBdSD
         EXvoEgboTGiuDqk7olAAh7xal3Qc5sq10eab7W03Q0ChnS5A8AEkDhXR5SyqPs/IOBdh
         ctCw83GAGK2DIQY1+93tFg3Q+tkfMWtpxwUfbNEanmMQwzQ4f+ub8JV6dXO8Vp97WRWF
         Vi/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776775606; x=1777380406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sKNxcZnpQRKJin6AtPmQmdcGPEHcDYeHh+yBhiH6NjM=;
        b=Zci1LT4q+xnizey6vqfWTNw7iHZVe6KRhRH4REqgqt3XrKdWvi3v5utGLsRZxqTYCF
         XLZ1pvasQbzaW8RXPNmLClooOX/bk4DysqKck5HpIpKXrMmGNOzMzeZ1W9SxiB0nYprF
         NFLlb8VUPnt5n6Zx0hgRKse8zl8Mef2Ik0PJO5BStUxzNu7zCmgvrLIyvri0AvhyGPQk
         Z25eiERQvwBXbJSf7jyxMpFMpwgsfjhLc5RsFqBXq14wCkkh/rtT45LgeIeDt7BKa/2B
         YSQ3usVbK+RBaVnYv+jgTSFLxzgNqbrpHM5IqiTZfrmt/TsQLGhewWkwv6MGLhpmyauP
         NE9g==
X-Gm-Message-State: AOJu0YwVjDv2pOBkfEFrWJTXzuKVvxd2rCjjr1SsZtn6J/Pm+dXyToJC
	c+5utKGFPZ7FV7yqZFRIFQDCMvsxWZfAj1e/hGPnlvChIc3tYaraTI8J1xWniAO85cxdxJjS1LL
	wotkagEDyA3/9yIEiX8yNMWsmvPm3VqY=
X-Gm-Gg: AeBDiesAUZxjGes5xdI8XPgs5gqlwxpr7wjpeOYQboZfpcVbBPfF9U7bczmV0klusGu
	8QEpZWii//55yxwdemveiQfFlJt3VcgjCXHaVOqwWIs/lglSjbzkxDzMkz3nAWkr0083yWS7nGQ
	RS/Uq8i7GEfNeoywgrFv8sQJoKneuSjY2VaOeHU7oHnFBT5RxnzOtsdWJXfP5K6GsgpMqdLrmif
	+GXENZ5OgQ6IeK9b2kJzZ0PYQRb3XKA5nqIsJrQzLIBS1Opcx5y3wRV0YREY+cH2dkXQlXlci29
	GjW1F5TmSA1D9pdZowvonokEyYgw
X-Received: by 2002:a05:6512:108d:b0:5a4:1add:c583 with SMTP id
 2adb3069b0e04-5a41addc69dmr4897729e87.41.1776775605928; Tue, 21 Apr 2026
 05:46:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420082805.14844-3-kerneljasonxing@gmail.com> <20260421094023.69C89C2BCB0@smtp.kernel.org>
In-Reply-To: <20260421094023.69C89C2BCB0@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Apr 2026 20:46:08 +0800
X-Gm-Features: AQROBzDiVgJ0CPRwqId_m8MuXK9Bi_etdxEb0Yl49zkSHWCrwCFfuDGYPB07vCI
Message-ID: <CAL+tcoCXK=rjLQ9-1K-MRVvbfN_DSr8XP+mY5XnyrGUwCpFBsw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/8] xsk: handle NULL dereference of the skb
 without frags issue
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 5:40=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 1 potential issue(s):
> - [High] Memory leak of newly allocated skb in `xsk_build_skb_zerocopy()`=
 on error paths for the first descriptor.
> --
>
> commit c0083470d60454acdbd801635be8f00a9b79a9eb
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> xsk: handle NULL dereference of the skb without frags issue
>
> This commit addresses a NULL pointer dereference in the error handling
> path of xsk_build_skb by explicitly checking if xs->skb is NULL. For the
> first-descriptor case, it cancels the CQ slot and tracks the invalid
> descriptor instead of dropping the skb.
>
> > In this series, the skb is already freed by kfree_skb() inside
> > xsk_build_skb_zerocopy for the first-descriptor case, so we only need
> > to do the bookkeeping: cancel the one reserved CQ slot and account for
> > the single invalid descriptor.
>
> Is this description accurate regarding the skb being freed?
>
> Looking at xsk_build_skb(), if xsk_build_skb_zerocopy() encounters an
> error and returns an error pointer, the local skb variable is set to
> NULL before jumping to the free_err label:
>
>     skb =3D xsk_build_skb_zerocopy(xs, desc);
>     if (IS_ERR(skb)) {
>         err =3D PTR_ERR(skb);
>         skb =3D NULL;
>         goto free_err;
>     }
>
> Since skb is NULL, the cleanup code at free_err is bypassed:
>
> free_err:
>     if (skb && !skb_shinfo(skb)->nr_frags)
>         kfree_skb(skb);
>
> Does this code leak the newly allocated skb and its sk_wmem_alloc charge
> when xsk_build_skb_zerocopy() fails on the first descriptor?
>
> I see this is addressed later in the series by commit aef1b3344bd95
> ("xsk: avoid skb leak in XDP_TX_METADATA case") and commit 93315725e1616
> ("xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS"), but
> the commit message here appears to incorrectly assume the free is already
> happening.

They are already fixed in the series. And what I mentioned is "In the
series,...".

>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 887abed254668..54d4895fc11eb 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
>
> [ ... ]
>
> > @@ -973,9 +973,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_so=
ck *xs,
> >               kfree_skb(skb);
> >
> >       if (err =3D=3D -EOVERFLOW) {
> > -             /* Drop the packet */
> > -             xsk_inc_num_desc(xs->skb);
> > -             xsk_drop_skb(xs->skb);
> > +             if (xs->skb) {
> > +                     /* Drop the packet */
> > +                     xsk_inc_num_desc(xs->skb);
> > +                     xsk_drop_skb(xs->skb);
> > +             } else {
> > +                     xsk_cq_cancel_locked(xs->pool, 1);
> > +                     xs->tx->invalid_descs++;
> > +             }
>
> Because the skb wasn't freed as the commit message assumed, can a
> malicious application exploit this missing kfree_skb by repeatedly
> supplying abnormally large descriptors to exhaust socket buffer memory?

It can happen but it doesn't belong to what I should here.

>
> >               xskq_cons_release(xs->tx);
> >       } else {
> >               /* Let application retry */
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420082805.14=
844-1-kerneljasonxing@gmail.com?part=3D2
