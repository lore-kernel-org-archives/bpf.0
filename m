Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8357D3783B4
	for <bpf@vger.kernel.org>; Sun,  5 Jul 2026 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260633; cv=pass; b=EB7lXZpA/uzDyHX4S2oTgG6imrP1KiZ2YhPjsWBeSHRv2poAX8RPz8HlbevMKCF3+0LtQzrHuxsoBgbQjR5EQwtfJUQERZBBHhXb2TGesd1vbnq0NgqBe8L7GGeSVa8+Vsn5Wz7RoFhErao7u1OXRPHKM5qbRSi9YT4ev1uEUtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260633; c=relaxed/simple;
	bh=kakKne0EgDfucXuQ0PX+nfBbCLc7Urw3aYMCYO/CowU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOF8grr3Tn2vFXG+2cxbb1ElahrRpbKEzwyrXdmuYVWc4o/V4YI09UrkbOUaKM63gwYDEcPjuazTwOw2l7+L150YcD+5hwWNBODIOzlDluXC9ruN9B0jvNMl5avrLL1KGEFfjUZfA6S9xyOUncfufqH3DttnaouiedmNWFX0XqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=q9/d9q1O; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="q9/d9q1O"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8475eca3a66so3199713b3a.2
        for <bpf@vger.kernel.org>; Sun, 05 Jul 2026 07:10:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783260631; cv=none;
        d=google.com; s=arc-20260327;
        b=VKgNuQy0lcU7Dcgm0q/XHSCjk5Q7r63PHlkh/j9DlsngiyZ5PAheiQlD3Yx+Fj2J8H
         av+pSzJXQzyTTtDHEDyiuE6f3idkwU3W0u4bGhhdfCoC0HQ1TjyYvzzI0qQGXYV495Zl
         Py5u71bzrZifLLDSzAPvsrGOYRPIfAvgtZq9ZoaFSzjOQi+rgrtO4K0xXvksT1JtVrwi
         nG8SMp1l7ucghV0kDV+Yb34YCl/rMGZ26Epzb3phOSVCIir+/+U58d8imYjVMrvlcsrD
         ZfjBq24MdUuvg6BIsclE8aN/1pxqPL/mKhy7Y9oAbT/d2Z1cptlbdB6URjBonk5w4VmT
         BGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eOeIHvaWNTRw9NcZ+F+Xnp1pzsZrL0QiN5VA73LV1XE=;
        fh=DPsQKsd2qjJ9xNJqxfYbyk0BypDPnIKjJchaaQVVt6E=;
        b=T0CP4/i+YTHJXD9JHwV046psOIgPEHvNZAc0WMuxsw6zsr1c5C2wJk1l/JEph4U6Nf
         M2joMe8s3qm+UliY+cvYIxPKhsgDT4DIGfsSldCOeuiAHrBUqa9ZpNXILdFGxXvyU9Xi
         OeEh+WFs60DvQ4dUiSvx7l/wbLaPBpDQgMKIjysEna4YxbYZElfxyIBc9D/IBjQMdw9q
         nTpDee7TGobm2Q9RXSDjfhGAkDGPzPDvlKWJE41psIMtlVbUbANhgF5885m3BT1FOu6y
         5Fa/gAIvLMJYz1IvZjV2WazOUbgrF7rDqHGEjfZAkrzaSFjfeQOP07DdaTaTk2n0H7nq
         7gWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1783260631; x=1783865431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eOeIHvaWNTRw9NcZ+F+Xnp1pzsZrL0QiN5VA73LV1XE=;
        b=q9/d9q1OoSJVvJ6vJ59b8AjwgLBCEb+vdKxZOXQpuIZ56S4TH1ZCFba1+A2EkqfSo2
         Q9kym5hg6fqfJctZsEsf+IICRlgrq5nNPpzORB+0GKNb4KslxYJefpdjohhuSpYMBeqY
         5B0fvmK59Ym4JLcZcTEd0AByGCGh18xUr2i4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783260631; x=1783865431;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eOeIHvaWNTRw9NcZ+F+Xnp1pzsZrL0QiN5VA73LV1XE=;
        b=Zz1bzlUf9d/j4H1XXuXqI/ZguG53RIApuFTLBayIsJavzlinZi2pIp8zmFGpdapRxg
         87NIuqb3nw/i1jwJ5aM9HNV3b1xg3dJ6CHex1HvxVoIxyWegc8qOFQnOtp2AZrhixksu
         dA92x53VnWDDEHgtNJZQ+AI6yOhwu5e4Me/MQapM7fHxb0bYgfZqnxhbx9Q5RDr7VhXO
         4KCCQ2tn0eykCPyzx6KDsupuxSpKz9BBuqhK6OlPNp6C14h3y4M+HLM3z7qRMHF1k0iG
         ChIsZD500GhWMvWkvMIUw9q9ETaLQ9dgYNT2TyeAbjg+UiQ8sNhIOCr9SkMQchFzn9r7
         OSLA==
