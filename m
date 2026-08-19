Received: from mta0.migadu.com (out-29.mta0.migadu.com [91.218.175.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACEC30274D
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144348; cv=none; b=ZcO2MkOJTJSO4FWmDMOoMvX/i7tbHNFak1vd04vzTel19XFBuTUKmnB7QF+rw0JJhpgCS2Ui3t2qpQ0jPVzgcGSL6Q5rZCo1rvXg6b6TjSZaFfM/Sxnm17vWju50dOQgkujZpumncNEUNqUTvuGMgk+Zg7lppCTAcpW3hPICMmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144348; c=relaxed/simple;
	bh=YHHGpBQsh966A2uqbUVkWULPEk/gHXX6SwIBwmV9YFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czpoS30RN+TZq8xgysxuwHkHFy7OzUN8sfY/enxyqRl2hOSglWLSwIdKdfX/BYJVly4lKkAEZGCf3CjDfks0nWQLga9moCxWyNL42CAq/CInoXY8q2gx349UrunVOOBSkw5c/BxZ6Jv4zd/WndQIFzIn481ympI4F26CZJr0Nbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EAyGmQe7; arc=none smtp.client-ip=91.218.175.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EAyGmQe7"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YHHGpBQsh966A2uqbUVkWULPEk/gHXX6SwIBwmV9YFs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787144343; v=1; x=1787749143;
 b=EAyGmQe7DZtTspqnNDjXGKcexQc0LRcrfWuTqpfmsKin32FANB0FHaIZDR49BibPO409TRxY
 LbltMzF3A65sLAkgGILhJGxStT+1Zjv3UEHLRwA8FqPyf5oXCQagWrhQwZttAfXHm/0cTwEoQKn
 APc9Idn7uX0e/rn3hWUyi1jI=
X-Envelope-To: bpf@vger.kernel.org
Received: from localhost.localdomain (147.136.157.2)
	by smtp.migadu.com with ESMTPS id c005072b8a956614;
	Wed, 19 Aug 2026 12:59:03 +0000
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
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
	Paul Chaignon <paul.chaignon@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Wade <danjwade95@gmail.com>,
	KaFai Wan <kafai.wan@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 2/2] selftests/bpf: Add reg-invariants test for speculative pointer arithmetic
Date: Wed, 19 Aug 2026 20:58:30 +0800
Message-ID: <20260819125840.286434-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819125840.286434-1-jiayuan.chen@linux.dev>
References: <20260819125840.286434-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An unprivileged socket filter does variable pointer arithmetic on a
PTR_TO_MAP_VALUE whose offset collapses to a constant. The Spectre-v1
speculative path used to snapshot the pointer with a const offset and an
unbounded r32, which tripped reg_bounds_sanity_check() on the following
register move.

Mark the test __success_unpriv (the speculative path only runs
unprivileged) and flag it BPF_F_TEST_REG_INVARIANTS so the invariant
violation becomes a hard load failure. The unprivileged run fails without
the verifier fix and passes with it:

  verifier_bounds/spec_ptr_alu_const_offset @unpriv:FAIL   # without fix
  verifier_bounds/spec_ptr_alu_const_offset @unpriv:OK     # with fix

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 1a273e416fed..df8d5309657e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -2267,6 +2267,47 @@ __naked void deduce64_from_32_wrapping_32bit(void)
 	: __clobber_all);
 }
 
+/*
+ * Unprivileged variable pointer arithmetic on a PTR_TO_MAP_VALUE whose
+ * offset collapses to a constant. The Spectre-v1 speculative path snapshots
+ * the pointer while its r32 has just been blanked but its offset not yet
+ * synced; the following register move used to trip reg_bounds_sanity_check()
+ * ("const subreg tnum out of sync with range bounds"). With
+ * BPF_F_TEST_REG_INVARIANTS that violation turns into a load failure, so the
+ * unprivileged program must still load.
+ */
+SEC("socket")
+__success __success_unpriv
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void spec_ptr_alu_const_offset(void)
+{
+	asm volatile ("							\
+	call %[bpf_ktime_get_ns];					\
+	*(u64*)(r10 - 16) = r0;						\
+	r1 = 0;								\
+	*(u64*)(r10 - 8) = r1;						\
+	r2 = r10;							\
+	r2 += -8;							\
+	r1 = %[map_hash_8b] ll;						\
+	call %[bpf_map_lookup_elem];					\
+	if r0 == 0 goto l0_%=;						\
+	r1 = *(u64*)(r10 - 16);						\
+	r2 = 0x40000000;						\
+	if r1 > r2 goto l0_%=;						\
+	if r1 s> 1 goto l0_%=;		/* r1 in [0, 1] */		\
+	r0 += r1;			/* ptr += bounded scalar */	\
+	r9 = r0;			/* used to trip the warning */	\
+	*(u8*)(r0 + 0) = r1;						\
+l0_%=:	r0 = 0;								\
+	exit;								\
+	"
+	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
 /* Check that range_within() compares cnum ranges, not min/max projections. */
 SEC("socket")
 __failure __msg("div by zero")
-- 
2.43.0

