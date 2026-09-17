Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5394D0A14
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643522; cv=none; b=LWjTddK4tSIWaytY2bRFQz04HFGx/8QH/1LxVjnn3RypPdFLdkxX86YtJudMXPLVO1O30QrlkLjrxMnmfl0N2kS539RJU0vohkpKUopngx1LK0EUrAFBeLzmHo0w+PBftRIblCw91vdl+4f6H0tZMp08Y32lcBC972MeeiG3pnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643522; c=relaxed/simple;
	bh=OOKKZODyMMC5kmbSdBPf37VZyHZD2uvJ2336y6RyzBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flx83yFg2N3iHFaDsLIVjSzyq8AlCvLTe2krXQZ8pfDFxuVgOwXhxjwU+bQ2UMKewGA7WBI3DZEsSmVD+DVAM1EEZT2S4ht/VQZT2gEPfIF8sbSg46NfcxiRpfqJxHau2mYkjGKinr3w63zpCqqLZfKFK97MPkeDOcGRk6jhftE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iG5+U1oU; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iG5+U1oU"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-4926d058720so1703365e9.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 04:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789643495; x=1790248295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vZR2s/k2A0ou/ArUCARtV7UR8g7zpnlIQzIKjyJOXkY=;
        b=iG5+U1oUbkCYNTenfnFBLNTupwitKXaw3OBEwu3QC40M1gdNmLMwqGc3wEo2Pbb7uy
         sokSiG9fpyROnoVWSCjACd4KCRAYpVUw6x2qexvvkzLSSwvEkrDL3EDKQEG0Fxe6gpVq
         ZnrDzTP7KQXpQum6kGF+7HG92A2/leGG69gFvxD30+hSbehaDsuGoqGsvjc31RRrmPRU
         T+AfVPXplhPOZPKoI/2bZbsN2ukQflfEhQQL1djlCd2sMn6KAG2PfxFtARzwE5mN1seV
         EbUQGCYIfLSCGw4MdzuVUcPn7mtuKxzoGd+fNVf3BERO7X3uLfeGgfmp2yz+vSqmEXXm
         pFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789643495; x=1790248295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vZR2s/k2A0ou/ArUCARtV7UR8g7zpnlIQzIKjyJOXkY=;
        b=rizJMjO9Z3nYQ6Jp2h/xO1TAUlEsIXIam8F0LYGwNjduziFHsl+SiyEa8dY2yshckm
         cd4fhwEz7a55u6TUwKMcVYfveGiWbbeKizswN5+EO2rctTDpFKZ/0xmB2Gs1RrsNAbYQ
         +eXNom94In3M6ttd3LIpLWsWHUHUpvo0A+UeJfQbe51loFYqqOqzFTjJaqf4MLVXgO93
         6qr36N5hS56hVk5RWrZtnuRbrASjbbh/08HZnZEa4o4lEqToFAsM8buT8ToPtrlkiNgO
         FIWh5aPPym/5so/ZxeFloDRJeBOuq9d0C9/QcEJRfUpIKhTr2nt7dYsHhbrGtzl6V99e
         GmUg==
X-Gm-Message-State: AFuF++mf4qibxMN2kt7rj3kHkBJsAgpd29toAhD1wdbx3WNaICwZ/b5o
	2TLLY/s54HUb9g7GnBUjfbzoMBSEfaDCo3AQWc8y7D3Kq1n15++mut4fwP30cUoN
X-Gm-Gg: AYBFou238NaChWQqlr75uMut9A4bgT4YZhD7a9CqPMHyIEmxLO5xgM+bzgjPU9V3PBC
	4ngxs5DdoMijWCbG1Ae71x/hGezvuDiw2MjeKFXVMOiXpMJPYoUxNn77zpsECGwfsnrvDp28sCD
	5k3EvzfjPp6lMB2ag5nne1z2ILwEEUi+gP8TIVw/CK9+JOObGxP23W1KOTNGKhhBR/mjMmgTF7X
	wpHrJnWBh3Kq/DuMF9Pny0/tIlh15VitiMKRUieA42IIviDOT3duw862aEgxUempiAm7WmNLV7i
	pBcUfWgvEPfdLb2Yl7O9TlWMBnSU4TYRySLAmjgcX/eWGplRcMIhV3iLZrfdPGnwCx1trmhHDhs
	rfrZ7BVsAH8OqOWD8vuqRFuIGVBYWTvZc22UqSON+ysTgAvCq1zFL0dU5d3vpkqU+QXwlgPmRja
	pL7MYaRbCqVvoZ7edhWaRLdlWbbX/ZnD3vvvrIjtOUDUNrDInZh4vRSxOMJ7aMQplTkK38NQd9/
	0c+hmozU7entXFTAFb2fJBi+6C7Y2V3t4ZkjtmY37rQvw5fI4G78Xcnx+VFCOSILs1EGMyFshi4
	ZzvflmnE9H69bB7o623MhckMVywqxdxXqzpbIw==
X-Received: by 2002:a05:600c:8b8a:b0:49d:1f10:8b9f with SMTP id 5b1f17b1804b1-49eac463921mr92857285e9.7.1789643494980;
        Thu, 17 Sep 2026 04:11:34 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd17051fsm69425515e9.0.2026.09.17.04.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 04:11:34 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v6 04/10] bpf: Apply CO-RE relocations before subprogram validation
