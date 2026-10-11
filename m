Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D7F367294
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 23:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791762707; cv=pass; b=AznYgxP8NoKTFe/eFs5DhRDuuLIG/v+pkhek8CRd2UcQpQeFjGAdSGiio+SJCidvUxb4unwMsQkhApxqMKCGBZMdnAyuz2J3gdyd8P4dSaUh90GM9M0mO//AOVW9mTsT/4TTdYGa9O31coGWXI99qBpDdkxBSWjnTARXehxvOrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791762707; c=relaxed/simple;
	bh=PUddo9pEFxTSjGXLyVs4rfryj8Najc6DKM5Xcj7JMFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMW+i14LWOdY2caV3i8yiPwdYjZVklYebcooZGkhC6BlCgH8KwS2hRJo7s6qblrLHTE65yYJ9ZKsFYV0Ka/qUKspPAKy7IgJteD64V0jBjFtbfIfvY14rPv/DoZn1/Mghyy3ncjzhmN9aGTc74CE7ZlLcN3Ze8YKgOT5weeW5mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=yra3c78X; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="yra3c78X"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-88b7d853b11so743596b3a.1
        for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 16:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791762705; cv=none;
        d=google.com; s=arc-20260327;
        b=juROhfMEawjpIRcGTbiKWJ/+d6slGxM1POFvMJMiTHJ84LyuNgapR62duOon5lmImc
         lHm/waBXXofkt/A+efk/tVEDUvZiHOP+JoOWhfCSq2xCT7rchrzY8RZdgQHjUGUo5ltl
         PlOhFLqlrYep9/nDkKxkjmAcfD+VB1bS4Wmc/rWcNBulUxBj6F5ikfMXoriRxl/cKT25
         WpTlL6+Uk6bAtgR37PLxvdenTSn2Ht/FVdvSX3O/oKOrVQbTqtFM0zDGzGEfdYTr0zRP
         twoeOqt/3VR6vDSm09s6oDohsTYRcSAcduvTkRhHae2GGqIi7+2iw0BQHd7IW9dMrLIZ
         2xLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7rt849pVW8bnk+JyEXheFpVHzRjAqfDz2Uy0+F+vJn0=;
        fh=E2tqKUMIlzlUxZxgUTNS884AWTpRcAsdGP5t6WLp0W8=;
        b=njGHRdf5Va8GCKP8wxrd1Y9VxRAcaPHs30NGCeTkhd0lgbrU/Lu6Y3dxAHPqf+yqBe
         ipxTcKbBN2LnTliX16zHBVH95SzrusVUQPFWADNF9iS+s5ZNylWxL67GSTCViqlpveLi
         ENtgKzd3mayPtsj6IcfOd0XKvbFGT9o9hiIkXNNlM79Q1Mn/t6SfbqAk39XtDNlbLZQX
         tgLA/f9FvKRC7k9zU0MXWc3bcUO/HNecBOgjf99No0oOxJHe5/sCOwCMoScMK3FTtULT
         X4GaXxxLVlTRV+4rKFgACtkcbUehnZ52QoRWGrGucqnSRSGX8tfMFblgmf1/aSKKC1FX
         S9cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791762705; x=1792367505; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7rt849pVW8bnk+JyEXheFpVHzRjAqfDz2Uy0+F+vJn0=;
        b=yra3c78Xvm7neZqmFUSw+ORyKK/r0eGeL9BA8ZDaXb/svOwmjeGPRxuoQ7e30/glpk
         4q/RpMgg0TYDHrf0dDm9jjsW9SbYjOGXLsrF47fwjjij82MjCprc6N52b0ZpcomBDBAQ
         jAsKSy3S1fg0If1HAScE4kumTmr0pKOA9QlEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791762705; x=1792367505;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7rt849pVW8bnk+JyEXheFpVHzRjAqfDz2Uy0+F+vJn0=;
        b=GB53WXPaa8XNPr/hNg1JBk1PK+8G6FhAkT0ZrjdWS9LZiPiweKgSb5IzXGDRogzUfd
         GY6+0C6ADrHvZQFA4j1fhHTFdRT7SLylqx58ATm8SA2IdPq1gH8djKDZmO8avs1aHhGK
         1lEXimdQB7LONgTDT4WPoAU28TSHzAoJiJgsWeR1ald5JNsdr9BzHGXpNN2M0J8MXH21
         mMGdu8A/Y09Gy5kWNstkepU/Ukxouw+J02xrSU19rl0MquMwgDbdsCeuNWkRaHMmVKC0
         K4r1hslaj3c+4f+mdVpNzed602kxbnWBwiNyJJsvSy/7v8mbdlcTtEhczcG3HeQRxK6a
         Goeg==
