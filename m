Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E63C0630;
	Mon, 10 Aug 2026 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786362199; cv=none; b=blIA31aygWZ2CFYhY5ao/z40oGCRVGuCFPqVYcW7Fh4jnez/9o51IMTr8tqwlTOaiiKLfz8fTQggdY5GGSv+jtEtxAOZiVvSq8R60Dy6lrKPJlmePBxOXYG3kA+HYf+kf/ZjF2sD/h5Nd550acUWbkdJNCG34lxfbErumNN/c0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786362199; c=relaxed/simple;
	bh=yWknneG1P8cHsqapGYEn8wMkxeBUNJsODRzG7EzWcTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vzf0WHZMPrwZ2FTF7MC4auM3dw017WXBMGfyfILt6/hHInb7oOn5ve+e+L6NEBZrHrhhsv4GGNdssHv6h7uTgfMAnn5Vxn8Y1OdYqNF87ofwRYCwNjw8pdeTHh1oQTuet5iLBbStYR+lc3SkvEi9wESHbvfcbHCzAh844TmSWR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZp6majY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZp6majY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D07D1F000E9;
	Mon, 10 Aug 2026 11:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786362197;
	bh=Eiem7LBuQlQ7cxSVIkkWqhfHRGZ0GHrsJpkwoKlf1L8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eZp6majYjI/aUrK+Nqma3GbUetgI4bpxlVWLt9Fkm/FJVvy56+I5h18+CZrVGPhdB
	 DESfIM9Kx2ff4dMsCqa0N3l1++lnqGMKlZ7pW0ySFR34nJ3dUnPdSlnIpXuUJvFsYw
	 vzMXXr9rRAsxpA+Sn1cNCRSPlfLWraJvbMx2D7Xy2glAOEzn7EZnM5SWjTpRE++D10
	 F3DhKQCUCGpfdVioGcaJt9/kM20iI4xdKMG3kJK9uacn8k9+31oOzBX+oDv4QawevO
	 8XPLWPyiAg7OX4L9JGs8F2QMONOClF6dpE0LvsSOLSayWJ58NmanShQKCccH2F3CoL
	 6b3ORM9MW8GEg==
Date: Mon, 10 Aug 2026 12:43:11 +0100
From: Will Deacon <will@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, rmikey@meta.com, kernel-team@meta.com,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>
Subject: Re: [PATCH RFC] arm64: entry: PSTATE_I_SET is leaking on pseudo NMI
 mode
Message-ID: <anm5T9FazACqOWXF@willie-the-truck>
References: <20260807-arm64_fix-v1-1-d069ccf9d71b@debian.org>
 <anXkO8YpoadRzm07@J2N7QTR9R3>
 <anXqMsJ14r3BAbMG@gmail.com>
 <anYHjvJ1_4dDjuzw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anYHjvJ1_4dDjuzw@gmail.com>

On Fri, Aug 07, 2026 at 09:29:12AM -0700, Breno Leitao wrote:
> On Fri, Aug 07, 2026 at 07:58:21AM -0700, Breno Leitao wrote:
> > Meanwhile, I will try to ftrace the writes to PMR and regs->pmr to get
> > a better grasp of the states machine we are in (probably on Monday).
> 
> It seems LLM found a very easy to reproduce this:
> 
> 	bash-5.1# dmesg
> 
> 	bash-5.1#  cd /sys/kernel/tracing
> 	echo 'r:pmr vfs_read bad=+0($retval):u64' >> kprobe_events
> 	echo 1 > events/kprobes/pmr/enable

Nice, that triggers straightforwardly in QEMU for me. The diff below
(which implements my suggestion from [1]) seems to fix the issue, but
it would be good to hear feedback from one of the Arm folks.

Will

[1] https://lore.kernel.org/all/anXgWRmcjwPKG7N5@willie-the-truck/

--->8

diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index 795b35128467..691ee5f86dbe 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -132,7 +132,7 @@ static __always_inline void local_daif_inherit(struct pt_regs *regs)
                trace_hardirqs_on();

        if (system_uses_irq_prio_masking())
-               gic_write_pmr(regs->pmr);
+               gic_write_pmr(regs->pmr & ~GIC_PRIO_PSR_I_SET);

        /*
         * We can't use local_daif_restore(regs->pstate) here as

