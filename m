Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793582996;
	b=ri5M8IO61FiBAcRDQ0cNTpwnZPTYK83uM9dw3Uqt7vUHu+wBK0BpSb2Av3o2GpI0symB
	 NT0NrEUsoG58Rqu6O/gvz/7sKHyPHci88LFdyZgYvZ0XiRwUo1a5jXShnUgTnyQeXnxKI
	 lflwG7q15yr1TrU+hlq9hcGtU2zrOmXTd9GyxfDsLkLbScOjC9OiUTxH3S+0s9LH4iclV
	 4Dkd+KKfMYJprGgSdq0I2NXjQ3prGdMZddLrFvpg131HDougr85k1Yk4fjbbFOjAq8v56
	 1tBbDUk/8va7eXAGgWrXNZlYdCJitH2gzDyU6PsYwQd+F9gLjuGoHipFgtuQ5Yfngrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793582996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Dzo1CbwDixSRbvG6ooBSzTGh8YYiY96FONeA3FCMV0A=;
	b=0VxEfmyAyafhF8HlPYw9YX1FmO4ypaKSN85AH4wYVPzb1BB+EzsZvLV1tsab3nwXEJt+
	 g0dqxXp/KVz+iYUtxc+SpTOyXBq3j559f97J1+bGhhlAZ4jg0fOOCOdfWWrhZ1P2JwMJ1
	 yHrrsd/WbbztO+BandXnVU4SLnQ1OcOedRS8isgRqzj/OdRyojOXRuM1uO1FS/1zuiqGq
	 nZOslVe84sR6eVAET6Jurg5QGtrKV66ZNoEj1gwZ25z0blaJ0wfZ2Vs/A/96BSGNuY/nc
	 DyLoaDGQHaM0ifLp73alm3ZOuL3fLVZWRQuSG6ciVho99N3FGthnHYuchWRX1IQDs8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U3HJ7jAE;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E87606A326
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 01:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88E87606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U3HJ7jAE
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e5378b281aso13453285ad.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 17:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793582994; x=1794187794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dzo1CbwDixSRbvG6ooBSzTGh8YYiY96FONeA3FCMV0A=;
        b=U3HJ7jAESLWK+IzCYL8fVmLXes0+6wj494GZnIq/+0tKVaGbuPSxbuS/WgnKPxfX0R
         B4N2gbII1veA5LKEHeKtq7B+gDJ8XDY46HVZMHSF+eORznJrNR34xAEBpeVXDY8XE+OF
         BKp2dzQGBV5zZ8/0tCu+8h36uv4dSKvybWBAwYl32Zy33Km7/y8cXKJO0xFNm9Fgm9lc
         F1v3MbEU2mMiKRMB6v1rm2n43asDWbPLRRv2kdJspC1JoiHNAJawzEKCEQjpREOxCMf5
         gREQHCFW9kM29sUJ19QlNKCiwepQkbqMZJ6JUudOf0qK/Hs1w8b5ixldXUc3uUUq6pqx
         5idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793582994; x=1794187794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dzo1CbwDixSRbvG6ooBSzTGh8YYiY96FONeA3FCMV0A=;
        b=yBVnyfVLKyHuX46VbA9+YFelxXGsbhWfqmGVjPEwd8E42DroNqWhjL+qWlsaOcKshW
         2VW0FWJsKg1uzd9CyHnu2+VGXL3wAEX+xOD0DL/n3MT912PvGVPIBebdKn65jcDCaUz+
         x5DDIykoudfcsYCqp1VfVJzINM2HrOpt7GDSgmJHm0hl1/JuJPv3KEDXIQxhKkwPfhrS
         dkE7y8UNZM3P3cd8Tupottp/C9a+YnFnqlyBRm2BQryULDEBixc5FMhcbyTbvovbehqV
         EbURGFyJP5KeDg57U4dx4E4dfYcbS55zLXWUamQX4BxkHkKqTIdn5XXQ7d4Uo5/Bubq4
         h5gQ==
