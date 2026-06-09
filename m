Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9D939D6FA
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998647; cv=none; b=UwarBSthpWkbjImZyOqW8sN0QK7YFvavApmX1ZvH5kDLtGyL3b+VL1zy121TKDa5V2P10VSf/+04ZxxgsOwn9UJriHRnpsv/scgwGbdAXREPgtBFJAZkvgTZboOwzOc8Q0H1e+caJZBsplaFU6mJHqqr+kr3F7pOMn3DS5nlz6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998647; c=relaxed/simple;
	bh=LVsisOh2t/3BY9u48eKv6sHKecTbrxVyTPE/nrEqEDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBvPMbZjC8mZkGarO77Iu4SZ55C6sYOuNkVGOWI4EULnq+AwgMna4r2BbfnYC9+lFPZoArPW+Fy0bsItW6K9ZUpCkC0PSrbTsWhI3gcq46djHBD4RBSdXdPTuOmEJRJY9o2mOq6I/bYn1FM8ICPRDhIStxp8v1+60Pj7xiTty+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omqD8ec4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omqD8ec4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC1F1F0089A
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 09:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780998645;
	bh=LVsisOh2t/3BY9u48eKv6sHKecTbrxVyTPE/nrEqEDE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=omqD8ec4RwhqP75Swo+2L1XAYZsWpuWBoMBChLXYdR8kYizp0aLPgiic5S64rpMmk
	 vb9iiZRLGgGyAFPj5RuQMpZZTb2eaZs29sOweS0GIp33uyAiyd5eb+Ztgfny7mctrC
	 bNwBiIBwmzDof78RMjqPSG+5SC9BKZntXnazkz8JxepMnr0huQvNNZSzWTh0riXf0D
	 GkQDMjqq4ZXWeg3veFYUtg+j1toh+4hFnrvb8WXX6LJu+bVCdseEUM4wtZH2HNdCnt
	 SZYD+BjwnVx38RcvcS8nr6K/kHbHa08B59TF7yWJnMn1M0EglAuhQ4ZsOjLJPm5bBe
	 ycrjhqeLYPTKQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bef8b97655eso998342266b.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 02:50:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9U+7plpuhfQVoPfVurgzsxqS3rUx31dujvR/xBYoTABqRt9M4u8fXjuswE79Jd9OuIyjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt8YAACYafzQLhaGB8xQkMjFSX5I2Fr7haYvrlfUGidtZTp7gn
	ZPN8jxAfalm1ncpxCkugAIABhNdyDzxxTfyS5mPBpTXOolvzt2LHCI/3g5cmpAtQNgNR3u/srVz
	qIPqOrOWX25bkTOO+g/PKlW9YRzffr3o=
X-Received: by 2002:a17:907:60cd:b0:bed:f8a3:23a0 with SMTP id
 a640c23a62f3a-bf3a8a0ce48mr751853766b.25.1780998643858; Tue, 09 Jun 2026
 02:50:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609-arm64-ftrace-direct-calls-v1-0-4a46f266697f@linux.dev>
In-Reply-To: <20260609-arm64-ftrace-direct-calls-v1-0-4a46f266697f@linux.dev>
From: Puranjay Mohan <puranjay@kernel.org>
Date: Tue, 9 Jun 2026 10:50:28 +0100
X-Gmail-Original-Message-ID: <CANk7y0jKE1Mq5FQD1M9+CUQt-+G2EQN7hCvUCQJE=hFmsr+o0A@mail.gmail.com>
X-Gm-Features: AVVi8CeSrRlbGA71o_97ek791-ypZvvhb-lg2xrkdnUMSr3_kQBTCBTCfOxMfQY
Message-ID: <CANk7y0jKE1Mq5FQD1M9+CUQt-+G2EQN7hCvUCQJE=hFmsr+o0A@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: ftrace: support DIRECT_CALLS without CALL_OPS
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, 
	Florent Revest <revest@chromium.org>, Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 6:19=E2=80=AFAM Jose Fernandez (Anthropic)
<jose.fernandez@linux.dev> wrote:
>
> On arm64, HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS is currently selected
> only when DYNAMIC_FTRACE_WITH_CALL_OPS is available. CALL_OPS, in
> turn, is mutually exclusive with kCFI: the pre-function NOPs it needs
> would change the offset of the pre-function type hash (see
> baaf553d3bc3 ("arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS")),
> and the compiler support needed to reconcile the two does not exist
> yet.
>
> The result is that a CONFIG_CFI=3Dy arm64 kernel has no
> ftrace direct calls at all, so register_fentry() fails with -ENOTSUPP
> and no BPF trampoline can attach: fentry/fexit, fmod_ret and BPF LSM
> programs are all unavailable. Deployments that want both kCFI
> hardening and BPF-based security monitoring currently have to give
> one of them up. systemd's bpf-restrict-fs feature hits this today:
> https://lore.kernel.org/all/20250610232418.GA3544567@ax162/
>
> CALL_OPS is an optimization for direct calls, not a dependency.
> In-BL-range trampolines are reached by a direct branch without
> consulting the ops pointer, and out-of-range trampolines already
> fall back to ftrace_caller, where the DIRECT_CALLS machinery
> (call_direct_funcs() storing the trampoline in ftrace_regs, the
> ftrace_caller tail-call) is gated on DIRECT_CALLS alone. s390 and
> loongarch ship HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS this way,
> without having CALL_OPS at all.
>
> Patch 1 prepares ftrace_modify_call() to build without CALL_OPS by
> widening its #ifdef and using the existing ftrace_rec_update_ops()
> wrapper (no functional change for current configurations). Patch 2
> drops the CALL_OPS requirement from the DIRECT_CALLS select.
>
> Configurations that keep CALL_OPS (clang !CFI, and GCC without
> CC_OPTIMIZE_FOR_SIZE) are unchanged. We verified this: in an arm64
> clang build, every object file is byte-identical before and after
> the series except ftrace.o itself, and its disassembly is identical.
> CFI builds (and GCC -Os builds) gain working direct calls, with
> out-of-range attachments taking the ftrace_caller dispatch path
> instead of the per-callsite fast path.
>
> We tested on a 6.18.y-based kernel and on this base with clang
> kCFI builds (CONFIG_CFI=3Dy, enforcing) under qemu (TCG, and KVM on an
> arm64 host) and on GB200-based arm64 hardware: fentry/fexit, fmod_ret
> and BPF LSM programs load, attach and execute; the ftrace-direct
> sample modules (including both modify samples, exercising
> ftrace_modify_call()) run cleanly; no CFI violations observed. The
> fentry_test, fexit_test, fentry_fexit, fexit_sleep, fexit_stress,
> modify_return, tracing_struct, lsm and trampoline_count selftests and
> the ftrace direct-call selftests (test.d/direct) pass on the new
> configuration with results identical to a CALL_OPS kernel built from
> the same tree, and a broader test_progs sweep showed no differences
> attributable to this series. Without the series, all of the above
> fail at attach time with -ENOTSUPP.
>
> riscv has the same gap (its DIRECT_CALLS select also requires
> CALL_OPS, and its CALL_OPS is likewise !CFI); if this approach is
> acceptable for arm64 we can follow up there.
>

It looks correct to me and should work.

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