X-Forwarded-Encrypted: i=1; AHgh+Ro7PEzxm1jSI076NTtZXPXc3FMYlFvqAj2ftaMoTVZD9fozOvLNgftbal/gfQ/o/y6RBuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR/f0D3O0+2HmqyPAwjF59oIHoRXn0zmfie8cUahdAImQjz/m0
	+K7W2pp64r9sGfDAyoNGvsZPTRghcFdU137pwtMPDiSCL7EXPgYfYYX8KkGtFgcVtDxRe7WDE49
	rV5WEJUgMm8YGupSEvlUJRQNstSW7PTe4WiYiU+QeKBgIhjDu9gw=
X-Gm-Gg: AfdE7ckaGgdxzzSUkexRtbBgH81wcDhg3YbulLYtQJZqQBL0LdpmpAIevcylRqNZC1g
	zR8uX8RAvEI7CG1AHVKzfU4D3f4PbwWom3rcR9RF7RpMnTqDOnv24tzskO2Wgo8FTkc1JsBy5QJ
	wsJD9ubj7WA4XuJxWJosERs9Oa0U+iSwGZZnk9Hezm5r/31wS7PWBKHtwqTtGqIO/RUwRWT4YO5
	uFY7B+Iq22cpNI6dJBeHCxwS8tLnu7W/97cMYCvU067vQm9Mw62OEGzhcrs0gEuzVRLoUC9BUf+
	w0wg
X-Received: by 2002:a05:690e:11cc:b0:664:dbfc:e46a with SMTP id
 956f58d0204a3-66652e66e21mr6863949d50.19.1783260245720; Sun, 05 Jul 2026
 07:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630123331.186840-1-daniel@iogearbox.net> <20260630123331.186840-3-daniel@iogearbox.net>
 <CAM0EoMn6H6cKCweHmt=8ve2i0JuK=E8W1Q89oqDD7vra_Uuk-w@mail.gmail.com>
 <d9fce17f-851e-4cb0-9d78-2ac2cadfda81@iogearbox.net> <CAM0EoMnZPbKG3GCndk2Xp44KxUfPJzSMGXYPDZeoa_-6JZ+Uuw@mail.gmail.com>
 <c526d9d9-db4c-45e8-96c5-52b2a9dca7e8@redhat.com>
In-Reply-To: <c526d9d9-db4c-45e8-96c5-52b2a9dca7e8@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 5 Jul 2026 10:03:53 -0400
X-Gm-Features: AVVi8CeG9O3TK3HqjDcb3pIV075W7jf3weYjl-1a9FqDQYgpOGDfycAxpf-fEc8
Message-ID: <CAM0EoM=Ct36Dt7sgXF=qB_2B67L0JbBcf-R3FV=G5Y+DvQu5uw@mail.gmail.com>
Subject: Re: [PATCH net 2/3] net/sched: Handle TC_ACT_REDIRECT from qdisc
 filter chains
