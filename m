Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D6935201C
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470777; cv=none; b=PHTKxY2fK38vcnjRSF+C0zLoWJA/VK/OkjiwmspdTsTs23+hNpgdZ6V870M0GOz+Vj+Oxq7WdqQ2Yqw1sh/vR5mC0Vg4XxrWoCVqx0+yV+yhFKtfJJFudlazo4q6uDAgKnVIs0Fm4+gB01VCciiS7UpfLK0yjGbEBJchFJtT/kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470777; c=relaxed/simple;
	bh=ZnEfhbq5FU+SIt1zFr0qrkNgeJ0/p6a0yMkbsnYW7dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OG/mtL5471/oBj0cYpRS1LdoKeWBYUuSeKEA2W7oiMtAuB8mx4zhkRHcXkLROoxWpupivApP/eD+mRfa5u+b2haXlVQojMC2JIo3SqG+4qCel/6dewzXGEVJ+POpwkarz28l3RsUirHm2M/0I+TzlQSrk6MQphCospXiwxc8H18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBVeNTwu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBVeNTwu"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cab973140bso3793535ad.3
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 10:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786470775; x=1787075575; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GYFNSkrmdeZs57R787s4dda4ZUWyvhVjjL9eg/8PjQI=;
        b=HBVeNTwusF+Dp5+9O5LLGxFDYR2WPz18GBd1jEXFsg3zVx5dbifQz6R0zhbjhtKSCc
         6Toe82xNfD5IxPVvgSGspoyy9oNhKc8xRdx3+FfYxJ27FNLfJhmTJtyBMfYo88yH7udW
         Wr+wftUeADc53RKNaImrRJ3j5ou/va+EHwBT/s8yQrzB/IaH0+U/nLfOZlLit5+fCdL8
         0JVlHxs9QGWFMXwhW+DHDl3fZudm9uoOJEkKbAuFTuKPnw1KapvNCY1qu+zj4zSdkPfq
         fpc5Lhh8S0y+Z8xCfG2CHXBPLYa154Vb4bE7uc7jdtQ9ms6GWmtwm+4Vf107z88issHk
         j+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786470775; x=1787075575;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GYFNSkrmdeZs57R787s4dda4ZUWyvhVjjL9eg/8PjQI=;
        b=MsChAYn0dCsngnFiTyYwLTyDCKBoEV+dbMufEMNnEuNfpw7n8LpXH11x0OAgoggYjD
         C6J78PY5YjQzW9IM8fUD2rZxwwoNW64q0I+U8qqGsPnS8dxSpzJEhJ/r4/oZoGDzADdc
         RgzoCzPxDEvZS39SJAIkAPlKsSN9f5rSu39IOSyNaOsyoMePHOsZGIrhfht/rm9DjcHL
         6cKggPYZr9sxFKuTvEZ5isdvUIgDA4jkFlbSUbjxn+aPXPBi0DlLbjY4HMcaAwZ70E3m
         LN/naEO/pOp0c5YBHoX7vPM0KkWiTaJK0xQDTAk52kVMbqmLMlSKNgQf94uDjawp1HFt
         Y9Vg==
X-Gm-Message-State: AOJu0Yxdh12zu96Tn2sNky218gFlQh9Tl9roTQePi8CfyngeCwbnJPV/
	xACIKlvqjBoG7LvRPBksD7y3HEyiIwHJOEMDFj0ycyacNfnU8TpRmPaJBj+Eu6Q/
X-Gm-Gg: AR+sD11S6XlZEkvPbYpuq3PheWB5AKmo3pAplVF/XvvqR1f8mXzO3TyHQeiyU3afAg7
	QT/pfQXL4zBznkMfiIg1RxuY/+R2OPD7pQ8b4HOSLn3RdPZ5eKCecee4b/IBk9+J1yIZ/5E/EfP
	9wPJ/YY2NEayjBaXETAB+QHs3mARUFeUc/g3dSkXN+ozJX61K7I4s7APfCmbXWd5J3gLpW4rRWw
	bywNDfj/k46vRcj51UhHZYqueBxu0Seg3Wmhvz0xvAv4KpZhMEkrUxkFScjGZKEO5JFjA3kHY4J
	FReAOPZ6wB4ml97c47wi+vujekfQ0Josn48PfRnIFNdKrgf50VE7OFnCLLfsluyXi2tRZyPolx0
	bixMKrsPhddpGYl+dqY7/B4GlqTz15z0dxeT7jihkSsYnC0QFf39x7Pz2zyOODphlIbGliInfko
	KuYnxy5y9X6pF91SSMscx5n2clOKv8tw2jDYwWV+gZLRn2RtURHBTjRlurqwB5GgEbfYN88e/5j
	1gVxWfzMZ43uiTirGgLr4O8oxeW68cxFVVTmJyfeRh2
X-Received: by 2002:a05:6a21:1b84:b0:3c3:875d:c52f with SMTP id adf61e73a8af0-3cc2b80bb73mr6687175637.10.1786470775027;
        Tue, 11 Aug 2026 10:52:55 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::4:f345])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf6d726f1sm2405112eec.26.2026.08.11.10.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 10:52:54 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 1/2] selftests/bpf: fix for veristat file/prog filters processing
Date: Tue, 11 Aug 2026 10:52:41 -0700
Message-ID: <20260811-veristat-filter-fix-v1-1-b5b43c431550@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811-veristat-filter-fix-v1-0-b5b43c431550@gmail.com>
References: <20260811-veristat-filter-fix-v1-0-b5b43c431550@gmail.com>
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
| foo/bar  | foo  | bar  | processed   | processed   |
| foo/bar  | foo  | buz  | skipped     | skipped     |
| foo/bar  | bar  | bar  | skipped     | skipped     |
| foo/     | foo  | bar  | processed   | processed   |
| foo/     | bar  | bar  | skipped     | skipped     |
| /bar     | foo  | bar  | processed   | processed   |
| /bar     | foo  | foo  | skipped     | skipped     |
| /        | foo  | bar  | processed   | error       | (!)
|          | foo  | bar  | skipped     | error       | (!)

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
2.55.0
