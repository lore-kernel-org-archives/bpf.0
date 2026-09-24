Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B943E0083
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219484; cv=none; b=dLsa7PeC75VwFbd1dtZnUfkjpKtJcOJn0gGrxjsu7lI7cFnxsP+tSKItMz3K1nW08iRvRC1LzLqGmYBBeIyQjxJkIRr7Xa3Hc9O15nlqcY/VVXgPQEfUBIho0PXPz4DR643NkbFNRKoRLY0/GF2z0riYiuwnMZukUyA+VNy2JGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219484; c=relaxed/simple;
	bh=+iy88FV2VY6akVstFgMyhIBE7kh/W4kOvVy2/Ha0rnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TY2PrvC+46OTMT4474bds3/pvDN2kvZAmk1CD26XPhA9DtSHCm/oW/W098eJBlgkVOf9j8eN53GpD0W2QW6cXA3lFq2upyJDchvPi2ZsxeqssPjQgjj3bOVCkWoEhZ0IiBsoMWM2jkM8bGbtoBxW7yLhZNBaNBPrZ91PDmVXQQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LalMldlG; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LalMldlG"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso1140842a91.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790219482; x=1790824282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c/QXp6aoJjYzHQmRjAwffOMiR01hXkwC0Cc4KTtlEKA=;
        b=LalMldlGgnxFTSz33fCsp17i8NtGbxy0WRAfJQAoby1pJsl+ygQ6F5cFz0rrqmyQ6G
         lmgyDKQw+XSJJtICr+0BJac9SMZhOMaADjiUkHkCIl2qF4OrZtC7cTmQgKksS8Dpn5/c
         7GAxNJVN5FMw8XtgZeocbgeo7mqLv06IP+qonwxQVbbPtui4GLOEoNF1ku6JwDU1Y28i
         UJfgIFJiSk8+uNoC+DotsvUr38uWVgAWdxweaoVz3wIDIdwt9uqlwG91EKvjSaek0cCk
         MwdCD0i3/VtwUjwl0hUHbFbKN5XDIHvkQjx//v4t+NweNMB/RQUSjfhBglQJ/vQMWkcQ
         tSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790219482; x=1790824282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c/QXp6aoJjYzHQmRjAwffOMiR01hXkwC0Cc4KTtlEKA=;
        b=Par9iGsTv4SzVOUD+bqH7vXvcHYoqahkFVPIwcKR3oDEOr4Bkgl+fl4h0+fMDfK62L
         cJLu9xc3ZqBs6xspgsciCm83MwjYskloNV2tlHzl4ypybMl7r9axfmx8j7T7Rykodxd0
         XqxjC+ZTfKFcz4wzfj2HsNzHckn+grk0AB9pCJIN9veVWqr6p84iqR4qxEvySdbABXfk
         k8K4v+5AxhuaDcg4ghKyx/XMQZ4dNxQOFx2EaOmwFwC/auhThdjBCjaXqOS77oQ3wpy7
         fUFpZO3p/UtVeq+BNmUTwR8os3couxY5UkQNdhUmbyfsG6GZdHDTtQjMIECiL1Kdet2R
         /gNw==
X-Gm-Message-State: AFuF++lBe0NFBnbH3KJdRimLECLDKBOVGYLl26u0IhhSE4x3UeC2fbZ8
	Duazbv1F9ozuZEOogWwQkvXV73aEbyhnlwJsKJvuegvAFW+X2guf/u9ODjcHPg==
X-Gm-Gg: AYBFou2snm8soOeADM8BJIeq6sQogS4x7FGIEksB5Ld7pqCSdwu9ini92cvME5yb781
	u+Jm8TD+w+NiFpr1lqHyEPTA/E7jHnnPfYx+eHyzGkHdCCkqCrLoZDU2oBARSDM/cJqSwMJgqgX
	SiTV69pK8P9y31qvGzl7GkonUNPKj4vFpZ1SF0idNRh0tB/OQ3yd0L89rI219jIs/4NE/eoJLNm
	2Q22pGZeHSKp9JFL2HfTMz6pDl65Gf5h971IK9zJaQrW8uj4yjjEDYarpgx1xwNsv+jRbc1iHMy
	vlYwMpeUa6heYDjtOHlbXezCfojZqeQsdYRHmS9ZgpFdOUvDTz0p9b33SmoNbLls62yyVxSIapa
	+PVlYbVSfotkvi3W3wo6qaxPNG4Ta7tjNSDj0VFydpbVZ70S5wY5w3n95HDKJ+xp8kx8Vp2Wm+B
	gr2vdvQVxZ9C6OePv97zyS3p2GQUL5vqCqpAVorH9yfU+JYiGhPHe7mrQQ2OYkaBpq4Fjmxxqep
	TKm9QwezQgw8ES0Tik6Rf4kAJw2sj5Dc9t3a6IGXZdyklJpGqd/Nz9HgILLPbmo374C9S+fZhzD
	oXNW3gFkx5bjv3wwYzosmtkwQ0MjWPSo8KMGmiO4sWU=
X-Received: by 2002:a17:90b:50:b0:3a0:7d96:77f with SMTP id 98e67ed59e1d1-3a098567f87mr1124431a91.1.1790219482372;
        Wed, 23 Sep 2026 20:11:22 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972efa0bsm1998389a91.8.2026.09.23.20.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 20:11:21 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 11/17] libbpf: Support pointers to static functions in data when linking
Date: Thu, 24 Sep 2026 03:10:36 +0000
Message-ID: <20260924031042.1690890-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

A pointer to a static function in data, e.g.

  static int (* const handlers[])(void *ctx) = { foo, bar };

is R_BPF_64_ABS64 relocation against .text section symbol with the offset
of the function stored in place. The linker rejects it:

  relocation against STT_SECTION in non-exec section is not supported!

so an object with a table of static functions cannot go through
'bpftool gen object', which all selftests do.

Functions move by the offset of input .text in the output section.
Add it to the pointer. Swap bytes if the object is of foreign endianness,
since data sections are kept in the byte order of the object.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/linker.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 78f92c39290a..53f64a1a1f25 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -2274,6 +2274,24 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
 						insn->imm += sec->dst_off / sizeof(struct bpf_insn);
 					else
 						insn->imm += sec->dst_off;
+				} else if (sym_type == R_BPF_64_ABS64 &&
+					   (sec->shdr->sh_flags & SHF_EXECINSTR)) {
+					/*
+					 * A pointer to a static function in a data section,
+					 * which is stored in place as an offset of the
+					 * function in its section. Data sections are kept
+					 * in the byte order of the object.
+					 */
+					void *ptr = dst_linked_sec->raw_data + dst_rel->r_offset;
+					__u64 off;
+
+					memcpy(&off, ptr, sizeof(off));
+					if (linker->swapped_endian)
+						off = bswap_64(off);
+					off += sec->dst_off;
+					if (linker->swapped_endian)
+						off = bswap_64(off);
+					memcpy(ptr, &off, sizeof(off));
 				} else {
 					pr_warn("relocation against STT_SECTION in non-exec section is not supported!\n");
 					return -EINVAL;
-- 
2.55.0

