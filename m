Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C802D3D4138
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774879362; cv=pass; b=YpmeDx3JGLJwB8PpzlK7r74RRSP71fNxEgjWU5T4+i6vO/TRmPpyiuna4QwOvrAQZ76vXap8u5jgAQq1MWzCofs9PQWr+r6WPNlnnrohRq6elb7Y5in2b0H1hrZja5sS+9VhMWXel/A13Wr6RsKob4dUK5BQ9cLmTGZcybVm5Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774879362; c=relaxed/simple;
	bh=cOYNuyzwl97tt3swTkjE/ZnYXJjAP/MubIqZuyFxJRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3BiOTHLfDAJdOrvAQNyWWXHGHb4Nq9atozybpv7qxm6Z/lvlULD8PQhld+nKCNme/1y1gCloKPgQDYF+Dp4QRP2jEHsmcAVNoQxgnsjJQkIfpwCclkhcoW3FKcrKejD9I+m8kYpf+ScCBBc5csCuLSlk11Rh81yUiwCN1yvkpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzKE0Tin; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzKE0Tin"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-439d8df7620so3235464f8f.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 07:02:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774879358; cv=none;
        d=google.com; s=arc-20240605;
        b=MqegpjGkWJMdxUZceArbOXf/PgDnAhaMqg/LIqM+RE9p1kCy/PMV+VUelTzstEnswm
         f7qtZYVDkNOVL3GjbHY5JVB6L+4xJi4rAEsuIiUJKnAKPdKh/PgWbCLUYGmqYO4ivxzw
         8Z9NMn6TCUnc7wfM3K6Ss2LQXmIwYcJeR45ehVs40pMAj52cSO3zpNdW9LKzhWh9F7ut
         xfuD/QJj+uSvH5BeEmMJEKZ9nXThm9P3mup6dPffS6H/mrj9z/NfUoZAU6odendJE3tu
         FRjEaKIMcCUOaVAcfDEf+p8QPBEwbauqzSyCN0SNlCNIgwCgHbTCUFk8xAvfnqO4/czN
         vfDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KjB/UVz/vnJ23xIYfblwh45FQTiDMykH3MwZx75uAOM=;
        fh=9d03gO6ZDIjrOrTeHaZeBUvVDHxN+aVkavLReq5lJ0A=;
        b=IOz5usjOP1Bla/DRDoNMhsG+yKPxZ5SQKadygcW1UsVe12iR1XKy/a9gi3lWVPYZE/
         5CRFW7/WU0cGTECCfaVatACzdhkpgNK41vZT9ycX2bgM3VNvHuZPCnbfEy9G8ZL2qhRH
         Gu2yGvEMXrXwS7IqV23JKOdnuL1bdYU7xZQBEGu/itIbMAP31aVrMJrfzlo5ae2OH83S
         zfAlcKsbG3deycryg50WL8XcvWRcQT13/QxF4sEXqmOJP8KWNGfmi6EKs0H2md0JU3HK
         vuURoyjRF7g5ZbZN/WSaaVdkZz8R9/gkJJp0yqSmdKoCm8aUiwrW92/zR9rIyRNdzP/m
         XAVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774879358; x=1775484158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KjB/UVz/vnJ23xIYfblwh45FQTiDMykH3MwZx75uAOM=;
        b=SzKE0Tin7y8a4NBmDzUqlON50Izn/bvIXebm2hZuO7d8eStmzams8/QRhXSedy8/P3
         rwqnEA5oFppT5Xq0uP4h1HDcdC1aAPB9OBnd4+o3QrfqL2icI9NGnirqhIYymH0HbXc/
         k1k0ZqyHBbudMCf/XtrezmRp+aAaUL4znkgXUxjpYCPlBeRnzLnYRFEKV4LTi6PIKexi
         r9jnPUg6lm2kLOIf2kf+Win9BTd1+DskWycqzSw0LjHwjcxkbNSBvcSvlQXuAAkY+pSN
         zaaymsP2NyNny4UKYcgmFIJxYEs+gA84KKR5LXb1QDBpEGDCQOH2oSkRjS/NGjmQnmSI
         2ivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774879358; x=1775484158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjB/UVz/vnJ23xIYfblwh45FQTiDMykH3MwZx75uAOM=;
        b=EL7kLuzAQzsPCYN48M4hr2IzNOuQ6PZwWQJ60ao+of64pI/7I0kkpz0yAIDSWgl/uY
         OEFzPRzh3Yzrr9QROtIw+oym+aGA4aH5w5F8A6LqpuSBcxg+HE1j/oJn8zJZRBr2YH6A
         g3g1bMuyp33bu92AmhGcrpF5kpEDlu/KWrGzcb8g6h6cciWcQdSuaoNQGKbS0W8bjkDn
         i84FCTaxNP8bNKOX4NKqpUdCaeE30J523vKMlGAYzsx+TKcIlQfMtuOHSBF48LOIpK3I
         pQjrpww0VstBAVjtnlb+RgLFjgOZIEcb7W3ObpEzaKpn5hkJhtI+yNnZ/q+1C2lm50oJ
         mk0Q==
X-Gm-Message-State: AOJu0YziYETmF9PBFV7G8VqmnzGIAVelw5xjXqTXLhGzxidOSHfIUBlc
	mrvOzQyllOrZamz7jsnLepIyG4AkyagQT8u57PhgW8ahs9x3pB+/FSflPIqWhP9M4HbabbH7WOR
	hc8m6VBmAt/Rws5rQAj2FeTgR5hlwFPE=
