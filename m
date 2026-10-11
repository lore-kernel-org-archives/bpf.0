Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB252FE074
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 23:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791762674; cv=pass; b=LCeSiVuMUbFFf+zk/iuMqHHy3Yc7upnqR/fKFlxZBFHzVEkONRMZwgF3lMdoFPd91JOF8TwG9xp25YYrLfTh64tJhpCeg/pf2e8UzMRaUmfe1ZjWe87hL6/jHiRFa92J2yNOFZ8TDL6QZweVeg0gQapnVj6o/5UBf1+tcxSSBRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791762674; c=relaxed/simple;
	bh=l8l/HrqBWeizsx+Ga7Gg5ptkYIKPinnsVS7D23mXjpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ViDmeaSVPco2D0p2oVm7ZvMcPRXHGvle9eEWsaImMC7Z9yjSECCVlfns7VDP1gBIHAA5SBRpzuwDN8lLONKAOcWgEsPLzicMooOe1Hw1DeiIb8jTtWQKQczp8qs12E2SYKIGEUOaFe+WCUAyqjuiEValyOXjYwY+Oa77BPOBlvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=mjF4e3VZ; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="mjF4e3VZ"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-88bd2b44f3aso541027b3a.0
        for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 16:51:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791762671; cv=none;
        d=google.com; s=arc-20260327;
        b=W3gMSfyEKvic9Z6tPk7UcTPR87Kk8q4TKuX0VzuxtG//Bh7j1XmeYRmJHY4OpMqPTi
         FQlT8OlyDB5cAsEooawdRgNvgP1GlInJX/Ab+1cxx3Nt7ItAnWXTfpJsxqdLl8L8yOwf
         1A1s9KMpOK5Wyhx19BHLsv3MlbjudJcGHOthFy/2TcH63EuXn+rt9bJdxOxWVpuOuqX0
         9PlT6PbHqPKWYbI41OVcPk21g7tz2NvDNuVlrSJ3NvQ8AqLJpiyGeiTw3E6gNpuRtPgW
         B5+LhoQ1iUxw/bWBkzZpVCr44LsAM0arY9iROLl5ssX2NGCwFrBI9JTnflC83KxAUrMf
         P4Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pv+XIWTeBsaSRyVk3l1JDv5LX9sq7m1fFmfHjL2yJDQ=;
        fh=ii51oYZ5/LYNN/8mNsLVr2l4YoKKuL/lJEhUsBZvX7Y=;
        b=DVx+48ux4T9W/f3C0dpG0hly4cDnP00zIKmBXPjzoK1EZosOnyKuX1xOiVuvX3Kvqh
         /ey9uxJY53Ir7We2xGzHGJdeQMFRoehTkEkAuXquuhGHr1buja0X6l3vKeNN9alLiiSU
         I7qpDNOArrQKzQWleSOlyTIt4lwEC7QR4r7ISsJdcRvB6WGF/QxhLYG7ota7baqEzQnb
         9f/AeFNESm4CpZrOavMQ7N7/Ns/Hmhw7zzM2UQwClv4PK6diCqforUtdM6czHyUbensr
         Ku5jXLyax0dL3wVZlEaBPko6ZtV4MMIwRd/xD/9d8mnmYHh/XKCQXKEvbJcXBX05kFYc
         ff2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791762671; x=1792367471; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pv+XIWTeBsaSRyVk3l1JDv5LX9sq7m1fFmfHjL2yJDQ=;
        b=mjF4e3VZT9IsywRPi0RGuRFEcD4U9V2vTwkriESumXEpHHKP2ovllsYou8gbzb6g/L
         2VOwXkYMHniRLxm5QuPq0q/IFy7NMrIeSk+FLKjYlSdFUJtoJotbcVWjK7zZwsIFKjDc
         fCXo6V8LjneYmGEs1c8hxIxOlfYOtEFrPlXqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791762671; x=1792367471;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pv+XIWTeBsaSRyVk3l1JDv5LX9sq7m1fFmfHjL2yJDQ=;
        b=s99Hv4XQ7B+Df+XFT9tubqFDT3/XF2oKUPXHY/ym0G0d7EVU8Cl7KfJ5+N/M9MfonS
         gRB5/eqIfqnXTv56C8A//nCxDfXT/gEvr8P0+oZwxaNW7hyBIM0vJ67zTidN+IyTz9rD
         JHqfN9kKHjfWaKOvw9pY8mshLLHpW14NvRIa3p03es437LFjrcFSe+X+SnpfLYtzto+q
         1dCD0KYhzU54dqn9+4BJtl9MH0VNTrs67+X3zH5vUkd9oKOn4ZrMqfi+AV9HEWezGc8B
         Ys+BAbcAUP0JMq6drCr94LCI6zYIua01jDcj2Q036GNpUM8R/Fca8UJbDnJzyO6RNbv9
         GxWg==
