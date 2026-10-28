Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181597;
	b=aWL2VimvF5pL8sbGumk1ApEkqgc0n1VdfzfG1ER8mxam+AKMraEWCbdSduAKf6x14FmB
	 axCMGrNm3K8LJYKal1WzP474/rmgZY+ItL04oQRpgXd5qgdVfDay53pTDPA3Dy4HW5xU2
	 O8Krs33v6L7F3H4MN2asydpuOn7GByee22PYb3jtqDpegCiuXO9So8/PB0luvcr9TAhBC
	 s+KEvR2NExdbstNgL0ZP1/uiehi7cs9kW/nu2A+wUZjPPnAk/udAl5DluRDT6sXvALguc
	 uA6ioOKW7df7U9lkxwsYK6gzKlnklQRdvQJ2aqkkzQkfLUdQusqxDca35eiZ8zvTJaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181597;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4PURH1B9VR3wyETq8zfkWcWy50ocxSt1URto7TUlM3I=;
	b=JADtadlMpBQ2AeSv8LvXMquSfzYTSu3Q3qYsyYVETzRGItU5Pcs/judJqK+KZ3PA6OId
	 a/Fj2TUxG8gjZ0xAjAVkKZ9bUt/W/Wp4KD7tzzZPz8gddD9fUgQOJBkbqejaHHiVOwifx
	 F5bHSwcl02VmJQeILLCBnH49TnC5JexT3hBmcsduUArL0PJoXjczJHRw5cEMecKFLs2Mg
	 U5Bqxt57rxO/cncuj4oZxw/hpd4k/RbDKTlHa0XTI5NwYe6NFZTCfE+mKPCV3uaslbFvD
	 rpMxHfR14LSXdzalxZYoLus19Y6ohKWUhjdMD6K0muqTmAGzz5sZ4lhdAi2taQHCX0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dNA9WxE/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B950606A325;
	Wed, 28 Oct 2026 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNA9WxE/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4341F031E1;
	Wed, 28 Oct 2026 09:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793181597;
	bh=4PURH1B9VR3wyETq8zfkWcWy50ocxSt1URto7TUlM3I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dNA9WxE/kF5eFTFnG3rWHmpMzFJ+DcQkW6R/ctVAGiyfv+ZqyFcF0s3RTP26ioG3w
	 JqcDqa8In0oBCpeaXqXH9/ecF3FAc++QoheKNavEQDI8Eb82PMKBwpM4yZy36vkioo
	 Ibahi818Y5SvJIi0ezXNj/QsUNQoEDiZmjvuYUbazz7UVhQhYxVWvclCFXNfQDjVIb
	 SvR7VNvU71h/se91+VLo1OUAaTnAmL2u/kMhdzv+57PW+cGxvmch8LhraoZ31w7c/R
	 EkTSVnULmKNtYjOlarohYtRzYhkCPo+JG0jNaaalpF8u30xaQIsXMEHkHy14IDYdt4
	 Kt/0O/O9RI7PQ==
Message-ID: <sashiko-outbox-187711@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf: Fix suspicious RCU usage for sleepable
 bpf_get_stack()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng Yang" <yangfeng59949@163.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261028093548.790977-1-yangfeng59949@163.com>
References: <20261028093548.790977-1-yangfeng59949@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 09:59:56 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: per-CPU bpf_raw_tp_regs corruption in bpf_get_stack_raw_tp_sl=
eepable()
--

commit c66538ad7075b69839a1969f72a7ea7eff53e112
Author: Feng Yang <yangfeng@kylinos.cn>

bpf: Fix suspicious RCU usage for sleepable bpf_get_stack()

