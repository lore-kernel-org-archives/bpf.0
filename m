Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2563F9F23
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684559; cv=none; b=D4jEe+QBjf/gIaJSLM9mdcWFO2YT29i1wbm6p9wWBnSvmILgDlpaYZvFs7AfG9plGki6iXxKkXhr99i872fUotKglRpSQ08tyrwt890iseXFBM2tFTjbfDLXf11eGLkW3Xe0ZGrKSQtsjYSl2jW7LYuAWTOauKOHZeRGu1UZxhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684559; c=relaxed/simple;
	bh=mEvyukhAhdQcXVildxDzfDWhPWDo3cluDvmrIumRn2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlTAIhbmZo24kmoMa3wYUS7Lq1ZiWQr1S7O6OeF0BjT3Ni+bs8PK1M8ZU2+j1IkwmHZLwoCuKD6ebCUUr2Cro+DsgRa5ThTa808mZOWUhOcDuJSAV9SyuApcTj6noIenEJheo1bNDe6U0Pf3bbnapzjFi0vR7NYDUzbV+mLF6ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oncUyvsl; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oncUyvsl"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8423efad617so1285834b3a.0
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 11:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780684558; x=1781289358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WskOQGo0lDwUWYHDxbKfENWvvFNug6jys3p8dhOE0vs=;
        b=oncUyvslSx96Q1sGSO7xhrtL3Y4JZC4x8CqaXNadr7ERZ5lB8tPp+Rs65No2FbPtWI
         CfUPzYnYEZvqGMmo/NqZ5XsVat3PhYEVRSP7k2GOoXYT0AnicdGTgloWlWHLRHguFPPv
         fZBXqX3KNIyCjOaYX6w/3fChPXZeaNSD5AiCElcr/NR5T/ZZrsnhBrciyLtO4ROz/7WV
         VlFSUtZZ8nn/MuP2+hV7+rwk07kZ0NcribPOHl9UU1reNx42MKZ8ojLThVJ+X5cpaeNE
         2UH198Wkll16uT9grjv1p/f6LoNNyVm+A6ng/w/2ELPo3XRe1zoBvcQ4Qu4KsiLQfAmn
         ODRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684558; x=1781289358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WskOQGo0lDwUWYHDxbKfENWvvFNug6jys3p8dhOE0vs=;
        b=gQJjgHLKTXH+mWLi0ErN2GexmHOArLu+VkqlsunatksUGOt961KSH7hItR9ud5YVPJ
         ovW81Aq1xIf7T2aGb7fV2cNtej+wtHmjWsjpX55zpXeTS1LaV20DXpZMCdePKto1RBs/
         RRRbN3v8Pl6knupxWf48Jm3cEXyVo+ASV0TIXV8hn1EthL8Os260+NXKUVRhTfAKkpAD
         cSraCcYinbAjfDEWdXj4QSNZq3Wigv8r9zntplRlZtQyvwXGD/cwY3JlyaZ9gpz5eL+9
         wsdOKPUzyQmdZV1ziKOOrAs57QfW4fIuDlpBxT+oZUaEeGj1CeA32k9VgjUAYCfbTQty
         0tMQ==
X-Gm-Message-State: AOJu0YzndUaaL+UMuTXIJ3HTVzXJ7cMTmL5YSGzHJPaGM/nlCZvQESnG
	z3kC5Gxq6VCOc3XQ17scRMVGcqR9v79sTOS522RWJE73pVAGjOVEovWpRpXYXA==
X-Gm-Gg: Acq92OEudLAXM1YuXcJg4vtvjpYG4p1zsDE1owsEAeLmd5a5RvEYA+Z5V5Bt3i0bYTB
	vnwx1cHrQa4OQDuMH95y8cpXmiDh31m4dHwm56XOWIe8DCY24ao7l7ZhaZ1ARzZHcrK//mHCBj5
	ZVjQG8XsH5/atQAqC0UfOszkGew3n3mONwD6gjBWldH6dnXhULXPokwq6ST6wR1onXOqZjUc2jp
	Lh0rF1YQXKo+MgmyaxZrh7iozF6g1B2Acp1q2KZPn/0w+QM6V2Iz3u/7i3rS1kfaOLfSH6e6ErN
	QklGz9T3HYWxfGOpsA6ebQvxkAfr34gJN9K1zi0t4kcW0IDFx3iEC5XmW063TjqTihayIDZ7HT/
	ILLYPCPBHIsNvWz0UL4KA6E8UvNcn4DQ/tHVNv42aI2B2fq1AVZBMQU9G/ZgT67szaLA1x6yRn5
	FgFFkbGC1q0foVcHFVEHrNjcSU
X-Received: by 2002:a05:6a00:4216:b0:835:41f3:f440 with SMTP id d2e1a72fcca58-842b0e5d0ecmr4949646b3a.14.1780684557646;
        Fri, 05 Jun 2026 11:35:57 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5e::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842823512b0sm10586252b3a.15.2026.06.05.11.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:35:57 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: Use bpf_dynptr_slice() to read file dynptr in leak test
Date: Fri,  5 Jun 2026 11:35:51 -0700
Message-ID: <20260605183551.969144-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605183551.969144-1-ameryhung@gmail.com>
References: <20260605183551.969144-1-ameryhung@gmail.com>
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

