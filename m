Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED2321CA0D
	for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774819541; cv=none; b=oK7KJL1mo+FItQuGb7pqP1gWaIefao6P0pF39X5fwMjfxxs9QzScoR0qriMGQYNfmUhdzWlKx0fRAlO1VJg4IouZAjhlUlnsIaJhDf2qRJFcBnJsPp4AXbH3msX7pzaY0JvavcXpseytBJsKesKkjJBST5aSzGY4xoP/ckD8rdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774819541; c=relaxed/simple;
	bh=LQxkBYx6ebUIhWdWkc5U0RU1TpvgmYLfpkXku55n9WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8W0tbUwdyr+Ih8YZV/80PJsE06J7ghK84GZkJTa5vTa0L/VxgE8RCHQA5Fj929/Bv8OosJSKClt1B2zs2ZhHHozllBY/ZdGsy6bfr7NmmiqE0Zsd9RL1OXRDk9oOYWy7KEE678KWIEiYQE8Q9D7lZPClkVXtZ0bNT6aS1bIYng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PotCsztH; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PotCsztH"
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-4043b909ed4so2358842fac.3
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 14:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774819538; x=1775424338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUfSA2IQvTAaru/F4z57yDZzWlDoKJmaGeloF4DYKj8=;
        b=PotCsztH8IuDMoT/xesRmcvsCGMcYpcSCzENeQRWdBp5Yxi2Xucp19yIFzXG6Ns0B/
         e8GxqHu0/+5pJXx4nzPtzOZILEckf6ZSYxC5wj7ErA42JCPnZpx0nR6c6WFOoFJbra1l
         aPxJEPUNNjMC03dvdDf/68B3hq55fJbSBNe/7ToQNXQ2nZz0+Mvav5ekOrz5ZljWf80C
         /Q2maZ34Vqg6+KhjccXPaAFbEf25/VJEMenpyI9GjYmjqiGVr3MoKi6V03+4RuF16p99
         nI0AS/wAGvn/oH4ONElV16Uw5/Xxwi5IDVlvKHZ9jl+SuGgEiY82qsHN25Bd6qGa3DDD
         zc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774819538; x=1775424338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eUfSA2IQvTAaru/F4z57yDZzWlDoKJmaGeloF4DYKj8=;
        b=iG6ZJx0dlJOBHiuD1Zs3pa6Hcrq9h8BQsuDL/da4Lg6KvqhvFYlvTk511slPdRBNg9
         FnqPpm6Gbllb7hTGNzhQcXxBEC04bLfoRYMCifeG4IdSq0umzXy1FgVYyDRXflKePq9l
         JUx0UkBxjkTsHYRRWl1nwMWN1PAzRqeMjgWH8tCAmFBvUrJgldIQHCnd/vlYm2imKo9d
         6yEYTDBvotsFPVbegu1+Fol3Z0tQdAXQxpOX/8AdGWS7ZxpwG8cPLQQVxJFv0fIMH3X+
         q/CGmSzzwht9LpzE12aGJAuv5NpfWPeayLIsSiVA3p6J+ffrv0FJ7s3+pdzR43UJuRiR
         S6dQ==
X-Gm-Message-State: AOJu0Ywk/mk5LQJ/s5OY76auTQcNYZ1aVz3JYnDPgK+dkg++875aMvw5
	Pya7DPkCmCyXFr4y98Nmwui+9aDPS57YKLdnWd7iCjaocVzmZWa1QXnF2mzuAnL4
