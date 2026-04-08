Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CCC192D8A
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 02:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775614450; cv=none; b=jIBUVD4mZD8//m7qx4G01lkOF15A82MHG0BWwp8PfD5jQOuNB+9YLBW5uX/1eT6M4EfAJKh0lDPuhMSnhx3k2pHuQILmWCQ0F5JoMwjrgPcqShFbcrG2KymBSgNqp1/UIBTC3pN5r4EouwMyXFnuE5EAhqJKP0YPAIRUVIjpvO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775614450; c=relaxed/simple;
	bh=4un/u7V1hVOFlkJ+V7oQA/Yj2uErKQy68jTijuA4FTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRMWSB5ZBkiHD3AM2aFXMfvUo3muMLG++Lk6epiIDPk/h1iCVDsmRSiHAH/syfpY2WMhjuG6cvZItrILPjDB/T+gTTcYcqqfyCeCIWcpH7scoRpZGEwh79yN8ZDXVEdHTMrcIV4Yqz9eV4jM0ZGG+AtHwwCYz9v44YMvLUEFROA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bW6qaP36; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bW6qaP36"
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-46fb6d65c89so1244288b6e.1
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 19:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775614447; x=1776219247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaV+L98Zy+hMORa1iyaBKkHqChLPj+v770j3KIw++JI=;
        b=bW6qaP36pVcn4y/mXHgSFZR7kb/0qkUaNbaBpFu9bQZ6rHe90pUuNjjiCn5unMz3Sp
         UOQafbpJPPri9zxHCg12D7Nc0N/N3MYFUiM4olk4EE2y8JH49uE4jRc6lhgvwqj5QoQt
         5M/BefdHUXYkFLOuTNSkuBKVO4i91+FXQFiGTGxVttmk2xdLE8ZOlvtuQEFh4BJ8T3jU
         GUi2C82oUea3YEvWffPwWePeAsdHJ4Qn6GUTqkd1D6dZJu/DjiIQoziVAPhL5zwtCca8
         lIvIcHWMzNCVTSoX8MdlGRqUHvdsKd1zPPxXCM3Y1Ocj309oJCU3MP1s4aGOyPkTh7Cr
         VTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775614447; x=1776219247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZaV+L98Zy+hMORa1iyaBKkHqChLPj+v770j3KIw++JI=;
        b=r+sgtRxmh7tFcGr+VV+5G/sBICYqgxIwzTRwyuJxBMdclRiSFXZ+yRcvNaWHrx88IQ
         JXjTALJ881tI+3jDAUztw4CVHX5C0LboUHgTT0vsfxWs4qBW+v0i8lHA1sXs8WH7Lhf9
         3MN7+nEUB8BNg4k8f0kLbStvMijkWCA5p1c1YWQwsTat/N2Hkh6iOaxVjD6ZbolM6nNY
         p85+HP0yhoWW04bE5e1qav4QTh6xzf6VsbPm3P3jwmFVS+EolTaSCKajHl1HzP5OrxxH
         CeaS2qZjJQjiFkHXdrtnykR2yAk/nNYTDH9ig8/BAGLyUGvHY8f8lmjrb55/znJB+AK9
         vQvQ==
X-Gm-Message-State: AOJu0Yw8vy/4ijUz41cTuIdVf4S1DuLKu2GR5TslncJAn8S7DeN07MRc
	OJCp+obQA30ee+PJh38h8xt0uXOzfDekc1swWbCKcipGyGJzbKQQA/qDmsUOad9sm3E=
X-Gm-Gg: AeBDieu8QsUz7bc9mT9pvhxzMzET3MEAXamv8bg8QLj9p6X6OqJkvG4osd1ww1F1ssD
	yxgeigzXeeVOdWG3Vpmh+K0gesUNHGOnW404AKGJs6mqwl8ZtXk9XpwQUz8SlhQB4PGDRwwW7Q/
	lbpAlG0SNeCwkIEzZtrGh7FDOOyCYYlLBgda5VsS/hVvlJM3yb0f5k1vXyi5DXLiPgK8oYsRqCM
	7iU/krkhcpL4DE/K6TvarfMo+4BBnC8A6Vfp8MHkZHQfMaTD4Gc55UAiWt4qd3MtzjWbhsw55mM
	prztPx13/5447o+Wb7JZcGkf4X34KtaYF1YxA6Zxqdkf0zUbO/xTt3Lgh5WSwr7Hj1+eks+7Vjr
	rt52CAT02MvCygIgeO6kiVvUVc3lhjpYo4Vz1nFLLbxnMGjG9HE9Y1sF305mx6bGAYChNPVr6ex
	dHU5tjeVZYg3AjmCUp6Bpq/adpTPxKqOgHAwr6hq6An512
X-Received: by 2002:a05:6808:d47:b0:450:bbed:7a75 with SMTP id 5614622812f47-46ef7309386mr9501962b6e.28.1775614447402;
        Tue, 07 Apr 2026 19:14:07 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4757665c7c5sm1365270b6e.1.2026.04.07.19.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 19:14:07 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/6] bpf: Extract bpf_get_linfo_file_line
Date: Wed,  8 Apr 2026 04:13:53 +0200
Message-ID: <20260408021359.3786905-3-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408021359.3786905-1-memxor@gmail.com>
References: <20260408021359.3786905-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2643; h=from:subject; bh=4un/u7V1hVOFlkJ+V7oQA/Yj2uErKQy68jTijuA4FTk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfPqzmNvT9bo/3quy/V8nd1iFZk5a6Tf7Fq2736egqtCvPjD 9+qrO0pZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRJ/8Z/seYnlD/uD9HZ31mfg933t 441x7DFfkGy6Oa/7csrP9kVcbIcKTv4Rsmu3edmWnZOf4r/l+rmmz58utkl8PXeB9a2c+MZwIA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Extract bpf_get_linfo_file_line as its own function so that the logic to
obtain the file, line, and line number for a given program can be shared
in subsequent patches.

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h |  2 ++
 kernel/bpf/core.c   | 29 +++++++++++++++++++++--------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 30d35d5fe40b..d8fb9d61f5ce 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3945,6 +3945,8 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+void bpf_get_linfo_file_line(struct btf *btf, const struct bpf_line_info *linfo,
+			     const char **filep, const char **linep, int *nump);
 int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
 			   const char **linep, int *nump);
 struct bpf_prog *bpf_prog_find_from_stack(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 89b89f55415c..ada76f997177 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3315,6 +3315,26 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
 
 #ifdef CONFIG_BPF_SYSCALL
 
+void bpf_get_linfo_file_line(struct btf *btf, const struct bpf_line_info *linfo,
+			     const char **filep, const char **linep, int *nump)
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
+}
+
 int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
 			   const char **linep, int *nump)
 {
@@ -3349,14 +3369,7 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
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
+	bpf_get_linfo_file_line(btf, &linfo[idx], filep, linep, nump);
 	return 0;
 }
 
-- 
2.52.0

