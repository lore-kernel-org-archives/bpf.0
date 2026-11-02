Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793583007;
	b=Xoc0slgsm3UXVm3wbahKoojLyLcoSoWzNFCiK0edkIJO05th+uJBWgayTRKktyj9DViZ
	 CjTAk2ST/wsCZIObkDHtBUNBe3SbDwawtIAUanslOB4QSZ47s8bZr6B0BxAlhyYCS2HJM
	 Y7dg1f9ShOVxJuXv90dz9SB8Uu9QyW4q90Md7AqsaolmFWFnf1nO6ER0M8bg81M2Xj1kF
	 4Tj1Q/lg7UwX1N2w7fv1SjX8nxFMvs794oMIr5PV0XKv7aIH5CxBC/KuC84cs5YTXR/in
	 l9OK87d7geJ09pwFbYiIbv0xOHsPgkoetB5HD48wAwbQEc6T+uhQTx6APgg5Q2uMDdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793583007;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2SQ+F2pX094eZr6b8oTELGG2vTC2BEDP13zXVokSPvU=;
	b=RBVyriXJunVuUFux3URdmdY0L72SywxyDW4e5sE+0ZBj8RPVggcxb//kBJKllw3F+bgj
	 /PAuSqy8la1ePurTJoXjdbAAFFNs2xOcyVm4CI/PICwvXRAI3BtZn5gDFwJcR0+DJPGnG
	 3iYZfRbeN29vBgbUt7rR12XUh1EKXHX0j9gyW4sNmVbbx4U6pCabatVccDQHQdzLd/Qcf
	 333rCeLZhrZqI9RVhyMFT1tLB2wBFhsaDo/XaLJKwDpffkQcxY5A0Hh6DZmqde0bUFhvu
	 KsqRzVss56OFjaQBQUSRxdD1NcUgfZZEs43UZ4gnAyIf8mcJjbxUPGojkxdQ+horUxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ercsrTpf;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27089606A326
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 01:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27089606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ercsrTpf
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ccca948203aso745637a12.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 17:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793583006; x=1794187806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2SQ+F2pX094eZr6b8oTELGG2vTC2BEDP13zXVokSPvU=;
        b=ercsrTpf5icK7+sHO6xUUm505Ko4QIAXSTYgSwzJ/T0198z37TX5SlKwNFJhKLKmC7
         PrNYJL5eWXLizFcJiwfIyCy6Y8e+pbQD1wufDQ5SY1kW0X9+JVaZziwy45ZhcKv42Y/u
         SVy4okmRalH7LW/j0drNtltMLk0zZh48Gx07wzTWLiVCkO4ZBkUZv1/ylaK044Veq3Gw
         Eb1XwPzXPLXR4xmaaf+o2aw/wLZ2s77EgBj0gkr9xCEjNDurwOxWpj796I9WrKKgxXDS
         0/+Y1Rqwt+YhUvznrANF31SfI6QGkv5b5WO4g6BY42zDa2JHUvqwmscRs+4EjJ7NlOnC
         lG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793583006; x=1794187806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2SQ+F2pX094eZr6b8oTELGG2vTC2BEDP13zXVokSPvU=;
        b=qXcn8acRRbpaWuF0lg/EbLIYtbKc1xNWMsQJocQWcJre+xxastdSXz9uTDQGUhDP5t
         RLkNA2fIOz5n4JzbTZkNelydGeVIFslCYNffo1osK0FQN2pSnFfcrNm/eNdy64rdX96+
         /296WvzLX6Qi2vtkxHDZ7L3Ubq4XjyOZYWlQg8oCeUYlJplT1syfBj+bciNGDGsvxS/S
         Fr8lx/Z49q/LTbSKVuGGtn7sKpjSAaVvL+i8JJB4JePSmTlUMfyQbCl//KGZUB4W9C44
         oOv/4sR7U4NV1B26fmtvmG2zsriMF/y5CtvAL1Q8ZfugQ1M2luylJAPKjvfGizWU3kJw
         RLSw==
