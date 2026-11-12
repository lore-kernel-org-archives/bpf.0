Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470649;
	b=aG8pPJ0arUYF3m7oaCLRvzgtN62tWrDT+O0ww1QPuAzfJTd8WZ1xe2P9sVYryG5Chajn
	 l+ci7yOWRYAvgDUFfAQqxQ+CP5iglcjsTLo7BMT8858IwkM4wjREkgWXH5QgWDjF7FFDY
	 U4apny9UAk6obiUW8kvQbv+paYMGtqxxuz2pm6JBOnqvZ4/cZTkKkNKBQeIAhC1nToIag
	 jTHZ6kLEor9t4DlhMAWIerFTmtjSFhhK+a9piiENzeb/z80PuVEP5sC5++CDQHOx979me
	 HuXBuCzipq/YhpkMqDqmtSJtoAzspJG8I+cd6EdcutCgD8ee8CPozeyhVSWtxhMaiag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470649;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=TlZK97JIK4Nn+MnoW7/S82hDUBRhLj3xXqWxr7yoG8c=;
	b=G4hnkBAXSrhAEBGCH5nxnlITyib8ZlquYJU7Qg+VCHfpZDsD6Pb2PkJ94oirljynWNth
	 1P81RaLxECeSiq/eZVUrXthj9ZUf6K6ThgqiM4dHA0SKA6i3NbbmksYMrSxEHprjQD7BZ
	 M7OcFna2EFjVfEKkSv3UnplYhg0VwvycM2Au+ax0zWXiGgQ1oP84i2ncbwimZLeQ3ZFhQ
	 UCJG7jjYTKqvQTjIP5jm/YKrUGHh9vEIPAgP9xS0EHMALIAdi/xp/qcTMnBlHZsmN1otL
	 sTN54NLPt+1cNsgtm6gJZ1vlEuDdoRfe6UwqGlYXtsae4jIAVdRaoyqi7iKQbiAlr6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=RKBTgT67;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABCE606A327;
	Thu, 12 Nov 2026 08:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ABCE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=RKBTgT67
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TlZK97JIK4Nn+MnoW7/S82hDUBRhLj3xXqWxr7yoG8c=; b=RKBTgT674M5Ff2bwNNuHVMvaBZ
	pUx2MoLLoNq0shonBH+dYNVM1/t6vY544iIeUU/t41/0tFbXktyCOgolZ5alxry7MYjhVcn/1xmRQ
	kNg+G4IzQmrUr4+3uklAbmfy26Gp05cgcIuxf2DQe/CdjTYPiQ42iDhBPRiiYUiOqBu4vI9Vt0k4R
	S2kJwbFL4Dmw7KhqA5FTc2ypq1GEJQ8KbIiiMhKmsQ7cQw+ILC6iFOQptSJs1GBmFlDZNNbR6K+P0
	uIu4WRW1rLgDi8zut3Fu71J7UHjIdOza+VXhcyj2y8h0NpfOngHUG7e17Wmde1wmNRFiyZfQFszzv
	Cg4C8MEA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPmx-0000000A22o-1jP5;
	Thu, 12 Nov 2026 08:04:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 60E7A300400; Thu, 12 Nov 2026 09:04:06 +0100 (CET)
Date: Thu, 12 Nov 2026 09:04:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: hang.zhengyang1010@gmail.com
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] uprobes/x86: Emulate ENDBR as a NOP
Message-ID: <20261112080406.GA2668804@noisy.programming.kicks-ass.net>
References: <20261112-uprobe-endbr-v1-1-284a47a5ae3e@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-uprobe-endbr-v1-1-284a47a5ae3e@gmail.com>

On Thu, Nov 12, 2026 at 01:26:18PM +0800, Hang Zhengyang via B4 Relay wrote:
> From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
> 
> A uprobe on ENDBR64 is single-stepped, so it takes two traps instead of
> one: insn_is_nop() doesn't recognize ENDBR, and it isn't a branch or a
> push either.  That makes the most common case slow.  With
> -fcf-protection, the default for gcc on Ubuntu, every function starts
> with ENDBR64, so every uprobe on a function entry pays for the
> single-step.  PUSH had the same problem until commit e7ed9d9bd037
> ("uprobes/x86: Emulate push insns for uprobe on x86").
> 
> Userspace IBT is not supported, so ENDBR is just a NOP in user mode.
> Emulate it like the other NOPs.  Don't use is_endbr() for the check: it
> always returns false without CONFIG_X86_KERNEL_IBT.  If userspace IBT
> is ever enabled, uprobes on ENDBR will need rework anyway, since the
> int3 replaces the ENDBR at an indirect branch target.
> 
> The numbers below are from the selftests/bpf trigger benchmarks, with
> an extra target that starts with ENDBR64 (the existing ones are built
> with __nocf_check, so they don't have it).  On a Ryzen 7 PRO 5850U,
> without this patch, a probe on ENDBR64 is as slow as a single-stepped
> one:
> 
>              nop       endbr64   ret (single-step)
>   uprobe     1.33 M/s  0.65 M/s  0.65 M/s
>   uretprobe  0.66 M/s  0.43 M/s  0.43 M/s
> 
> With this patch ENDBR64 is emulated like a NOP.  I could only boot the
> patched kernel in a KVM guest, where uprobe went from 0.19 to 0.99 M/s
> (nop: 1.00) and uretprobe from 0.17 to 0.61 M/s (nop: 0.61).
> 
> Signed-off-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
> ---

Uh, no. We must not allow uprobe on ENDBR. If we ever get userspace IBT
(people are actually looking at that), then putting a probe on it will
make indirect function calls #CP.

None of this makes sense.

