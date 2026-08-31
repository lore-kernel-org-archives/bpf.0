Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25953DDB1D;
	Mon, 31 Aug 2026 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169240; cv=none; b=qwblOjDL0RXT8G9ZVv/RSn049eG8kIez+sBHc16sKZIbHOJDqLs9zuIduJ52zmAETj2WUKzGcGFHh1j5wSzfBFZM/W5TSgL/TgG4YTAVMjKG6gNMmQfBXecrXnhktchlTxAcO45hMs0iC83Gv4eeYkjTQvbWCZjJ8y8kWVOkInw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169240; c=relaxed/simple;
	bh=PP6J6gEXfB2zgSpUiOtpgtkCxYNTusLi+Z0X9f4YtEU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tkMw/vQOTk9SEezIR0w33hKH8OC52kredNrwW5fbPK3DQGM/ntYLyN1/qsNtTDpsvs9orRWj3yO9yVX6TwCVP6N19WoQfzCE6N/7Dw5PDUlDf+WNu7inkfeT3kyBWyzkefpIFvto7FeI7kgONMNKlkW/SpNCiTk55Ek2/4k2mz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLmq6C/1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLmq6C/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EA01F000E9;
	Mon, 31 Aug 2026 09:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788169238;
	bh=Jxm2dIqV+KcoPcQhXodbPQjhG7Cs37TXWNsTjgEA7wU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NLmq6C/1fiFOo6lt4fwv/Ny0ao+vySVPWQ8GYO0PSmpEYmfaLAdd1+hts+uN2R1Jr
	 V5AXvt06VC2utGWuKdDQnAGTLr/6iLxEs5eMj4haWUbN7klzTxwCjMGb3cQ82mqTmf
	 Q/k0aqO/dUUllL0MpB4/0r5d2zPQ+UaAbyium2wbqYQXkRw6F7uCIWGf/H/bNHnlTb
	 2TSI8aBZD8Pm21CVGlRbkU/2UrjrZhNFVsXehDNwQIYgnmsXuCuI0zIyMPsQ8qKNP8
	 /KQ5DFrC/rTzoVvHAkrgCardWG3rW3Pzi1rvJj5//s+3hh2zGVb3I2toa2Mcai6fjz
	 qz6h325zczsQA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 16/20] tools/rv: Add BPF monitors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260831090524.106845-17-gmonaco@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
 <20260831090524.106845-17-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:40:38 +0000
Message-Id: <20260831094038.71EA01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tqueue monitor causes false positive invalid state transitions f=
or tasks scheduling during do_exit().
--

commit 22065a19b365cd05306cad5f1def6f25a73bdc87
Author: Gabriele Monaco <gmonaco@redhat.com>

tools/rv: Add BPF monitors

This commit adds the code for 2 initial BPF monitors, both DA (the only
currently supported type): queue and nohz. It also integrates BPF monitor
building into the main rv Makefile.

> diff --git a/tools/verification/rv/bpf_monitors/tqueue.c b/tools/verifica=
tion/rv/bpf_monitors/tqueue.c
> new file mode 100644
> index 0000000000000..c7516da01b65c
> --- /dev/null
> +++ b/tools/verification/rv/bpf_monitors/tqueue.c
> @@ -0,0 +1,35 @@

[ ... ]

> +SEC("tp_btf/sched_dequeue_tp")
> +int BPF_PROG(handle_sched_dequeue, struct task_struct *tsk, int cpu)
> +{
> +	if (!(tsk->flags & PF_EXITING))
> +		da_handle_start_event(tsk, sched_dequeue_tqueue);

[Severity: Medium]
Does skipping the dequeue event for exiting tasks here cause false positive
state transitions when the task is later enqueued?

If a task calls do_exit() (which sets PF_EXITING) and is preempted or sleeps
before reaching trace_sched_process_exit(), this logic skips the
sched_dequeue event. The state machine then incorrectly remains in the
"enqueued" state.

> +	return 0;
> +}
> +
> +SEC("tp_btf/sched_enqueue_tp")
> +int BPF_PROG(handle_sched_enqueue, struct task_struct *tsk, int cpu)
> +{
> +	da_handle_event(tsk, sched_enqueue_tqueue);

[Severity: Medium]
When the exiting task is rescheduled, handle_sched_enqueue() unconditionally
processes the sched_enqueue event.

Since the corresponding dequeue event was skipped above, won't this un-pair=
ed
enqueue cause the monitor to transition to an invalid state, breaking the
intended functionality and flooding the trace logs with false positive
violations?

> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831090524.1068=
45-1-gmonaco@redhat.com?part=3D16
