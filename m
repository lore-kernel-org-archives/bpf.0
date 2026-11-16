Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854864;
	b=b1tTRGYtpqpJUURADUDTyODEzO7j8wqIiirwqUiL1UXJlxqDREGjN+6Cqpt6T7P77NEp
	 dG/jOVLeJ2hpoLQxktZbpAFyQDvlyxVmReY+IoB3RpWnMR3kV2LXM7OtzboWrl7h4lD8M
	 4fXJPg8V9g7bTNHY1bwA0qXAKUN1ViGV7hP3WyqC+s/YF0dqB2YokgO9gFIbj59UbVR7h
	 hoJQ4zFgcTqh2fqmR31rgi/gDXGdLrWFbsCNopxKOwlS8Ps9/d7lQ4xcuiOy4Cv8A1rG+
	 hn2u3sp6JHXN+GiZf0BAC/PXO5XQ7HL1aWzoc3JC0Y9mxGaKIkrbb62ClCXuD9jeoVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pkGRbtzAUOddYKX69NzivkJyzuDSrRr91G97bv6lnNg=;
	b=i1PbgjX+0mAKaUV7mWTcIW/+skd8+jvsL2dpMRmUwgtoUbMc1Ytwv4Xh/xoZ9rXiTnFx
	 zp3VJiwoUQQ5joJfW20Znye0twcxcMe+86zLJ8WftP3PO9yfK/o9rOYYISRavcpharDcA
	 UCzo4fKROLflXKRgwNoRw4IWoHTrrI3aiZ6kZ6KsXsDSawdZOTCSnuxoqch6pWFQpyE49
	 FCnjqg+cAYU6m8TfaJhPDU52ZF/5plzpAmcJhzUTtpEqZjBkzZCu2UmUU5qr47oXgwvGQ
	 zVUyd9MyJRt1ahR+FPQnz05POezs85jOp3Wu8dRQcMa/0ZOs69vZ1n7qJ8S8jGgfwlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DwFuf4J2;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D421606A336
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 18:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D421606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DwFuf4J2
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e96502e447so39811925ad.1
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 10:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794854863; x=1795459663; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pkGRbtzAUOddYKX69NzivkJyzuDSrRr91G97bv6lnNg=;
        b=DwFuf4J2lx6Mkje+7VG6pLEhFMX4BMBdwc6QFs/Mv+Q4IIyV8t/L+EJ4ik2cQ6DrZi
         F1mLPayiuW92DwvXjhOGYPBI9YoypCzZ5mzvWbxqdLEd6+fhaI4vaSjRuLiwJRox1vmb
         1HbM1vaxaX7YngWJ6L4X0uJkUHI98Ekpw8WqymFOxWK2E2tXhhzSP76iUIQNyRTLQquV
         klypLyG1NEHXmBC/5MwVCdttPEeCT5l8qymmQgzRZeR9mbAfiv9MYWQR7GppOXJ1Bxli
         ZgFwYj9erK3XfwhYWldNAcN67IQ9elT1UU3cNRTs5uJKo21k1sU0+KQWKN5XR2sKM65C
         hbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794854863; x=1795459663;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pkGRbtzAUOddYKX69NzivkJyzuDSrRr91G97bv6lnNg=;
        b=Tw9HUmhFT0i/RTnifRdNgGcBaP3cxUGMwCkz6cTujhtFl+eynJ6f+3AJOe2SKI52ZZ
         pdgksWED0OxW7KxUX76gS4auCVVqxHF4dnmJ7PJRdtjuDJhvSJv7kBtz62TvublxKjTF
         TI3HgMiBEDE4JpHjMu3sF01qOSLCnkc8/MndkwDvSp5yqwraSQ+UtA1aeC1aYOBCwEod
         GmifENsl4p4EFOIr4d4tvpC+2ruyh6Ea3ePCPHLDg5u3+eF8f9o+/rSmzRketq11JlQf
         D8B0Kkwpi31KXA89GjJtFPERpDLraAfGQpGOZOrgZbhNQnqVkUm5YwFAJ4Yyzyqb24UL
         DQqw==
