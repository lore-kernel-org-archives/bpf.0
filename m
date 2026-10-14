Received: from mta0.migadu.com (out-94.mta0.migadu.com [91.218.175.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AECA3B42EB
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977538; cv=none; b=YYVgwNkzeHxQkx7HZZ75IrQR2TyRBYWqX7AEhTLvyUv+0FkS0gND11qUqctSti6cZwRi2JMT/5zi6AOvYmMZrcKC0p5dw5uQwRuE/9QHDAfnHgfC8nQ5jyqGLiidCHDAJr9Pnyk5VEgsza9y/nVNDUeiXgnWbVJxWcziPrksyp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977538; c=relaxed/simple;
	bh=LoMHMOtdlnxaox6Rxr22rfVmrJVa+1s0wpe4gtcjIaw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQzrniJp0KEMfDG5Q+6NxSVeEn7gQK/4o69L3uhgy0NPa3LoXnZXmi+DeYCcyDe9ulArrBHjykL1FyPI8RdxmDa1xG2eS3IiIu2rnKH9HyJSLk4x9Mrar0nGK6RxEkzvngU65kPmuPGpIUuNFeLg3zCW3mVa3kjXlFu/xpXtgQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I25uXRfC; arc=none smtp.client-ip=91.218.175.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I25uXRfC"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LoMHMOtdlnxaox6Rxr22rfVmrJVa+1s0wpe4gtcjIaw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791977532; v=1; x=1792582332;
 b=I25uXRfCoQuPnSKowTE6IPdKbUabOY/XWJLhzKErIKSK4nN+YaRuJYyzqxx7FRCLKUyIpjXh
 HGLxZuIe2v/iZrvVn0cF0JcURzGOxZBKOu+NnxhAcKabYcBLYY97tAGSUXL+kXGFcg7TL36U0Fw
 ivUvNNVm+rh186++EpyCfiGA=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 44e70a3378976f04;
	Wed, 14 Oct 2026 11:32:11 +0000
X-Mizu-Trace-ID: 44e70a3378976f04
X-Migadu-Flow: FLOW_OUT
From: KaFai Wan <kafai.wan@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
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
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	KaFai Wan <kafai.wan@linux.dev>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Feng Jiang <jiangfeng@kylinos.cn>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Vineet Gupta <vineet.gupta@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH bpf-next v2 3/7] selftests/bpf: Fix stack arg pruning test JOIN log expectation
Date: Wed, 14 Oct 2026 19:30:39 +0800
Message-ID: <20261014113043.640435-4-kafai.wan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014113043.640435-1-kafai.wan@linux.dev>
References: <20261014113043.640435-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f414d20879ae ("bpf: Save DFS postorder numbers for program
instructions") changed bpf_compute_postorder() to use a real DFS, which
changes the postorder of this test's instructions and thus the insn edge
the arg track join at insn 10 is reported on:

  arg JOIN insn 8 -> 10 r1: _ + fp0-8 => fp0-8|fp0+0
  arg JOIN insn 8 -> 10 sa0: _ + fp0-8 => fp0-8|fp0+0

Update the r1 and sa0 expectations to the new output.

Fixes: f414d20879ae ("bpf: Save DFS postorder numbers for program instructions")
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 tools/testing/selftests/bpf/progs/verifier_stack_arg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
index f6a4a6aa0e617..b9f799f6e4051 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -117,8 +117,8 @@ SEC("tc")
 __description("stack_arg: pruning with different stack arg types")
 __failure __log_level(2)
 __flag(BPF_F_TEST_STATE_FREQ)
-__msg("arg JOIN insn 9 -> 10 r1: fp0-8 + _ => fp0-8|fp0+0")
-__msg("arg JOIN insn 9 -> 10 sa0: fp0-8 + _ => fp0-8|fp0+0")
+__msg("arg JOIN insn 8 -> 10 r1: _ + fp0-8 => fp0-8|fp0+0")
+__msg("arg JOIN insn 8 -> 10 sa0: _ + fp0-8 => fp0-8|fp0+0")
 __msg("R{{[0-9]}} invalid mem access 'scalar'")
 __naked void stack_arg_pruning_type_mismatch(void)
 {
-- 
2.43.0

