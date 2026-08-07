Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEFB345EA4;
	Fri,  7 Aug 2026 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103167; cv=none; b=dFygnnDsjxT05Y9aoBGA7Pr2QwAPEtRLIjlujrpZhCnYzQKMsk6nb7OJkoodqw5BCBq4eltlTCRlzboNQq0TDT6CJu5E+g8oQrKFTG69Pa7rO+vGqs/GVZaWLqK+kMVaR1dxA7kmQqH9iRAaTDsPLaKDBWz6lc64qy3zs5CLDKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103167; c=relaxed/simple;
	bh=5dE9dIhb+E/qMMmGxKOuwTEbgvQhQK+FcpKEFmSsm90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uMOT1Fu5RxKeha2P4pEgH1cUBb0RsaS/86Qbgis8R/4QDQDaFJhSYu3JbUK69fPqqNugXcKs3MmF0ZvJkyr549+BMmHYHZ+eXta4LeSVAMpoZgLJwzm1wmNT/1qxRi6lBM7XrHEyf9BPuM1uitRqo0/X/lMwyI0/KsPTDwfsVhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=V+NoDyNm; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="V+NoDyNm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=mCanMn7m0CYK20sqSEYGQ02/KP0vhxgam5D0g5dRWiQ=; b=V+NoDyNmdPDfBFi1KJiaRY9qWc
	sxlGtdMNlYetoxjQjzy0WnbE36hDgwXlFvdYvM11AG0NUGD5QXAfGq9u4LiCGbcMIx3jIHDgB4oFp
	Cj+U8YTpS96GTJHgXCtbnfcjjnKWtpcBcqe1a5tK3diCrOH8s9IL0K8LJw7aL/9h9RtZl45A+deoM
	laIyt2JFT5Y3tC7kQE35dyTw7zk7A0op4rG/cDk3u9Kt2ibPYoWR3x0cN7jixQIBf48qmxwiKVVem
	oVk0Y/9SW0ig1JRa0iI9z6CAQykXhifjiSXiF45RQRwjQM1QSddnUUJDhzD1l85pwcMa0HbnMsNoo
	V43xLp6A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wsJ1E-000PF0-0K;
	Fri, 07 Aug 2026 11:45:44 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 07 Aug 2026 04:45:31 -0700
Subject: [PATCH RFC] arm64: entry: PSTATE_I_SET is leaking on pseudo NMI
 mode
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260807-arm64_fix-v1-1-d069ccf9d71b@debian.org>
X-B4-Tracking: v=1; b=H4sIAFrFdWoC/6tWKk4tykwtVrJSqFYqSi3LLM7Mz1OyUjDUUVBKz
 kjMS0/VzUxRslJQMjIwMjOwMDDXTSzKNTOJT8us0DUxT05MsUhLMjM2MlbSUVAqKEpNy6wAmxW
 tFOTmrBRbWwsA5/sphGAAAAA=
X-Change-ID: 20260807-arm64_fix-47cad8fb6323
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, 
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, rmikey@meta.com, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=4166; i=leitao@debian.org;
 h=from:subject:message-id; bh=5dE9dIhb+E/qMMmGxKOuwTEbgvQhQK+FcpKEFmSsm90=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqdcVjNFJ9sISzh0Ym7DNgI5eZwMI6Ue02b07LJ
 MU067HAWpuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCanXFYwAKCRA1o5Of/Hh3
 bdtbD/9Yw1F9Z0OseIdi1qj3WAc3moSUI2IgAUPpMXat9PRrG3nFWk/zNIJX6Z8yWs2Emz5LMui
 DSKc2BBI7k/yrOxlxw1oPYhYnVENHLqKEZW7zf1+p8NBpqtoTOxNCXRS1eemgZiEUXGMPIrGLT1
 5saGb23CRPTFQUf2iy/UwQ7O+hzxhCH5+Oh9XKfLR7uHe16Hn+1g4QlcjzcSoPJvstKTP9jcsJ+
 RHi3fipvLCQUNWuXMehlkbJt56Fkoi5kG50wCAzL30HCwjPss+9RQlIQsA1HmUVVUQZrjmVtn0a
 uDZ8rkG3Tb1JhTzum+th0pomDnL6aCDUkAw8GU1HhZo/lKK6aumcaOHVq3g++ormPu+1fqho89c
 ponnL/1+xnk1RcbUdWx1IWwfVJcmjoY0Zrh0wNwGt4hq5aBQaWwmKMUcQ2v7oJfnchXB1nAZzNT
 +koEKrHzt0eBXZ98f3LFuPUkp3kA5APL2/x+tjXvQqHoxWLFETLtGE9+yzooKKjTNOCr4rkuT0Q
 e/l9IbeRgbTLR0tXLwesR/YuWknEE+E9zeO4lzs8Qx8QXMzKeTsxN/uPSMMdU2yZZ4gEGZ8jATu
 wJfzuTtNXKH/iWwjIrmeot2W5IZf7yjtxx7w7yo2awOx+zVHSdLxhrXobONSx1CRYQouP1f/A1T
 UFJzM1dswbwub2w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Running retsnoop on a kernel with GIC priority masking and
