Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793766815;
	b=d65KLCBLzBYakz2gEr+b7IZ9sZgiV3TNZWILvvCn9KTcp30WbeYUx8tikRLezMo3LEK/
	 NflpevxYWD+m3/3VnGoC+gbhRKYEPWCYYEGsNGbAUkF8bGyWszGWVGAaRHMPvEAKyPbrP
	 EyT5N7wr1p6N48NPD8qKdLxdv5gi+kT7TFzvho902EErj/A41Zn4POV6DCDn94aW4Tgh8
	 LMg0PByzE/1FAcdv6o9QEZRoahJ8o22bFmbEOvMv1N3jJ0S08oNov9NeFZkMl2QgFToAZ
	 6XVwADJeY2tTSqUQaLcte8JmViZVyfozj2tXHJDuVSB/mUxbjO7u/sFB+FMl9GAmesQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793766815;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=f+xvtQWs74MMe/UeD/ChJT/X8yyz7Cxi7Xah66FFlJw=;
	b=wnxQoID3Q7HrMyLQREt0pfsyNpxTuxeeaJA0p8hSc27AQPK+y+DraB/eKcBItFWqqivf
	 2VzNrXQsW866vWEzX5yyq/qTI5nUZikHek+C9EZPYiJ4fIvWRcqisUivAoX0cmY4XtBzh
	 HcYeh0WH1fMmYSZ+cV/zQEV/jHHTmUZCD9an1uZdstetTs36+sCmhg35iimA44j2Of/CI
	 4ibaAAj9JCR2CCmNMEhS+02GNynTeu350G9Kipj8nkfUYd05cFgqlNYkVfwBsq4mD5afI
	 XkK3tireBiE+U4dU7/SEIn9CqBQFKqHYqU3tBTqJ6yYcYSxPrSY79FJur7Kq6qgYR6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t87Lfhk6;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858FB606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 04:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 858FB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t87Lfhk6
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ab41538192so282002a91.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 20:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793766814; x=1794371614; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f+xvtQWs74MMe/UeD/ChJT/X8yyz7Cxi7Xah66FFlJw=;
        b=t87Lfhk6Akx597Wzu4kuhZ1wSY2MW1n/tKfD4ubDTKR2G3sESsPw88qNMIOhlzDdVU
         VLgXpTQFwEF3xV/lF3G4G1wFQHKcfqaGcprjKfvAXIEoAmav4HQ3z1a+PFdypcWqFVd5
         9BQs7TfYaSkHkwLDyjHYfNz/FS7tfpTL30ALmQ01HZPcX9D91eDuRMtl/mYtMKkhwTU5
         ECoIJkhEHz4mrWIUt5RhBH2iBp0WxusV4iv0qGVbVvaUCEayY+6UfCHLuRI3aoErnOtA
         S0ThcnhwWNfpE2/56G1E0PkEq3e/Olz8IHYHCCjNIh1priYDEyfwJgjd7TYt420E7CdI
         6G1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793766814; x=1794371614;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+xvtQWs74MMe/UeD/ChJT/X8yyz7Cxi7Xah66FFlJw=;
        b=iFoNlysp5F2eQwLx9O/5rT1280IvZ3zgYUNJzjH67QyjGLgbfF9casQt6NaM5trswP
         f/fQvQ0VTN7QJB0TMLV/DysVEYDwSIcHR20VwETLFif2F+4CIut95VhmL5/c2+qG0JKE
         jNGvGiIuFF5hsenw+CXkqRo4lapYEcCXMIuIf3oazlzePw/vQ3KJ9xElJt/6/YDm/0Z2
         0PCQq4Bn8KCK/Scx8m9FhNxS3nuOU8dB27MHRhXoycpsyjMabAIRWRShACQiDx6NqrQx
         bMScpLaO6l627q48IyvwuO8mSf4E1wdrLOGa5MUbbDx2HS95q+UgtxlyhWHi7e+uAaSj
         e00g==
X-Gm-Message-State: APuU4Z8UTlC+oxRanL1219Bv23oMBgc8DduIF4XNzWVHfFFm4LO+6wcl
	2h5TwD9IZbaGaDadGhzCrH53MMROkg8DvDLWVGMF77CyFIEMF+Ixee1v
