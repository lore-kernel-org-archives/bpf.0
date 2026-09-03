Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D4635F19A
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442496; cv=none; b=XX+I6DtH4FkVfBjpVGoAMfBio+msUJfHFhV1jEZwWPrAa8X5rPDsPemcUqzVa7pv4luB762bVHb0BRRzTzQCpmPy/0lGoqNJ1cuqc9RUSiof5PXUjrMz72yfedVODVrEDqSL+o4rVn2FNvVtr+yOLwI4JkiCL3NfcphDd2Gz488=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442496; c=relaxed/simple;
	bh=j1h1rv1LmIW0zaoGeiaNelfYvnsL6kCV3sA6HCK6RJc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f4jnF+0Xk6UsNWK91fRfe11rckTrikrJ6OACMS/LbvBihjgD68411dZaAU9C3FBviFIeVPTnOM16GVuA+m/hKxWbjGkVW2W29v+zsE6Drsq9U92rMDJ1sWLRwI8KCN9tIMCkTPJv1q7t+mYxKyLg1mL0cVuZVIeuIu9wIahFLY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhw1AHwd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhw1AHwd"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49ccfae359fso17405245e9.3
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 06:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788442485; x=1789047285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5b4o1sohYAp6JMucoB/3eMbCsksvnhxaFD6Rf7AovNM=;
        b=lhw1AHwd0FljJFAN+8mqrL4pRMJ3KdlUbBnfHIrVogFwVxJBbm91s3oMPH+eYj2srk
         Sd8zjGbX1uYKAtoO6TKmwD+qvGJl90vIxg/hS3USJ21P/8/fq/w0Za94zffHxCboR688
         4ArCU8vK5WigZpO8EmahAjyHGP7BL4Z7gmbS1F9f+hHKNgimOo4DY6VW1XdmkEqkYdbL
         OTEi8m4s/EdsnncR0VDKrwAFG04LujUUm1evh04IaOlP3q4VXj2MKeEKD28h2v2Hn6To
         GnELa35p5LdAspHOvbugSshm0nj1VbZoLUa8JgK1Ej95PESGQih1UXvNxLHCXVGuxFai
         bb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788442485; x=1789047285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5b4o1sohYAp6JMucoB/3eMbCsksvnhxaFD6Rf7AovNM=;
        b=exyBVLutgV/XFW8WjAky0a7vt6fnJJmwMijCaa4m5bgiiE/hLKSltMqER1cW/osh9b
         J7nm/FDcheFTFFLGOJwL9OTnwzazYP3v5lAncT37v0d2wORujgN1gg3iXpAG3rD+BFlF
         M6pBHyzrnCyNyLn1hKl6zpX81c06cT2P9Sxc5g9Uv3iV7rtRi6BYW0Zi9JHmqOazpH+B
         jbXEA9gXKhBMeNN2nElh/OnDGLHKCyz2ddQVdBBLxPDe/98xAa/DP12I/C9jf9tx3QYm
         qeKz+kQlKt4XLa0qDn5ouhiOKfftr0xzTJ978+unvkYSh+WsQ5KtkLoR1zu6KcBr9l0m
         IBoA==
X-Forwarded-Encrypted: i=1; AKwUvBwJ4jKeWEnK3ToIqgbtnnlgtRpSH+laY1CQXhKbxizuJOrXPkaoYjozUUW0RdIPCv41wYw=@vger.kernel.org
X-Gm-Message-State: AFuF++naW7QDH0/HCxdcJzE7cmjPQFT0maV1pGSQMSUxkCvtJpaIYHh+
	g00+xhm4DjuCW7oJM2HDa9wFUR9+zrrYiIgwd9W/5pUjK1y16wuDGOoD
