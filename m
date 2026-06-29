Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1320936894B
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742130; cv=pass; b=jfNZglx5h678tBX/fX8ZbOSiUeR20sSdJUmVoeDBl7hpHMld959GX08c6it2QMqftwufsbaJ0JEBEXHTtCSdGd5iRFxd0A+oYUwFpdDb/kTj841UV0JACk+ErMtEA6kHPXPaEFNXs0L2VZrwVhGScYDYS3cv34+kEFExBUL4u48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742130; c=relaxed/simple;
	bh=q8QVdB9NJN+/zi8Xa6uyCMmfy4NxiwhJalxYShKUiSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSBPBOIVoFb8Hn2XfUB9juUsceriRVIKH0MG8JytKtRzH5iBZTg9GDHr6iY1VE3GVjSUKTSmZKHu+BUynwgkmJeC6ZztYZ5oWWgtzi+9GO8ItEdOyr2uFqNdesvsC+MdZC6E7Iu4tU8HlE08df9AiFOdYkxOD6d8hhf0oyN7Mv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=XksBjP4o; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="XksBjP4o"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-664a09bc459so3028141d50.1
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 07:08:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782742127; cv=none;
        d=google.com; s=arc-20260327;
        b=fGH+jjFbG6zBtgUI/cf6lh1uv0/YWJPNtF3AH3apogmJBS2IAR4IJoVDs1ugc48iGP
         moQAISrAlD433258E1DipCqDaWPngu1lBelLkodUhulm3SD+Qm9NZsfVMf9bMU7xrdS0
         R/bROA16kctR9evvnUafJYyGwtRC+cH510kwfPzreLJHwBDQSW2/awRMI+Fcpb+Ei9TO
         q7sudCb0fRzeJWNeoDpa6sm5QUIE/uEV8V6ZI56cMvR9WADbHzWcQRxhdHelyRKl9KjE
         1kPeP35F/7h4KhBpJVUN/7JcHdxd9Ebmxw2L8b6DyuW5yDKp4LWcJ27Eu/QWr1fUI//+
         FHGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kayxw8M9qLEbLCSUnNOcv0HfIXS5cEO8Cn8lVzCr2oA=;
        fh=XT1EHs8/E07gBLdgiQvVoYa2FWok7037du82WS0138U=;
        b=KubQmC/inoesdY1Wha3xMV9kTJVvQETqEH1uRlmeyhsfW404I9oqHPDF6Wmiov5E6r
         O5QxWmgLEKlDe0fljYJKTrxClp1bIdUKVwfUEhQhqfa1IUyxkYPZOeVFO0Yjp6K6omrP
         ja0J6aRPLElPLsCog7GKsTfgwEY7JSW7JESPkfXnPBShZaLsCTXjUwSA9KCpnq+uOJOw
         /DO9PFaHMHMGD81kAYoShCEyRpxqmjD5+9fY226BDRQWXIh4AqVFhfmQF+d1lmY2ig4B
         PyBMMCZWlO+D3DyyrIKVOyvxFVL6kWxZ6YAvPa/JRYFJKkPkzrV5lAg1Kqybd8rb4A3H
         hf9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782742127; x=1783346927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kayxw8M9qLEbLCSUnNOcv0HfIXS5cEO8Cn8lVzCr2oA=;
        b=XksBjP4onHdQGNQhjSwLsyFa5U7EewqqYv64OBG477NoI+++Tzw60DB7vQAZvZbWUY
         +wnPRwDg7tNhwk/aXmOESi2i4WG0ddy05TpTtLnU2ORZWEBiTZyYntVGdsQ+zCmpBv9K
         Im1tPOFZtf9o+0WBcY7VNiERNX0K7lpExRr7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782742127; x=1783346927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kayxw8M9qLEbLCSUnNOcv0HfIXS5cEO8Cn8lVzCr2oA=;
        b=UngHSNQS7zWtKFW0pkQqwTk/pNH8ySqsQZ1SPofrIf23LDvaHoAn9iI5mZa88YCbV+
         76nHU93veXrZc/4l91+hmZQWRS4HwuBXbIc2JGqIZYvfoIb1NdA+FP2FUHy24O4Uv2DX
         YUx5Azxo9K8MaGkMQlqcAHZEULwEapq+IkaJ1dsEpjIo892QTamU4h1ncJeaejEV0tpK
         zA5CKWJSuJggEdDArIshNIyeL/8ReaZMeW0PNXuCYtH+38tPxOrcfoQ54hJRlPSRNHbb
         NKhHEaAMEse17h+SkgtCIU6oYMeUpu2c3MHm4k62hu1kN4Cc0adn25555Oulu/PZf2/+
         3Dzg==
