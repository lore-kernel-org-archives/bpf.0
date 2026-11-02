Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793582989;
	b=tJNnxlGWwzJYFAzJAcfhunk/wOa4OxVxc0+HvMTKM65x4NVK01tAD7MUl4+tPrfIfME+
	 d2RbLPg4tzAjNCJu46iIfsXvTGg2IBUNJg5Fm5X1N9kIyRENmWboyuF6daRUNnKNQ338w
	 a/xoyX3qoIYcxucoIrBQn0dCdBCyHrqm6GptkXHKOq5p2GnFkim4N2OcCs/cdegUa/qIf
	 rEaphXT09HOZmtFDmVY0/bB6fAzVSyH0lUXE3N27MrzZEtYV5rg3pkxdlpg6d1XhUqpv4
	 J9C4aUUQtskVbb2L8leunYdV1QR+tth9bfVHcS8uMwms+h3ob48IuT/Gt8sP5YuAzqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793582989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Hb8ElyxtLSMJLEADiqtDWNfTaPL/ARlys6vHuP3UIwI=;
	b=ULV8cfhXJuLSLFqdh3AhEIoXf/o6D+hZ6fk3T1X+xB63ngvOvs4gWGED45jPq7ikyoqb
	 yyZRUmaqRVyaIJRvSuH1LPysYkY9vENTzRR86EqkWbdqMILQDksvIxu4uV0UsoRbS3hil
	 g197XUIAC3s63tWyPF0YsZsrJ27qfsykgjmjRezgbNrZ+1fkP6ulbijUc6b4pqFy9o5IV
	 w8OeBVP9yL6m2yeA9yHdPvwkvDPfcN49utGZpXPyf6MkUarzF1EE+iv8vi5aitIkB2KHF
	 XVgpbIOHeXUd0Uqp1OmqqUf70Lbw1b9Zb2JTyClXgQWLvvNWmAFtqMVn/ISLZx2tBLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qbIc0gTR;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B38606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 01:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8B38606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qbIc0gTR
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so1774475a91.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 17:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793582988; x=1794187788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hb8ElyxtLSMJLEADiqtDWNfTaPL/ARlys6vHuP3UIwI=;
        b=qbIc0gTRbuX87752Phl9kDIpIduLwvRMDQSwYWFjxaBuWGig/EjmBcRGRfU4vE2yWL
         eCc9lbllVNHZr190SJxEeuMRVW8g42djqTl/13cv67z8U5JRz51ee+PpgVukX4TCR4kA
         EbxnCFJ/mz4yg4xCjlur0V6ZdQlNzJqmYaq3E4JJ6xDrFxgaRlc+6IruDl+LNSWGt7qT
         QYxT9VufGTbhAGAf0Us7oQ7XPBWwwvijWvum4rm5LuQ7jL+3fFWbP6Te8qjlgj1WjJQW
         5NNr9ikM09W6YsryZKXGWWLDCDg+6xuLYBfxu7jYLijgaI/JVopzBoodWUkMgB3vA1jZ
         9CzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793582988; x=1794187788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hb8ElyxtLSMJLEADiqtDWNfTaPL/ARlys6vHuP3UIwI=;
        b=xPThSeYpV4sgPPWf+HG53yYX5S9bfoziuHPhdfw16huMPqSbgbGBpbALw6E76/FY9Z
         DuSB0D0qioAssrn3TbhrZI9on07s5tuJDikSpc6KJXL/pscESuVG1yEm6RWPSNR9RYED
         tsKpAKeR7INJgNU4qbV6dA63q4jWmRSG1eK9gzl+QsraLPPV+ucrfkxgrP0fShyp6n/0
         YntGuu1PUeQXXZXwQT4JVexrwWZp8KK+3owmGZBQIxET+JuN7ESgPh1LutOGmXtE/SlU
         OwKtPN2Mekz2J2hKQ550ZcmOd/AjA90vbvvQDOkHlDaI+PutoCLiGyzmku3DJ8VnLkCa
         d/5g==
