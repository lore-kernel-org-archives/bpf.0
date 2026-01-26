Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0208F2E2DFB;
	Mon, 26 Jan 2026 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769462352; cv=none; b=cHfjZ61Czfbg4cI7r7HpzUIe/55emkZdYhnglTozg0K1VwTNBEuUuKN8mXZ+3C5ScQbUHUpRCLK4gp+KlQfoHMIEwdQ6aVEnUuSJPrY82upIh7iOWMoYcKi6miqN3NWIjgJZT4kOHlVHfL7RzSV8pOqMYbGph8pqNZWzrQNBvi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769462352; c=relaxed/simple;
	bh=OPXYGIb4iSKw+NG+q/gcBaDARKqPqG+hEsi0CPFQZ2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svMoAZtsHyYTv4VAWto+qPVM/gSvT7RMiZ01RA4Tm1ef0AgGBhvMSo3PMX3J0/bG7s4XrVdsXzdeejaxNEzDK2gpt457GUaX8yBqW/vkI6Ft0c5d1gOYmKYUVlEIkz16GMZo971WV0/bLsbvCG4nKeGz4tmHnOnoaDWfpovWJok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZvEcfCC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZvEcfCC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB460C116C6;
	Mon, 26 Jan 2026 21:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769462351;
	bh=OPXYGIb4iSKw+NG+q/gcBaDARKqPqG+hEsi0CPFQZ2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZvEcfCC/L2uQa+HBTc+djb/Vrza0s9zEOLo/ZNThLv3N5q+xuQA1+pZADp/nWrKT
	 vT3d9Ks7uGbMr55mza2SIbxV1oJuxh4pZj9TqTfbyMRdVAC1eHM7HskJOPtOIm/XH9
	 PdJ8kMHOcuc11DlU569afLDX7964HhlEZve/o9bGmMhg/GCYz0uWpsWsnbpOoVoo3a
	 orKQkd8sxvH/yVBhyHB8b31FpK0WzNaEkbco1R0tEBwtFty907078Qx7EQYtK6vZdy
	 js0gz3JXomSPiEYoNcOTcTWVPMHIEiSwMUxuaXKuLip1zYH6Bq0vvn8tAdIibstrvW
	 crQ0jnQdPUy6A==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Mahe Tardy <mahe.tardy@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCHv2 bpf-next 2/6] x86/fgraph,bpf: Switch kprobe_multi program stack unwind to hw_regs path
Date: Mon, 26 Jan 2026 22:18:33 +0100
Message-ID: <20260126211837.472802-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126211837.472802-1-jolsa@kernel.org>
References: <20260126211837.472802-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Mahe reported missing function from stack trace on top of kprobe
multi program. The missing function is the very first one in the
stacktrace, the one that the bpf program is attached to.

  # bpftrace -e 'kprobe:__x64_sys_newuname* { print(kstack)}'
  Attaching 1 probe...

        do_syscall_64+134
        entry_SYSCALL_64_after_hwframe+118

  ('*' is used for kprobe_multi attachment)

The reason is that the previous change (the Fixes commit) fixed
stack unwind for tracepoint, but removed attached function address
from the stack trace on top of kprobe multi programs, which I also
overlooked in the related test (check following patch).

The tracepoint and kprobe_multi have different stack setup, but use
same unwind path. I think it's better to keep the previous change,
which fixed tracepoint unwind and instead change the kprobe multi
unwind as explained below.

The bpf program stack unwind calls perf_callchain_kernel for kernel
portion and it follows two unwind paths based on X86_EFLAGS_FIXED
bit in pt_regs.flags.

When the bit set we unwind from stack represented by pt_regs argument,
otherwise we unwind currently executed stack up to 'first_frame'
boundary.

The 'first_frame' value is taken from regs.rsp value, but ftrace_caller
and ftrace_regs_caller (ftrace trampoline) functions set the regs.rsp
to the previous stack frame, so we skip the attached function entry.

If we switch kprobe_multi unwind to use the X86_EFLAGS_FIXED bit,
we set the start of the unwind to the attached function address.
As another benefit we also cut extra unwind cycles needed to reach
the 'first_frame' boundary.

The speedup can be measured with trigger bench for kprobe_multi
program and stacktrace support.

- trigger bench with stacktrace on current code:

        kprobe-multi   :     0.810 ± 0.001M/s
        kretprobe-multi:     0.808 ± 0.001M/s

- and with the fix:

        kprobe-multi   :     1.264 ± 0.001M/s
        kretprobe-multi:     1.401 ± 0.002M/s

With the fix, the entry probe stacktrace:

  # bpftrace -e 'kprobe:__x64_sys_newuname* { print(kstack)}'
  Attaching 1 probe...

        __x64_sys_newuname+9
        do_syscall_64+134
        entry_SYSCALL_64_after_hwframe+118

The return probe skips the attached function, because it's no longer
on the stack at the point of the unwind and this way is the same how
standard kretprobe works.

  # bpftrace -e 'kretprobe:__x64_sys_newuname* { print(kstack)}'
  Attaching 1 probe...

        do_syscall_64+134
        entry_SYSCALL_64_after_hwframe+118

Fixes: 6d08340d1e35 ("Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"")
Reported-by: Mahe Tardy <mahe.tardy@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/include/asm/ftrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index b08c95872eed..c56e1e63b893 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -57,7 +57,7 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
 }
 
 #define arch_ftrace_partial_regs(regs) do {	\
-	regs->flags &= ~X86_EFLAGS_FIXED;	\
+	regs->flags |= X86_EFLAGS_FIXED;	\
 	regs->cs = __KERNEL_CS;			\
 } while (0)
 
-- 
2.52.0