X-Forwarded-Encrypted: i=1; AKwUvBzm+I8Ho9jdNrt+A73TSx11ZLlw09rfDH9J3KxryKu4wa1blBhLPx9EDcR3524RpLAHm5E=@vger.kernel.org
X-Gm-Message-State: AFq9FYIsmepb+o9UPyYvx5c43nJ3p1vUS4YbjVRqG9XqiJV+55PICxwm
	8GOCivzZ/Z/dqU0XLjWmy2McQM1MkrqB3D5y0ogAYALQ5kpexRABshvSI5mF34A9W8oqx9tOUYk
	bw3IIm7kLeyFfFk39kzdVLgMEB/6zur0o/7kGaEOH
X-Gm-Gg: AYBFou2ZKuUkYQ51PucWfdBPHMrYMA32iEDkIUg6la60zXWRhif6n8wJ3l03AKjB0Ui
	D7gYNorZvXGC9QAvQvp4yLdTD/FbhCD0rIM1pwmeOVd4e2FlJRs/3bxTwFEHB4LilKRFyLilruZ
	KRhh6VC+gZI0KZfvKp2MjuXLuRWW1DvgfevJ4Bf+mNAAARSSDzY4OwUMvIFgFU8XZhHwF3g+gME
	/V6VEJcc3nwPE8iBvhf62wUSfhX1xNATJzbpHMf8lfrX3W67ZriWAHo478DC8qnhk2e2bqNQ/V2
	6CGeEyuPHKBx8iNd9PSzKqg5TDG/XOZW/IiP9/ruWlQUCUzztM2CsuxQCwPZSO7N/XQxdq9ck0v
	81wrLAocYaE/wJuvfbHEH2kQcoSnzfxx1cA==
X-Received: by 2002:a05:6a00:1808:b0:893:4980:630e with SMTP id
 d2e1a72fcca58-897c79deac0mr6891127b3a.31.1791762704699; Sun, 11 Oct 2026
 16:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-PYC7.v2.20261010165947-3@mojatatu.com> <179175260626.434549.15434445852177291195@kernel.org>
