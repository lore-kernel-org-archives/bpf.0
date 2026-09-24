Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233E4403138;
	Thu, 24 Sep 2026 06:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230868; cv=none; b=Q4VDzely54G84ryLHhfu1eACbTEnIW3gYxoYiqQ4ksZcLhMrmI7F5+RfK8ib3/UkYjOjx5qlOR5o/3pAq4gTb1Plht6JtUcR6PKBbsjYfpceAvMZYnln1B41tDnPI2IcKd2BuZs6isK9JcwOJRkXnksj2OHqjFn4oRliRoKeKQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230868; c=relaxed/simple;
	bh=reBBHsp3dFVFx1bF+MzYdUeYyaVuB7Dha/3mQOU4WLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O6TT15NdDsKb8FKqhZCLx8tQXIQtfAImlb3KaijMgHeVtS4U4ZZurjqjgSQDg8U3eFlVBJvfZBAR7MjkZJNUR3PtxsGqBSMMjRDgqMwOeEdo6JpFCLwrLzGQ5H/3x+Qx5s7JuTF+uBlFf+8aGOCxQu2JWjDp8sAsHDMuiDYtxX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ldix3Ne3; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ldix3Ne3"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790230853; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=UZmmCpa9iQGypCYX6K6r43HbgZn3fz9spOS64iksXTs=;
	b=ldix3Ne3+9sO2eMsKeLXrXRkSZNYFjD96PKUARWcza4N92lo+DSuLQSGiTml6deieiKXBw5XaZpNz3WDD8pWmjiD+p37zd8RmoX5mSzYIijpLB26h8Yu4rdSkUZKmPcl6g73o1ZS3W0jDeL2WsKN8/ae78auOF0ve+cko+8lr6A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0XBYn2f4_1790230804;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XBYn2f4_1790230804 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Sep 2026 14:20:53 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: JaeJoon Jung <rgbi3307@gmail.com>,
	rgbi3307@nate.com
Cc: bjorn@kernel.org,
	bjorn.topel@gmail.com,
	luke.r.nels@gmail.com,
	xi.wang@gmail.com,
	puranjay@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	memxor@gmail.com,
	pulehui@huawei.com,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: net: bpf: add bpf_jit_supports_private_stack()
Date: Thu, 24 Sep 2026 14:19:59 +0800
Message-ID: <20260923114951-private-stack-rfc-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810031418.95364-1-rgbi3307@gmail.com>
References: <20260810031418.95364-1-rgbi3307@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi JaeJoon,

Thanks for the report. I have been looking at what still blocks
sched_ext on riscv64, and the private stack is indeed an important part
of it.

> $ sudo ./build/bin/scx_simple
> libbpf: prog 'simple_dispatch': BPF program load failed: -EACCES
> libbpf: prog 'simple_dispatch': -- BEGIN PROG LOAD LOG --
> Private stack not supported by jit

I don't think we can take the hook on its own, though.

The other architectures paid for this with real JIT work rather than
with the hook alone: arm64 (6c17a882d380), x86 (7d1cd70d4b16) and
powerpc64 (156d985123b6) each added the per-CPU allocation with
overflow/underflow guard regions, the prologue work that puts the
program on that stack, and the guard check plus free on the program
free path.

> It seems that it should be defined in the same way in RISCV as well.

Defining it the same way means that JIT work, not just the hook. With
the hook alone the verifier would let these programs load while riscv64
still runs them on the per-task stack and has no guard region, turning
the clean -EACCES above into a silent stack overflow.

Going through those three commits, this is what I expect the riscv64
side to need, and I plan to post it as an RFC series:

  1) per-CPU private stack allocation with overflow/underflow guard
     regions, plus the guard check and free_percpu() on program free;
  2) pointing BPF_REG_FP (S5) at priv_sp + the program's stack size
     while leaving SP on the kernel stack, the way arm64 does;
  3) emitting the per-CPU lookup that produces that pointer after the
     tail-call entry point, since RV_TAILCALL_OFFSET is a constant
     added to the target program's bpf_func;
  4) bpf_jit_supports_private_stack() returning true only once the
     above is in place.

Aiming to send RFC v1 within the next couple of weeks. JaeJoon, I hope
we can go over the testing together once it is posted.

Thanks,
Pei
