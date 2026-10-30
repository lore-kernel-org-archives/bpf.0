Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793401267;
	b=iANxiWLAeit6+xDWAXgjD2bieGELCWoT0WJKhIKECPn91VMLy7Q7iCo13D83y4sCizyS
	 jSeU+m5WX4ntjmIk0kBEppQHyiwKAcXX5ZCwagDxMFNznOf+YnPRZPtlACcl0VdFp0zbF
	 KrpcfI+ekUMEl+oHG7zXPbe/oyW9+wjXk1fscXxrLRKS5JH9vC6mCzwgcY77/ZUgsQoF9
	 Hw6SHDQUu4NDMp5fNSY7G+0JiKLs/5bcWJ57b+tzZv18hVw/8qqkoD2JU1TO9JjDUppuI
	 Iu4b+nykwDdwPlyKbs96Oa3XCHhNBvb8fLBZ9lgtDP4X71mljHpfPM+qEYoiPHidPNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793401267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZqxcF4lJNEYISFgEKoKl5OomytwhwZ+IBxXpkIJsLHc=;
	b=QvqmAR5BNkUgfgKGnWUYuzlJU3BHilcngXCRyknbIzVjMCyXpqftPiUujfN2cvwoY++g
	 O/r4FDtFuOeuxQr8nayPpdFwf/83cSfrqnQoSuOo3Ou8N0suAVnsSSYs1mDsXXZc09e3q
	 kNCmfLe+FaO/hV3c4sIybXJiO74KZamn259j/aqfPOeC13DybvnCTaeEBEBMclZsRawS9
	 VEgXBLi1P+SfC+pKHoXbEPs8v1hSOZHx7ej606k2G3jFYHTyMzeNxIn1BzCsg9XyC1XKf
	 HjRjkpOs3hFjaSxhQsGC8hSOej1JrTcN2MqUCL4APIDb0zjSYEqQbsN1Ze+9y/QEtlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y1MGzY+G;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF8F606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 23:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCF8F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y1MGzY+G
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso8753085e9.2
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 16:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793401265; x=1794006065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZqxcF4lJNEYISFgEKoKl5OomytwhwZ+IBxXpkIJsLHc=;
        b=Y1MGzY+GegyFz1M+MFM6aXhBvcDzQnMAMjztRJMq2QYPjxoLKaPZtqT+sZAvQvQ9DF
         wOwz9TY8Fdhkq5mJ7EXTI1zgDXnch1tSsCB6lCniM5o+ox4Q5yZsG/jdW+Aqv1XV1yRo
         FnIloNuZHDxvW7MeiUtnFktF9Wi2pZme9VVcw/bBcHTa9YNyuPtpoX5ob3vONfsSie8Y
         iTghVfURy9pRn31fjcC6ntxa8N6VLyC17fCdaoAGLWMrlEM6y17RVR1DyncQ2DQ2WbG2
         ME7f3wpZ57H6QXaBN25dp24jPMVasD2R8+RbJUmbcfK8EZYCYgcd4q5Ek8U1D3UErFoo
         1LTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793401265; x=1794006065;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZqxcF4lJNEYISFgEKoKl5OomytwhwZ+IBxXpkIJsLHc=;
        b=Op8MH1GgFXjfu1ADDpvTJGjL52ZTKC/UMm9pSCNAdkjuy5ihmKKZYElH/EbVuaxsV5
         s+5upVJX35p7Hw+ug/9tMRA0cP2Us2vBYDAMTUm+tJSPhpRnkik0Q6SACH5JZ256Fbk4
         3Ydwpk3xf7ly+WtGyAJangKBfG/b2IZsuDapFEYw4GPlQpjeV0JjfKUT6juqMJolc8WU
         QYJ6lt54qNQfWUKox/ajPkW9pgoR12t9mTcbULk5XZp/2/J7yGxXupeq4XuQw+OXdo6/
         FlbaoiYaYylg8tPBWrpOlKCFCasaDg6SwzbwzkEAe8m8M2AYRCpVoi8O0CQYAmaPoq79
         FYWg==
X-Forwarded-Encrypted: i=1; AKwUvBxTggA4ft2/4k0eNP7xXKpTe51QhuB/F2irn6xho/ZIVEwD1uwQNV/fcrX+PhZ9ChwcVuo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFu8fRDEWXfo1GjQTJu2MOrg2pBj/Bal5tIfGZQBCg1870TJ5t
	nmYglYDGE5gmn/Bb9OmOUF4OPMeo9r6WXP54uZ+uCXz0zIqVEV5UPMnYasGSeg==
