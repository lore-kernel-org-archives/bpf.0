Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793305393;
	b=LbNOQ9t+WQqOZ8HOeznRAT8ojGD2QG/cDlcI8TFQSYUoUnClY0Jv1T/Nw1dqTfu/T20n
	 RiMKD+6vUsY3KcYW867wwXE+3E9vB0KdZRadnRlL/LMFOBuOVPwxBb0QqMfdqwToEqch5
	 b1OQL1k7MfqkFZZgmmxhFOhkREFyMOidD+R7O80KQOSgH9H1Yuya1MpRqsMRpkws64vno
	 4a35wUZmllbYd7rfdjVSJvLESOvX7lTOXPI0aJl3H7gdWUkK9HCLty9Y/cw4cYIFhy4bD
	 KgBSQ81bkC+mjy9+tQlbzeG5W2d0em56zXq7s2MKRIHII1Y5Dg8vCJ/8Ls1JI/MFhUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793305393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KiIhvG8lOlwQG0lb7m/oiOyUeW6Fz+zTOcXywbar0lE=;
	b=pCRNqexG0moHgqIv4Up0wPuSEFkEGXTXU39pOk765DvCnBx8VSd1SAcNBm9QrapuB4Rq
	 rQsWshWOj2DAO8bhq3hLPESvoyIM6g0ZvrTFdsq3wXuIQEtpqAJmVQxA81gV0ujUJ7Ens
	 Yl6ARQd0r41aRhTnnovyBKjsx6olm9Ev14yh2aVPC9OceyC8HjTJ5yvnLq6MdDhGQN+/K
	 AFLhQa9HH9GPWn/cnl6TVcyPlr2MjSGOozbTbGOIz8RzZO7U/GnE/ef5YZX6uo4P1BIND
	 fNVBET+qc+p6M/tK9i2w69NBKnsOnrtSEI4iPMwm563ZJ2OI0kChSq6/leeZqIM69FQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="Owv/Hl4t";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426D7606A31D
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 20:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 426D7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Owv/Hl4t
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a070755c8cso1498151b3a.0
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 13:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793305393; cv=none;
        d=google.com; s=arc-20260327;
        b=lDFzXFrjXLnetiYzF4p0t7LZKZUNrGsCpPGYh1AOXMF+8HsckCoKLN1vNxR4heYQbS
         9XNRvg+I58CiQLVbdWn9EUondcMr1YlwXMfdIjvb66jY20nndl3w8kIrpJ+EajaQ92sP
         So7UO73gNIzWzPZdNExg4KI8B0d3P6Fomy3uU5tXvAfD/8qumsMPoa15iQZWs87YBZmJ
         vLd72YtJhK62CzrrEakGlZEe0oAkXtLLqYFM1NMfaqDBYCJEaKtFuuG3SOGe4sSsn/xN
         WgPc+EvwqjYfAJMVu0g6OAYuJgHpG0mtiGbsHpyyE+vGcV6Lz/Jzs/AtxatNlnLUkw2b
         wlRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KiIhvG8lOlwQG0lb7m/oiOyUeW6Fz+zTOcXywbar0lE=;
        fh=NOX5ICr6ZDYnULHVBx3fiELSoNsgEMyBYshodlrwoRY=;
        b=KbDVOd8MatXBTwHv17oSIUxbBWAQ4MSHewjLEAY/oqT1A/XWJP9xYvx7xAcw9BkMDX
         uvXPqpzeRGasGDRJgsO2li9TSRRK2Sv2lUCs5e2HkAjYOOSOarYMoH6hKbNUVNcP2ZYU
         V/w0Gg9Eo99brwtALZnQzGNadY4GA2QRGSToHL3/rtB6a+8Hp3g7Tg2n7gf66D7fGTi1
         kkYQCdRGKjq/tPHM7osaGRPv8O3NnZ3x4vjhUoqYEE84O9xGrgBDXtt/ytpYwf+01/aN
         yMPF4cmevzFLNGQdj1KBA2hROjLBpieh4vqeqCq1cdD59MwcawM0bbml+UThb1sWbJ42
         Hnbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793305392; x=1793910192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KiIhvG8lOlwQG0lb7m/oiOyUeW6Fz+zTOcXywbar0lE=;
        b=Owv/Hl4tmYNSAfPAJqqnfF3fbaCCZFLWmIsEAI6P6HzBe2cgGRujaZv5L4P/FsyZZu
         mi6KbNn4DM+Tf8V2OeBjiLBpc9xXhBMeCKtGsEhgxQaaIivkb1kqphGZw1bPtLXquQ6O
         t0KsHWo/ZCVrxJxeT5kwhfQk5AEWx5sbkdgFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793305392; x=1793910192;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KiIhvG8lOlwQG0lb7m/oiOyUeW6Fz+zTOcXywbar0lE=;
        b=PH5ABalWCCv8hwJRIo7a80PbFDQbDVwbABnPGPKvX3Fgm+Z4LLzh70m6o9WTkxsgaH
         sIupL7OLmhkCwXO3oMZhR2pAytloderST6sOG/994CpPnOwijYZGvJsI9xrO8++ukOjg
         cV9DPwGuCBdb1iUl9DS1b0ikEVqT4aGJm0w4f866obP1D8tVxZEoettJo3ENFm4TzwNR
         pDW2WwrJ2GH9Ms0Vq7l7ItnSUmd1873oYseu3P9EE1HgvkbvTsSKxqnSHIock5E3rXXG
         6plv12m1HhwQsZ8T2K/Am8N4sTHQEVfq5COU7nmgaRB5TOjlunPVPxDE9BcnBIO2hJB3
         ZvAw==