X-Forwarded-Encrypted: i=1; AKwUvBzlgcfNe21Cyg5ygMNW9N/ShQrUTBPBzlJM6zbJMMxUrIo64BlaQRncmCq5Fw+5FtxVUNA=@vger.kernel.org
X-Gm-Message-State: AFq9FYINLFJEkizH9Ah3qse7gctIwTilpXyucguUUbuiBQ/QyVhT9e1/
	vdDzVmYLZXYOJauZh/HfimSFTj28Mc/mHSrvO0Q/C3DMhwgrC8RB8DorVAywokkhuN62IqENDVd
	dBKmHJpDedzxuZw6De3h017USb8F2ebtJjIZqetMH
X-Gm-Gg: AYBFou2sSIQEV1RPwUTFnRC02vca96PAWBTDlmDdnNy6/L+bFnEEIMAPpWYajeSxs5k
	IvZIUC0cN3+bxTiDNOiiwAi2aN6i9ztTq9wKOTvf0EQgOXAI9Fg3+4jGnAQePWaw59XtjuJZ77n
	onqCECwPWeXsUUaQDDKKmy1Cbx8duW2uxDHoeTzxnNTWB1GGa0FtcoH2GsE9Op9JZVBv4uVip/8
	xn7Y4wWg18TpI9T5eU8R/W2cA4wrjNUdgw/HYr6fZKWmCuiFPynIGs4GrQVRrg1yE4VApswLwHT
	5x0jRCYjZ6MZcKl0RFPBKc7Zxgh3ThCrvKhDmmbl8yEBocUouw8VM4SqT5k+QgvciE8/e8WlYaq
	hp/LGlhTAN5fWw/+hrb4TANwq9BBWe7l3zA==
X-Received: by 2002:a05:6a00:c510:b0:899:3439:c8d5 with SMTP id
 d2e1a72fcca58-8993439cbb5mr2350953b3a.14.1791762671179; Sun, 11 Oct 2026
 16:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-PYC7.v2.20261010165947-2@mojatatu.com> <179175260495.434549.13119281916864696711@kernel.org>
In-Reply-To: <179175260495.434549.13119281916864696711@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 11 Oct 2026 19:50:59 -0400
X-Gm-Features: AclHuK-SxmWspNCU_md_RXVs0LAR_-0Rb9D3vOeCSeAjqVZTGZQirYaXoj6RbNk
Message-ID: <CAM0EoMkDJzCm3Qwicas1Nmu0jLRQQjeh1x880-AoFyxhq=6+5w@mail.gmail.com>
Subject: Re: [PATCH net v2 1/3] netdevsim: reject cls_bpf programs bound to
 another device
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, jiri@resnulli.us, bpf@vger.kernel.org, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 5:03=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] On the tree this patch applies to, the bug described in the
>   commit message cannot happen.
>
> Pre-existing issues:
> - [Medium] Offload accounting imbalance when a shared-block late-join
>   replay is rolled back.
>

Unless something else which is substantial shows up I will not be
sending an update to this patch.


cheers,
jamal

