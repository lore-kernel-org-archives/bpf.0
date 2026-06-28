Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E32D3A6B65
	for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782649741; cv=pass; b=C8PPm8IH4d84gWXJwLDtfGbgl0Q9yFParu366V+pv3PTUuVVaMQkr3zwgC9LhSlL4WWQxXwouqj4sjtQUaKM7hq8yupkB/K11KDTY+uVYYtUOnXRXd3/fj7rFa5Vf34lmTKqUPJIwn/dCzbiRM+lhhiDZeaLo0tfCizQ0jiWWxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782649741; c=relaxed/simple;
	bh=5ApnCwq5Hsy6OnK5R9dFY0h0QMvGDBvhMeGj0FhJ0Eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+P1CDenCWN4Y34UrlgiAjcEMB7+WrUtrFPvzrG9JtUhcmcP25USsO21j48ZBYIPkqWbW6VAAjTUJF/FHFV1aVB7S4wNl1rs48P+pSOMdT386zFe5401b0wZhyDirwMpYc2sPnBL3DTsdf0R4EmzhodPiLcRABrlFROrAcdo2VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=YSO11PSM; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="YSO11PSM"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-845e363246aso647229b3a.1
        for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 05:28:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782649738; cv=none;
        d=google.com; s=arc-20260327;
        b=sCZcVr76Rsng7s87BpBT0EBIVUIYRZCK3Oeek9hkM614WV3c6mkuNc7OWoghxoX/wp
         i0Eiw3gzmTjeDB75xyJHTBb7hie8kpdCjNhJiWh2jNKAfFO+tSklXUrkOHGSo+DoA/FX
         8OWuwiFj5LkCi9JVWaU/lLpZj70bLN40MAscD8W1wJpFn+XyUHPh6Y56zg7xw0ntxnjx
         rzydH+DhppGgTMPfK6SkhmlDpCJOSrljYz5j0+wRIfXhnICUUfhU04PZZ7vOjgWLgXhi
         hsy+8GHTfwo/Wj7e9a8qTIYWIJca+3PISw7ruROuVkk+TOtD4hfVKJumpdvHZ2gaeICi
         cEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sEdjbIGDqsoiW4GawsVBo2JW1gWoEIpSwHHzh69Rb4A=;
        fh=h6FRjY4Vg/+m/z24uvzYaeQBI8nwVTWs0k3ZXJWq2bs=;
        b=ieJpBiGG7MPXjP3m+zgfVOZbC4wLUhvpqC+RZDsxLSX373XKTtrL5+Q5q1oaYmZdVA
         ZBzvYVAaWBLIjhEBWWz/RN3EsamN37SePnoKmZ8ny4VPTaR99RhUaIbjiEX4CrEmO4Uq
         YVpgyv1z1jlM6ATACg01Eb3dN9+wC0V75zYAS+PbXEHQ9ybd7roUfCdWGNJweT3a2LL7
         uLWH9yyRDfIAtIpTZTjAwfLCC4xP/JV0T/mu7SJ8sOYJI92pSdxLc3FO3lsyHTvYa7TN
         K9/jzktbAleuCwy1rFLQNJYssi+yjDuZamYMSTMOrYvMANrIIWlpp8MQh3ftRfKFcx1I
         QTog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782649738; x=1783254538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEdjbIGDqsoiW4GawsVBo2JW1gWoEIpSwHHzh69Rb4A=;
        b=YSO11PSMSJL8ahHFpAaBEQseDtKAyGwXZIMJ2uymz5G8I2rwq1An9gnidiEaJ2EScj
         Dw8nAwQixfotAeu7MSOYe7iMpCqRiugzE5BSWTdc1EmHINI+/VrJSTNNUwC5ov+nnplA
         Q8wFaCUbhhGyRdbPgyQpfxcLXrPK+wlJyl1sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782649738; x=1783254538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sEdjbIGDqsoiW4GawsVBo2JW1gWoEIpSwHHzh69Rb4A=;
        b=JqhU4wky0PA19nKrjhNNWOAupFM2G/rjIkHGSP+GG9/AsgXxTe7F99aumT0xLtvbL7
         FnFXc8fPn3BK8ziJSVxyOJ80iaup0goSOXrVJmIxbE8pNGuroWv7x3R09HfNop8pdF7h
         yeQHwDQ4iQeE7zYJVpOo0wIaVNx7tZESIHlM4IIbR9hd1q0pyNgOnHUDYHE1rrSFTCmQ
         HhSNf/2X1Afy4X8tdbnvmKxdbxtCzEhEpbbdDWnrjtMHpyfmHcqNYbr0yUPE8Y6Dq9qH
         DjDRNRqV6C6GucmBg2EE8snmY/18h001z5uKUnBRw4hJ/LIMmC3Cv1aQfXwwOULehm0K
         S1tg==
