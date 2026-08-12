Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A25630569B
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 06:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514760; cv=none; b=MiM2DquY4GIlYG8gHCwkS0YyWVzGvj74MI0E5FeDSWR/oa1fkRafeigUU5H1sYYLsUNHglR9zRJdIcyEDtVKkBs/B2iWco4n4j0SgWjmYeaOC9vYJIgvYNB3hmJ4zTUkbeN4mfxmuINWChwbb3aMHY8dLC1vH2hhFoUsTlahciA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514760; c=relaxed/simple;
	bh=vLjoCWE8xawxyjA3Ri+8LtlrwzclLJrjRM9+xcl7HiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8xu59eyC8ZgPHX73HxiMLm6IIRrKal4XizW72+eF2y+vNqX6dDPyn9GwAQG6B+XxtGSAl1Mqs9dt79X4Z92O0wgw9962eUIXLs+h1p6/rlODZF1YfopVqGT6FBjo9h8UpgMCg713+jyfHQEHDArA+JsOyEwRjegmikc+8UQhPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ee2ng0aG; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ee2ng0aG"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbee3777e1cso378552a12.3
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 23:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786514759; x=1787119559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/LAT2FjzJIpFHBoeoXnbjchpZKPkgrHr8uhuX1Wl3Ts=;
        b=ee2ng0aGXBK1WU0ZnL5I7qqvG60mdb5sXgW1bM7qsJ9nFSGkK7LkyBZ/FPGFzkRu35
         xtsSOTm2Utbiga7RYeMCW/71ho4gP4CW/DMFhoEg+2Z8PXa2etDejbM84KrL8sFLpB+G
         r0BNi3UFaQ0T0Cc6omWwNf7696yuIGUY0pcnigMdFTqwYHdhqBMUI762swAe7hFNhSZz
         cjel88ZP1DafC5jsHlC1cKl7XLHDzalvYB4MoNeEHY1Jh/XayRavEJzJdSNmymJ7euj/
         SrMZRCLBoA6gtccuTNCy8Uo8I+EWSIjpz0SZxYbLqCKfkYjRLPIacfCo9RpVmyIopc0u
         7D0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786514759; x=1787119559;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/LAT2FjzJIpFHBoeoXnbjchpZKPkgrHr8uhuX1Wl3Ts=;
        b=tRtcKZO7oA3m8lBnmqHAgRce6QocafZVZf7u/QRND6x/Uu/7u7NQg50DMj3zLJIdBg
         v5+XKTtEF652LBD6B/HlXkBf4rxhQhfCZgFY8ErVxIQC7WOWlQOJH1XqOga8wavstPUr
         cDMQiqvvN14o/KftD79ck0K7VYwcf5EtivX3dsNYYxu1KZiZmGpGEsc4TvR611Inl2Xf
         nNpY0VFR+k/qchDIbiT/VdgEnJGPPJsgp51At2IKsyzez8Li7BtsZJyJN3QH5XFW2Yth
         /0wGM0Z8EZaLn8PUS1R+VBh1+nVtiSzA/GTMZviwg79M1H6ve/xQrc9lCOg9z9Q9xtsp
         6h2g==
X-Gm-Message-State: AOJu0Yz2RqzlmhEUD6ITrZODXF6thd5ECVWEiZcc01sB8mwAu7YePe6G
	t1QV9YQDKgMaMN1bHYGupasTO04bRXN8vBvfA1R3M9qunhBwWoybodYIriHwCnE+
X-Gm-Gg: AR+sD10dYM3NeN2LVr43UDEWnCoUwMp12/zDhnNN/9bgNCaLLECGLYzFcIgkPHNhvF2
	9fIflrTuplkiaPyW7xdaAAfGAhgNMMMqq8Oyei9/BGJX4+gHciD7ReSf1f2ugvuzbn389uYe48Y
	NGxKyx8PcdhwWqEiruJkedLDn1wFpjWK2pwMh9cX8hjfZK2SqCAm+IW8a3/cvL/kW/Bu57wnc7K
	lc49HOjNW3LEtZBYxP4ULuXTzX6c+5bgo0RHoJ3WQxdAah4AxCga3LjCfO3XgPojYRZRWL5BAgb
	v3efGHyDq0vlSRG3v2191MvweXW9u3BITSLs3WLvNIgFYSrzL3LX+6+bfux7NnCa22RvMdWx4Ro
	j9EHJHQjYWRaZ8K1Dg5Ch45y/p5JnmvVvd3/el7wKstpfUidVDtjgHPR32MFB0TZlQpFx1pGW+3
	ncXkYxre3gByTpBXJNNDi+duzSNwHRuD4PggtSYUPXJd6RX0ljvYuyjfd8ypwGpZGbqSi7CEtXb
	ixHvQ==
X-Received: by 2002:a17:90b:38d1:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-393014cac5dmr2570968a91.14.1786514758487;
        Tue, 11 Aug 2026 23:05:58 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f88d1e8csm2314520a91.5.2026.08.11.23.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 23:05:57 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 1/3] selftests/bpf: fix for veristat file/prog filters processing
Date: Tue, 11 Aug 2026 23:05:42 -0700
Message-ID: <20260811-veristat-filter-fix-v2-1-6c234c4cd6ef@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811-veristat-filter-fix-v2-0-6c234c4cd6ef@gmail.com>
References: <20260811-veristat-filter-fix-v2-0-6c234c4cd6ef@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

At the moment veristat filtering behaves unexpectedly for the
following filter expression:

  -f !file/prog

The expression rejects all programs with name 'prog', and all programs
in a file with name 'file'. This commit fixes the expression to
exclude only a program 'prog' from a file 'file'. Additionally,
the commit makes empty filters like '-f ""' or '-f "/"' and error.
Here is the filtering behaviour compared old versus new:

