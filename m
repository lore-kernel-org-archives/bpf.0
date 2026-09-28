Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE99A418361
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627216; cv=none; b=eEQAHDqS1LVTr2e8C5/HnTQSIf8SHFRMZqn/DCo5k3xmyO2qeNfK/vCqo8LuCOhSNJ6TuuaKe5jSJpxubAFHAE4t2h5a5zJOwgkVFwt/xgfi8QjOMRb4L9sK/ifCYy62avEeOqkHEfu3eHaizhz77TOGB6sIHZp9A8yd6rsrkqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627216; c=relaxed/simple;
	bh=sBY3NTuquKPk2izoz/tl+FNSel/ECAF2Y3AirZivHA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGAdW/g6S5FNSzN4UY2It1mH3DnXpF9ktbhfHkY/TcuxcGBJDU0SNJ7BJxl9GstY/rRGxvXWgOMMgEFfT+pCObbbG66xMJ9OsLIeX1V7VdV7zs9yz40yVnnJvKH9GvFpeTCkn5bS4aytTeKAv85+fPwFdcXxg7IxxED/iMgoV4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=qwk8o26S; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="qwk8o26S"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc78d45f78fso2048882a12.3
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 13:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790627214; x=1791232014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4VwPVRYEV2wLFgwgDC5jga2CPmwFe3KR4l7fTGWAThQ=;
        b=qwk8o26SEK3Mxs/WJMy9Jazl5RAxUcD6Ph9kWzXvZld2xNprgb3GwTjFP32VeBs+0u
         LJ4dWhGob4dsJ37PsR+Sb+C+23zhr5IOFGn1gzt+jfKFMHeT3ceqVAYE/eqWWQs1+Kj1
         O0IKJ5OKkUPpr59o2EXYrt9+0mPiU458H8vU4yFCGdC3G+fCb9p1W0VapqN3nBSqOROI
         HhNN3e5NleuhCkCoSTbdzTuNNgW3rMmITiqtqUOhyJ8rbAzr3Sp3scW5TUtTW55pvcod
         5Vn4LCFFl5XzWWkkgf48sV3PzrqmaMz1gbjMQAoAZOAAaUdt2r0+7qsr2UHXqXLzd7Js
         1Ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790627214; x=1791232014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4VwPVRYEV2wLFgwgDC5jga2CPmwFe3KR4l7fTGWAThQ=;
        b=oa4PLfQ0ZlcdHWaP9qy+C7hLktuNplB0NtVKhu07ooEtZxAiDhQ0R6RR/bAOEPaEY5
         l321uK8EVQfDoKAoi4OPNK4uV3O29HTr2cTZUd8xaalrUF9hGFpOS+uAzcjs+cGmj1Kd
         atpJmZWz1AiXuCfAl0i92SB/JnWj9sJB3e3+6ju/IDgaLJstoNWQIdmHO4++WdSM5p01
         jle6Y2yAyfxfg6tcQRBmU9gkIs6Zmw+ppVvZ9ELxBDiYTfJyoxeeW0MtmwRt8Lzkhgth
         vUd6otZOxx/Z28QDBWFwLrEBcN13fSLZlBEzwVEGOshg35SwpuaBy/qqmDb8Uo7QJbIQ
         zP1A==
X-Gm-Message-State: AFq9FYKC7hg/sfyBQjQj+iJK88TUPwcTpBKgldrUzLslNS85tRsXtACO
	MXBbrRtH2HuyC+lQHhje5xjiCe1Os8giRndGRcqXUCwkqEgOFmu/Ii+2ZMXinS1SVcdl4rQy/l9
	FfEuNwME=
X-Gm-Gg: AYBFou3oO7USp8pumsvPpBTatGHfpCRGiFxp4TEeNvLP2Nk1QVOhvTn8iDOVhBUNpaa
	tb3TO/StjOhiiolrkG2yI07TiIARG8cia8byK7/xWnvM/VQAt+xWtKjsZqHom7TJejgYYUnlF+j
	axDUp3A9MxaURtYjVpgQC45V8XMk18Qo0xLvOqnRYL4hcy/z4//jFGY70Ca3vlrmV7T+1uzSZNM
	Z6l4Ouj9oN8uTUy+msWlS3Wfx807y58zP1XczrsDc+Rj+wASRI8y2CpjXnQrDmev1oUFn8MVRg0
	Jr8cT8s3tFlKGIHqCE0pu9XrhE6rQwjxK8eJ30JGzLZl5K2fw/wTPFnxEVPMwp7D0UAn72CbgqE
	4lg5Gu4Nx27vAvWjBs5JQMUVkXeYpALk3zNg/cGhGHAyQVX9kB+Gy7KoVh65WXh+IaEqAhDDBOJ
	B7zq4io1LHwYTnKtd2lwL0FcKeFL62WWCgahvI/UpJmXkaVoRP7Tm9x7z2teyxFPJlhFLuyPgDa
	+LvMXZQao2EA5CJhAZmHOSDflhaZ2RAnSGfxLEugw==
