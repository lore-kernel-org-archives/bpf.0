Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D173D3338
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137494; cv=none; b=d/eMsGrwHfkwQoJVZtjNaMlbNEiknybdaM3eJL6jWJxZQTPebgl+1kZZK2fqUczrPE4KexejCQ/4tBDj18yACB9noZbV5kKcLO7TU5/K+AeeLFWhjBiCkeJkX28srY5U52wN4vIikhJgatNj5ZdxlHnQX8SIunC2tPAeBm7rsvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137494; c=relaxed/simple;
	bh=LG8aVkPS+1Gukg+64+iDQOxJobsKnPSvG4yGUYO2C00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzmsCRtuKdamzuW9T1OUTel3xFn8MiObdgXkUon+Pi6iroTJTdpz6kSFs188g3AG3hef3IA5y2OyFaubdQKZsCWHJJpVbjR91IWQdPGSPXDOpea7XV77/+ihUq9xsdPF2XFVQrEEOavhRB4XW+wmmvc60kVSC1sEFvwbkRepK/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjJ/6+A7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjJ/6+A7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F916C19425;
	Tue,  3 Feb 2026 16:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770137493;
	bh=LG8aVkPS+1Gukg+64+iDQOxJobsKnPSvG4yGUYO2C00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VjJ/6+A7TWLuWy0nzu0O6/UURwtouvrTSbEhpHAmDgygJDdDhCWzsXbIKAwsWop3e
	 8n+oXPGQMPV1jqwOHzl61t/mMgDtxCbEaOHq7SngvYY1DOE7lool3wnGV95CWqYZ7e
	 kSDXDHVb2VJGTLVqNiCpbOj2ENNdcZiarIQxvTKyEc1dHrW1kAj/iY0t7age7u+Os+
	 w74qdWRhmItzKsvWSIQxnFj6n/AIAFb/CWjm1xGY35/p15YrGjU+0omKKzVkrxbeAb
	 4xrEWa2yqnCJzmrsD/xl4XFFAgxasiNsVSNgpETSGrwT9+sOx1hhTPFgu+O5z7Ia9c
	 kSRqeiNaE768w==
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
Subject: [PATCH bpf-next v3 5/5] selftests: bpf: verifier_scalar_ids: Add a test for ids=0
Date: Tue,  3 Feb 2026 08:51:01 -0800
Message-ID: <20260203165102.2302462-6-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203165102.2302462-1-puranjay@kernel.org>
References: <20260203165102.2302462-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that two registers with their id=0 (unlinked) in the cached state
can be mapped to a single id (linked) in the current state.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/progs/verifier_scalar_ids.c | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index c8f8820336b7..3072fee9a448 100644
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
+	 * Verifier considers such states equivalent.
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