| filter   | file | prog | old verdict | new verdict |
|----------+------+------+-------------+-------------|
| !foo     | foo  | bar  | skipped     | skipped     |
| !foo     | bar  | foo  | skipped     | skipped     |
| !foo     | bar  | bar  | processed   | processed   |
| !foo/bar | foo  | bar  | skipped     | skipped     |
| !foo/bar | foo  | buz  | skipped     | processed   | (!)
| !foo/bar | bar  | bar  | skipped     | processed   | (!)
| !foo/    | foo  | bar  | skipped     | skipped     |
| !foo/    | bar  | bar  | processed   | processed   |
| !/bar    | foo  | bar  | skipped     | skipped     |
| !/bar    | foo  | foo  | processed   | processed   |
| !/       | foo  | bar  | processed   | error       | (!)
| !        | foo  | bar  | processed   | error       | (!)
|----------+------+------+-------------+-------------|
| foo      | foo  | bar  | processed   | processed   |
| foo      | bar  | foo  | processed   | processed   |
| foo      | bar  | bar  | skipped     | skipped     |
| foo/bar  | foo  | bar  | processed   | processed   |
| foo/bar  | foo  | buz  | skipped     | skipped     |
| foo/bar  | bar  | bar  | skipped     | skipped     |
| foo/     | foo  | bar  | processed   | processed   |
| foo/     | bar  | bar  | skipped     | skipped     |
| /bar     | foo  | bar  | processed   | processed   |
| /bar     | foo  | foo  | skipped     | skipped     |
| /        | foo  | bar  | processed   | error       | (!)
|          | foo  | bar  | skipped     | error       | (!)

Fixes: 10b1b3f3e56a ("selftests/bpf: consolidate and improve file/prog filtering in veristat")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/veristat.c | 76 ++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index c9c257784ee3..6aaa06790daa 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -514,6 +514,40 @@ static bool is_bpf_obj_file(const char *path) {
 	return err == 0;
 }
 
+/* Exact filter match */
+static bool name_filter_matches(struct filter *f, const char *filename, const char *prog_name)
+{
+	if (f->any_glob)
+		return glob_matches(filename, f->any_glob) ||
+		       (prog_name && glob_matches(prog_name, f->any_glob));
+	if (f->file_glob && f->prog_glob)
+		return prog_name &&
+		       glob_matches(filename, f->file_glob) &&
+		       glob_matches(prog_name, f->prog_glob);
+	if (f->file_glob)
+		return glob_matches(filename, f->file_glob);
+	if (f->prog_glob)
+		return prog_name && glob_matches(prog_name, f->prog_glob);
+	return false;
+}
+
+/* Check if the filter does not outright reject the file name */
+static bool name_filter_may_match(struct filter *f, const char *filename)
+{
+	if (f->file_glob)
+		return glob_matches(filename, f->file_glob);
+	/*
+	 * If we don't know program name yet, any_glob filter
+	 * has to assume that current BPF object file might be
+	 * relevant; we'll check again later on after opening
+	 * BPF object file, at which point program name will
+	 * be known finally.
+	 */
+	if (f->any_glob || f->prog_glob)
+		return true;
+	return false;
+}
+
 static bool should_process_file_prog(const char *filename, const char *prog_name)
 {
 	struct filter *f;
@@ -521,16 +555,7 @@ static bool should_process_file_prog(const char *filename, const char *prog_name
 
 	for (i = 0; i < env.deny_filter_cnt; i++) {
 		f = &env.deny_filters[i];
-		if (f->kind != FILTER_NAME)
-			continue;
-
-		if (f->any_glob && glob_matches(filename, f->any_glob))
-			return false;
-		if (f->any_glob && prog_name && glob_matches(prog_name, f->any_glob))
-			return false;
-		if (f->file_glob && glob_matches(filename, f->file_glob))
-			return false;
-		if (f->prog_glob && prog_name && glob_matches(prog_name, f->prog_glob))
+		if (f->kind == FILTER_NAME && name_filter_matches(f, filename, prog_name))
 			return false;
 	}
 
@@ -540,24 +565,15 @@ static bool should_process_file_prog(const char *filename, const char *prog_name
 			continue;
 
 		allow_cnt++;
-		if (f->any_glob) {
-			if (glob_matches(filename, f->any_glob))
-				return true;
-			/* If we don't know program name yet, any_glob filter
-			 * has to assume that current BPF object file might be
-			 * relevant; we'll check again later on after opening
-			 * BPF object file, at which point program name will
-			 * be known finally.
-			 */
-			if (!prog_name || glob_matches(prog_name, f->any_glob))
-				return true;
-		} else {
-			if (f->file_glob && !glob_matches(filename, f->file_glob))
-				continue;
-			if (f->prog_glob && prog_name && !glob_matches(prog_name, f->prog_glob))
-				continue;
+		if (prog_name && name_filter_matches(f, filename, prog_name))
+			return true;
+		/*
+		 * If there is no prog_name and the file name is not blocked by
+		 * the filter, allow to open the file. Afterwards there would be
+		 * a second refining query with prog_name set.
+		 */
+		if (!prog_name && name_filter_may_match(f, filename))
 			return true;
-		}
 	}
 
 	/* if there are no file/prog name allow filters, allow all progs,
@@ -703,6 +719,12 @@ static int append_filter(struct filter **filters, int *cnt, const char *str)
 		}
 	}
 
+	if ((!f->any_glob && !f->file_glob && !f->prog_glob) ||
+	    (f->any_glob && strcmp(f->any_glob, "") == 0)) {
+		fprintf(stderr, "Invalid filter: '%s'\n", str);
+		return -EINVAL;
+	}
+
 	*cnt += 1;
 	return 0;
 }

-- 
2.53.0
