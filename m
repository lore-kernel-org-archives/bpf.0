Received: from mta0.migadu.com (out-221.mta0.migadu.com [91.218.175.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054C2242D89
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 00:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792284957; cv=none; b=ez/r8QXtr2QektqazXPVccsbhEKmiIDrEDHe3JlHdLD9Ak5E/ZUOt0UbQVDca8yGXOrvkGLK+9JNvNpSKQPKtFMzQ4NtB9bhLPWsWk8onMDsTrzBDfsOdp6vDICAabk5I0R2k8jyGMlWr+maJgPG4RN1Jpff0w/cMZNSd7yt/tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792284957; c=relaxed/simple;
	bh=APFwl/HiItu/QCD6VtNINOJAd0UoIdFGyY4WR9sMH7o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7YtYWs3FsznL+wqJEhMZZ5twc/drzFwv5/MZqANy0KhYKv7rT44Fg6rzkixxeyCrceKM6hnoT/ZUqNSWrcFWwACcbFw+Fw+JyNsQFYSwCYyylY4v43T83ZAoxAAFtxIsVzElR4XnBjP9CFZAuh0zKdsDKWH1WSL+xkNNlj6ZXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mM83M+Bt; arc=none smtp.client-ip=91.218.175.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mM83M+Bt"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=APFwl/HiItu/QCD6VtNINOJAd0UoIdFGyY4WR9sMH7o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792284954; v=1; x=1792889754;
 b=mM83M+Bt3J7eYmTcQR3Z7zI2VSiN9CGp/GvZCNm1g2LjkyUQGXvQYd+QoGYEEMzpkHqC1667
 Iot8HUEvEMn+kp20aMxZ+AIU/JAnlpUmisXd37cYnwU+kQAZpfugegrB/4QUEQW3nGlKyDif1Ug
 wWopGTSKLNx9jjJA538a9ZDM=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id e9275ec6c32b6a9a;
	Sun, 18 Oct 2026 00:55:53 +0000
X-Mizu-Trace-ID: e9275ec6c32b6a9a
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
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: Use _exit() in uprobe_multi_test clone-ed child
Date: Sun, 18 Oct 2026 08:53:48 +0800
Message-ID: <20261018005348.2195130-5-kafai.wan@linux.dev>
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

child_func() terminates with exit(), but spawn_child_flag() also starts
it via clone(CLONE_VM), which shares the parent's address space. That
exit() then runs atexit handlers and static destructors against globals
the parent is still using.

LLVM commit `3c3ed59c6a2a ("[llvm] Add format check for
MCSubtargetFeatures")` [1], included in the LLVM 23.1 releases, added
Target::isValidFeatureListFormat() with a function-local static holding
the compiled regex:

	static const llvm::Regex pattern("^([+-][^,]+)(,[+-][^,]+)*,?$");
	return pattern.match(Features);

The child exit destroys that static while its guard variable still marks
it as initialized, so the regex is never rebuilt in the parent. From that
point on, get_jited_program_text() gets NULL from
LLVMCreateDisasmCPUFeatures(), so every jited program text check in the
tests running after filter_clone_vm fails, e.g. "verifier_jit_convergence",
"verifier_private_stack", "verifier_tailcall_jit" and "verifier_jit_inline".

Use _exit(), which runs neither atexit handlers nor static destructors, as
uprobe_syscall.c already does for its own CLONE_VM child.

[1] https://github.com/llvm/llvm-project/pull/180943
Fixes: d2520bdb1932f ("selftests/bpf: Add uprobe multi pid filter test for clone-ed processes")
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index f0baf5738b751..7fbcfddc3cc36 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -94,14 +94,14 @@ static int child_func(void *arg)
 	/* wait for parent's kick */
 	err = read(child->go[0], &c, 1);
 	if (err != 1)
-		exit(err);
+		_exit(err);
 
 	uprobe_multi_func_1();
 	uprobe_multi_func_2();
 	uprobe_multi_func_3();
 	usdt_trigger();
 
-	exit(errno);
+	_exit(errno);
 }
 
 static int spawn_child_flag(struct child *child, bool clone_vm)
-- 
2.43.0

