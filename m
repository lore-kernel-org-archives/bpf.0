Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361186;
	b=H1U6MX0XdZg65QvaSwiYwn/+4Ynccpftilf9vpB65KhYLqgDb7BLglDwdPegE51KlcAA
	 SToKkenoM8SI7QEY2LISbE56CymbITQ64WpQnMLyH2bSk0PqHgTOvKVLTkB2/YJXUFeZ9
	 doFSCopGcrNkaCAhZ+RNlkoPZcQxrkCn2rBb4Gmv0fcfPrDjJAGkMZRV69n9uQN4UrewO
	 tDMHvKfH93Yt0ORlS1ctmVh0GdJ39fYUnJa1unJdaaemJ1gVGrH5iZTXJzLdQeZzsMDma
	 b0rIw2F4VRU8Fm4F5iou6ALGG8w/GhxbK4893WfyN++bBAmY1BJhzOgZ3ViOmdU26Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=iQEzt43Iqk8rbRcHs3uXdnSD5RPpGNITGkl2B8MxniU=;
	b=vgGWcr581aXaCc3ggyL0HiZpnnbfN9TufWoQEpvT5eTi4AhmOZR7BOcVHm9HDLDBRVzp
	 zksnE5AJOmIRlvUn1nwFpFSqRmOXAytwnwrU1NP+dY+xAln3lFVVBIxm9+I9kbG3qnIZh
	 wOzSo6J/sS/8xCrN+YBAEkFU8kQJMeKmMkSHjh4ahcJF5XO5RcWFEJLh0JQY39DVMMImF
	 1mJdw3hgn/hWUPFSM9GWQUgvimYConoU9YnMdIbiVcbndbPBsSqZiqyaVJgF86IDNDxJK
	 PbhQ0txJf2nIxeWBUQiQaRXbTUVZ+bYqBplm3UTP2goi3JZDDF1oWe634RP9Pk7deSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0gRuXZ7z;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240E3606A326
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 11:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 240E3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0gRuXZ7z
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a8cc11ac42so493386c88.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793361185; x=1793965985; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iQEzt43Iqk8rbRcHs3uXdnSD5RPpGNITGkl2B8MxniU=;
        b=0gRuXZ7zMuqbsyWRK6lKnnzAHdWcTKuZUdwmJmDS1F7SpRV1uDXTNRfWBOPV3lvtlP
         jFWjXPQQYsz0P8Jz/88sy5s62vr6S+HcA1Wm3qgghHVPkppetfVW6lQsa+yPiSIax0q9
         /qrtTJTITs6yb0cSTeZjYrVbWlGVMe13t3IfWVpwPzsCCbKla7fxDMT60hsRRVTAf649
         ozSe37tXGQCcBbZ1EU4VtzcEipOkZ4BMLB2Lq93EX7Rvg+HlOXnqy0TOBewVPIFzTeV3
         FwidNwo/JtEWA2+22VhhOgQooaBUCmkDwoOhtdwemtBa/yI63uT6V4GaCVNWfbTz7NLm
         OuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361185; x=1793965985;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iQEzt43Iqk8rbRcHs3uXdnSD5RPpGNITGkl2B8MxniU=;
        b=Wox/OlQyhIuQKVTwbsX850zjd43Nqu1Nnn9q5T53zxbl5XlNoRHCm1Sh5yReMGjajY
         fAUj1l+Y5b9IMQGCe1ZENHolOuKwQDPXjVBjHTeeQdj9ZtY+1LOYU4FE0I1VQ4Kn1IOk
         miQSKUu6mDDyiFf+2OJx9+KmG52FJ6DSqW8SikEhhRDzx2f1F9Y8+KMNWZdizPQyp4oO
         gZwrilBCmSye0I6tQ24RlLvqEDF0j/yu+KlPp5gpkANarl56o+ApL7m0IeyCiaod1/0x
         UGLDRiJSO+spv68wa2ztTD4N72mbEIYHbWkYVNiyZuhlXSKMP+LO8oYwQApq3a46eUZb
         7yIw==