X-Gm-Message-State: APuU4Z+hPACcDjTjz1MWAqd8J42rdsYuFYKMvIgIOpa6yhloR4JDvzbX
	pd3CBp/r1vNP7UPp47OHBjRT0K7COI3ZRBzBhTJDYtHoFwcfdFcIraPYavsFXw==
X-Gm-Gg: AYBFou1Xg4CWXaLCugXpDNb4giioREJ+aK8fxFoXb5vvaoALCN2n4YRHDUc56rWPxnL
	HBNqRONO/M4GObVfHBcrRQoi+enCe5DaRoFw28J3H2WjTNHJHd2KRn6zDbx82NzTR9sCumKbE2T
	wP6dZqpbVeQ0oFoRQFROHjMNwGieSZyZX9WEewdbp5o5SnCpgkOZviYURZFxRLRM0EP1E6eyrY4
	l6cgi/f0WvKcxENlDSSoTD/s82nf2apoGLM4je/bjPsVGvF9xVhBIhRuaxlpW0hCAj30hj6e2rL
	a/ZS9PUJ0XAh3H6ZIJOoDHzoEeFz/ccxnqNZz+UBNravOBYca4vvJHpeTr9hcXFs+dAtX9IBqq+
	kWSMJ1OA5YJW0XAxOoNjh5hthhPHPkRSaf2kX+2F2/n49oVEU+mkp0XJ6w7UlBew6jUgx7Z1GlR
	F/hi9ohSch//UZ6mpXWpIbJcUy16ZPpGHVHK/TL1fXtrPj+4EEuyCOA3MSlydFUVPX1x4AiHVrI
	PtjF3Gb+MX/ftJ1uoD2dQIaSQB5h2/MtQmLYgmZz4gB1PvlNYLnRmEKwLrwAWRsX1LM9MLv1AQR
	nylAEBieeNp56A8DClBeyrw/GK5CetucB6jVtD/+/mtRlhZfOcwDNvavzDJLZvI/c8zLmuAxhNb
	5F1k4PkBzzct+sDZ4fLsxnrt4j8AveInsCaOJa6/NhQ1Qq6Oz7Z22IF7mnJsBhdcKi4oNejunRA
	==
X-Received: by 2002:a17:90b:4b90:b0:3a4:7730:33dd with SMTP id 98e67ed59e1d1-3ae8984b662mr7314399a91.58.1793582988082;
        Sun, 01 Nov 2026 17:29:48 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9583c1sm17014126a91.10.2026.11.01.17.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 17:29:47 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	odys.yuan@gmail.com
Subject: [PATCH bpf-next v3 01/13] bpf: Add a list of deferred instruction patches
Date: Mon,  2 Nov 2026 01:29:28 +0000
Message-ID: <20261102012940.1756142-2-alexei.starovoitov@gmail.com>
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

After verification the verifier replaces many insns of a prog with several
insns each. bpf_patch_insn_data() and bpf_patch_insn_single() patch one
insn immediately. Each call moves all insns behind the patch and walks all
insns to adjust the jumps. It also walks each table that names insns, for
example line info. Thus a pass that patches M of the N insns of a prog does
O(N * M) work.

pyperf180 from the selftests has 24k insns. The 920 patches that inline
bpf_map_lookup_elem() take about 40 % of its load time.

Add a patch list: an array of patches and an array with their insns. A pass
queues its patches in the order of the insns and does not change the prog.
Then one commit builds the new image in O(N + inserted insns). Its first
walk calculates new_off[], the map from old index to new index. Its second
walk copies insns and patches, and it adjusts the jumps.

  old image               patch list  new_off[]  new image
  0: r2 = 0                            0          0: r2 = 0
  1: r0 /= r1             4 insns      1          1: if r1 != 0 goto +2
                                                  2: w0 ^= w0
                                                  3: goto +1
                                                  4: r0 /= r1
  2: if r0 == 0 goto +1                5          5: if r0 == 0 goto +2
  3: r0 %= r1             2 insns      6          6: if r1 == 0 goto +1
                                                  7: r0 %= r1
  4: r2 += 1                           8          8: r2 += 1
  5: if r2 < 3 goto -5                 9          9: if r2 < 3 goto -9
  6: exit                             10         10: exit