Date: Thu, 17 Sep 2026 13:11:16 +0200
Message-ID: <20260917111127.3780880-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917111127.3780880-1-memxor@gmail.com>
References: <20260917111127.3780880-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4827; i=memxor@gmail.com; h=from:subject; bh=OOKKZODyMMC5kmbSdBPf37VZyHZD2uvJ2336y6RyzBs=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv1qaT+RX+YM6dZG06rEf3eObfyAIdeilvXj2apv366M Q5Lbgp0lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCL67YwMW/RcsydckIrl0Nzn c9TWmLvqTcfOn2lKF3l2H5/pbjVjHyPDFD6DPqE79ys3mbm5MP7gOmHxWvLrze859yWPBQapPTz BDgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

check_subprogs() verifies that each subprogram ends in an exit or an
unconditional jump before in-kernel CO-RE relocations are applied. An
unresolved relocation can then replace that terminal instruction with an
invalid helper call. The resulting fall-through into another subprogram
breaks the CFG invariant used by postorder and stack liveness analysis,
which can write past their per-subprogram arrays.

Apply CO-RE relocations immediately after preparing the program BTF, before
subprogram discovery and validation. Keep func_info and line_info validation
after subprogram discovery because those records depend on the complete
subprogram layout.

Reject an ldimm64 first slot at the end of the instruction stream before
CO-RE can inspect its missing second slot. The regular instruction validation
already rejects this form, but now runs after relocation processing.

Include core_relo_cnt when deciding whether to prepare program BTF. A load
that supplied only CO-RE relocation metadata previously skipped both BTF
setup and relocation processing.

Fixes: fbd94c7afcf9 ("bpf: Pass a set of bpf_core_relo-s to prog_load command.")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/check_btf.c       | 12 ++++--------
 kernel/bpf/verifier.c        | 12 +++++++++++-
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 36b65797877d..bba5a727c651 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1197,6 +1197,8 @@ static inline void bpf_trampoline_unpack_key(u64 key, u32 *obj_id, u32 *btf_id)
 
 int bpf_prepare_btf_info(struct bpf_verifier_env *env,
 			 const union bpf_attr *attr, bpfptr_t uattr);
+int bpf_check_core_relo(struct bpf_verifier_env *env,
+			const union bpf_attr *attr, bpfptr_t uattr);
 int bpf_check_btf_info(struct bpf_verifier_env *env,
 		       const union bpf_attr *attr, bpfptr_t uattr);
 
diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
index 0e8b3ccc7a5b..4c1ed842f661 100644
--- a/kernel/bpf/check_btf.c
+++ b/kernel/bpf/check_btf.c
@@ -338,9 +338,9 @@ static int check_btf_line(struct bpf_verifier_env *env,
 #define MIN_CORE_RELO_SIZE	sizeof(struct bpf_core_relo)
 #define MAX_CORE_RELO_SIZE	MAX_FUNCINFO_REC_SIZE
 
-static int check_core_relo(struct bpf_verifier_env *env,
-			   const union bpf_attr *attr,
-			   bpfptr_t uattr)
+int bpf_check_core_relo(struct bpf_verifier_env *env,
+			const union bpf_attr *attr,
+			bpfptr_t uattr)
 {
 	u32 i, nr_core_relo, ncopy, expected_size, rec_size;
 	struct bpf_core_relo core_relo = {};
@@ -414,7 +414,7 @@ int bpf_prepare_btf_info(struct bpf_verifier_env *env,
 	struct btf *btf;
 	int err;
 
-	if (!attr->func_info_cnt && !attr->line_info_cnt) {
+	if (!attr->func_info_cnt && !attr->line_info_cnt && !attr->core_relo_cnt) {
 		if (check_abnormal_return(env))
 			return -EINVAL;
 		return 0;
@@ -455,9 +455,5 @@ int bpf_check_btf_info(struct bpf_verifier_env *env,
 	if (err)
 		return err;
 
-	err = check_core_relo(env, attr, uattr);
-	if (err)
-		return err;
-
 	return 0;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5d7080c260d8..33161dc64568 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21199,6 +21199,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	ret = bpf_diag_init(env);
 	if (ret)
 		goto err_prep;
+	if (env->prog->insnsi[env->prog->len - 1].code == (BPF_LD | BPF_IMM | BPF_DW)) {
+		verbose(env, "invalid bpf_ld_imm64 insn\n");
+		ret = -EINVAL;
+		goto err_prep;
+	}
 	if (env->signature) {
 		ret = bpf_prog_calc_tag(env->prog);
 		if (ret < 0)
@@ -21274,6 +21279,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	/* Apply CO-RE before validating the program's instruction layout. */
+	ret = bpf_check_core_relo(env, attr, uattr);
+	if (ret < 0)
+		goto skip_full_check;
+
 	/* Discover all subprograms before validating their layout and BTF. */
 	ret = add_subprogs(env);
 	if (ret < 0)
@@ -21283,7 +21293,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
-	/* Validate BTF against the complete subprogram layout and apply CO-RE. */
+	/* Validate BTF against the complete subprogram layout. */
 	ret = bpf_check_btf_info(env, attr, uattr);
 	if (ret < 0)
 		goto skip_full_check;
-- 
2.53.0

