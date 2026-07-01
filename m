Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF18435E1C0
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782920127; cv=pass; b=V/yuhVPPGcNF7rfQ5O+iwY8h5wYkRu/wu+LN91XwZbrRZ3V8zV3H14Ni8mN0TUSbgHKMj9PYZMH84LPsHBjikQhEFEa88lwdw3oT4c402fQu79N89BA/Md9QyALYpceQEs2TQuAGYYU/xK3reseDT9RsQJzukIaWxehgtZr44TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782920127; c=relaxed/simple;
	bh=Y2c6QTfFJtVu0RfirbPQ6iVT1Kw5wPu8BkJiRRYRdIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCJg7X+9sXTD0dDNzbe2V4rL/sMtLq74K2FfGdRRKXtjZDbDO1HBuXcxvDteVyPHbuVLVvjx9E1t3MFn+qkAuGLQ8UHEmkiyWu3rJVYDWTOVKYJy5p+q7g4qbkW5xqwDHhmIWk8ka45RSl9T/Kf4CWk+ty3xhlp8nVs8tlHo4f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=FltoVmhk; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="FltoVmhk"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-664ae993e4bso787462d50.0
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 08:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782920123; cv=none;
        d=google.com; s=arc-20260327;
        b=BXhmVWEThaxilxe8q+r1WfqxbMmcmx+PnKF2rl4hLFeqpyffQIe4rinNuZ82/CkIQh
         WfCPyPeUIUsY34PtUk4odCAei+L7FTjaFbV69zgvNB16nk3tng3lm39WcO3WKoItY1f+
         zo8mAZOBDX1SY1SKh4KZPkedCE7ybz8s3Fb/7TMt6ta1psHrQyRK6rgwbv1o8SO+5UWl
         1F7dQwtHZXbvHO6uRmIUTbn6lJy6RjQB169qlElfTisvT1U+iLya9JoOUkBE0m4oTrK8
         sknWPkx6ukBoKekHiWCKbA53oNyHM5LJB1QjP/UUwu/EX5PjUT3gSwtq5mZvVX/lwgAq
         BT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ndR8vhWFt9KSYRpwVTspSwgHXJD0hfWVRuMdjE0PPzc=;
        fh=vZoj5azBbEYCdIujBPoCfHXlaPXHl/xKs+OCWOTW1H0=;
        b=OKm4gGT7XN2soilttdH9pbw79Aw0MAvcj1tdalknHwnmEUixTscpii7KYtlSBgah0m
         r0yiVvdrsnUEHUUtNtjMpX35eeWe2t3bSZAcfCz2yy6FaxoYYIg5VF65Eeo/wRiUQLzn
         SfeUBaEEk/lbhlDa6rKYMHLIE4QSK2YxrUQfma5J1iw7XQzA4UNTKFa4WXNj318wlUGf
         guERO1jrhbBwTBGvLpG9NxDbCrS0yJij/c/vbPVNWzL25a2ddXpGZm1ncEglsW/+e9yA
         XgWmBA9jRDuQvNzO12jkmMcUo0jq8NDJyUsXsACUigvJOBVXK6YRdHZ+cY/VSQWzGCcu
         Uj5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782920123; x=1783524923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndR8vhWFt9KSYRpwVTspSwgHXJD0hfWVRuMdjE0PPzc=;
        b=FltoVmhkn3E9PCmMtx+l+2vCJp/LzSVHT2m5n/11+Y4/V/i4x0BCJkUuyye5rfzS+z
         /CWpTUrNhfhX1vv92m/WpZ6BxVMLbSVmZSZZeFF0KGY7krtJapuFfs3yW68wI0XHlM4H
         C+HIfr7hcfVS9fqN6tX/J6KBKC8KdYl21UsKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782920123; x=1783524923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ndR8vhWFt9KSYRpwVTspSwgHXJD0hfWVRuMdjE0PPzc=;
        b=CUlFtFps7/YZ4ZBLF7dDE/+Ni2+p49E82xi0cM4g0CZbGoNrAZ857JUNaXckEIHORO
         WZcFDe0HZxWynEhZDxUno0W5eG2ij7uyzZoV7dt3LW732NChM/MmZCNrUh/tX2Rhnsv0
         yhCTz/ZzGlmzt2QocTixGUVV9DDrIm9CeaY4BUptkQdNpCyeWPAivr7vaICn4K8DS6xe
         Q2cCFV/71YDlbwnvUyc67jbuFDsq1AhXNleeehf0bksghoQnB6Uvj1QiHoTtYc4SMU7s
         VEzSC5XtMELIArf2em0Re7LUPtK5rzhDgLE0cNg+Sp+5591DABhVQQzkdH0QLa4plZgi
         pC5w==