In-Reply-To: <179175260626.434549.15434445852177291195@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 11 Oct 2026 19:51:33 -0400
X-Gm-Features: AclHuK_kjRfGvpSY8DvEfGEK2PVebcmLN2BToIWowkJX17XUAuoVSLI30UV31Qs
Message-ID: <CAM0EoMnWNnzLt+3fxq1ahvuzLb1vjLT4k5H-nojLpvkBLmtw1g@mail.gmail.com>
Subject: Re: [PATCH net v2 2/3] net/sched: cls_bpf: accept dev-bound programs
 on shared blocks
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
> - [Low] The v1->v2 notes say: "Style (gemini + nipa Low) -- FIXED: the
>   shared-block comment opens with /* on its own line." The diff does not=
=E2=80=A6
> - [Low] The commit message ("matches every netdev bound to the block"),
>   the code comment ("require a match with every member") and the extack=
=E2=80=A6
> - [Low] The stable metadata does not express the patch's known
>   dependencies.
>

Unless something else which is substantial shows up I will not be
sending an update to this patch.

cheers,
jamal

> --
>
> net/sched: cls_bpf: accept dev-bound programs on shared blocks
>
> This patch follows up commit 120977e2c096, which took the target device
> from block->q and so rejected every dev-bound cls_bpf program attached
> through a shared block. On shared blocks, cls_bpf_prog_from_efd() now
> walks block->ports and accepts the attach only when
> bpf_offload_dev_match() succeeds for every entry. It rejects an empty
> block.
>
> Link: https://lore.kernel.org/netdev/20260809094418.901607-1-jhs@mojatatu=
.com/
> Link: https://lore.kernel.org/netdev/QDISC-PYC7.v1.20261003103747@mojatat=
u.com/
>
> > Fixes: 120977e2c096 ("net/sched: cls_bpf: reject dev-bound programs bou=
nd to a different device")
> > Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> > [ ... ]
> > Cc: stable@vger.kernel.org
>
> [Severity: Low]
> Do these tags give stable tooling enough to backport this safely?
>
> Commit 120977e2c096 carries "Fixes: 2b3486bc2d23" ("bpf: Introduce
> device-bound XDP programs", v6.3). Stable trees from v6.3 onward, such
> as 6.6.y, can therefore pick it up and inherit the shared-block
> rejection.
>
> This follow-up iterates block->ports in cls_bpf_prog_from_efd(). That
> field was added by 913b47d3424e ("net/sched: Introduce tc block netdev
> tracking infra", v6.8-rc1), so the patch will not build on those older
> trees. They would keep rejecting every dev-bound attach on a shared
> block.
>
> The ordering against the netdevsim patch ("patch 1 must be applied
> first, including in stable") is only stated in prose. Would a version
> bound on the Cc: stable line, or a prerequisite annotation, express
> both dependencies in a form the tooling can use?
>
> > diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
> > index 188cf0f949dd4..07ad9556889d4 100644
> > --- a/net/sched/cls_bpf.c
> > +++ b/net/sched/cls_bpf.c
> > @@ -392,11 +392,31 @@ static int cls_bpf_prog_from_efd(struct nlattr **=
tb, struct cls_bpf_prog *prog,
> >       if (bpf_prog_is_dev_bound(fp->aux)) {
> >               struct tcf_block *block =3D tp->chain->block;
> >               struct net_device *dev;
> > +             unsigned long ifindex;
> > +             bool match =3D false;
> > +
> > +             /* A shared block has no qdisc of its own, but it may bin=
d
> > +              * several netdevs and the program is offloaded to all of=
 them;
> > +              * require a match with every member.
> > +              */
>
> [Severity: Low]
> This isn't a bug, but the v1 -> v2 notes say:
>
>   Style (gemini + nipa Low) -- FIXED: the shared-block comment opens
>   with /* on its own line.
>
> This comment in cls_bpf_prog_from_efd() still has text on the opening
> line. The only new comment in the series with /* on its own line is in
> nsim_bpf_setup_tc_block_cb(), in the netdevsim patch.
>
> Was the style fix lost when v2 was split into three patches?
>
> > +             if (!tcf_block_shared(block)) {
> > +                     dev =3D qdisc_dev(tcf_block_q(block));
> > +                     match =3D bpf_offload_dev_match(fp, dev);
> > +                     if (!match)
> > +                             NL_SET_ERR_MSG(extack,
> > +                                            "Program is bound to a dif=
ferent device");
> > +             } else {
> > +                     xa_for_each(&block->ports, ifindex, dev) {
> > +                             match =3D bpf_offload_dev_match(fp, dev);
> > +                             if (!match)
> > +                                     break;
> > +                     }
>
> [Severity: Low]
> Does block->ports really hold every netdev bound to the shared block?
> The commit message ("matches every netdev bound to the block"), the
> comment above and the extack text all assume it does.
>
> In tcf_block_get_ext(), the offload callback is bound for every binder
> type, but the device only goes into ports when tcf_block_tracks_dev()
> is true:
>
> net/sched/cls_api.c:tcf_block_get_ext() {
>     ...
>         err =3D tcf_block_offload_bind(block, q, ei, extack);
>         if (err)
>                 goto err_block_offload_bind;
>
>         if (tcf_block_tracks_dev(block, ei)) {
>                 err =3D xa_insert(&block->ports, dev->ifindex, dev, GFP_K=
ERNEL);
>     ...
> }
>
> tcf_block_tracks_dev() only accepts FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS
> and FLOW_BLOCK_BINDER_TYPE_CLSACT_EGRESS.
>
> sch_red binds shared blocks through tcf_qevent_init() using
> FLOW_BLOCK_BINDER_TYPE_RED_EARLY_DROP and FLOW_BLOCK_BINDER_TYPE_RED_MARK=
.
> Those netdevs own the block and receive the cls_bpf offload broadcast,
> but this loop never visits them.
>
> That leads to two cases:
>
> - If a block's only binders are RED qevents, ports is empty. A dev-bound
>   attach then fails with "Program is not bound to every device in the
>   block", which is misleading. The old code also returned -EINVAL here,
>   so the return value has not changed.
>
> - On a mixed clsact plus qevent block, the check passes without looking
>   at the qevent member.
>
> The mixed case is safe in-tree today only because of other checks. nfp
> and netdevsim register their callbacks ingress-only, so a qevent bind
> raises nooffloaddevcnt, and tc_setup_cb_add() rejects skip_sw:
>
>         /* Make sure all netdevs sharing this block are offload-capable. =
*/
>         if (block->nooffloaddevcnt && err_stop) {
>                 ok_count =3D -EOPNOTSUPP;
>                 goto err_unlock;
>         }
>
> Both drivers also re-check bpf_offload_dev_match() in their callbacks.
>
> Should the commit message, comment and extack say that this check only
> covers clsact-tracked members? The rest of the protection comes from
> nooffloaddevcnt and the driver callbacks.
>
> > +                     if (!match)
> > +                             NL_SET_ERR_MSG(extack,
> > +                                            "Program is not bound to e=
very device in the block");
> > +             }
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-PYC7.v2.20261010165947%40mojatatu.com
>
