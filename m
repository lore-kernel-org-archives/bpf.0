Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF504D7948
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971826; cv=pass; b=qZJH46kc2cQY4pXFWdEi6ZliwP2cOwco5N2pM9JJeSLDYB/gTOQdW+/F7DKjbpL+/vQYcO5G6yKpY7E8+lDK6yeNSMK7Y2qjy1G+Ug3WQUC8mE5FngrJiVt9nJ4skuZTYlR/Y+P00kW68+sM9wPqdxPY+eZvuJuJp1sNRRhxeZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971826; c=relaxed/simple;
	bh=pES0DDjBr7lNbZcv4EttsrEqsZlgoprgnuuUAEr6uzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNRY2CTgGKY0MGVoVZQ8+hUoinGZpvsF/rSjSk8NIAybnRxX5So3vKQuTuj2kygjoqNuxWiwyLkXSgLyu0oVn8AQ1jfdTZxc6lug9DFpC1Y41wJ8AfqfAzNDBT+g9NytfxmV/6luTCXffLHyMe80UhgLKxkMO1EKlSom+gM1XpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=NzDRS6hZ; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="NzDRS6hZ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-88bc25fcd0eso212136b3a.2
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 02:57:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791971824; cv=none;
        d=google.com; s=arc-20260327;
        b=rOf70snJyAGXqoOWnUwkkRrpl74F+Zxokeru2NGRhNMucWmc76/4XadEimUu0zAAou
         Tjdl8VVnUJmzVwVnTmnd5Hh2Im2SxN+fqHPx4GY+gDHAxvnVYYjD8YGd15IBKWxrKKbV
         do6ztOtfwHoJQtXpzy0w9eEJvnops3vvDGZuZMr8Ziq3Rx1orqbA+p9S2RFbhV9XxgBt
         l7hK2F1IlZVQV8f7cfKQ+VTjlQ91ueHHnP+5SS84dQqJH1bzqnacYuKbcYo2vSFHGz0X
         fiL9R/9VVemnMqPGjA6A6JP7I8zY8ESN4Fs1En7ksjysxCpiKBTS0P+lD81TpR5CcATD
         8S5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x9rvRSpojIVM87li0yF5q9R69waCFTVPzWFGm69CD+o=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=osxkdZMLmO+aczJBmHvcA5xchc2AcNa0r/aLofCPlDAm/jT9ZnCwBrGDN00yUeu8Sp
         UU38O9lTS9xX8DT9Xj0ACfipag4bc191wLSSC1+EAqIk4iuOcAqXEvBkPqEMCEUO3A65
         sHgE30B7kjS17+5FnAERxGhd2k42zz8EwSyFGGzHWasvO4aJDcow25mnZTM0O300U6LO
         fTi10c+maOmAodnqoHqJT8uPYDHgThexezNf5lcroTOgoYU2lu5zCql3zdcRklqHJUK3
         d/RvQuGW9tzG78FuB4GM3raSXHulRk8KECeWNZ/iCHz6Qtj1+gxZLr0rY+bydldJxG4d
         2fmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791971824; x=1792576624; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x9rvRSpojIVM87li0yF5q9R69waCFTVPzWFGm69CD+o=;
        b=NzDRS6hZ4cGKZueOsec0EdGmv2PaAaydt2Cb8mnCAdh/8DrgzzvdM+QcNkFUo8hFkJ
         nvQE6qXwmMA4T5PIPOFM5WFciLeU6G/2N6gQnAEji7EIT4UGdLVLOL214weLbekHAzc8
         9oQFnQ1E++ISCVrpF8fg4QYShincVWsIbeY1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791971824; x=1792576624;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x9rvRSpojIVM87li0yF5q9R69waCFTVPzWFGm69CD+o=;
        b=bmtT7FUl95VDNxl9N8fioJ+yLnWnHbvQYqTrTsvt54ykRbZ26FO64kiahp7VKd71qW
         RLl7ipiZyNKSapXYPM5o2pmd45DB4vZ0NjsNr+4Lj/XvPPymRtSWWobyzcnHNbyTE8u5
         RHBwb3KStDQwOytXnubEfwSvUEE7aQNpQGNb0zkoXaMUmZr8sCMvQhuCgFfQwIEdpgic
         YGCoA5WVLGwp8tpmUG1ptM1rp3LpMEMyjDiGktseF9APJ6xgGpfdxuRKS1h0S6doVsNH
         hVT6b5Nnujwj/zaN35YTTujGe/PjfaDBatumuZs6KTmpigyv+A1YuJjY7O0jYIn4CHrx
         OfvA==
X-Gm-Message-State: AFq9FYL1VBYT9q6XGUBgW4hRMeiE/kz4yk7+YP4mU0KyPv5EKqMzHNgb
	V3JoMVfsjZnOUjxqVwK0wwNsKVMWIz5rmChppQzhIWD3fEsSgOdcbL6ZDLRyh8e+YEEhXlAF1UE
	U0jkSKC1z0LP5OtsV4AWUOp0dH9LaglJIejVt+Ii7XqBCkuyUifQ=
