Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B092480942
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785944061; cv=none; b=KREKnKkpWddFHr+Dk4FMA4xZycwXY+C0Uny2znr0f5llVF3FPHZkQxgc4NOF6hAzywXuxyHyPlMAK8Cy+ZD+eiyiBKVYiJNB+fMEh3xwI8AUW8QcsIRsg2RKRkMF6mQcPNxXG8sps8m9atu4lWfobOGJVjyTnbqqXW/tBE/2YiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785944061; c=relaxed/simple;
	bh=Zs5H7cMZtG2P7oyTZ5Hzw070uiL1GvEuUmtkmYsw1Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IU5yELnwN+Xzhxgh8gUM2oCMsUCi0SVD9LvFTSrQlbwlvKrrcSpqrSybe897JToqW7jFOZQlu6vvgXUwPFLCKnlb9mawnXfMqHwzm+LVUcmxHKuyA0fDETC6BwmQlHZql26Er9hGF/Di26fstRcKivahDAt4OTxQTyZAj0Hes+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S6pqvAhI; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S6pqvAhI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785944051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WnTpfffi4HdZULUYUzgBmCgy+bFF8M6Arvi3UvMRAbA=;
	b=S6pqvAhIwMTsIqnNLnQF1Ivu93hQYpIr+BbFAlZ5ZJS1XnW13skP/I/vcoFR0jQIGL64D4
	1uQft4YPgu3MhSanztPn/e0lcl2iBmIuOHPK0PfMbMFZZUTjErRbMWk1EO2ls1udx7lG/u
	EE5UL12Bsxi+3I0gXE0iBDq2OjOpclk=
From: Kaitao Cheng <kaitao.cheng@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Test module kfunc calls under spin lock
Date: Wed,  5 Aug 2026 23:33:40 +0800
Message-ID: <20260805153340.34776-4-kaitao.cheng@linux.dev>
In-Reply-To: <20260805153340.34776-1-kaitao.cheng@linux.dev>
References: <20260805153340.34776-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kaitao Cheng <chengkaitao@kylinos.cn>

The verifier uses kfunc registration flags to decide whether a kfunc may
be called while a BPF program holds a bpf_spin_lock.

Mark bpf_testmod_test_mod_kfunc() as KF_SPINLOCK_SAFE and verify that it
can be called while holding a bpf_spin_lock. Also attempt to call the
unmarked bpf_kfunc_trigger_ctx_check() under the lock and verify that the
program is rejected.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/kfunc_call.c  |  2 ++
 tools/testing/selftests/bpf/progs/kfunc_call_fail.c  | 12 ++++++++++++
 tools/testing/selftests/bpf/progs/kfunc_call_test.c  | 12 ++++++++++++
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c |  2 +-
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
index 7af5560f2a08..2b39cc1b09f9 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -71,8 +71,10 @@ static struct kfunc_test_params kfunc_tests[] = {
 	TC_FAIL(kfunc_call_test_get_mem_fail_not_const, 0, "is not a const"),
 	TC_FAIL(kfunc_call_test_mem_acquire_fail, 0, "acquire kernel function does not return PTR_TO_BTF_ID"),
 	TC_FAIL(kfunc_call_test_pointer_arg_type_mismatch, 0, "R1 expected pointer to ctx, but got scalar"),
+	TC_FAIL(kfunc_call_test_spin_lock_unsafe, 0, "function calls are not allowed while holding a lock"),
 
 	/* success cases */
+	TC_TEST(kfunc_call_test_spin_lock_safe, 0),
 	TC_TEST(kfunc_call_test1, 12),
 	TC_TEST(kfunc_call_test2, 3),
 	TC_TEST(kfunc_call_test4, -1234),
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_fail.c b/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
index 64b6a0b0ab1c..7e93f7fb1329 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
@@ -4,6 +4,18 @@
 #include <bpf/bpf_helpers.h>
 #include "../test_kmods/bpf_testmod_kfunc.h"
 
+static struct bpf_spin_lock kfunc_call_lock SEC(".data.A");
+
+SEC("?tc")
+int kfunc_call_test_spin_lock_unsafe(struct __sk_buff *skb)
+{
+	bpf_spin_lock(&kfunc_call_lock);
+	bpf_kfunc_trigger_ctx_check();
+	bpf_spin_unlock(&kfunc_call_lock);
+
+	return 0;
+}
+
 struct syscall_test_args {
 	__u8 data[16];
 	size_t size;
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test.c b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
index 5edc51564f71..8e6560c31e78 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
@@ -5,6 +5,18 @@
 #include "bpf_misc.h"
 #include "../test_kmods/bpf_testmod_kfunc.h"
 
+static struct bpf_spin_lock kfunc_call_lock SEC(".data.A");
+
+SEC("tc")
+int kfunc_call_test_spin_lock_safe(struct __sk_buff *skb)
+{
+	bpf_spin_lock(&kfunc_call_lock);
+	bpf_testmod_test_mod_kfunc(42);
+	bpf_spin_unlock(&kfunc_call_lock);
+
+	return 0;
+}
+
 SEC("tc")
 int kfunc_call_test5(struct __sk_buff *skb)
 {
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index eb0f9b5e18d8..0585794606ed 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1384,7 +1384,7 @@ __bpf_kfunc void bpf_kfunc_trigger_ctx_check(void)
 }
 
 BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
-BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
+BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc, KF_SPINLOCK_SAFE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
-- 
2.50.1 (Apple Git-155)

