Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984539;
	b=s+NUy3o48j3I9ItIV28107JjiQgvmKTktbAWroKGGgjvkI+E2uqpd9wKvxcV+A/+l4fH
	 F76MtUbtSWyE5azPH2P32SGn2ykfJYWpfZWG6JpJNfFjpj1icyM6LxVyVF63GFvYIimSN
	 yrTsDgnY/waa9HOlWodF/DtbdbgLyGwFIbk97VdDIFQfuQkompDectE2IejkgnCRpKGvw
	 CkZ60do4pEJabUT5oLvV/fU1kNZC1oSn1uDAPjB0BuZoIGwbC/mihtc+TldiIalPefNnX
	 C5ZXnPNQLV7pCLE5/PjeCWAnv/BkrcvJ/6CRvvVNtIRlKRP5PmQautV/xQcaDzAoc3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984539;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1c5RaHxSR1+JRBoLdaVPuvnvZFGDTqZ8hLTNAO18cDE=;
	b=Ya1V+eOHSr8lzEa2kVwJ5PgDU7710NFt/QXTfLIo4pOTa2ANyef3nSRn0XOhaYyINrfF
	 F6FhwIHUY2xhMZWHP0SfwYbrOyojxWwrslSwsmosHkNLRStZjawR27YASefss6ScKHIiS
	 di9OlnBcpdt2Jc29Mlow1MNMymgz+MHouzJpMDQbw2bIXTDqFrwClPlE69RFiEXcr5HqH
	 uecN1WCBSOlfDopR1qEnVIYO9tD9NfLej0AwBymAdfNMpfCKo9YkrXuK/FHqKZtCa9yM3
	 ZhB9w0Qq4eRGFhPM2eHKx5yfJOzczk0T9+WV6gGVd0ySf/hOFmiEY1lTsOBA+EjvyMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FlzgajHV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4287E606A329
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FlzgajHV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4801F0089F;
	Fri,  6 Nov 2026 17:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793984539;
	bh=1c5RaHxSR1+JRBoLdaVPuvnvZFGDTqZ8hLTNAO18cDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FlzgajHVgAIia2Iw5xNKt4QNe1gpFc5oGTqZKMl0FW0rA1tvh/mQ5l6YevhJOfZJV
	 0lOKGRjLsB9ZD7V/v0VScxVgTo2N2lQixe166oY5R5gKsN/hxzbV1l41fHGv63jFdf
	 ChXQyiLpGE1FdeC/loyJpoD4ZM1OqZ9NHUmamY2TP4noW6s4pLjl5ox57OwRMajan8
	 chxxH8GVE7Sud8rVsMUxhQVvt/Fn4WsNMIAxrs/DpQGdBaSMJwQmGt/Geoeu+eljks
	 nklXfEdc0zlnBUz+S7t9XWsy5Aixamap+Y/591LEvEXkmAdL17VZZD2beEyimQmIoL
	 RlK7y97K8rDSg==
Message-ID: <sashiko-outbox-201889@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 bpf-next 2/2] bpf: Disable private stacks for untagged
 kprobe programs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261106164043.546879-3-jolsa@kernel.org>
References: <20261106164043.546879-1-jolsa@kernel.org>
 <20261106164043.546879-3-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:02:18 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] bpf: bpf_enable_priv_stack() allows private stack on uprobe
  via IOC_SET_BPF
- [Low] bpf: missing Fixes trailer for commit a76ab5731e32 in commit
  message
--

commit f0768285bc0b64d913853bd20bc1d61e4c54eed4
Author: Jiri Olsa <jolsa@kernel.org>

> bpf: Disable private stacks for untagged kprobe programs
>
> Uprobe programs can be preempted and re-entered on the same CPU. Since
> the private stack is shared per program and CPU, another invocation can
> overwrite the preempted invocation's stack.
>
> Programs without a multi or session attach type may be standard kprobes
> or uprobes. Disable private stacks for them, and retain private stacks
> only for kprobe multi and session programs, which have attach types that
> identify them as kprobes.
>
> Update verifier tests that rely on private stacks to use kprobe.multi,
> and add coverage that untagged kprobe and uprobe programs do not use
> private stacks.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

[Severity: Low]
Should this commit include a Fixes tag for a76ab5731e32 ("bpf: Find
eligible subprogs for private stack support")?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b7329d164771c..1b58a1796a2e4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5749,6 +5749,15 @@ static enum priv_stack_mode bpf_enable_priv_stack(=
struct bpf_prog *prog)
>  	 */
>  	switch (prog->type) {
>  	case BPF_PROG_TYPE_KPROBE:
> +		/*
> +		 * Uprobes are preemptible and lack recursion protection. Classic
> +		 * kprobe and uprobe progs have no expected attach type, so enable
> +		 * private stacks only for kprobe.multi and kprobe.session progs.
> +		 */
> +		if (prog->expected_attach_type !=3D BPF_TRACE_KPROBE_MULTI &&
> +		    prog->expected_attach_type !=3D BPF_TRACE_KPROBE_SESSION)
> +			return NO_PRIV_STACK;

[Severity: Medium]
Can a BPF_PROG_TYPE_KPROBE program with a private stack still be attached
to a classic uprobe through PERF_EVENT_IOC_SET_BPF?

At load time, bpf_prog_load_check_attach() accepts BPF_TRACE_KPROBE_MULTI
or BPF_TRACE_KPROBE_SESSION on any BPF_PROG_TYPE_KPROBE program (including
sleepable ones, since can_be_sleepable() only checks prog->type =3D=3D
BPF_PROG_TYPE_KPROBE).  While BPF_LINK_CREATE checks expected_attach_type
via bpf_prog_attach_check_attach_type(), attaching via
ioctl(perf_event_fd, PERF_EVENT_IOC_SET_BPF, prog_fd) ->
__perf_event_set_bpf_prog() only checks prog->type:

kernel/events/core.c:__perf_event_set_bpf_prog() {
    ...
	if (((is_kprobe || is_uprobe) && prog->type !=3D BPF_PROG_TYPE_KPROBE) ||
	    (is_tracepoint && prog->type !=3D BPF_PROG_TYPE_TRACEPOINT) ||
	    (is_syscall_tp && prog->type !=3D BPF_PROG_TYPE_TRACEPOINT))
		return -EINVAL;
    ...
}

A BPF_PROG_TYPE_KPROBE program loaded with BPF_TRACE_KPROBE_MULTI or
BPF_TRACE_KPROBE_SESSION therefore still gets a per-CPU private stack and
can be attached to a uprobe perf_event, where __uprobe_perf_func() ->
bpf_prog_run_array_uprobe() runs it in preemptible (and optionally
sleepable) context without recursion protection, allowing preemption and
re-entry on the same CPU to overwrite the active invocation's private
stack.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106164043.5468=
79-3-jolsa@kernel.org?part=3D1
