Received: from mta1.migadu.com (out-96.mta1.migadu.com [95.215.58.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A9B36197E
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 02:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790734141; cv=none; b=Eo5i8Ng3RWUZGC0NP2Z48qgHM3GbdgNEEIoFjbMSlHibBTFYN1U7/3Iw1nuDEfYed61WDfCXYbsX4bMGjkNoPEY6cGSjjGCXGyO1J6YrhDVw6AJ4HDnUhgtOQMXyTfZNOoLPhSrQXuGdAFfHMM0/zD5IbD0lX+EQg2jzDI/ygMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790734141; c=relaxed/simple;
	bh=EhJ1kOqQWb77/CgBIh3EhtTAgoS/f6wLGpATIyZVt8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uPJtFya8nOVlN4Zxm9s4q0EXHAmbDFudkKMhL3aCOLMAqSa6owQWZl8faszNCsw/wfi9ei5+lobSyk6wnLDTx+DDbwmfrZ+odathTf+ntUU2SVnQ+MP65XLPD7UDEWD1Vr8VxM2Nlgg/rvkVzYr6iC5pAhhJpuY79WSvDdI6G5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FpxqQqnA; arc=none smtp.client-ip=95.215.58.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FpxqQqnA"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EhJ1kOqQWb77/CgBIh3EhtTAgoS/f6wLGpATIyZVt8M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790734138; v=1; x=1791338938;
 b=FpxqQqnAO9FA1yAWCz1gyDbLNTwyoTh9Mxm3XNLuwuCtdIlr34ytRANfoe9hilucphSGCDLS
 IGU7x9dVXSzmyot2uQhcbX1TiuL8WTdzf1lseapmWqL7TdRSRMojsx1ZhT3mLoh2snRdtAccwo9
 I0YJ3mGJRRYNvmoSfahBmeW0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6557dd49c07b39e3;
	Wed, 30 Sep 2026 02:08:58 +0000
X-Mizu-Trace-ID: 6557dd49c07b39e3
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v1] selftests/bpf: Skip callx switch table test for clang-22 with cpu=v4
Date: Tue, 29 Sep 2026 19:08:51 -0700
Message-ID: <20260930020851.71691-1-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang-22 miscompiles call_by_switch() when targeting -mcpu=v4: it turns
the switch into an array of pointers to functions and then erroneously
removes the array in BPFAsmPrinter::doFinalization(), breaking the build
with:

  error: Undefined temporary symbol .Lswitch.table.call_by_switch

Fixed by llvm commit 9fc458a1d95b ("[BPF] Fix erroneous removal of
non-jump-table globals"), first released in clang-23; older clangs are
fine. test_progs-cpuv4 is built by default whenever clang supports v4,
so selftests/bpf fails to build with any clang-22 release. Guard just
this test with the compiler/cpu check and leave a __skip placeholder
for the broken combination, so the gap is reported as SKIP instead of
silently missing.

Fixes: b018e998e645 ("selftests/bpf: Add tests for callx through pointers in read-only data")
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../bpf/progs/verifier_callx_rodata.c         | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
index db3169a1ddf6..3e7a1c2c2a9a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
@@ -803,6 +803,14 @@ int callx_c_ops_selected(void *ctx)
 	return use_shape(ops, 3);
 }
 
+/*
+ * clang-22 with -mcpu=v4 drops the lookup table it builds for this switch
+ * ("Undefined temporary symbol .Lswitch.table.call_by_switch").
+ * Fixed in clang-23 by llvm commit 9fc458a1d95b.
+ *
+ * https://github.com/llvm/llvm-project/commit/9fc458a1d95b
+ */
+#if __clang_major__ != 22 || __BPF_CPU_VERSION__ < 4
 /* the compiler might turn the switch into a table that has no symbol */
 static __noinline int call_by_switch(unsigned int idx, int x)
 {
@@ -847,6 +855,18 @@ int callx_c_switch_table(void *ctx)
 	return call_by_switch(op_idx - 8, 3);
 }
 
+#else
+
+SEC("socket")
+__skip("clang-22 bug with -mcpu=v4, switch table test cannot be built")
+__success
+int callx_c_switch_table(void *ctx)
+{
+	return 0;
+}
+
+#endif
+
 /*
  * Misaligned pointers to functions are ignored, the rest of the data is
  * accessible as before. The program doesn't have callx, so libbpf doesn't

base-commit: cc6010e6e5cbe1f743d3011991041f227d976a5e
-- 
2.50.1

