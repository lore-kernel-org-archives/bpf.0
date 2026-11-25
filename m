Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795572019;
	b=WA6dXy2FqpH8zxWUG/oS/VjKikwMXpDxTqdzCkqWz7vufR2WBusV1MdmVt/bFl0Cmx2j
	 cZXvdxjaYPez//IpzsKOxWt8psBSz8TmxchIVcnj5iLgFR1+jd5KqxmmITW3RT65zbLB2
	 BiYWuiLEGu8Uhwj0o3eyOwn9Mf4d0GjyZI9pNlnlLQMYLaHli7dGhO1jFVzRWb/HONy3p
	 65pDUmZMbUj5w3EMRT2dbuPP7JEgH9RZiOEk7twyZDpZBwiTxRuUEaahQRfnsuiPrvTno
	 I8szAEfVN9E+xBVCQg911XH8qQOpryqDY5c5DrljHaspOB4kxOd8t/54xN0qOpsDWRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795572019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=sE8wc6dsgEssNyddWthFZ+lEoCwD6PVFc+K8Q81j6aQ=;
	b=jK+KpdpgKO14TSeidSfLk9ZNllGh+f9tTpBEmyKRZEx7KsZk4F43LQyB/vUTo9cJX0Gi
	 9mKkCKh3IsYs6ZxYIbADuH1Mfb+tgKt+4NVYUKNTuQhFsGMGk/Bapb9MmZfqxr5G6M7tg
	 ZVbWJV1y1RXB6qW/+Xp1NKS9bb73xJF11DssbQhnhc40Wsgzr2LFRmqtJgJ5nzopolXG4
	 yWZr36RJTmZtiDH4k+vQJeCPvymBXOv+lT1gm6JklF0WPIUWQG9ZQb0r3c4X58/48JSae
	 O+y40jErVI6CA/ELLinTTuGR5UVD5eLlPjrSqtCORbOXee/+2e9UB6b8GN0GEsgMZiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iHP4bFsE;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FE1606A329
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 02:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16FE1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iHP4bFsE
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b2382bf051so2887094b3a.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 18:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795572017; x=1796176817; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sE8wc6dsgEssNyddWthFZ+lEoCwD6PVFc+K8Q81j6aQ=;
        b=iHP4bFsEwUspvyK0PiaGfnLAUGem8sQq2bVTWN9NqysK9HnRLqQKsQiZjlWIPlGRLF
         zykbBaw4m/HEEl6hQ0ZymO3VX0vi4ziAYxa7mAyhATJoTxmvI1fK7oMCKcQplyxQI4o2
         FEyiLzffxRsiDMsjaqrthTfWqdw7e1DxYr7Lr8rj5YAL2RSwaefynMBxHiuh82oV/sxw
         wQDUlv/S69AHhCRvBKRg56LcP113dwLZXbbY4vPoIM3WSGVqEAnpx/3+hu5fX4Qg7JYy
         Ssr8OV92BWkXpueqh3PAHJ7vhHeAwNxVrNj8tfZNv0CIwTdL9MS4CQHA1V5GZpjdkPMW
         BYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795572017; x=1796176817;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sE8wc6dsgEssNyddWthFZ+lEoCwD6PVFc+K8Q81j6aQ=;
        b=dB+XNIMJyPbBxx7ybwWyji0tgn/Z9BudMZdZ+NcVUruAzzKGeXoX6rCZpZ9CsO1Nkk
         UPYvJTaY4jMJnULLzViEbP0iEFLje0jzGaI+LwsdRyuZhhLYuEkWrSVHltllQ1JNKZaG
         fYnS/UbaElhLTRy/9/umXucmy9wC4XwQ/+6Agkh58Fa8beHF94m1cthq80YkNsp8QMP9
         JmJMmKFKnsThLygwQtq+C2Uw3TnGR1ioSHkmcJrz8cctdNPvVgSN83xoCCb0t3x70OYR
         SEP0Wf4lP1SXr2NY88O8Bpg70m5cHCDlRlcgMo3lYK9fn6T0HR3OaHA70fljGK6Nh6px
         zyEA==
