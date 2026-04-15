Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DEC1514F8
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259198; cv=pass; b=pjjwzsiR8u6XFrisp1cgj85Nu5W9at4MU29uJsk6/56PfkOeloq/blENWfajT1myXFDdfUAZYJSLkU4TMnSz8sqPuygWSzYlS6UoiWxosvMlYymivI7dzFURQPDrEu51Bd4m4zoXj3RdFG7b1gC/l/8KecHKcJrrt7vIq8qOyPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259198; c=relaxed/simple;
	bh=cVvVDK2MRWzZyXz3GUm3WQXQ9PZPcYLa/itSN6r995Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AG64TUotISG+QXE/XdgLmT1iIpcJm/ruYzRvTqlNn1TOmYwDtYtq47R2UWA5PsZMW/H0pZSv4aoXWZa24+G3yZz7YUGRIY9582S3F6qUrqX9I+lueDhX5/ZSuVdPdvwlGMqdChjO9e2XkJE098q70FHhqLHsvyrNPTCRkN0IdS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXEFxcfu; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXEFxcfu"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2dec803f9f0so238201eec.0
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 06:19:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776259196; cv=none;
        d=google.com; s=arc-20240605;
        b=j3YaQWqjeSKVDKOPy+udbumJ/2WVYyWumsDVSiSKlnUT3AqF60sjsvu4xoMm8HlDCF
         UFybcaKKDDNykwGVmMUfrfT7KvJ5X6laTmLtrh1qTSYmjJWFGBNTQq1hPQ+zVcyTp92g
         sBlLTHzPuTCwKri0qtp0edWXomZewRaUJdO0n6oyAd/QfzZDrbe28TZsEc7kGpwny3O6
         tAW2an0/RZKSbarRnFzPHV2FUCzOZu/CyfKDw5lHbCgwLQBaEr96LHWzHAapn5JLv25z
         izFIHEsEkOn94RlIpiF5Y9pl8LLmh1LQHS+otqV0OGxENqGmjb6jpEu4TOhtjvsp2Clc
         Covw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=reYav/f2RX+zYG9Jz25IFXarapNrYkmH4ZhSUflT7K8=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=PMt+p4E2xLJ3l8SOciqgaeV98WnoHNVXClU9VcKtJsN8LH7iOc062rd0rUR377DCU/
         a5GjmfSw50wTF3H2eeSVc5jsuPgjBWzeRXV5Y5VCR/qK7UhDlJnfnO/8FCzxO0rQDbMY
         N0wum6y7IPL06YUVAgmiRfSQh0CIyqulkwcZBShoLeAFgYhWMcFeLQtIFqvrxjQUtmGn
         ARNUrs2atdEUbzN5J9YTvIrGTuAGWbDHUx8yzpON3EVzlKWvs+Z8qFQKfOf1ztoHQ9a7
         4RETrYSKawxhNsQaBawpn2498WJe+0zif1PpENn/UuOAl9yEWdobTA5DdRXw6PDOfCmx
         9NqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776259196; x=1776863996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reYav/f2RX+zYG9Jz25IFXarapNrYkmH4ZhSUflT7K8=;
        b=lXEFxcfu//HBvVSNqmT3i4XNVCaAMh+Cv9WkoQ+ceRVEgyWVyI6CQIXmAux0Mba8Yh
         C+QUZhf96COYaGiRqjWVQ4HJWUhVug03QxBMb7WRulHEDfB2y9jEvx0mxR6+uFy/ZUD/
         4wS0QbFLmQrymDHSaxRhN+G6Mf7zmKfqAQJ6i434qOWMTjeJxK77XMHimAGmoJPFYsiP
         ocy6pWPaSLLGUFl38Mgifwa83g6yRUs0dc/+/G4IERnS4VzR1pXZpyXqzq4V8kE2ztol
         EqmyYOKqmwbK3ZwXpf4Fdrkll2mpXRz58FsNIkkQD878iMw83FMGS8A51cjyd+QwxIIH
         fmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776259196; x=1776863996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=reYav/f2RX+zYG9Jz25IFXarapNrYkmH4ZhSUflT7K8=;
        b=R0NUAH2lawPsYHAPXDfNrijjBJqKOEndBVdezJQdTIoyq0VmAaub/c9ItnilnIHWCs
         n2CI8F1YFENeI9084SE0ezLbEVj772IpspjdIJ9Zefirm47Zrp3GvKze7xWR7cK9tuTp
         GP1TaV6A3YG+ySKn0lfiw5EJ/rBiwezshKY0xTP/6aX5nII31I7gkH1U/XMU76HzrPB2
         7jlJI405yWC0v/ZOWP2SECYibRNn007hRUwAgUzBVAbw0hu8IMiri6e+RmWULoO3sLII
         ogv2ZEKlDvHFt/u2XYu4OKfc91TfYyini9avFcvVcxppukMxbadUqpIbuHa9XafvhhB5
         D3pQ==
X-Gm-Message-State: AOJu0YzUpDTL5NEneW3BZNz6wIRB+GxgpvtTzfydlIVDHoyYhsssWKB8
	wv2TqBbshAgWAxYEWyVgEIG5wORzuED5rHTqkF0VSBKi49qtWesaE5ooA+cKBE4zu+2nzlKwbJp
	Tut7P1EHaiyZccCmkWGvfSiyjgnopZZtDNACWUjeKZzAY
