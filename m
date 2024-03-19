Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD3E7D401
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710844023; cv=none; b=AJCfE26xlD9y+s+cCe5ndiDkSxnSF+o3ZKcC98+NeR6BNB0Jf+W1ut5jnJOsYaaQDlE6sqxTRCA/4Ug9tWCi0q8/vAx+M14FWBGH37Kpj7aPZ9JnA6uhjv0TOKC2Y+b4zRDZvoIc+w2JBxjBSB+WyD8yDF3IwX0SB2logkO4NYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710844023; c=relaxed/simple;
	bh=JDBEgWxmv3lx9ZUJtA88SrYQaM6/7zfXZOtcpSZ+qjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCmZC0VGy8zDR8OSD9PMFID7EnHpjVh/NtactKmaVyUfob6N1Jqaycc8cCt8L5A+hCGedAw5WWlyHxGSRefmgWZHjIwtzsHthj97at/BiTWkeu1ZhxKnqs425/6u73S1RUE8gJ71LQlUysdJ5ZO/8RSjG4YRdm2oJ/7S2yIKhBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NNrCw8wq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNrCw8wq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710844020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WHrOefhxxy4qfibpmG156d30i339Q4R83fPgqzMYdFw=;
	b=NNrCw8wqrw3VJlpEe5KvO4GUsiNRWzkLu8LefBkUQ6Qz0bGnpi1lY5ibd0yx44sAugaTin
	EifBBoAnzY5FasI084ZHl0b0Ochp6uHxgFPkuenEvMXAbruzIRK44HsQIn8bSQBqf1IIi8
	hut0eGY3xzOtb3n4bXWopDp7DlKbb6I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-cYTWm71CPw-NzIhIFZPUiA-1; Tue,
 19 Mar 2024 06:26:54 -0400
X-MC-Unique: cYTWm71CPw-NzIhIFZPUiA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F413D29AB3E5;
	Tue, 19 Mar 2024 10:26:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.50])
	by smtp.corp.redhat.com (Postfix) with SMTP id 1BA9417A90;
	Tue, 19 Mar 2024 10:26:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 19 Mar 2024 11:25:31 +0100 (CET)
Date: Tue, 19 Mar 2024 11:25:24 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: [PATCH RFC bpf-next 4/3] uprobe: ensure sys_uretprobe uses sysret
Message-ID: <20240319102523.GC20287@redhat.com>
References: <20240318093139.293497-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318093139.293497-1-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Obviously not for inclusion yet ;) untested, lacks the comments, and I am not
sure it makes sense.

But I am wondering if this change can speedup uretprobes a bit more. Any chance
you can test it?

With 1/3 sys_uretprobe() changes regs->r11/cx, this is correct but implies iret.
See the /* SYSRET requires RCX == RIP and R11 == EFLAGS */ code in do_syscall_64().

With this patch uretprobe_syscall_entry restores rcx/r11 itself and does retq,
sys_uretprobe() needs to hijack regs->ip after uprobe_handle_trampoline() to
make it possible.

Comments?

Oleg.
---

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 069371e86180..b99f1d80a8c8 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -319,6 +319,9 @@ asm (
 	"pushq %r11\n"
 	"movq $462, %rax\n"
 	"syscall\n"
+	"popq %r11\n"
+	"popq %rcx\n"
+	"retq\n"
 	".global uretprobe_syscall_end\n"
 	"uretprobe_syscall_end:\n"
 	".popsection\n"
@@ -336,23 +339,20 @@ void *arch_uprobe_trampoline(unsigned long *psize)
 SYSCALL_DEFINE0(uretprobe)
 {
 	struct pt_regs *regs = task_pt_regs(current);
-	unsigned long sregs[3], err;
+	unsigned long __user *ax_and_ret = (unsigned long __user *)regs->sp + 2;
+	unsigned long ip, err;
 
-	/*
-	 * We set rax and syscall itself changes rcx and r11, so the syscall
-	 * trampoline saves their original values on stack. We need to read
-	 * them and set original register values and fix the rsp pointer back.
-	 */
-	err = copy_from_user((void *) &sregs, (void *) regs->sp, sizeof(sregs));
-	WARN_ON_ONCE(err);
-
-	regs->r11 = sregs[0];
-	regs->cx = sregs[1];
-	regs->ax = sregs[2];
+	ip = regs->ip;
 	regs->orig_ax = -1;
-	regs->sp += sizeof(sregs);
+	err = get_user(regs->ax, ax_and_ret);
+	WARN_ON_ONCE(err);
 
 	uprobe_handle_trampoline(regs);
+
+	err = put_user(regs->ip, ax_and_ret);
+	WARN_ON_ONCE(err);
+	regs->ip = ip;
+
 	return regs->ax;
 }
 

