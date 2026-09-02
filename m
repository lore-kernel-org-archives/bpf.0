Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4024A5EA2
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362307; cv=none; b=Qc9T2i89hWAVau1JxjufT76B6hcYHivJJhSb+tbmbxqAv8+pMOxvkIfT6s8kWs9B3DrhwXYjyaKljwBu7Fiu1ScjCqbCR83BlMKxZO3tgRD6+MUoA1RVemrY4c61Jw8r4+o9QdeOG6PiLbM1eT+jDcYSlKgJ7uNaL88QZmeqZQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362307; c=relaxed/simple;
	bh=bSPrHn67O0OwTMUGnw4PtrISNSHgyUD9GElqOdDKFVU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A4M1FAGxFU+YScwZQFsgjHRpqSoj92oZfx3F2Q9OODLCarot0hloO4Z/K9LwIgPQmrmObZzV8tqtGAxhMjuZaqQljmHv6cReg297vnubsdD4KgmOxkVpq/yC2oB42eWwDUP0bbmGb4GpltNs3spCip1OvOBHLbjEWjpaczG6p6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPoiLSEH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPoiLSEH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE851F000E9;
	Wed,  2 Sep 2026 15:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788362305;
	bh=VaMfaywJSm7NkTirTftE0RnTZLDwL+xy2XJms+ga15w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JPoiLSEHbPAPl1G/PtwP9a2rWHU5Kg7HGnCZhmfyqm5lkbzWnyVeNy3eewxUbIuiW
	 yiBGraScXBdkUz3Md/TXXlDYDazdLv7pLbl4JM2tS/pt/+Q/jmqNgTNdMr66WVcQVK
	 z3mQDF9eiOIFnYoJ3XjU5DYNLE0U121m0TqZxkkfcGTJPRzSAYUqRQ36ghAVvUt1iZ
	 qIBbDsLTXuKCoM1+N/Mtxl4pSYVVJy/0a2ZjDXiHVB5dFH0G2JQBZwePexf3+Y5Rc7
	 7hI0XyoFZpFGTzduBhmf7ZhAMmeWzioHt+hOL1IJP+0NxalpF+u7vgItGGIIvaRVYO
	 qugTPXIR0T0DA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test bpf_send_signal_task()
 from kernel thread context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Sharma" <adi.sharma@zohomail.in>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260902150439.692725-2-adi.sharma@zohomail.in>
References: <20260902150439.692725-1-adi.sharma@zohomail.in>
 <20260902150439.692725-2-adi.sharma@zohomail.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 15:18:24 +0000
Message-Id: <20260902151824.EEE851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The newly added `send_signal_kworker` program silently runs duri=
ng existing remote tests, sending the signal instead of the intended progra=
ms (like perf or NMI) and invalidating their test coverage.
- [Low] Multi-line comments do not follow the BPF subsystem style guideline=
s.
--

commit 2bcfd3bbad998237f70d4a407001c43f11ecd4c9
Author: Aditya Sharma <adi.sharma@zohomail.in>
selftests/bpf: Test bpf_send_signal_task() from kernel thread context

This commit adds a new test to verify bpf_send_signal_task() from a kernel
thread context. It attaches a BPF program to a workqueue tracepoint to
ensure signals can be properly sent when the caller is a kworker.

> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools=
/testing/selftests/bpf/prog_tests/send_signal.c
> index 7ac4d5a488aa5..f9dd23db1ef98 100644
> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
[ ... ]
> +	if (pid =3D=3D 0) {
> +		/* install signal handler and notify parent */
> +		sa.sa_sigaction =3D sigusr1_siginfo_handler;
> +		sa.sa_flags =3D SA_RESTART | SA_SIGINFO;
> +		ASSERT_NEQ(sigaction(SIGUSR1, &sa, NULL), -1, "sigaction");
> +
> +		close(pipe_c2p[0]); /* close read */
> +		close(pipe_p2c[1]); /* close write */
> +
> +		/* notify parent signal handler is installed */
> +		ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
> +
> +		/* make sure parent enabled bpf program to send_signal */
> +		ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
> +
> +		/* the signal is sent from workqueue context, so nothing has
> +		 * to be triggered from here
> +		 */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the BPF subsystem
style guidelines? The BPF subsystem mandates that multi-line comments must
have the opening /* on its own line.

> +		while (!sigusr1_received)
> +			sleep(1);
> +
> +		buf[0] =3D sigusr1_received;
> +
> +		ASSERT_EQ(sigusr1_received, 8, "sigusr1_received");
> +		ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c b/=
tools/testing/selftests/bpf/progs/test_send_signal_kern.c
> index 176a355e30624..d1c000c308857 100644
> --- a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
[ ... ]
> @@ -60,6 +60,32 @@ int send_signal_tp_sched(void *ctx)
>  	return bpf_send_signal_test(ctx);
>  }
> =20
> +/* Send a signal to a task other than current, from a context where curr=
ent
> + * is a kernel thread. No filtering on current is possible here, so this=
 is
> + * driven entirely by target_pid.
> + */

[Severity: Low]
This isn't a bug, but similar to the comment in send_signal.c, should the
opening /* be on its own line here as well to match the BPF style
guidelines?

> +SEC("tp_btf/workqueue_execute_start")
> +int send_signal_kworker(void *ctx)
> +{
> +	struct task_struct *target_task;
> +	int ret;
> +
> +	if (status !=3D 0 || target_pid =3D=3D 0)
> +		return 0;

[Severity: Medium]
Could this condition cause the kworker program to silently run during other
remote tests and invalidate their test coverage?

During existing remote tests, both the pid and target_pid global variables
are set to non-zero values. Because this program is auto-attached by
test_send_signal_kern__attach() and only checks target_pid =3D=3D 0, it app=
ears
it will run and send the signal when background workqueue events occur
during those other tests.

If this program delivers the signal and sets status =3D 1, it could preempt
the intended test programs (like send_signal_tp or send_signal_perf),
causing the remote tests to spuriously pass without actually exercising
their specific BPF programs.

Would it make sense to also verify pid =3D=3D 0 here to guarantee this prog=
ram
remains inert when the other tests are running?

> +
> +	target_task =3D bpf_task_from_pid(target_pid);
> +	if (!target_task)
> +		return 0;
> +
> +	ret =3D bpf_send_signal_task(target_task, sig, PIDTYPE_TGID, 8);
> +	bpf_task_release(target_task);
> +
> +	if (ret =3D=3D 0)
> +		status =3D 1;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902150439.6927=
25-1-adi.sharma@zohomail.in?part=3D2
