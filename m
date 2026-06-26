Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259D63F822C
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488642; cv=none; b=FoCWg5Y++lZVvtSNKct/4xR4Dw06abqyTYoVf+7HdTOvE0vNGUwMwupZXeGhubSoKkGXbdgZpM7LQQDlJ7kYY4hE1S/5r59Oicl7EWg96uMCTol1vvSVublBKoxNwyWnV/Qd2M+BTOuuP9HqpAAbQoMe+usTVKwBnyJci6hdyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488642; c=relaxed/simple;
	bh=wexs/pj5LbonN2tQ1OGP9sqY3ym9qJeio5P/023R3zU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f16O6p7OHX/jFP0Nr5PR41Zx8h8lAG5cafJ9eI/9nLmV9rImtlPqQE9H4v0GFvO3yiOTJ9tKcqEN6RtntjC4di8QKywQrrz4gQDBTijp7TSA38eVhnRgoWFv3gi97pSmRiK3UzqryOEQ9YP5tnBYHY7/5HZRyS9je5mZ7CwKCHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rZ38p/ge; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rZ38p/ge"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782488636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=avd+SKJ2HYmi6vTi8Dal1HBsaJoT5oKjLularkXSyaQ=;
	b=rZ38p/geEHqsLGGof1c1cnSCJF0gDjLzpkjqxiM9JjhRay7VHLnNw32rdMivt/frPYCmXY
	PztNmNPXuuaNzxxF6Qb8HrRAwdlN2f83rq4yBhTbpqLTPzbPBD8nuFabNbMKmk9WymdZ5f
	F0wvxLj0c+mazzNZq8XcmK1FrOUT+k4=
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
Subject: [RFC PATCH bpf 0/6] bpf: Disallow interpreter fallback for interpreter-unsupported insns
Date: Fri, 26 Jun 2026 23:43:24 +0800
Message-ID: <20260626154330.33619-1-leon.hwang@linux.dev>
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

After verifying them by patch #7, I think they are real issues. With
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
__bpf_prog_select_runtime().

This series is built on
"bpf: Fix unaligned interpreter panic on JIT fallback path" [3]. The
patch #7 is also able to verify the issue of un-JITed helper.

However, The patch #7 aims to verify the issues. I think it is not
proper to be applied to upstream, because it adds a stub
'bpf_jit_test_fail_task' to bpf_prog_jit_compile() for the tests.

I'd like to drop the patch #7 in the next revision.

Link:
[1] https://lore.kernel.org/bpf/20260608151347.2C77D1F00893@smtp.kernel.org/
[2] https://lore.kernel.org/bpf/20260622150759.EC9071F000E9@smtp.kernel.org/
[3] https://lore.kernel.org/bpf/20260615025316.24429-1-yangtiezhu@loongson.cn/

Leon Hwang (6):
  bpf: Disallow interpreter fallback for user BPF_ADDR_SPACE_CAST insn
  bpf: Disallow interpreter fallback for arena insn
  bpf: Disallow interpreter fallback for BPF_MOV64_PERCPU_REG insn
  bpf: Disallow interpreter fallback for internal BPF_PROBE_ATOMIC insn
  bpf: Disallow interpreter fallback for gotox insn
  lib/test_bpf: Add interpreter-fallback tests

 include/linux/bpf.h                      |   1 +
 include/linux/filter.h                   |   4 +
 kernel/bpf/core.c                        |  69 +-
 lib/test_bpf.c                           | 800 ++++++++++++++++++++++-
 tools/lib/bpf/skel_internal.h            |   2 +
 tools/testing/selftests/bpf/test_kmod.sh |  39 +-
 6 files changed, 903 insertions(+), 12 deletions(-)

--
2.54.0