X-Gm-Message-State: APuU4Z/QOxhLZjrIu6loVvgpi6aZEbWq6f0k48r8wojv9zf5TcVdQz81
	LYnrGDg/ndRuy8VHUfsQswrjxJCBNSyXEKYmY/vJ3e1qgrev69DQi3eKgp7B+Q==
X-Gm-Gg: AYBFou0DSDdObLSZQZKzAN7xPzMX8DUGmwF2N6Qk6ZWsWsbL+a5zFzhF5H1YFLqbDYy
	D7ZWYNrfARcq1pbko6h0OwPxooloHzR6pUfn4Mr0N2QP2tFLCbe4HXqNfISKbyM2yB8cdHp8GYl
	fdq+Qfa9NL9BipLmIM90iFa0Cal+U23UySJCxtygN2Uy3kg3gmKtS0CHQ9BU/kcQu1RJ+77GRJ5
	rsQsjJybhgJ5ivv98f/2BZMD8t1FxB/og819HWpmr7GJMaHzom5RfAO/bivCO/QNZhuZSfNSyOC
	hQIE5DJrK0T9mYVXvs1xDs1RcAYckPLlDGZZmZy7s6A9j6SxMfIpP0/j6jrLrJKlh+E4oRq0x1m
	DUh9kWbxTfi3s0Hvhegnu/O7x0WXVnUEQltQE1HqdGlQWCrP/CTPtHICfRKacSGwXGgVbMUXsOC
	f6Hn0S8xIpwlsNxUmZJvsdjrja/E/WV4NCaFZOEPi1fMr33TZNONzzLw1QbtE3Ta/RLkTU8aduR
	UIJdVgDS6zfWpQSXoFxQQJLPDYSfHLyc0skPgXpZSMVvm+waGKgWibeu7cvA+R3y1HMDD+eGTic
	IPLGz0QdERMYZcMvkPUo2vJm+AAwe4K5AE+LD+zCobWCWFpFJqOEXoFZtUmSbnarri8D7Hr8cri
	dNBS7UxXJj9xfIsY4Z4EtyK0oK0McOeQTGev39WN+T/iownkqN8YfT15Dl4gHJDuMrwIvln/Ccg
	==
X-Received: by 2002:a17:90b:1b12:b0:39e:3713:c2e4 with SMTP id 98e67ed59e1d1-3ae896f51e5mr7694770a91.14.1793582994122;
        Sun, 01 Nov 2026 17:29:54 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae880a46f1sm5659956a91.3.2026.11.01.17.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 17:29:53 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	odys.yuan@gmail.com
Subject: [PATCH bpf-next v3 02/13] bpf: Remap the verifier state through the patch list
Date: Mon,  2 Nov 2026 01:29:29 +0000
Message-ID: <20261102012940.1756142-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102012940.1756142-1-alexei.starovoitov@gmail.com>
References: <20261102012940.1756142-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qiliang Yuan <odys.yuan@gmail.com>

A pass queues its patches in the patch list. One commit builds the new
image of the prog and new_off[], the map from old index to new index. The
code in core.c moves only the tables of the prog through the map: poke
descriptors and line info. The verifier has more tables that name insns,
and bpf_patch_insn_data() walks all of them for each patch:

  table              what an entry names
  -----------------  --------------------------------------------------
  aux data           insn i, by the position of the entry in the array
  subprogs           the first insn of a subprog
  function pointers  the first insn of a subprog that .rodata points to
  insn arrays        a target of an indirect jump

Put a patch list in bpf_verifier_env (env). A pass calls
bpf_patch_list_add() to queue a patch, and bpf_patch_list_commit() one time
at its end. The commit moves each table one time, through new_off[].

During the commit one part of env describes the old image, and a different
part describes the new image. A helper that reads env or the prog at that
time can get an incorrect result. Thus the order of the steps is a rule:

  1. all that can fail   Build the new image, allocate the new aux data,
                         reallocate the prog. An error changes nothing.
  2. the tables          A new entry depends only on the old entry and on
                         the map. No helper that reads the insns,
                         prog->len or a table from env or the prog.
  3. the new image       bpf_patch_image_install() writes the insns and
                         prog->len last.

