Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A963EB0F4
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787826825; cv=pass; b=arGs2ipiz5YvMrm5F55ZMtHVCaHGAQon4CTvozr/JClRzxINrvSxQq7EXAW1gxEmQgBEOv2oprqBmck6iYta0UO6/zFGUJaTwKX7jknsTymn6X/fxo8ViFlXeUcxrwIJmTG400nThFg4Nl+S5Hy6MfnTZ4APf48HrapETSzEP9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787826825; c=relaxed/simple;
	bh=KGhnaUEwIzXBqIWGQ/6ZDCdDoFWPzxMEPr1HCeR4y58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHa+SWcF5cC/OWbm79uDlL/H/lQcBFqbo+HPBOeIpJ/n8JRZNJC6kzzb/RgZZxMGT207guBogb3fDfbrreHmG3xkvDPywX2GNtKIS1VwOw04Z4X2iBYE6vmhNqrj5itVg0qZ9IfmRHQkwsjNQBHOCKuRvnHLY6W9+MSG3LS7oLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rtNIAL92; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtNIAL92"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4a475409044so1148818b6e.1
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 03:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787826822; cv=none;
        d=google.com; s=arc-20260327;
        b=rwGVR7K4bIB9v6HJbkAXg6qb1Cg59CD/w9SS2Hm2SZ5gN4NnRpUQzFqB93I/I/TrVo
         yyS8moha3+Wl8AdV4kmXd9Rso71a8GUvTNwWjNtwZ2vTlg4N7BQBR4VTyZk2Rq2j7nDq
         sRx7gHrdxknblyl99CueDz+IWgu6ayDRT2uePEP6/QaTAunhRU3EMTtsmRhWOTsjJpCq
         3KW//W+6aKejUeZe6++/L67JsIukpkRxdzM7OTBsxsLAa+lxDzqDOfxNemp30OyCffVX
         gQ6qZgKnCRKf4cXjODLMCxdEBuK38pXYNOamUfVV/2giUaI2T/S3udpkp6JEsRzqdrpD
         2wVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/J4+zWslzd7v8Hb8+D1FNou+n4APw0wKKRPrdHi8DTo=;
        fh=cxPxur7mv34NR1eQbZTWZLe20AogUUVAJSmML7DR9s8=;
        b=jXOJrgq43b47dXhlYbICi+mQsh0i0B5CmotfxNsxNfF5Hxfuyn0cWziMQc5UT5kXj+
         oAMz9heLOTraYTWwYsxc5AT56vzMhyDSI/qdPHiO751kfVk1pfD4yEMuc//ijOWTYFE/
         uwcrA1u3JsDbk8D8uksEq2SYKjlQBV5ZL9acwMjhHG0G24CfcmSkFnElbKe9YM57NZdf
         +7jgAo+3jP4if7hyNwm7UFBMPQDRte43PHLDhA5bk7rLBrbZ8DV8ctCESJFwLY+eQ8Rt
         NpeB2IF5XE0MJBj1pZQ+JR50KUCCNaijbZcjYf3O0zCLAo2vTHILDjZNP1mJM3CWxTux
         tdIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787826822; x=1788431622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/J4+zWslzd7v8Hb8+D1FNou+n4APw0wKKRPrdHi8DTo=;
        b=rtNIAL92RKNaoNyj4j+PnbqwuwegrbQAPWMx1Jjf0jCQQHtpB8/bm32gA56vgpTGw+
         sW7MgjA5oTQJdov87ahIbJnBZhN85NIht1fYtBmYpaT0xLodSTE+xA3bIKW5hzur1gKW
         5V8VureJGC96y7zfqynqKXHbsMs0fSL1mwkyuto0vsu5OASRsHMfXzaU4+gH5aDk2d+X
         Qb5Druuh3H8SFhQiBGmap3VLPET3spfmJ+aYBmR7eMGBfwKWkB55hzYR1ylPjW+/SRxu
         7bRaBa5OvdtLS+4tiYHzJ6aEKUya+7WiWYKLeuzgU+v7fN4iwdI0zN/xUf7b/dVrnx+x
         8TgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787826822; x=1788431622;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/J4+zWslzd7v8Hb8+D1FNou+n4APw0wKKRPrdHi8DTo=;
        b=b4VOWvqMguGtKhD22DuaSSJmz9lchVY4Jk4Sp+YyCQWpIPXWtxWUMEGdb5fac5hGAB
         Mh3P5eTMNYh1x3q/SrL53heDzrL8+QjHCx1MCeYmCNldWQIKoMjrdZ8kySWki/X0JTL6
         D5wYkrnMUPr5u9CVooqUm0EghDU+OhsHBwuF8GiHqhlUpINQBqTRGDLsD1vUzDWa+rWt
         PRzWR8kTq6d3mbgr96qfvtfd6SuF7qsN3zOuGL/Ub7LS9NWK+umc1xQhiT1mkGwhKZFw
         YvuPuAro90u2Urfb/Zk7Gatooe5tISqjmrymc5FITdsTQx8QKu2CYptXN85fat3lEIZO
         DgbQ==
