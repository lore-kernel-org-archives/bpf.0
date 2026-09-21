Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694AC3B8D70
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 07:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977582; cv=none; b=BtcyGoxrOgOy8nbp8FO9p7BY5AAim6FzE937sDiGEXq5Hv+KKkhi5XC/1zXoOb7VLEVledZmQQpuyjglRPHOJWau2IPLsmDyQSC0+q1t81FCxifpRB/pZ6QGmk1ypndjBN0MDaGtP4MHUUVtZp8I60YdhxNVpdSyVSVbkeKeYVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977582; c=relaxed/simple;
	bh=sd8HcPEtf1wDsCptN9io4Ts1J86he+0UpKjclgSifR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s3jdLL8mMrgSgQje2DcwlCz798D02kafVucwutopUB/9VEx4rNkhprf6HDuOmMuNgzWVMqYxbun0r4DSt0V0sENwhXADmQyoJNiUPVaetS1CPqsbqAldAd0VCMYJJ6QSGyOb3d/qiTV5IkjasJY+Npic/EulG0PQRY50L0P31Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wwf3dZd5; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wwf3dZd5"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398a1676000so2095067a91.2
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 00:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789977581; x=1790582381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gJS09xFOcgYKm17/KrVDFt/Una4jfXuK+GKS9KRcb0I=;
        b=Wwf3dZd5GxxxR9GTWouusrlSbOi/qqo75vvuPewiirg+VBjVfBHfcfdQ9jX4g0VcoE
         Y6+lh3a/Ky6h310/h4QLV7ESSJruu3rMKtHUUsblh4lUzLPQeDga1hgFRnRs/VWWdxo4
         74OsJUZGexzlorbE96/aeCpb3pYLVsW3SUL5twkuRagZIJxST4nyQ/UgUpttQjcZcY07
         msLHRBjzj5xRLq8SQokew31G3EnbvRnOI+Xs3hNmDbrGZ2xcs9+9Stb7nhJwgKDYzHP1
         tou5TToDcq6yBVXeOLkJb5ORPRYcMYnf+U2XXrfomOm5ya4ZwEDmg7yPTFSXffFnxbnq
         J/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789977581; x=1790582381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gJS09xFOcgYKm17/KrVDFt/Una4jfXuK+GKS9KRcb0I=;
        b=1XnA1ih163BfN+hdcIuqGhInJZepOvoCsrTq3bDzeuUNIZkcF/IVH6FQX8gyk5o2Gf
         yPaocANrfGA6/Mh41yOotRR2BlY5q5eZx9pROtQLEDwXKGUuRL4785d/KEicuS+MkDbG
         oZmCvq6Ax+1FdrNVsunrNGWLHJxcuDmve8iX6urT1HYNFFgzrwNjDa04diNhobopuKWI
         fCaIDg8lXMxKjXFvRBTD4HRqNDzBSPHqcq2Eq9AOYZyfYqPD+Ku7hk/3hnCsO8U0Xa/R
         9aoM9ECio9zMB6HL84jGPbxvhX05ycQvX3s3dr1mSxMBBx5IycBFl9Pt5mJ4Ef94+Tv0
         TBkA==
X-Gm-Message-State: AFuF++mWJ3JhMIwDYhmRlJiNBG+JIaXLCrx0o0rW5UtwFWP5DR+QAnLA
	jCJJKfRg1yXAOHmZA2SUDXl47suzDdmZxgL9KYrJyd8mR3fLRG8S6XLD6lDTmlhzQos=
X-Gm-Gg: AYBFou2t7lg87+BU6Unqwsyr4AE+KE6me8gNCzYwNJRsQTZVUMFmDAKicPNq7Ju4+iq
	sj8zLp1uRpROEFRBOlzTYwNQPSUwxk7VxKGVfsGku44nuMzwNtBRC7HuTaZa9OiGjsl+GX85Uxn
	OTsntXXRAPoFtD7ZOvJLa6Oq3+DRfy23O0TRGUSaWcKM0aWCdH8iMRvdkJhj5wvAjMNXvjLeBhC
	qSBGm7XoVJ1Biym1ytvhaII0KG+BZjCK1pbilXYz2d67ViFEt8nXZ3QzfPzdjM08qbXOIJ/0/Xz
	M0FGU3xvE5nWBcsea3UW2tjdAZDuukkN8xg8E/oA6zq1kLmxBGo5tXK9hl0B6dmPhWeh548rw3u
	8nbkIVGqb6aBSsqyYexoII/bTxLMjxPu744/xQdHH+ELjp7Jw3kO1Jn8VdhaYRQgyPac74JHX3t
	O0qGcTKY2I16aTLNXTTwnr6db72tg98CQwY9e5O5kM/jI0FshIoMRCadgIxNODqiX4X9wb9hr5i
	d0TTJ9v/91e9O/IVNNFfsSFDcR7dYcmlxSL1SVnlE0N2TCuk0kavD9xOedl5MbAMg==
X-Received: by 2002:a17:90b:2f8d:b0:39e:6c69:f47e with SMTP id 98e67ed59e1d1-39e6c69f5c2mr9933670a91.61.1789977580596;
        Mon, 21 Sep 2026 00:59:40 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6f1835adsm12843830a91.6.2026.09.21.00.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:59:40 -0700 (PDT)
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	memxor@gmail.com,
	nickolay.lysenko@gmail.com
Subject: [PATCH bpf-next v8 1/9] selftests/bpf: keep headers off the generic link command line
Date: Mon, 21 Sep 2026 00:58:47 -0700
Message-ID: <20260921075855.2065871-2-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921075855.2065871-1-nickolay.lysenko@gmail.com>
References: <20260921075855.2065871-1-nickolay.lysenko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic '$(OUTPUT)/%:%.c' rule links with '$(LINK.c) $^', so every
prerequisite reaches the compiler driver. A header argument makes clang
fail with "cannot specify -o when generating multiple output files".

Filter headers out of the link command while retaining them as
prerequisites.

Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 7ea5ba1df29e..bfb788ea6561 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -257,9 +257,11 @@ $(OUTPUT)/%.o: %.c
 	$(call msg,CC,,$@)
 	$(Q)$(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
 
+# Keep header prerequisites off the link command: clang treats
+# bare headers as precompiled-header jobs and refuses -o.
 $(OUTPUT)/%:%.c
 	$(call msg,BINARY,,$@)
-	$(Q)$(LINK.c) $^ $(LDLIBS) -o $@
+	$(Q)$(LINK.c) $(filter-out %.h,$^) $(LDLIBS) -o $@
 
 # LLVM's ld.lld doesn't support all the architectures, so use it only on x86
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
-- 
2.43.0