X-Gm-Message-State: AOJu0YxzJe3CP/IAd67gc6OJCmrBMJY2/FEAeAYiiNGUd21LQw1gpqj3
	y4y1eDFDtNJXyAEs42UzWJ+lIg0fEuD19i7KdFU7pyPaOkTKxiqj+aTI/RUvIa3nKYy++cuwSMP
	44jZrirPjdXM4wqfb8WBxMFlzohfv+RUMPFWP2tIV
X-Gm-Gg: AfdE7cktDFN4E/mDH5FLI1Kcm4xU9s90v9VcKHP/AbwSFB4Yjgzw+c3QtBilXcEo4MQ
	Ejd4d7j7qjcBzbKkc9saU4pmLKSD4asBAjNXyGeJ0Ls90X0DIUksIEBU6ij6OTHhb+KiwHipiV3
	M+5wlVaVRaRSMOra3n1uSSWo7u1Y14lIhWYn+g8/uEfkwD+5MTgHhlDi8QVjvsRVBT6ms1sps+9
	aproXWqzUm2xGZhy95v02Uig9C1WSNp8+DgOY+iMNw69QwEVBxJDeNIWHUyVCerJqC345lBZ1wl
	R7j3XhUl
X-Received: by 2002:a05:6a00:32ce:b0:845:4888:74c5 with SMTP id
 d2e1a72fcca58-845b3ab50a8mr14060519b3a.23.1782649738333; Sun, 28 Jun 2026
 05:28:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626165156.169012-1-jhs@mojatatu.com> <20260626165156.169012-3-jhs@mojatatu.com>
 <20260627165220.096B61F00A3A@smtp.kernel.org>