X-Forwarded-Encrypted: i=1; AHgh+Rr6BQoqW2B6UOnDUHBtSz/7K4cTTl/sREjDSZmUrn73B4YQKTL3Qn5DDg+H6YZef3jHHVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZNBq29HRKri+2ZuH9llq1vuKl8UsRGN1vyCZVG2G65u57gjdF
	vAV+JU8kfIEQnQhHst3DHxaTMTpL8qXrk6xL2YgX77wv00nr/553eJ57Av5zwMvX9Asuaay9bbo
	/n/ERFQ4kEN0wVsL1Zn4Yz3Rbw3ff/ZcdLz7ylpwfRus0WX/BdahWPQ==
X-Gm-Gg: AfdE7cldx1fu1uQ1XsSjU0NGe9XFYh64Cvmw8B2daOCMl9k56joygTf8+qnpEhdIqT9
	vOdq9vJ9oAjejIVerbVsgAyo/S7RH4Zh1r0wPp0Hyv9KZuYVFGdGkmK2lYx6PH94La9cD4+UJL2
	qyHslNYd+fgn9W3rN4yQ8x0ZrIUncCwKGJHiMXHM+cdSkqQAyHsLofssWNmqBXlPseMB2H1Fc/5
	1QVThQgGMOPfABZYkSOKrjjjbdn9PAmMAcj7Ck4KOJ17hf9pH0p9wYnNmgUKr40TINIBhKZ1Q==
X-Received: by 2002:a05:690e:1489:b0:664:e5c5:5b2b with SMTP id
 956f58d0204a3-66520e00800mr1930879d50.4.1782920123243; Wed, 01 Jul 2026
 08:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630123331.186840-1-daniel@iogearbox.net> <20260630123331.186840-3-daniel@iogearbox.net>
 <CAM0EoMn6H6cKCweHmt=8ve2i0JuK=E8W1Q89oqDD7vra_Uuk-w@mail.gmail.com> <d9fce17f-851e-4cb0-9d78-2ac2cadfda81@iogearbox.net>
In-Reply-To: <d9fce17f-851e-4cb0-9d78-2ac2cadfda81@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 1 Jul 2026 11:35:11 -0400
X-Gm-Features: AVVi8CfqeTgnacRGIOCuhvdFtORTR-T_CEfhc-_OdUiwNBANp03Tk1iSAhcfLDM
Message-ID: <CAM0EoMnZPbKG3GCndk2Xp44KxUfPJzSMGXYPDZeoa_-6JZ+Uuw@mail.gmail.com>
Subject: Re: [PATCH net 2/3] net/sched: Handle TC_ACT_REDIRECT from qdisc
 filter chains
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 11:23=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> On 6/30/26 5:16 PM, Jamal Hadi Salim wrote:
> > On Tue, Jun 30, 2026 at 8:33=E2=80=AFAM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >> From: Jamal Hadi Salim <jhs@mojatatu.com>
> >>
> >> When a TC filter attached to a qdisc filter chain returns
> >> TC_ACT_REDIRECT (ex: via an eBPF program calling bpf_redirect() or an
> >> act_bpf action), the redirect was silently lost i.e no qdisc classify
> >> function handled TC_ACT_REDIRECT, so the packet fell through the
> >> switch and was enqueued normally instead of being redirected.
> >>
> >> This has been broken since bpf_redirect() was introduced for TC in
> >> commit 27b29f63058d ("bpf: add bpf_redirect() helper"). We got lucky
> >> for a long time because bpf_net_context was a per-CPU variable that
> >> was always available.
> >>
> >> commit 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct
> >> on PREEMPT_RT.") turned bpf_net_context into a task_struct member that
> >> is only set up by explicit callers. Without a caller setting it up,
> >> bpf_redirect() itself crashes with a NULL pointer dereference in
> >> bpf_net_ctx_get_ri(). However, even with bpf_net_context available,
> >> TC_ACT_REDIRECT from qdisc filter chains cannot be honored without
> >> adding skb_do_redirect() calls to every qdisc classify function, which
> >> would require changes across net/sched/. Isolate it to ebpf core where
> >> it belongs.
> >>
> >> Instead, add a tcf_classify_qdisc() inline helper in pkt_cls.h, as a
> >> wrapper around tcf_classify() for use by qdisc classify functions and
> >> tcf_qevent_handle(). When the classify verdict is TC_ACT_REDIRECT,
> >> the wrapper converts it to TC_ACT_SHOT, dropping the packet rather
> >> than letting it continue silently. Dropping is preferred over
> >> letting the packet through because the user immediately sees packet
> >> loss. Silently passing the packet through would hide the problem and
> >> leave the user wondering why their redirect is not working.
> >>
> >> The clsact fast path, tc_run() continues to call tcf_classify() direct=
ly
> >> and is unaffected: TC_ACT_REDIRECT is returned as-is and handled by
> >> sch_handle_egress/ingress() calling skb_do_redirect() as before.
> >>
> >> Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
> >> Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct=
 on PREEMPT_RT.")