X-Gm-Gg: AYBFou0rAGJ8r7guUlCBU6p72jIfTR6YDjTJOiD9qGSc6plXQOwb7P1CywxbmcFVWTw
	iUnHOn8iO0GmqafUPx+ac0v3QXr+R+Kq2Bw9n/dFiexwemTsthdqZ15www3oG8gAjIsv7gErhNX
	Yheh8+FMvbNjkLQ6priAWFBs+CqZftKNhO17kKJF4mWjoxwDlrHhYNDdXXpfQb6LqRFNCqhqpZw
	O8Jfjv4g8TEgsHIEHolzDTvPIOjs+4Rt9V+r2v8iZ5UakB/0phchSbQAgnXg+trIGDpPV8BPnWG
	YTtwTy1OumJpW3bR1foHiy6CUABdRzwkth0O1zjfq50QvyADzi4iwOsdxm7Ii9sGh/xWSX1dIN4
	hst2FwLeQEL46ap0VW5240lH4NPNMPOIMgv2nEMy8uGx94zMDcutV8M3Z5D+wWRMpzZSbGedqHx
	iBGR4beE0RKWWc90zYRs/Rx6q3bh0arz1LTE2IueJho6o6LJiDlqnrQ9ls8dd3CWnMeaM1j2xKU
	NNYv6///08o5+wS4lI9szOyJTrL4H4/ahmtnlmJGxe0JIQYtgCstHRjZ2mmRge3fkh4EZE6dlPE
	41zl6x57VUcOtXc8vzDLwLS9a1cfMeC1BKSW8xlIPgq/xlieFGxkxch1O0flvbA4kQWMGe/dT1f
	eoQ8CATlD3bgPsACt/AKPtN4XGBAMTARbcg==
X-Received: by 2002:a17:90b:4c09:b0:3ac:adce:60af with SMTP id 98e67ed59e1d1-3ae89724b12mr14227669a91.16.1793766813499;
        Tue, 03 Nov 2026 20:33:33 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09445cf0dsm1865847a91.4.2026.11.03.20.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 20:33:33 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 04:33:32 +0000
Message-Id: <DMM59LNY80FW.36KH8ZKL94T59@gmail.com>
To: "Jiri Olsa" <jolsa@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>
Cc: <bpf@vger.kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "HyeongJun An"
 <sammiee5311@gmail.com>, "Christian Simon" <simon@swine.de>
Subject: Re: [PATCH bpf-next 0/4] bpf: Disable private stacks for uprobe
 programs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261103093400.112178-1-jolsa@kernel.org>
References: <20261103093400.112178-1-jolsa@kernel.org>
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

On Tue, Nov 03, 2026 at 01:33 AM Jiri Olsa <jolsa@kernel.org> wrote:
> As discussed in [1], there seems to be no known compatible fix for
> private stack corruption in standard uprobes. This series leaves that
> issue unchanged and adds the BPF_TRACE_UPROBE attach type for new
> standard uprobe programs, allowing the kernel to identify them and
> disable their private stacks.

New uapi to fix a bug is not a good tradeoff imo.
The bug stays for every loader that doesn't set the new attach type.
HyeongJun's tracer is one of those.
BPF_TRACE_UPROBE is also the last attach type that fits into
u64 allowed_attachs of the token.

> - disable private stacks for all KPROBE programs: protects uprobes,
>   but may reject existing kprobe programs that rely on private stacks.

can we do that for all of them except kprobe.multi and kprobe.session ?
A prog without attach type is either kprobe or uprobe.
The kernel can't tell, so it gets the kernel stack.

Without the private stack the verifier sums the frames of a call chain.
The limit is 2 Kbytes on x86-64 and arm64 now.

The options for standard uprobes:

  option                   untagged uprobes  what stops working
  ------------------------  ----------------  ---------------------------
  BPF_TRACE_UPROBE          still corrupted   uprobe and kprobe progs in
                                              one prog array
  reject them at attach     can't attach      uprobe progs with 64+ bytes
                                              of stack
  no private stack without  fixed             kprobe progs with a call
  attach type                                 chain above the limit

