Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4172D0C63
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 06:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769235741; cv=none; b=LzuazUX4mRipJpCPLbWhV913z0pGH+TUaZYeQrMy3FnwOk8lxFt75bzfupIeqdTFEJfE/FsMPWQaC/HFXyCG9iF1tXX1NcmgJ2+LqU7Ut3TFiXzE2VA6lA2Ko/HGCUonkR73V0TbrzHyDRnyHq+UAeilTXGZBp66voP+g7v3tmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769235741; c=relaxed/simple;
	bh=mSDxwBVD18PlqYhebUKPcoi11BSc/00xy3TAGxUREuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QF9XWYPpUjPy0v59G8e1wZDrpeLWxEbs0mkSbXeuZhySRd5F937wFIJqqLrlOMWHELZ8tGqPENhB9TLZk4/c+aF5jU1D/HGTdMK+KFr6/nb2D4h4umLvT8t6iQB+beZIFBFzA2rk5vn1hLsSYX3u4YFQb0HFU9PahEpGfx5EAiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNDI7oW6; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNDI7oW6"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-34e730f5fefso2030105a91.0
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 22:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769235739; x=1769840539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6couASguPY6BXT1cGXkKjPK1OxE68MmNkjTJGExLgc=;
        b=fNDI7oW6EPwAxhle9ZKxHbH1rJD+lz+UF3NH3nFrSs7WjFMBY2iJJ4oAjlBG8HFKDj
         aB4qfOQPpF3u34T/RbZKgTDit723u/w4hG6B7iuY+3cWo026u3E5ToXv/myxFcpV3qm9
         ZdTEMCK3KH5RGaXoqTNw90BTjfjy4G5iyG0l2KFeOTrpcr7bOOCD7MMG8t2ozN6Rk04s
         o9vCsM2Oi9e3Y29+2DUCzY1xe5HQcQ95YQe8j1/FNfAl4SwqF/6aZ9/WkblVX0/6LWc2
         JPxpLMtud65Q1FVWlgCnFiEviMrI+wGkwj+hG3nwYJ4KyXXm2EuX8Qyj9gp08W0RlApc
         bRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769235739; x=1769840539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P6couASguPY6BXT1cGXkKjPK1OxE68MmNkjTJGExLgc=;
        b=l5mzdnRp7Tw67IBA8ydvcXLAgZOLtuKDTsabSg9+59Sb4UcLTkq0rf1Pxx7ErqCNrM
         gj9a3NnaVrH1/SgfvV283QtYoorgq+Yfdc60BHnR0/jVn7V9/vqOcYrRG9dBJ7n17qqg
         TnLsTeQCPRyvSJ8XWvQ5nxw/OXNgX3NbXtRiEl+9kHNmwUXqMUd0Ni+1MM1OcABgcmAp
         TPytWkvJr7O2YVE6PPBiwkFPk/BVz4+ayVoMQlMYqGLRngTGhjzdXiFzhSPZuiuD4hH7
         c6neoherEWL953mMZsgzpki3Di7767JhSKXDvG+4cPcEv4wEeabx47sGgNK2lt5OMTB4
         nroA==
X-Forwarded-Encrypted: i=1; AJvYcCXL82o+G4uobEIor5Y3dasZgTV2DvBGk9gVFF1lqy9u2kWJ+KMwNKSEg/l57YF15GfsyYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmGIE715ICPXKzjHzq1fTpaUKjKmTZB9prsimH/VPjcYcBdr7F
	5X5xyIYLOU3trp/qc/KKX8AtKsU24IiVl++4dbxzfX9FDEg0RUrBI/o7
X-Gm-Gg: AZuq6aK5+5fjQUq6Q6xr60w8rfLZ+SgJbvCUyz4Ol0SqgsDWi2BjNVQKd6ATeqrCFWc
	J2QV3Hte8SKYTJyv8VSrwI8pRB75Rq2mkSrvPGXOlW/XdQAdbkGo+FyMhFOP3zTHsTz3Dll3ea3
	1QT3HwbxZ+kTxwRiQDTzeK+5bNPtCCIgHB1AjAReDHp7XP7oNfX0LesHAL9z3crwM5bw9GEqY4+
	v4i6PqIgRx0OlPFt+vW5toU0PvqRWNFoaZFoKwclfDbI3+JteV+1fjGeQL/GIVP4tqAotN3wUXi
	Sn6eGc+KxXgjaCQdr6x18xLKNVhXay8STSs4UMixKyLHRbElKUBul0/MBs9ijQRWtNPl6p6plav
	LF6JV+ezM7Vsqc0vKa7LkuFWzuIQ+diR5n8nUY4wtw/TikIr3W70NHfcsRbNoCZgr5/aEBzEKCy
	7PfJjy2S+j/5qs33sZ2Zo=
X-Received: by 2002:a17:90b:3c05:b0:340:bde5:c9e8 with SMTP id 98e67ed59e1d1-3536894c35cmr3832652a91.22.1769235739094;
        Fri, 23 Jan 2026 22:22:19 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353354a6b5asm6496537a91.9.2026.01.23.22.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 22:22:18 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v13 13/13] selftests/bpf: test fsession mixed with fentry and fexit
Date: Sat, 24 Jan 2026 14:20:08 +0800
Message-ID: <20260124062008.8657-14-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124062008.8657-1-dongml2@chinatelecom.cn>
References: <20260124062008.8657-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the fsession when it is used together with fentry, fexit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../testing/selftests/bpf/progs/fsession_test.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index 211332bdcccb..86e8a2fe467e 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -161,3 +161,19 @@ int BPF_PROG(test9, int a, int ret)
 	test9_exit_result = a == 1 && ret == 2 && *cookie == 0x123456ULL;
 	return 0;
 }
+
+__u64 test10_result = 0;
+SEC("fexit/bpf_fentry_test1")
+int BPF_PROG(test10, int a, int ret)
+{
+	test10_result = a == 1 && ret == 2;
+	return 0;
+}
+
+__u64 test11_result = 0;
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test11, int a)
+{
+	test11_result = a == 1;
+	return 0;
+}
-- 
2.52.0