X-Gm-Gg: AeBDieuMuJEV3DN7slgm/4C+4nqIeTxVsNL9aRkUJimlw7qv6T3P5eyCgE5yOpc/6yE
	VMMk8b6ZGef/6RYJ07DlZNWQetkJW4k3KY0Wm1npaZIB3cLAzhLVGo9C2Jeyc7BHk2D68sXwg9C
	tb8xjqGKBzqjNgl74RhoQ/fdzHYWk3DuRivcFpf6wMtyeLxLhAwmkOTOPbbkErOGh1+1boRYPB4
	hwh69+60KPGHziNi3UlweAkxG0MlXwccLAnF3Sl8Ym/ZqZv2SDyKe/81O/1WUBuE8Pa5+d2ZXIq
	uxnQOVSliNLnmO9fIA==
X-Received: by 2002:a05:7301:4196:b0:2de:ed01:550e with SMTP id
 5a478bee46e88-2deed109858mr666443eec.8.1776259196005; Wed, 15 Apr 2026
 06:19:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415082654.21026-3-kerneljasonxing@gmail.com> <20260415085204.3F87AC19424@smtp.kernel.org>
In-Reply-To: <20260415085204.3F87AC19424@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 15 Apr 2026 21:19:15 +0800
X-Gm-Features: AQROBzCTbko2gkyRBF0aL5pTN-Jlo3x3SnxbUODTV8U0Vj3aNOjitv5gNgR5c5Q
Message-ID: <CAL+tcoDS_R9AFX1jJCuO0ikk23g6e0WLMayUUZyUEYrWVhcFSA@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v4 02/14] xsk: extend xsk_build_skb() to
 support passing an already allocated skb
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 4:52=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 1 potential issue(s):
> - [High] Inconsistent ownership semantics of `allocated_skb` on error pat=
hs lead to a memory leak in the zero-copy path.
> --
>
> commit a6016c1c59927d7e151f38b7f237ad699db86b1e
> Author: Jason Xing <kernelxing@tencent.com>
>
> xsk: extend xsk_build_skb() to support passing an already allocated skb
>
> This patch extends xsk_build_skb() to accept an allocated_skb parameter,
> allowing the batch feature to reuse an already allocated skb instead of
> allocating a new one.
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 1194268ae8676..becc8ebfd82f8 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
>
> [ ... ]
>
> > @@ -793,15 +797,16 @@ static struct sk_buff *xsk_build_skb_zerocopy(str=
uct xdp_sock *xs,
> >       return skb;
> >  }
> >
> > -static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > -                                  struct xdp_desc *desc)
> > +struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > +                           struct sk_buff *allocated_skb,
> > +                           struct xdp_desc *desc)
> >  {
> >       struct net_device *dev =3D xs->dev;
> >       struct sk_buff *skb =3D xs->skb;
> >       int err;
> >
> >       if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
> > -             skb =3D xsk_build_skb_zerocopy(xs, desc);
> > +             skb =3D xsk_build_skb_zerocopy(xs, allocated_skb, desc);
> >               if (IS_ERR(skb)) {
> >                       err =3D PTR_ERR(skb);
> >                       skb =3D NULL;
> >                       goto free_err;
>
> Does this leak allocated_skb on the zero-copy error path?
>
> If xsk_build_skb_zerocopy() fails on the first descriptor (e.g., if
> xsk_skb_metadata() returns an error due to invalid metadata), it returns =
an
> ERR_PTR without freeing the SKB.
>
> Because skb is then explicitly set to NULL before jumping to free_err,
> kfree_skb() is skipped.
>
> While the original code also had a leak here for internally allocated SKB=
s,

Awesome! sashiko spotted a real bug prior to the series. I will cook a
standalone patch to fix that first.

Also I checked the MAX_SKB_FRAGS situation in xsk_build_skb_zerocopy()
that has the absolutely same issue.

While reviewing the whole destruction of skb in the error conditions,
I realized that there is one problem in between patch 2 and 13. Here
at least I need to add the following codes to make sure no wrong
accounting happen:
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 3bf81b838075..19bc786decbc 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -904,14 +904,16 @@ struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
        if (skb && !skb_shinfo(skb)->nr_frags)
                kfree_skb(skb);

-       if (err =3D=3D -EOVERFLOW) {
-               /* Drop the packet */
-               xsk_inc_num_desc(xs->skb);
-               xsk_drop_skb(xs->skb);
-               xskq_cons_release(xs->tx);
-       } else {
-               /* Let application retry */
-               xsk_cq_cancel_locked(xs->pool, 1);
+       if (!allocated_skb) {
+               if (err =3D=3D -EOVERFLOW) {
+                       /* Drop the packet */
+                       xsk_inc_num_desc(xs->skb);
+                       xsk_drop_skb(xs->skb);
+                       xskq_cons_release(xs->tx);
+               } else {
+                       /* Let application retry */
+                       xsk_cq_cancel_locked(xs->pool, 1);
+               }
        }

        return ERR_PTR(err);

And the above part will be removed in patch 13. It prevents someone
from bisecting in between two patches and triggering the issue.

Thanks,
Jason

> this patch extends the issue to caller-provided SKBs. In copy mode,
> xsk_build_skb() correctly frees allocated_skb on error, but the zero-copy
> path does not.
>
> Could this lead to memory exhaustion if a caller assumes xsk_build_skb()
> always consumes or frees the provided SKB on error?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415082654.21=
026-1-kerneljasonxing@gmail.com?part=3D2
