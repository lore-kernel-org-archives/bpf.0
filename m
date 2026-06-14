Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF61539B4A6
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781429194; cv=none; b=asyauEGCIRvmYi8AerDnzBQE608HNc+TZVLxje34WsuiGo0vAK0aD8O0X2srNJdR5SEm09m7BvbcQuA2RcBNa/cezLWHCRJSFr2NhFTEwUJ6sRyhHNRjEgiUqSXZBIwUIqXRB3n+nL5WaESWKzPw1X/I432RndMHGzZ2qsAFh5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781429194; c=relaxed/simple;
	bh=lhowr9EjwPapIm5LZ9CUvqkGMBmfsnVS9rihubPA5e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoKZPG+vsa7Fjp0zcG5SWkLs3GGn//xwal1LJEbv853Colqt3Qcmahdg0mD815wQRz9AqogoQiZ56fiynAm40CYJCdxF6+3XSmi7apAmLW1/BtP2ajcnIKTdQXWYJgvyRgvUFoMF1DKB2JrZucuZf3kpLUzaeSRT7yLGr0XwOuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2qrsybh; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2qrsybh"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84230ab8857so1088991b3a.1
        for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 02:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781429191; x=1782033991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NT1UtqM2AmX11NcJjNv9n62UrLKyvxdMBYbCsYRy7Tg=;
        b=R2qrsybhpG8zS5xtDIWAsro5G+GDlQjIRuaZ9LuEoXyb1e3EzXKHCl6LDL9gegkaeq
         Z1/O6/DL56G1edjEaLOjuJOywShKh2nScTQ13ZKbfGTVj/q8xk6tpyDgDEz0VlFD1Mka
         AEitCfa0pqWyUDV2GoQ06P6yRwenUQqJDxKJEhrM6PsCRLy1dj9MdyoJ4ZmCLQNg1JP2
         r0S7Eg0SuuC94fT7pdg+730X3Bp1T/i4KIBiMA38XzIaMoBRXExDHovyQdrT/c/ZDSSu
         TX0CMuairgljLvQ9POq+wuVD6mT4Q/ZvlNGPRAQYwkA/b8qy2rTULQKSggOwh2Oq9m6O
         YRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781429191; x=1782033991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NT1UtqM2AmX11NcJjNv9n62UrLKyvxdMBYbCsYRy7Tg=;
        b=EMbAlueWqyEWF2jXRDFM7naoidkJjrXRzxSnEtz/YyRzJ6YHCeg38EKU+/KxQcnPA5
         7DLwu94s2cVUTTSmb3Y/7Va1vCrUmdhChykvwsiwhoQ2+GcHcqr1Vd1sXFezB+R7eyIn
         0RwV3HoS5XVpMyxOnbwweUuDUpoKdx921YqNjDtiaxsevbWIly1fwgQYp5Zl3JYy1pPj
         Yb3bqmdDDDLtMaenNF1AJgjw2tGI2MFRFOUIrpURAhSyr1F6VsgQ88axG8vi/eh1zqJd
         R+dW+hYAg8WG8s+/O1rBoKk5RjBBT5BywnI5wWDrfdz6rOW0QngGcHG0Mg6KO2yotPpO
         or4w==
X-Forwarded-Encrypted: i=1; AFNElJ8XeBeIlnUjtAVxVgsnY4wvDjq87euTrkWyTjBRjotPzYVB/1myHqwniwUiFTkJMNQvYao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMpRBbnmDoPTMLsKnscAwWqDnVEBDJL98LhGnopIXYECqyLqtC
	WO3JEREAZNItqfXCtclpGRKt1UPYkCBRZUAbw2AMBPi3WZEQU/6sV3It
X-Gm-Gg: Acq92OH1GJ+EwODeAZ9vrAAlCRcXEUdBnQWtHERryaSJJl5k5zpk05wnZFQ0a+DikNh
	ZFGR5LfT1UwP3JvDDBkKg9T/1J1F2NJZlyFl8t/Nnmq8z11/nVfL/pGcIMX/akZQNDrgBD3JdMW
	KRxB1GTHjYonPoepHILWr5WqPGzuHhelcqldia925b9EdXiZFqQCDf5nfDdV3BlvGVzy5uq7tex
	xiOfHMQ9ZNgZEb5i1M89KHu+AHhJfXOL0ymHqg6zvq4NOG6vspirJqgOZIQ9wY4y25F+F3vZyxC
	HZ3W4DZj3ochpj+1TyRiwvdcWQCMhIbrITn5AlfVExlKJYENyKCwNTuzcR+StyqfAvo7+4O2Wxj
	3aJBKJ6HEB1kci1sJapcZwXC38B1PAomPfOndaSFSpwmy9Mf5OfEFju+tJ2eRgpl3STC8+YJSFc
	VjWxeK13PGMtWyNTTu3XoPYTBWDaNtXdHYSa82kT3H2ZaLrKMyx1SEHSNmS2g4ic/t6T77QsDUj
	4s4nwTb7SWfj9ki
X-Received: by 2002:a05:6a00:3c8c:b0:842:688f:307f with SMTP id d2e1a72fcca58-8434cf0e0e6mr10983905b3a.28.1781429190897;
        Sun, 14 Jun 2026 02:26:30 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b057461sm8198423b3a.58.2026.06.14.02.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 02:26:30 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf v2 1/2] libbpf: Reject out-of-range linker relocation offsets
Date: Sun, 14 Jun 2026 18:26:15 +0900
Message-ID: <20260614092616.165337-2-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260614092616.165337-1-sammiee5311@gmail.com>
References: <20260614092616.165337-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The static linker sanity-checks relocation sections before appending them,
but for executable target sections it only verifies that r_offset is
BPF-instruction aligned.  It does not verify that the offset is inside the
relocated section.

A malformed object can therefore pass an out-of-range offset through
linker_sanity_check_elf_relos().  When the relocation is against an
STT_SECTION symbol, linker_append_elf_relos() uses the unchecked offset to
find the instruction to adjust:

  insn = dst_linked_sec->raw_data + dst_rel->r_offset;

and then reads insn->code and updates insn->imm.

This is reproducible with bpftool's static linker by crafting a BPF object
with a 16-byte executable section and a relocation in its .rel section
whose r_offset is 0x1000:

  BUG: AddressSanitizer: heap-buffer-overflow in linker_append_elf_relos
  READ of size 1
   linker_append_elf_relos
   bpf_linker_add_file
   bpf_linker__add_file
   do_object

Reject relocation offsets that are outside the relocated section before any
later use.  This mirrors the normal object loading path, which already
rejects executable relocations whose r_offset is not inside the program
section.

Fixes: faf6ed321cf6 ("libbpf: Add BPF static linker APIs")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 tools/lib/bpf/linker.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 78f92c39290a..3eb23da167d2 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -1048,6 +1048,12 @@ static int linker_sanity_check_elf_relos(struct src_obj *obj, struct src_sec *se
 			return -EINVAL;
 		}
 
+		if (relo->r_offset >= link_sec->shdr->sh_size) {
+			pr_warn("ELF relo #%d in section #%zu has invalid offset %zu in %s\n",
+				i, sec->sec_idx, (size_t)relo->r_offset, obj->filename);
+			return -EINVAL;
+		}
+
 		if (link_sec->shdr->sh_flags & SHF_EXECINSTR) {
 			if (relo->r_offset % sizeof(struct bpf_insn) != 0) {
 				pr_warn("ELF relo #%d in section #%zu points to missing symbol #%zu in %s\n",
-- 
2.43.0

