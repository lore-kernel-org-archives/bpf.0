Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466038;
	b=Kss4vmZ7xPL2tmq8eRYyCjZN6YW2tIyRM6fG3yxBxVC1FcB7mPRYFhl8M8OtOVcG2h/O
	 b+PHvwYQSHxWico1lGonu4tUFjvQoOZiBbqUlDoU67v+saaOZWO6IvBR+8aLwTRlHpTQO
	 YN5Vw0Y9QVX8KCkLF+c/qAOejYwkmwNkmhquDK8KIhZKL05NIoKn/YWLYq0OJrQJOyz3U
	 KVGhgm+cZG3PPIRGlJXNpKzGwBri6paXwQoaDfpHL5lGuzSLb47/R0lXMqAvGKkvFS0tI
	 G5BBceSuFfP8IJwyPX+RWZf3a2+3US2pUI74obxbiCgezkDwGWg5LNat3suC3wZBpTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466038;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=wthDU1MJlKXQ4gOwfl778urHAsy7uIMOzikS225CULI=;
	b=iPdA+vdosGlJyl1kxKme7Owgy7RBFd7ampz4KGb12HSorn2dSRjCNFRwkOvpOt1j/EIr
	 i2O4/WuxtWW6SjqmIjzhqcJmTF+tl+hDdsk1m+lIll3OnKjkFHCPbPVQ1p51cmbVOY7t6
	 8+08exF6gVmMBL+NQIvgvxdC5sMullX0sUrz2pUaQLIdC01m4fFCTmPYQrbV/1Db1YUC2
	 275rDULqbYMG3nstrOw/aLF/VvSEuhifxU3eqK6LTDbZXAVSRRgEb6zaVDBTB4pAASCYR
	 sgxuBnLdiq+gMqHdiYrd36Unjrsog86Gj9ovFrEJ0kprIv3f2A9FQEt8EEyT/1FpDuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAEUPNTs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD37606A321
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 20:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAEUPNTs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BA91F000C6;
	Mon, 23 Nov 2026 20:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795466037;
	bh=wthDU1MJlKXQ4gOwfl778urHAsy7uIMOzikS225CULI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cAEUPNTseR6VaDek247Kwgu29WTR0qIw6gySaahY0sG9UkuywEcyTdpnGClML9m4D
	 1kVCbekSSXfNTstzgln7n6Mw9loq+dKaqRlV/Cm5OWn+s3Ro/ji86raakPMf+w+/O0
	 mGoKnF3g3zV56p6vL7Oe31i0DB/IrkXgb4LakWCTix39o5ZPaN+Vi3aVcqQWhcnGCu
	 o0fQo3Wq18m6hbdY4iRrkb4mI9sFJPEjBdHB+X7D7u0AeBHJe9lCXN8WuPHIYeBVke
	 NtDmmO8Zgvpxh7Asm+qajt0OlBxaSfZjUHtzTxYNWCMT5b6rPOqdr4H7XhHpqMwqfa
	 pTHMWnyAeEb8w==
Content-Type: multipart/mixed; boundary="===============6775268101469017704=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <08485d99d4b1acae77cca252d58b50db686badaa018b58964adfee290b7e20fc@mail.kernel.org>
In-Reply-To: <a2d4276cbf11b1254aa7997874a6539d20f296cf.1795463894.git.memxor@gmail.com>
References: <a2d4276cbf11b1254aa7997874a6539d20f296cf.1795463894.git.memxor@gmail.com>
Subject: Re: [PATCH bpf v2] bpf: net_sched: Let bpf_kfree_skb() run with irqs off
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 23 Nov 2026 20:33:56 +0000 (UTC)

--===============6775268101469017704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: net_sched: Let bpf_kfree_skb() run with irqs off

TL;DR: dev_kfree_skb_any() in bpf_kfree_skb() may wake ksoftirqd with irqs
off, possibly deadlocking on a runqueue lock if a sched_ext callback drops an
skb kptr; irq_work deferral may be needed.

> diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
> --- a/net/sched/bpf_qdisc.c
> +++ b/net/sched/bpf_qdisc.c

[ ... ]

>  __bpf_kfunc void bpf_kfree_skb(struct sk_buff *skb)
>  {
> -	kfree_skb(skb);
> +	dev_kfree_skb_any(skb);
>  }

With irqs off outside of an interrupt, dev_kfree_skb_any() queues the skb
and raises NET_TX_SOFTIRQ, which can wake ksoftirqd:

dev_kfree_skb_any_reason()
    if (in_hardirq() || irqs_disabled())
        dev_kfree_skb_irq_reason(skb, reason);
dev_kfree_skb_irq_reason()
    raise_softirq_irqoff(NET_TX_SOFTIRQ);
raise_softirq_irqoff()
    if (!in_interrupt() && should_wake_ksoftirqd())
        wakeup_softirqd();

Can this deadlock if the destructor runs in an irqs-off context that holds
a runqueue lock?  For example, a sched_ext struct_ops callback such as
ops.running, called from scx_start_task_running() <- set_next_task_scx()
<- __schedule(), can drop a local object holding an skb kptr
(bpf_obj_drop_impl() is available to struct_ops programs):

bpf_obj_drop() -> __bpf_obj_drop_impl() -> bpf_obj_free_fields()
  -> bpf_kfree_skb_dtor() -> bpf_kfree_skb()
  -> dev_kfree_skb_any() -> dev_kfree_skb_irq_reason()
  -> raise_softirq_irqoff() -> wakeup_softirqd()
  -> try_to_wake_up(ksoftirqd/N) -> ttwu_queue()
  -> rq_lock(this_rq) while __schedule() already holds it

ksoftirqd is normally sleeping, so the wakeup would be taken.  Previously
kfree_skb() freed the skb inline in this context, and for an skb without a
socket destructor it woke no task.

Elsewhere BPF defers work for this case to irq_work, for example
defer_timer_wq_op() uses the same in_hardirq() || irqs_disabled() test and
queues an irq_work, and bpf_mem_free() does likewise.

Is the skb kptr destructor expected to run under scheduler locks?  If so,
would an irq_work based deferral be needed instead of dev_kfree_skb_any()?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45257226477
--===============6775268101469017704==--