X-Gm-Gg: AYBFou1E4Qq1vaSyh/JlXngMttWXwrhgiWPKKYdlWyDBxA1g6tmfoTo+VdXlR59ms/E
	dR7MXviETTuQpDNPsyseMDrVyN2JIRU2hXxJVO/9hArWsY7ySY44GASGb038ABwu92zyvls+0fG
	EPyRkNxDYhTyqhgPZFbvekhbDZwJQc+dfFiGL+N0TrUs/ciWyNhhsT+kjNq06owazvan7o3KSmI
	ySGKWnHrMry/7TPR8j0R+tfW25K6RCu4GEn38hdxMZTKyMdH0BxE1vVmjVSxxBzpGxBwi3qR1dq
	y1azFpOjR1sKVgRcvxQDmc1hEzDPrgWVJ+QZGcgaEYl9RmIXEMovLPtIgBU8eyRIVMKEW0wbz8J
	OpfukGUOQCOwO26NRa13MUkKw9ZuHp7eMQb6KfZmzVEuSIXee6XgsOoKmh5fcoxUVHUcaEQ4tck
	xExvZiGEuVwI07/Ge9KAqtS3OMO3VPTQHUNJPXmv28ydTliQwiV6/F6ez5VtVmtYyEh5rdVUwIe
	cOvZJNmP54i6/dD1aO45RCWSQm3mHpPPrfVvgV6w2fNYfgPp9DHm8a+amDs3a8MHZ0aS0ldRQdl
	bp2NySxiasHqO2WVOiyi8eWe1lSvN8IfHiOI2unYhEnxLWcKdT7dHGXlIlVVmjDecNv5Jpw=
X-Received: by 2002:a05:600c:6285:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4ac182dc8f6mr83184385e9.34.1793401264862;
        Fri, 30 Oct 2026 16:01:04 -0700 (PDT)
