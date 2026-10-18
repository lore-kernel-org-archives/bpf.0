Received: from mta1.migadu.com (out-213.mta1.migadu.com [95.215.58.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A812ECD3A
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 00:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792284928; cv=none; b=Poxj1CkpgxnPElVn30bX8pa/kE9dUaeAqHWK+F6+Du4Wt3bpgaPSBOohnGyD9lqQqsHW85klWnAMfqConJA2Ibi5vs9mD5A8oRevURAvLrXiuphwj97zg4UGfaB8PCgCdjKklwTVUA8AjdABWGljD38wi6VPRMXKkDRXoub7LRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792284928; c=relaxed/simple;
	bh=cuCai43qHo6wk/ZaLeyiSAHCGVqMO6NDS2LjuU6aRIs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYeG4pOJHG3+MUiQ+JtqY9nnjY7tr+CNUtRW4KCsjeSQuJICL7MOgm0z5HCTCVBt8fWZ+ENrG2sfJkzNY3tozRuFPzYOiZWpwQDeyuFEEV2ovI0a94zBQl+MDZ+dfE7aGn6cNckRE2evjew7TTdKOTZ0o2p3irMPyQHXCHitMZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LpCKkSEJ; arc=none smtp.client-ip=95.215.58.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LpCKkSEJ"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cuCai43qHo6wk/ZaLeyiSAHCGVqMO6NDS2LjuU6aRIs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792284924; v=1; x=1792889724;
 b=LpCKkSEJrCAPKDikWuZ0S0sB2VPgzagprfHrFw0+ieiZsVX3VuyZ6foQkUp7FygYAN8rpu1i
 NaqcC7wdTiGCP1qkq921HdO2YFX72mEiM750FjTXzdXw9806Wny8oHbmqq2j6dZ2lri58vg/nps
 PaG/65g1jJFq2gAxttNVdd78=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id a6ffd5d94c9e89ed;
	Sun, 18 Oct 2026 00:55:13 +0000
X-Mizu-Trace-ID: a6ffd5d94c9e89ed
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
	Leon Hwang <leon.hwang@linux.dev>,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	KaFai Wan <kafai.wan@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Feng Jiang <jiangfeng@kylinos.cn>,
	Vineet Gupta <vineet.gupta@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH bpf-next v3 1/4] bpf: Determine freplace staticness from BTF linkage
Date: Sun, 18 Oct 2026 08:53:45 +0800
Message-ID: <20261018005348.2195130-2-kafai.wan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018005348.2195130-1-kafai.wan@linux.dev>
References: <20261018005348.2195130-1-kafai.wan@linux.dev>
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
index 2c812a5f1da87..519af2766032a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22228,7 +22228,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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

