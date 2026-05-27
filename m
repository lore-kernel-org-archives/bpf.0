Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAA336495D;
	Wed, 27 May 2026 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909175; cv=none; b=LfL+GpXRxwFgZiII5zhqzVqNTPs7BpxaB0XUSxRG4gYfxfqPAui89fGzqlw4uuBRhTqDOujw5q4F309JJKKebwLHOaMGmEufxSRc0gKTBGcgcyyzgwwQqrY5pl1SvA95PY6M9j9pm+ueKUj/T0m6JIyt9QiS8u9jeu7OpMtPVwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909175; c=relaxed/simple;
	bh=OMBhp36SGhBUxYsENPfb9uF3VzY8cW8Q8Xw5p9ehcs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XkcA2/lklmofWjMOwpaxrQDC7Zz5T+It8dFbl8ZlTXbtOopJDygu3Jmv6h5/J2Z3E6U7r8RwXXeH6b+YhUAAQmvmSWiJ4E5W4bUGa78KkbSa9HjKatFWDy/3NgoYeRIH7I5M02VeTBKkvCghto/XeQYkAnqgp+hL72b91ROgfIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OffYYVPf; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OffYYVPf"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E07214E42D69;
	Wed, 27 May 2026 19:12:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9282A601A1;
	Wed, 27 May 2026 19:12:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1697A10888BE4;
	Wed, 27 May 2026 21:12:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779909163; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=pqol5pOcp80VinncolPKrRnV5MzpAOgtnDii24qMsFA=;
	b=OffYYVPfGFCF2dx9rYcIraiIMq+j7bOIll6Qp7FRxkUrDxdIt410u8733cY+NqOiejfA0H
	1uAeQI6/4IFZs8Zcv+kM6tsLUGlqD49XqYMd25HLACFjPIBLJQMC3s7FihDKpTSWXO7Kv8
	13ar0VGPk+K9c6lIwHgSRP0Qv9+da1ZagwHopr5Bptzw9oFKGmvtsSVEDo37Rq7UJtfLsv
	5oYh9c6E8JfwLKqk+7zGRU38il8afy96ie9wOwVP9yvoJrp2rFSoUrr26fRoQZtShFB34H
	Ezud/a+RvKwm2whD1hidf/fSnLKMd5QQrTMu6yhrCI2DAT7LTygHdoVYJqtKKw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 27 May 2026 21:12:31 +0200
Subject: [PATCH bpf-next] x86/ftrace: relocate %rip-relative percpu refs in
 dynamic trampolines
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260527-fix_call_depth_in_trampoline-v1-1-1c1abc8ae310@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM4QrCIBSG4VsZ53eCGVurW4khenZsJ8yJ2hiM3
 fusfr58H88GmRJThnuzQaKFM8+hxvnUAE4mPEnwWBuUVJ1s1VU4XjUa7/VIsUyagy7JvOPsOZD
 opcW2u10k9g4qERPV/49/gI1OBFoLDP8lf+yLsHx12PcDDo4qhYoAAAA=
X-Change-ID: 20260527-fix_call_depth_in_trampoline-80bc56930c8f
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 ebpf@linuxfoundation.org, Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