Row 1: a prog array takes progs of one attach type only.
With patch 3 SEC("uprobe") has the new type and SEC("kprobe") has 0.

Then no need for the new attach type, the feature probe and SEC_UPROBE.

PERF_EVENT_IOC_SET_BPF doesn't check the attach type.
It can attach a kprobe.multi prog to a uprobe. Hence the 2nd hunk.

Something like this (compile tested only, selftests are not built):

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 935b163..9003330 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5706,6 +5706,15 @@ static enum priv_stack_mode bpf_enable_priv_stack(struct bpf_prog *prog)
 	 */
 	switch (prog->type) {
 	case BPF_PROG_TYPE_KPROBE:
+		/*
+		 * Uprobe progs are preemptible and don't check for recursion.
+		 * Two tasks can run the same prog on the same cpu.
+		 * A prog without attach type is either kprobe or uprobe.
+		 */
+		if (prog->expected_attach_type != BPF_TRACE_KPROBE_MULTI &&
+		    prog->expected_attach_type != BPF_TRACE_KPROBE_SESSION)
+			return NO_PRIV_STACK;
+		fallthrough;
 	case BPF_PROG_TYPE_TRACEPOINT:
 	case BPF_PROG_TYPE_PERF_EVENT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 457d75e..f2d4f8b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11856,6 +11856,10 @@ static int __perf_event_set_bpf_prog(struct perf_event *event,
 	if (prog->aux->kprobe_write_ctx && !is_uprobe)
 		return -EINVAL;

+	/* PERF_EVENT_IOC_SET_BPF takes kprobe.multi progs too. */
+	if (prog->aux->jits_use_priv_stack && is_uprobe)
+		return -EINVAL;
+
 	if (is_tracepoint || is_syscall_tp) {
 		int off = trace_event_get_offsets(event->tp_event);

diff --git a/tools/testing/selftests/bpf/progs/verifier_large_stack.c b/tools/testing/selftests/bpf/progs/verifier_large_stack.c
index c2a3ddf..c366f00 100644
--- a/tools/testing/selftests/bpf/progs/verifier_large_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_large_stack.c
@@ -226,7 +226,7 @@ static void priv_stack_frame_2048(void)
 "	::: __clobber_all);
 }

-SEC("kprobe")
+SEC("kprobe.multi")
 __description("private stack: two frames of 2048 bytes")
 __load_if_large_stack()
 __arch_x86_64
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index 3d9994a..4d74a40 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -22,7 +22,7 @@ struct {
 	__type(value, struct elem);
 } array SEC(".maps");

-SEC("kprobe")
+SEC("kprobe.multi")
 __description("Private stack, single prog")
 __success
 __arch_x86_64
@@ -70,6 +70,40 @@ __naked void no_private_stack_nested(void)
 "	::: __clobber_all);
 }

+SEC("uprobe")
+__description("No private stack, kprobe or uprobe")
+__success
+__arch_x86_64
+__jited("	subq	$0x100, %rsp")
+__arch_arm64
+__jited("	sub	sp, sp, #0x100")
+__naked void no_private_stack_uprobe(void)
+{
+	asm volatile ("			\
+	r1 = 42;			\
+	*(u64 *)(r10 - 256) = r1;	\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_all);
+}
+
+SEC("uprobe.multi")
+__description("No private stack, uprobe.multi")
+__success
+__arch_x86_64
+__jited("	subq	$0x100, %rsp")
+__arch_arm64
+__jited("	sub	sp, sp, #0x100")
+__naked void no_private_stack_uprobe_multi(void)
+{
+	asm volatile ("			\
+	r1 = 42;			\
+	*(u64 *)(r10 - 256) = r1;	\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_all);
+}
+
 __used
 __naked static void cumulative_stack_depth_subprog(void)
 {
@@ -83,7 +117,7 @@ __naked static void cumulative_stack_depth_subprog(void)
 	: __clobber_all);
 }

-SEC("kprobe")
+SEC("kprobe.multi")
 __description("Private stack, subtree > MAX_BPF_STACK")
 __success
 __log_level(4) __msg("stack depth max 512")

pw-bot: cr