This patch routes sleepable tracepoint and raw tracepoint/tracing BPF
programs calling bpf_get_stack() to bpf_get_stack_sleepable() so that
classic RCU read lock is held when accessing callchain entries and the
helper is marked might_sleep.

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 14adfb85fdb2b..7887d1c00be83 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
[ ... ]
> @@ -1705,6 +1727,33 @@ static const struct bpf_func_proto bpf_get_stack_p=
roto_raw_tp =3D {
>  	.arg4_type	=3D ARG_ANYTHING,
>  };
> =20
> +BPF_CALL_4(bpf_get_stack_raw_tp_sleepable, struct bpf_raw_tracepoint_arg=
s *, args,
> +	   void *, buf, u32, size, u64, flags)
> +{
> +	struct pt_regs *regs =3D get_bpf_raw_tp_regs();
> +	int ret;
> +
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	perf_fetch_caller_regs(regs);
> +	ret =3D bpf_get_stack_sleepable((unsigned long) regs, (unsigned long) b=
uf,
> +				      (unsigned long) size, flags, 0);
> +	put_bpf_raw_tp_regs();
> +	return ret;
> +}

[Severity: High]
Can holding the per-CPU bpf_raw_tp_regs slot across bpf_get_stack_sleepable=
()
corrupt active register state or exhaust the per-CPU slots on the local CPU?

In kernel/trace/bpf_trace.c, get_bpf_raw_tp_regs() and put_bpf_raw_tp_regs()
manage a 3-slot per-CPU array indexed as a LIFO stack via
bpf_raw_tp_nest_level:

    static struct pt_regs *get_bpf_raw_tp_regs(void)
    {
        struct bpf_raw_tp_regs *tp_regs =3D this_cpu_ptr(&bpf_raw_tp_regs);
        int nest_level =3D this_cpu_inc_return(bpf_raw_tp_nest_level);

        if (nest_level > ARRAY_SIZE(tp_regs->regs)) {
            this_cpu_dec(bpf_raw_tp_nest_level);
            return ERR_PTR(-EBUSY);
        }

        return &tp_regs->regs[nest_level - 1];
    }

    static void put_bpf_raw_tp_regs(void)
    {
        this_cpu_dec(bpf_raw_tp_nest_level);
    }

Sleepable BPF programs using raw_tp_prog_func_proto() or
tracing_prog_func_proto() run under rcu_read_lock_trace() and
migrate_disable() with preemption enabled. When such a program calls
bpf_get_stack_raw_tp_sleepable() with BPF_F_USER_STACK | BPF_F_USER_BUILD_I=
D,
bpf_get_stack_sleepable() -> __bpf_get_stack() only disables preemption aro=
und
get_perf_callchain() and callchain_store(), and then re-enables preemption
before calling callchain_finalize():

    /* trace should not be dereferenced after this point */
    if (may_fault)
        rcu_read_unlock();
    preempt_enable();

    return callchain_finalize(buf, size, trace_nr, elem_size, flags, may_fa=
ult);

Inside callchain_finalize() -> stack_map_get_build_id_offset_sleepable() ->
build_id_parse_file(), the task can sleep on page faults or filesystem reads
while still holding the per-CPU bpf_raw_tp_regs slot.

If task A on a CPU acquires regs[0] (nest_level becomes 1) and sleeps or is
preempted inside callchain_finalize(), task B on the same CPU can call
get_bpf_raw_tp_regs(), acquire regs[1] (nest_level becomes 2), populate
regs[1] via perf_fetch_caller_regs(), and get preempted before
__bpf_get_stack() disables preemption. If task A then wakes up on the same
CPU and calls put_bpf_raw_tp_regs(), bpf_raw_tp_nest_level is decremented
from 2 to 1 while task B is still about to use regs[1]. Any subsequent call=
er
on that CPU (another task, or an IRQ/NMI raw tracepoint program calling
bpf_get_stack_raw_tp(), bpf_get_stackid_raw_tp(), or
bpf_perf_event_output_raw_tp()) will increment bpf_raw_tp_nest_level back to
2, receive the same &tp_regs->regs[1] pointer, and overwrite task B's saved
registers before task B runs get_perf_callchain().

In addition, if three sleepable tasks on the same CPU block concurrently in
build_id_parse_file(), bpf_raw_tp_nest_level stays at 3 for the duration of
the I/O, causing all get_bpf_raw_tp_regs() calls on that CPU across task,
IRQ, and NMI contexts to fail with -EBUSY.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028093548.7909=
77-1-yangfeng59949@163.com?part=3D1