X-Gm-Message-State: APuU4Z83xhKe5OhPO4IelFeDDZOzI3TKdiSaEJL7UijzTT2YmcQUFzYW
	eHnnLUCgrtF8gz4JFKhuF0g2gtH/AFxmH6871/0mtKAF+JDRMyc2o//fdy23VQ==
X-Gm-Gg: AYBFou2YwNhrID5iG9RZrz7wiMuX+f8mBx5ZIN4EvKeNzK0HlXUrxjBk2BuRpJKwmEC
	Ycq/0Zqc9HjJw6Dr2ZPAygOuNzzyTQMzDEuq96XxKkKyvd2DOEcjAlQlk/f3fMoeCPVW3ldgzhP
	YAp3NLNIRS5DS3n6YPiMLtO1JDa9l7seIh2mFCfBQTBdTGngqESSdaCfVQs1CG/VSHX9E6W9YBY
	VA0g5rNNRqurTcEtjlkLiLGXp4JQhYHzDALd0YjD0h/eDYbLdMN2SOkiPY6jYkWYTteVOcUZXZe
	Fqko6rdnftntfUbbTOBbKrZjE+Nel0ebCeYcRpcfxVdcYnyP/gXgzXICru1Xcz9iCsgQWOaQJqV
	ax+lrRkAd6iLfDiykG6wyKM1gGg2NECVJFKk+qRkCj5Tp6sBtKsl8wbyjzLEh9YP1n+cf0BX1Wj
	7kf64xcJv0mkLTQcn87YuBlaCKizBBEUCRDU0vRLsjB7HOr+wILrgqDaPmg67R4fSVFfTtKmK3K
	BaENi5PuNuJne2Mel8q952/it1QQGWQ9kw1wHzrRKBIBuYcWwEagJ9VR8WKxMUD1jymg8/tTRyK
	p07qgPRAI1m0tqTX3ic7CTCrDgFvNz30AYKdphCb3EvgQAhVFNljz+uKDDgJoO/Eh0XZ4g0Druu
	d2cHcZuaq5tlt7Xjhebcp3A2JDG7c+waDd8+jmc53/2AWairgM88ZcnEj2k1tH3tZeIICvahOKA
	==
X-Received: by 2002:a17:90b:3944:b0:3ad:4a8b:c6fd with SMTP id 98e67ed59e1d1-3ae89750f64mr5529970a91.28.1793583006189;
        Sun, 01 Nov 2026 17:30:06 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb09615125sm2467533a12.1.2026.11.01.17.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 17:30:05 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	odys.yuan@gmail.com
Subject: [PATCH bpf-next v3 04/13] bpf: Let the patch list remove instructions
Date: Mon,  2 Nov 2026 01:29:31 +0000
Message-ID: <20261102012940.1756142-5-alexei.starovoitov@gmail.com>
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

verifier_remove_insns() removes a range of insns immediately. Each call
moves all insns behind the range and walks all jumps and each table that
names insns. Thus M removals in a prog of N insns cost O(N * M). The patch
list can only replace an insn.

Add bpf_patch_list_del(). It queues a removal, which is a patch of 0 insns.
The map from old index to new index, new_off[], needs no new rule. A
removed insn maps to the next insn that stays:

  old image               patch list  new_off[]  new image
  0: if r1 == 0 goto +2                0          0: if r1 == 0 goto +1
  1: r0 = 1                            1          1: r0 = 1
  2: goto +0              removal      2
  3: goto +0              removal      2
  4: exit                              2          2: exit

