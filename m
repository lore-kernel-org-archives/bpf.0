Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0F92931E6
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633615; cv=none; b=aABft15uw9CJBwkaCpNjFjxrXe99Ek7aEnvrv74uuUxD0EKzeGkZwuc4fMGODbmtMUerRm0H0hcnGrkiXnek5aRvhXzD42BfD5WSWY64UjZYz3jx3vT2w+hbo8BRPvAAQXA9Rt6LdZx+CRRJxuqmJ1lKaI+nivbh2DEhK1w5a+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633615; c=relaxed/simple;
	bh=ff2jCNIGJ9xQ5GweSmok1wIOV1Q3gF8lWeAUxHe3BfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dLSqHcjoGeqw0Gi8fzgrafc4bi2cbDms1M/zae/71JcmVwYBSTyT/hygBKmaRKuBxPibnZxPMoZVqcL/6KAUxURaYUgBhMyWnXno+ElKzAJD8oFt2+XtReuigvhzCm1NLTCTLnlRa6pU0oCywGpqfHDQeymRCvzQ6sXzDJO6wrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 683A523D4C4F0D; Thu, 13 Aug 2026 08:06:41 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH] selftests/bpf: Fix chained_global_func_calls_success() for cpu v4
Date: Thu, 13 Aug 2026 08:06:41 -0700
Message-ID: <20260813150641.3347662-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The chained_global_func_calls_success() test hardcodes the instruction
counts reported by the verifier's per-subprog stats:

  subprog {{[0-9]+}} (global_good) global insns_self 5 insns_total 5 stac=
k
  processed 14 insns

global_good() does 'return arr[0]', where arr[] is an int array and the
return type is long. Without cpu v4 this is a zero-extending load
followed by a <<32/s>>32 sign-extension pair. With -mcpu=3Dv4 llvm emits =
a
single sign-extending load instead:

  18: (18) r1 =3D 0xffa00000008eb000
  20: (81) r0 =3D *(s32 *)(r1 +0)
  21: (95) exit

so the subprog is 3 insns rather than 5, and the whole program is
12 processed insns rather than 14. test_progs-cpuv4 fails with:

  EXPECTED    REGEX: 'subprog {{[0-9]+}} (global_good) global insns_self =
5 insns_total 5 stack'
  #606/1   verifier_global_subprogs/chained_global_func_calls_success:FAI=
L

Select the expected counts based on __BPF_CPU_VERSION__.

Fixes: c2e6c7de8830 ("bpf: Show more useful info in stack depth stats")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/verifier_global_subprogs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c=
 b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 7b65eea97ebc..966f49348787 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -54,8 +54,13 @@ __msg("Validating global_good() func")
 __msg("('global_good') is safe for any args that match its prototype")
 __msg("subprog 0 (chained_global_func_calls_success) main insns_self 7 i=
nsns_total 7 stack")
 __msg("subprog {{[0-9]+}} (global_calls_good_only) global insns_self 2 i=
nsns_total 2 stack")
+#if defined(__BPF_CPU_VERSION__) && __BPF_CPU_VERSION__ >=3D 4
+__msg("subprog {{[0-9]+}} (global_good) global insns_self 3 insns_total =
3 stack")
+__msg("processed 12 insns")
+#else
 __msg("subprog {{[0-9]+}} (global_good) global insns_self 5 insns_total =
5 stack")
 __msg("processed 14 insns")
+#endif
 int chained_global_func_calls_success(void)
 {
 	int sum =3D 0;
--=20
2.53.0-Meta

