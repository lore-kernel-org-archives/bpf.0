Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7159C2DEA6B;
	Thu, 29 Jan 2026 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769647840; cv=none; b=YkN33KBTNbLlVmQW9Tl6UQZq7WPdj1uaPRjYX1e0DnFJSQuJq3s6zaLERntamLi310+0YMHJlIRO7qoX8GvrkymwNCHkZcBIhBsISvTbUmFy541lOXdtt44anRK4OPbuRJc5jLLaiwSOmfVki4RnpxOr1wR9xf7Ayng2kE1Qcuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769647840; c=relaxed/simple;
	bh=CJRMCzrnLuyYZ++FHBMD9+P3uHEYuJe/NBsshsqugWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=choJ4CuqVVjPWw6RMoLlBXawX9Ift0zNkx2hBqLp99u6hSpDvb6iewNmOwjSmkg+XoNqRm+p7h5xa4cnBeqRqytNzedAJIzMouOtEBiCt2WZfZ4TGFtYmzS8XCpXZLobGGcFOc/KmCQRYiqARYYjI+UGHf6EXBtFC9IkM1y/pgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id AA5911B14CA;
	Thu, 29 Jan 2026 00:50:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 6730020012;
	Thu, 29 Jan 2026 00:50:33 +0000 (UTC)
Date: Wed, 28 Jan 2026 19:50:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Mahe Tardy <mahe.tardy@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org, Yonghong Song
 <yhs@fb.com>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko
 <andrii@kernel.org>
Subject: Re: [PATCHv2 bpf-next 2/6] x86/fgraph,bpf: Switch kprobe_multi
 program stack unwind to hw_regs path
Message-ID: <20260128195043.4ac5187f@gandalf.local.home>
In-Reply-To: <20260126211837.472802-3-jolsa@kernel.org>
References: <20260126211837.472802-1-jolsa@kernel.org>
	<20260126211837.472802-3-jolsa@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6730020012
X-Stat-Signature: eesqx6cdcebfafgrm9fgoeonfdcso36w
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/R9v32MNDW0xNNrvfM5B0fBvffkSOfThI=
X-HE-Tag: 1769647833-345789
X-HE-Meta: U2FsdGVkX18u271zeS/+bFkUd6P07QbScJLBXEvsxw6yIueB4cIP4Gp1ueHntkHj5r3kZZych1+9LvUk2hp19a3DKF9wyesv/OzlrrOVYgRTiHfRCjDU+u+K0ZYXeszkIw2qU04VAVmdeCi7wc2ssuEvrh/XSlLg40adgz7hbYfq+7MU0d7JrnnqSP056VaLT2/ESJHKxH9C1haEveUKMPLgGVO5+j4W3pHOdQ9Bo7NineLDzvrh/8Qcu8jcvp0Rpj3byJDkfcOwE+ldvJeyGV0VUUdU7WUJ9h8y7SLHammcB4qMkCBabIB+YA25EcuPfBSAjQentsvdA59H8Zk5HGYhRwppnTelEp1/+jVIZQrK/stNgMls3FFBJUHN21EQC8wSMgQi0ImBU6HAPzsHAKNA5A4NlaVWa0Y5gJ8xB/M=

On Mon, 26 Jan 2026 22:18:33 +0100
Jiri Olsa <jolsa@kernel.org> wrote:

> Mahe reported missing function from stack trace on top of kprobe
> multi program. The missing function is the very first one in the
> stacktrace, the one that the bpf program is attached to.
>=20
>   # bpftrace -e 'kprobe:__x64_sys_newuname* { print(kstack)}'
>   Attaching 1 probe...
>=20
>         do_syscall_64+134
>         entry_SYSCALL_64_after_hwframe+118
>=20
>   ('*' is used for kprobe_multi attachment)
>=20
> The reason is that the previous change (the Fixes commit) fixed
> stack unwind for tracepoint, but removed attached function address
> from the stack trace on top of kprobe multi programs, which I also
> overlooked in the related test (check following patch).
>=20
> The tracepoint and kprobe_multi have different stack setup, but use
> same unwind path. I think it's better to keep the previous change,
> which fixed tracepoint unwind and instead change the kprobe multi
> unwind as explained below.
>=20
> The bpf program stack unwind calls perf_callchain_kernel for kernel
> portion and it follows two unwind paths based on X86_EFLAGS_FIXED
> bit in pt_regs.flags.
>=20
> When the bit set we unwind from stack represented by pt_regs argument,
> otherwise we unwind currently executed stack up to 'first_frame'
> boundary.
>=20
> The 'first_frame' value is taken from regs.rsp value, but ftrace_caller
> and ftrace_regs_caller (ftrace trampoline) functions set the regs.rsp
> to the previous stack frame, so we skip the attached function entry.
>=20
> If we switch kprobe_multi unwind to use the X86_EFLAGS_FIXED bit,
> we set the start of the unwind to the attached function address.
> As another benefit we also cut extra unwind cycles needed to reach
> the 'first_frame' boundary.
>=20
> The speedup can be measured with trigger bench for kprobe_multi
> program and stacktrace support.
>=20
> - trigger bench with stacktrace on current code:
>=20
>         kprobe-multi   :     0.810 =C2=B1 0.001M/s
>         kretprobe-multi:     0.808 =C2=B1 0.001M/s
>=20
> - and with the fix:
>=20
>         kprobe-multi   :     1.264 =C2=B1 0.001M/s
>         kretprobe-multi:     1.401 =C2=B1 0.002M/s
>=20
> With the fix, the entry probe stacktrace:
>=20
>   # bpftrace -e 'kprobe:__x64_sys_newuname* { print(kstack)}'
>   Attaching 1 probe...
>=20
>         __x64_sys_newuname+9
>         do_syscall_64+134
>         entry_SYSCALL_64_after_hwframe+118
>=20
> The return probe skips the attached function, because it's no longer
> on the stack at the point of the unwind and this way is the same how
> standard kretprobe works.
>=20
>   # bpftrace -e 'kretprobe:__x64_sys_newuname* { print(kstack)}'
>   Attaching 1 probe...
>=20
>         do_syscall_64+134
>         entry_SYSCALL_64_after_hwframe+118
>=20
> Fixes: 6d08340d1e35 ("Revert "perf/x86: Always store regs->ip in perf_cal=
lchain_kernel()"")
> Reported-by: Mahe Tardy <mahe.tardy@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/include/asm/ftrace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index b08c95872eed..c56e1e63b893 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

(it passed all my tests too)

-- Steve
