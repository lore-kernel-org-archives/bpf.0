Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE202BE05E
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611097; cv=none; b=q0jMIzfr33gsH1s/yKfMSOu2uyV/Y4UDTzMMnTJghse4xkQqmqTu2i4xkfC9Hy8T6OBlqNxaH95Y+M66Xpvz+WVx3t6oQVnJae7Sn5S2j322t2VGCBm0Zkmoy7lXl6ZoopsVPopnxrZixDFb7IGXf9TIqS1m0h0072r1m8ZW3VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611097; c=relaxed/simple;
	bh=pt9HBeKL8qkXJmO8cLBEpfksgzb/lOw+Nd0QjMpkqGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJ2BGl5Dp4RLxRNAiFfLaYVSLumyhuqdXRP3sLte5dSMxmvFIB1PRlCnS0eOswqLrlaQMmDFjbSqll9YE0aaR3FbdNH5aNLylHXm9IpkcGFsqZI2/Payo1H9T+JL1oPUlEuGano19eid5kOBWaQgbTBswg94AqcfAwMcMJro8tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=UnjfohhK; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="UnjfohhK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=11u+tFuHX6pC+XccwysqoTw5vNekJQSTd0XZM4DKlrE=; b=UnjfohhKMctYhSIjwmCdia48yt
	BX5oWG9B7aY/lRhFrbDq98uMliu27t4OTIEd9h4xLUVw5U5Ru4998yjSTAvdO/PiupHKhxK7nc+2a
	KQc5N55riNoNazx2DWsh44r75x7KSVEKj++2ONKXUl3R7eOgwaGNBxsPmJy7PX8WyIi/ihfqtvOpS
	ZTW9a2vzAO1Dw3QhUgs13n4XS+wBX4/AiMZlF09R7uUbEkLA1+59baLkzDZ1g9pJOPkuArEYptS6/
	GNV5au4/emNBNTfzM8VxlTWoYI1C5K7bCSANw2bNhErCeOheaqIBtml8O0GJS/M4ycDki0sCQteom
	C7/xvwKg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1whqiq-0007dd-3C;
	Thu, 09 Jul 2026 17:31:33 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: eddyz87@gmail.com
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test for scalar id on sign-extending stack fill
Date: Thu,  9 Jul 2026 17:31:31 +0200
Message-ID: <20260709153131.386599-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709153131.386599-1-daniel@iogearbox.net>
References: <20260709153131.386599-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28055/Thu Jul  9 08:25:20 2026)

Add a verifier test where a spilled scalar is filled once via a sign-
extending load (BPF_MEMSX) and once via a zero-extending load (BPF_MEM).
The two destination registers must not share a scalar id.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_scalar_ids
  [...]
  #643/1   verifier_scalar_ids/linked_regs_bpf_k:OK
  #643/2   verifier_scalar_ids/linked_regs_bpf_x_src:OK
  #643/3   verifier_scalar_ids/linked_regs_bpf_x_dst:OK
  #643/4   verifier_scalar_ids/linked_regs_broken_link:OK
  #643/5   verifier_scalar_ids/precision_many_frames:OK
  #643/6   verifier_scalar_ids/precision_stack:OK
  #643/7   verifier_scalar_ids/precision_two_ids:OK
  #643/8   verifier_scalar_ids/linked_regs_too_many_regs:OK
  #643/9   verifier_scalar_ids/linked_regs_broken_link_2:OK
  #643/10  verifier_scalar_ids/cjmp_no_linked_regs_trigger:OK
  #643/11  verifier_scalar_ids/check_ids_in_regsafe:OK
  #643/12  verifier_scalar_ids/check_ids_in_regsafe_2:OK
  #643/13  verifier_scalar_ids/no_scalar_id_for_const:OK
  #643/14  verifier_scalar_ids/no_scalar_id_for_const32:OK
  #643/15  verifier_scalar_ids/ignore_unique_scalar_ids_cur:OK
  #643/16  verifier_scalar_ids/ignore_unique_scalar_ids_old:OK
  #643/17  verifier_scalar_ids/two_nil_old_ids_one_cur_id:OK
  #643/18  verifier_scalar_ids/two_old_ids_one_cur_id:OK
  #643/19  verifier_scalar_ids/linked_regs_and_subreg_def:OK
  #643/20  verifier_scalar_ids/ldsx_fill_scalar_id_not_shared:OK
  #643     verifier_scalar_ids:OK
  Summary: 1/20 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/progs/verifier_scalar_ids.c | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index e38f102da45f..663d15fc5fd2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -4,6 +4,13 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, long long);
+} map_hash_8b SEC(".maps");
+
 /* Check that precision marks propagate through scalar IDs.
  * Registers r{0,1,2} have the same scalar ID.
  * Range information is propagated for scalars sharing same ID.
@@ -915,4 +922,53 @@ __naked void linked_regs_and_subreg_def(void)
 	: __clobber_all);
 }
 
+/*
+ * A scalar is spilled to the stack and then filled twice: once via a
+ * sign-extending load (BPF_MEMSX) into r4 and once via a zero-extending
+ * load (BPF_MEM) into r5. coerce_reg_to_size_sx() gives r4 a different
+ * value than the spilled/zero-extended siblings, so r4 must not keep the
+ * shared scalar id. Otherwise the later 'if r5 == 0x80000000' refines r4
+ * through sync_linked_regs() to a known 0x80000000, while at runtime r4
+ * is the sign-extended 0xffffffff80000000. The test turns that discrepancy
+ * into an out-of-bounds map value access (r4 >> 63 is believed 0 but is 1
+ * at runtime), which must be rejected.
+ */
+SEC("socket")
+__failure __msg("R0 max value is outside of the allowed memory range")
+__naked void ldsx_fill_scalar_id_not_shared(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	/* r7 = unknown u32, keep only bit 31 */	\
+	r7 = *(u32*)(r0 + 0);				\
+	r2 = 0x80000000 ll;				\
+	r7 &= r2;					\
+	/* link r6 and r7 via a fresh scalar id */	\
+	r6 = r7;					\
+	/* spill r7 (u32) to the stack */		\
+	*(u32*)(r10 - 8) = r7;				\
+	/* sign-extending fill: must drop the id */	\
+	r4 = *(s32*)(r10 - 8);				\
+	/* zero-extending fill: keeps the id */		\
+	r5 = *(u32*)(r10 - 8);				\
+	/* r5 becomes known 0x80000000 on fall-through */\
+	if r5 != r2 goto l0_%=;				\
+	/* verifier believes r4 == 0 here, runtime is 1 */\
+	r4 >>= 63;					\
+	r0 += r4;					\
+	r0 = *(u8*)(r0 + 7);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