X-Forwarded-Encrypted: i=1; AL+hErFDg1YUlegWvIl97lwcAIRt3ECh4Ded1setcVeL8QJYNoePkJtfD/BdT9NsJ/KTlCTx9Ik=@vger.kernel.org
X-Gm-Message-State: APuU4Z9C60S1/1pBOkhj5LBYCFYyV2f1ab1wbZ0QSfYAPD39DGA2wjNn
	88pnGt/iFN+dPlYiwZuohoeBtx5VsshoDZQna3NOJkd3HPeDz8SN/EUs
X-Gm-Gg: AZFdTZcJuPkJ+S/TSLoSAiq6tETK8SLfuxOABv8Zy0gR12NiFyyMNB4Zzbo5k5bQjj2
	XRptWaHpazIVAiLfeqItWCEE3dXwEp60GIk2QvkiFNO5xRvC/paBOq8njj0Zd1f91I/fh12kitR
	2FYO4q4nR4pmjaQA1ABGKKDEe+z26cjlihU5abOs9FB1mUtAJdHamvFk6QmaafrSMn5W1IwgkGA
	laosRAvSUJ02C9xgKfXDoJ0EiyvwFm/3yz387khiFmDNMDF1NaZLfvEnGzPPoDxQY/3Qp6HslfI
	FSbjbXo1rdChYBl1fzjgFnDX0lW7gxrLspkPV1W5k+JjkItorIUNRMojDSgveGsPM8cCU/fjQ8X
	EsMtKhVkZTrjUoGT69sDsCHi5+/LmlsxTMgT8XEo4nfTol0RJN0ZvyCyejUgtySWv+UH0DCKPOX
	7E2nO1R14uc3WR4c5Xj59nrK4EFV+nk5bV4XvzJ20USn056DiUiBffmKRs6nJlt/76VD5RgPaWz
	wiW7n1DfP1gUB7baGI6HdqMB42xlFDk0vn3Ji3TSQdf5DIXHVaY3HqpD0Bz5d2PkYlpgnrvZoIJ
	kZ4B4s4rATNhZqzZTzSkxRIpl7TCqC+iyVQDTNa9t+6J1LpsgDfYdoJzTaNVu16/v7bYjzYcviD
	rMvmZzVMtURk67yVwSS3/xn31/vwvqUDC2Z4=
X-Received: by 2002:a05:6a20:7345:b0:3e2:a412:4f1b with SMTP id adf61e73a8af0-4014bb52d9cmr17269124637.27.1795572016912;
        Tue, 24 Nov 2026 18:00:16 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c228sm7884391b3a.10.2026.11.24.18.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 18:00:16 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 02:00:15 +0000