X-Gm-Gg: AYBFou0mRqebYayGC1sJryz38iuhxj9PnQ0WZCkctnL/YJU2Qw6XCac2PXhWER0Hmzl
	cPp/2uOAWwxWATJNP5RFQgR/A7uJha1X+XO2bJDlpQZU2233Uz5PkXMdu4yLFdgcqxXNKJNc6uw
	Lu4MRIKK8IokbU2G8QMSGHtDdHPZfBfAtUj+kONW+wQAtOpJV4oHlPnTp1QvC0310x5p3gR6goz
	fURnhOisKJJTB2tffhr4cK6Z4wSIcCxxKqeYKCKflFTNpdL/xzPG+mG3WVQhU6wyobgcWGhqcBU
	2ndCfMmLDaklsI3aN6vYzZ6FajhtXVKW6nPC2zHIc3XQk85L00QtZzB+1EGBe1u2OTt0b3jNNCp
	xeuf7+JJDWmuUtvCN6Tk9aZjyaxwV28I8IPrrRKoPbNUh/qsng1Q8wgLPkzOpYNc528IIHgBQ8Y
	+NSMWQrr9gcruYE9lENg/czpjEEJo526jE5rPgW5NkogGMjqkEdOqHVDW8mm3zmYsOAteEor75J
	crRMZJpdww=
X-Received: by 2002:a05:600c:c170:b0:49b:d45:703e with SMTP id 5b1f17b1804b1-49ce57f072fmr269887985e9.8.1788442484440;
        Thu, 03 Sep 2026 06:34:44 -0700 (PDT)
Received: from DESKTOP-NFZVUTU.localdomain ([176.240.169.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60bae6sm88131755e9.9.2026.09.03.06.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:34:44 -0700 (PDT)
From: Utku Erol <utkuerol71@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	qmo@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Utku Erol <utkuerol71@gmail.com>
Subject: [PATCH] bpf: disasm: guard print_bpf_insn against BPF_MEMSX | BPF_DW
Date: Thu,  3 Sep 2026 16:34:34 +0300
Message-Id: <20260903133434.17860-1-utkuerol71@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

print_bpf_insn() renders a BPF_LDX by indexing one of two size tables with
BPF_SIZE(insn->code) >> 3. For BPF_MEMSX it uses bpf_ldsx_string[], which
has only three entries (W/H/B) because a sign-extended doubleword load is
not a valid instruction. The LDX branch checks only that the mode is
BPF_MEM or BPF_MEMSX; it never rejects BPF_MEMSX | BPF_DW. For that opcode
BPF_SIZE(code) >> 3 == BPF_DW >> 3 == 3, one element past the end of the
3-entry array:

  UBSAN: array-index-out-of-bounds: index 3 out of range for 'char *[3]'
  KASAN: global-out-of-bounds: 8-byte read in print_bpf_insn

The out-of-bounds slot is then dereferenced as %s.

The disassembler is expected to run on unvalidated instructions. Since
commit b9c5d822f677 ("bpf: Add source and instruction diagnostic context")
the diagnostics facility disassembles instruction context from
check_subprogs(), before check_insn_fields() has rejected the opcode, so a
raw BPF_MEMSX | BPF_DW insn reaches print_bpf_insn on the ordinary
bpf_prog_load() path whenever a verifier log is requested (log_level >= 1).

Reject the impossible size the same way the branch already rejects an
unexpected mode, keeping the disassembler total for any opcode.

Fixes: b9c5d822f677 ("bpf: Add source and instruction diagnostic context")
Signed-off-by: Utku Erol <utkuerol71@gmail.com>
---
 kernel/bpf/disasm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 50b3ca5149a0..70c2b281cfe9 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -299,6 +299,10 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			verbose(cbs->private_data, "BUG_ldx_%02x", insn->code);
 			return;
 		}
+		if (BPF_MODE(insn->code) == BPF_MEMSX && BPF_SIZE(insn->code) == BPF_DW) {
+			verbose(cbs->private_data, "BUG_ldsx_%02x", insn->code);
+			return;
+		}
 		verbose(cbs->private_data, "(%02x) r%d = *(%s *)(r%d %+d)",
 			insn->code, insn->dst_reg,
 			BPF_MODE(insn->code) == BPF_MEM ?
-- 
2.34.1