new_off[i] is i plus the number of insns that the patches in front of i
add. A patched insn maps to the first insn of its patch, as with
bpf_patch_insn_data(). All that names an insn goes through the map:

  offset of a jump or a call    new_off[old target] - new index - 1
    old insn 2, target 4        new_off[4] - 5 - 1 = +2
    old insn 5, target 1        new_off[1] - 9 - 1 = -9
  poke descriptor, line info    new_off[old index]

 - A jump that stays in its patch does not change. A pass writes a jump
   that leaves its patch as if this patch was the only one.
 - bpf_patch_list_build() builds the new image in new memory. A jump can
   get out of the range of its 16-bit offset. Then the function returns
   -ERANGE, and the prog does not change.
 - The code is in core.c and needs no bpf_verifier_env. Thus the blinding
   of constants in classic BPF progs can use it. No pass uses the list yet.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  47 ++++++++
 kernel/bpf/core.c            | 220 +++++++++++++++++++++++++++++++++++
 2 files changed, 267 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7baeb831281f..baa3a29a190e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1059,6 +1059,53 @@ struct bpf_fd_array {
 	};
 };
 
+/* one deferred patch: insn 'off' is replaced by 'len' insns */
+struct bpf_insn_patch {
+	u32 off;
+	u32 len;
+	u32 start;		/* first insn of the patch in bpf_patch_list.insns */
+	struct bpf_insn orig;	/* the replaced insn when the patch was queued */
+};
+
+/*
+ * Patches queued by a rewrite pass, applied together by
+ * bpf_patch_list_commit() in O(prog->len + inserted insns).
+ */
+struct bpf_patch_list {
+	struct bpf_insn_patch *patches;
+	struct bpf_insn *insns;
+	u32 cnt;
+	u32 cap;
+	u32 insn_cnt;
+	u32 insn_cap;
+};
+
+/* the image of a program with the queued patches applied, see bpf_patch_list_build() */
+struct bpf_patch_image {
+	struct bpf_insn *insns;
+	u32 *new_off;
+	u32 cnt;
+	u32 new_cnt;
+	s32 grow;
+	u32 bad;
+};
+
+/* Map an offset in the old program, which may be past its end. */
+static inline u32 bpf_patch_image_remap(const struct bpf_patch_image *img,
+					const u32 *map, u32 off)
+{
+	return off <= img->cnt ? map[off] : off + img->grow;
+}
+
+struct bpf_insn *__bpf_patch_list_add(struct bpf_patch_list *pl,
+				      const struct bpf_prog *prog, u32 off,
+				      const struct bpf_insn *patch, u32 len);
+void bpf_patch_list_release(struct bpf_patch_list *pl);
+int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog *prog,
+			 struct bpf_patch_image *img);
+void bpf_patch_image_free(struct bpf_patch_image *img);
+void bpf_patch_image_install(struct bpf_prog *prog, const struct bpf_patch_image *img);
+
 /* single container for all structs
  * one verifier_env per bpf_check() call
  */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e6593febbc35..5c4898c91a43 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -530,6 +530,226 @@ int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 	return err;
 }
 