The aux data of a patched insn goes to the last insn of its patch. The
other insns of the patch get new aux data, as with adjust_insn_aux_data().
One rule is new. They get the orig_idx of the patched insn: its index in
the prog that the user loads. Thus a message about a jump in a patch names
that insn, not insn 0.

A patch of 1 insn moves nothing. bpf_patch_list_add() does not queue it. It
writes the insn to the prog in place. It sets zext_dst and non_stack_access
in the aux data from the new insn, as bpf_patch_insn_data() does.

The commit replaces env->prog and env->insn_aux_data. A pass must read the
two pointers again. bpf_check() frees the list at its end. Thus a pass can
return an error while patches are queued. No pass uses the list yet.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h          |   1 +
 include/linux/bpf_verifier.h |   5 +
 kernel/bpf/bpf_insn_array.c  |  17 ++++
 kernel/bpf/fixups.c          | 187 +++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |   1 +
 5 files changed, 211 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ff0436781293..ba96b4fc893a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4380,6 +4380,7 @@ int bpf_insn_array_ready(struct bpf_map *map);
 void bpf_insn_array_release(struct bpf_map *map);
 void bpf_insn_array_adjust(struct bpf_map *map, u32 first, u32 len);
 void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
+void bpf_insn_array_remap(struct bpf_map *map, const u32 *new_off, u32 cnt, s32 grow);
 
 #ifdef CONFIG_BPF_SYSCALL
 void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index baa3a29a190e..fc051a084442 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1152,6 +1152,7 @@ struct bpf_verifier_env {
 	bool signature;
 	u32 insn_aux_data_len;
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
+	struct bpf_patch_list patch_list;
 	const struct bpf_line_info *prev_linfo;
 	struct bpf_verifier_log log;
 	struct bpf_diag *diag;
@@ -2066,6 +2067,10 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env);
 int bpf_fixup_call_args(struct bpf_verifier_env *env);
 int bpf_do_misc_fixups(struct bpf_verifier_env *env);
 int bpf_insn_def32(struct bpf_prog *prog, struct bpf_insn *insn);
+struct bpf_insn *bpf_patch_list_add(struct bpf_verifier_env *env, u32 off,
+				    const struct bpf_insn *patch, u32 len);
+int bpf_patch_list_commit(struct bpf_verifier_env *env);
+void bpf_patch_list_free(struct bpf_verifier_env *env);
 
 int bpf_flip_opcode(u32 opcode);
 u8 bpf_rev_opcode(u8 opcode);
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index 92bbb71576ae..21ca87c96373 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -253,6 +253,23 @@ void bpf_insn_array_adjust(struct bpf_map *map, u32 first, u32 len)
 	}
 }
 
+/*
+ * Move each offset to new_off[offset], new_off[] covers [0, cnt]. Offsets
+ * past the end of the old program only move by 'grow'.
+ */
+void bpf_insn_array_remap(struct bpf_map *map, const u32 *new_off, u32 cnt, s32 grow)
+{
+	struct bpf_insn_array *insn_array = cast_insn_array(map);
+	u32 i, off;
+
+	for (i = 0; i < map->max_entries; i++) {
+		off = insn_array->values[i].xlated_off;
+		if (off == INSN_DELETED)
+			continue;
+		insn_array->values[i].xlated_off = off <= cnt ? new_off[off] : off + grow;
+	}
+}
+
 void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len)
 {
 	struct bpf_insn_array *insn_array = cast_insn_array(map);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 41bc37e205e0..aee645cbb63b 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -355,6 +355,193 @@ struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 	return __bpf_patch_insn_data(env, off, patch, len, BPF_PATCH_KEEP_TARGET);
 }
 
