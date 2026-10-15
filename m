Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77074A6CFA
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051224; cv=none; b=qqlolKBfaBn48ltzpy/S8frTD1DSpHGz28KLIE0yVba9Pkdll/PSBKBaQIggkaPWJ86USU57OkAf9TllyuhEhm84u93nsBYSEgyhN55u7qkA2o25HDBTdIsk9ch5zcWRwVpozX2j3qcNs9DairklqOG8MAAh/PMAc6aYbIPsRC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051224; c=relaxed/simple;
	bh=qo/0NHXtvxnsaVIwxmzb+oU9wow4NUxeO4jASS+kfB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqxwmq9ANUX+ikABh3yepsJqXsSjA7ZgnUtkQ89MMocYdlcZsB8DMR/Tw3jJR1bMc7HsgiyBH70cEZi1nrlYhaL/nOY+4lYEBs0tYSUwFimBKMsqP/4gc7LmQmGDsd39fjMy+YQ1ZhT2wDG83x+0ho8ki29vq8XKMzfARN4NjSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lhClTILe; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lhClTILe"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792051219; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qo/0NHXtvxnsaVIwxmzb+oU9wow4NUxeO4jASS+kfB8=;
	b=lhClTILeGkrmE2xKL7v62BCD69NG9E+2L25KrMhbEDo+PUEIBoN9CDi1HgGZzz/wrp9UOvpGv4d7n7q+9HrNKtQDzbTVlCLcXXoGwN0ts6jyFFpmJGMRPp4bLkJbUPE9XbZqyAxBjRtUL8U56mrDwZrWzPLrzsS3N9BiEKqkqbk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0XCr3JvP_1792051214;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XCr3JvP_1792051214 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 15 Oct 2026 16:00:18 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: sashiko-bot@kernel.org
Cc: bpf@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Enable private stack tests for riscv64
Date: Thu, 15 Oct 2026 16:00:11 +0800
Message-ID: <20261015080014.6366-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-172140@kernel.org>
References: <20261015021238.5657-1-cp0613@linux.alibaba.com> <20261015021238.5657-3-cp0613@linux.alibaba.com> <sashiko-outbox-172140@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This one I am not taking: what gates the test is large stack support, a
JIT capability separate from the private stack this series adds.

> [Severity: Medium]
> Was the private_stack_two_frames test in verifier_large_stack.c missed
> in this patch?

> Since the RV64 JIT now supports the private stack, should __arch_riscv64
> be added to this test as well so that the riscv64 architecture receives
> this large stack test coverage?

The test builds a 2048 byte frame. Above MAX_BPF_STACK that is only
accepted when bpf_prog_stack_limit() returns MAX_BPF_STACK_JIT, which
requires bpf_jit_supports_large_stack() in the JIT as well as
bpf_jit_supports_subprog_tailcalls(); the former exists only for x86-64
and arm64. riscv64 rejects the program on the depth with or without a
private stack, which is why it skips behind
is_large_stack_supported(). Adding __arch_riscv64 would turn that skip
into a failure.

The other comments on this set are valid and are taken in v2.

Best regards,
Chen
