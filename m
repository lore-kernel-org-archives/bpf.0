Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903F846EF8F
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945267; cv=none; b=DMgdMnnzeXKQEmlkieDHW6ercW8g6B6thI8K5ew7SJADgy0t5ppW3YdwNzc8XxLLb2DRPRJL/0bT3ruGeADQ/3curUQ7mf0vaAUKQNfl8mcuJzGih2/sAI4LjHXno0Vyupd580fWVZr3HGHoxpSN+kULKZ5itMy5cCAPa4F1ISA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945267; c=relaxed/simple;
	bh=cXsYLl+Q8b7d4MawPZruPSdeYinL4Su1gmiN1V7BG8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ox5aaKNyEBTJIVpijNz+TGSR8iyYZFsBfMwnf4cPLBzzqeiAXCCCszyWWsNIg3ZMPcvKnSglm+/RFFK4NbXlTn/DZUZ/Pa4eTbyWsDbbLTsD845CmAbDcrJv6nM55rshypLJ/zcNCjmxyLR1+bzd69V7nRWEqokz6DUhTVWKgIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htpKZI5W; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htpKZI5W"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a6d43df6bcso369619a91.1
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 05:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790945266; x=1791550066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nBSAjtoxhys8Ve8fY2ylGFq7eYlflq9DlF7aYF9S30Y=;
        b=htpKZI5Wlk3rCIPfrY2SaVMbp5mA9denNuZWZcperQ0ODzsUyf1uoqvBMHWjc3nnwV
         o7Xtd+nrosPRCAhuEoldwwgow7yK8CSOUIE/CixP8Ygc07zPuxDyrxE04m29rWbnmf2z
         M111bruUQkkxI/UVgbRZXHdLEV7NxOCqsfCOm1DAgU1UVjes9z3vOZgQWrteWU5qXs5p
         dKXbpgt7sAuScjbYWZ9Vi4+bufOEccLWs1AwU1+SYg5a/PzMCH5xSpQN0uVYjMZrecrv
         EanhxLvRX9UL86tw48JHX0zULEBHW51QViEkCftUaHQ+2oII2s3UMaDhPgbK5KKDgE6W
         qXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945266; x=1791550066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nBSAjtoxhys8Ve8fY2ylGFq7eYlflq9DlF7aYF9S30Y=;
        b=t/LdB24pzJ8BcbSguE6xWTEHHty62mBVSl/svwkDtWqaJFyxN694eAI2pVE3U0vcqy
         mJZ81kgV+OyG0whR5fH/KYUB9fFJ4xJnG2Hhewm4IQqs0J1lTqejwXEvlB3HjgFbQBwD
         GUGgEMRQKCNVrmsBh3A+Vg2IA4Bdiwh/G3N2/E52XzMwEpuohTw3qGz9F7Kq9guV2FDf
         L8Nd5Y0pHv4faUm8frXOlrZQLwny8dMbR8yaYfc/l+dTWZOIB7bsVxi+qI9m2Kb9Oiu5
         j3Y0kxGIMWuM8X3H/UvSErEkEMJZnok1AfnVTy6vQmL8IUCzbHx3JQjA+0njvuGHtu+W
         iEOQ==
X-Gm-Message-State: AFq9FYJrbXilFPJ7GZIEAhezlyXh52VFYX3pKjjTMlsFcZAkS2S8JU3m
	200VhouTlfKlJjJ07Cz4nPEvaK4zlKZ/gWYEaOF3V0/0Ivvv8GGJ5+JfYjnkPbZ0m3Q=
X-Gm-Gg: AYBFou0IxbeIcjYXtGuXQ7e/Ablg4rkn1BUQc/7H5tiJGpP/NS+Qik0DYljhakU/RpW
	IggfJRH4CFqTDfmXX+rHmrPvSnBh50L+HuopyWPySjwGIcHKiKBRwVhsy/lNSOAcbXg6WCKM6iY
	Ih/1i8DBNQCNy+i3JcCUfsQWUC4vbZUYidDtlTBWNianzvuyiqPLeQPUiIFOQsdVyTmNt9NH2Ka
	Alf8W9bLb1pETr4idMi+KpNnwlBxpURpAxOAHNCV5QRg0m17EQz3I7ZdSPkHsEDi9S2pJm9zEiu
	73GgegHvYWhqiLBJufuXVnW+EPsawdXZc9muuIp1lTlr06L7H98UXcdLAzP/2riuV0D8r/PnJHB
	nHNZD4yQ12VanL1TpWQkc4twbaqa16xO42+/L7pxSp4FuMLuQVXaNOIebDB+PmG//mspBarNaSx
	8tTKvsKIIrn9cQPB5y/lcXUoHc6QOyHqPdn5SFadxyA4Cr2vrV+5U3OWUmplLCrTjLCwIEhSeJX
	A7mdc/t3vZLgu/buL/bFL0gWh7K6OoT8GWlbnTk9PfvVHIAZ1c4yPZWQsJI9j+YSDvRyNhAliKZ
	fWt+bXsPTRK6vxZVij6/Qddba1xr5B1eexpXrQms55s=