X-Forwarded-Encrypted: i=1; AKwUvBxPj7Grod93Pi9z/MfSgDBbTcxJ2Fs26E2/N+4D664iMDmxbrvjaLvI0SL/wGei3d7Z3A8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIroJYSgweTnPv+qS7k4EmEM+8HisodHF3vzvFeyr/Rrhoh/JqS
	9xiPP9thcwg+B5AFuKdxUerqCYNVO1TvC48M9/MUhXBl7lGA26F/vwqRYkofp1awvfz3BpURX6H
	L8O9odq4g8u0kwFOt/T3HXiqHLByqtY1ejAjUUsRZ
X-Gm-Gg: AYBFou20o9LV0bliOFGjcCerGkxdplSFG4rBFloCsHQj0VkRTOygci9fKDRHtw+e6Xk
	5F0e4yzklh8NkzD9o5MWpd+bLGIrhqxK6WBMb6XP4lCte6iPrIV25RFn/3FqFhhb4XZpzgdyWl2
	Q9tC8JM7+IRC8cwu5bn+Qgp1RnKyblyxP2Qp8pmACbQa3n6EPVYduH5cJbJb9BixZxf+DdaXqLK
	2mf7+jruuH9a5DWJhMHZzdT5KmgfU4/t+7BDe6Ad44uYc8dmQmaqamrOvNZJhIpDj9xBxw9vuHk
	2fW9NiYfpQWmuHrN3nSrN1AYLxBwa0CRWeN4wyNaoN/ZEsWATse+C60AnBfQ8H4ycw8/u+pmbsd
	eJFYH8WDm2Zq3f6u4JCN3I5MnfEkGH9vSuz8yucPHhpHy1eW2ZI7JiLZf3Qbseq583YjARknkQS
	NBR3aQwO63JaIQ5SI=
X-Received: by 2002:a05:6a00:1814:b0:898:3898:3826 with SMTP id
 d2e1a72fcca58-8a9be58914bmr217096b3a.14.1793305392573; Thu, 29 Oct 2026
 13:23:12 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-MD1X.v5.r0.20261026053226-1@mojatatu.com> <179329777513.3134.12135506558709584471@kernel.org>
In-Reply-To: <179329777513.3134.12135506558709584471@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 29 Oct 2026 16:23:01 -0400
X-Gm-Features: AclHuK81fdOF3hQJNx2mlfsMkazycSpdb9h0JGAAUY4VUhgLcYcrWN6YKU1fFJc
Message-ID: <CAM0EoMm_3=sHFEcoynZpNMb_Y2sT=a8WZeKz_2Ewn4eo9rfJ_g@mail.gmail.com>
Subject: Re: [PATCH net v5] net/sched: clamp skb->queue_mapping before
 indexing the tx queue
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	vinicius.gomes@intel.com, horms@kernel.org, hawk@kernel.org, 
	daniel@iogearbox.net, sashiko-bot@kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 2:16=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The patch silently changes behaviour on stable kernels, and
>   its commit message and docs do not describe the change accurately.
>

sigh. Exhausting. I will send v6 with the commit message fixed.

cheers,
jamal