> >> Tested-by: Victor Nogueira <victor@mojatatu.com>
> >> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> >> ---
> >>   include/net/pkt_cls.h    | 14 +++++++++++++-
> >>   net/sched/cls_api.c      |  4 +---
> >>   net/sched/sch_cake.c     |  2 +-
> >>   net/sched/sch_drr.c      |  2 +-
> >>   net/sched/sch_dualpi2.c  |  2 +-
> >>   net/sched/sch_ets.c      |  2 +-
> >>   net/sched/sch_fq_codel.c |  2 +-
> >>   net/sched/sch_fq_pie.c   |  2 +-
> >>   net/sched/sch_hfsc.c     |  2 +-
> >>   net/sched/sch_htb.c      |  2 +-
> >>   net/sched/sch_multiq.c   |  2 +-
> >>   net/sched/sch_prio.c     |  2 +-
> >>   net/sched/sch_qfq.c      |  2 +-
> >>   net/sched/sch_sfb.c      |  2 +-
> >>   net/sched/sch_sfq.c      |  2 +-
> >>   15 files changed, 27 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> >> index 3bd08d7f39c1..5f5cb36439fe 100644
> >> --- a/include/net/pkt_cls.h
> >> +++ b/include/net/pkt_cls.h
> >> @@ -156,8 +156,20 @@ static inline int tcf_classify(struct sk_buff *sk=
b,
> >>   {
> >>          return TC_ACT_UNSPEC;
> >>   }
> >> -
> >>   #endif
> >> +static inline int tcf_classify_qdisc(struct sk_buff *skb,
> >> +                                    const struct tcf_proto *tp,
> >> +                                    struct tcf_result *res, bool comp=
at_mode)
> >> +{
> >> +       int ret =3D tcf_classify(skb, NULL, tp, res, compat_mode);
> >> +
> >> +       /* TC_ACT_REDIRECT from qdisc filter chains is not supported.
> >> +        * Use BPF via tcx or mirred redirect instead.
> >> +        */
> >> +       if (unlikely(ret =3D=3D TC_ACT_REDIRECT))
> >> +               ret =3D TC_ACT_SHOT;
> >> +       return ret;
> >> +}
> >
> > Why did you remove the warning?
> > A lesser issue is that you introduced a space above #endif
>
> I don't think we need to put out an extra warn to spam the log, this
> can be easily traced either via bpftrace or qdisc stats etc; plus the
> guidance to eBPF with clsact is also obsolete. Given noone has run
> into this the last 10y, I don't think it really matters tbh.

It's a bit entitled for you to change someone else's patch to fit your
philosophy without a mention.
It's only one message per qdisc. But fine, let's keep it that way.
Sashiko is hallucinating on TC_ACT_CONSUMED for patch 1. Let's ignore it.

cheers,
jamal
> Thanks,
> Daniel
