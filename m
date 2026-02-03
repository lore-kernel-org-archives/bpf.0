Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9812F362B
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 02:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085391; cv=none; b=HZyj865Vh6kH63AbzK6czEjNHiu/XtpJtrodnXWPSG2U1wLPKHVSn4H6y6n3ZWIXMth3SCGul+pEReuVfSxrlJAsqZ+Fv5JDF9nyzA8Wz9DU1vwT2oBOftYLvVqo6DH84AI5+U5hK3nWeoQI5bic8Zp0T2k+YxNngRwK7fyXdMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085391; c=relaxed/simple;
	bh=ZSYBCd2W+blP+wAhiRAYH8CA6IAK2pR7v9XIBbRNGGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEGbh4gZu1QzX/xevjAsnnhyelei6CN5/3AWfnFef1VDiTV6YZGqZXOz1iLOank10QmQVMO6i5mvXtCeNNcpE1Mno97aOIeom5NCJmADSj/gpVdY9THD0MjreezVW91jcdqkrgvV+1f9Yi9fZd7zGJDSd39I76pKSn3JksZhdCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkvELOij; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkvELOij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD87C116C6;
	Tue,  3 Feb 2026 02:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770085390;
	bh=ZSYBCd2W+blP+wAhiRAYH8CA6IAK2pR7v9XIBbRNGGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kkvELOijVB8+ARRvra0YXRBmhXh/Q1nGmrd4C+0i461OSG3DR9uoN15KyYiLfyMtQ
	 sRl3+otIxXhYE2aQESQ5zBRZfpqKA2NLTY65F3uko2hIxZLrv2YVS5KC7KMYYL1JoO
	 pcAZ5Ez3AvY3w8ijvQEzt6bbXsUz1ffztFxQ88lfzT/EgWhnwq5WW9itkhym+t8J0X
	 puhUui04QZDfTCJ5Fhp1qnEQsK6AbENvxZ8Q4dH9o/sjPTDJI/dJ1+Qcw+QtO0QkgA
	 UGx/b7u+zo21IYlLnQ6N7akLhkMl//JvmzNgqiPnrvIjGD9sbOrQh0qY8qPwtXi9dT
	 H5Fn+FRlr9P/w==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v2 5/5] selftests: bpf: Add a test for ids=0
Date: Mon,  2 Feb 2026 18:22:28 -0800
Message-ID: <20260203022229.1630849-6-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203022229.1630849-1-puranjay@kernel.org>
References: <20260203022229.1630849-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that two registers with their id=0 (unlinked) in the cached state
can be mapped to a single id in the current state.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/progs/verifier_scalar_ids.c | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index c8f8820336b7..a67f2ce40e64 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -715,6 +715,51 @@ __naked void ignore_unique_scalar_ids_old(void)
 	: __clobber_all);
 }
 
+/* Check that two registers with 0 scalar IDs in a verified state can be mapped
+ * to the same scalar ID in current state.
+ */
+SEC("socket")
+__success __log_level(2)
+/* The states should be equivalent on reaching insn 12.
+ */
+__msg("12: safe")
+__msg("processed 17 insns")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void two_nil_old_ids_one_cur_id(void)
+{
+	asm volatile (
+	/* Give unique scalar IDs to r{6,7} */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	"r6 = r0;"
+	"r6 *= 1;"
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	"r7 = r0;"
+	"r7 *= 1;"
+	"r0 = 0;"
+	/* Maybe make r{6,7} IDs identical */
+	"if r6 > r7 goto l0_%=;"
+	"goto l1_%=;"
+"l0_%=:"
+	"r6 = r7;"
+"l1_%=:"
+	/* Mark r{6,7} precise.
+	 * Get here in two states:
+	 * - first:  r6{.id=0}, r7{.id=0} (cached state)
+	 * - second: r6{.id=A}, r7{.id=A}
+	 * Currently we don't want to consider such states equivalent.
+	 * Thus "exit;" would be verified only once.
+	 */
+	"r2 = r10;"
+	"r2 += r6;"
+	"r2 += r7;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 /* Check that two different scalar IDs in a verified state can't be
  * mapped to the same scalar ID in current state.
  */
-- 
2.47.3