> --
>
> net/sched: clamp skb->queue_mapping before indexing the tx queue
>
> A tc BPF store can leave skb->queue_mapping out of range. This patch caps
> it in the qdisc dequeue paths in sch_generic.c and in taprio_enqueue(), s=
o
> it can no longer index dev->_tx[] or q->qdiscs[] out of bounds. On a
> TCQ_F_ONETXQUEUE qdisc the mapping is pinned to the qdisc's own
> q->dev_queue instead of being capped to queue 0.
>
> Closes: https://lore.kernel.org/netdev/179033713973.2160803.4914570693994=
398206@kernel.org/
> Link: https://lore.kernel.org/netdev/179293123940.3134.114912867992323467=
7@kernel.org/
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v4.r=
0.20261021042722-1%40mojatatu.com
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v3.r=
0.20261015165943-1%40mojatatu.com
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v1.2=
0261005193231%40mojatatu.com
> Link: https://lore.kernel.org/netdev/20261015125822.GH83879@horms.kernel.=
org/
>
> > diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> > index 6f6a6f0d5eb0..5dc1d47f811a 100644
> > --- a/net/sched/sch_generic.c
> > +++ b/net/sched/sch_generic.c
> > @@ -96,9 +96,34 @@ static void qdisc_maybe_clear_missed(struct Qdisc *q=
,
> >
> >  #define SKB_XOFF_MAGIC ((struct sk_buff *)1UL)
> >
> > +/* Re-cap a stale queue_mapping; an ONETXQUEUE qdisc pins q->dev_queue=
. */
> > +static u16 qdisc_cap_skb_tx_queue(struct Qdisc *q, struct sk_buff *skb=
)
> > +{
> > +     u16 queue =3D skb_get_queue_mapping(skb);
> > +     struct net_device *dev =3D qdisc_dev(q);
> > +     u16 capped;
> > +
> > +     if (q->flags & TCQ_F_ONETXQUEUE)
> > +             capped =3D q->dev_queue - netdev_get_tx_queue(dev, 0);
> > +     else
> > +             capped =3D netdev_cap_txqueue(dev, queue);
>
> [Severity: Medium]
>
> On a TCQ_F_ONETXQUEUE qdisc, this branch rewrites the mapping of every sk=
b,
> not just the out-of-range ones. Is that intended for in-range mappings th=
at
> a classifier sets on purpose?
>
> The rewrite happens in several places. dequeue_skb() applies it to the he=
ad
> skb and to gso_skb. try_bulk_dequeue_skb() applies it to each follower.
> __skb_dequeue_bad_txq() applies it to skbs taken from skb_bad_txq.
>
> Here is one way to hit it. Take a per-queue child of mq, mqprio, taprio o=
r
> htb offload whose q->dev_queue is txq i. A filter on that child can run
> "action skbedit queue_mapping j" with j !=3D i and j < real_num_tx_queues=
.
> tcf_skbedit_act() accepts that value:
>
> net/sched/act_skbedit.c:tcf_skbedit_act() {
>     ...
>         if (params->flags & SKBEDIT_F_QUEUE_MAPPING &&
>             skb->dev->real_num_tx_queues > params->queue_mapping) {
>                 if (skb_at_tc_egress(skb))
>                         netdev_xmit_skip_txqueue(true);
>                 skb_set_queue_mapping(skb, tcf_skbedit_hash(params, skb))=
;
>         }
>     ...
> }
>
> A tc BPF store of an in-range value behaves the same way.
>
> Before this patch, qdisc_restart() sent the packet on
> skb_get_tx_queue(dev, skb), which is queue j. With this patch,
> dequeue_skb()->qdisc_cap_skb_tx_queue() first rewrites j back to i. The
> packet then goes out on queue i, and nothing is logged.
>
> The commit message says:
>
>     netdev_cap_txqueue() already logs a ratelimited notice and selects
>     queue 0.
>
> The TCQ_F_ONETXQUEUE branch never calls netdev_cap_txqueue(), though. Tha=
t
> also covers the 1-queue reproducer in the commit message, because
> qdisc_create() sets the flag on every non-multiqueue device:
>
> net/sched/sch_api.c:qdisc_create() {
>     ...
>                 if (!netif_is_multiqueue(dev))
>                         sch->flags |=3D TCQ_F_ONETXQUEUE;
>     ...
> }
>
> So in that reproducer, a store of 1 from the filter on the prio root is
> quietly pinned to 0, with no notice.
>
> The only place that says in-range mappings from a filter on a per-queue
> child are now overridden is the v4 -> v5 note below the "---". git am dro=
ps
> that part, and the patch is tagged for stable.
>
> Documentation/networking/tc-queue-filters.rst also still says:
>
>     2) TC filter directs traffic to a transmit queue with the action
>        skbedit queue_mapping $tx_qid.
>
> It does not limit where the filter can be attached.
>
> Could the commit message describe the pinning of in-range mappings, and t=
he
> missing log message on the TCQ_F_ONETXQUEUE path? Should the documentatio=
n
> be updated to match?
>
> > +
> > +     if (unlikely(capped !=3D queue))
> > +             skb_set_queue_mapping(skb, capped);
> > +
> > +     return capped;
> > +}
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-MD1X.v5.r0.20261026053226-1%40mojatatu.com
