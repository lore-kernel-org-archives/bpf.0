Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CC83E1203;
	Thu,  1 Oct 2026 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870151; cv=none; b=ualGFfEsFFtuUPImlZBwE0Mau5Sv0/r7KZkNTSua7cQULuTSSnlk18TeZ95jEKYymAXES28LojHyIu8+wtTr0pkUS+dHf8C4p4P5iPcS3Zszq05aBsboM7hd9d8+5DKCkufLADnCQkT7mvKop8qF+6V0P6cB+OmQIl+MKm/7aI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870151; c=relaxed/simple;
	bh=YL07/6AWFXwX37lPPO7txX/9zUpCBn9ZdZE9rC4njFo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N6cS97zhPzzYvGGwlUUCsDqoBKM1GlSGmwl56uXFTDt44Jq8AvOX/3jn6YLWoCgeiwUxSwb2STkY1P/xagFR6FO53o40asiCX1imxMWRhirbSXe76oGEswwpR/eN0fI4MXjBPnftFJev+d1PZdnBzXRo/JMgbVEz+Xlr5JmlFcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+mBWaNe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+mBWaNe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B081F000FF;
	Thu,  1 Oct 2026 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790870140;
	bh=1FwEbjPmHrR5dhbECq09PtTRVvJfrQ8mrwH4+kDYIKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T+mBWaNeFs5qgLm4IV2h74CVuidcobEtinV4wOE1cnjrlQtlVOcbBkTbXrxybRMGq
	 EsIJ48GX9eUEtkNSsW4hsRGfSX5nIysLCazgP2xXsits00DMubTUjm7hSU8sswwd7i
	 be3eknw90JJfW7MLuMrbmucxH3PWzEMtwVQbNsti6dUIgkcyi7smASgL/cuqkxQ018
	 nwWWl9QsXv1qOpIX1crETiUwQ5dbvGfkQQYUzWXNHB6L5cOomOrfeHrx/U6H9TQCtb
	 aDn5uy2sf11I7rWTSqiyp/uTp6gufWBtFm6s7sGQ7wzI/k5zV7OyS/kGH659uhLF84
	 uNkCnVAoEz8VA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261001152042.124445-11-gmonaco@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
 <20261001152042.124445-11-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 15:55:40 +0000
Message-Id: <20261001155540.A4B081F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: PER_TASK map leak via premature sched_process_exit cleanup
--

commit 9e1db08be07757261ff0e098cd3dda05c445d860
Author: Gabriele Monaco <gmonaco@redhat.com>

tools/rv: Add BPF monitors

This commit adds the code for two initial BPF monitors (queue and nohz) and
adapts the in-kernel da_monitor.h to share code and conditionally compile B=
PF
or kernel-specific components. It also integrates BPF monitor building into
the main rv Makefile.

> diff --git a/tools/verification/rv/bpf_monitors/da_monitor_bpf.h b/tools/=
verification/rv/bpf_monitors/da_monitor_bpf.h
> new file mode 100644
> index 0000000000000..12f0f78b9c9d3
> --- /dev/null
> +++ b/tools/verification/rv/bpf_monitors/da_monitor_bpf.h
[ ... ]
> +#if RV_MON_TYPE =3D=3D RV_MON_PER_TASK
> +/*
> + * BPF Per-Task monitor - uses BPF hash map indexed by PID
> + *
> + * Just a special case of per-object monitor with API consistent with in=
-kernel
> + * monitors (no need to pass the id).
> + */
> +
> +#define da_get_monitor(tsk) da_get_monitor_bpf(BPF_CORE_READ(tsk, pid), =
tsk)
> +#define da_handle_event(tsk, event) \
> +	da_handle_event_bpf(BPF_CORE_READ(tsk, pid), tsk, event)
> +#define da_handle_start_event(tsk, event) \
> +	da_handle_start_event_bpf(BPF_CORE_READ(tsk, pid), tsk, event)
> +#define da_handle_start_run_event(tsk, event) \
> +	da_handle_start_run_event_bpf(BPF_CORE_READ(tsk, pid), tsk, event)
> +
> +typedef struct task_struct *monitor_target_bpf;
> +static inline void da_destroy_storage(da_id_type id);
> +
> +SEC("tp_btf/sched_process_exit")
> +int BPF_PROG(handle_obj_cleanup, struct task_struct *p, bool group_dead)
> +{
> +	da_destroy_storage(p->pid);
> +	return 0;
> +}

[Severity: Medium]
Could this lead to a map leak if trace events occur during task teardown af=
ter
sched_process_exit?

If an active PER_TASK monitor traces an event that occurs in do_exit() after
sched_process_exit has already executed (for example, sched_dequeue, page
faults, or other events in exit_mm() or schedule()), the event handler will
call da_handle_start_event_bpf(). This function recreates the map element v=
ia
da_create_storage().

Since handle_obj_cleanup has already run for this task, the newly recreated
map element will never be deleted. Over time, this could exhaust the BPF ma=
p,
and a future task reusing the same PID could inherit this stale automaton
state.

Would it be safer to attach this cleanup routine to sched_process_free
instead, ensuring the storage is only destroyed when the task struct is
actually being freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001152042.1244=
45-1-gmonaco@redhat.com?part=3D10