X-Forwarded-Encrypted: i=1; AHgh+RrVObhly7S7zpU5swZNwv2eAmu1GCTlZy3an2I3/rOubaaqsRXsP0TuVwAuIagMdl84+SU=@vger.kernel.org
X-Gm-Message-State: AFuF++n3Jl0YqF1ax74DjvZfTO5h/AE4ESYla0+Yz0zetMWlAfGuB6Yg
	4faO9J0O9wIEmz8i8Jv7J8cmJzcjpkYELuFGr734cNt0tQOB588YDnsDdErnMGXlNtBY5yb4Vlz
	H8WNOs5jW1PSeCIEnYr2UoNo1BOjx1XQ=
X-Gm-Gg: AR+sD116ZFmhUl42xdZd77XzilG+RU6XmWVkQ6NDwI46DXXzf0J5uRTXgwnunt5kgab
	pBRzDzZo6jAZQ+FfU3mZxrldz0uJPVaaBePXWqU2OBmdysEXYKXNaywxaEXhgrimuNTU7O6TEvW
	t/0B8IYHnRa3YxHTziYgi91APz5uXRg29J4uF69JHyccrNMzl7/R3/Kjv5yZP2TqYWdsO+JCO/j
	zbdjFa2lRSuk12XKYz5lftpY5GWR6C7IBLp7MQR86DEdopaUnYKkPTPuyLBhf2a76t+WR9OvGIa
	IJVeZMna0EuRfKc7G9+g5l9aiGi4Rdu1aMA4DJiiraws
X-Received: by 2002:a05:6808:c235:b0:479:f7e7:4a81 with SMTP id
 5614622812f47-4b36635caadmr13710332b6e.0.1787826821869; Thu, 27 Aug 2026
 03:33:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827051859.45511-1-blbllhy@gmail.com> <20260827053814.E0FFC1F000E9@smtp.kernel.org>
In-Reply-To: <20260827053814.E0FFC1F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 27 Aug 2026 03:33:30 -0700
X-Gm-Features: AcwNN1U6O7n56pozCKPz0ZzPS2sbkmywmMLVd2N2WSupAdPYymth3eZVW_zVk7c
Message-ID: <CAMB2axPQ1LVXNybsPY7RNa+12+7mtLaahvr0vFL-xHf8sbJK8A@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix NULL pointer dereference in __bpf_sk_storage_map_seq_show
To: sashiko-reviews@lists.linux.dev
Cc: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 10:38=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Socket local storage elements are removed from the RCU-protected=
 BPF map inside the socket's destruction path (`__sk_destruct`), violating =
RCU-001 rules and causing a use-after-free of the socket because the socket=
 can be freed while a BPF iterator is still using it.
> - [High] `bpf_selem_unlink_nofail()` concurrently sets `SDATA(selem)->sma=
p` and `selem->local_storage` to NULL, causing guaranteed NULL pointer dere=
ferences in concurrent `bpf_selem_unlink()` and `bpf_selem_unlink_map()` pa=
ths.
> --
>
> commit cabffb2f3787054c5c6ba2a413eaf5dc639ba23d
> Author: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.com>
> bpf: Fix NULL pointer dereference in __bpf_sk_storage_map_seq_show
>
> This commit addresses a NULL pointer dereference in
> __bpf_sk_storage_map_seq_show() during concurrent socket closure. It adds=
 a
