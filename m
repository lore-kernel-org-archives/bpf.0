Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716A33A05C4
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790465728; cv=none; b=o0B9jH22buMtRQP6Sryr6gkMI7yY3ibnDGf9Fx1zgOEkEpSVVHXqw488ehSSCO5uShPk2UUt/vHF+xX8yBC1c+xH5ktR74khTvH6av3hpyiXqKEDUY/7cUpcgaUJZ/uke5/VC/1iP0borofW4pTfWtQnYddmhVAPbLSHUl8yliQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790465728; c=relaxed/simple;
	bh=E2AuCmsXTK++8U0Kn7WnJ7Om+7zwIUgxEE+w99xm0zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqqRDiL5hbgtWY9RfkVqJFWxap3hsSomKEC5phEdJpt8UJXwfyHFmHwhja55KseuWju+wqnP5h/+3UQSRbpJ80WgN7dZBiJE7NQwB89p3h62Su5pVFvCwKLas9ia0HLle4DC+wtWgffGGeJOANTJ5WmKAek6jUe2SJdkf5KkFd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdDxSBz6; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdDxSBz6"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49ffd5111f2so3330605e9.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 16:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790465724; x=1791070524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OVQfxctZBAmzG6J0lcASmCkF/iklJ8Ai6u3dFnv6bp4=;
        b=DdDxSBz6rSw5NKbkwHZ/My2ieB/xzzMm44g2foUEt2YMREa0GDaUppS5bIcg9M4Saq
         FaVm9nssK738odbckRM2/AwLYRcp9+osO8RVmDsMpGsWsJY8XIwAjiRaxg6a80pq2L0f
         q6ZXgqSwtn9yj30Ww1x7/dxDX/CpimrPwf0qbMRONKwo7M/f2BsYjm4I/N5JMVRCCxDJ
         s22FjgQrv/nt9f38eQihSkzqKbDJm5RfFMwxTSuBGOfhIzzg6Ay1ZYL4sVKC+/uMsqVz
         TPsT9bmn38336X8Pu5Rd9RMBX4XsoUZeyfXety6eRDnUKHWw+z/1NtLQSE4KHh9lNSqA
         42Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790465724; x=1791070524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OVQfxctZBAmzG6J0lcASmCkF/iklJ8Ai6u3dFnv6bp4=;
        b=xycD9A5URCpHIgUEHBJZ/ap+lomLU973pR46U6FPJ2pqR86sagxuRyCzsSBmXYsC8p
         Ahs4JVcV1fMmN+eIut9hfIFPMbmnfmxtpzr+mkOZ0LHtl6jB/Ggip+XJJM1ZnEmbiZSx
         9fWYZ1tTEiJOOZZe02tw5w945RBwKRC9HKf+dmANMAjUsgC6aN0+//Plt/bVRP1HAJC4
         w39cgjmWbLSbpqX9wy8h7qqJzoafhlm6dQxV3YegxuRSeGimNgnCDcmScr0eCyjczY/p
         CSHLWxnOtLXIW2RWK0IwvrqdejZrkW8S1SYW15GYg/MqDufAAigOhjmlJiTyLZ5KCq2b
         4o3A==
X-Gm-Message-State: AFuF++mAiJ81Juy5oeaxRNfHfrLbK5fQXJcBWU6R7R+91Swt2GkbfS15
	07fGpqXf2oG9CmadxPuxRQvJre2+4xCzL3cWm2u/4dlcXi8d2zJhuboDKSHTmNph
X-Gm-Gg: AYBFou3bh0LUQxgmqTqNS6Db0VcEddlJjHeRyooDx+6UQJ41iJ7N+UwYz8NWyzTjlLJ
	5W8xaXN4ibPQlbe15k0KOFWC7Ji0e6RVTW8R0gM/wHjfbA7dTp1oV6GzutyUHtBXMwewwcrFbrA
	/F3LbXqdsEup0WGiGqsya/uXDfHh8KSuoJjYepreZRLzkp2KAqpC5Py3wDkyp/3ilPjKjqBFTm1
	YSCHpcOtwvKnzsSsIawSrlXA6srODyNEZyKxBEi6UiPcIbm0ovCOi5oi2vgYgGr+PhPIJuW0Bd8
	ZOYyeLOdGzwllobjQfWLCW93h+boD36n3bv6V/U/+hhvTu3mFdZYuIedCRcM3kf89zdFvqoXNA/
	YE31HpAP3HdRs3SuwJ0U1I1gvua7Z/X4VGH6wljacboZk4LF6ElpbUg9dRw8J0AHytaEcX4M8rq
	+6E3SrZZH3S+f55z9RvIbRZampP/HW/CVA8blqaDtP9udoMKLcJaAXSUSQ5DejZ9di6rF4vqBF0
	YXWqRfUHmazwmGaGcWrdir0zZ1jNRI+hj/84zoPjEx/yNYAt++k/px0Z1fqdPE8kJkN88R9aB0m
	vmlqorFBC8UuXwKIwUvvT6IsGdf1115QGaT6RQ==
