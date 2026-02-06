Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DA1241103
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 11:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770379159; cv=none; b=IwuIgwuZX3WnWQEA6kOIx8mxgN4R5CKDgkqwopdqnZHbmbrSjFxLJTbuvx75BawsJK4lNI5ZIx2UQZ+LFOO2tQGSF349fASg+/az6q+sMqMks/iE6a3V6a6SxB8nlTmbBAkn6tC2S/qbFiyD8GRURR7Mvsk2CARY9Z+zmh08/JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770379159; c=relaxed/simple;
	bh=WNVhyOL7okSH5jtf5uSAFPq08ifRlHDbQ+0d6p9ancM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgacPZw7KBruhTtqQakDMyOamDaZbgrtlP4fi0GkpROO1glCmXCPqLMUqEzU0DctS/UuBAnRQDmw76g4kgd3zSTRCQdJ06iX04q2n3OrASR9PqX1hbJtqyrmy0B2B55g/iDzaBUBO+azBnRNu6Azu7cvmLrQcm0NdGxqfBZq+Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbrY5WtB; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbrY5WtB"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a79998d35aso16351295ad.0
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 03:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770379159; x=1770983959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOZtDu7jSNri6wkbo2wj70FyVnPCcpHXFtiLHwbu29Y=;
        b=dbrY5WtBBQhYu3+ZI7un9MhxL5yN0mns+IChAd5SeOp8/lSGLIDkA9jIfKjDAIH61T
         V7CDYEbh9kDFaZBDwVIjFOLVCbjg6XS/IG/1TZ2MTRZUobqlWn9wpRiZajOHeRkB9XdG
         /z8kIE4yY7we3la3fQJMh1hLoBe3FL3kdak5olx8oI1gygRywAKLG+sokEMUj1tHH5Em
         tJICv2dnATVUr/kjGzfRFM1RdQc5XemwqJgp2gajDUTAzKTlAZghdvF6e9+ZZ55e1/tw
         QuGvOGX72wUUpoM1YF6zaLWpquQKImmzLVYJihmavmItVhODVgtXccTIZEDGut+Gi46F
         S+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770379159; x=1770983959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GOZtDu7jSNri6wkbo2wj70FyVnPCcpHXFtiLHwbu29Y=;
        b=nFkk/Z+AfIqc0aj785X54U0ntaEZu/XPf7ACRm4YOuvnW94nybDr2GrLich8ic5Bdo
         G0L82hlvs3lzi1UtDgAPMpUsem6Y6PRWYgx8aUpYIZ0+eMRvUo7dkohX2bSA4s4BKPKR
         PXNVmZX+z52wywRaTbZC3H1wFRmicnU/uBxCmsTebSgL2hUXV+pIxg2+KvvQqZS3WD1N
         ZOMWgYiyKcu7vJYVnF4Ool/+f8m0bp4Pbo4PP7X4PBmMcaqYGO2ElJKB+v/PFXOqQmzb
         KF4ZY48twFJ3Zgv1bqSSMfepoJZ++tEmEyyp/kdguy3L1l1OwEj4UhKsXXIMK9+bgxi2
         I5lg==
X-Forwarded-Encrypted: i=1; AJvYcCUHhRi5xf+DyDw2nj9sHITkf+L7Dvk4myxHp2xRXL/tqbKsflKduKtAr5ROkzvkrZDBN8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQVZnYmvdHyEQtdVTwc9wa16giaLcerQs8WkDmyfEw3dQiPAEJ
	4ZlYA/xvO1KmulGA7cMZnCBs+G612MI69HqFQCZTj3wCSX6tLov02b5T
X-Gm-Gg: AZuq6aIsvfJl3oPgO4znFLZfV4WEvwyMtAq7Wsz86FwIVZkynXUqUZ4EyXb49ERc7kE
	qKh8FmliJCOTMTze8loiGzQckX3hUIYzEvUWKL9kaOc5zYYyFHDKCX3sxzG3fbskh9VUdWwLl7F
	XXuW60MInfDpBLUE4mVne/2SsxMotPmQFp1AkX8OeWU4zhzxr6e7pURx/Pttlg9r2Jg6t5S5pE7
	Blpku+lsKdFPNi/lrlCa1RXMe7lsU6MbmeHgo0FZh2itNO+2PXCECYj0XobFBHqrPzKaR3fYTHi
	IJ+x7uvQgL0CXJn/5DTQwdylw237PMIVEC3QiR8v3ZAfu0otfzeJr/Z3koErjkw0DUTglEn3LMU
	uH0RDjdNNhclK259ZHHAV391gqjmGOPKCtk+hI01FYfNsocyvf1PbjZcqHfvmDg5h2C+eWlq4tR
	8fb4KLo5a2qr68gWajrfA=
X-Received: by 2002:a17:902:d58a:b0:2a0:f0e5:3f5c with SMTP id d9443c01a7336-2a9521f3f28mr26054885ad.34.1770379158955;
        Fri, 06 Feb 2026 03:59:18 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c8ac5asm22856395ad.35.2026.02.06.03.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 03:59:18 -0800 (PST)
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
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: enable fsession_test on riscv64
Date: Fri,  6 Feb 2026 19:58:23 +0800
Message-ID: <20260206115823.1070354-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206115823.1070354-1-dongml2@chinatelecom.cn>
References: <20260206115823.1070354-1-dongml2@chinatelecom.cn>
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