Insn i is removed when new_off[i] == new_off[i + 1]. The rules for all that
names a removed insn are the rules of verifier_remove_insns():

  what names it     after bpf_patch_list_commit()
  ----------------  -------------------------------------------------------
  jump, call        It lands on the next insn that stays.
  aux data          The entry is removed.
  line info         The record is removed. If the next insn that stays has
                    no record, it gets the last removed record.
  subprog           It starts at the next insn that stays. When it has no
                    insns, it is removed with its func info.
  function pointer  It follows its subprog or gets BPF_FUNC_PTR_DELETED.
  insn array        The entry gets INSN_DELETED.

 - A removed record changes the index of the records behind it. Each
   subprog holds the index of its first record. Thus bpf_patch_list_build()
   calculates a map for the records too, new_linfo[].
 - Only the subprogs show where a subprog ends. Thus the function pointers
   move before the subprogs, while the subprogs have their old starts.
 - The two helpers for removed insns read bpf_verifier_env (env). Thus the
   commit calls them in the new step 2, before it moves the tables. Nothing
   can fail there. Thus a fatal signal does not stop the calls of the
   offload driver (nfp), as it does in verifier_remove_insns().

  1. all that can fail
  2. removed insns       Tell the offload device, free what their aux data
                         points to. All of env describes the old image.
  3. the tables
  4. the new image

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  11 +++
 kernel/bpf/bpf_insn_array.c  |  10 ++-
 kernel/bpf/core.c            |  81 +++++++++++++++--
 kernel/bpf/fixups.c          | 170 +++++++++++++++++++++++++++++++----
 4 files changed, 245 insertions(+), 27 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index fc051a084442..b77a0ba477f1 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1084,10 +1084,13 @@ struct bpf_patch_list {
 struct bpf_patch_image {
 	struct bpf_insn *insns;
 	u32 *new_off;
+	u32 *new_linfo;
 	u32 cnt;
 	u32 new_cnt;
+	u32 nr_linfo;
 	s32 grow;
 	u32 bad;
+	bool del;
 };
 
 /* Map an offset in the old program, which may be past its end. */
@@ -1097,9 +1100,16 @@ static inline u32 bpf_patch_image_remap(const struct bpf_patch_image *img,
 	return off <= img->cnt ? map[off] : off + img->grow;
 }
 
+static inline bool bpf_patch_image_deleted(const struct bpf_patch_image *img, u32 off)
+{
+	return off < img->cnt && img->new_off[off] == img->new_off[off + 1];
+}
+
 struct bpf_insn *__bpf_patch_list_add(struct bpf_patch_list *pl,
 				      const struct bpf_prog *prog, u32 off,
 				      const struct bpf_insn *patch, u32 len);
+int __bpf_patch_list_del(struct bpf_patch_list *pl, const struct bpf_prog *prog,
+			 u32 off);
 void bpf_patch_list_release(struct bpf_patch_list *pl);
 int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog *prog,
 			 struct bpf_patch_image *img);
@@ -2071,6 +2081,7 @@ struct bpf_insn *bpf_patch_list_add(struct bpf_verifier_env *env, u32 off,
 				    const struct bpf_insn *patch, u32 len);
 int bpf_patch_list_commit(struct bpf_verifier_env *env);
 void bpf_patch_list_free(struct bpf_verifier_env *env);
+int bpf_patch_list_del(struct bpf_verifier_env *env, u32 off);
 
 int bpf_flip_opcode(u32 opcode);
 u8 bpf_rev_opcode(u8 opcode);
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index 21ca87c96373..e2e4aee00c4d 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -254,8 +254,9 @@ void bpf_insn_array_adjust(struct bpf_map *map, u32 first, u32 len)
 }
 
 /*
- * Move each offset to new_off[offset], new_off[] covers [0, cnt]. Offsets
- * past the end of the old program only move by 'grow'.
+ * Move each offset to new_off[offset], new_off[] covers [0, cnt]. An insn is
+ * removed when it maps to the same offset as the next one. Offsets past the
+ * end of the old program only move by 'grow'.
  */
 void bpf_insn_array_remap(struct bpf_map *map, const u32 *new_off, u32 cnt, s32 grow)
 {
@@ -266,7 +267,10 @@ void bpf_insn_array_remap(struct bpf_map *map, const u32 *new_off, u32 cnt, s32
 		off = insn_array->values[i].xlated_off;
 		if (off == INSN_DELETED)
 			continue;
-		insn_array->values[i].xlated_off = off <= cnt ? new_off[off] : off + grow;
+		if (off < cnt && new_off[off] == new_off[off + 1])
+			insn_array->values[i].xlated_off = INSN_DELETED;
+		else
+			insn_array->values[i].xlated_off = off <= cnt ? new_off[off] : off + grow;
 	}
 }
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5c4898c91a43..e96de7a2c786 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -663,6 +663,25 @@ struct bpf_insn *__bpf_patch_list_add(struct bpf_patch_list *pl,
 	return &pl->insns[p->start + len - 1];
 }
 