> NULL check after re-reading selem->local_storage to prevent dereferencing=
 a
> cleared pointer.
>
> > diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> > index 1d295a8769fad..7228520aa2b6e 100644
> > --- a/net/core/bpf_sk_storage.c
> > +++ b/net/core/bpf_sk_storage.c
> > @@ -806,6 +806,8 @@ static int __bpf_sk_storage_map_seq_show(struct seq=
_file *seq,
> >               ctx.map =3D info->map;
> >               if (selem) {
> >                       sk_storage =3D rcu_dereference(selem->local_stora=
ge);
> > +                     if (!sk_storage)
> > +                             return 0;
> >                       ctx.sk =3D sk_storage->owner;
>
> [Severity: High]
> This is a pre-existing issue, but does this patch fully address the
> underlying TOCTOU race?
>
> If a socket without SOCK_RCU_FREE (e.g., AF_UNIX) is closed, __sk_destruc=
t()
> in net/core/sock.c calls bpf_sk_storage_free(), which unlinks the storage
> from the BPF map.

It looks like a valid issue that should be addressed in another patch.
Probably need to defer free in sk_destruct if local storage is used:

#ifdef CONFIG_BPF_SYSCALL
      if (rcu_access_pointer(sk->sk_bpf_storage))
              use_call_rcu =3D true;
#endif

>
> Couldn't a concurrent BPF iterator in __bpf_sk_storage_map_seq_show()
> operating under rcu_read_lock() find the storage element before it is
> unlinked, and read ctx.sk =3D sk_storage->owner? The socket is then
> synchronously freed by __sk_destruct() without waiting for an RCU grace
> period, leaving the iterator to pass a dangling pointer to the BPF progra=
m
> via bpf_iter_run_prog(prog, &ctx).
>
> This appears to violate the remove-before-reclaim ordering (RCU-001) sinc=
e
> the socket is removed from the RCU-protected BPF map inside the socket's
> destruction path.
>
> [Severity: High]
> This is a pre-existing issue, but might this only fix a downstream sympto=
m
> in the iterator path while leaving other concurrent map operations
> vulnerable?
>
> When a socket goes away, bpf_selem_unlink_nofail() in
> kernel/bpf/bpf_local_storage.c sets SDATA(selem)->smap to NULL without
> holding local_storage->lock.
>
> If a concurrent map deletion calls bpf_selem_unlink(), it acquires
> local_storage->lock first, sees selem->snode is still hashed, and calls
> bpf_selem_unlink_map(). Could bpf_selem_unlink_map() then unconditionally
> dereference the now-NULL SDATA(selem)->smap, crashing inside
> select_bucket()?

Callers of bpf_selem_unlink_nofail() (i.e., map_free and destroy) do
not race with bpf_selem_unlink() so this should be a false positive.

>
> kernel/bpf/bpf_local_storage.c:bpf_selem_unlink_map() {
>     ...
>     smap =3D rcu_dereference_check(SDATA(selem)->smap,
>                                  bpf_rcu_lock_held());
>     b =3D select_bucket(smap, local_storage);
>     ...
> }
>
> Similarly, it looks like bpf_selem_unlink() could use a potentially NULL
> local_storage for lock acquisition:
>
> kernel/bpf/bpf_local_storage.c:bpf_selem_unlink() {
>     ...
>     local_storage =3D rcu_dereference_check(selem->local_storage,
>                                           bpf_rcu_lock_held());
>     err =3D raw_res_spin_lock_irqsave(&local_storage->lock, flags);
>     ...
> }
>
> >                       ctx.value =3D SDATA(selem)->data;
> >               }
> >               ret =3D bpf_iter_run_prog(prog, &ctx);
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827051859.45=
511-1-blbllhy@gmail.com?part=3D1
>
