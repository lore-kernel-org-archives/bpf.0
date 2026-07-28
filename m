Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A6B3A7F6F;
	Tue, 28 Jul 2026 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259910; cv=none; b=oOnZQG0Ky8HbGvs/t/bbap7f36+RGNq/udQ0zfUlte9/mpiWD/sfXHzei1n7gUDq58TwO4KrQWqLmCgM9C52VSyoq64P0l6TJXQJr17jfRGetGqM6dJNZDsjmuaQRG924km36OgdgbxI86gcK+i9vmOEFzFv5D+TfQ/qI8qlBJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259910; c=relaxed/simple;
	bh=KwxVOT9RanBvHZZjm9RuSigNIRCQICh1YKEM1MGk1YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9j4exG2rF/hsZ7gEMbzfutvoiECwofmEDgftBcjt6JuGZ6Wk2dc48N3hMZA44r7ywD8f6JFBT7AqB1nrcSg2Dxz/RjtQsaA1HZmwoyw2ZMu7cKexokQ8d67qwt9g6r6I3JASxjiFvAMDmi8qFs6aDj9TQNxiS1vzf8Uw4mYIvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NdB6N83X; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NdB6N83X"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B526169E;
	Tue, 28 Jul 2026 10:31:43 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 500643F763;
	Tue, 28 Jul 2026 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785259907; bh=KwxVOT9RanBvHZZjm9RuSigNIRCQICh1YKEM1MGk1YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NdB6N83X3iLpzBAs56YxTADvdNoNZXoS0zfJgLFb2XlYkQy2TH7DB2JXkyRnHUZXl
	 MpeXExUY6kB+w7GT0Op7HI0Bud9xBTrMwOuKLk0qVrWzTWhu2yK43hZw7aYkKKUMvq
	 LeqhuiBGAg5g3/XwD1qO7BaxvXDtzMHG5MRlXcs4=
Date: Tue, 28 Jul 2026 18:31:43 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
	bpf@vger.kernel.org, Florent Revest <revest@chromium.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huawei.com>
Subject: Re: [PATCH 0/2] arm64: ftrace: support DIRECT_CALLS without CALL_OPS
Message-ID: <amjnf5gz0xP5PTSB@J2N7QTR9R3>
References: <20260609-arm64-ftrace-direct-calls-v1-0-4a46f266697f@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-arm64-ftrace-direct-calls-v1-0-4a46f266697f@linux.dev>

On Tue, Jun 09, 2026 at 05:19:25AM +0000, Jose Fernandez (Anthropic) wrote:
> On arm64, HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS is currently selected
> only when DYNAMIC_FTRACE_WITH_CALL_OPS is available. CALL_OPS, in
> turn, is mutually exclusive with kCFI: the pre-function NOPs it needs
> would change the offset of the pre-function type hash (see
> baaf553d3bc3 ("arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS")),
> and the compiler support needed to reconcile the two does not exist
> yet.
> 
> The result is that a CONFIG_CFI=y arm64 kernel has no
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
> ftrace_caller tail-call) is gated on DIRECT_CALLS alone. 

It's true that this is not a strict functional dependency, but there is
a substantial performance cliff here.

With CALL_OPS we only fall back to the ftrace_ops_list_func() when there
are multiple ops associated with a given callsite. Where we have a
single ops for a callsite, if the direct call is out of range, the
ftrace caller will call trace_ops::direct_call.

Without CALL_OPS, if there are unrelated ops registered (attached to
difrerent callsites), the ftrace_caller trampoline will call
ftrace_ops_list_func(), and we'll iterate over all of the registered ops
to find the relevant ops and trampoline, every time an out-of-range
direct call is used.

So the big questions are:

(1) How often is a direct call being made?
(2) Where does BPF allocate its direct call trampolines?

From a skim of arch/arm64/mm/init.c, EXECMEM_BPF covers
VMALLOC_START..VMALLOC_END, the vast majority of which is out-of-range
for a BL from the core kernel or a module. So if EXECMEM_BPF is used,
that's likely to be problematic.  Hopefully I'm missing something such
that BPF trampolines are almost always allocated in-range of a BL?

When we originally implemented CALL_OPS and DIRECT_CALLS for arm64, the
understanding was that we'd have many ops with direct calls. We believed
that the ftrace_ops_list_func() penalty was so substantial that it
wasn't worthwhile supporting direct calls in a configuration where
bouncing through that would be common.

If we need to support this configuration, then I strongly suspect we
need to make other changes too in order for it to be worthwhile.

> s390 and loongarch ship HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS this
> way, without having CALL_OPS at all.

Following from the comment regarding EXECMEM_BPF above, it looks like
both s390 and loongarch don't define EXECMEM_BPF, and only define
EXECMEM_DEFAULT with a subsstantially limited range, which I suspect
keeps their direct calls within range.

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

Can you comment on how you've tested in-range vs out-of-range
attachements here?

> We tested on a 6.18.y-based kernel and on this base with clang
> kCFI builds (CONFIG_CFI=y, enforcing) under qemu (TCG, and KVM on an
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

Have you made any performance measurements, or was this just functional
enablement?

Mark.

> riscv has the same gap (its DIRECT_CALLS select also requires
> CALL_OPS, and its CALL_OPS is likewise !CFI); if this approach is
> acceptable for arm64 we can follow up there.
> 
> ---
> Jose Fernandez (Anthropic) (2):
>       arm64: ftrace: prepare ftrace_modify_call() for use without CALL_OPS
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
> 