+/* Queue the removal of insn 'off'. Jumps to it land on the next insn that stays. */
+int __bpf_patch_list_del(struct bpf_patch_list *pl, const struct bpf_prog *prog,
+			 u32 off)
+{
+	struct bpf_insn_patch *p;
+	int err;
+
+	err = patch_list_reserve_patch(pl);
+	if (err)
+		return err;
+
+	p = &pl->patches[pl->cnt++];
+	p->off = off;
+	p->len = 0;
+	p->start = pl->insn_cnt;
+	p->orig = prog->insnsi[off];
+	return 0;
+}
+
 void bpf_patch_list_release(struct bpf_patch_list *pl)
 {
 	kvfree(pl->patches);
@@ -670,10 +689,44 @@ void bpf_patch_list_release(struct bpf_patch_list *pl)
 	memset(pl, 0, sizeof(*pl));
 }
 
+/*
+ * Map the index of each line info record to its new one in img->new_linfo[].
+ * The record of a removed insn goes away: it gets the index of the next
+ * record. The last one before the next insn that stays moves to that insn
+ * instead, unless the insn has its own line info.
+ */
+static int patch_image_map_linfo(struct bpf_patch_image *img, const struct bpf_prog *prog)
+{
+	const struct bpf_line_info *linfo = prog->aux->linfo;
+	u32 i, j, pos, next, nr = prog->aux->nr_linfo;
+
+	img->new_linfo = kvmalloc_array(nr + 1, sizeof(u32), GFP_KERNEL_ACCOUNT);
+	if (!img->new_linfo)
+		return -ENOMEM;
+	img->nr_linfo = nr;
+
+	for (i = 0, j = 0; i < nr; i++) {
+		img->new_linfo[i] = j;
+		if (bpf_patch_image_deleted(img, linfo[i].insn_off)) {
+			pos = bpf_patch_image_remap(img, img->new_off, linfo[i].insn_off);
+			next = i + 1 < nr ?
+			       bpf_patch_image_remap(img, img->new_off, linfo[i + 1].insn_off) :
+			       U32_MAX;
+			if (pos >= img->new_cnt || next == pos)
+				continue;
+		}
+		j++;
+	}
+	img->new_linfo[nr] = j;
+	return 0;
+}
+
 /*
  * Build the image of 'prog' with the queued patches applied in img->insns,
  * without touching 'prog'. img->new_off[] maps each old insn to the start of
- * its patch. On -ERANGE, img->bad is the old insn whose jump got out of range.
+ * its patch, a removed insn to the next one that stays. img->new_linfo[] is
+ * there when insns are removed, see patch_image_map_linfo(). On -ERANGE,
+ * img->bad is the old insn whose jump got out of range.
  */
 int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog *prog,
 			 struct bpf_patch_image *img)
@@ -689,11 +742,19 @@ int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog
 
 	for (i = 0, k = 0; i <= cnt; i++) {
 		img->new_off[i] = i + img->grow;
-		if (k < pl->cnt && pl->patches[k].off == i)
+		if (k < pl->cnt && pl->patches[k].off == i) {
+			img->del |= !pl->patches[k].len;
 			img->grow += pl->patches[k++].len - 1;
+		}
 	}
 	img->new_cnt = cnt + img->grow;
 
