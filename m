Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FF34B04BE;
	Wed, 19 Aug 2026 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127835; cv=none; b=N7N7bCqcR4SY2OCV0SIhMRXQ8texizWfZ1CNQ4WwKKyVhRDGllZ+XfVf09I35WCEiSq2UG66Qm5A2keQo6Y0213DswtWe/8FTyaXmbJzCO7DzQGeMFBEz0EOphCmT30kA8iCZSNNYHd3mTTX9H8rD0plzQktHd97uyPYT36tSy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127835; c=relaxed/simple;
	bh=DlKum+OD+Tui2wO8j+I4laxW/iItP+hAMFGwf6y4a0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvCbA4YwITSG78ekUkZgCDFwgbdXZy/7wUM5FPQj7U4sBaPHFrSs0GLUVtzibskF0/mN4gO1b59xN80P/VWLL+Uqyi+UVdJ0kknKF7bERke6iLqZrivwBe0mAlRV9e7JtxDZHBzW7qTafeGTeP555IZFj0+yVLTVJMEAxv2qHkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iBMsmniI; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iBMsmniI"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787127828; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=o0sqmDLy0vpj/KvGkon3LG48honRgsuUlMQByXc6VPY=;
	b=iBMsmniIo+CfkOK3pewTz5bm/z0oQmvaXfdg4H7b4oM/cuvJNAXS2uNZtHyH0sHtnt8rVprZF6ZGS3fi7NpPJH7LTXOydydKEOEOSjgcXJ1Teg9JIsEb8sPieKdCO45cAIcnRiQswXajtZ//latoB0jGvevk9qW3CGG6rauKToU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0X9G44Qo_1787127821;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X9G44Qo_1787127821 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 16:23:47 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: Pu Lehui <pulehui@huawei.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf, riscv: Add support for signed arena loads
Date: Wed, 19 Aug 2026 16:23:33 +0800
Message-ID: <reply-pulehui-arena-ldsx-fix-20260819@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4ba94268-cd39-438c-a788-a5b75cfd8813@huawei.com>
References: <cover.1786708960.git.cp0613@linux.alibaba.com> <3445fb0231f9c72496ae840e9dca675b15899433.1786708960.git.cp0613@linux.alibaba.com> <c5441b7e-3d20-4e4e-a225-7478f7fb9d6d@huawei.com> <4ba94268-cd39-438c-a788-a5b75cfd8813@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Lehui,

Thanks a lot for testing and catching this!

On 2026/8/19 11:41, Pu Lehui wrote:
> oops
> 
> need to revert this reviewed-by
> 
> [...]
> 
> Hi Chen Pei,
> 
> It's happy for the verifier_ldsx, but it not happy for the other test,
> pls take a look.
> 
> [2026-08-19 11:33:21]  [   35.541573] WARNING:
> arch/riscv/net/bpf_jit_comp64.c:915 at add_exception_handler+0xce/0xf0,
> CPU#0: test_progs/122

I reproduced it locally with arena_atomics on riscv64 QEMU and found the
root cause. It is indeed a bug introduced by this patch.

BPF_PROBE_MEM32SX is defined as 0xc0, which collides with the mode bits
of BPF_ATOMIC (also 0xc0). The riscv add_exception_handler() gates only
on BPF_MODE(), so adding BPF_PROBE_MEM32SX to that gate lets every plain
STX atomic insn (including on-stack atomics, whose JIT emit path also
sets ex_insn_off) pass the gate and register an exception table entry.
That overflows aux->num_exentries, triggers the WARN you saw and fails
the JIT pass with -ENOTSUPP.

Since BPF_PROBE_MEM32SX only exists for loads, the fix is to restrict
the PROBE_MEM32SX check in the gate to the LDX class, so that plain
atomic insns are filtered out again.

I have fixed and verified it locally on riscv64 QEMU: arena_atomics now
loads all ten programs cleanly with no warnings, and all five
arena_ldsx tests still pass. The fix will be included in v2, which I
will send shortly. Thanks again for the review and the report!

Best regards,
Pei
