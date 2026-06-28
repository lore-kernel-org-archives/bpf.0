Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46347204F8B
	for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782634655; cv=none; b=sebDZA4fX9DEzVLJHT6zHmxo98xRJdh+XRmqtUqZTqe4QjEYvEq7JRM8UmuqTddIQD9fI5mUWAbvTjrcVDujM8fE9sR24R3Sv5X94bz7V5Uzz/YRyGvXg4yNjzsyGbnHVmUXmI0ei4/NTFOeSZ1WPiqQNf5nl/2yUy5BEnl4rfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782634655; c=relaxed/simple;
	bh=8oz1uGZk3lbQ9sRGCHA97Ci5HM6VCopXGCtIAJIYbsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXX9TnthVSt8RjM0t65EAoL6z5zdOG0gwqKWRtFytW4Fs1al7g+yYHP6xwNwh1zmSnxXIFtW7Ix/j8qyxDZpXWXXabQOTYs73/Fn5MddM7eg9HVutvJiukPEFPGmWju256qH9WAaSML9JROsiPKYPHvV7AtlqwwKgYQITTvrBJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIjUqGbk; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIjUqGbk"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c85c531d4a9so926162a12.2
        for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 01:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782634653; x=1783239453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fS2yJRct07pRe6n4SB8fXurYRNSLUTRVGluVVDIlUMc=;
        b=nIjUqGbkF4L/V02HTSBd/YbDPQxBntd5OnlM/dEuuuNxRoHgHJiufElmjdWuhp1Xhn
         WheTuffoFr9vg5riykBVjQlGCqCTzlDHln3w3KmHlPUVR8q98QpkMcnZDFdgUmwE/FET
         CAHf+QBKzT6ku6F5M4Kvin3cFwGPGgJGZhKze6U9fNdk2MmOT5g1+vphG6TJLJbk5lMr
         xxR2oXsPvsIAt6BmYIeFpG4UBIRcx8XjiW3J/fy7i3XgkCmmisFAaNzIhlbDivxanQQC
         PZHkkCGNbN7WfAOfvcgyMGLW3Aeoe1uvB7tduHblXjpQIYN/+KCmoete0C0fbfP/zk/7
         KpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782634653; x=1783239453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fS2yJRct07pRe6n4SB8fXurYRNSLUTRVGluVVDIlUMc=;
        b=RKKBUD1jggp7w81mXi4yUJ9fQGVuZ0bQmfIOkhbokku9BdvTli1y/wu7eg9aLvGikm
         0TK3gtZ/kLWZ6gPy/LxUeqSYY3Npo+Zsw4jMdI8V2niw5PBYPE0OPxNSfk0PwVyHx35W
         l+fn4GhwfnmvE+P03YApt1rfZz+2bYdt4Ze08wFpRzWlQGmyCoeYaf+dLloQcl4T/zKa
         r+FAUt0wTVcI5xnIAJ040O8I7MNWee8CZkeHTwGW9hZu23HD09rQH/DhAAusTt1UPfmb
         5nEgIaoaLn4OZNf+xKDuvJGX0+ETYzitLqVGKPMhY2gxmX4aIW3pBA3iFZV1OCWgSAf0
         tiRg==
X-Forwarded-Encrypted: i=1; AFNElJ/4t14KYWPotsspovOzBKT+9QiR4trYjISWxc3otXpUref5Icbmch0ik9uAK06+X2//Qp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdwBt03+wWJ4UX36uCR2fkp6PxZABe+dHzpoW48N5PquKciVay
	p3VB0w8Ts0MFwHFGVPQkSuTP8B/16/TPDYwUi3UR/DTDbYlTif2gwdKA
X-Gm-Gg: AfdE7ck41IXPpb2H83BodbuUmI8hnUVYYCIcbRfh1bL7D6T0M5grRfMlIboL8411svB
	UdSzWey6r+KvfnNvW0cJHB9LIjazXWgHwwjdToqxXZz8VScEEiHsh7yT8fKboiIbZOF2c2O7U7m
	TEMCPpkdRfx5mA3XQpi3ZqpuTIJkFWXiPj8OS8lbuuS+jFQE0+PuT17uDjYbp+Tk12+WHHhNCNf
	YcwzkX0kSp4+1p86+J5TJY+ptQ0ld4gtkdA+87Gie5QMET4CB8SsrA5Yxr4D7JfaJmAVGf/YPkT
	E6NPCVleryK8SJU1ROdqicXxYqsFJUs4P8oNgdYUzSoNEJa5AlDvvwTE7rh4CCFZBM4zx40ojZ9
	p4cIW7SHoLF1qK5QQ5Ak1pNOyBzpIAxof+/LswwnsrGIGPwxqEty+Q8ke9EH9T6RQahvsnta0vg
	4A6rIf1d55dXvEhtbRwrKhXxFmr18m7+kqpinfAHGD8vU+92M+SW4Xohg=
X-Received: by 2002:a05:6a20:7289:b0:3bf:82b4:4b47 with SMTP id adf61e73a8af0-3bf82b44e32mr2761238637.18.1782634653395;
        Sun, 28 Jun 2026 01:17:33 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:3b4a:8aa::dd:15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92bd55985asm6020434a12.31.2026.06.28.01.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 01:17:33 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	bjorn@kernel.org,
	pulehui@huawei.com
Cc: alex@ghiti.fr,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	puranjay@kernel.org,
	shuah@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [PATCH bpf-next v2 1/3] riscv: stacktrace: Implement arch_bpf_stack_walk() for BPF
Date: Sun, 28 Jun 2026 13:47:08 +0530
Message-ID: <20260628081710.113333-2-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628081710.113333-1-varunrmallya@gmail.com>
References: <20260628081710.113333-1-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be used by bpf_throw() to unwind till the program marked as
exception boundary and run the callback with the stack of the main
program.
This is required for supporting BPF exceptions on RISC-V.
This depends on the frame pointer unwinder, so it is only built under
CONFIG_FRAME_POINTER, else falls back to the weak no-op.

Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
Reviewed-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/kernel/stacktrace.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index c7555447149b..64929381bb30 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/filter.h>
 #include <linux/kallsyms.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
@@ -102,6 +103,36 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 	}
 }
 
+void notrace arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp),
+				 void *cookie)
+{
+	unsigned long fp, sp, pc;
+	int graph_idx = 0;
+
+	fp = (unsigned long)__builtin_frame_address(0);
+	sp = current_stack_pointer;
+	pc = (unsigned long)arch_bpf_stack_walk;
+
+	for (;;) {
+		struct stackframe *frame;
+
+		if (unlikely(!__kernel_text_address(pc)))
+			break;
+		/* pc belongs to the function whose frame pointer is fp */
+		if (!consume_fn(cookie, pc, sp, fp))
+			break;
+		if (unlikely(!fp_is_valid(fp, sp)))
+			break;
+
+		frame = (struct stackframe *)fp - 1;
+		sp = fp;
+		fp = READ_ONCE_TASK_STACK(current, frame->fp);
+		pc = READ_ONCE_TASK_STACK(current, frame->ra);
+		pc = ftrace_graph_ret_addr(current, &graph_idx, pc,
+					   &frame->ra);
+	}
+}
+
 #else /* !CONFIG_FRAME_POINTER */
 
 void notrace walk_stackframe(struct task_struct *task,
-- 
2.54.0

