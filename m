Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5DB3655C4
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039648; cv=none; b=bj2etZvZH3bqYBE26HpabkXGLT/iylJhFfgkTgKN1GR+MqzWxesRS1R7ofsxyecPtn/17kTnkeG69vG1kZbt5OroviXEuU1NDLE9hf27IwI/YXFgZHPZCbUDsqbTC1mFFi+BzFtaQz/BNQG7Fefj0kpmyrKafpySUmUG2Bjs1ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039648; c=relaxed/simple;
	bh=+iy88FV2VY6akVstFgMyhIBE7kh/W4kOvVy2/Ha0rnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSJ7vF38wGwOrxVDlp3P5tBvaFlAAOtiBO9rx6VEHicfBL+ptyFeO0MCAXeoGANYtrSKTP2ZpybUsF7k630Cii8ICf4CcFtFAivgJTO47NGZWW6NMFnixUGVMTnZfRWDjFyL66oVjRHXih+YCACDGm1syNZVG4hsglxWGm0Wn0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVNpd/OB; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVNpd/OB"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39d654f02baso3020100a91.3
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039647; x=1790644447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c/QXp6aoJjYzHQmRjAwffOMiR01hXkwC0Cc4KTtlEKA=;
        b=BVNpd/OBSyYT85UbhOKg+DoK0aYN8HZ6UPFvFlMn4i6CU7jXVgbpjfyklOvM0Cc9TT
         epr8bn80FOuabUyYQKQ231f8j1lS8BeUYfcAxzVVIIuVIOxwr1+YPClggw9NeY7cGAie
         VWNI33A4VLttCG6GFfbPcV6OOVmztMNRqkuZC5tqAT3E9t0FXIQdxVRAyy+70y2YMOQp
         0U88PHuCa1TT9tH/2LrYpvgC8nBHCfnKLdNTvCNtt6l5vAShlMmQUUflEDO9Ha4D8C3R
         OC26U6ETc9cPbxqher90MzEvKiuYu3YWeOwAs12XSaaU2g1wL0Gbn3cKLuPOSpT1cd/K
         YApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039647; x=1790644447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c/QXp6aoJjYzHQmRjAwffOMiR01hXkwC0Cc4KTtlEKA=;
        b=RC0P2vzdju4HwCTS7vzACa1wQM30ynNKAupqNcuOSxQ5gf73lZlpBGrHoTlSFnalCk
         hKZTKFq3rjkTKkYKgrnyU7YpkaavkLjEwjdrV5I9uWO2JPzj7a0JPIrY1Lcxtgg5mBto
         CFog1ICWChtAKlnaE4l939hyLMDG6sNto30SFGXl/vd4s+R40OdhammSUp/74p6HLHc2
         41TrvxlPD/8yZaPCJ05vQFZWDKbkSeIj1NmnGRY28LlNrtN7gIC2jdxivL878IOgjTHG
         m1EaV8Qk6+bLUaWNhOfdEIagN9EIH6vMZE/tvczVLnGari7THZFtpfNywtJozeptW4m7
         Ndew==
X-Gm-Message-State: AFuF++lnG6XPHD4ThRNTcaeNh/nSHc25d4ObvympKZVxBuZyKpxpkSME
	drOzIZS8sl+7unzY0e9E52cykZkjzH0aQCWrryAmzwC2cOx99W8+akb3GzEZEQ==
X-Gm-Gg: AYBFou2L31wi+4rbGXDnxyu3ufMjUjAtXjnknACo+Rwd0+blpeL0IC2K8rs2IhmoGVH
	vBDRyzKAPFu+Dz/GAopAmz5Nybm94OMForrO/XTDa+9SElSZNGLeVDLmeGZFbt84fuFy1/i6HiK
	8ASZMwRDTDA3HjSh9DLN4WhQvKwXz8cIiW7XvPAEk5z0tWu/2dSY73IcAq4XUBM+m5kIFdToUS+
	qXvSXO4OD3BPIY92OgAqbXvAblg+TxV46pnymSw5cAoJ7vIzlWDVVqFygk7+R8bLbVDJ1XvSYGV
	4lw+Ox3sH0qNM12TaiuL8OuutNmM+BK0HknoFdnyybyBG7u5P1X7ReFc4lHJXXSKKsIqLpTXDT7
	iknnAJy0K7S8rVAleHQi11e/cIVjSkxSupFoWkjU6mZpWpa6qGfOa1d0psa46xMtrrVRXMVukMS
	RF8/nkZvRYH+m933/D2EOEHspiETJlGfEoIhz+nP7ngP4LqAWy/swCfp0zsJY94ja/2qPJLccQL
	4eypjr4H1JDlZbawWm7gKTmmXEGMDKX8v8SZxQ9em17EFNdH0/K3i/bDJp6DyrR4Iapg/sVmmiN
	6NBYIa46+0YUCJJbFZEGXuCF2lXm2XEcNHSq5GqdJKg=
X-Received: by 2002:a17:90b:540c:b0:3a0:516d:9f7e with SMTP id 98e67ed59e1d1-3a06af631cfmr813605a91.45.1790039646879;
        Mon, 21 Sep 2026 18:14:06 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06e5751f2sm245120a91.9.2026.09.21.18.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:14:06 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH bpf-next 11/17] libbpf: Support pointers to static functions in data when linking
Date: Tue, 22 Sep 2026 01:13:17 +0000
Message-ID: <20260922011323.1298619-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
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

