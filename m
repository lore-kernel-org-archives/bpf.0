Received: from mta1.migadu.com (out-222.mta1.migadu.com [95.215.58.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EC72D2385
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792284938; cv=none; b=KVKPNPQ4jY99nX5sCrsqzXqFySkmRdjGUGIeCDFTmNw6ugMN1AcZVfRPF+Q/OSpEnzzr1OjFbiy5fDaqILZT2Gp97MqPf6Mz7VJTh9B2m5jHb3zyCiQCdqQvNRTSUVsx3h4ZVanBmk5ni5Wwv5cInnXzTHI0bI/XvdqbRpViKqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792284938; c=relaxed/simple;
	bh=HKl8BtwrGEdbKND/Li3gr4MtxNocGx9qEL6mblvf5R8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Swbk9YIKU38cdrx8bONhQgo8UZUTfScZLdw47zvu9ESXCc5dwG+Dipl8qc1TZl3tCrP/iwgdk+rnOkPjqBANHaVHpyx4UluOWGZzrIWsYPsO1xqhk8QJRvG2PF+Lvt8uuOoFrO9zyFR9ojOC7KoPbsA5xVU+iqHtmpK6F4H5w8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S58R96KQ; arc=none smtp.client-ip=95.215.58.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S58R96KQ"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HKl8BtwrGEdbKND/Li3gr4MtxNocGx9qEL6mblvf5R8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792284934; v=1; x=1792889734;
 b=S58R96KQJvDaKryZX/rUFTlJtw5yD5aarvDtEWF7q3fpH0bCu2ESca9L/IPfxyfpLlOfKc3M
 dGIJiXeSAbRrQ2Hp1Mj3CI1kDqvLjrGOHqe75B+cPYeJgudBs0t1CWkK2qRUHn1pvdJ4+N+ACmu
 e7CBR+rzxoTZ/55w1XUrDaLQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id be5eabfb05022039;
	Sun, 18 Oct 2026 00:55:33 +0000
X-Mizu-Trace-ID: be5eabfb05022039
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
Subject: [PATCH bpf-next v3 2/4] selftests/bpf: Fix stack_arg precision backtracking log expectation
Date: Sun, 18 Oct 2026 08:53:46 +0800
Message-ID: <20261018005348.2195130-3-kafai.wan@linux.dev>
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

Commit 147400e9c27c ("bpf: Compute parameters liveness in
bpf_compute_live_registers()") stopped assuming that a call to a static
subprogram reads r1..r5 and now uses the callee's entry live-in. R1-R5 are
not live at these call insns, so __clean_func_state() clears them from the
caller state and the backtracked parent state prints as:

  mark_precise: frame0: parent state regs= stack=:  R10=fp0

Update both expectations accordingly.

Fixes: 147400e9c27c ("bpf: Compute parameters liveness in bpf_compute_live_registers()")
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 tools/testing/selftests/bpf/progs/stack_arg_precision.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/stack_arg_precision.c b/tools/testing/selftests/bpf/progs/stack_arg_precision.c
index 7baa9c1c8e31e..c9564776d7333 100644
--- a/tools/testing/selftests/bpf/progs/stack_arg_precision.c
+++ b/tools/testing/selftests/bpf/progs/stack_arg_precision.c
@@ -74,7 +74,7 @@ __msg("mark_precise: frame1: parent state regs= stack=:  frame1: R10=fp0")
 __msg("mark_precise: frame0: parent state regs= stack=:  R10=fp0")
 __msg("mark_precise: frame1: last_idx 11 first_idx 11 subseq_idx 13")
 __msg("mark_precise: frame1: regs= stack= before 11: (85) call pc+1")
-__msg("mark_precise: frame0: parent state regs= stack=:  R1=1 R2=2 R3=3 R4=4 R5=5 R10=fp0")
+__msg("mark_precise: frame0: parent state regs= stack=:  R10=fp0")
 __msg("mark_precise: frame0: last_idx 9 first_idx 7 subseq_idx 11")
 __msg("mark_precise: frame0: regs= stack= before 9: (05) goto pc+1")
 __msg("mark_precise: frame0: regs= stack= before 8: (7a) *(u64 *)(r11 -8) = 4")
@@ -95,7 +95,7 @@ __msg("mark_precise: frame1: parent state regs= stack=:  frame1: R10=fp0")
 __msg("mark_precise: frame0: parent state regs= stack=:  R10=fp0")
 __msg("mark_precise: frame1: last_idx 11 first_idx 11 subseq_idx 13 ")
 __msg("mark_precise: frame1: regs= stack= before 11: (85) call pc+1")
-__msg("mark_precise: frame0: parent state regs= stack=:  R1=1 R2=2 R3=3 R4=4 R5=5 R10=fp0")
+__msg("mark_precise: frame0: parent state regs= stack=:  R10=fp0")
 __msg("mark_precise: frame0: last_idx 10 first_idx 10 subseq_idx 11 ")
 __msg("mark_precise: frame0: regs= stack= before 10: (7a) *(u64 *)(r11 -8) = 6")
 __naked void stack_arg_precision_bpf2bpf(void)
-- 
2.43.0

