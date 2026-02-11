Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B548232937A
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770828000; cv=none; b=L9Z9Io2HnfHYDaZejB/eEvvsDDRz0YLgOJjxkLAjKqqKIJw3EyoLnaASy/PXxTjp8f1GFYLsFOFZ0E4HYpiKMll//disTuXRN5Owrg4yyFGgznTDv3BwubBF8xyNhfBmgy/+xfShv2xsXj7TdLCSHBBrwktk/tIxArXdUljUhyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770828000; c=relaxed/simple;
	bh=rLQz19qB15QKZaOJctxp0Gp+4KNpMyOqenbKFIWyVRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rT9TOcHAYT3vheBKql9bgE7q0Acvel4f9eigKBm7L0PgINUzQZCfaD1EYea1JKX+TBoCDVxmQ1As6l3sA2xRUkJVgm//65PqhVxY9vQFuLUz6C6dIJyPwM3GvrwhCmiDOSkjSNTAN+nd0V24ILBsQIYMtBr39i5rR9vxmjkcLLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyjZY5kq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyjZY5kq"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4806bf39419so7928615e9.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 08:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770827997; x=1771432797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Fmjk12njJftPqcWm6tlY2cb7lPd5Y/9OW8g0OynMzM=;
        b=QyjZY5kqJUsZfVDIn+ykYz6AAa4QHHztNtFNzchoHriPFnhRZdBdx1Gool6UH85Kev
         Vfmec3OBw6Pv+Ydxs6JXPGsbHhyQGHLoeFb/9O+CE0ykfq4+eprAE00OL1er5LFnKvwi
         PRJ0gNJ8JC6mK/8d8HWVdX7XHNTswtXgnmMYTN50a+unEA/7is8hZThE+OFGw3aKbBqx
         tG/gTReqbF3SBmtTWM1j+TEKXZWm6sIozuEH4+oejHTX5abbXOpOz0rK/I4qBSY9PeCU
         sFxiQtbJjFUvw571YdErabS029GgVgppQOicQMbcTCf3eeVBEFbD9kiD8fJajPxI1kG8
         SmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770827997; x=1771432797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Fmjk12njJftPqcWm6tlY2cb7lPd5Y/9OW8g0OynMzM=;
        b=tlm8hMd3zpU8Sq47A+pJpNApJWtO1dubcqNRT/vTeCuRKSuanJjjW1dv0w4Nur7Tus
         wuNEN3WelzpHZk+2G1onAmFcQGav4K6PkGcCzLSTfqB/iSWhR/KNZ7s+La9niEUcZm1T
         M/gucDajaXYBtQ1ZUQPJXT9qOHNMui+p29TIbNGSRaOHjhuTKYPMN1kchgytuhJh5Xc2
         7F/Rpsj0solZA+q99DRbRt1hPlKEFt+nFly5w0AY3nYZmE7Gv0+KWrJ9qncfpdMOOEFN
         o2F99vZOVYM0aS4wIJ+NqjOvkeBsAgYSht8/x27dKVOV+RezCJiLt83R8VK7lNfy2LNP
         cc9w==
X-Gm-Message-State: AOJu0YweCCUvUswdXgVSN7Jibtr5j1HREnm/Uo9HdwNnmOSzz3EaQ5vR
	RHvYaZi381xSrB5rYlnBLmWw6fcTdTPQQsUmwodYKPi6uIeGsFFEZ4EzbTcHNg==
X-Gm-Gg: AZuq6aJjkvOpc/lkKf59dzjVamgrSkgkbpjJ/xohs6PJKkByNZ5nJsuTB5tjkbcF1lZ
	sSWH0HKoBrJcPCTPZ798Pfcvey92IGDfI90crCIqlEWAH0Rb3QfCKlk8SmSWUyGH9BvleSNFrmw
	M8RdtjmIAnm28iiiAwRr1n+Kq4ss9V7d+VSjzzNnevbRRX+xuIKCq5hw8Pr2P2TpDOjugVIXtSH
	63kXKIlG/LdwWvZz86TUsZLaHG8b8AfTuN0uuSwRyT2sPJMKW8DuenDUjLq8UpFDggqifdeT4d9
	QiRVO3TrQm9WE9L9z4TMx50oqk1cNudNp7vGva9PsLdkoitXsdwCEKhDCQm9S8eBPMpdON2trvf
	+NrU57XtYVGA2eSJNjXeaNzdoWn7x2LEG0ATghTk3vVRK+2Dmv/NIyQCd+/kmWsEPyoS/aDpjLv
	+RbL77eLQ=
X-Received: by 2002:a05:600c:34cc:b0:47d:333d:99c with SMTP id 5b1f17b1804b1-48365061ae3mr24915e9.18.1770827997006;
        Wed, 11 Feb 2026 08:39:57 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::5:b8a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e5be13sm5791207f8f.35.2026.02.11.08.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 08:39:56 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v1 2/2] bpf: Use kmalloc_nolock for bpf_task_work_ctx allocation
Date: Wed, 11 Feb 2026 16:39:27 +0000
Message-ID: <20260211163927.665785-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260211163927.665785-1-mykyta.yatsenko5@gmail.com>
References: <20260211163927.665785-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Replace bpf_mem_alloc/bpf_mem_free with kmalloc_nolock/kfree_nolock for
allocating and freeing bpf_task_work_ctx. Now that kmalloc can be used
from NMI context, it is the right generic mechanism for memory allocation
in BPF kfuncs, even in restricted contexts like tracing programs.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 414e5b55cd37..d25aa51c80d3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4165,10 +4165,7 @@ static void bpf_task_work_ctx_free_rcu(struct rcu_head *rcu)
 	struct bpf_task_work_ctx *ctx = container_of(rcu, struct bpf_task_work_ctx, rcu);
 
 	bpf_task_work_ctx_reset(ctx);
-	/* bpf_mem_free expects migration to be disabled */
-	migrate_disable();
-	bpf_mem_free(&bpf_global_ma, ctx);
-	migrate_enable();
+	kfree_nolock(ctx);
 }
 
 static void bpf_task_work_ctx_free_rcu_tasks_trace(struct rcu_head *rcu)
@@ -4295,7 +4292,7 @@ static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *t
 	if (ctx)
 		return ctx;
 
-	ctx = bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_task_work_ctx));
+	ctx = kmalloc_nolock(sizeof(struct bpf_task_work_ctx), 0, map->numa_node);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
@@ -4309,7 +4306,7 @@ static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *t
 		 * tw->ctx is set by concurrent BPF program, release allocated
 		 * memory and try to reuse already set context.
 		 */
-		bpf_mem_free(&bpf_global_ma, ctx);
+		kfree_nolock(ctx);
 		return old_ctx;
 	}
 
-- 
2.47.3

