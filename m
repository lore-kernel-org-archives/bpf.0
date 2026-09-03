Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF50431A44
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455756; cv=none; b=meyZ0uySwoyRvjwCHM5tEpt2vTghPHPUQ+pI3uLT5/PDkRvbO8/7vvNScZZk18j6yqUr39RVf3yKs8qoubthDAn0QdTuM8JS/sVnqETJDFlKe38Qgg1fQ85Xh+IS+T4i54zXT0iL5DwanPjQ4hO2ilHeesD5/WWZtnpq81oNoQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455756; c=relaxed/simple;
	bh=3p86O8U84cS0E9duKs0DsYEf54l58uZSa4x7CmKf4Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeXbBA2WSwSmIO4y09htD3W0nhQqHfwAIg5xsBTjx/lJ7H6b6fote58m0G56PW5dFOF92SM0Z5K8c3NspGF76SVTAthPsMn+EC9SxZSeNECWA4nNg4pY4HQe5WJ9IXSDq1rk1Sq3txbzQRaMt6qUQk+ObEAA3aK3g8bmxVVsQvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRwKz8bj; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRwKz8bj"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-398b3c37877so41778a91.0
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788455754; x=1789060554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3j5UBKASEAKGY/HU/gRvW1lA7581/XMkr24NiM/6jVg=;
        b=lRwKz8bjprHSNPbWfKtgwnGSMRpnerxRJtkmawfx7DYpitXbBS7DFCeViKlwa6EH7V
         Yj4FA2k6eWBhjZoijDyvmLYyTi2CeNK5NRLilyxUUNxWFScDhjNfvrMmYbpcPIO/igj2
         Zl+2BxkVAFt68l1mjE4LOzeCIPzJJ1eUa2et1+xAF8C+D9Uu/M22hkbRJHIT7j4fo6Kp
         vswco76+4W68NC8CK2vXND5xqbywuR46cZVYHB3f2EALqe/jSWMXVUyswqaShNKVQoHs
         4ERV28/f46WRH1SGXu1ZDHKlbV9PKRyeqB9hBgs3bBJUyxOZal7eRHMh8aEAhen6PzrW
         1fQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788455754; x=1789060554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3j5UBKASEAKGY/HU/gRvW1lA7581/XMkr24NiM/6jVg=;
        b=X9rBMeTE6VmEoargdhAZ/1htY+8mmKdi/J3sJHLBk9AuXKDFTqed02dAB3s2IZxHKo
         w8moh+r2PdKZQ3UWpxtMOpvgABA8jTIePlTx9LQ1gqrMM1TXIz6uNBC+T8rj1OF/U+Vo
         9t9B3I+VSphIazassjI4KVjQm1N8UJKlW6esSfM3jG3erKIsEVmuHqu0jIZux6TGox2r
         uJXkaIEG2FWpjATePaEaA0O68s5sC9k5pEiCe+3CmBypkv6JAHJzgWGW4ccv54zrzJrv
         wXQum/CMyicoVvcpx4ydwInZisaL9/9hj93Krh5sNtLoo6K3B4OjDkf58aRt1W8h3QsZ
         f7OA==
X-Gm-Message-State: AFuF++kk9MNGFLD47UKqn8ZfChxrtd5zKRC2g3s4k0vNcVTV7bxHTwZ3
	jFmJdSg7xerhE7vJ4A+HK7IHLiY7RW9EhLTH7nxW50kLRsyJKw/bb07oFhytHQ==
X-Gm-Gg: AYBFou0XTwxHYCG58qTQN3q4uuWE8LbFj0SMCV4cg3Xfooz17VUgOHQr8D3dfjJsc0K
	upmuHISg6wSYhoRdbYQVm8YuDRfPgTANphFESD08Bc+Ix0CmE4H4enGhhejx6kC60fe50+BXtxQ
	lKJaBHW9nP2gnv9Igip+IK7dNyH7OrglwlwDLe6t4hadnmVgXOXrC0G1k3FIz09BLnXDb0SHG8t
	KBMGs2DVF9E5/6yT14/cs4PtTwlWeYrvtI4n69zdlWM+paAHDquswdP3eIjvksq+7OGgDDl1/IA
	dV/e7eHDn4/0bVTOnW4UN2j/Y81xaguIiNgR+dLjOOO9b2ac0cpnHTT1VGuIbEVIX2w2zuyuNPl
	VZ3O3UjtTHPOcoXCdD/h9WTLKHxOLr21sudoNrtt3/D9C4jTOzLUtasf2I8G3BbX/wsrIGQVubV
	Iu2i0pTXeMd1hVWC87jHvBaPi9aLpCU+xPV+2LzBrAV9Le0vh2jgSRHxJsGMy4URBGMI9vZw6UA
	iMGb3nHtPfEmT3Qx5hMbAOzmE4vG/rX5Xf2fWJuY26sdA==
X-Received: by 2002:a17:90b:2e50:b0:398:b426:ca4b with SMTP id 98e67ed59e1d1-39aee1a9994mr22881879a91.22.1788455753677;
        Thu, 03 Sep 2026 10:15:53 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::6:dba3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534d25sm354893eec.5.2026.09.03.10.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 10:15:53 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	npc@anthropic.com