X-Gm-Message-State: AFq9FYLD6sWKZFvkkrmNP6L8t4ubosqqPYYFiatScDZYocaguI2gtZwV
	c7NBA8dt61KwFfcKZVIy6FqlcELA2kaqgu783z4jyp/4UttWoV7dC5vYxhJJ9joZ
X-Gm-Gg: AYBFou2EUJzp7M4tWqHnf1w64nYsnr4u1yrB+DxuTnpsFePsPf1KnPxumTZxpUHjevh
	9Edd/by9giw2J4OXY48Uy3502uMS2llhgVUpZHqkpbBETHjDi5KOgybmE18LPAkYNVif0pd/Snq
	2Q+3v6Ks1KKPITZ+wsh0BGyfm2yU0n5QNoUCud6P7nERmQE0xlClxcosG7dOhxMyZQOY17CRZme
	UMWW363I2giBPXOl2hkTlOEE+oxHS5+0n6f0bMG7ZJdVxjsp6cRFFV03ZkknrSEXuvD15Pn8v43
	q/QKollSVAsmS6h+woVsUe0ljchPEUM3jpHgfLIG64mioOrudBTNpkW3/bYyObVCN3TEomjgSG4
	l+dyp6GUSECuQfhrJvbrXCWywKh8rUJ+nWEnHegGC9KWu5eDw1tw+p+Yli2Q8btpzSBu5HUd2Gc
	nRj+lu5hebthJ4Ogk3KGJFGgHNSBg2W7JS7hI8yrh2Xj23olj32dmayFAZFk83MCSfFX4pwBgmM
	CKnUmWRzwWEqZQszhp2+B4EU/bD6Yenj8+qcQwtRMW5cAIb6ztZKAs1tbvclIM/xsVOaV/+hghc
	71J2hcyTildwZisDsWYZhNV1
X-Received: by 2002:a05:7022:7f0e:b0:168:6ad8:e89f with SMTP id a92af1059eb24-1ad1068169fmr1638356c88.3.1793361185232;
        Fri, 30 Oct 2026 04:53:05 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcd6f1sm6437304c88.20.2026.10.30.04.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:53:04 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 30 Oct 2026 07:51:56 -0400
Subject: [PATCH bpf-next v2 11/22] bpf: Allow patching an instruction twice
 through the patch list
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-bpf-verifier-patch-batch-v2-11-55cd43439f7c@gmail.com>
References: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
In-Reply-To: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

bpf_convert_ctx_accesses() puts a barrier in front of an instruction
and may then rewrite the instruction as well. bpf_patch_insn_data()
applies the second patch to where the first one left the instruction,
the last instruction of the barrier patch.

The patch list refuses a second patch for an instruction, since it
takes patches in increasing order of the instruction they replace.

Make a patch queued again for the same instruction replace the last
instruction of the patch queued before. Move the backward jumps of the
new instructions down with them, so that a jump back to an earlier
instruction, like the one to the shared epilogue, still lands on it.
The barrier in front of it doesn't jump, so warn and fail if an
instruction in front of the last one jumps past it, instead of moving
such jumps along.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 kernel/bpf/core.c   | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/bpf/fixups.c |  5 +++--
 2 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 75d6399ce0965..10efd1dd36689 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -599,6 +599,46 @@ static int insn_set_rel(struct bpf_insn *insn, s64 rel, bool is_imm)
 	return 0;
 }
 
