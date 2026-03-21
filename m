Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E0028002B
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774110905; cv=none; b=Vr6SlDfs6BnTfi8CgTpqsijipE/Tn4SpQfJm1RZ+6LEjR2CndJ5ibM9yf0hlQF4rPhqupLsCwZa0av8JUSGp5ZEZxk2bdWndfP6hZaG9K+/EIaudxV6FvBafNeORLBuW8MGIwOsUX8OTIVH1wI1F7cKXAKJgvA1gG+0INhDo5Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774110905; c=relaxed/simple;
	bh=WG5XCLq40qZgpZXoZQoQzh1JTe8VNQCWfKKkdjx3lWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HuQRIaEi78JpeQ8Vgv6wUuLQ1AccAOfI/vZ4vfZgnzJnnMBdBQ7F19Sqm+dCqpDJX1f+52MXWk/eHLL0r29hCWtDg4Tbg+AAbowGeSqyVqMlJpeZ3qWm32AqYvSMz7DdTo+yunAPqgJ/HKOSLWmRxl3WK4CldF/lqX2yGQGoEZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Eh0DOGRe; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Eh0DOGRe"
Message-ID: <b2b92bc4-1921-4fb2-8038-d547b6dd468b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774110892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WG5XCLq40qZgpZXoZQoQzh1JTe8VNQCWfKKkdjx3lWk=;
	b=Eh0DOGRe2vT+tB58d3W3j29+ohL9d3Es5GZg3SXahlxzgBAJBOk7OXI2Fhy+XDAUcSy4DS
	kFE43E1F4mSvItOfFRDlelbtM90JrsY5u2cmW3bNKzoO6xnvgoFlo7r5qJ/VpFISdd7mKf
	atjrIW5xg/Xv43vHxgWdpVt1KB4J13E=
Date: Sat, 21 Mar 2026 09:34:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix exception exit lock checking for
 subprogs
Content-Language: en-GB
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260320000809.643798-1-ihor.solodrai@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260320000809.643798-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/19/26 5:08 PM, Ihor Solodrai wrote:
> process_bpf_exit_full() passes check_lock = !curframe to
> check_resource_leak(), which is false in cases when bpf_throw() is
> called from a static subprog. This makes check_resource_leak() to skip
> validation of active_rcu_locks, active_preempt_locks, and
> active_irq_id on exception exits from subprogs.
>
> At runtime bpf_throw() unwinds the stack via ORC without releasing any
> user-acquired locks, which may cause various issues as the result.
>
> Fix by setting check_lock = true for exception exits regardless of
> curframe, since exceptions bypass all intermediate frame
> cleanup. Update the error message prefix to "bpf_throw" for exception
> exits to distinguish them from normal BPF_EXIT.
>
> Fix reject_subprog_with_rcu_read_lock test which was previously
> passing for the wrong reason. Test program returned directly from the
> subprog call without closing the RCU section, so the error was
> triggered by the unclosed RCU lock on normal exit, not by
> bpf_throw. Update __msg annotations for affected tests to match the
> new "bpf_throw" error prefix.
>
> The spin_lock case is not affected because they are already checked [1]
> at the call site in do_check_insn() before bpf_throw can run.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/bpf/verifier.c?h=v7.0-rc4#n21098
>
> Assisted-by: Claude:claude-opus-4-6
> Fixes: f18b03fabaa9 ("bpf: Implement BPF exceptions")
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