X-Received: by 2002:a17:90b:2251:b0:3a0:9640:8031 with SMTP id 98e67ed59e1d1-3a098d4364cmr11101234a91.8.1790627214328;
        Mon, 28 Sep 2026 13:26:54 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a492ea04b1sm975193a91.4.2026.09.28.13.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:26:53 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 6/7] bpf: Support per-call-site kfunc specialization
Date: Mon, 28 Sep 2026 20:26:42 +0000
Message-ID: <20260928202643.9114-7-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928202643.9114-1-emil@etsalapatis.com>
References: <20260928202643.9114-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

specialize_kfunc() currently updates the canonical kfunc descriptor in
place. Different call sites therefore cannot select different
specializations of the same kfunc, and the selected target depends on
verification order.

Keep canonical descriptors unchanged for verifier lookups. Specialize a
copy for each call site, then reuse or append an immutable target
descriptor and store its index in the finalized call instruction.

Allow space for one canonical and one specialized target per kfunc. This
is conservative because most kfuncs do not specialize. Adding specialized
kfunc versions does not require resorting the array because lookups are
only used for deduplication and func_model lookup. Deduplication for
specialized kfuncs is handled by the specialization process itself,
while all specializations of a function share the same proto and
func_model.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf_verifier.h | 12 ++++--
 kernel/bpf/verifier.c        | 75 +++++++++++++++++++++++++++++++++---
 2 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5cbae5d05fe7..7bdbda7764c7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1784,7 +1784,9 @@ enum bpf_reg_arg_type {
 };
 
 #define MAX_KFUNC_DESCS 256
