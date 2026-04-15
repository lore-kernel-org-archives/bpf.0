Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BEB2DC765;
	Wed, 15 Apr 2026 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776256698; cv=none; b=pVh4Nr7XtjMvW08fD6Cxli7IFjyHXih7HTIMF9Z9gPUKPNAJNmLwxJTCheFd+NVfZHIPjrpczNz+RtyhCJ3KAmWfX1C0a7yCe9fmWZLVlbeCDIEOi0EAIIJnnINdM2u6L7S9FMRMTeruSu0h9vSmhs49/J/Ik/8HtDThU1RfPUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776256698; c=relaxed/simple;
	bh=p340FmAH97IMVG74X8N25pPtvw4YgnFTmmYmNrvVRsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gK+WffdylXx8PfX88thDLg7XEn4RyTqe88VODgreFy70xysgvqtUQ+/qbCOKPqPRo1FEvPlQpez3qx5ulr9gID3b3xESoT5LLB5xBkH7t4WfdAAdBlP2Vto4HhizQuUdLzbqgA4oUDPt/XttBC6z8kHE81r7sk/ZDyOaRHjnSOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=VXD/xn0h; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="VXD/xn0h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eRHac6+7OjGhQ4pPHk0arofb9sWAo1B2RbgwlWeamq0=; b=VXD/xn0hXIMU1iK3HIIAIyKapC
	OMlDpvUPFyN1cbc5rT+/MmehfjNFi2HHrnkB/3Jg7DeHi62tq31iZC+exinlj8mXgnvccnNw6OT9Z
	O9wYYry02IDoO1b/ysgwAjt5tdzY2ZbadG0m6aQKFgi9PIGxJU58VXorrpiQV6Mua+WAsI6j+s2vp
	0oXWPFE1B0dLlYgZPUZxCf7u6HRD8yBBdJQPpDyRGYflPiz30oo8X4I6UL5iavX3ijMHYlUNKP4nm
	iukmmtUTOM2hXYWgUv0msL8nchlFPgROY32FP/a4isRqWC4dm/1arhgNSsOpPz68yRXI9eI7u4tMd
	0RxlCEBQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wCzVQ-00Dq5O-18;
	Wed, 15 Apr 2026 12:38:08 +0000
Date: Wed, 15 Apr 2026 05:38:01 -0700
From: Breno Leitao <leitao@debian.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf, arm64: Remove redundant
 bpf_flush_icache() after pack allocator finalize
Message-ID: <ad-GmdGbXrZAi7WA@gmail.com>
References: <20260413191111.3426023-1-puranjay@kernel.org>
 <20260413191111.3426023-2-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413191111.3426023-2-puranjay@kernel.org>
X-Debian-User: leitao

On Mon, Apr 13, 2026 at 12:11:08PM -0700, Puranjay Mohan wrote:
> bpf_flush_icache() calls flush_icache_range() to clean the data cache
> and invalidate the instruction cache for the JITed code region. However,
> since commit 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory
> management"), this flush is redundant.
> 
> bpf_jit_binary_pack_finalize() copies the JITed instructions to the ROX
> region via bpf_arch_text_copy() -> aarch64_insn_copy() -> __text_poke(),
> and __text_poke() already calls flush_icache_range() on the written
> range. The subsequent bpf_flush_icache() repeats the same cache
> maintenance on an overlapping range, including an unnecessary second
> synchronous IPI to all CPUs via kick_all_cpus_sync().
> 
> Remove the redundant bpf_flush_icache() call and its now-unused
> definition.
> 
> Fixes: 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory management")
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Acked-by: Breno Leitao <leitao@debian.org>