X-Gm-Message-State: APuU4Z/b+DWH06w/LJQtS1WQmyzCVmhSHStEY6TnNjt5BmEp8iZq9ZmY
	Y/Jbu3oJT7+w19h1z91wyK7glMNk/C0KUC2ftORFDNjTRAuIuDxYUkUmD7tsGA==
X-Gm-Gg: AZFdTZeLBYlnzXfmd0OkKiekb8Rdr5RqdojOxgrttA56ewXw2jw1PU0+a0Vk1prgw8K
	xDgiWVeUlycMuJS7RiacGjmeYKpzcdT1PX+aRqJ8REbDzn1bHuUcixjuxeUwKBpnK+56CGiR6nY
	MqrCoV8vEpuGaNaj1sB8nw95Mccn3aJ80eHDnweX0lv1IDu2V1Hzl3LKtlID/6lSQfrtCYacqPZ
	HF/UxXUF1eMqunhUGlHUMXYVvPmHW/HTKB5JzKvpYL/IQ08c5bPw4DdDQp2JIYqyyuHZKQWrAQe
	lmXBz4nh1TbhScqsc9gA0g84l9zfH9MuIsLbElYDCDdr33VnLZzcVr9V8dktk0vknKV3rM0cHjd
	4V6gRSA6pr5YHIz3BE7DwmbpSjwWJ51h5E3vct408eEqvvJMsXCpXg8MGZhTJSIEtCJbQWmPUDl
	cYVGI0CrXEFArbPLDx/VRpdPGw/T0U/QXIlGdRVaV5uAJrIZyfsJB/CmSm1bi1SRoQU+/DWQezA
	wcsvmhhYJBiqpIjE+CvmfUaFbyoueluZUBp65KQxmUQX4djvN5oP+z98HNeaY3HyxGeTkRniuPk
	PcV1sp+gJBMO9Ef54g8vplp6x065kfEx2hL5A1XG6xlvtTKko28KnulOUCXn/HSYb2b1OZRdWPM
	Dv96klY3OioYLWh09q5w/SLcN5SUCknrdIvm0SHrY3KkrJu6hUdnOrRw=
X-Received: by 2002:a17:902:db02:b0:2dd:c053:a6ee with SMTP id d9443c01a7336-2ee0dadc350mr100928425ad.32.1794854863379;
        Mon, 16 Nov 2026 10:47:43 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7a11be4sm3125495ad.12.2026.11.16.10.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 10:47:42 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 18:47:41 +0000
Message-Id: <DMWUY4M0QXMH.33XAPR76ZXKRT@gmail.com>
To: <rtm@csail.mit.edu>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: a riscv ebpf uprobe can wedge the machine by writing
 pt_regs.status
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <30318.1794850523@30-11-166.wireless.csail.mit.edu>
References: <30318.1794850523@30-11-166.wireless.csail.mit.edu>
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

On Mon, Nov 16, 2026 at 09:35 AM rtm@csail.mit.edu <rtm@csail.mit.edu> wrote:
> On riscv, kprobe_prog_is_valid_access() allows a "uprobe" ebpf program
> to write ctx at offset 256, which is pt_regs.status. When returning to
> user space, ret_from_exception copies whatever value the ebpf program
> provided to the CPU's sstatus. One way this can cause trouble is if
> the ebpf program sets sstatus.SPP to 1, indicating that the trap
> should return to user space in supervisor mode rather than user mode.

Yes. It's a real bug, and it's not only riscv.
The exit path trusts some of the fields. ptrace guards the same fields:

  arch    field   exit path                       ptrace
  ------  ------  ------------------------------  -------------------
  riscv   status  csrw CSR_STATUS, a0             not in the regset
  arm64   pstate  msr spsr_el1, x22               valid_user_regs()
  x86-64  cs, ss  (cs & 3) == 0: iretq to ring 0  set_segment_reg()
  x86-64  flags   iretq loads IF and IOPL         set_flags()