+	if (img->del && prog->aux->nr_linfo) {
+		err = patch_image_map_linfo(img, prog);
+		if (err)
+			return err;
+	}
+
 	img->insns = kvmalloc_array(img->new_cnt, sizeof(*img->insns), GFP_KERNEL_ACCOUNT);
 	if (!img->insns)
 		return -ENOMEM;
@@ -723,6 +784,7 @@ int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog
 void bpf_patch_image_free(struct bpf_patch_image *img)
 {
 	kvfree(img->insns);
+	kvfree(img->new_linfo);
 	kvfree(img->new_off);
 	memset(img, 0, sizeof(*img));
 }
@@ -734,17 +796,22 @@ void bpf_patch_image_free(struct bpf_patch_image *img)
  */
 void bpf_patch_image_install(struct bpf_prog *prog, const struct bpf_patch_image *img)
 {
-	u32 i;
+	struct bpf_line_info *linfo = prog->aux->linfo;
+	u32 i, j;
 
 	for (i = 0; i < prog->aux->size_poke_tab; i++)
 		prog->aux->poke_tab[i].insn_idx =
 			bpf_patch_image_remap(img, img->new_off,
 					      prog->aux->poke_tab[i].insn_idx);
 
-	for (i = 0; i < prog->aux->nr_linfo; i++)
-		prog->aux->linfo[i].insn_off =
-			bpf_patch_image_remap(img, img->new_off,
-					      prog->aux->linfo[i].insn_off);
+	for (i = 0, j = 0; i < prog->aux->nr_linfo; i++) {
+		if (img->new_linfo && img->new_linfo[i] == img->new_linfo[i + 1])
+			continue;
+		linfo[j] = linfo[i];
+		linfo[j++].insn_off = bpf_patch_image_remap(img, img->new_off,
+							    linfo[i].insn_off);
+	}
+	prog->aux->nr_linfo = j;
 
 	memcpy(prog->insnsi, img->insns, sizeof(*img->insns) * img->new_cnt);
 	prog->len = img->new_cnt;
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 0a5b35a00f9f..588a3a3b6615 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -383,6 +383,22 @@ struct bpf_insn *bpf_patch_list_add(struct bpf_verifier_env *env, u32 off,
 	return __bpf_patch_list_add(pl, env->prog, off, patch, len);
 }
 
+/* Queue the removal of insn 'off' until bpf_patch_list_commit(). */
+int bpf_patch_list_del(struct bpf_verifier_env *env, u32 off)
+{
+	struct bpf_patch_list *pl = &env->patch_list;
+
+	if (bpf_rewrite_must_abort())
+		return -EINTR;
+
+	if (verifier_bug_if(off >= env->prog->len ||
+			    (pl->cnt && off <= pl->patches[pl->cnt - 1].off),
+			    env, "insn %u removed out of order", off))
+		return -EFAULT;
+
+	return __bpf_patch_list_del(pl, env->prog, off);
+}
+
 void bpf_patch_list_free(struct bpf_verifier_env *env)
 {
 	bpf_patch_list_release(&env->patch_list);
@@ -429,6 +445,32 @@ static void patch_list_adj_aux(struct bpf_prog *prog, struct bpf_insn_patch *p,
 	}
 }
 
+/*
+ * Let go of each range of removed insns: tell the device, whose driver finds
+ * them through the aux data of the old image, and free what their aux data
+ * points to. The commit can't fail anymore, so there is no check for a fatal
+ * signal between the calls of the driver.
+ */
+static void patch_list_drop_removed(struct bpf_verifier_env *env)
+{
+	bool offloaded = bpf_prog_is_offloaded(env->prog->aux);
+	struct bpf_patch_list *pl = &env->patch_list;
+	u32 k, n;
+
+	for (k = 0; k < pl->cnt; k = n) {
+		for (n = k; n < pl->cnt && !pl->patches[n].len &&
+		     pl->patches[n].off == pl->patches[k].off + n - k; n++)
+			;
+		if (n == k) {
+			n++;
+			continue;
+		}
+		if (offloaded)
+			bpf_prog_offload_remove_insns(env, pl->patches[k].off, n - k);
+		bpf_clear_insn_aux_data(env, pl->patches[k].off, n - k);
+	}
+}
+
 /* Fill 'data', the aux data of the new image, from the aux data of the old one. */
 static void patch_list_remap_aux(struct bpf_verifier_env *env,
 				 const struct bpf_patch_image *img,
@@ -441,9 +483,10 @@ static void patch_list_remap_aux(struct bpf_verifier_env *env,
 	for (i = 0, k = 0; i < img->cnt; i = end) {
 		if (k < pl->cnt && pl->patches[k].off == i) {
 			p = &pl->patches[k++];
-			patch_list_adj_aux(env->prog, p, &pl->insns[p->start],
-					   &env->insn_aux_data[i],
-					   &data[img->new_off[i]]);
+			if (p->len)
+				patch_list_adj_aux(env->prog, p, &pl->insns[p->start],
+						   &env->insn_aux_data[i],
+						   &data[img->new_off[i]]);
 			end = i + 1;
 			continue;
 		}
@@ -456,10 +499,76 @@ static void patch_list_remap_aux(struct bpf_verifier_env *env,
 	env->insn_aux_data_len = img->new_cnt;
 }
 
-/* Subprogs, and the function pointers that name them, follow their first insn. */
+/*
+ * Whether all insns from 'off' to the end of its subprog are removed. 'info'
+ * has the 'cnt' subprogs of the old image and the fake 'exit' subprog.
+ */
+static bool patch_list_subprog_gone(const struct bpf_subprog_info *info, u32 cnt,
+				    const u32 *new_off, u32 off)
+{
+	u32 l = 0, r = cnt, m;
+
+	/* find the next subprog */
+	while (l < r) {
+		m = (l + r) / 2;
+		if (info[m].start <= off)
+			l = m + 1;
+		else
+			r = m;
+	}
+	return new_off[off] == new_off[info[l].start];
+}
+
+/*
+ * Remove the subprogs whose insns are all removed, with their func_info. The
+ * passes that remove insns run before the hidden subprog, which has no
+ * func_info, is added.
+ */
+static void patch_list_del_subprogs(struct bpf_verifier_env *env,
+				    const u32 *new_off)
+{
+	struct bpf_subprog_info *info = env->subprog_info;
+	struct bpf_prog_aux *aux = env->prog->aux;
+	int i, j, exc_cb = env->exception_callback_subprog;
+
+	for (i = 0, j = 0; i < env->subprog_cnt; i++) {
+		if (new_off[info[i].start] == new_off[info[i + 1].start]) {
+			/* The exception callback is live, so it isn't removed. */
+			if (env->exception_callback_subprog > i)
+				exc_cb--;
+			continue;
+		}
+		if (i != j) {
+			info[j] = info[i];
+			if (aux->func_info)
+				aux->func_info[j] = aux->func_info[i];
+			if (aux->func_info_aux)
+				aux->func_info_aux[j] = aux->func_info_aux[i];
+		}
+		j++;
+	}
+	if (i == j)
+		return;
+
+	/* move fake 'exit' subprog as well */
+	info[j] = info[i];
+	/* func_info->insn_off is set after all code rewrites, in adjust_btf_func() */
+	if (aux->func_info)
+		aux->func_info_cnt -= i - j;
+	env->subprog_cnt = j;
+	env->exception_callback_subprog = exc_cb;
+}
+
+/*
+ * Subprogs, and the function pointers that name them, follow their first insn.
+ * A subprog whose insns are all removed goes away, and so do the pointers to
+ * it. Only the subprogs tell where a function ends, so move the pointers while
+ * the subprogs still have the starts in the old image.
+ */
 static void patch_list_remap_subprogs(struct bpf_verifier_env *env,
 				      const struct bpf_patch_image *img)
 {
+	struct bpf_subprog_info *info = env->subprog_info;
 	u32 i;
 
 	for (i = 0; i < env->func_ptr_cnt; i++) {
@@ -467,29 +576,53 @@ static void patch_list_remap_subprogs(struct bpf_verifier_env *env,
 
 		if (fp->xlated_off == BPF_FUNC_PTR_DELETED)
 			continue;
-		fp->xlated_off = bpf_patch_image_remap(img, img->new_off, fp->xlated_off);
+		if (bpf_patch_image_deleted(img, fp->xlated_off) &&
+		    patch_list_subprog_gone(info, env->subprog_cnt, img->new_off,
+					    fp->xlated_off))
+			fp->xlated_off = BPF_FUNC_PTR_DELETED;
+		else
+			fp->xlated_off = bpf_patch_image_remap(img, img->new_off,
+							       fp->xlated_off);
 	}
 
+	if (img->del)
+		patch_list_del_subprogs(env, img->new_off);
+
 	/* NOTE: fake 'exit' subprog should be updated as well. */
-	for (i = 0; i <= env->subprog_cnt; i++)
-		env->subprog_info[i].start =
-			bpf_patch_image_remap(img, img->new_off, env->subprog_info[i].start);
+	for (i = 0; i <= env->subprog_cnt; i++) {
+		info[i].start = bpf_patch_image_remap(img, img->new_off, info[i].start);
+		if (img->new_linfo)
+			info[i].linfo_idx =
+				img->new_linfo[min(info[i].linfo_idx, img->nr_linfo)];
+	}
 }
 
 /*
- * Apply all queued patches in one go. Everything that names an insn of the
- * old image follows it to the new one, a patched insn is named by the first
- * insn of its patch, like with bpf_patch_insn_data().
+ * Apply all queued patches and removals in one go. Everything that names an
+ * insn of the old image follows it to the new one. A patched insn is named by
+ * the first insn of its patch, like with bpf_patch_insn_data().
+ *
+ * An entry that names a removed insn:
+ *   jump, call, poke descriptor  names the next insn that stays
+ *   subprog                      too, or goes away when none of its insns stays
+ *   function pointer             follows its subprog or is BPF_FUNC_PTR_DELETED
+ *   line info                    goes away, but the next insn that stays takes
+ *                                the last record when it has none
+ *   aux data                     goes away
+ *   instruction array            is INSN_DELETED
  *
  * The order of the steps is a rule:
  * 1. All that can fail: build the new image aside and allocate memory. An
  *    error leaves the program and the env as they were.
- * 2. Move each table that names insns. The new value of an entry depends on
- *    its old value and on the maps of the image only. Between the first and
- *    the last step one part of the env describes the old image and another
- *    part the new one, so don't call a helper that reads prog->len, the insns
- *    or one of these tables from the env or the program.
- * 3. Install the new image.
+ * 2. Let go of the removed insns while all of the env describes the old image:
+ *    the helpers for that look at it.
+ * 3. Move each table that names insns. The new value of an entry depends on
+ *    its old value and on the maps of the image only. Function pointers need
+ *    the old subprogs too, see patch_list_remap_subprogs(). Between the first
+ *    and the last table one part of the env describes the old image and
+ *    another part the new one, so don't call a helper that reads prog->len,
+ *    the insns or one of these tables from the env or the program.
+ * 4. Install the new image.
  */
 int bpf_patch_list_commit(struct bpf_verifier_env *env)
 {
@@ -527,6 +660,9 @@ int bpf_patch_list_commit(struct bpf_verifier_env *env)
 	env->prog = prog;
 	err = 0;
 
+	if (img.del)
+		patch_list_drop_removed(env);
+
 	patch_list_remap_aux(env, &img, data);
 	data = NULL;
 	patch_list_remap_subprogs(env, &img);
-- 
2.55.0