Received: from krava (ip-94-113-247-31.net.vodafone.cz. [94.113.247.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d425sm5743208f8f.1.2026.10.30.16.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 16:01:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 31 Oct 2026 00:01:02 +0100
To: HyeongJun An <sammiee5311@gmail.com>
Cc: olsajiri@gmail.com, bpf@vger.kernel.org, simon@swine.de, ast@kernel.org,
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	tj@kernel.org, yonghong.song@linux.dev, stable@vger.kernel.org,
	andrii.nakryiko@gmail.com, alexei.starovoitov@gmail.com
Subject: Re: [PATCH bpf v3 1/2] bpf: disable private stack for sleepable
 programs
Message-ID: <auUhrnOOUWY3Mb9y@krava>
References: <20260822225444.2774461-2-simon@swine.de>
 <CAADnVQ+MCsQxn5KTp-y7pZu9DrV0Lhy9=+T4yofCfZEZGZcWdg@mail.gmail.com>
 <apC6-9YqBpOjFLGr@krava>
 <20261030012258.3005240-1-sammiee5311@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030012258.3005240-1-sammiee5311@gmail.com>

On Fri, Oct 30, 2026 at 10:22:58AM +0900, HyeongJun An wrote:
> On Fri, Aug 28, 2026 at 12:32:27AM +0200, Jiri Olsa wrote:
> > > my understanding is that preemptable kernel doesn't mean that
> > > bpf prog can be preempted by user space.
> > > only by kernel.
> [...]
> > hum.. non-sleepable uprobe prog is run by bpf_prog_run_array_uprobe
> > and it disables only task migration, preemption is not disabled and
> > holds rcu_read_lock (which seems ok for preemption)
> > so I'm not sure why it wouldn't be preemptible by another task
> 
> It is preemptible, and the private stack gets corrupted when it happens.
> We hit this in a uprobe/uretprobe based tracer and reduced it to a small
> reproducer.
> 
> The second writer is not user space. The scheduler preempts the task
> while it is inside the program. migrate_disable() keeps that task on its
> CPU, but the CPU can still run another task. That task hits the same
> uprobe, runs the same program and writes its frame into the same per-CPU
> private stack. When the first task resumes, its frame holds the second
> task's values. Neither uprobe run path disables preemption:
> 
>   bpf_prog_run_array_uprobe()  migrate_disable(), plus rcu_read_lock()
>                                for non-sleepable programs
>   uprobe_prog_run() (multi)    migrate_disable(), plus rcu_read_lock()
>                                or rcu_read_lock_trace()
> 
> With PREEMPT_RCU, rcu_read_lock() does not disable preemption.
> 
> bpf_enable_priv_stack() gives a private stack to every
> BPF_PROG_TYPE_KPROBE program with at least BPF_PRIV_STACK_MIN_SIZE of
> stack and no tail call. So classic uprobes and uprobe.multi are
> affected as well, not only sleepable programs.
> 
> The test: four processes pinned to one CPU call getppid() in a loop for
> 10 s. The program fills 16 stack slots (a 216-byte frame) with
> bpf_get_current_pid_tgid(), spins with 200 bpf_ktime_get_ns() calls,
> and counts runs where a slot no longer matches a fresh
> bpf_get_current_pid_tgid(). The JIT output confirms that this program
> uses the private stack. The controls do not: one adds a tail call into
> an empty PROG_ARRAY, the other uses a single slot.
> 
> Clobbered entry runs / total runs, one 10 s run per cell (7.0: one of
> two runs, the other was within a few percent), x86_64, 4-vCPU KVM
> guests:
> 
>   kernel         preempt    uprobe      uprobe.multi  uprobe.s
>   6.12.112       voluntary  0/288000    0/296000      0/288000  *
>   6.18.56        none       0/272000    0/288000      0/288000
>   6.18.56        voluntary  0/272000    0/288000      0/288000
>   6.18.56        full       497/272000  481/280000    501/280000
>   6.18.56        lazy       0/280000    0/280000      0/288000
>   7.0 (Ubuntu)   full       1221/856004 1202/864004   1158/856004
>   7.0 (Ubuntu)   lazy       0/840004    0/848004      1/856004
>   7.2.10         full       649/296000  654/288000    642/288000
>   7.2.10         lazy       642/288000  622/280000    655/288000
>   bpf-next       full       700/288000  595/280000    619/280000
>   bpf-next       lazy       634/288000  670/288000    647/288000
> 
> * 6.12 has no private stack. Its JIT output uses the task stack.
> 
> The return probes gave numbers of the same size. Both controls stayed at
> 0 in every row. On 7.0 under lazy, each variant gave 0 to 2 clobbered
> runs per 10 s run across repeats. bpf-next was 7.3.0-rc5-g763187dbbf83.
> On 6.18, lazy stays at zero while 7.2 and bpf-next corrupt under lazy as
> often as under full. We did not look into why.
> 
> In the tracer this showed up as copies from another task's buffer
> pointer and length (wrong bytes or -EFAULT), and as return probes that
> found no entry state because the tid in the frame was not theirs.
> This was on the Ubuntu 7.0 kernel with its default lazy preemption, at
> one to four bad calls per million under steady load, and more when the
> host was busy. It went to zero once the programs stopped using the
> private stack.
> 
> On the fix: I agree with Andrii that skipping the second run is wrong
> for uprobes. It is a separate, legitimate event, and a tracer that
> counts calls would silently lose it. Disabling the private stack for
> uprobes, sleepable or not, as he suggested, avoids that. At load time a
> classic uprobe program cannot be told apart from a kprobe, so this needs
> either the load-time marker that was discussed or dropping the private
> stack for BPF_PROG_TYPE_KPROBE. For uprobe.multi, expected_attach_type
> already says BPF_TRACE_UPROBE_MULTI.
> 
> Until then, a single tail call into an empty PROG_ARRAY keeps a program
> off the private stack.
> 
> I can turn the reproducer into a selftest, or run any version of the fix
> on these kernels.

sorry.. seems this fell through cracks

could we add a BPF_TRACE_UPROBE expected attach type for classic uprobes?

but I think we can't reject attaching an unmarked BPF_PROG_TYPE_KPROBE
program to a uprobe if it was JITed to use a private stack, that would 
break existing users

thoughts?

thanks,
jirka


---
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8d7228834305..c0bb356b1f46 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1200,6 +1200,7 @@ enum bpf_attach_type {
 	BPF_TRACE_FENTRY_MULTI,
 	BPF_TRACE_FEXIT_MULTI,
 	BPF_TRACE_FSESSION_MULTI,
+	BPF_TRACE_UPROBE,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 02ed5368f056..8dfa98b22be9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2800,6 +2800,12 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 		return -EINVAL;
 
 	switch (prog_type) {
+	case BPF_PROG_TYPE_KPROBE:
+		if (expected_attach_type == BPF_TRACE_UPROBE ||
+		    expected_attach_type == BPF_TRACE_UPROBE_MULTI ||
+		    expected_attach_type == BPF_TRACE_UPROBE_SESSION)
+			return 0;
+		return expected_attach_type ? -EINVAL : 0;
 	case BPF_PROG_TYPE_CGROUP_SOCK:
 		switch (expected_attach_type) {
 		case BPF_CGROUP_INET_SOCK_CREATE:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 26a5ee0708a3..d9f390b0d289 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5699,6 +5699,10 @@ static enum priv_stack_mode bpf_enable_priv_stack(struct bpf_prog *prog)
 {
 	if (!bpf_jit_supports_private_stack())
 		return NO_PRIV_STACK;
+	if (prog->expected_attach_type == BPF_TRACE_UPROBE ||
+	    prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI ||
+	    prog->expected_attach_type == BPF_TRACE_UPROBE_SESSION)
+		return NO_PRIV_STACK;
 
 	/* bpf_prog_check_recur() checks all prog types that use bpf trampoline
 	 * while kprobe/tp/perf_event/raw_tp don't use trampoline hence checked
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 457d75ea7142..5fb8b40f52e0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11835,6 +11835,19 @@ static int __perf_event_set_bpf_prog(struct perf_event *event,
 	    (is_syscall_tp && prog->type != BPF_PROG_TYPE_TRACEPOINT))
 		return -EINVAL;
 
+	/* XXX leftover.. Multi and session uprobes must use their BPF link attachment path. */
+	if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI ||
+	    prog->expected_attach_type == BPF_TRACE_UPROBE_SESSION)
+		return -EINVAL;
+
+	if (prog->expected_attach_type == BPF_TRACE_UPROBE && !is_uprobe)
+		return -EINVAL;
+
+	/* XXX can we do this? */
+	/* A preempted uprobe can be re-entered and overwrite its private stack. */
+	if (is_uprobe && !prog->expected_attach_type && prog->aux->jits_use_priv_stack)
+		return -EINVAL;
+
 	if (prog->type == BPF_PROG_TYPE_KPROBE && prog->sleepable && !is_uprobe)
 		/* only uprobe programs are allowed to be sleepable */
 		return -EINVAL;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 8d7228834305..c0bb356b1f46 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1200,6 +1200,7 @@ enum bpf_attach_type {
 	BPF_TRACE_FENTRY_MULTI,
 	BPF_TRACE_FEXIT_MULTI,
 	BPF_TRACE_FSESSION_MULTI,
+	BPF_TRACE_UPROBE,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 02e75b183ed0..3b7aa4903758 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10842,11 +10842,11 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("sk_reuseport/migrate",	SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE),
 	SEC_DEF("sk_reuseport",		SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTACHABLE),
 	SEC_DEF("kprobe+",		KPROBE,	0, SEC_NONE, attach_kprobe),
-	SEC_DEF("uprobe+",		KPROBE,	0, SEC_NONE, attach_uprobe),
-	SEC_DEF("uprobe.s+",		KPROBE,	0, SEC_SLEEPABLE, attach_uprobe),
+	SEC_DEF("uprobe+",		KPROBE,	BPF_TRACE_UPROBE, SEC_NONE, attach_uprobe),
+	SEC_DEF("uprobe.s+",		KPROBE,	BPF_TRACE_UPROBE, SEC_SLEEPABLE, attach_uprobe),
 	SEC_DEF("kretprobe+",		KPROBE, 0, SEC_NONE, attach_kprobe),
-	SEC_DEF("uretprobe+",		KPROBE, 0, SEC_NONE, attach_uprobe),
-	SEC_DEF("uretprobe.s+",		KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
+	SEC_DEF("uretprobe+",		KPROBE, BPF_TRACE_UPROBE, SEC_NONE, attach_uprobe),
+	SEC_DEF("uretprobe.s+",		KPROBE, BPF_TRACE_UPROBE, SEC_SLEEPABLE, attach_uprobe),
 	SEC_DEF("kprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
 	SEC_DEF("kretprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
 	SEC_DEF("kprobe.session+",	KPROBE,	BPF_TRACE_KPROBE_SESSION, SEC_NONE, attach_kprobe_session),