CONFIG_ARM64_DEBUG_PRIORITY_MASKING=y trips the ICC_PMR_EL1 sanity check
in __pmr_local_irq_disable():

     WARNING: ./arch/arm64/include/asm/irqflags.h:63 at arm64_exit_to_kernel_mode+0xb8/0xc0, CPU#40: retsnoop/31805
     CPU: 40 UID: 0 PID: 31805 Comm: retsnoop Not tainted 7.2.0-rc6-next-20260805 #7 PREEMPTLAZY
     pstate: 234013c9 (nzCv DAIF +PAN -UAO +TCO +DIT +SSBS BTYPE=--)
     pc : arm64_exit_to_kernel_mode (arch/arm64/kernel/entry-common.c:63)
     lr : el1_abort (arch/arm64/kernel/entry-common.c:323)
     pmr: 000000f0
     Call trace:
D)    arm64_exit_to_kernel_mode (arch/arm64/kernel/entry-common.c:63) (P)
      el1_abort (arch/arm64/kernel/entry-common.c:323)
      el1h_64_sync_handler (arch/arm64/kernel/entry-common.c:449)
C)    el1h_64_sync (arch/arm64/kernel/entry.S:589)
      copy_from_kernel_nofault (mm/maccess.c:52) (P)
      bpf_probe_read_kernel (kernel/trace/bpf_trace.c:268)
      bpf_prog_db21a1730c2407e5_calib_exit+0xf0/0x160
      trace_call_bpf (kernel/trace/bpf_trace.c:147)
      kretprobe_perf_func (kernel/trace/trace_kprobe.c:1750)
      kretprobe_dispatcher (kernel/trace/trace_kprobe.c:1875)
      __kretprobe_trampoline_handler (kernel/kprobes.c:2116)
      kretprobe_brk_handler (arch/arm64/kernel/probes/kprobes.c:422)
      call_el1_break_hook (arch/arm64/kernel/debug-monitors.c:244)
      do_el1_brk64 (arch/arm64/kernel/debug-monitors.c:266)
B)    el1_brk64 (arch/arm64/kernel/entry-common.c:427)
      el1h_64_sync_handler (arch/arm64/kernel/entry-common.c:481)
      el1h_64_sync (arch/arm64/kernel/entry.S:589)
      invoke_syscall (arch/arm64/kernel/syscall.c:49) (P)
      do_el0_svc (arch/arm64/kernel/syscall.c:140)
      el0_svc (arch/arm64/kernel/entry-common.c:736)
      el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:755)
A)    el0t_64_sync (arch/arm64/kernel/entry.S:594)

This is my understand of the current situation:

A) A task enters the kernel via a syscall.
	* PSTATE_I_SET becomes set on the live PMR
	* regs->PMR doesn't have PSR_I_SET set

B) A BRK fires at EL1 and that is what leaves the live PMR
   with PSR_I_SET.
	* At this stage PSTATE_I_SET is set on both on PMR and regs->PMR

C) A nested synchronous exception happens (Not sure why -- BPF related)
	* Now both the live PMR and regs->pmr have PSR_I_SET.

D) On the way out, local_irq_disable() → __pmr_local_irq_disable() warns.
   It detects that PMR is different than GIC_PRIO_IRQON and GIC_PRIO_IRQOFF,
   given live PMR and regs->PMR have PSTATE_I_SET ORed.

How to fix it? I don't know very well.

I am not certain that we want to have PSTATE_I_SET ever be sent to
regs->pstate. Do we ever need PSTATE_I_SET in regs->pstate?

In the current patch, I found that disabling IRQ in case it is disabled,
would solve the warning, but, this seems more a hack than a proper fix,
perhaps.

Fixes: ae654112eac0 ("arm64: entry: Use split preemption logic")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/arm64/kernel/entry-common.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index ceb4eb11232a6..fcce9ccd37108 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -55,7 +55,13 @@ static noinstr irqentry_state_t arm64_enter_from_kernel_mode(struct pt_regs *reg
 static void noinstr arm64_exit_to_kernel_mode(struct pt_regs *regs,
 					      irqentry_state_t state)
 {
-	local_irq_disable();
+	/*
+	 * Only irqentry_exit_to_kernel_mode_preempt() needs interrupts masked,
+	 * and it returns early when regs had them disabled. Skipping the
+	 * disable avoids clobbering a PMR the irqflags API does not expect.
+	 */
+	if (!regs_irqs_disabled(regs))
+		local_irq_disable();
 	irqentry_exit_to_kernel_mode_preempt(regs, state);
 	local_daif_mask();
 	mte_check_tfsr_exit();

---
base-commit: ea2bff00da89d7767d677bb68470130ba96f4928
change-id: 20260807-arm64_fix-47cad8fb6323

Best regards,
--  
Breno Leitao <leitao@debian.org>

