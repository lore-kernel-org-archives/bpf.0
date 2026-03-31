Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B3636AB50
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978012; cv=none; b=SHcxwEht9bjmwl+Rka6syIDwo4CQr8e+OFKpwYM9LyEA0RFehk6svn9iu0U/cKNAd6JPHd2GFiN2wkRo68F2N6zJubnFqQuXHMc70JibYXzymYFnDAoubsqgY1PFdyf2A2vacQUhYmG9NM+W0RtQGNY3bhwFn9Deri4P5IcZGiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978012; c=relaxed/simple;
	bh=fgBcF8dCgVfN1w+raua1B886e86aC5RvtO/RAFfL+80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWnSs0U7sze+QarWWfPYNtFCGwE6OKYpIXbwZ+FmoIHufmjLHRUoZObbriQxf91hKpjdSqaR8JWR8DjCl5yJhVhMSNTo8+oiq5+ujJeWrp5pZEA93JgHBoMwc7+mqXfjCOgZMMbwABuIhAhyGl9hhjtK8tbBtK2TTV7fPTzRMgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1+ZCCLo; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1+ZCCLo"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48700b1ba53so54900535e9.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 10:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774978009; x=1775582809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkssFBvNjOO5cMIJ6nfJuXhEtuPGvJYGnT6NAHeE4oI=;
        b=F1+ZCCLo78QujNzHu+Sso7vPreJA1kIbhu7gsht6L1ALlFZSITHlZ/PKk7pZs2uOF6
         EvUOhyqE+t8LidMO35Wz2yRssdtPEWhFiUM1B0zhmg0e7XComi9mAayH+KJ162A8KF48
         FXIAocIOqbnQcL1BlogJFZbTx3BqZnSl2vqKC2nYF8RyJJm5gtifjw5g7QOr8qFzPJh8
         AWHfokBDTDcc2VuBI06SlO3qAg+xC7uAskUPV4mq+kxDslKxDfz662lj4toP0S+XxJYN
         2b1BveD6I6hPl05dKHWCk2I5e8qXXTki7W9wtWem0I9An4AgtXpFZYjBKYkJqtddaB8+
         m4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774978009; x=1775582809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VkssFBvNjOO5cMIJ6nfJuXhEtuPGvJYGnT6NAHeE4oI=;
        b=B0hfzXoaEKq7J3FdF5q3LoaL2Bon1E4w90iVS75a3TZCSKCPcP86HGOwvuaxSz6sTa
         H0pbPyoLrov4lw2D9GCH7ciiXkUuPqXJ9owrpzR44f92RksS6Jk2HxzVhsai9ube2BPk
         +UTANSUf3LPLjnZRJhdvChhY/5olyKJcg0/zVoDsjGSDxlXz7PsVt6bEi8wEN3K4gQPN
         Mh0bV0Gbi0n+8ygjwwN+4oKlFQME9RmteChh7JsOHOkEifftN7fy/KmrIMNfUyg3HIwa
         BJm6vOt6ZnZURXn7cdv3arfcbBIzu3BxW3iyiFR0RVtMX3jeFLuxE6thII5GgKlC/WWV
         6wVg==
X-Gm-Message-State: AOJu0YzAlfId7YuVnQSvxtNeU0O6OvKcaOpThd3iOX0WFk+GkdEnkS7s
	hxMmDGZMeXF7TFkgYXmaJIG2j1lEOvlRI+g2vHiSSumJV4NuV3E3X9fPobKECIUR
X-Gm-Gg: ATEYQzy7W6YQSYICNxa5FtBPEJVQIvw7t5O4s4Qlb5BYQ/BLojq7fj6rwst1/jv/njs
	GW6eDcyST+ge9Vww0Tf3QoJZYTF/DyahVaNB5OrP8Q4prpV8jjk2zZfRejjo5ljI8SZ7KQOG+t2
	eauy0xXI16saraGTZmSzO9BXghHeFPqXZC7v308+9DAO/eWdfRVQLx77qubDQoKE5QOTOUgW20I
	6IB5UTQLA86YEb144m6fq22HAi7Th8uxffE1CMjYRPyJkvz0DUl8biLa3otOR2vHSVqCc2VJjYM
	qC+GnoldzWKOdsVIdCs+j2ypU3pr/DvDagvhJYYzRz8p6PnPHCtY/qadjqVteDVm1H2F4YXZa4f
	pMQzhwEoJQjNdotGGPWuL8yGWPQdiWioVLtzEvfEpE2ofIGXcTHwckQoUFRkuaWyLJ/qZarn3V7
	XAF/ZWnT6vVoRjrw1lOT3i9bxwKIdEXO5D5Q==
X-Received: by 2002:a05:600c:1d16:b0:485:39b2:a47c with SMTP id 5b1f17b1804b1-488835a58cdmr3373615e9.25.1774978008731;
        Tue, 31 Mar 2026 10:26:48 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887aacb88fsm22800275e9.2.2026.03.31.10.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 10:26:48 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Suppress veristat error messages in non-verbose mode
Date: Tue, 31 Mar 2026 18:26:34 +0100
Message-ID: <20260331172634.57402-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331172634.57402-1-mykyta.yatsenko5@gmail.com>
References: <20260331172634.57402-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

When running veristat across many BPF objects, expected load failures
produce noisy stderr output that obscures actual issues. Gate these
diagnostic messages behind --verbose.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 9652649171ce..5c82950e6978 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1673,7 +1673,8 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	fd = bpf_program__clone(prog, &opts);
 	if (fd < 0) {
 		err = fd;
-		fprintf(stderr, "Failed to load program %s %d\n", prog_name, err);
+		if (env.verbose)
+			fprintf(stderr, "Failed to load program %s %d\n", prog_name, err);
 	}
 	mem_peak_b = cgroup_memory_peak();
 	if (!cgroup_err && mem_peak_a >= 0 && mem_peak_b >= 0)
@@ -2247,7 +2248,7 @@ static int process_obj(const char *filename)
 	}
 
 	err = bpf_object__prepare(obj);
-	if (err) /* run process_prog() anyway to output per program failures */
+	if (err && env.verbose) /* run process_prog() anyway to output per program failures */
 		fprintf(stderr, "Failed to prepare BPF object for loading %d\n", err);
 
 	bpf_object__for_each_program(prog, obj) {
-- 
2.52.0

