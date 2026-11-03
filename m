Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699972;
	b=3FcH4G/N5esDnqI9LbSGXnZQedx0byzlW//2d/J1Pl65NKjEQN9yifjj2mPQgD4MNkdH
	 JQWJUmzIsqxvKpyu3x2xD8GNC6FahHT9mk8z7YxoBBvwhdt2BN+6FjST8m8b+WWA6MQHc
	 gg1gOsH6pYXRhdYu8lOF/ks46t6+pqObszCfUMLxocS2tqp+ll83TCbKf5iUE4X2rA4gn
	 ScXlYspPSD57RAe/uvwO7Qx6PJ6b7dIzL9TyB386JHW7Rpc+uUz/onKqg9E85H98xV/16
	 WIVaL0bL3O7lmAxYjZLhf3VPtWcS/fcoUm1FyqeO8kmOJNDr5D/ICC4mCie6txi4bKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699972;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ja/E6TkmV2USNhcIVIMnBiNF3Ue8V8sGmWj6TSPjuWE=;
	b=WnCb6/fnrp9yt9Kdp/NTxUPdx1Ht0Aq6EV9ux4y+MoAr0BVfPathvfg5xcSS85TFNheD
	 ix/pt70i7BuwNTlYcnLGKFlRRbmnHUwlqCrhuI9OVNKhu+uGW5z5v4X5fy/PjA3mrfLxm
	 OKQNHyjgb5mqvz/1JigF/anLBtSahjOWJ8qvf/Pt96yG4JMBivGwROzH0HdwU/wQtm4xl
	 4eJXqwlrVnuGCQ2jdjZcpcFv+ibMepMOuide7J7/rJyA43qVgPnTigHkKLlXMV4+VJXTc
	 iQwKHac/UWT1SQrS78HpphRrF1cpuKcL4z6JfXAONXPi0yS2vTlpX9JnV4Wrd20bbig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oR4pUkIX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6976E606FADE
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oR4pUkIX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE1A1F00A18;
	Tue,  3 Nov 2026 09:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793699972;
	bh=ja/E6TkmV2USNhcIVIMnBiNF3Ue8V8sGmWj6TSPjuWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oR4pUkIXoFqy9f+RGQ2ia/lzb0NozXVQseRdR0ZfkMtbyTgrx3glZNOtrvX81w0sS
	 nnkq49CzT/pWO90Dwi8ASD4fGsd0D/Vum8bt3z8CHr4ybFqyvx+IKbeS/BKPjz6nou
	 IlXXonWOUMUL1mMOOa/b22CTon6hmdCOg4KpvXfou4LLhBUqAgR3KDkHWbPFLxrChw
	 wWB5LZsOHIsfXwgCbSWt94lCvLfuXeENW/vSUhNS8flPXxOSmz/u9ibUmW2rZnGW07
	 viIZJdBIT5yfRcD1Kn4AgMRnjBe47ScmWiW1K5yYmcrK/KvDsQcw5LJN+oVdSeaKz+
	 193ygMLaIu7pA==
Message-ID: <sashiko-outbox-194993@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/4] bpf: Add BPF_TRACE_UPROBE attach type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261103093400.112178-3-jolsa@kernel.org>
References: <20261103093400.112178-1-jolsa@kernel.org>
 <20261103093400.112178-3-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 09:59:31 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: private stack remains enabled for uprobes without BPF_TRACE_U=
PROBE
- [Medium] bpf: missing BPF_TRACE_UPROBE validation at prog load and attach
--

commit c83a6cf6c87c8d327256fad738b73343332bf238
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Add BPF_TRACE_UPROBE attach type