+/*
+ * Queue the replacement of insn 'off' by 'patch[0..len)' until
+ * bpf_patch_list_commit(), see __bpf_patch_list_add(). Replacing one insn by
+ * one moves nothing and is done right away.
+ */
+struct bpf_insn *bpf_patch_list_add(struct bpf_verifier_env *env, u32 off,
+				    const struct bpf_insn *patch, u32 len)
+{
+	struct bpf_patch_list *pl = &env->patch_list;
+
+	if (bpf_rewrite_must_abort())
+		return ERR_PTR(-EINTR);
+
+	if (verifier_bug_if(!len || off >= env->prog->len ||
+			    (pl->cnt && off <= pl->patches[pl->cnt - 1].off),
+			    env, "insn %u patched out of order", off))
+		return ERR_PTR(-EFAULT);
+
+	if (len == 1) {
+		env->prog->insnsi[off] = *patch;
+		adjust_insn_aux_data(env, env->prog, off, 1, NULL,
+				     BPF_PATCH_KEEP_TARGET);
+		return &env->prog->insnsi[off];
+	}
+
+	return __bpf_patch_list_add(pl, env->prog, off, patch, len);
+}
+
+void bpf_patch_list_free(struct bpf_verifier_env *env)
+{
+	bpf_patch_list_release(&env->patch_list);
+}
+
+/*
+ * Fill the aux data of the 'p->len' insns at 'slot' from the aux data 'old'
+ * of the insn they replace, the same way as adjust_insn_aux_data() does.
+ */
+static void patch_list_adj_aux(struct bpf_prog *prog, struct bpf_insn_patch *p,
+			       struct bpf_insn *patch,
+			       const struct bpf_insn_aux_data *old,
+			       struct bpf_insn_aux_data *slot)
+{
+	struct bpf_insn_aux_data *last = slot + p->len - 1;
+	struct bpf_insn *orig = &p->orig;
+	u32 i;
+
+	*last = *old;
+	last->zext_dst = bpf_insn_def32(prog, &patch[p->len - 1]) >= 0;
+	memset(slot, 0, sizeof(*slot) * (p->len - 1));
+
+	for (i = 0; i < p->len - 1; i++) {
+		slot[i].seen = last->seen;
+		/* messages name the insn of the original program */
+		slot[i].orig_idx = last->orig_idx;
+		slot[i].zext_dst = bpf_insn_def32(prog, &patch[i]) >= 0;
+		if (!memcmp(&patch[i], orig, sizeof(*orig))) {
+			slot[i].non_stack_access = last->non_stack_access;
+			last->non_stack_access = false;
+		} else if (bpf_is_mem_insn(&patch[i])) {
+			slot[i].non_stack_access = true;
+		}
+	}
+
+	if (bpf_is_mem_insn(&patch[p->len - 1]) &&
+	    memcmp(&patch[p->len - 1], orig, sizeof(*orig)))
+		last->non_stack_access = true;
+
+	/* indirect jumps to the replaced insn land on the first new one */
+	if (last->indirect_target) {
+		slot[0].indirect_target = 1;
+		last->indirect_target = 0;
+	}
+}
+
+/* Fill 'data', the aux data of the new image, from the aux data of the old one. */
+static void patch_list_remap_aux(struct bpf_verifier_env *env,
+				 const struct bpf_patch_image *img,
+				 struct bpf_insn_aux_data *data)
+{
+	struct bpf_patch_list *pl = &env->patch_list;
+	struct bpf_insn_patch *p;
+	u32 i, k, end;
+
+	for (i = 0, k = 0; i < img->cnt; i = end) {
+		if (k < pl->cnt && pl->patches[k].off == i) {
+			p = &pl->patches[k++];
+			patch_list_adj_aux(env->prog, p, &pl->insns[p->start],
+					   &env->insn_aux_data[i],
+					   &data[img->new_off[i]]);
+			end = i + 1;
+			continue;
+		}
+		end = k < pl->cnt ? pl->patches[k].off : img->cnt;
+		memcpy(data + img->new_off[i], env->insn_aux_data + i,
+		       sizeof(*data) * (end - i));
+	}
+	vfree(env->insn_aux_data);
+	env->insn_aux_data = data;
+	env->insn_aux_data_len = img->new_cnt;
+}
+
+/* Subprogs, and the function pointers that name them, follow their first insn. */
+static void patch_list_remap_subprogs(struct bpf_verifier_env *env,
+				      const struct bpf_patch_image *img)
+{
+	u32 i;
+
+	for (i = 0; i < env->func_ptr_cnt; i++) {
+		struct bpf_func_ptr *fp = &env->func_ptrs[i];
+
+		if (fp->xlated_off == BPF_FUNC_PTR_DELETED)
+			continue;
+		fp->xlated_off = bpf_patch_image_remap(img, img->new_off, fp->xlated_off);
+	}
+
+	/* NOTE: fake 'exit' subprog should be updated as well. */
+	for (i = 0; i <= env->subprog_cnt; i++)
+		env->subprog_info[i].start =
+			bpf_patch_image_remap(img, img->new_off, env->subprog_info[i].start);
+}
+
+/*
+ * Apply all queued patches in one go. Everything that names an insn of the
+ * old image follows it to the new one, a patched insn is named by the first
+ * insn of its patch, like with bpf_patch_insn_data().
+ *
+ * The order of the steps is a rule:
+ * 1. All that can fail: build the new image aside and allocate memory. An
+ *    error leaves the program and the env as they were.
+ * 2. Move each table that names insns. The new value of an entry depends on
+ *    its old value and on the maps of the image only. Between the first and
+ *    the last step one part of the env describes the old image and another
+ *    part the new one, so don't call a helper that reads prog->len, the insns
+ *    or one of these tables from the env or the program.
+ * 3. Install the new image.
+ */
+int bpf_patch_list_commit(struct bpf_verifier_env *env)
+{
+	struct bpf_patch_list *pl = &env->patch_list;
+	struct bpf_insn_aux_data *data = NULL;
+	struct bpf_prog *prog = env->prog;
+	struct bpf_patch_image img = {};
+	int err = 0;
+	u32 i;
+
+	if (!pl->cnt)
+		goto out;
+
+	err = bpf_patch_list_build(pl, prog, &img);
+	if (err == -ERANGE) {
+		verbose(env, "insn %d cannot be patched due to 16-bit range\n",
+			env->insn_aux_data[img.bad].orig_idx);
+		goto out;
+	}
+	if (verifier_bug_if(err == -EFAULT, env, "insn %u jumps out of the program",
+			    img.bad))
+		goto out;
+	if (err)
+		goto out;
+
+	err = -ENOMEM;
+	data = __vmalloc(array_size(img.new_cnt, sizeof(*data)),
+			 GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	if (!data)
+		goto out;
+
+	prog = bpf_prog_realloc(prog, bpf_prog_size(img.new_cnt), GFP_USER);
+	if (!prog)
+		goto out;
+	env->prog = prog;
+	err = 0;
+
+	patch_list_remap_aux(env, &img, data);
+	data = NULL;
+	patch_list_remap_subprogs(env, &img);
+	for (i = 0; i < env->insn_array_map_cnt; i++)
+		bpf_insn_array_remap(env->insn_array_maps[i], img.new_off,
+				     img.cnt, img.grow);
+
+	bpf_patch_image_install(prog, &img);
+out:
+	vfree(data);
+	bpf_patch_image_free(&img);
+	bpf_patch_list_release(pl);
+	return err;
+}
+
 /*
  * insn was moved down by delta insns inside its own patch. Operands relative
  * to the pc that point in front of the old position did not move with it.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1b6c0674ff6a..5bdf41a9bef0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24240,6 +24240,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (env->insn_aux_data)
 		bpf_clear_insn_aux_data(env, 0, env->insn_aux_data_len);
 	vfree(env->insn_aux_data);
+	bpf_patch_list_free(env);
 	kvfree(env->fd_array);
 	bpf_free_scev(env);
 	bpf_stack_liveness_free(env);
-- 
2.55.0

