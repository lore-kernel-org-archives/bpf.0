Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F83B3E1200;
	Wed,  5 Aug 2026 07:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913664; cv=none; b=VsebJEY1VPx3G63FpFIRqThe+HvcKe9raR3pm0ssqUoTSE8Nh5BIoIyZb4f2/HMvU7bgsB9G7HosEi9h5ON6FcC55ig1TsnwCKV9P1AJBZOSmB8mBwIWldXJXFY4G25QROyJRrZ0iYWt1JIKnwtCA8tMJrYlvS1zbvn5EkO4eF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913664; c=relaxed/simple;
	bh=Myax3ICaCfHvuuA+MdnM9g68vUSuJvAwLLyjkMpToyU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U4UUadpOPTxMsSlniaRSMR3L/PgMHpSUYu6bPOxD5C70s7/cf14hh40RO6r33mz1V+PBhzNZbTDNLl+zBDMcYGexfLjqKa/eLjutt2G8Ckdob6Js/jC6XEAV2HyLE1Ibs9jAv3Jp0VBjHWar64txlYtUd0z1vdNrilJF6gGPD+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=M6OyBtSJ; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="M6OyBtSJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=giwccgl4kvfivgirqz4zgmgqbq.protonmail; t=1785913638; x=1786172838;
	bh=76T7YXpCcnUccWZ6WjLKZL7MNTS7wtBYlfMP+CvX2BI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=M6OyBtSJ7I/2abgXUM5LZyVacijpx2qBGt7y4Ri8wVXRUtV4K8k0YZ3I+DosRBf+H
	 wl+BmQnN3j9YxV42Y1pzGc53n8htSD+HDcykxAOFq4ZlXHEmEIS34kY07u/Ro0/ro7
	 YdfWisgTzSZ1V2+HFxoyrOmB385TTiJBJ+ybGjQcirOi/QBM/6fJcp4J3JGYE02Yi4
	 +IuPZ86Ui+vIxg+rZL6StCmHJv8J2emoG0iQsemd4cMdThnIoqm+XKshA7VaZVmOUh
	 EZuGMfROFy3CuOCO1Y4+55zQi+hd8CWRgdwsoU6eue7j+3SJiL0r6QbEd3bT+0FYaF
	 nea8D5iUi5NsA==
Date: Wed, 05 Aug 2026 07:07:10 +0000
To: NeilBrown <neil@brown.name>
From: quanyeyang <quanyeyang@proton.me>
Cc: Quanye Yang <quanyemostima@gmail.com>, Justin Suess <utilityemal77@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, syzbot+ef8d17bae14efb960935@syzkaller.appspotmail.com
Subject: =?utf-8?Q?=E5=9B=9E=E5=A4=8D=EF=BC=9A_Re:_[PATCH]_bpf:_disable_lockdep_while_running_BPF_on_lock=5Frelease?=
Message-ID: <46Fu_iB0xOxZXb0l5G6pslLArj7TrP_AOICffhfZKoviSn7zVUVVVSMfWaVBYNqt9RiCWWHhSAvlMc3RaJvRFSnvbV2EcBz9VUBQzb2wSkw=@proton.me>
In-Reply-To: <178588373680.3252194.4414470901360919775@noble.neil.brown.name>
References: <20260803-fix-lock-tracepoint-bpf-lockdep-v1-1-91fb7afb526a@gmail.com> <anEuaSqiCVsQ6I4P@zenbox> <178583246611.3252194.4318729338489544399@noble.neil.brown.name> <CABcBDJuznu=BgDhevsD6PybX8+6fcaO1xyTcuGuv8F_+MfeZoQ@mail.gmail.com> <178588373680.3252194.4414470901360919775@noble.neil.brown.name>
Feedback-ID: 206494642:user:proton
X-Pm-Message-ID: 5b0be336a668bf17b65cbba6ee7490592d97faa7
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 6:49=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> I don't think that detecting recursive acquisition is a scalable
> solution.  You'll keep finding new locks that you need to enhance.

Yes, it makes sense.

>
> If I step back a bit, it looks like TP-BPF (BPF attached to tracepoints)
> introduces a new execution context, similar to SOFTIRQ and HARDIRQ.
> i.e.  it is something that can start running at almost any point and
> blocks the currently running code until it completes.
> I suspect it would be good to handle it in a similar way.

Thanks for the detailed explanation.

>
> So I suggest adding a new
>   LOCKDEP_STATE(TP_BPF)
> to kernel/locking/lockdep_states.h, and teaching lockdep to understand
> it.  Then it could help avoid all these problems.
>
> An important part of this would be the ability to temporarily disable
> TP_BPF much as we can disable interrupts.  What happens at present if
> there is tracepoint that happens in BPF code, and a BPF handler is attach=
ed
> to that.  Does it get called recursively?
> Would there be a problem with disabling new TP_BPF handlers while TP_BPF
> code is running?  Maybe this is already done?

It's already partly done, but it differs by attach type.

The perf-event tracepoint path -- trace_call_bpf(), and the perf-overflow
(PMI) path bpf_overflow_handler() -- share a global per-CPU counter,
bpf_prog_active: while a BPF program is running on a CPU, any further
BPF on that CPU is skipped (the prog_array is re-entered only to bump
the miss counter). So a tracepoint firing inside BPF code does not
recurse there; the handler is dropped. That is already the "disable
TP_BPF while TP_BPF runs" behaviour, analogous to disabling interrupts.

The raw_tracepoint path is different: __bpf_trace_run() uses
bpf_prog_get_recursion_context(), which is per-program -- only the *same*
program is prevented from recursing; *different* programs can nest. So a
raw_tp handler can run nested inside another raw_tp handler on the same
CPU.

So the recursion/disabling mechanism exists, but it isn't uniform: the
perf path is already "disable-like", raw_tp is not. That asymmetry is
itself part of what makes the lockdep picture messy.

>
> Circling back the original patch to rhashtables that was proposed - had
> you said that you needed to use rhashtables in a different context
> similar to HARDIRQ or SOFTIRQ, then I think I would have had a different
> response.  That is a well-specified problem with well-understood
> solutions.
>
> I would likely be OK with making is possible for lockdep to see locks
> from different tables as different locks, because they need to be taken
> in different lockdep contexts.
>
> I would then see if the new lock_class_key could be declared in the
> rhashtable_params struct.  This is already passed around everywhere, so
> this would be much less intrusive.  We would have to use some cast to
> get rid of the 'const' attribute when passing the lock_class_key to
> lockdep, but I think that is justifiable.

On the per-table lock_class_key in rhashtable_params: that sounds right
to me. I'll rework the rhashtable patch so each table can declare its own
key in params -- framed as "different tables live in different lockdep
contexts" (not per-init-site, as in my first attempt) -- and resend.

Two small notes:
 - if the field is a `struct lock_class_key *` pointer, the params struct
   can stay const: lockdep writes to the pointed-to key, not the struct,
   so no cast-away-const is needed;
 - callers that don't set it would fall back to the shared class (current
   behaviour), so it's opt-in and doesn't churn existing users.

On LOCKDEP_STATE(TP_BPF): it reads as the more general fix, but it's a
larger change in the locking core and would need the recursion gate made
uniform across attach types first (raw_tp currently runs despite the
global gate). I'd lean toward starting with the per-table-key change for
the reported false positive and treating the TP_BPF-context modelling as
the longer-term direction -- happy to take guidance from you and the
locking folks on scope.

>
> NeilBrown
Note: Sending from an alternate address because Gmail is
temporarily rejecting my mailing-list replies.
Thanks,
quanyeyang
