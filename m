Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B2266576
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 03:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769225609; cv=none; b=hbOKX/lMzuxVH+mCCxLr3s0MFDcDsYxdliMs33kgFC7uVbGtro7ZKBSL6pQUaOxDDvLsyxSnwIvEVtqxGcIWepPYGkxYPdIzFZLfxQgjN1wTGPDus+O+fDzi7vpAEnYxWBs+zjzibCodC0gsaRxMvdKWbQg/DPLPWFHeeJPTy/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769225609; c=relaxed/simple;
	bh=mSDxwBVD18PlqYhebUKPcoi11BSc/00xy3TAGxUREuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUoCvE7YdFeZtyE9b0y+ZqQTnPrWkyP4NhDbJVsDJeYuyfi7c/pgbNYuY09bOpKlIQJgaso+VMvc+SRrhSK44Ae1jfIs1HTHJe30C2oUFpdr/hlECzi9h7GhwLhup5tqUWKS2tmqScwYA0l/nGRXeTAa33gKax21W8vv5kdUvd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXqWxvSl; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXqWxvSl"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a09d981507so19654675ad.1
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 19:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769225607; x=1769830407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6couASguPY6BXT1cGXkKjPK1OxE68MmNkjTJGExLgc=;
        b=GXqWxvSllPoUHku5fRetKn5YH8J2FiH6yyjYxkQXeL8E8gSQlfmRFIJqVAMdXyr99A
         gOSVXECcrsEB4IFRKXh2pRkBo/F7PRbdcqedpviG81S5U4qA8KB1G1ey8tinz6gLmMxV
         Uxzce1FTV6MRUi88xUCaangX8jr834zx0GxaEH0qJqwaXNH5ODwIoq6Ue+pvm2wch/QK
         6Tl1kqcBvun4xDj4Z/ooQvbe3DJMj/A+zCC5YqcDAcNLAoVM/nnK7neyuajW9gL4F5ws
         WAQf+1QZx+M+x1hm6qq2jp3xoxI9yt8vwQnySLFz33QI11te17STam5BHYDY7jgDktif
         98OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769225607; x=1769830407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P6couASguPY6BXT1cGXkKjPK1OxE68MmNkjTJGExLgc=;
        b=VPInbTm0XtfUPNPtSUbZHwSGWqxq8/t9YNaPT7LGxKT5Tdqdte00kW9tMnOiDgr51p
         wie0YBGxcD4UudF8GtUjm9FknBLTd3oGdToajQv8iLnmVu0JM+VI8vTSLOX2YiqP/L9u
         lxHC2o0CpYbAMEfIOs8Jud83FoUm7YYQ4/W+zmBql81mZzvwleEEmvw9LXFAIbn59SUB
         jQZdFzc+eIhE1+50tkrPPDHvFARvpOGI2odVSjbxiGLJNac19rRlkccgCMS+U0oth3Vc
         FL2g5vyKpTV9LjTEdp2GCNgBm5IiKZj6dEVTkTTIydedZ/8VL1vgjHUxTSfeIXjc9AGs
         N5TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIEiSZIXZRqL3jiCNPY7++hX7M9XOtGiWanQnr51V/lygy1JccibkG/FQUO3g8yd7Qs3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9R1jF5w1czmhTXxoroAp1sRVtdmHk/C8qZNV3nowadqDNMO9t
	it9s3U1CLUgFpf8VekVvOtriJxz6IVIgH/3ZKe4j2UwZwRjp6nD3Hx2J
X-Gm-Gg: AZuq6aLEThsdaYfbUGHhpny3syioDCM2mA5GcEfDm1wVTV2pnjqGIsgMB/p0WkR55eY
	9CnCSarat4UX4ie8gX9DASAbsYRnhRK+ehuaTjRQh7rjSK/nG6G4NUxh6N4f58wcj97389Lojbk
	0KK0gIpOzeP9Hfw4vVQ3lOXwlXQXvrpVLRxm09M183MxAZxP/9W7NOO7I5SlIBXGz2tI46H8P0O
	eBRcQXJShWvtd00d7ei5Fxvf6w87/jA4nXRIjRx1AC5NT9Gh0gbYDhClWHmZKwwrgGw/zckij+t
	7brKDOLiSTPTnWj93GQu2WxLrdhtKx+JIHV7szUUEgH4yc1ZkfduTnagcGmpxnJkdWQKvfsrfBJ
	Rz2GcwtHJqDYXb3K/EmyAEpEFcBX/0/CBbL+HI7ohvdC+MpAJu7UIoWcpZCtOvglbpdsk51qeEn
	ohcKr/GnS+
X-Received: by 2002:a17:903:1b25:b0:298:45e5:54a4 with SMTP id d9443c01a7336-2a7fe73faafmr35282315ad.1.1769225607207;
        Fri, 23 Jan 2026 19:33:27 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcddb0sm32539805ad.38.2026.01.23.19.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 19:33:26 -0800 (PST)
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
Subject: [PATCH bpf-next v12 13/13] selftests/bpf: test fsession mixed with fentry and fexit
Date: Sat, 24 Jan 2026 11:31:19 +0800
Message-ID: <20260124033119.28682-14-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124033119.28682-1-dongml2@chinatelecom.cn>
References: <20260124033119.28682-1-dongml2@chinatelecom.cn>
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

