Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7C35E547
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770380461; cv=none; b=InlSyqq01F7GAovl9Vhmq3qC2r48wzg5vuomZ5MtKKirFqW2aaEmlhk5q5rt6uINDxoz/+DrGfldb39ElxFy7gzo5R5HskSxi9jboOi+Sj1GhTyQuXZo05JKcP3Drs4PdIXkP9OEmVs16U6Ha3qtAYklOnzHRgqSYnxJhUx5dHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770380461; c=relaxed/simple;
	bh=WNVhyOL7okSH5jtf5uSAFPq08ifRlHDbQ+0d6p9ancM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GuDroHaIII0HlBnvK5cE4+e9x0i+ejUWaWvPcQ1F3FwG1Q+YzmcQvNk8WzD5SEkyLYAIVtlxthD2pvs0GxJv/z6qnF4UAlQsq1FoEYc3XTHFqpGGijV0KfycQrAFcG7YOcERZMMla7n7GRMpzXZEQAqAMlGqoz5PU4/nknCvbrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeE+stIb; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeE+stIb"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-354a2a7d90fso1119004a91.2
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 04:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770380461; x=1770985261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOZtDu7jSNri6wkbo2wj70FyVnPCcpHXFtiLHwbu29Y=;
        b=HeE+stIbBgr+mYbMgRCNxIlsupDFH7IdUTPwN+s6GQKrC7Mg21S7t1XFSAgct0mE82
         Z21DBJZxnxKVdir7399s6yTa5+N/JqsrsgQE/Yj+z0D7pslNQyaWNYdbYljnZczMDKuw
         9zdUXCSsMo++7i5Oho7Qdc5QUHW2U3u+F0ObVaI5hKSwcWSdoXOY/m5K58URn7Gilvha
         /rcJm0dFn2WdWGfwOIaeNfZ+TE7gpdBTbiwxlVs9yPaFLD/XcXGAF+pXLu7ysvgQUGmL
         nIUa7ijspNY86mpTLg5l6BHDYAHl6q09UWp1yoaRuxsVbB9JhpqS8qOgXPklONfDY0nb
         7WLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770380461; x=1770985261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GOZtDu7jSNri6wkbo2wj70FyVnPCcpHXFtiLHwbu29Y=;
        b=THT10rQVRWTk1bc2W31MkTiZQD1tCT6r2HDPf/sKKYB27QO3I5ei/nRLzMkrAPj8sg
         Bs9WwHkEeOHCV6ZuU6mopedqLHp2/b20ms+4PnoeJx1AvMngHyNLzi2jXl4so9wNiYuW
         z22rhyEHkgZWhApPUjQJ7hBQH5phJLQJdeD6Y7ZrigZ58ebazojiYeuB4jAWDYi+IOTa
         PLof404D7WZGxths98OLzrvPriTEBID5vrKjJZ+ZnnQFsmbnAZnob09nbvRNGDw7ZCxl
         zhIAUUIe42f3oBe/8tsRwlr4GDwgsRP+lV8lENlAQ6ikS6eMTCSiOwGoau9e691e+esj
         2WuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/fWUS5AHDgOJPAIr8gbMf9fESNEmPwZl00i+NIcS6bAR4n/SC6uE+rtpJbbVhWlHpub4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDIJsD8j033T8DsC19PfyP2SVhatotBElO6ehyPGaYiB7mGb0i
	LMQ1LaSV2m5MiuVthUScjEwH7povlP2pNGeXPVgTEgZ+wAUL1EzgzE/g
X-Gm-Gg: AZuq6aInWjGHBWJLnv09Igf4Cbmt9QV6H0dnWT+w9FVg44f2WCCnKyzTZW36W0cZtDN
	QPuDKCSG9VMFtfTtb+of+b7/GdQWkfb56AAIObglhh29KB4ke1A1hfrrFOLR28WkKVbuKtWXKgB
	eGgnYuAG/IJf2zUUvgeARsK/eP2UcC/9CIOSKHmS2cKQypoYXw+fSmxAbEr/q3GJ1gGSKinkol6
	eJajwJHfZsfl7AbELAUAHDuaIGSTHeMG9RlIbqNn6NWu9y6jHXkmaPBmHI7YzA6nWWxCBwu6olH
	UqAFc5B85WWZHysXe9/J+rkIu4r08NPTsZ5WVWcotSDjjetzs3+dWEslr9frfVhLy4gUk/1CdgJ
	Yjg0KrWS2aef4o8Iin+DcdOWgBwpV+Tz7foAAqNwgDbxuVuSy8NrqeT+PBEVt/qjHal+khuUA68
	vU7/r6Y6CiHshMg/oLmzg=
X-Received: by 2002:a17:90b:1e08:b0:34a:b1ea:664e with SMTP id 98e67ed59e1d1-354b3c8c50fmr2606450a91.15.1770380461134;
        Fri, 06 Feb 2026 04:21:01 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354b301d93bsm1528222a91.1.2026.02.06.04.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 04:21:00 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	bjorn@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jiang.biao@linux.dev
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: enable fsession_test on riscv64
Date: Fri,  6 Feb 2026 20:20:02 +0800
Message-ID: <20260206122002.1494125-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206122002.1494125-1-dongml2@chinatelecom.cn>
References: <20260206122002.1494125-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now that the RISC-V trampoline JIT supports BPF_TRACE_FSESSION, run
the fsession selftest on riscv64 as well as x86_64.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Tested-by: Björn Töpel <bjorn@kernel.org>
Acked-by: Björn Töpel <bjorn@kernel.org>
---
 tools/testing/selftests/bpf/progs/get_func_args_test.c | 2 +-
 tools/testing/selftests/bpf/progs/get_func_ip_test.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/tools/testing/selftests/bpf/progs/get_func_args_test.c
index 180ba5098ca1..075a1180ec26 100644
--- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
@@ -167,7 +167,7 @@ int BPF_PROG(tp_test2)
 }
 
 __u64 test7_result = 0;
-#if defined(bpf_target_x86) || defined(bpf_target_arm64)
+#if defined(bpf_target_x86) || defined(bpf_target_arm64) || defined(bpf_target_riscv)
 SEC("fsession/bpf_fentry_test1")
 int BPF_PROG(test7)
 {
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index 43ff836a8ed8..45eaa54d1ac7 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -106,7 +106,7 @@ int BPF_URETPROBE(test8, int ret)
 
 __u64 test9_entry_result = 0;
 __u64 test9_exit_result = 0;
-#if defined(bpf_target_x86) || defined(bpf_target_arm64)
+#if defined(bpf_target_x86) || defined(bpf_target_arm64) || defined(bpf_target_riscv)
 SEC("fsession/bpf_fentry_test1")
 int BPF_PROG(test9, int a)
 {
-- 
2.53.0