+static int patch_list_reserve_patch(struct bpf_patch_list *pl)
+{
+	struct bpf_insn_patch *p;
+	u32 cap;
+
+	if (pl->cnt < pl->cap)
+		return 0;
+
+	cap = max(pl->cap * 2, 16U);
+	p = kvrealloc(pl->patches, array_size(cap, sizeof(*p)), GFP_KERNEL_ACCOUNT);
+	if (!p)
+		return -ENOMEM;
+	pl->patches = p;
+	pl->cap = cap;
+	return 0;
+}
+
+static int patch_list_reserve_insns(struct bpf_patch_list *pl, u32 cnt)
+{
+	struct bpf_insn *insns;
+	u32 cap;
+
+	if (pl->insn_cnt + cnt <= pl->insn_cap)
+		return 0;
+
+	cap = max3(pl->insn_cap * 2, pl->insn_cnt + cnt, 64U);
+	insns = kvrealloc(pl->insns, array_size(cap, sizeof(*insns)), GFP_KERNEL_ACCOUNT);
+	if (!insns)
+		return -ENOMEM;
+	pl->insns = insns;
+	pl->insn_cap = cap;
+	return 0;
+}
+
+/*
+ * Extract the pc-relative operand of a jump, a subprog call or a ld_imm64 of a
+ * subprog. gotox and a tail call pass for a jump to the next insn: nothing
+ * reads their 'off'.
+ */
+static bool insn_get_rel(const struct bpf_insn *insn, s64 *rel, bool *is_imm)
+{
+	u8 code = insn->code;
+
+	if (bpf_pseudo_func(insn) || bpf_pseudo_call(insn)) {
+		*rel = insn->imm;
+		*is_imm = true;
+		return true;
+	}
+	if ((BPF_CLASS(code) != BPF_JMP && BPF_CLASS(code) != BPF_JMP32) ||
+	    BPF_OP(code) == BPF_CALL || BPF_OP(code) == BPF_EXIT)
+		return false;
+
+	*is_imm = code == (BPF_JMP32 | BPF_JA);
+	*rel = *is_imm ? insn->imm : insn->off;
+	return true;
+}
+
+/* Set the pc-relative operand that insn_get_rel() extracted. */
+static int insn_set_rel(struct bpf_insn *insn, s64 rel, bool is_imm)
+{
+	if (is_imm) {
+		if (rel < S32_MIN || rel > S32_MAX)
+			return -ERANGE;
+		insn->imm = rel;
+	} else {
+		if (rel < S16_MIN || rel > S16_MAX)
+			return -ERANGE;
+		insn->off = rel;
+	}
+	return 0;
+}
+
+/*
+ * insn is number 'idx' of the 'len' insns that replace insn 'off' of the old
+ * image (an insn that isn't patched is its own patch of length 1). It lands
+ * at 'pos' of the new image. 'new_off' maps the old image to the new one.
+ */
+static int patch_list_adj_insn(struct bpf_insn *insn, const u32 *new_off,
+			       u32 cnt, u32 off, u32 idx, u32 len, u32 pos)
+{
+	bool is_imm;
+	s64 rel, tgt;
+
+	if (!insn_get_rel(insn, &rel, &is_imm))
+		return 0;
+
+	/* relative to the first insn of the patch */
+	tgt = (s64)idx + rel + 1;
+	if (tgt >= 0 && tgt < len)
+		return 0;
+
+	/* the patch pushed what follows 'off' down by len - 1 */
+	tgt = tgt < 0 ? off + tgt : off + tgt - len + 1;
+	if (tgt < 0 || tgt > cnt)
+		return -EFAULT;
+
+	rel = (s64)new_off[tgt] - pos - 1;
+	return insn_set_rel(insn, rel, is_imm);
+}
+
+/*
+ * Queue the replacement of insn 'off' of 'prog' by 'patch[0..len)'. Patches
+ * are queued in increasing order of 'off' and applied together, so a pass
+ * keeps addressing insns by their index in 'prog'. Jumps in the patch that
+ * leave it are relative to the patch placed at 'off'.
+ *
+ * Return the copy of the last insn of the patch, which stays valid until the
+ * next call.
+ *
+ * The caller sees to the order, to off < prog->len and to len > 0.
+ */
+struct bpf_insn *__bpf_patch_list_add(struct bpf_patch_list *pl,
+				      const struct bpf_prog *prog, u32 off,
+				      const struct bpf_insn *patch, u32 len)
+{
+	struct bpf_insn_patch *p;
+	int err;
+
+	err = patch_list_reserve_patch(pl) ?: patch_list_reserve_insns(pl, len);
+	if (err)
+		return ERR_PTR(err);
+
+	p = &pl->patches[pl->cnt++];
+	p->off = off;
+	p->len = len;
+	p->start = pl->insn_cnt;
+	p->orig = prog->insnsi[off];
+	memcpy(pl->insns + p->start, patch, len * sizeof(*patch));
+	pl->insn_cnt += len;
+
+	return &pl->insns[p->start + len - 1];
+}
+
+void bpf_patch_list_release(struct bpf_patch_list *pl)
+{
+	kvfree(pl->patches);
+	kvfree(pl->insns);
+	memset(pl, 0, sizeof(*pl));
+}
+
+/*
+ * Build the image of 'prog' with the queued patches applied in img->insns,
+ * without touching 'prog'. img->new_off[] maps each old insn to the start of
+ * its patch. On -ERANGE, img->bad is the old insn whose jump got out of range.
+ */
+int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog *prog,
+			 struct bpf_patch_image *img)
+{
+	u32 cnt = prog->len, i, k, n;
+	int err;
+
+	memset(img, 0, sizeof(*img));
+	img->cnt = cnt;
+	img->new_off = kvmalloc_array(cnt + 1, sizeof(u32), GFP_KERNEL_ACCOUNT);
+	if (!img->new_off)
+		return -ENOMEM;
+
+	for (i = 0, k = 0; i <= cnt; i++) {
+		img->new_off[i] = i + img->grow;
+		if (k < pl->cnt && pl->patches[k].off == i)
+			img->grow += pl->patches[k++].len - 1;
+	}
+	img->new_cnt = cnt + img->grow;
+
+	img->insns = kvmalloc_array(img->new_cnt, sizeof(*img->insns), GFP_KERNEL_ACCOUNT);
+	if (!img->insns)
+		return -ENOMEM;
+
+	for (i = 0, k = 0; i < cnt; i++) {
+		const struct bpf_insn *src = &prog->insnsi[i];
+		u32 len = 1, pos = img->new_off[i];
+
+		if (k < pl->cnt && pl->patches[k].off == i) {
+			src = &pl->insns[pl->patches[k].start];
+			len = pl->patches[k++].len;
+		}
+
+		for (n = 0; n < len; n++) {
+			img->insns[pos + n] = src[n];
+			err = patch_list_adj_insn(&img->insns[pos + n], img->new_off,
+						  cnt, i, n, len, pos + n);
+			if (err) {
+				img->bad = i;
+				return err;
+			}
+		}
+	}
+	return 0;
+}
+
+void bpf_patch_image_free(struct bpf_patch_image *img)
+{
+	kvfree(img->insns);
+	kvfree(img->new_off);
+	memset(img, 0, sizeof(*img));
+}
+
+/*
+ * Move the poke descriptors and the line info of 'prog' along, then put the
+ * new image in 'prog', which has room for it. The new value of an entry
+ * depends on its old value and on the maps of 'img' only.
+ */
+void bpf_patch_image_install(struct bpf_prog *prog, const struct bpf_patch_image *img)
+{
+	u32 i;
+
+	for (i = 0; i < prog->aux->size_poke_tab; i++)
+		prog->aux->poke_tab[i].insn_idx =
+			bpf_patch_image_remap(img, img->new_off,
+					      prog->aux->poke_tab[i].insn_idx);
+
+	for (i = 0; i < prog->aux->nr_linfo; i++)
+		prog->aux->linfo[i].insn_off =
+			bpf_patch_image_remap(img, img->new_off,
+					      prog->aux->linfo[i].insn_off);
+
+	memcpy(prog->insnsi, img->insns, sizeof(*img->insns) * img->new_cnt);
+	prog->len = img->new_cnt;
+}
+
 static void bpf_prog_kallsyms_del_subprogs(struct bpf_prog *fp)
 {
 	int i;
-- 
2.55.0

