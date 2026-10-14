Received: from mta0.migadu.com (out-85.mta0.migadu.com [91.218.175.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF0B3EB7F0
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977525; cv=none; b=mCwC12BMhBhKL0rjU4gCMABKH7fYmjwTPgZ7a+nRaowh1zmVjEL9t4YAPbkhkRZ5W9liesP0IHbkN81v71bWp4UMmmAEn/RiYGmptHYHNgG9/wavPfiL91lLXi+3aD40qGJZG4/2U4k+BRO2R/VZ9IzGzGMIDnNVS0AZdif5nsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977525; c=relaxed/simple;
	bh=HKl8BtwrGEdbKND/Li3gr4MtxNocGx9qEL6mblvf5R8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+jc+Craiqs+0cUggQl8MQjOGIqjWCAPUZTzsZFqB8A2FwBfh5Ix0jBqhOOmx/2UfVu+GnxGZYRZMzom05DYkUGEgp3Rbt+aBpboTyI5XkZTQfVcVybFad9lbCukn6Y9hw8kQj8HRbj8iCZPF5QuBfPvmZPXNuoE1EIrdMWPnwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EpY1vrR7; arc=none smtp.client-ip=91.218.175.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EpY1vrR7"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HKl8BtwrGEdbKND/Li3gr4MtxNocGx9qEL6mblvf5R8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791977520; v=1; x=1792582320;
 b=EpY1vrR77z+BM2bkeMFbBCEF8HiYxN0oSLpzsfzFk3RGI3ZCZtey4OALzYTTk0kVGi6cyIOw
 VpzByW6/VadnY+p1FzFfn3zrXVp0mCqrQIh1Tmdw9k7Rmn/y1dxS4fxmJv/pLU99R5yQlNjVCvS
 lgSGv5DrMiBiaQlyy0TJdg8k=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id d40ef85041f235d7;
	Wed, 14 Oct 2026 11:31:59 +0000
X-Mizu-Trace-ID: d40ef85041f235d7
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
Subject: [PATCH bpf-next v2 2/7] selftests/bpf: Fix stack_arg precision backtracking log expectation
Date: Wed, 14 Oct 2026 19:30:38 +0800
Message-ID: <20261014113043.640435-3-kafai.wan@linux.dev>
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