X-Forwarded-Encrypted: i=1; AHgh+Rpd72Ows6pe1oKELbLUXFZP8MZJdbJxTDBQ6NwxUEK1OFQhhrbd6YDJhBGTFIrUdhclQBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBYbwkKld7bU9ZBKDuI96fP4NX+9aGDTTcdDnHG2WLRBf615kG
	0yMDxxjk8dk9frPtwAe/UFLIY5VzMyKLiAP4q0pPYQqk2FQVtZiv61/H08xYhgI3bNf7plzNKqC
	jDFCJX6xZyzFR+lgFqSjIINMZShIUhR7Tdc/2RynS
X-Gm-Gg: AfdE7cmYyxjs5afjUm7+TuwWBIWN81Exy9WsqMIiiL48kkhhZU1uYTwB210rkUPzdj6
	gkauKikXDff8y9YSYt5AbQU7BRoJhOlbLO9ZMnDlVeeFybTsIvmMeflea+072i0ZqqZxkT369sR
	rzgdmfFlE4GNSsJjJWeB5RkiKPL4vH/BZSBW6tysIH4fR3oKlZNgzs4wCsx+ta02utI1EO1N6C3
	x5B9bJIm7eESOSkbOvNby/UEjZ8JfTEhk/Lmh15tXxKwAPVe+KLpGefEldpG+FTtammfg==
X-Received: by 2002:a05:690e:11c9:b0:664:cd1c:3c1c with SMTP id
 956f58d0204a3-664cd1c64c7mr3930877d50.0.1782742126728; Mon, 29 Jun 2026
 07:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629102157.737306-1-jhs@mojatatu.com> <20260629102157.737306-2-jhs@mojatatu.com>
 <a1a31c1e-b5bf-458f-a80a-bc324fc7a07c@iogearbox.net> <CAM0EoM=QsOZ+mbWk7Ysv8-UNMzbmzbYiNXvF9fjEnG1-bDv6YQ@mail.gmail.com>
 <8a462b1c-b79b-42c5-8409-a36ad727f994@iogearbox.net>
In-Reply-To: <8a462b1c-b79b-42c5-8409-a36ad727f994@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 29 Jun 2026 10:08:33 -0400
X-Gm-Features: AVVi8Cdkj6dZhabBc0jnLqVMZa0vjqL1ozX4LLqAaVAUSsSvVM-qHxGJioR3gI0
Message-ID: <CAM0EoMknehYGAse7AfAN12oEYvQ894YbJrdhv1unOYgpTtvzFA@mail.gmail.com>
Subject: Re: [PATCH net 1/3 v2] net: Extend bpf_net_context lifetime to cover
 qdisc enqueue
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, toke@toke.dk, Steven Rostedt <rostedt@goodmis.org>, 
	Petr Machata <petrm@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, security@kernel.org, 
	stable@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 9:49=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 6/29/26 3:36 PM, Jamal Hadi Salim wrote:
> > On Mon, Jun 29, 2026 at 9:01=E2=80=AFAM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >> On 6/29/26 12:21 PM, Jamal Hadi Salim wrote:
> >>> The bpf_net_context used by sch_handle_egress() is stack-allocated an=
d torn
> >>> down in that function returned. By the time tcf_qevent_handle() runs
> >>> current->bpf_net_context is NULL.
> >>>
> >>> When a filter attached to a qevent block (e.g. RED's early_drop or ma=
rk
> >>> qevents, which always use shared blocks) returns TC_ACT_REDIRECT,
> >>> tcf_qevent_handle() calls skb_do_redirect(), which in turn calls bpf =
helper
> >>> bpf_net_ctx_get_ri().  That helper unconditionally dereferences
> >>> current->bpf_net_context resulting in a NULL pointer dereference.
> >>>
> >>> Note: The same holds for actions that invoke BPF redirect helpers
> >>> (e.g. act_bpf running a program that calls bpf_redirect()) during qev=
ent
> >>> classification itself.
> >>>
> >>> Fix:
> >>> Move the bpf_net_context lifecycle out of sch_handle_egress() into
> >>> __dev_queue_xmit(), so that it spans both the egress TC fast path and=
 the
> >>> qdisc enqueue.
> >>> Note: The call is placed outside the egress_needed_key static branch
> >>> to cover the case where clsact static key is disabled. Unfortunately =
this
> >>> adds a small unconditional penalty to the code path _per packet_ only
> >>> guarded by CONFIG_NET_XGRESS (two writes and one read).
> >>>
> >>> As pointed by sashiko [1]:
> >>> The same context must also be set up in net_tx_action()'s qdisc drain
> >>> path, since qdisc_run() -> netem_dequeue() -> qdisc_enqueue( RED chil=
d)
> >>> can trigger qevent classification asynchronously from softirq context=
.
> >>>
> >>> This keeps all bpf_net_context management in net/core/dev.c i.e the
> >>> existing boundary between tc core and BPF without requiring any net/s=
ched/
> >>> code to know about BPF plumbing.
> >>>
> >>> Reproducer:
> >>>
> >>>     tc qdisc add dev eth0 root handle 1: red limit 1MB min 10KB max 2=
0KB \
> >>>         avpkt 1000 burst 100 qevent early_drop block 10
> >>>     tc filter add block 10 pref 1 bpf obj redirect.o
> >>>
> >>>     traffic through eth0 triggers red_enqueue() -> tcf_qevent_handle(=
) and,
> >>>     on a redirect verdict, a NULL deref in skb_do_redirect().
> >>>
> >>> Fixes: 3625750f05ec ("net: sched: Introduce helpers for qevent blocks=
")
> >>> Tested-by: Victor Nogueira <victor@mojatatu.com>
> >>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >> Could we simplify patch 1 & 2 by just moving the bpf_net_ctx_set() and
> >> bpf_net_ctx_clear() into a tcf_classify_qdisc() wrapper where we don't
> >> end up having to touch the core TX code?
> >>
> >> Untested diff :
> >
> > This is bpf plumbing which doesnt belong in tc really. You already
> > moved most ebpf/clsact stuff into dev.c - let's just keep it there.
> >
> > As a side note: calling a hierachy of N qdiscs we would incur N
> > set/clear cycles for N levels =E2=80=94 and worse, qdiscs like HTB and =
HFSC
> > iterate filters while loop calling tcf_classify_qdisc() per iteration,
> > so each filter chain traversal does set/clear per proto.
> I'm just saying that this is a lot simpler and taken out of the core fast
> path. Also, I think you forgot to Cc Sebastian on the whole v2 given the
> bpf_net_ctx_{set,clear} dance. Imho, having them via tcf_classify_qdisc o=
r
> something similar would be the much better choice compared to sprinkling
> ifdefs since you want to block the TC_ACT_REDIRECT from classifiers attac=
hed
> to qdiscs.

And you are clearly not listening to what i said.
Something similar would be fine - but stop using tc as your dumping ground.

cheers,
jamal
