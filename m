Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C83C27E045
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 06:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769235694; cv=none; b=MLGzOge1CnBEvvu4mVoMbmutQqV4Yj0mZiG20XU7iUyV9wFeFYWEtWjw8fpWNfyOLPnxC9w1F9cc20FRyhCVfzcyu9sfZnGqb4yXcsONNmtIa39dhu5FZcHPnuIkxO4z1RFwlfkVvkNu/UAQhs2Ci+8VJaz/wdhRU8Q5f5ZIV2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769235694; c=relaxed/simple;
	bh=7cC1ms5ub9SS0bly7QzzdjNJghADRqDQHVSuwXZiOkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMIF9OSzbi4nRp4rDOc9mhG09r4zxdJOXZ3QxqaVkk+PuVUNjJ0Cvau+ne3R9Svm5mQAySUlLmhuOtzqnKmMJhQzq+AE4mMZBaakXydbZlCS6amA416lvmeAAL09vK06FYuWJlotEPYvpft89cnGyuvd8EebzXzKi6AUSE+Xt6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EA1xnhRf; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EA1xnhRf"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-353576abcfeso1040657a91.0
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 22:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769235693; x=1769840493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG3OIJ4OsXGkuiYroAWEp+caX5ZqVGcvi7JJxvZjj6c=;
        b=EA1xnhRfiT0cBVfpQaCqUjWbXq8bjonP/vaoRYMH+D4LDodfJFvTHE9+Mu8aqEMa47
         QxbZft+FAov7cW1OT5cV5IBWmAFEAJiGm+v8MRw2l1ElpQLlwKne4j8aWarCQr5KG47p
         8hRbF0R1xlu98z+v4Jw4BSd2/FuwA9vpwMGS2Y6OjFM1fHKuJEs7YJyw9olgfKcnrj2g
         oqBSaheZMW+D0n5/NR07XlyZjRDHaj2NqTXQh1aywNqCmj9mHGBqR0OJuVkKgzHCz4jP
         kCLJzEPWItGKfass2BmBn7ijHiJ0VzQpEEk5ULADOexeZuwOHcln25OTc8EzzbCNru29
         iAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769235693; x=1769840493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TG3OIJ4OsXGkuiYroAWEp+caX5ZqVGcvi7JJxvZjj6c=;
        b=hC3GLNz5TVcNBhmfVeuAvKm+++n6yvW5oahCJWbG2CL1rs0Cwoxjl2X9cwxBxRAHlK
         0Nbk+IcHThTA0A3grXwIDNP+Rq9BMpaVEugbKY/ZHFe5ndjvh2HDz+LsMYRljmIlnANn
         CQAycLIphxMcHdGqyaSAxcyO51IeJ1P3UHxJG8l+mQx8viqWSFxjslYgrUA62PWmJrsZ
         tRamBxbFZIHfT6yUrtoGchvSaWmDbc3uPiuy2krFjor+rLO4iRbEQpxMQxUeWMr+P+8D
         x4smbAdDInjqq/2z9/usGsfBl0WIrkIlNmIUY+Sgilub0meEIt/oI7zNSzxoUefmB5eG
         yf7g==
X-Forwarded-Encrypted: i=1; AJvYcCU01q143yaJwMWkSP3BerxOkZNj51o1GpqQ4Eng9tM8e7Ub6j5/6VU4ecIaSwq7oyMSqkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqQANplhNYjhjN39m7Q6LRQ5/BNNmP+TItVVx/NHRHHMVCY7DP
	mV55f32pto1RK7PRIzWRWTP1koNXQuQ39rSNneaYjpfH43PZoFYDBkcZ
X-Gm-Gg: AZuq6aKERsV0C0NZnyPT2haz2JQOnHvANx4KsBZa1Ie50Z1O6V5huq5eyK8gpbZ2CJr
	QNlCQcSGasL9oDNZ4wHYsCDqnMlDuaVlPtlD9HXDdXhy4t+KMwes1jcAyvnNv2hS+QVu2dKOFWF
	UEvCzl8OqlsF77u2sC9STPjTx97d0xRcENtWHSTODKTTSKLSOIepX/mbwH4vKMG6csWpyCWidSG
	eOtszRgW4x5ZbUKmhj+vx3m5nf3dDerprNYx12Dsu2VDJVU5np7lBuresNeCXkXvhFJKH90ApIu
	tXafyLeQVT7FnIp9DwIafRS3BHSOUNaeZO0ncd+QFP5Llep78dzOLiRzvU3EJH78p6JZfhjtKns
	mhnPChrcWK8R+uT1yQF33F0R7cPY1crs7GWq2MEZY+usbEY9bZcYv+5plO4XJlTMoFazI9YgCB1
	asULirPFCI
X-Received: by 2002:a17:90b:1c06:b0:353:3999:5c04 with SMTP id 98e67ed59e1d1-3536884bb77mr5366911a91.17.1769235692687;
        Fri, 23 Jan 2026 22:21:32 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353354a6b5asm6496537a91.9.2026.01.23.22.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 22:21:32 -0800 (PST)
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
Subject: [PATCH bpf-next v13 08/13] libbpf: add fsession support
Date: Sat, 24 Jan 2026 14:20:03 +0800
Message-ID: <20260124062008.8657-9-dongml2@chinatelecom.cn>
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