X-Gm-Gg: AYBFou1qEcLYat4Yg3MRD9v4POicT+zCYG1P24MAU+dc2KmphJPicyKixMUuu8SJD2G
	40Dt4+/rEFjWnZ5oQHaLb/G4WpHs7GjmE+HPZESp5BEe8irxXIIUFLoEz/pOi36xHqEicqXkdsG
	xmv1a5RB0u5zU+U3GORMikXHTXV3HxTSGIBKzZJRxO9c/7q4YHH/7fOACh6ReI+ZpUIwU2jzJwv
	QF0Wz3NjzxLz9FaiA8WoJuUOpsNgOoJ1BE98DHf97hXt1B/4+4HvGPqyg1vG/lddqfRyU5A82JY
	xdVtZuG9pxQDSR8WwrbfwWgPRPfr/gbNxPCbgaRfYynKho9kepwFmY3ycIZroaapvpHla7DKjZB
	GYjVhuANAzbMXGJU/Muc0oQASGETW6l4PwQ==
X-Received: by 2002:a05:6a00:3e12:b0:883:71f6:5fb with SMTP id
 d2e1a72fcca58-897c6e1b608mr14580422b3a.13.1791971824324; Wed, 14 Oct 2026
 02:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-H19Z.v3.r0.20261012193813@mojatatu.com> <QDISC-H19Z.v3.r0.20261012193813-1@mojatatu.com>
 <sashiko-outbox-171044@kernel.org>
In-Reply-To: <sashiko-outbox-171044@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 14 Oct 2026 05:56:53 -0400
X-Gm-Features: AclHuK-NLE3qfsWeit2n79z3ZCol8KGxRxDpPaAT__Uoa9Kdg3NPnm2-yKHy-cg
Message-ID: <CAM0EoMnwMw-tOJWp19WWwrmkxivYQ0iYaZRgkOZmndn0hA3szw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/5] net/sched: act_gate: reject oversized
 dumps instead of wrapping them
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 4:54=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] net/sched: missing error propagation and wrong extack in tcf_get_=
notify
> --


I will not make this change unless something more substantial shows up
in othre reviews.


cheers,
jamal
> commit 98a2c073503c58fa744586844b669ba5ddd1bfc0
> Author: Jamal Hadi Salim <jhs@mojatatu.com>
>
> net/sched: act_gate: reject oversized dumps instead of wrapping them
>
> This commit fixes an issue where oversized action dumps wrap their u16 ne=
st
> lengths, resulting in structurally corrupt netlink messages. It uses
> nla_nest_end_safe() to report -EMSGSIZE instead, preventing unrepresentab=
le
> dumps from vetoing deletes and allowing correct handling.
>
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824153903.=
4143642-1-victor@mojatatu.com
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-H19Z.v2.2=
0261007062551%40mojatatu.com
> Link: https://lore.kernel.org/netdev/QDISC-H19Z.v2.20261007062551@mojatat=
u.com/
> Link: https://lore.kernel.org/netdev/QDISC-H19Z.v1.20261001053234@mojatat=
u.com/
> Link: https://lore.kernel.org/netdev/179111893181.434549.1344966067026704=
8994@kernel.org/
>
> > diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> > index 6e48b4bc2d75d..4b4b5d37d2206 100644
> > --- a/net/sched/act_api.c
> > +++ b/net/sched/act_api.c
>
> [ ... ]
>
> > @@ -1701,7 +1719,7 @@ static int tca_get_fill(struct sk_buff *skb, stru=
ct tc_action *actions[],
> >
> >  out_nlmsg_trim:
> >       nlmsg_trim(skb, b);
> > -     return -1;
> > +     return err;
> >  }
> >
> >  static int
> >  tcf_get_notify(struct net *net, u32 portid, struct nlmsghdr *n,
> >              struct tc_action *actions[], size_t attr_size, int event,
> >              struct netlink_ext_ack *extack)
> >  {
> >       struct sk_buff *skb;
> >
> >       skb =3D alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);
> >       if (!skb)
> >               return -ENOBUFS;
> >       if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, 0, event,
> >                        0, 1, NULL) <=3D 0) {
> >               NL_SET_ERR_MSG(extack, "Failed to fill netlink attributes=
 while adding TC action");
> >               kfree_skb(skb);
> >               return -EINVAL;
> >       }
>
> [Severity: Low]
> Since tca_get_fill() now returns actual error codes like -EMSGSIZE instea=
d of
> just -1, shouldn't tcf_get_notify() also be updated to propagate these er=
rors?
>
> If an oversized RTM_GETACTION request fails with -EMSGSIZE, it appears it
> will incorrectly return -EINVAL to userspace and display an inaccurate
> extack message ("while adding TC action").
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/QDISC-H19Z.v3.r0.=
20261012193813@mojatatu.com?part=3D1