> --
>
> netdevsim: reject cls_bpf programs bound to another device
>
> This adds a check to nsim_bpf_setup_tc_block_cb(). The check rejects a
> device-bound cls_bpf program whose offload device does not match the
> target netdev, and returns -EINVAL with an extack message. The commit
> message says this closes a shared-block late-join replay path through
> cls_bpf_reoffload().
>
> Link: https://lore.kernel.org/netdev/20260809094418.901607-1-jhs@mojatatu=
.com/
> Link: https://lore.kernel.org/netdev/QDISC-PYC7.v1.20261003103747@mojatat=
u.com/
>
> > diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
> > index 16aa882783984..e6799947db834 100644
> > --- a/drivers/net/netdevsim/bpf.c
> > +++ b/drivers/net/netdevsim/bpf.c
> > @@ -144,6 +144,18 @@ int nsim_bpf_setup_tc_block_cb(enum tc_setup_type =
type,
> >               return -EOPNOTSUPP;
> >       }
> >
> > +     /*
> > +      * A dev-bound program can be replayed here when a netdev joins a
> > +      * shared block, after the core attach-time check has run; enforc=
e
> > +      * the device match as nfp does.
> > +      */
>
> [Severity: Low]
>
> Can this replay path be reached on the tree this patch applies to? The
> commit message says:
>
>   The core cls_bpf attach path rejects a mismatching program, but a
>   netdev that joins a shared block later is replayed the stored filter by
>   cls_bpf_reoffload() before it is inserted into block->ports, so the
>   attach-time check cannot see it.
>
> In net/sched/cls_bpf.c, cls_bpf_prog_from_efd() does this attach check:
>
>         dev =3D block->q ? qdisc_dev(block->q) : NULL;
>         if (!dev || !bpf_offload_dev_match(fp, dev)) {
>                 NL_SET_ERR_MSG(extack,
>                                "Program is bound to a different device");
>
> In net/sched/cls_api.c, tcf_block_create() never sets block->q for a
> shared block:
>
>         /* Don't store q pointer for blocks which are shared */
>         if (!tcf_block_shared(block))
>                 block->q =3D q;
>
> So it looks like every dev-bound program on a shared block is rejected
> at attach time. Wouldn't step 3 of the reproducer ("install the program
> on a shared block owned by B") fail with "Program is bound to a
> different device"?
>
> If so, cls_bpf_reoffload() never holds a dev-bound filter on a shared
> block that it could replay to a joining device. A non-shared block has
> only one netdev, and that netdev already passed the attach check.
>
> The late-join path seems to open only with the companion patch
> "net/sched: cls_bpf: accept dev-bound programs on shared blocks". That
> patch replaces the block->q check with the every-member predicate
> mentioned in the v1 -> v2 notes. This comment only becomes accurate once
> that patch is applied.
>
> Could the commit message and this comment say that the cls_bpf patch
> opens the replay path? Or could they describe the path that the Fixes:
> and Cc: stable tags actually cover on older trees, which is direct
> attach before 120977e2c096? The code change itself looks fine.
>
> > +     if (prog && bpf_prog_is_dev_bound(prog->aux) &&
> > +         !bpf_offload_dev_match(prog, ns->netdev)) {
> > +             NSIM_EA(cls_bpf->common.extack,
> > +                     "program bound to a different device");
> > +             return -EINVAL;
> > +     }
>
> [Severity: Medium]
>
> This is a pre-existing issue that this patch did not introduce, but the
> new -EINVAL return adds another way to reach it. The companion cls_bpf
> patch lets a dev-bound program sit on a shared block. After that, what
> happens to the offload counters when this rejection triggers a rollback?
>
> Say device B holds a skip_sw cls_bpf filter with a B-bound program on a
> shared block. So in_hw_count =3D=3D 1, TCA_CLS_FLAGS_IN_HW is set, and
> block->offloadcnt =3D=3D 1. Then netdevsim device C, which has a differen=
t
> bpf_offload_dev, binds the block:
>
> tcf_block_bind()
>   tcf_block_playback_offloads(add=3Dtrue)
>     cls_bpf_reoffload()
>       tc_setup_cb_reoffload()
>         nsim_bpf_setup_tc_block_cb()   <- returns -EINVAL here
>
> The filter is skip_sw, so the error propagates and
> tcf_block_playback_offloads() jumps to err_playback_remove. That replays
> add=3Dfalse over every filter, including the one whose add just failed.
>
> With prog =3D=3D NULL the new guard is skipped. ns->bpf_offloaded is NULL=
,
> so it is !=3D oldprog, and C's callback takes this path:
>
>         if (ns->bpf_offloaded !=3D oldprog) {
>                 oldprog =3D NULL;
>                 if (!cls_bpf->prog)
>                         return 0;
>
> tc_setup_cb_reoffload() treats that 0 as a successful removal and calls
> tc_cls_offload_cnt_update(..., 1, false):
>
>         *cnt -=3D diff;
>         if (!*cnt)
>                 tcf_block_offload_dec(block, flags);
>
> Wouldn't in_hw_count then drop from 1 to 0, clearing IN_HW and
> decrementing block->offloadcnt, while B still has the program offloaded?
> Each later failed join would decrement the u32 in_hw_count again and
> wrap it.
>
> Once block->offloadcnt reads 0, tcf_block_offload_in_use() returns
> false. Could a device without ndo_setup_tc then bind a block that still
> carries a skip_sw filter?
>
> The same imbalance looks reachable on the baseline through netdevsim's
> existing rejections, which only apply to adds. One case is an unbound
> skip_sw program that B accepts (bpf_tc_non_bound_accept=3D1) but a joinin=
g
> C rejects with the default bpf_tc_non_bound_accept=3D0. Another is the
> -EBUSY "driver and netdev offload states mismatch" path.
>
> The root cause seems to have two parts. The core rolls back without
> tracking which callbacks accepted the add. Also, netdevsim returns 0 when
> asked to remove a program it does not hold.
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-PYC7.v2.20261010165947%40mojatatu.com
>