This commit adds the BPF_TRACE_UPROBE expected attach type for classic upro=
be
programs, disables the private stack for programs using it in the verifier,
and rejects attaching them to non-uprobe perf events.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a9c6a4b8eecce..7c941e009a337 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5707,7 +5707,8 @@ static enum priv_stack_mode bpf_enable_priv_stack(s=
truct bpf_prog *prog)
>  	switch (prog->type) {
>  	case BPF_PROG_TYPE_KPROBE:
>  		/* Disable private stack for uprobe programs. */
> -		if (prog->expected_attach_type =3D=3D BPF_TRACE_UPROBE_MULTI ||
> +		if (prog->expected_attach_type =3D=3D BPF_TRACE_UPROBE ||
> +		    prog->expected_attach_type =3D=3D BPF_TRACE_UPROBE_MULTI ||
>  		    prog->expected_attach_type =3D=3D BPF_TRACE_UPROBE_SESSION)
>  			return NO_PRIV_STACK;
>  		fallthrough;

[Severity: High]
Can classic uprobe programs still end up with a private stack enabled and
corrupt per-CPU stack state when expected_attach_type is 0?

Classic uprobe programs run via __uprobe_perf_func() ->
bpf_prog_run_array_uprobe() in preemptible (and sleepable when
prog->sleepable is set) context with migrate_disable() and without any
per-CPU recursion guard:

include/linux/bpf.h:bpf_prog_run_array_uprobe() {
	...
	migrate_disable();
	while ((prog =3D READ_ONCE(item->prog))) {
		if (!prog->sleepable)
			rcu_read_lock();

		run_ctx.bpf_cookie =3D item->bpf_cookie;
		ret &=3D run_prog(prog, ctx);
		item++;

		if (!prog->sleepable)
			rcu_read_unlock();
	}
	migrate_enable();
	...
}

If a BPF_PROG_TYPE_KPROBE program with a stack depth of at least
BPF_PRIV_STACK_MIN_SIZE is loaded with expected_attach_type =3D=3D 0 (inclu=
ding
programs with uprobe-only properties such as prog->sleepable or
prog->aux->kprobe_write_ctx), bpf_enable_priv_stack() still returns
PRIV_STACK_ADAPTIVE.

Even with libbpf updated in the follow-up commit to pass BPF_TRACE_UPROBE,
__perf_event_set_bpf_prog() still permits attaching a BPF_PROG_TYPE_KPROBE
program with expected_attach_type =3D=3D 0 and prog->aux->jits_use_priv_sta=
ck
set to a uprobe perf event. If one task executing the uprobe on a CPU is
preempted or sleeps on a page fault and another task on the same CPU hits t=
he
same uprobe, both tasks will share prog->aux->priv_stack_ptr and overwrite
each other's stack frames.

Should bpf_enable_priv_stack() also check prog->sleepable and
prog->aux->kprobe_write_ctx, and should __perf_event_set_bpf_prog() reject
attaching a program with prog->aux->jits_use_priv_stack to a uprobe perf
event?

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 457d75ea71420..016d479467edc 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11835,6 +11835,9 @@ static int __perf_event_set_bpf_prog(struct perf_=
event *event,
>  	    (is_syscall_tp && prog->type !=3D BPF_PROG_TYPE_TRACEPOINT))
>  		return -EINVAL;
> =20
> +	if (prog->expected_attach_type =3D=3D BPF_TRACE_UPROBE && !is_uprobe)
> +		return -EINVAL;
> +
>  	if (prog->type =3D=3D BPF_PROG_TYPE_KPROBE && prog->sleepable && !is_up=
robe)
>  		/* only uprobe programs are allowed to be sleepable */
>  		return -EINVAL;

[Severity: Medium]
What happens if a non-kprobe program is loaded with BPF_TRACE_UPROBE, or if=
 a
kprobe program with BPF_TRACE_UPROBE is attached via BPF_LINK_CREATE with a
mismatched attach_type?

In kernel/bpf/syscall.c, bpf_prog_load_check_attach() does not restrict
BPF_TRACE_UPROBE to BPF_PROG_TYPE_KPROBE. If a BPF_PROG_TYPE_PERF_EVENT
program is loaded with expected_attach_type =3D=3D BPF_TRACE_UPROBE and att=
ached
to a non-tracing perf event, __perf_event_set_bpf_prog() returns early befo=
re
reaching the new check:

kernel/events/core.c:__perf_event_set_bpf_prog() {
	if (event->state <=3D PERF_EVENT_STATE_REVOKED)
		return -ENODEV;

	if (!perf_event_is_tracing(event))
		return perf_event_set_bpf_handler(event, prog, bpf_cookie);
	...
	if (prog->expected_attach_type =3D=3D BPF_TRACE_UPROBE && !is_uprobe)
		return -EINVAL;
}

Additionally, in kernel/bpf/syscall.c, bpf_prog_attach_check_attach_type()
validates BPF_TRACE_KPROBE_MULTI, BPF_TRACE_KPROBE_SESSION,
BPF_TRACE_UPROBE_MULTI, and BPF_TRACE_UPROBE_SESSION under
BPF_PROG_TYPE_KPROBE, but does not check that prog->expected_attach_type =
=3D=3D
BPF_TRACE_UPROBE requires attach_type =3D=3D BPF_PERF_EVENT:

kernel/bpf/syscall.c:bpf_prog_attach_check_attach_type() {
	...
	case BPF_PROG_TYPE_KPROBE:
		if (prog->expected_attach_type =3D=3D BPF_TRACE_KPROBE_MULTI &&
		    attach_type !=3D BPF_TRACE_KPROBE_MULTI)
			return -EINVAL;
		if (prog->expected_attach_type =3D=3D BPF_TRACE_KPROBE_SESSION &&
		    attach_type !=3D BPF_TRACE_KPROBE_SESSION)
			return -EINVAL;
		if (prog->expected_attach_type =3D=3D BPF_TRACE_UPROBE_MULTI &&
		    attach_type !=3D BPF_TRACE_UPROBE_MULTI)
			return -EINVAL;
		if (prog->expected_attach_type =3D=3D BPF_TRACE_UPROBE_SESSION &&
		    attach_type !=3D BPF_TRACE_UPROBE_SESSION)
			return -EINVAL;
}

If a BPF_PROG_TYPE_KPROBE program with expected_attach_type =3D=3D
BPF_TRACE_UPROBE is passed to link_create() with attach_type set to
BPF_TRACE_KPROBE_MULTI or BPF_TRACE_UPROBE_MULTI, it bypasses
bpf_prog_attach_check_attach_type() and returns -EOPNOTSUPP instead of
-EINVAL when CONFIG_FPROBE or CONFIG_UPROBES is disabled or on 32-bit
architectures.

Should bpf_prog_load_check_attach() and bpf_prog_attach_check_attach_type()
also validate BPF_TRACE_UPROBE?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103093400.1121=
78-1-jolsa@kernel.org?part=3D2