X-Gm-Gg: ATEYQzxtnMe9gpj9IuuzVeW0r16rlHL9zDH/vF047EnlDrq25ogbbF/MY4UicUuFkvl
	pPYshjukhTmvVHfxwIsPCOf9jDsmbIXGKYdZIeXnrZf6Q8uPPUHSew2KYyVkx1Kfl4AQR7qda9V
	H51ETMw/vcuizHNXB0vdjL3vTru3ejPKrz9yyIjAbaDOwp6qB5S3N13cFKIPl47hxoH6u2LQWiM
	YHW1aIiCBbd1e6q9efZy/LW0ZAoScElEyDXhEcYZYVkGtXjB6DBR8OHdfBRXoZRHgbPz9Xw0k8p
	iJmKJwKEKK+lnPrf8UUi4DKjKI2OVI2Ysh0ivvqjAqVYNSWSnjMkuqQqN4cXrtx+23m/0pF1bte
	cVuoTe4CH+OBwMT8TET7guCifz26Pt3uR8dpFJzqo1BQyOKHRN8/Q6RPM3a84jnntXjZT2yG8Xc
	j6/TF6I2CmNB2VyO4Nz7V3wqVpTe7AF/A2dkoFqO35wWA=
X-Received: by 2002:a05:6871:4706:b0:3ec:5267:cb6e with SMTP id 586e51a60fabf-41cec2f9ccamr5154087fac.23.1774819538203;
        Sun, 29 Mar 2026 14:25:38 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:3::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d04501478sm3931158fac.0.2026.03.29.14.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 14:25:37 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/3] bpf: Extract bpf_get_linfo_file_line
Date: Sun, 29 Mar 2026 23:25:31 +0200
Message-ID: <20260329212534.3270005-2-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260329212534.3270005-1-memxor@gmail.com>
References: <20260329212534.3270005-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2593; h=from:subject; bh=LQxkBYx6ebUIhWdWkc5U0RU1TpvgmYLfpkXku55n9WU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfPkdFXfw3YrP1lqirK+jfn8eFdw3QwRfhH2wOOfhHk6Xuin OdR1lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCL/JRj+Fy5wi9qUe1lOMjPFU3XXHk Wxb8eT84XSBTvXBnbfcI2xYWQ4UGbDzyGxQ5STs9Fbi1FqdsLTxAXHW+7kt7h9nnPeaQYPAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Extract bpf_get_linfo_file_line as its own function so that the logic to
obtain the file, line, and line number for a given program can be shared
in subsequent patches.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h |  2 ++
 kernel/bpf/core.c   | 32 +++++++++++++++++++++++---------
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 05b34a6355b0..2c4f92085d79 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3946,6 +3946,8 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+int bpf_get_linfo_file_line(struct btf *btf, const struct bpf_line_info *linfo,
+			    const char **filep, const char **linep, int *nump);
 int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
 			   const char **linep, int *nump);
 struct bpf_prog *bpf_prog_find_from_stack(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 1af5fb3f21d9..052dd78a2d81 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3313,6 +3313,28 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
 
 #ifdef CONFIG_BPF_SYSCALL
 
+int bpf_get_linfo_file_line(struct btf *btf, const struct bpf_line_info *linfo,
+			    const char **filep, const char **linep, int *nump)
+{
+	/* Get base component of the file path. */
+	if (filep) {
+		*filep = btf_name_by_offset(btf, linfo->file_name_off);
+		*filep = kbasename(*filep);
+	}
+
+	/* Obtain the source line, and strip whitespace in prefix. */
+	if (linep) {
+		*linep = btf_name_by_offset(btf, linfo->line_off);
+		while (isspace(**linep))
+			*linep += 1;
+	}
+
+	if (nump)
+		*nump = BPF_LINE_INFO_LINE_NUM(linfo->line_col);
+
+	return 0;
+}
+
 int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
 			   const char **linep, int *nump)
 {
@@ -3347,15 +3369,7 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
 	if (idx == -1)
 		return -ENOENT;
 
-	/* Get base component of the file path. */
-	*filep = btf_name_by_offset(btf, linfo[idx].file_name_off);
-	*filep = kbasename(*filep);
-	/* Obtain the source line, and strip whitespace in prefix. */
-	*linep = btf_name_by_offset(btf, linfo[idx].line_off);
-	while (isspace(**linep))
-		*linep += 1;
-	*nump = BPF_LINE_INFO_LINE_NUM(linfo[idx].line_col);
-	return 0;
+	return bpf_get_linfo_file_line(btf, &linfo[idx], filep, linep, nump);
 }
 
 struct walk_stack_ctx {
-- 
2.52.0

