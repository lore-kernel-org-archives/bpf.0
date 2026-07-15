Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F32A478E51
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124729; cv=none; b=jvIgEHx5Hov+sK7Nu3bKokL1/PJA+jqRutBAeE4XVfZedJRlCkgR5Hj8iBRDA+vCXbHqrfMt4qcwI8gWRBzkOjB0UreO6Ko1mUlXwsCGNLjOubjI7rL9M09z/tyxUEomoqxPnC6XazQyfONk2peMrcdD/tGCRAvxloowsOXmEII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124729; c=relaxed/simple;
	bh=jKYEPjJmk/4wVC0Nb1kJtaTETlVko7kX3Lqk3meOMYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k6j3O0Jgpkijd7ebNc/ayScH/u7xyEOE6rdaaWpFJ4KT2oYFSkVHqAuWBnxvpK9m5ZgioEofJM9r6B+Dw+63VflMmhIFxGvOWbGRpJWy5C8hSzQDpUAzGnu37m4Zgv1USBt5S70BKRt+OqvRQr9Xbdnt3X9kIlYVU/Ut/xUS9wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=crsjyZ62; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="crsjyZ62"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784124715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q1RJFtLBbovc5tYQu7WNN4H+TjPY+BRBKTXIpeUD9i4=;
	b=crsjyZ62aWoayOJcX8tIMlmB+SxGvalf/C05unuXZAsPkGnd7b71ruzDCRZ9Rk7RILUlTe
	Np3XlTjwwNYtH36j5x0RI7XPQezgjr1AcDdV6tLkYt88dgIKItf92LFQV7/OMORv8mcrwq
	5VN4wBnVdRpOd5PySpDW8dwzNOkf/14=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next v2 0/3] bpf: Disallow interpreter fallback for interpreter-unsupported insns
Date: Wed, 15 Jul 2026 22:11:19 +0800
Message-ID: <20260715141122.15783-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Sashiko reported two potential issues about interpreter fallback [1]
[2].

After verifying them by patch #7 of v1, I think they are real issues. With
LLM assistance, the interpreter does not support the internal
BPF_PROBE_ATOMIC insn and the gotox insn (used for indirect jumps),
either.

1) the user BPF_ADDR_SPACE_CAST insn
   the interpreter just ignores it.

2) the arena ST/STX/LDX insn
   the interpreter could hit the BUG_ON() in ___bpf_prog_run().

3) the BPF_MOV64_PERCPU_REG insn
   the interpreter could hit page fault, due to loading memory from
   invalid __percpu pointer.

4) the internal BPF_PROBE_ATOMIC insn
   the interpreter could hit the BUG_ON() in ___bpf_prog_run().

5) the gotox insn used for indirect jumps
   the interpreter could hit the BUG_ON() in ___bpf_prog_run(), too.

Reject these insns on interpreter fallback path in
__bpf_prog_select_runtime() by setting 'jit_required = true'.

Link:
[1] https://lore.kernel.org/bpf/20260608151347.2C77D1F00893@smtp.kernel.org/
[2] https://lore.kernel.org/bpf/20260622150759.EC9071F000E9@smtp.kernel.org/

Changes:
v1 -> v2:
* Drop RFC.
* Change target tree to bpf-next to utilize the 'jit_required' bit.
* Set jit_required as true if there's arena map, then all arena-related
  insns will be rejected if JIT is not available.
* Set jit_required as true if there's insn_array map, then the gotox
  insns will be rejected if JIT is not available.
* Drop the issues-proven patch.
* v1: https://lore.kernel.org/bpf/20260626154330.33619-1-leon.hwang@linux.dev/

Leon Hwang (3):
  bpf: Disallow interpreter fallback for arena-related insns
  bpf: Disallow interpreter fallback for gotox insn
  bpf: Disallow interpreter fallback for BPF_ADDR_PERCPU insn

 include/linux/bpf.h   | 4 ++--
 kernel/bpf/fixups.c   | 5 +++++
 kernel/bpf/verifier.c | 2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

--
2.55.0
