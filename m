Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616FB40D575
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 23:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781048065; cv=none; b=feVuyRAt8XIHCRaF6jOlQHhtYQklwZzu+FEBJCCsbpjS5XQr851I/PklHwrKFs2FP8rSOKhUv1/sq7YMiKpnMngFDwCmHQU4eJ/QVv5ZCJ7pJo3P3dHx9Lf8bd5s5G7CETvFpcIugPGQ4bP5x6uNDPoklXgM5/qvPrcVqJBBAic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781048065; c=relaxed/simple;
	bh=6ps0bp3uQidt2QvwsUpndv9HP73P9xVNu1acTXZapXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOvpmGYEoAoWz9bVZjZz2I6OB7jbWyOBNU3pXwjjwe3quWU//LXH1vd9ib+6ZuRBRvEoQS5o2GzVcuCB00JmLe2aDf3aDggSlQrd3jHV+5W6hpb49me7dmWbPlBT1Luqy3QgKrs8NlMXO97rGKyHKqcZU5ZOleP6sqd/+UXgYZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 3BB6414B04B95F; Tue,  9 Jun 2026 16:34:12 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Adjust fexit_bpf2bpf ctx layout for llvm23 true signature
Date: Tue,  9 Jun 2026 16:34:12 -0700
Message-ID: <20260609233412.2712178-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260609233402.2711071-1-yonghong.song@linux.dev>
References: <20260609233402.2711071-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

test_pkt_access_subprog2() is defined in C as

  int test_pkt_access_subprog2(int val, volatile struct __sk_buff *skb)

but llvm optimizes away the unused 'int val' argument. Before llvm23 the
BTF signature did not match the optimized assembly, so the verifier set
attach_func_proto to NULL and fell back to MAX_BPF_FUNC_REG_ARGS (5) u64
arguments (see btf_ctx_access()). The fexit ctx struct therefore placed
the return value after args[5].

With llvm23 the 'true' signature

  int test_pkt_access_subprog2(volatile struct __sk_buff *skb)

is recorded in BTF, so nr_args becomes 1 and the return value moves to
the slot right after args[1]. Select the matching args_subprog2 layout
based on __clang_major__ so the test works with both old and new llvm.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c b/tools/te=
sting/selftests/bpf/progs/fexit_bpf2bpf.c
index 983b7c233382..f4bbf87b82dd 100644
--- a/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c
@@ -53,14 +53,23 @@ int BPF_PROG(test_subprog1, struct sk_buff *skb, int =
ret)
  *   r0 =3D *(u32 *)(r1 + 0)
  *   w0 <<=3D 1
  *   exit
- * In such case the verifier falls back to conservative and
+ * Before llvm23, in such case the verifier falls back to conservative a=
nd
  * tracing program can access arguments and return value as u64
- * instead of accurate types.
+ * instead of accurate types. With llvm23, the true signature
+ *   int test_pkt_access_subprog2(volatile struct __sk_buff *skb)
+ * is available in btf.
  */
+#if __clang_major__ >=3D 23
+struct args_subprog2 {
+	__u64 args[1];
+	__u64 ret;
+};
+#else
 struct args_subprog2 {
 	__u64 args[5];
 	__u64 ret;
 };
+#endif
 __u64 test_result_subprog2 =3D 0;
 SEC("fexit/test_pkt_access_subprog2")
 int test_subprog2(struct args_subprog2 *ctx)
--=20
2.53.0-Meta

