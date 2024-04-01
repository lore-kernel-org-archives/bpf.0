Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A02422085;
	Mon,  1 Apr 2024 19:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711998986; cv=none; b=Pt0V7AVxDrpF0nyytd4n1V1E5RYJbcOeIWNc5WAWzx9gbHhg+7zAKkWopBkYf75n1BQQqwVSyiQtY/H2vwBp7rpYaSgxxNdLZy3/fAV1qkto93MOZLD0mGiaxSzPD53rfjx+LMMuWU+32J2sHtLqRvfLhr/n5BzJz9qKPhMz4Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711998986; c=relaxed/simple;
	bh=W1d1NqcXhfEFc53mLx05GuQo2bdZrUjOS3clRv96L/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qGuBt34SCVw/EzDlPVKVQU2DUhXxtMWO7jxCkMI46oxNnNQNyKRQS3bglbuyK4AkuqZ89E2xBeENFOYnrlMi0qtf4YN1B21k/eme/CaAktyTDdK8C6ARDpTJ7y0zvuRqxkiYYuc2DN57hzk8r6TD/N8xI2N0G145JTiipJLOfaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZvisAns; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZvisAns"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-22a5df0f789so1748220fac.3;
        Mon, 01 Apr 2024 12:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711998984; x=1712603784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eW71oU99QynNwXgrQuDtBaxu54emi4+sBht5DBCWvRk=;
        b=SZvisAnscJtkYScqntVLwQaPZzsTqJvmDUGFxkx65lwSsoGyw82I/AXJP8fy20aHkf
         /f6g/8Z73gtx+9SBLk0CE4LF6dvttvtMV/ySMuRvlg5y13J7OPnLSX4mIRM8Mi08I/EC
         YsY6jwHbm2H9FzY5QLY3V5VHcH1su42uMgK7GRPrcBEjWmNWwAf4nTotSt02sLuNqZCr
         XJjGwZllD3LLBSTq99R70fbqqSbAtvAPamDKKuY/Rwyp1m2v9Cw69Efh/0taBby8hZG6
         GIBXa5L5xZcPuYvEqEUr7kLok+qCP7B4VgEnueW0D+yyL1I3sZxoXO8jZ+Q+rgGq7Afq
         712Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711998984; x=1712603784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eW71oU99QynNwXgrQuDtBaxu54emi4+sBht5DBCWvRk=;
        b=QjqPYBP4NZc1LKLnKG4G4OzsT5WENgYILrda+lNm63YlIYYyh5qlSbB9yLaswCfmp2
         VVPFLDeH4nhdQrsxWr9DkpAUQVtR6Gt0nmwt2NREFe8S3AgkjoGb16/hfyUtfJaZMVj2
         VS4PegnGuGPDkIJGJH74raBk68yEi2xZUSQmzoxkf6L+H8xzPmQ7dy9EUkQ1gYgAwoA1
         5JKL/P+gznCpQSYddqeSAj7PDwIhS3jQ9D7Xcnc8HK3CbONAdbySsrzygbuFHmRrY4eu
         IvGHYM51hCntyoz4uewGcq87eXbC6oOPnAqUcaT3fwlMgPfAEMbVr+HgdWPtPr4aXylX
         IR1g==
X-Forwarded-Encrypted: i=1; AJvYcCWvDgyQAneJp/Hg/q2wYF/yaY2QNzOEzEA92KyAvB2JrOI2GqZG/U+dHlJFZTQpPxxuY7vjlHtMKhwhSfODytAvHOfurkUUSbxLm5s8zn7GoDCwGiJwlNJZhJrlmTOLe/MTp3Ze+tOp
X-Gm-Message-State: AOJu0YycIbBhtlWRyO2xvkiIWjtwL3OnwTsijtX3BQWPJD2N6YilNpeM
	ZeGbGPQLEK5ZNwd56TsyV+BY22+LNEcuBV8cwYvePNTcenTeKzSG
X-Google-Smtp-Source: AGHT+IEd2SfRRSSE15M3WKWiXb5JQfut8Xkg9rAS80NNkP2vGvttxCp43F/qD5o1uAaJqLM0d2b6Fg==
X-Received: by 2002:a05:6870:700a:b0:229:7fa8:f4c4 with SMTP id u10-20020a056870700a00b002297fa8f4c4mr12364246oae.36.1711998984264;
        Mon, 01 Apr 2024 12:16:24 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:769d:e8e1:4c99:3e97])
        by smtp.gmail.com with ESMTPSA id lw19-20020a0568708e1300b0022aac1d2430sm2843414oab.31.2024.04.01.12.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 12:16:23 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: mhiramat@kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	andrii@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next] rethook: Remove warning messages printed for finding return address of a frame.
Date: Mon,  1 Apr 2024 12:16:21 -0700
Message-Id: <20240401191621.758056-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rethook_find_ret_addr() prints a warning message and returns 0 when the
target task is running and not the "current" task to prevent returning an
incorrect return address. However, this check is incomplete as the target
task can still transition to the running state when finding the return
address, although it is safe with RCU.

The issue we encounter is that the kernel frequently prints warning
messages when BPF profiling programs call to bpf_get_task_stack() on
running tasks.

The callers should be aware and willing to take the risk of receiving an
incorrect return address from a task that is currently running other than
the "current" one. A warning is not needed here as the callers are intent
on it.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/trace/rethook.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index fa03094e9e69..4297a132a7ae 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -248,7 +248,7 @@ unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame
 	if (WARN_ON_ONCE(!cur))
 		return 0;
 
-	if (WARN_ON_ONCE(tsk != current && task_is_running(tsk)))
+	if (tsk != current && task_is_running(tsk))
 		return 0;
 
 	do {
-- 
2.34.1

