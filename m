Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F9D368293
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 05:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770097999; cv=none; b=aV5RhCnWj9qp0siCJcbLW/Lj8n5InecZo7H4Vn8bSy4rdiTViAFNT97a1X+rR83cDjkvJpbTpbA4ECMRuKgbgsbwwdmXsob/N2Zw2XupsjwKJGIuH9thEx8Z3YwwgOpWI4QSoD+RTYouPV7K7OOJyfyiUMKQS3KXNsmovOL/gJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770097999; c=relaxed/simple;
	bh=hHiF3nksI8lsJC2F4SsmOkBpvT4ZyZWbPKJh6PP3/fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRvrQJzZftyylSDzK0eT1A4jNO0ehIZ8Mw08ddInkgg9r0E8gsPbJKRKh7ipdoaeUutKPHifIL9OSucOXh3p8maYWnXrT+Bt79zL18U3jfB+Dm6v51DUubsfgyyaF4Gx1S/Dhq1Jw09lQhCvJIIs7bkqeSQzOfvR2Jg4C67hJeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehiDrojD; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehiDrojD"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-894638da330so54105076d6.1
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 21:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770097997; x=1770702797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxSsUMeT8Os/CYFJWOVT+HQkubqBYSe/TOEbnpWLzSM=;
        b=ehiDrojDS1Quzdq4sdtcFBp1C1XV0+C8q1EjuF8QAhtm59slgkt45fsQhv2F7MooEs
         2zrJ5SCi9FHIxsYqsYldB3YUc6h4Lykmbn12YAqvyGCX8GB60WnsG66rrsd0MlcNcrNU
         8II5ZAoblz78Z7zOgeaG3xvWNDabTkCR0pG154VCYnd1GB3X9kUpCx9b0YVV3SMnEvDI
         5A18uN3DR4vUQI3YUjatde4p1kaUzT1Zt9ZxqYtxalasyPEJ8whyc+zi/SRE4MzsfZeI
         s9FS4AkeWakrmeYZ4K/OB+uumxZw5PgM7QW5SII1iMQUuqGqW/wlIUT1v/xOM8x1+f8B
         DCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770097997; x=1770702797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wxSsUMeT8Os/CYFJWOVT+HQkubqBYSe/TOEbnpWLzSM=;
        b=JI71e0q+AO+aS2Y6iCASmC3GkOSQbIkXZQQ0aYjIQoaZ9bCYY1gSy4KiY5Ru1b8//z
         3s3s38mRZ55O1qC/W3DaPp7hHyDUVtyLnPeflNy2mozBIKMoeXVu3xFj6xvatNEeXoqN
         zpjXQAhvz7rvv/lCm+wMws405QNp0P5LDQ3vYSeM8PKOYZLXrkiblDGCP54KVIM2NbD3
         Igt8nOLqVYF6dNUSSNb0ufUytF7XYMfvDy1DRsF0JIOp+cUvmVLczPulQVavVHXrW1a9
         7sQAFK6d1b7hrR6nVJGdK+NbcygjrP8FBK1P4us42YOpZD1WZ0aJed96w1v7LWYfpNZU
         le0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFK9SbKyhX/OI1lDl1bMdM8DFqMwl1AbQzNxwo824A3OQWrRLuMTpDXy670D46dnzRQRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YynlsS7P0waG/uWV4FTxgChaptLSAP9Vkwy1ry2dCJ8LKEmyvSi
	OKaihZIwwLC7I8hkVhTAwrhZ8goiNx0kw37SDYTN6rp/L52njzNhPdJh
X-Gm-Gg: AZuq6aLed9vfSumX65zupZjSxJJxebpmC30FaJOGjanl4yG5iuf7qR+WaN4Q8VrxN0W
	CKellLLPF/YhMzMbduQscOSCOm/z1CcyQ5klaVYnD4bSv+JpBHZvXXY0kx8fcGXDzKbbEbfcXAC
	iFLzpNUqtT7XbA6Hw5Yvd0zbhx7TVXzNp8dCK6bqoItaNVG9B+7EZlS+BimQuFoAxIjDPi3pu5d
	GTZVwoEu8R+GCx3jeIRciMaHfzlIE5CsrmZJLfmRn4ZinyxosCMnIwKYZrm2AIHVWu8ttGYHbge
	3Wi4MXTqDTpg8HatVBVijnR5kxyHfvS5IsJu0DggLlfWIWQqWuEfH4cUHQvQDyE8wDgihtvEWKS
	L2eTwrST+E73rGp/JehoMRHuJdIAZobcuG/OA57FcP/DM2a9Rv58WUeTF4ugjcmhIN8IHA7Xir1
	MZAWoqf0E=
X-Received: by 2002:a05:6214:e8c:b0:882:5078:8da1 with SMTP id 6a1803df08f44-894ea0e654fmr202391646d6.64.1770097996666;
        Mon, 02 Feb 2026 21:53:16 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d376e65bsm129844996d6.55.2026.02.02.21.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 21:53:16 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
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
	bjorn@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 3/3] selftests/bpf: enable fsession_test on riscv64
Date: Tue,  3 Feb 2026 13:52:31 +0800
Message-ID: <20260203055231.1088479-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203055231.1088479-1-dongml2@chinatelecom.cn>
References: <20260203055231.1088479-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the RISC-V trampoline JIT supports BPF_TRACE_FSESSION, run
the fsession selftest on riscv64 as well as x86_64.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
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
2.52.0

