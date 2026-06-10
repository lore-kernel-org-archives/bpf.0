Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB01E370D69
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 04:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781066597; cv=none; b=MhDSelkWZlM5a6IZIXMwigfPFTvQugYD4xf1r8YyjEc1UHnoj92tFqNPEzsvcVzBizTciqdaWItzxmlG4cA33Jv9wZWdIUzkQDT3z4W3oJx4h0Qj53F9nhqA0exGFYsf2Ry4Mioufpu/rJlwbz4p3jT9yAvvnTn4k0xLyjvH+5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781066597; c=relaxed/simple;
	bh=YugiFesYD2nWr2HkyCAvq+z4fvPBJPssyXkaIQEWn8o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GmCEoSyz2j7pzt2rCBaq99+MUqs4dhly8fIrvdW49Ud6zcAZ/TsTwizKbtnHvsC+Vanwdsckf1OGmUIQXq2ykPYPhDdfH5nMaVs2GlsRpxSwjKdrJpXervRwCfrqudIKsb1godpi84JYdnPMrwDofkpLYFVDbOMLeuMV1fSnWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net; spf=pass smtp.mailfrom=craftyguy.net; dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b=HjIzng/P; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b="HjIzng/P"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=craftyguy.net;
	s=key1; t=1781066582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xrfCOYnawNby/+6P5H5Tb/h+uk8XWKJB+gnkB26erd0=;
	b=HjIzng/PovlFPzFjQIm3WEnGb3lIqEqOpN83SRyVl11T0Q6qhZZ2c665qUk+FpBzWNZSCc
	p6lBKhYhWMqi7mtmsb6CFySW9JvTlQuicxxP66QwLuyhv3qrXdD6bzXqCPDqFDR0EQ1vBy
	pW41C5Y3GEHBAlb7lN4Tp59P/gSQLV1yZ50g8UMnARlIjc8KfJEdqIbMbsoYx8zlf7CHuI
	eQbW5a7+UgkBsVhGWRYdkLhj0kktK9pCr3D8bO40VCgXIPJo6kKyMJLSlH/AtOPtfF1xH/
	k4fSQ0fQvKyI2IhqM+t++UnxBSJtse5s3E9NzdXFC5FaQ6gYYA33YAtMoOBTqA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 21:42:56 -0700
Message-Id: <DJ53EPMYFXVH.3I4BP5PF8XJ9G@craftyguy.net>
Cc: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <llvm@lists.linux.dev>,
 <bpf@vger.kernel.org>, "Florent Revest" <revest@chromium.org>, "Puranjay
 Mohan" <puranjay@kernel.org>, "Xu Kuohai" <xukuohai@huawei.com>
Subject: Re: [PATCH 0/2] arm64: ftrace: support DIRECT_CALLS without
 CALL_OPS
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Clayton Craft" <clayton@craftyguy.net>
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Nathan
 Chancellor" <nathan@kernel.org>, "Nick Desaulniers"
 <nick.desaulniers+lkml@gmail.com>, "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>
References: <20260609-arm64-ftrace-direct-calls-v1-0-4a46f266697f@linux.dev>
In-Reply-To: <20260609-arm64-ftrace-direct-calls-v1-0-4a46f266697f@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon Jun 8, 2026 at 10:19 PM PDT, Jose Fernandez (Anthropic) wrote:
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
> ---
> Jose Fernandez (Anthropic) (2):
>       arm64: ftrace: prepare ftrace_modify_call() for use without CALL_OP=
S
>       arm64: ftrace: allow DIRECT_CALLS without CALL_OPS
>
>  arch/arm64/Kconfig         | 2 +-
>  arch/arm64/kernel/ftrace.c | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> ---
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> change-id: 20260607-arm64-ftrace-direct-calls-152230ef7077
>
> Best regards,
> --
> Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

Thanks for fixing this! I gave it a try on an aarch64 laptop (macbook m2)
using kernel 7.0.11 with CFI=3Dy && DEBUG_INFO_BTF=3Dy, built with clang. A=
FAIK it
seems to work great, I am able to finally run systemd with BPF support (e.g=
.,
unprivileged nspawn works now)

Tested-by: Clayton Craft <craftyguy@postmarketos.org>