X-Gm-Gg: ATEYQzzMk+h3JQ4Ej3+V09qX/5Qb9HLYtB2wrRTiQQWSvkYJ5nRisjsIcUmXdoN8Nsj
	yAh+QEzLUswfbqjxx373AeLyEzG+WujjpTedrOwdwH95UKl13za3zfm5rw+YLubXHGTFjZmSN4i
	4dorBU2ISvey8svUGEktJnCNVj/hSGHsPkt7A4tWW13a+OT1LCP54MqnusA3/8lWVEIImR+qVAm
	M7Z+QAISR2tMbWSD+ZMb1Dhk4809pSFgja41xXZgfqJbtNqQj47nn8u1Nav1m9hiZGb5mz0ulIj
	3oe32+GHysn0G0tGW27E4SHLbAcLQOvTLVLbnIWhXJAKA/Lv2szwwwTakrqU
X-Received: by 2002:a5d:5489:0:b0:43b:a21e:9c19 with SMTP id
 ffacd0b85a97d-43ba21e9c7bmr14963980f8f.38.1774879357807; Mon, 30 Mar 2026
 07:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330032124.3141001-1-memxor@gmail.com> <20260330032124.3141001-2-memxor@gmail.com>
 <m28qb91w6r.fsf@kernel.org>
In-Reply-To: <m28qb91w6r.fsf@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 30 Mar 2026 16:02:00 +0200
X-Gm-Features: AQROBzDpKGwX6F0CTM-N2Sile2tLaGHYutBcYpbqPZS2MtZQx9jiuM0J1cmCL38
Message-ID: <CAP01T77PKKrejHXqTK3ojOo-GP_rO+oyUu=79LYj8_EBQ_4dUQ@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix grace period wait for tracepoint bpf_link
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Mar 2026 at 11:52, Puranjay Mohan <puranjay@kernel.org> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> > Recently, tracepoints were switched from using disabled preemption
> > (which acts as RCU read section) to SRCU-fast when they are not
> > faultable. This means that to do a proper grace period wait for programs
> > running in such tracepoints, we must use SRCU's grace period wait.
> > This is only for non-faultable tracepoints, faultable ones continue
> > using RCU Tasks Trace.
> >
> > However, bpf_link_free() currently does call_rcu() for all cases when
> > the link is non-sleepable (hence, for tracepoints, non-faultable). Fix
> > this by doing a call_srcu() grace period wait.
> >
> > As far RCU Tasks Trace gp -> RCU gp chaining is concerned, it is deemed
> > unnecessary for tracepoint programs. The link and program are either
> > accessed under RCU Tasks Trace protection, or SRCU-fast protection now.
> >
> > The earlier logic of chaining both RCU Tasks Trace and RCU gp waits was
> > to generalize the logic, even if it conceded an extra RCU gp wait,
> > however that is unnecessary for tracepoints even before this change.
> > In practice no cost was paid since rcu_trace_implies_rcu_gp() was always
> > true.
> >
> > Hence we need not chain any SRCU gp waits after RCU Tasks Trace.
> >
> > Fixes: a46023d5616e ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast")
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> With a nit below which is mostly informational.
>
> Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
>
> > ---
> >  include/linux/tracepoint.h |  8 ++++++++
> >  kernel/bpf/syscall.c       | 22 ++++++++++++++++++++--
> >  2 files changed, 28 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > index 22ca1c8b54f3..8227102a771f 100644
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -113,6 +113,10 @@ void for_each_tracepoint_in_module(struct module *mod,
> >   */
> >  #ifdef CONFIG_TRACEPOINTS
> >  extern struct srcu_struct tracepoint_srcu;
> > +static inline struct srcu_struct *tracepoint_srcu_ptr(void)
> > +{
> > +     return &tracepoint_srcu;
> > +}
> >  static inline void tracepoint_synchronize_unregister(void)
> >  {
> >       synchronize_rcu_tasks_trace();
> > @@ -123,6 +127,10 @@ static inline bool tracepoint_is_faultable(struct tracepoint *tp)
> >       return tp->ext && tp->ext->faultable;
> >  }
> >  #else
> > +static inline struct srcu_struct *tracepoint_srcu_ptr(void)
> > +{
> > +     return NULL;
> > +}
> >  static inline void tracepoint_synchronize_unregister(void)
> >  { }
> >  static inline bool tracepoint_is_faultable(struct tracepoint *tp)
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 274039e36465..ab61a5ce35af 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3261,6 +3261,13 @@ static void bpf_link_defer_dealloc_rcu_gp(struct rcu_head *rcu)
> >       bpf_link_dealloc(link);
> >  }
> >
> > +static bool bpf_link_is_tracepoint(struct bpf_link *link)
> > +{
> > +     /* Only these combinations support a tracepoint bpf_link. */
> > +     return link->type == BPF_LINK_TYPE_RAW_TRACEPOINT ||
> > +            (link->type == BPF_LINK_TYPE_TRACING && link->attach_type == BPF_TRACE_RAW_TP);
>
> nit: this second check is never true here, because BPF_LINK_TYPE_TRACING
> uses bpf_tracing_link_lops, which has .dealloc (not .dealloc_deferred)
> and this function is only called from dealloc_deferred() path.

bpf_raw_tp_link_attach has a special case for this, where this
combination ends up using bpf_raw_tp_link_lops instead.
I will add a comment since it's non-obvious. If you think about it, if
this wasn't the case, we'd have another bug.

>
> [...]
