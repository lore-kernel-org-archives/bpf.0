Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D6643B4BF;
	Fri, 24 Jul 2026 19:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921889; cv=none; b=C/d8I3FdOiZck/CNguuHDJLyIq26EhtXhBv4ke6HSbQeneNch/U0L3HUU2yf0wjoC8kVdMZAJjGBQ9pxCIDAhTdRshi6ZmngCuk9S6wK5BGNqQDVtKrw8FYHrStIcyzBR5iCG/pNRY+RHo4xgQ3/IAKo+Ex3WHavNhoZ0F31Hes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921889; c=relaxed/simple;
	bh=pNSG58VVaprl3EhqCQ8RunQyPJsG26bPHdoCHjw7oec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SipHPo8q0PIJh5xpCqky9izteyZHGchnb3SrlLqbd5laAHUnWr3JEvSowWLnQg2sIz07j9ApXIVsSQWFcZJYetCW6bT9ZF9q86AsUFvwj9bNWWjbJVTDVdKryzqF9MEjyQYeZgBwyEPFjNkUgtjG7xMmfZaNpIxT2hl8o49RNTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0GtXkLz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0GtXkLz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9027C1F000E9;
	Fri, 24 Jul 2026 19:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784921887;
	bh=zDSNgvrN46Mh8+EbjqbSRln6do6ct55g+Nt1nrPXrw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=R0GtXkLzAIr2zrZrhJDigbTNwzY1XZnncdp0RpWcgoiCTUK3C3gyj3q9FlXbr5pbD
	 Sj0FJNviqxvD4Whiqfn0305REgTH1/KIkl9eEdoPaq8N1icEZbReDAi5ztUiClKFBG
	 72Ec+V0rlx28zSpmo7F7n5h9Q/j+G65p8lse5qL+qsYc77YPlKwJTDK4PWm78f2X4v
	 DLZ4OF23tyX1RSQ0goffVPk2CndnfBuQ7GBRqPn8AUMdzyDw5sY9QuvjMEcaBoa7uF
	 7wmsbUEgJyCbbX2clml/dI23R4Okf1d5WD8IE2y6g7IsLn9z9rkiYtd3BeCvbIs75s
	 xkkY9ABoeaVbQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Varun R Mallya <varunrmallya@gmail.com>, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, pulehui@huawei.com
Cc: alex@ghiti.fr, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 puranjay@kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, varunrmallya@gmail.com
Subject: Re: [PATCH bpf-next v3 0/6] Add BPF Exceptions support for RISC-V
In-Reply-To: <20260722140015.1982158-1-varunrmallya@gmail.com>
References: <20260722140015.1982158-1-varunrmallya@gmail.com>
Date: Fri, 24 Jul 2026 21:38:03 +0200
Message-ID: <87cxwcqiuc.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Varun R Mallya <varunrmallya@gmail.com> writes:

> This patchset aims to add BPF exceptions supports for riscv64 by
> implementing the arch_bpf_stack_walk function and then updating the
> prologue and epilogue for BPF JIT on riscv. Also,
> bpf_jit_supports_exceptions() returns true now so that the verifier does
> not reject programs containing BPF exceptions on riscv64.
>
> On riscv the unwinder used by arch_bpf_stack_walk() is the frame-pointer
> unwinder, so exception support is gated on CONFIG_FRAME_POINTER.
>
> In the prologue and epilogue of the RISC-V JIT, I saved the
> return address and then the frame-pointer according to [1]. Also,
> according to [2], s0 to s11 are callee saved registers, which is why a
> new array (rv_exception_csave_regs) has been created to save these
> registers which contains all the required registers along with the frame
> pointer as well as return address.

...

> Since all exception tests pass now, the denylist file has been removed
> as it is empty now.
>
> Changes in v1->v2:
> v1: https://lore.kernel.org/bpf/20260621144259.288135-1-varunrmallya@gmai=
l.com/
> - resolve the ftrace trampoline address with ftrace_graph_ret_addr()
>   inside arch_bpf_stack_walk()
> - Remove duplicated code in bpf_jit_build_prologue()
>
> Changes in v2->v3:
> v2: https://lore.kernel.org/bpf/20260628081710.113333-1-varunrmallya@gmai=
l.com/
> - extend walk_stackframe to use sp/fp similar to how arm64 does it. (Bj=
=C3=B6rn T=C3=B6pel)
> - refactor prologue/epilogue into helpers. (Bj=C3=B6rn T=C3=B6pel)
> - fix comments to make them netdev style.
> - save/restore the tail-call counter in the exception prologue/epilogue
> - exception_tail_call now passes since bpf2bpf+tailcall mixing landed [3]=
, so
>   drop the (now-empty) DENYLIST.riscv64
> - (!aux->exception_cb) has been simplified to only one condition (Pu Lehu=
i)

Varun!

Thanks for the rework. The overall structure is much better now, and the
main v2 comments around reusing the stack walker and splitting the
prologue/epilogue have been addressed!

I tried to make sense of Sashiko's reports as well...

Sashiko seems correct about sp being stale after crossing an exception
frame. We restore pc and fp from pt_regs, so sp should be restored from
there as well. Would you agree?

The full pt_regs should also be validated before dereferencing it...?

I *think* the instrumentation concern also looks valid. The new
stack-walk adapter callbacks should not be instrumentable.

I don't think the !CONFIG_FRAME_POINTER report is an exception-support
bug. Exceptions require a valid boundary frame pointer, so the current
gating looks correct.

Sashiko is also correct that deleting DENYLIST.riscv64 breaks the
documented selftest command. Please update the README or retain an empty
file.

Minor wording issue: ra is not callee-saved. Please say =E2=80=9CRA and the
callee-saved registers s0-s11.=E2=80=9D


Thanks,
Bj=C3=B6rn
