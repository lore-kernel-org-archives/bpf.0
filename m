Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB537199FAC
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 03:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769225565; cv=none; b=bPDQ4eKo9Rh/o6/L8D3uaNkCmwIjtnqd8ebblCiOjyEzquKjUCM4Ljb4Uk9iKKDqe+FpVbxLzNnrj5fyJtC2jaMDq2rgwfz90Tmq7YRQcxNG44ZJ9rOkI3SZSyiF2QAwJnH0dqNOjc0j8pSlGPmB8dveXIHJumwISpaygw+84z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769225565; c=relaxed/simple;
	bh=7cC1ms5ub9SS0bly7QzzdjNJghADRqDQHVSuwXZiOkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmY0k5gqri021LHCX12sjU+7Y9sjloos3PGMTJMTavU7R9UaH8T7WQ7FXvfd2NZ+vTD2xJFhWY3RxOiSyljP0/w/gCHgmMnrXk6XWdIBLJqzbSqGqY2hNJOA15k42/HLdHM0zmdhd+/f5lqIhWFuru/f1uWUgiEHpycfr7rF9qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVL61iVI; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVL61iVI"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a77c1d5c3bso12579425ad.0
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 19:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769225563; x=1769830363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG3OIJ4OsXGkuiYroAWEp+caX5ZqVGcvi7JJxvZjj6c=;
        b=BVL61iVI88CRHYI7OLo9h9s94Hgiadlsw8Z0PkXAd08S70/8fsnKi+3/R5yqnbt3IC
         QQFVHK9pHRD2JWe2WFBNcomPXRafnHZ45a6VLKKEjW/wt9xV9FYeMR56tli5UZcsKh2w
         A1tVpZgolMpKvqjupMzu8/YPDgcLDSCA4uj/z+dFp1SmVi0MYkMpB3e/yqy5g7Oyt587
         yew/9wWqSf+zFSO+S9KglL/iMhkXr6prN3yGNRJN7P/sqWVTBks3tpf17FW1tgJa/tHT
         Y2YWUg2M5Np9Keu7QMEHvnmLhzsE2Rwlr3fC6tsV+mI5b3J8XeB/a46xL6AVDgZpwxms
         wbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769225563; x=1769830363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TG3OIJ4OsXGkuiYroAWEp+caX5ZqVGcvi7JJxvZjj6c=;
        b=clYTdb+3vTI8R1r85hvi23ts09TFguuBwHcOX/B1JZOVu3Jmq9qtzaLHm0QFGEk0az
         D7jeJYtrzG3Km6lArsX5RJ/ucF0BkxjjGpI0gtAkhtKh5DFJgKCqBIqWlCIF0AQMP2nL
         FcRLuY+rMsax7f4l9bWx4KpsPHb83Q6UiXupkEp3nI4uQ8HL8+7+v0Wi732mMt47TwfU
         HnvYxbwCXuCyYwtR6ClPFrPi/0by2MwSS5S6+/DVoKbX6Op+ByP67FLPMqSLaRN04t4s
         E2S+jAzCaPWwFCBbQWtC/ejaiGBS2KVJa8LKdpVjviUVdhG0gnwdy3yz3rHx6SAYKWXr
         XjkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxtdirH8EGf6ttP36CY4pl3UEMHzp7/IFMO031aUfoClwUngnSTyphpx+40xpfIFXlVXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeucoUZ9OCJZg6Jemg9zvoYw0E2nPWvJNVkdBnyWzB91lWHDDv
	eJjFYjH9Vnlx/TxUNdS6ffuQqeUDYNuiXpm6RASKMulHo0m6Am2df8Mx
X-Gm-Gg: AZuq6aI/4un8pesL9vs3/oigjKGY91U9nwlptbp+tvY7Ih/J8hzN/iBLtMO8TBPHpKN
	JHBjaQrM5zE/ZOT9DzXOX4MkYm/u79Cm4nywXX32gFo6lWN4XONK0H0RTLuB/R8cjFAcBgEX7SG
	cmqSFBYZb4qbjJJRE1wV0W2yEGf4eb0v5zgn1BBjblMafDk1oUvYgwQfUwFZpHVc9LQXK2P5rVL
	O+dHmsLvMPwXl+rKRAQddJsvp1m28oeu/k9LPoF1ftBRMDheufrTuwnPsq3CZ+N9auC0TD1lCae
	CHpiOIjCCyuPD5rF12fjsAQGR4hPOLV0DM3yFUmdevJKqJVXS5fD8T/j9D/WRzgTZBzkkbpIu0A
	sgjTX+YIP3HgUIf82Cse9HTex5ERdufVvagGdtEouAmXddV/b4F3C+J5qL0J0vdp1WwFBkj/Ykm
	RUHLrkH5Ghmxx3jn2Yv84=
X-Received: by 2002:a17:902:d2c2:b0:2a0:daa7:8a57 with SMTP id d9443c01a7336-2a7fe6260dcmr51787635ad.30.1769225563119;
        Fri, 23 Jan 2026 19:32:43 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcddb0sm32539805ad.38.2026.01.23.19.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 19:32:42 -0800 (PST)
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
Subject: [PATCH bpf-next v12 08/13] libbpf: add fsession support
Date: Sat, 24 Jan 2026 11:31:14 +0800
Message-ID: <20260124033119.28682-9-dongml2@chinatelecom.cn>
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