+/* Whether one of the 'len' insns of a patch in front of the last one jumps past it. */
+static bool patch_list_jumps_past(const struct bpf_insn *insns, u32 len)
+{
+	bool is_imm;
+	s64 rel;
+	u32 k;
+
+	for (k = 0; k + 1 < len; k++)
+		if (insn_get_rel(&insns[k], &rel, &is_imm) && (s64)k + rel + 1 >= len)
+			return true;
+	return false;
+}
+
+/*
+ * The 'len' insns of a patch were moved down by 'by' insns inside it. Keep
+ * what they referred to in front of the patch, the same way as
+ * bpf_adj_moved_insn() does: a call to the start of the patch, the old start
+ * of a subprog, stays there, a jump to itself doesn't.
+ */
+static int patch_list_move_down(struct bpf_insn *insns, u32 len, u32 by)
+{
+	bool is_imm, call;
+	s64 rel, tgt;
+	u32 k;
+	int err;
+
+	for (k = 0; k < len; k++) {
+		if (!insn_get_rel(&insns[k], &rel, &is_imm))
+			continue;
+		call = bpf_pseudo_func(&insns[k]) || bpf_pseudo_call(&insns[k]);
+		tgt = (s64)k + rel + 1;
+		if (tgt > 0 || (tgt == 0 && !call))
+			continue;
+		err = insn_set_rel(&insns[k], rel - by, is_imm);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 /*
  * insn is number 'idx' of the 'len' insns that replace insn 'off' of the old
  * image (an insn that isn't patched is its own patch of length 1). It lands
@@ -631,7 +671,10 @@ static int patch_list_adj_insn(struct bpf_insn *insn, const u32 *new_off,
  * Queue the replacement of insn 'off' of 'prog' by 'patch[0..len)'. Patches
  * are queued in increasing order of 'off' and applied together, so a pass
  * keeps addressing insns by their index in 'prog'. Jumps in the patch that
- * leave it are relative to the patch placed at 'off'.
+ * leave it are relative to the patch placed at 'off'. Patching 'off' again
+ * replaces the last insn of its patch, where the insn being patched went, and
+ * the insns in front of it must not jump past it. Jumps of the new insns that
+ * leave the patch are relative to the first of them, as for a first patch.
  *
  * Return the copy of the last insn of the patch, which stays valid until the
  * next call.
@@ -640,9 +683,26 @@ struct bpf_insn *__bpf_patch_list_add(struct bpf_patch_list *pl,
 				      const struct bpf_prog *prog, u32 off,
 				      const struct bpf_insn *patch, u32 len)
 {
-	struct bpf_insn_patch *p;
+	struct bpf_insn_patch *p = pl->cnt ? &pl->patches[pl->cnt - 1] : NULL;
 	int err;
 
+	if (p && off == p->off) {
+		if (WARN_ON_ONCE(patch_list_jumps_past(pl->insns + p->start, p->len)))
+			return ERR_PTR(-EFAULT);
+		err = patch_list_reserve_insns(pl, len - 1);
+		if (err)
+			return ERR_PTR(err);
+		/* the last patch is at the end of pl->insns */
+		memcpy(pl->insns + p->start + p->len - 1, patch, len * sizeof(*patch));
+		err = patch_list_move_down(pl->insns + p->start + p->len - 1, len,
+					   p->len - 1);
+		if (err)
+			return ERR_PTR(err);
+		p->len += len - 1;
+		pl->insn_cnt += len - 1;
+		return &pl->insns[p->start + p->len - 1];
+	}
+
 	err = patch_list_reserve_patch(pl) ?: patch_list_reserve_insns(pl, len);
 	if (err)
 		return ERR_PTR(err);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 6c2dce8f3b6eb..a56b743be0062 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -381,16 +381,17 @@ struct bpf_insn *bpf_patch_list_add(struct bpf_verifier_env *env, u32 off,
 				    const struct bpf_insn *patch, u32 len)
 {
 	struct bpf_patch_list *pl = &env->patch_list;
+	struct bpf_insn_patch *p = pl->cnt ? &pl->patches[pl->cnt - 1] : NULL;
 
 	if (bpf_rewrite_must_abort())
 		return ERR_PTR(-EINTR);
 
 	if (verifier_bug_if(!len || off >= env->prog->len ||
-			    (pl->cnt && off <= pl->patches[pl->cnt - 1].off),
+			    (p && (off < p->off || (off == p->off && !p->len))),
 			    env, "insn %u patched out of order", off))
 		return ERR_PTR(-EFAULT);
 
-	if (len == 1) {
+	if (len == 1 && (!p || off != p->off)) {
 		env->prog->insnsi[off] = *patch;
 		adjust_insn_aux_data(env, env->prog, off, 1, NULL,
 				     BPF_PATCH_KEEP_TARGET);

-- 
2.43.0