With CONFIG_CALL_DEPTH_TRACKING enabled on an x86 retbleed-affected
platform (eg: Skylake), with retbleed=stuff, registering a dynamic
ftrace trampoline crashes on the first call into the traced function:

  [    9.630365] BUG: unable to handle page fault for address: ffff88817ae18880
  [    9.630365] #PF: supervisor write access in kernel mode
  [    9.630365] #PF: error_code(0x0002) - not-present page
  [    9.630365] PGD 4b53067 P4D 4b53067 PUD 0
  [    9.630365] Oops: Oops: 0002 [#1] SMP PTI
  [    9.630365] CPU: 3 UID: 0 PID: 187 Comm: usleep Not tainted 7.0.10 #243 PREEMPT(full)
  [    9.630365] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.17.0-2-2 04/01/2014
  [    9.630365] RIP: 0010:0xffffffffc0400058
  [    9.630365] Code: 24 78 00 00 00 00 48 89 ea 48 89 54 24 20 48 8b b4 24 b8 00 00 00 48 8b bc 24 b0 00 00 00 48 89 bc 24 80 00 00 00 48 83 ef 05 <65> 48 c1 3d 1f a8 b6 02 05 48 8b 15 f6 00 00 00 4c 89 3c 24 4c 89
  [    9.630365] RSP: 0018:ffffc90000a3fe60 EFLAGS: 00010382
  [    9.630365] RAX: ffffffffffffffff RBX: ffffc90000a3ff58 RCX: 0000000000000000
  [    9.630365] RDX: ffffc90000a3ff48 RSI: ffffffff82198e40 RDI: ffffffff813f5654
  [    9.630365] RBP: ffffc90000a3ff48 R08: 0000000000000000 R09: 0000000000000000
  [    9.630365] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8881030d3780
  [    9.630365] R13: 00000000000000e6 R14: 0000000000000000 R15: 0000000000000000
  [    9.630365] FS:  00007f081d131740(0000) GS:ffff8881b7eae000(0000) knlGS:0000000000000000
  [    9.630365] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [    9.630365] CR2: ffff88817ae18880 CR3: 00000001033dc006 CR4: 00000000003706f0
  [    9.630365] Call Trace:
  [    9.630365]  <TASK>
  [    9.630365]  ? find_held_lock+0x2b/0x80
  [    9.630365]  ? exc_page_fault+0x74/0x220
  [    9.630365]  ? lock_release+0xe1/0x320
  [    9.630365]  ? __x64_sys_clock_nanosleep+0x9/0x1a0
  [    9.630365]  ? lockdep_hardirqs_on_prepare+0xd9/0x190
  [    9.630365]  ? trace_hardirqs_on+0x18/0x100
  [    9.630365]  __x64_sys_clock_nanosleep+0x9/0x1a0
  [    9.630365]  do_syscall_64+0x100/0x5f0
  [    9.630365]  ? exc_page_fault+0x1e0/0x220
  [    9.630365]  ? call_depth_return_thunk+0x2a/0xd0
  [    9.630365]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  [    9.630365] RIP: 0033:0x7f081d20ad83
  [    9.630365] Code: ff ff c3 0f 1f 40 00 83 ff 03 74 7b 83 ff 02 b8 fa ff ff ff 49 89 ca 0f 44 f8 80 3d c6 d2 10 00 00 74 14 b8 e6 00 00 00 0f 05 <f7> d8 c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec 28 48 89 54 24 10
  [    9.630365] RSP: 002b:00007ffd539e1328 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
  [    9.630365] RAX: ffffffffffffffda RBX: 0000000000000103 RCX: 00007f081d20ad83
  [    9.630365] RDX: 00007ffd539e1340 RSI: 0000000000000000 RDI: 0000000000000000
  [    9.630365] RBP: 00007ffd539e14f8 R08: 0000000000000000 R09: 0000000000000000
  [    9.630365] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
  [    9.630365] R13: 00007ffd539e1510 R14: 00007f081d370000 R15: 00005619c9d78338
  [    9.630365]  </TASK>
  [    9.630365] Modules linked in:
  [    9.630365] CR2: ffff88817ae18880
  [    9.630365] ---[ end trace 0000000000000000 ]---
  [    9.630365] RIP: 0010:0xffffffffc0400058
  [    9.630365] Code: 24 78 00 00 00 00 48 89 ea 48 89 54 24 20 48 8b b4 24 b8 00 00 00 48 8b bc 24 b0 00 00 00 48 89 bc 24 80 00 00 00 48 83 ef 05 <65> 48 c1 3d 1f a8 b6 02 05 48 8b 15 f6 00 00 00 4c 89 3c 24 4c 89
  [    9.630365] RSP: 0018:ffffc90000a3fe60 EFLAGS: 00010382
  [    9.630365] RAX: ffffffffffffffff RBX: ffffc90000a3ff58 RCX: 0000000000000000
  [    9.630365] RDX: ffffc90000a3ff48 RSI: ffffffff82198e40 RDI: ffffffff813f5654
  [    9.630365] RBP: ffffc90000a3ff48 R08: 0000000000000000 R09: 0000000000000000
  [    9.630365] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8881030d3780
  [    9.630365] R13: 00000000000000e6 R14: 0000000000000000 R15: 0000000000000000
  [    9.630365] FS:  00007f081d131740(0000) GS:ffff8881b7eae000(0000) knlGS:0000000000000000
  [    9.630365] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [    9.630365] CR2: ffff88817ae18880 CR3: 00000001033dc006 CR4: 00000000003706f0
  [    9.630365] Kernel panic - not syncing: Fatal exception

This small reproducer allows to easily trigger the crash:

  # echo 'p __x64_sys_clock_nanosleep' > /sys/kernel/tracing/kprobe_events
  # echo 1 > /sys/kernel/tracing/events/kprobes/p___x64_sys_clock_nanosleep_0/enable
  # usleep 1

Monitoring the crash under GDB points to the exact instruction in charge
of incrementing the call depth:

  sarq $5, %gs:__x86_call_depth(%rip)

This instruction matches the one inserted by the ftrace_regs_caller from
ftrace_64.S. This emitted code was likely working fine until the
introduction of commit 59bec00ace28 ("x86/percpu: Introduce
%rip-relative addressing to PER_CPU_VAR()"): it has made the call depth
accounting addressing relative to $rip, instead of being based on an
absolute address. As this code exact location depends on where the
trampoline lives in memory, the corresponding displacement needs to be
adjusted at runtime to actually correctly find the per-cpu
__x86_call_depth value, otherwise the targeted address is wrong, leading
to the page fault seen above.

Fix the %rip-relative displacement of the copied CALL_DEPTH_ACCOUNT
instruction (from ftrace_regs_caller) by calling
text_poke_apply_relocation(), as it is done for example by the x86 BPF
JIT compiler through x86_call_depth_emit_accounting(). This corrects
both CALL_DEPTH_ACCOUNT slots, in ftrace_caller and ftrace_regs_caller.

Fixes: 59bec00ace28 ("x86/percpu: Introduce %rip-relative addressing to PER_CPU_VAR()")
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 arch/x86/kernel/ftrace.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 0543b57f54ee..357df1b2922c 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -375,6 +375,13 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 			goto fail;
 	}
 
+	/*
+	 * Generated trampoline may contain rip-relative addressing which
+	 * displacement needs to be fixed
+	 */
+	text_poke_apply_relocation(trampoline, trampoline, size,
+				   (void *)start_offset, size);
+
 	/*
 	 * The address of the ftrace_ops that is used for this trampoline
 	 * is stored at the end of the trampoline. This will be used to

---
base-commit: aef70d0806e39b83f1fbecc32c72cc328751292a
change-id: 20260527-fix_call_depth_in_trampoline-80bc56930c8f

Best regards,
--  
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