In-Reply-To: <20260627165220.096B61F00A3A@smtp.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 28 Jun 2026 08:28:46 -0400
X-Gm-Features: AVVi8CeUfCgYCrMiVLpafN92ArCYDophcwyfKGs-OnnxoG-o95tadQncfOA3DcM
Message-ID: <CAM0EoMkUeJYuPbg-qXxFLEtiLuntT+g4MeY-sHy5yBSVd7+j2Q@mail.gmail.com>
Subject: Re: [PATCH net 2/3] net/sched: Handle TC_ACT_REDIRECT from qdisc
 filter chains
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Petr Machata <petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2026 at 12:52=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Removal of TC_ACT_REDIRECT support from qevents (tcf_qevent_hand=
le) breaks existing eBPF redirect functionality.
> - [Low] pr_warn_once() used inside a static inline function in a header f=
ile will print multiple times.
> --
>
> commit d96e142c03f9c1a1e9ac2e1d8c8fe26605053b10
> Author: Jamal Hadi Salim <jhs@mojatatu.com>
>
> net/sched: Handle TC_ACT_REDIRECT from qdisc filter chains
>
> When a TC filter attached to a qdisc filter chain returns TC_ACT_REDIRECT=
,
> the redirect is silently lost. This patch adds a tcf_classify_qdisc()
> wrapper to convert TC_ACT_REDIRECT to TC_ACT_SHOT and drops the packet.
> It also removes the TC_ACT_REDIRECT case from tcf_qevent_handle() since
> it is handled by the wrapper.
>
> > diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> > index 3bd08d7f39c18..3a542a72e9a55 100644
> > --- a/include/net/pkt_cls.h
> > +++ b/include/net/pkt_cls.h
> [ ... ]
> > @@ -159,6 +159,19 @@ static inline int tcf_classify(struct sk_buff *skb=
,
> >
> >  #endif
> >
> > +static inline int tcf_classify_qdisc(struct sk_buff *skb,
> > +                                  const struct tcf_proto *tp,
> > +                                  struct tcf_result *res, bool compat_=
mode)
> > +{
> > +     int ret =3D tcf_classify(skb, NULL, tp, res, compat_mode);
> > +
> > +     if (unlikely(ret =3D=3D TC_ACT_REDIRECT)) {
> > +             pr_warn_once("TC_ACT_REDIRECT from qdisc filter chains is=
 not supported; use eBPF with clsact or mirred redirect instead\n");
>
> [Severity: Low]
> Is this going to print multiple times instead of strictly once globally?
>
> Because tcf_classify_qdisc() is a static inline function in a header file=
,
> each C file including it (like the various qdisc modules) will create its=
 own
> local instance of the static __already_done variable used by pr_warn_once=
().

This was intentional. I used WARN_ONCE() initially, but NIPA testing
may consider that as something "bad". In any case, this usage is
common, just ignore it.

> > +             ret =3D TC_ACT_SHOT;
> > +     }
> > +     return ret;
> > +}
> > +
> >  static inline unsigned long
> >  __cls_set_class(unsigned long *clp, unsigned long cl)
> >  {
> > diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> > index 3e67600a4a1a1..3ca56d060e28f 100644
> > --- a/net/sched/cls_api.c
> > +++ b/net/sched/cls_api.c
> > @@ -4033,7 +4033,7 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qeve=
nt *qe, struct Qdisc *sch, stru
> >
> >       fl =3D rcu_dereference_bh(qe->filter_chain);
> >
> > -     switch (tcf_classify(skb, NULL, fl, &cl_res, false)) {
> > +     switch (tcf_classify_qdisc(skb, fl, &cl_res, false)) {
>
> [Severity: High]
> Does this break existing eBPF redirect functionality for qevents?
>

Again, design intent. I will update the commit message to state this
clearly with the following text:
---
Remove the TC_ACT_REDIRECT case from tcf_qevent_handle().
skb_do_redirect() belongs in the BPF plumbing layer (net/core/), not
in net/sched/. The case was never consistent with the rest of the
qdisc classification infrastructure, where no classify function
handles
TC_ACT_REDIRECT.
---

IMO, it appears to have been TheLinuxWay(tm) i.e a cut-and-paste from
existing code on day 1 of  the qevent introduction rather than a
deliberate design decision.
Ccing Petr to see if he thinks differently.

cheers,
jamal

> Prior to this patch, tcf_qevent_handle() correctly handled TC_ACT_REDIREC=
T
> by calling skb_do_redirect(skb). By using the tcf_classify_qdisc() wrappe=
r
> here, TC_ACT_REDIRECT is unconditionally converted to TC_ACT_SHOT. This
> inadvertently drops packets that were legitimately redirecting from qeven=
ts.
>
> >       case TC_ACT_SHOT:
> >               qdisc_qstats_drop(sch);
> >               __qdisc_drop(skb, to_free);
> > @@ -4045,10 +4045,6 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qev=
ent *qe, struct Qdisc *sch, stru
> >               __qdisc_drop(skb, to_free);
> >               *ret =3D __NET_XMIT_STOLEN;
> >               return NULL;
> > -     case TC_ACT_REDIRECT:
> > -             skb_do_redirect(skb);
> > -             *ret =3D __NET_XMIT_STOLEN;
> > -             return NULL;
> >       case TC_ACT_CONSUMED:
> >               *ret =3D __NET_XMIT_STOLEN;
> >               return NULL;
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626165156.16=
9012-1-jhs@mojatatu.com?part=3D2
