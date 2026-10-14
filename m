Received: from mta0.migadu.com (out-76.mta0.migadu.com [91.218.175.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5D3427F85
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977514; cv=none; b=rDlXdzs02oQrB8G3cxQHd/7ub9HqArl2We4yxyMcQJbh/obvEX0NH3Nnqd/YjVh/rRYXBbKlhiXSO0Msele6hH59ctTZuxhQerTpt2nRkOOhBjw0hPvlLtntZ5I7e7oviy6nUjDVzZgn9TcWwR4hLYUwnStf5r5cY2TSWPNn8Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977514; c=relaxed/simple;
	bh=MfJUipPRTHw3gZTbDsC5m8NYm0QnN8o8oob2FVBubUw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAgk3oZ4Im68WwjJqeHiqJne3PLXaepKoazsMpRtQcCF2NMy3mP21bHMyPavAA2iBsOGsLFQ/7Eh4PFRXuvGJIaKFt3bBA5DZXYlfowz/xnOewUtc0kM9FCSDgyu/a9CZrpA/+8meLEwOOwrkH0KAZgwEPpyMx4VAlhZqn2miqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eDe5sJAz; arc=none smtp.client-ip=91.218.175.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eDe5sJAz"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MfJUipPRTHw3gZTbDsC5m8NYm0QnN8o8oob2FVBubUw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791977510; v=1; x=1792582310;
 b=eDe5sJAzzNLH0QJWMaVJoLLAR4bSsUwjuNGZr8fGr7S5Tq+4aTUF+BhR6G9cE8G2RVeQkzme
 VtzEk3iuLkmgVBet97X6Uf0tWzjGe479QlP1CD3hFC1TS/hCItDQR7O8rBZe6xP+YpXCPf0IRFw
 PuwseAJhvgbjtBA1E/oSlsio=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 4a99d5c6d2f0ae41;
	Wed, 14 Oct 2026 11:31:50 +0000
X-Mizu-Trace-ID: 4a99d5c6d2f0ae41
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
Subject: [PATCH bpf-next v2 1/7] bpf: Determine freplace staticness from BTF linkage
Date: Wed, 14 Oct 2026 19:30:37 +0800
Message-ID: <20261014113043.640435-2-kafai.wan@linux.dev>
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

bpf_check_attach_target() rejects a freplace whose target is a static
function, using the subprog "unreliable" flag as a proxy for "static".
That flag is raised whenever a subprogram's BTF prototype disagrees with
the registers at its call site.

`147400e9c27c ("bpf: Compute parameters liveness in
bpf_compute_live_registers()")` made that work for static callees: a
static function with an unused argument no longer matches its BTF
prototype at the call site and is marked unreliable.

Since LLVM commit `29b36a16f111 ("[BPF] Emit ABI-accurate BTF
prototypes for DW_CC_nocall")` in 23.1 [1] that premise is gone:
BTFDebug may now drop arguments removed by the optimizer, so for

	__noinline static int subprog(struct __sk_buff *ctx)
	{
		return bpf_ktime_get_ns();
	}

compiled with clang 23 the BTF describes subprog() as

	[75] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
	[76] FUNC 'subprog' type_id=75 linkage=static

There is then no argument left to compare, the subprog stays reliable,
and the check in bpf_check_attach_target() is skipped. The freplace is
then rejected by the later linkage check instead, reporting "subprog()
is not a global function", and the selftest "exceptions" fails.

Determine staticness from the BTF linkage instead, and keep the
unreliable check for global functions whose BTF does not match their
call site.

There is no functional change: freplacing a static function was rejected
before and is still rejected with the same -EINVAL. Selftest "exceptions"
is updated to match.

[1] https://github.com/llvm/llvm-project/pull/198426
Fixes: 147400e9c27c ("bpf: Compute parameters liveness in bpf_compute_live_registers()")
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 kernel/bpf/verifier.c                               | 3 ++-
 tools/testing/selftests/bpf/prog_tests/exceptions.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2f190abe34489..e9814e3ac370e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22079,7 +22079,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		}
 		conservative = aux->func_info_aux[subprog].unreliable;
 		if (prog_extension) {
-			if (conservative) {
+			if (aux->func_info_aux[subprog].linkage != BTF_FUNC_GLOBAL ||
+			    conservative) {
 				bpf_log(log,
 					"Cannot replace static functions\n");
 				return -EINVAL;
diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions.c b/tools/testing/selftests/bpf/prog_tests/exceptions.c
index cea01d638f6fc..1bd15c4c125ba 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions.c
@@ -333,7 +333,7 @@ static void test_exceptions_success(void)
 				       bpf_program__fd(skel->progs.exception_throw_subprog),
 				       "throwing_subprog"), "set_attach_target"))
 				goto done;
-		}), "throwing_subprog() is not a global function", 0);
+		}), "Cannot replace static functions", 0);
 
 	if (test__start_subtest("non-throwing extension -> non-throwing subprog"))
 		/* non-throwing extension -> non-throwing global subprog : OK */
-- 
2.43.0