To: Paolo Abeni <pabeni@redhat.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 5, 2026 at 3:26=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> Hi,
>
> On 7/1/26 5:35 PM, Jamal Hadi Salim wrote:
> > On Tue, Jun 30, 2026 at 11:23=E2=80=AFAM Daniel Borkmann <daniel@iogear=
box.net> wrote:
> >>
> >> On 6/30/26 5:16 PM, Jamal Hadi Salim wrote:
> >>> On Tue, Jun 30, 2026 at 8:33=E2=80=AFAM Daniel Borkmann <daniel@iogea=
rbox.net> wrote:
> >>>> From: Jamal Hadi Salim <jhs@mojatatu.com>
> >>>>
> >>>> When a TC filter attached to a qdisc filter chain returns
> >>>> TC_ACT_REDIRECT (ex: via an eBPF program calling bpf_redirect() or a=
n
> >>>> act_bpf action), the redirect was silently lost i.e no qdisc classif=
y
> >>>> function handled TC_ACT_REDIRECT, so the packet fell through the
> >>>> switch and was enqueued normally instead of being redirected.
> >>>>
> >>>> This has been broken since bpf_redirect() was introduced for TC in
> >>>> commit 27b29f63058d ("bpf: add bpf_redirect() helper"). We got lucky
> >>>> for a long time because bpf_net_context was a per-CPU variable that
> >>>> was always available.
> >>>>
> >>>> commit 401cb7dae813 ("net: Reference bpf_redirect_info via task_stru=
ct
> >>>> on PREEMPT_RT.") turned bpf_net_context into a task_struct member th=
at
> >>>> is only set up by explicit callers. Without a caller setting it up,
> >>>> bpf_redirect() itself crashes with a NULL pointer dereference in
> >>>> bpf_net_ctx_get_ri(). However, even with bpf_net_context available,
> >>>> TC_ACT_REDIRECT from qdisc filter chains cannot be honored without
> >>>> adding skb_do_redirect() calls to every qdisc classify function, whi=
ch
> >>>> would require changes across net/sched/. Isolate it to ebpf core whe=
re
> >>>> it belongs.
> >>>>
> >>>> Instead, add a tcf_classify_qdisc() inline helper in pkt_cls.h, as a
> >>>> wrapper around tcf_classify() for use by qdisc classify functions an=
d
> >>>> tcf_qevent_handle(). When the classify verdict is TC_ACT_REDIRECT,
> >>>> the wrapper converts it to TC_ACT_SHOT, dropping the packet rather
> >>>> than letting it continue silently. Dropping is preferred over
> >>>> letting the packet through because the user immediately sees packet
> >>>> loss. Silently passing the packet through would hide the problem and
> >>>> leave the user wondering why their redirect is not working.
> >>>>
> >>>> The clsact fast path, tc_run() continues to call tcf_classify() dire=
ctly
> >>>> and is unaffected: TC_ACT_REDIRECT is returned as-is and handled by
> >>>> sch_handle_egress/ingress() calling skb_do_redirect() as before.
> >>>>
> >>>> Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
> >>>> Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_stru=
ct on PREEMPT_RT.")
> >>>> Tested-by: Victor Nogueira <victor@mojatatu.com>
> >>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >>>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> >>>> ---
> >>>>   include/net/pkt_cls.h    | 14 +++++++++++++-
> >>>>   net/sched/cls_api.c      |  4 +---
> >>>>   net/sched/sch_cake.c     |  2 +-
> >>>>   net/sched/sch_drr.c      |  2 +-
> >>>>   net/sched/sch_dualpi2.c  |  2 +-
> >>>>   net/sched/sch_ets.c      |  2 +-
> >>>>   net/sched/sch_fq_codel.c |  2 +-
> >>>>   net/sched/sch_fq_pie.c   |  2 +-
> >>>>   net/sched/sch_hfsc.c     |  2 +-
> >>>>   net/sched/sch_htb.c      |  2 +-
> >>>>   net/sched/sch_multiq.c   |  2 +-
> >>>>   net/sched/sch_prio.c     |  2 +-
> >>>>   net/sched/sch_qfq.c      |  2 +-
> >>>>   net/sched/sch_sfb.c      |  2 +-
> >>>>   net/sched/sch_sfq.c      |  2 +-
> >>>>   15 files changed, 27 insertions(+), 17 deletions(-)
> >>>>
> >>>> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> >>>> index 3bd08d7f39c1..5f5cb36439fe 100644
> >>>> --- a/include/net/pkt_cls.h
> >>>> +++ b/include/net/pkt_cls.h
> >>>> @@ -156,8 +156,20 @@ static inline int tcf_classify(struct sk_buff *=
skb,
> >>>>   {
> >>>>          return TC_ACT_UNSPEC;
> >>>>   }
> >>>> -
> >>>>   #endif
> >>>> +static inline int tcf_classify_qdisc(struct sk_buff *skb,
> >>>> +                                    const struct tcf_proto *tp,
> >>>> +                                    struct tcf_result *res, bool co=
mpat_mode)
> >>>> +{
> >>>> +       int ret =3D tcf_classify(skb, NULL, tp, res, compat_mode);
> >>>> +
> >>>> +       /* TC_ACT_REDIRECT from qdisc filter chains is not supported=
.
> >>>> +        * Use BPF via tcx or mirred redirect instead.
> >>>> +        */
> >>>> +       if (unlikely(ret =3D=3D TC_ACT_REDIRECT))
> >>>> +               ret =3D TC_ACT_SHOT;
> >>>> +       return ret;
> >>>> +}
> >>>
> >>> Why did you remove the warning?
> >>> A lesser issue is that you introduced a space above #endif
> >>
> >> I don't think we need to put out an extra warn to spam the log, this
> >> can be easily traced either via bpftrace or qdisc stats etc; plus the
> >> guidance to eBPF with clsact is also obsolete. Given noone has run
> >> into this the last 10y, I don't think it really matters tbh.
> >
> > It's a bit entitled for you to change someone else's patch to fit your
> > philosophy without a mention.
> > It's only one message per qdisc. But fine, let's keep it that way.
> > Sashiko is hallucinating on TC_ACT_CONSUMED for patch 1. Let's ignore i=
t.
>
> @Jamal: I read the above as if you are ok with the series in the current
> form as a whole. Please LMK.
>

I am fine with series.

cheers,
jamal

> FTR, I have a slight preference towards the extra warn message in case
> of misconfiguration, but big deal either way.
>
> /P
>