X-Received: by 2002:a17:90b:498b:b0:3a0:a912:e759 with SMTP id 98e67ed59e1d1-3a6ceaab429mr2306505a91.25.1790945265788;
        Fri, 02 Oct 2026 05:47:45 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6cd44c2besm3957378a91.3.2026.10.02.05.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:47:45 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 10/15] bpftool: Skip pieces of variables in DATASEC
Date: Fri,  2 Oct 2026 12:47:09 +0000
Message-ID: <20261002124714.180012-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
References: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The kernel accepts a variable in DATASEC that is smaller than its type.
It's a piece of a variable that the compiler split, with the type of
the whole variable. bpftool prints a variable by its type, so it reads
past the piece and, when the piece is the last in the section, past
the buffer with the value of the map:

  $ bpftool map dump pinned /sys/fs/bpf/piece
  ".bss": [{
          "whole": 67305985
      },{
          "piece.0": {
              "a": [134678021,1994496712,32592,32,0,833,0,414764080

Only the first number is in the map. Skip the pieces in
btf_dumper_datasec(), like btf_datasec_show() in the kernel does, and
in show_prog_metadata().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/bpftool/btf_dumper.c | 11 +++++++++++
 tools/bpf/bpftool/main.h       |  2 ++
 tools/bpf/bpftool/prog.c       |  4 ++--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index e4075824343f..3267163119dc 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -524,6 +524,15 @@ static int btf_dumper_var(const struct btf_dumper *d, __u32 type_id,
 	return ret;
 }
 
+/*
+ * The compiler splits a variable into pieces. Every piece is a VAR with the
+ * type of the whole variable, so there is less data than the type takes.
+ */
+bool btf_var_is_piece(const struct btf *btf, const struct btf_var_secinfo *vsi)
+{
+	return btf__resolve_size(btf, vsi->type) > vsi->size;
+}
+
 static int btf_dumper_datasec(const struct btf_dumper *d, __u32 type_id,
 			      const void *data)
 {
@@ -542,6 +551,8 @@ static int btf_dumper_datasec(const struct btf_dumper *d, __u32 type_id,
 	jsonw_name(d->jw, btf__name_by_offset(d->btf, t->name_off));
 	jsonw_start_array(d->jw);
 	for (i = 0; i < vlen; i++) {
+		if (btf_var_is_piece(d->btf, &vsi[i]))
+			continue;
 		ret = btf_dumper_do_type(d, vsi[i].type, 0, data + vsi[i].offset);
 		if (ret)
 			break;
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index fa2c877a3cbf..6851346a6030 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -121,6 +121,7 @@ struct obj_refs {
 };
 
 struct btf;
+struct btf_var_secinfo;
 struct bpf_line_info;
 
 int build_pinned_obj_table(struct hashmap *table,
@@ -239,6 +240,7 @@ int btf_dumper_type(const struct btf_dumper *d, __u32 type_id,
 		    const void *data);
 void btf_dumper_type_only(const struct btf *btf, __u32 func_type_id,
 			  char *func_only, int size);
+bool btf_var_is_piece(const struct btf *btf, const struct btf_var_secinfo *vsi);
 
 void btf_dump_linfo_plain(const struct btf *btf,
 			  const struct bpf_line_info *linfo,
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index a60414aaa494..eb077236d2ea 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -348,7 +348,7 @@ static void show_prog_metadata(int fd, __u32 num_maps)
 			t_var = btf__type_by_id(btf, vsi->type);
 			name = btf__name_by_offset(btf, t_var->name_off);
 
-			if (!has_metadata_prefix(name))
+			if (!has_metadata_prefix(name) || btf_var_is_piece(btf, vsi))
 				continue;
 
 			if (!printed_header) {
@@ -377,7 +377,7 @@ static void show_prog_metadata(int fd, __u32 num_maps)
 			t_var = btf__type_by_id(btf, vsi->type);
 			name = btf__name_by_offset(btf, t_var->name_off);
 
-			if (!has_metadata_prefix(name))
+			if (!has_metadata_prefix(name) || btf_var_is_piece(btf, vsi))
 				continue;
 
 			if (!printed_header) {
-- 
2.55.0