A uprobe prog should write only the registers that ptrace sets to any
value. The verifier can reject the other offsets at load time.
Each arch lists its registers. An arch without a list gets no writes.
flags and pstate become read-only, the condition bits too.

Jiri,
pls commandeer the following:

diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index 2a9b0bc..1e6ac47 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -152,6 +152,12 @@ bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
 		return regs->sp < ret->stack;
 }
 
+bool arch_uprobe_regs_writable(int off, int size)
+{
+	/* From x0 to x30, sp, pc. */
+	return off + size <= offsetof(struct pt_regs, pstate);
+}
+
 unsigned long
 arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
 				  struct pt_regs *regs)
diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
index eb177d0..dbb1534 100644
--- a/arch/riscv/kernel/probes/uprobes.c
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -126,6 +126,12 @@ bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
 		return regs->sp < ret->stack;
 }
 
+bool arch_uprobe_regs_writable(int off, int size)
+{
+	/* epc, from ra to t6. */
+	return off + size <= offsetof(struct pt_regs, status);
+}
+
 unsigned long
 arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
 				  struct pt_regs *regs)
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 0f60c0d..fc07bcd 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1888,6 +1888,21 @@ bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
 		return regs->sp <= ret->stack;
 }
 
+bool arch_uprobe_regs_writable(int off, int size)
+{
+	int end = off + size;
+
+	/* The 32-bit pt_regs has segments in front of orig_ax. */
+	if (!IS_ENABLED(CONFIG_X86_64))
+		return false;
+	/* From r15 to di. Not orig_ax, cs, flags, ss. */
+	if (end <= offsetof(struct pt_regs, orig_ax))
+		return true;
+	if (off >= offsetof(struct pt_regs, ip) && end <= offsetofend(struct pt_regs, ip))
+		return true;
+	return off >= offsetof(struct pt_regs, sp) && end <= offsetofend(struct pt_regs, sp);
+}
+
 /*
  * Heuristic-based check if uprobe is installed at the function entry.
  *
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index d34dbc0..43b250b 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -239,6 +239,7 @@ extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *
 extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr);
 extern void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr);
 extern unsigned long arch_uprobe_get_xol_area(void);
+extern bool arch_uprobe_regs_writable(int off, int size);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
@@ -300,5 +301,9 @@ static inline void uprobe_copy_process(struct task_struct *t, u64 flags)
 static inline void uprobe_clear_state(struct mm_struct *mm)
 {
 }
+static inline bool arch_uprobe_regs_writable(int off, int size)
+{
+	return false;
+}
 #endif /* !CONFIG_UPROBES */
 #endif	/* _LINUX_UPROBES_H */
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index caf4447..c47b1ee 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2703,6 +2703,15 @@ void __weak arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vadd
 {
 }
 
+/*
+ * Can a bpf prog write these bytes of pt_regs? An arch opts in and lists the
+ * registers that ptrace can set to any value.
+ */
+bool __weak arch_uprobe_regs_writable(int off, int size)
+{
+	return false;
+}
+
 /*
  * Run handler and ask thread to singlestep.
  * Ensure all non-fatal signals cannot interrupt thread while it singlesteps.
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b4ff9d4..4f1be6c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1398,8 +1398,16 @@ static bool kprobe_prog_is_valid_access(int off, int size, enum bpf_access_type
 	if (off + size > sizeof(struct pt_regs))
 		return false;
 
-	if (type == BPF_WRITE)
+	if (type == BPF_WRITE) {
+		/*
+		 * pt_regs also holds what the kernel restores on the way to
+		 * user space: cs and flags on x86, pstate on arm64, status on
+		 * riscv. A prog can write the registers of the task only.
+		 */
+		if (!arch_uprobe_regs_writable(off, size))
+			return false;
 		prog->aux->kprobe_write_ctx = true;
+	}
 
 	return true;
 }