Subject: [PATCH bpf 2/3] bpf: update disasm.c to print BPF_PROBE_ATOMIC as atomics
Date: Thu,  3 Sep 2026 10:15:40 -0700
Message-ID: <20260903171542.1438050-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903171542.1438050-1-eddyz87@gmail.com>
References: <20260903171542.1438050-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_convert_ctx_accesses() rewrites an atomic on an arena pointer from
BPF_STX | BPF_ATOMIC to BPF_STX | BPF_PROBE_ATOMIC, this patch adjusts
print_bpf_insn() to print such instructions as regular atomics with a
'probe_' prefix (instead of printing them as BUG_XX).

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/disasm.c | 47 ++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index b1a3fbe3fda5..3ce8d74b0e40 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -7,6 +7,9 @@
 
 #include "disasm.h"
 
+/* Only defined by the non-UAPI linux/filter.h, which this file cannot use. */
+#define BPF_PROBE_ATOMIC 0xe0
+
 #define __BPF_FUNC_STR_FN(x) [BPF_FUNC_ ## x] = __stringify(bpf_ ## x)
 static const char * const func_id_str[] = {
 	__BPF_FUNC_MAPPER(__BPF_FUNC_STR_FN)
@@ -226,57 +229,57 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				insn->imm);
 		}
 	} else if (class == BPF_STX) {
+		const char *probe_pfx = BPF_MODE(insn->code) == BPF_PROBE_ATOMIC ? "probe " : "";
+		bool atomic = BPF_MODE(insn->code) == BPF_ATOMIC ||
+			      BPF_MODE(insn->code) == BPF_PROBE_ATOMIC;
+
 		if (BPF_MODE(insn->code) == BPF_MEM)
 			verbose(cbs->private_data, "(%02x) *(%s *)(r%d %+d) = r%d",
 				insn->code,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg,
 				insn->off, insn->src_reg);
-		else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
+		else if (atomic &&
 			 (insn->imm == BPF_ADD || insn->imm == BPF_AND ||
 			  insn->imm == BPF_OR || insn->imm == BPF_XOR)) {
-			verbose(cbs->private_data, "(%02x) lock *(%s *)(r%d %+d) %s r%d",
-				insn->code,
+			verbose(cbs->private_data, "(%02x) %slock *(%s *)(r%d %+d) %s r%d",
+				insn->code, probe_pfx,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off,
 				bpf_alu_string[BPF_OP(insn->imm) >> 4],
 				insn->src_reg);
-		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
+		} else if (atomic &&
 			   (insn->imm == (BPF_ADD | BPF_FETCH) ||
 			    insn->imm == (BPF_AND | BPF_FETCH) ||
 			    insn->imm == (BPF_OR | BPF_FETCH) ||
 			    insn->imm == (BPF_XOR | BPF_FETCH))) {
-			verbose(cbs->private_data, "(%02x) r%d = atomic%s_fetch_%s((%s *)(r%d %+d), r%d)",
-				insn->code, insn->src_reg,
+			verbose(cbs->private_data, "(%02x) %sr%d = atomic%s_fetch_%s((%s *)(r%d %+d), r%d)",
+				insn->code, probe_pfx, insn->src_reg,
 				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
 				bpf_atomic_alu_string[BPF_OP(insn->imm) >> 4],
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off, insn->src_reg);
-		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
-			   insn->imm == BPF_CMPXCHG) {
-			verbose(cbs->private_data, "(%02x) r0 = atomic%s_cmpxchg((%s *)(r%d %+d), r0, r%d)",
-				insn->code,
+		} else if (atomic && insn->imm == BPF_CMPXCHG) {
+			verbose(cbs->private_data, "(%02x) %sr0 = atomic%s_cmpxchg((%s *)(r%d %+d), r0, r%d)",
+				insn->code, probe_pfx,
 				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off,
 				insn->src_reg);
-		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
-			   insn->imm == BPF_XCHG) {
-			verbose(cbs->private_data, "(%02x) r%d = atomic%s_xchg((%s *)(r%d %+d), r%d)",
-				insn->code, insn->src_reg,
+		} else if (atomic && insn->imm == BPF_XCHG) {
+			verbose(cbs->private_data, "(%02x) %sr%d = atomic%s_xchg((%s *)(r%d %+d), r%d)",
+				insn->code, probe_pfx, insn->src_reg,
 				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off, insn->src_reg);
-		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
-			   insn->imm == BPF_LOAD_ACQ) {
-			verbose(cbs->private_data, "(%02x) r%d = load_acquire((%s *)(r%d %+d))",
-				insn->code, insn->dst_reg,
+		} else if (atomic && insn->imm == BPF_LOAD_ACQ) {
+			verbose(cbs->private_data, "(%02x) %sr%d = load_acquire((%s *)(r%d %+d))",
+				insn->code, probe_pfx, insn->dst_reg,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->src_reg, insn->off);
-		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
-			   insn->imm == BPF_STORE_REL) {
-			verbose(cbs->private_data, "(%02x) store_release((%s *)(r%d %+d), r%d)",
-				insn->code,
+		} else if (atomic && insn->imm == BPF_STORE_REL) {
+			verbose(cbs->private_data, "(%02x) %sstore_release((%s *)(r%d %+d), r%d)",
+				insn->code, probe_pfx,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off, insn->src_reg);
 		} else {
-- 
2.55.0

