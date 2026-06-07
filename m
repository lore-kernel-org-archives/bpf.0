Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537482FD696;
	Sun,  7 Jun 2026 20:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780863037; cv=none; b=X9vm+biIXHX3aZIOH1pyk0GJUmFPk/qOx+Llen0/W4FW/cgK2IQWJxevsf7fiNw8Yl72C3JS8NauElYuLFSL+3fLDvIZhcT9pt277VHgv5F9hJpK/ufAjwut8o0LTDh6l2HDcypPNf/5+F8RxF0U9Wuj2lON/4W6d2XGV++CSf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780863037; c=relaxed/simple;
	bh=7wIHOSWYohEmLG6pMXnfULhqgb287plk20JlAu4I5Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=d97dowDZxsqYeUdgH+/y7zANiRF7m/pACZ1WJ8w8AUZdGuq8l69TLzZYpsvwu7FX/POQfesV0MT/ktWF1BHXzIU0ZCfefQgUXEEOxACpWnARb0P3sGwRBwAsGS9Dp/VtcWmPhFOJZqQkFywMsq+JalNyOn/rl2wU5oNwNKMvjE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bShHqSnI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bShHqSnI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BEA1F00893;
	Sun,  7 Jun 2026 20:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780863036;
	bh=7wIHOSWYohEmLG6pMXnfULhqgb287plk20JlAu4I5Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bShHqSnI6oWOfUDSbW6cYy9eMbRTgUko/xyPhiYjQd4+q8UgRyl4FX9sU96QojKmj
	 7jK6GH6Y5DzVZNl/oYRof/zwlsdAgIq4fxxaZFx4NGJtrqT4D5dnzx3nfJWfCBYTOo
	 qOhK6VyjprDy5b4PtURtf5opb1bLBCMSUX9BCEzhGEFgCit94GdQXXSZ8nj/J1X447
	 DHVTof/qqRgiYNi6dpMLHS0InhtO5TGWFhmblbiv2yVcqPhabshMvd3rR4d7/yfzL6
	 CUrw06X/S8BL4t3f+hrAxCmBx9mGTYM7AciY6l3xlakeFNLHf3tkdeUpikDVPqcxDZ
	 IOF2V8sJaovvQ==
From: Tejun Heo <tj@kernel.org>
To: bot+bpf-ci@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Cc: david@kernel.org,
	arighi@nvidia.com,
	memxor@gmail.com,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	void@manifault.com,
	changwoo@igalia.com,
	clm@meta.com,
	ihor.solodrai@linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] arm64: mm: Complete the PTE store in ptep_try_set()
Date: Sun, 07 Jun 2026 10:04:19 -1000
Message-Id: <1780862659.ccb18e27e916dc4b@kernel.org>
In-Reply-To: <5f68f44310d4878185fd5ebc52d66530b99f174c6d04ab1170dc53cefaa54568@mail.kernel.org>
References: <088f52fd25860ca961449d53f91b214a@kernel.org>
	<5f68f44310d4878185fd5ebc52d66530b99f174c6d04ab1170dc53cefaa54568@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> Can this path actually loop, or is the deferred barrier guaranteed to be
> flushed before the faulting instruction is retried?

I don't know the arm64 paths well enough to say. What I can see is that
ptep_try_set() only runs as an apply_to_page_range() callback, and
apply_to_pte_range() brackets it with lazy_mmu_mode_enable()/disable(), with
the disable() flushing TIF_LAZY_MMU_PENDING before returning. The barriers
would land before the access is retried. It also looks like the same
queue_pte_barriers() path __set_pte() already uses. I'd defer to Catalin and
the arm64 folks on whether that actually closes the case.

Thanks.

--
tejun