-static_assert(MAX_KFUNC_DESCS <= S16_MAX + 1);
+/* Each kfunc can have its canonical and one specialized call target. */
+#define MAX_KFUNC_CALL_DESCS (MAX_KFUNC_DESCS * 2)
+static_assert(MAX_KFUNC_CALL_DESCS <= S16_MAX + 1);
 
 struct bpf_kfunc_desc {
 	struct btf_func_model func_model;
@@ -1796,11 +1798,15 @@ struct bpf_kfunc_desc {
 
 struct bpf_kfunc_desc_tab {
 	u32 nr_descs;
+	u32 nr_base_descs;
 	/* Sorted by func_id (BTF ID) and offset (fd_array offset) during
 	 * verification. JITs use the descriptor index stored in the finalized
-	 * call's off field.
+	 * call's off field. The first nr_base_descs entries are the canonical
+	 * descriptors used for verifier lookups. Call specialization may append
+	 * immutable descriptors for additional targets.
 	 *
-	 * Grown one entry at a time by bpf_add_kfunc_call().
+	 * Grown one entry at a time by bpf_add_kfunc_call() and during
+	 * call specialization.
 	 */
 	struct bpf_kfunc_desc descs[];
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8183a8f22ed5..8ba831329ab7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2579,7 +2579,7 @@ find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
 	struct bpf_kfunc_desc_tab *tab;
 
 	tab = prog->aux->kfunc_tab;
-	return bsearch(&desc, tab->descs, tab->nr_descs,
+	return bsearch(&desc, tab->descs, tab->nr_base_descs,
 		       sizeof(tab->descs[0]), kfunc_desc_cmp_by_id_off);
 }
 
@@ -2933,10 +2933,12 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 	if (find_kfunc_desc(env->prog, func_id, offset))
 		return 0;
 
-	if (tab->nr_descs == MAX_KFUNC_DESCS) {
+	if (tab->nr_base_descs == MAX_KFUNC_DESCS) {
 		verbose(env, "too many different kernel function calls\n");
 		return -E2BIG;
 	}
+	if (WARN_ON_ONCE(tab->nr_descs != tab->nr_base_descs))
+		return -EFAULT;
 
 	err = fetch_kfunc_meta(env, func_id, offset, &kfunc);
 	if (err)
@@ -2994,7 +2996,8 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 	desc->addr = addr;
 	desc->func_model = func_model;
 	tab->nr_descs++;
-	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
+	tab->nr_base_descs++;
+	sort(tab->descs, tab->nr_base_descs, sizeof(tab->descs[0]),
 	     kfunc_desc_cmp_by_id_off, NULL);
 	return 0;
 }
@@ -22062,6 +22065,56 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
 	return 0;
 }
 
+static int add_kfunc_desc_target(struct bpf_verifier_env *env,
+				 const struct bpf_kfunc_desc *target_desc,
+				 u16 base_desc_idx, u16 *desc_idx)
+{
+	struct bpf_kfunc_desc desc = *target_desc;
+	struct bpf_kfunc_desc_tab *new_tab;
+	struct bpf_kfunc_desc_tab *tab;
+	struct bpf_prog_aux *prog_aux;
+	u32 i;
+
+	prog_aux = env->prog->aux;
+	tab = prog_aux->kfunc_tab;
+
+	if (WARN_ON_ONCE(base_desc_idx >= tab->nr_base_descs))
+		return -EFAULT;
+	if (WARN_ON_ONCE(tab->descs[base_desc_idx].func_id != desc.func_id ||
+			 tab->descs[base_desc_idx].offset != desc.offset))
+		return -EFAULT;
+
+	if (tab->descs[base_desc_idx].addr == desc.addr) {
+		*desc_idx = base_desc_idx;
+		return 0;
+	}
+
+	for (i = tab->nr_base_descs; i < tab->nr_descs; i++) {
+		if (tab->descs[i].func_id == desc.func_id &&
+		    tab->descs[i].offset == desc.offset &&
+		    tab->descs[i].addr == desc.addr) {
+			*desc_idx = i;
+			return 0;
+		}
+	}
+
+	if (tab->nr_descs == MAX_KFUNC_CALL_DESCS) {
+		verbose(env, "too many different kernel function call targets\n");
+		return -E2BIG;
+	}
+
+	new_tab = krealloc(tab, struct_size(tab, descs, tab->nr_descs + 1),
+			   GFP_KERNEL_ACCOUNT);
+	if (!new_tab)
+		return -ENOMEM;
+	tab = new_tab;
+	prog_aux->kfunc_tab = tab;
+
+	*desc_idx = tab->nr_descs;
+	tab->descs[tab->nr_descs++] = desc;
+	return 0;
+}
+
 static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
 					    u16 struct_meta_reg,
 					    u16 node_offset_reg,
@@ -22082,9 +22135,11 @@ static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
 int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		     struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
+	struct bpf_kfunc_desc desc_copy;
 	struct bpf_kfunc_desc *desc;
 	unsigned long call_imm;
-	u16 desc_idx;
+	u16 base_desc_idx, desc_idx;
+	bool near_call;
 	int err;
 
 	if (!insn->imm) {
@@ -22104,13 +22159,17 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     insn->imm);
 		return -EFAULT;
 	}
-	desc_idx = desc - env->prog->aux->kfunc_tab->descs;
+	base_desc_idx = desc - env->prog->aux->kfunc_tab->descs;
+
+	near_call = !bpf_jit_supports_far_kfunc_call();
+	desc_copy = *desc;
+	desc = &desc_copy;
 
 	err = specialize_kfunc(env, desc, insn_idx);
 	if (err)
 		return err;
 
-	if (!bpf_jit_supports_far_kfunc_call()) {
+	if (near_call) {
 		call_imm = BPF_CALL_IMM(desc->addr);
 		if ((unsigned long)(s32)call_imm != call_imm) {
 			verbose(env, "address of kernel func_id %u is out of range\n",
@@ -22119,6 +22178,10 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 		insn->imm = call_imm;
 	}
+
+	err = add_kfunc_desc_target(env, desc, base_desc_idx, &desc_idx);
+	if (err)
+		return err;
 	insn->off = desc_idx;
 
 	if (is_bpf_obj_new_kfunc(desc->func_id) || is_bpf_percpu_obj_new_kfunc(desc->func_id)) {
-- 
2.52.0

