Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138FC30E0E7
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153813; cv=none; b=sg3gpUq3h6P2tnPTwbA1Z6h0RqW6KbyEoPfMSvJzp4thO0g5PMucqOwGsIJpIhed8zO2PHlkfRhGuM3kaPbFqwl9JqoMDtv4ek8D4ySSpiBF5sFW7hWYP+gYwyMC8qNKT5JC923AA2eTpt3uz/2SDe9n8NsIwyo7bZu9Fu87FtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153813; c=relaxed/simple;
	bh=7cC1ms5ub9SS0bly7QzzdjNJghADRqDQHVSuwXZiOkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfucARCHR3BiTmYUuyrGew/ffbHD+j99TwC4oCQTp+57M05XVAePL5rBL8/XqvLbaYtbWi9KCmXTh/J81X0QwhG636bnaRUBP55qSJ/jJZPJlVa8H8qWW44i8j1AT0MW1EOg1YNFfXYfXzIh9qcSkS9/zdVxM2pTsM4YyFFtd2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQhrHOIK; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQhrHOIK"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-823081bb15fso922466b3a.3
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 23:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769153811; x=1769758611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG3OIJ4OsXGkuiYroAWEp+caX5ZqVGcvi7JJxvZjj6c=;
        b=HQhrHOIKI1HpgGhW1C4/hYqk+pyPGbib312/colf0oNZeKvi2aQrTu4AkNjQIGya5T
         L2pQKJAwNp/ZGzSiKgNUlC0WxQsvUdug/WpuIVLPeOM4rHxUo6WcHGA5x09wTy7/sYCb
         wfA283H6WygQN0YXvlZWrSarIC3XXdnABrlozPgvzzzyJwvHNhhxnzqzLJ6amIoQirza
         yyiTcWRg/5v12paT9ZR4o70CItBrh5qKe8urBxBIf/QeCFGSD4g9ksp1ae2epKMG7wmT
         3K6Mw62EMRq1S3huYMw8turGLvf72GienPWTgplc9pvMiEGdJHBLPsAeNY3/G+ECPCM4
         8wFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769153811; x=1769758611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TG3OIJ4OsXGkuiYroAWEp+caX5ZqVGcvi7JJxvZjj6c=;
        b=CuBVOpx33cJj7TUk6dnszGcWWgewgAt05/54UJn/42d3uCWsr7DYyBRGp+NUkWLyFB
         0pD1MAedGxToqKpi/dFNHTX8DxG++JUbntsDVEd6maf4b7ymptWA5LVyyQv4hYHAHbcQ
         EnAjyxcy3rRj3m0miep3qZ42Es3i4mpMnOZgzyN7QrJQ1ueHWjWh952W0W+Zp8gLLT2c
         +/E/ctZK0tSMNaXYFVwHL9jaAhESA9H3Cbb1woKFhrWgE32hohnFbro3X/BViQwr1EKh
         ThKP2xAIzx5xCMbs3qyCEl7uppVgjhoXPrhMD21belvW8K9JqLQHZU7016MsKBCeyRSk
         OQAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtKDeF5Cno00hd36fpDaALHKyEBsml+T9XKhPO0HdIfzaUghQOn+O5at3sJ+0sPk/DfqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygoKeIU6gBCcHq6523oH7vDRfK4RQ2OlvuFdNo+oJKzBHrM4kB
	1KmUXNMTDJ3NEDNeEaQSuI9GTjJtJ41aZxii8igagWZ4VhWrLnGo1Iw/
X-Gm-Gg: AZuq6aLAZKw7olposqvd5ZKDtU52xWcglTJ+/YQDOpE21Lu3ERgi/mKB6Cblz2byDAj
	pRQae0mwPrGUbrYsPMmtn6U0BDcuR5D0rGgqFhLKc65MqOU3xLOBTvg5+nag6hAhBi20ZdHf02j
	EYVrA4iQxbPbfC0JPUhJ94fLy8A2+vt+Gbxj1KOtD1M1TingenGSqqNXOBtJvZ4jhTIF/1Cr8/M
	pat3QcbzrpTIwdxHg+xOzrPCZFcQmA/u1r9u+o4nEI8Na/wg3bZca0QvqUXAaqudJr4YqgReb6K
	4JDyS7g4B4FZt15FleCnQGy68kGq9SQ7zt5GSltZ5IRk7g32y9l6ajeKj07sATW3+pDDrT4u8S1
	SHiznJAZ/E+lwbYDLKsL3X3YFPQMKlje0YdEFt3aGS2RzgftefJuxl0c18MgGzAtYYGRN0b1qfu
	xZKREFKKC+
X-Received: by 2002:a05:6a00:3cd6:b0:823:8a5:297f with SMTP id d2e1a72fcca58-82317da469cmr1995656b3a.16.1769153811409;
        Thu, 22 Jan 2026 23:36:51 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231876fd1fsm1334205b3a.69.2026.01.22.23.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:36:50 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: daniel@iogearbox.net,
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
Subject: [PATCH bpf-next v11 08/12] libbpf: add fsession support
Date: Fri, 23 Jan 2026 15:35:28 +0800
Message-ID: <20260123073532.238985-9-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123073532.238985-1-dongml2@chinatelecom.cn>
References: <20260123073532.238985-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BPF_TRACE_FSESSION to libbpf.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v10:
- split the modification to bpftool to a separate patch

v5:
- remove the handling of BPF_TRACE_SESSION in legacy fallback path for
  BPF_RAW_TRACEPOINT_OPEN
- use fsession terminology consistently
---
 tools/lib/bpf/bpf.c    | 1 +
 tools/lib/bpf/libbpf.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 21b57a629916..5846de364209 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -794,6 +794,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_MODIFY_RETURN:
+	case BPF_TRACE_FSESSION:
 	case BPF_LSM_MAC:
 		attr.link_create.tracing.cookie = OPTS_GET(opts, tracing.cookie, 0);
 		if (!OPTS_ZEROED(opts, tracing))
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index bbcfd72b07d5..0c8bf0b5cce4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -115,6 +115,7 @@ static const char * const attach_type_name[] = {
 	[BPF_TRACE_FENTRY]		= "trace_fentry",
 	[BPF_TRACE_FEXIT]		= "trace_fexit",
 	[BPF_MODIFY_RETURN]		= "modify_return",
+	[BPF_TRACE_FSESSION]		= "trace_fsession",
 	[BPF_LSM_MAC]			= "lsm_mac",
 	[BPF_LSM_CGROUP]		= "lsm_cgroup",
 	[BPF_SK_LOOKUP]			= "sk_lookup",
@@ -9859,6 +9860,8 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("fentry.s+",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fmod_ret.s+",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fexit.s+",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
+	SEC_DEF("fsession+",		TRACING, BPF_TRACE_FSESSION, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("fsession.s+",		TRACING, BPF_TRACE_FSESSION, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("freplace+",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("lsm+",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("lsm.s+",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
-- 
2.52.0