Message-Id: <DN3X5OIRXSWR.2Y70DWFMPDXQF@gmail.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc: <mikeba@sentinelone.com>, <bpf@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "JP Kobryn"
 <jp.kobryn@linux.dev>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per task for
 preemptible programs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <CAEf4BzavErcSOZhGobqEo68d+2bCnJ8vFxxT_vqb+oQw1j1d7g@mail.gmail.com>
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com> <DN38312WXPDJ.2KLUTCWSDFL3P@gmail.com> <CAEf4BzavErcSOZhGobqEo68d+2bCnJ8vFxxT_vqb+oQw1j1d7g@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 24, 2026 at 01:47 PM Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>> +       for (ctx = old_ctx; ctx; ctx = ctx->saved_run_ctx) {
>
> do you mind checking if unlikely() around ctx improves performance?

Mike,
pls try it on respin.

> So basically to opt out from this behavior BPF program would need to
> stop using any per-CPU maps and just implement its own poor man's
> per-CPU storage?

poor mans's per-cpu with bpf_get_smp_processor_id() shouldn't work
as an opt-out. See section 6.

> And even using SEC(".percpu") would still be detected
> as per-CPU usage, right?

This one is pretty much brand new, so there is no data to make
a decision. I can see arguments both ways.

> Should we give a way to opt-out of this protection explicitly while
> still using per-CPU maps?

After looking at the data, I think we shouldn't allow it.

An opt-out is for a prog that protects its per-cpu data on its own.
In the v1 thread your example was stack_trace_scratch in wprof.
It doesn't work. wprof is broken today, without this series.
An event gets args or a stack of another task. wprof 8dd41e18 on
bpf-next, corrupt events / all events:

  -U                             what's wrong  lazy      full
  -----------------------------  ------------  --------  ---------
  u:func (arg:0, arg:1:str)      args          1928/16M  9111/17M
  u:func (..., stack)            stack         683/15M   3419/15M
  raw_tp:sys_enter (arg:id) and  args          3491/48M  16673/44M
  tp:syscalls:sys_enter_openat

utrace_scratch has no protection.
stack_trace_cur handles nesting, but not preemption:

  task A                task B                task C
  idx 0, st_cnt = 1
  preempted
                        idx 1, st_cnt = 2
                        preempted
  put, st_cnt = 1
                                              idx 1    <- slot of B

With -S offcpu task C is wprof_task_switch. Then the utrace event has
a record of kind ST_OFFCPU.
uprobes have no protection. That's what an opt-out gives to raw_tp, tp
and fentry progs:

  -U, lazy                 today     preempt off  opt-out
  -----------------------  --------  -----------  --------
  raw_tp only, args        0         0            2849/45M
  raw_tp only, stack       0         0            4081/27M
  raw_tp and tp, args      3491/48M  0            3166/54M

The series doesn't touch uprobes, so wprof needs its own fix for them.
The default mode of wprof, without -U, is fine.

Now the bigger question: do we need preempt_disable() at all?
We do. Without it progs of 17 out of 69 projects in [1] corrupt their
data. 12 of them have progs that are clean today.

Three kernels, bpf-next a58375b858fa plus patches 1-3:

  today        prog->active
  preempt off  walk + preempt_disable() for marked non-sleepable progs
  walk         walk only

Objects from [1] with small test loaders, 4 vCPUs, PREEMPT_RCU, 6-20 sec,
SCHED_OTHER tasks only. The load saturates the cpus. These are not
production rates.
The numbers are corrupt events / all events.

1. Clean today, corrupt with walk

The per-cpu buffer has one entry prog, so prog->active protects it.
"today" and "preempt off" have 0 corrupt events in each row.

  prog                            default  walk, lazy  walk, full
  ------------------------------  -------  ----------  ----------
  tetragon 1.8 event_execve       yes      25/172K     243/174K
  tetragon 1.8 tp on syscalls/*   policy   88/6.0M     478/6.8M
  tetragon 1.7 generic raw_tp     policy   40/290K     225/271K
  runtime-enforcer                yes      8/1.3M      252/1.0M
  pulsar sched_process_exec       yes      24/1.8M     188/1.5M
  kubescape fork                  yes      79/2.5M     475/2.7M
  coolbpf proctrace               yes      3/1.3M      398/1.4M
  inspektor-gadget finit_module   yes      5/38K       3/38K
  ptcpdump mount                  option   36/9.3M     101/8.9M
  wprof -U raw_tp only, args      option   2849/45M    16140/44M
  wprof -U raw_tp only, stack     option   4081/27M    20194/26M

  prog                       what breaks
  -------------------------  ------------------------------------------
  tetragon event_execve      pid, uid, argv of another task.
                             execve_map keeps the wrong pid.
  tetragon tp on syscalls/*  the signal goes to a task that doesn't
                             match the policy. Sigkill is the same code.
  runtime-enforcer           fmod_ret returns -EPERM for an allowed exec
  the rest                   path, argv, args or stack of another task

bpftool prog profile breaks too. Cycles per run of a tp_btf prog, lazy:
1540 today, 1236 with preempt off, 387 with walk. With full preemption
the sum is negative.
Same pattern in the source, not run: perf stat -b, bpfsnoop -g and
--output-lbr, exec and setsockopt in the fentry mode of datadog CWS.

2. Corrupt today

Several progs share the buffer. prog->active is per prog, so it doesn't
help. Lazy preemption:

  prog                        today      walk       preempt off
  --------------------------  ---------  ---------  -----------
  tracee syscalls             2153/9.3M  3619/22M   0
  tracee exec                 180/1.1M   181/1.5M   0
  datadog CWS, fentry mode    2268/7.0M  4065/12M   0
  elastic ebpf, no cgrp path  315/13M    290/14M    0
  skywalking-rover            196/21M    345/30M    0
  inspektor-gadget traceloop  28/7.5M    238/12M    0
  tetragon 1.7 fentry         2199/19M   3100/18M   0
  falco libs 0.25.4           2700/56M   4019/82M   879/72M

So you're right, for these the guarantee was never there.
For most of them walk is as bad per event as today.
preempt off fixes a bug that they have now.
Same pattern: open, exec, rename, http of inspektor-gadget and kubescape.
In the source, not run: systing, dynolog, coolbpf ifc engine.

3. What prog->active costs

Same loads, lazy preemption:

  lost                                today      walk     preempt off
  ----------------------------------  ---------  -------  -----------
  tetragon, match without a signal    616K/4.9M  57/4.2M  0
  runtime-enforcer, denied exec runs  175/336K   2/440K   0
  falco libs 0.26.1, lost events      16.5M      2.7M     0.5M

walk is better than today here. preempt off is better than both.
The 0.5M of falco come from progs that are not marked, see 6.

4. How precise is the mark

About 2000 progs run in the affected runners. 930 are marked.
From the source: 420 corrupt their data without preempt_disable(),
230 of them are datadog in fentry mode. 350 are marked for nothing:
the hook is atomic, the map is read only, or the prog has its own guard.
The rest lose a counter update at worst, or have a bug of their own.

5. Sleepable

No prog has fentry.s, fexit.s, raw_tp.s or tp.s. Two loaders set
BPF_F_SLEEPABLE: tracexec and datadog shared-libraries. Their progs have
no per-cpu state. So nothing in [1] needs protection for sleepable progs
in these runners.
tracexec has a pool of 2 * ncpu entries. Without prog->active it
overflows and cuts argv in 0.14% (lazy) and 5% (full) of execs.
Today it loses 42% and 66% of execs in the same load.

6. What the mark misses

array[bpf_get_smp_processor_id()] without a tail call.
That's the 879 in the falco row, and the batch of closed connections in
datadog tracer-fentry up to 7.78. Both releases don't load on bpf-next
for other reasons.
bpftrace is not in [1]. createScratchBuffer() indexes a global array by
cpu id for each object above on_stack_limit, 32 bytes by default.
str() and large printf() go there:

  tracepoint:syscalls:sys_enter_openat { printf("%s", str(args.filename)) }

From the source this is clean today and breaks with or without
preempt off. Not run. Procmon and Sysmon do the same on raw_tp/sys_enter.
A mark for bpf_get_smp_processor_id() fixes them. It marks up to 350 more
progs in [1], and most of them are safe.

7. The case for no protection

lsm lost prog->active in 6.2 (271de525e1d7). uprobe is preemptible since
6.0 (8c7dcb84e3b7). About 330 progs of 21 projects in such runners use
a per-cpu scratch without a guard today.
But projects started to notice after 7.0. obi, falco, fact and tetragon
added guards in Aug-Oct 2026. falco saw "one crash every 10 minutes per
agent" on 7.x [2].

What a prog can do on its own is limited. bpf_preempt_disable() cannot
span a tail call. A depth counter needs LIFO order. A heap keyed by task,
a slot with an owner and ringbuf reserve work.

The progs that do it right, falco 0.26 and tetragon 1.8 fentry,
do tail calls. An opt-out for per-cpu maps doesn't remove their mark.
A false mark costs scheduling latency only.

Not covered: PREEMPT_RT, may_goto.

[1] https://github.com/4ast/bpf-corpus
[2] https://github.com/falcosecurity/falco/issues/3955