X-Received: by 2002:a05:600c:628e:b0:49e:84bf:6136 with SMTP id 5b1f17b1804b1-49fe66b42b6mr147917685e9.11.1790465724549;
        Sat, 26 Sep 2026 16:35:24 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0019162fcsm10329225e9.13.2026.09.26.16.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 16:35:24 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 11/16] libbpf: Support the typed_arena_cast instruction
Date: Sun, 27 Sep 2026 01:34:49 +0200
Message-ID: <20260926233503.3114147-12-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926233503.3114147-1-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4073; i=memxor@gmail.com; h=from:subject; bh=E2AuCmsXTK++8U0Kn7WnJ7Om+7zwIUgxEE+w99xm0zc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtHWLxqd+L6Q+/S3nQcPvtz01a1Bf2PJj1sURbL2HROq coyOb6po5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABNR2c7whz9JhZmRSzhxmUfh 4ZAvHLqd5ypzl9iL39ldb1Vz4sZPbkaGT5czz24sXz9X6tCBRp6ic7euah1VPq3ru+ez1ezEE0E b2AA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The typed_arena_cast instruction turns any 64-bit value into a pointer to an
object of a program-BTF struct in the struct's typed arena, the kernel-only
region of an arena map. It is encoded as a 64-bit register move with an off
of BPF_TYPED_ARENA_CAST and the struct's local BTF type ID in imm, and the
kernel takes the ID from there, so a compiler that emits the instruction
records a BPF_CORE_TYPE_ID_LOCAL relocation against it, the way it does for
the ld_imm64 behind __builtin_btf_type_id().

Let the relocation patcher write a local type ID into that instruction. It
is the one ALU form with a register source that carries a relocation, and it
takes no other relocation kind; nothing else about the patching of ALU
immediates changes.

Add bpf_typed_arena_cast() to bpf_helpers.h, wrapping the compiler builtin
under its feature macro, so that programs cast through one name whatever the
toolchain.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/bpf_helpers.h | 13 +++++++++++++
 tools/lib/bpf/relo_core.c   | 19 +++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 9d160b5b9c0e..1a440e32ebeb 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -340,6 +340,19 @@ enum libbpf_tristate {
 /* Helper macro to print out debug messages */
 #define bpf_printk(fmt, args...) ___bpf_pick_printk(args)(fmt, ##args)
 
+/*
+ * Turn any 64-bit value into a pointer to an object of the given struct type
+ * in its typed arena, with the typed_arena_cast instruction: the kernel masks
+ * the value into the struct's slice of the arena map's typed region, so the
+ * result names an object of that type whatever the value was, and the
+ * verifier trusts it. The struct's local BTF type ID is relocated into the
+ * instruction. Requires compiler support.
+ */
+#ifdef __BPF_FEATURE_TYPED_ARENA_CAST
+#define bpf_typed_arena_cast(v, type)					\
+	((typeof(type) *)__builtin_bpf_typed_arena_cast((v), *(typeof(type) *)0))
+#endif
+
 struct bpf_iter_num;
 
 extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end) __weak __ksym;
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 2672623a4198..e872e432729b 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -1028,6 +1028,12 @@ static int insn_bytes_to_bpf_size(__u32 sz)
 	}
 }
 
+/* rX = typed_arena_cast(rY, <local type ID in imm>) */
+static bool is_typed_arena_cast_insn(struct bpf_insn *insn)
+{
+	return insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) && insn->off == BPF_TYPED_ARENA_CAST;
+}
+
 /*
  * Patch relocatable BPF instruction.
  *
@@ -1043,7 +1049,8 @@ static int insn_bytes_to_bpf_size(__u32 sz)
  * 3. rX = <imm64> (load with 64-bit immediate value);
  * 4. rX = *(T *)(rY + <off>), where T is one of {u8, u16, u32, u64};
  * 5. *(T *)(rX + <off>) = rY, where T is one of {u8, u16, u32, u64};
- * 6. *(T *)(rX + <off>) = <imm>, where T is one of {u8, u16, u32, u64}.
+ * 6. *(T *)(rX + <off>) = <imm>, where T is one of {u8, u16, u32, u64};
+ * 7. rX = typed_arena_cast(rY, <imm>), for a local type ID relocation only.
  */
 int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
 			int insn_idx, const struct bpf_core_relo *relo,
@@ -1060,8 +1067,16 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
 	switch (class) {
 	case BPF_ALU:
 	case BPF_ALU64:
-		if (BPF_SRC(insn->code) != BPF_K)
+		/*
+		 * The typed arena cast is a register move whose imm names the
+		 * struct by its local type ID; the kernel takes the ID from there.
+		 */
+		if (is_typed_arena_cast_insn(insn)) {
+			if (relo->kind != BPF_CORE_TYPE_ID_LOCAL)
+				goto bad_insn;
+		} else if (BPF_SRC(insn->code) != BPF_K) {
 			goto bad_insn;
+		}
 		if (res->poison)
 			return bpf_core_poison_insn(prog_name, relo_idx, insn, insn_idx);
 		if (res->validate && insn->imm != orig_val) {
-- 
2.53.0

