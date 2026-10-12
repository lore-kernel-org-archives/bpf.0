Received: from mta0.migadu.com (out-145.mta0.migadu.com [91.218.175.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE233033E6
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813448; cv=none; b=gVAAWDktwcg7SPbHFdOW3LyDTy3Q3xfu6yOk3P0jGUs28Z5rZvReK1pM51U/Ks+Rku9Auvt7tqRAtULz6Hn0wep12EFR38sf6rFxALQr+HL7zQzq8dcwYUJBMDldr/EAIy3Fo4nkS9usaxDRIubYGX3/TRmdiyz8qDid9iOfr8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813448; c=relaxed/simple;
	bh=x6wBnpNMUdYNXU0gqwEl8PQ7hY4EkntWRDU828VTuOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fWze3Krw1bfLb5XXRv3M1pQYpjNNeYrIbNjUnJ6d70krYKlDpBLidO5m+ZiW9pmrDbccy3R0ljJeOQrj5MdAqbIVrp4f17QC8ROUs6BW1ME/KhfWcLUVvUliHJGYGvy6Hni1gbYeuGNMmTJP0BF/ufnMQTBi7lm+KkqujMup+WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vrxvn3+Q; arc=none smtp.client-ip=91.218.175.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vrxvn3+Q"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=x6wBnpNMUdYNXU0gqwEl8PQ7hY4EkntWRDU828VTuOY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791813443; v=1; x=1792418243;
 b=vrxvn3+Q+ds8vw3lPoTlz4TGkW2K6r5QQ68mgXDaRPV19sO6QMRSFumWsX60JHhnwUiv1rSR
 9lixhWfWMj8fA2dIBHiDnXq5FLB9UGqul2WUxMdwVCR6WWC/E3g+Xjht3feMCN68ruUQw+necOM
 90oRH+AdEABQsohw9hlQyPlg=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 34a32a671e085a21;
	Mon, 12 Oct 2026 13:57:23 +0000
X-Mizu-Trace-ID: 34a32a671e085a21
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
	Menglong Dong <menglong8.dong@gmail.com>,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Cc: KaFai Wan <kafai.wan@linux.dev>
Subject: [PATCH bpf-next 1/1] bpf: Determine freplace staticness from BTF linkage
Date: Mon, 12 Oct 2026 21:56:24 +0800
Message-ID: <20261012135624.2749743-1-kafai.wan@linux.dev>
X-Mailer: git-send-email 2.43.0
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
prototypes for DW_CC_nocall")` in 23.1.0 [1] that premise is gone:
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
index 2f190abe3448..e9814e3ac370 100644
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
index cea01d638f6f..1bd15c4c125b 100644
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

