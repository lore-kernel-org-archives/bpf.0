Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FA2426ED8
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780690867; cv=none; b=P2v+AY+d5C85badDGzmiqiTNNgHFw9T2ks66R/mlo/MczSXJCE+9/nqIvFGvU7Cg3gzc44UU4sFMKKWWpHcqT4AY7ROYRdU0WBVCszNsjTJm2xz6Xp72ZDkpiM+D1RomurLWQhnQ1gflcI3GqcCrRspZw615VK/rrKb5d7T8F+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780690867; c=relaxed/simple;
	bh=0K6YGPmo5oE+oT8qEcDlB0fOA+kgYJZzHLTEFFd7qyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrqmESgR1v4f+RVpuJ4pny00AC/+65e6Q6Qu3019JvDfcnSwEXcvhL2Ywc7cV6jlsTFl+BFNUsD47QJ9Gu2R3UF3A0bGulC6IphEaLlTzOuYhEG1ErBIRkpulegByZb6kRtnM+qP+EBVf+2OlX2GP38Hdgo6OkNO82WdSRTUb3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6zOXCPu; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6zOXCPu"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8422f148dfcso1286744b3a.3
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 13:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780690862; x=1781295662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvtsSjqoa8csGDPIPn9CW3BdCwPSSCraeMH+eLutkdw=;
        b=l6zOXCPu5E+u2VpaO6S4CEVQTWd36Jf+EkVQYB24YaXI/2HHUtHARBdYtfc8qb0nt3
         yv42/H/aut4gW3dcn6xwWvAcnqYru5Lrdsy3QcEdaSZ4cQ3gVUz3kVPuKpjCbPAlB4Da
         hszgS7h+vx3HT1vKgil6r/I+FXV47uVZ7gtx75CGte8BsVIikB3vBXlRkq/96pL2SVEo
         lxQfz43LeO8fC8tJTPylAil5h+jviL9sDqwB3RFcTlS8NRKEErBmhwJZbZ5SrKSwktI5
         bZdDuXzThMGcuDNW3zikSejYzNahtL/3+upHtcp/50Xt6WLBC02mJHCdmpqCAHBhF/I9
         5Tpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780690862; x=1781295662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PvtsSjqoa8csGDPIPn9CW3BdCwPSSCraeMH+eLutkdw=;
        b=oEZgXOEy+F9rJzfETUec/n+VJ+bNtksWt9Ar3jG0NqWndoENuFsSsVuTs26D2R5piP
         TrVx3lBtIycSIdbO/FkHsMOLlG/1ETV29vQnzXp3sYIBUZOWkvCxM8bJkEUAiCKPFRu2
         DCbMgpJcDtbnivtjb471ANM1Em0B4aSiqOw6Y2jSmS2lJKNsKKFJiHo4Zr+nD2y8fw1H
         /gfqoj+HlE2bO4FVm9Bp5ep1t2CiI8RzSyeQ2rIX59Q3qBLGBZjeS18iTX5PHbAwaaoK
         Q7jK59znLzDyDkgkBbqz+SKhUYYBGtbkUUgDvm+k3rMfw+pvLU9yczUT0Cv/QNbWSoft
         rX9A==
X-Gm-Message-State: AOJu0Yy6AZE9TpgD+CZ6ZAIR8hqoArfVBOgvbcOnCtk2W0IzRlo2xg/E
	xp/YAAfEsXeed2N7473WqCSySH5HQ7T29zfDYWR7AOBSVUaGZShAP2dig8pM8w==
X-Gm-Gg: Acq92OHGxbNy2RCAcuY121M7Ci02PO+q1Tgv7ioeb3J+RzV/CnaZlFtf1vta9Tzv3Mv
	aQ3z5HwDJxYcj9P0V1Yp28GmBmmbQ8LNc7HydHQJOGAKyEcvEjo6nG8Eem2eOERT2QgNFxEfLF8
	x6OFEr78CMmObGqddJsZ+300+Bn/WABJFLlkCA/sCerQ8WBhgcF6X/wDsNY7zbD6NiAqmVFVxBl
	eLvV4QxgwFjafenMBNZG4jP46043Qn4BEx9gABdYgPtirs3uUQ6zRzR6eeg678AT66MRzWHlTBx
	6OCFsu/DtS3z/CHEc3mktvxFehe/nG6QO2PRJAY2+PpG8AMo3JtRlqUpjnf7KWwRGCf6geQwxKa
	N63EltRyGN8GAKzKyB+7peG5BX1reQQ1vpdxEJurUxCSbkqsK5tO/02Ig5UqTNuaivk/JPL/8j+
	bqXV0N0N3OFnmn15cgVOZQ5xGmo63gI1wsH2c=
X-Received: by 2002:a05:6a00:418d:b0:842:6fac:ba7 with SMTP id d2e1a72fcca58-842b0e1dd8cmr5397249b3a.5.1780690861988;
        Fri, 05 Jun 2026 13:21:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5d::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842822222ccsm12000282b3a.3.2026.06.05.13.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:21:01 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 5/5] selftests/bpf: Use bpf_dynptr_slice() to read file dynptr in leak test
Date: Fri,  5 Jun 2026 13:20:56 -0700
Message-ID: <20260605202056.1780352-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605202056.1780352-1-ameryhung@gmail.com>
References: <20260605202056.1780352-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

use_file_dynptr_slice_after_put_file() reads the dynptr via
bpf_dynptr_data(), which always returns NULL for a read-only file
dynptr, making the example confusing. Switch to bpf_dynptr_slice(), the
correct read API for file dynptrs, and read (rather than write) the slice
since it is read-only. The test still fails as expected.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/progs/file_reader_fail.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
index d5fae5e4cf9a..3bb9e2612f8f 100644
--- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
+++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
@@ -87,7 +87,8 @@ int use_file_dynptr_slice_after_put_file(void *ctx)
 	struct task_struct *task = bpf_get_current_task_btf();
 	struct file *file = bpf_get_task_exe_file(task);
 	struct bpf_dynptr dynptr;
-	char *data;
+	char buf[1];
+	const char *data;
 
 	if (!file)
 		return 0;
@@ -95,15 +96,14 @@ int use_file_dynptr_slice_after_put_file(void *ctx)
 	if (bpf_dynptr_from_file(file, 0, &dynptr))
 		goto out;
 
-	data = bpf_dynptr_data(&dynptr, 0, 1);
+	data = bpf_dynptr_slice(&dynptr, 0, buf, sizeof(buf));
 	if (!data)
 		goto out;
 
 	/* this should fail - file dynptr should be discarded first to prevent resource leak */
 	bpf_put_file(file);
 
-	*data = 'x';
-	return 0;
+	return data[0];
 
 out:
 	bpf_dynptr_file_discard(&dynptr);
-- 
2.53.0-Meta

