Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF0823BCE3
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 03:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769225591; cv=none; b=Mo27JncE88/H9Odxix4BphJacsYg7Y9qdjcVPTwbZr+q4GLkXeRNPrme6nTOZ6rXq9GAfJAv7xzFcKSjsPHGHnG7Iwc/YmY3q7c9JVLy5D2/R/Xs0go8+6DNw9LAqo1LKV68GJi3cpCVtvN9OGaqyDw+F1O0HmtcsATXGUBpQrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769225591; c=relaxed/simple;
	bh=hiIpT3trYm3UFeAi+Ivpk1TCrDPx1rTtI+5jR2LaH1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBG/k4vJW+Qv7arD2QOf0MHoGk9tAC3YlwSegYMqpc70TuST+x//T9Odxh+fDFUGBusbuD94UQdDc0NPjAV26bVubQRv4jODFMetoRMtTpHfd/nOKEdBBYYXyhoCu1hS7rGrmr2VrNYo4jxaoRfdRYQnNNq4ciAE9z8gWTPTUf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7EoH3Xe; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7EoH3Xe"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so1055772a12.0
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 19:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769225590; x=1769830390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sguImxus6ArC1Mtelx9uzhpdKAYVx6JRUGEnc74urEw=;
        b=l7EoH3XeR8u2n/jPQLVRF8V5OMoNT5YPvHsjivz565/15noL6EOR+3C3qMYTW9//tV
         +dKqHE6N9ZfhSMCfn07rjaLFHO09kEy0RUqlt8zpGLRk7FsGCmJac8bETSes9zLKKqZ6
         Y+MHlT4IXt/6nNjQr9kIExam+LaBKm8PL3yAJs8P6WrbwlACsjhsc6jbueEr/3ic+wbL
         Wzzid8f/n2s4QxP/GTaZo1i/cUnW4BiNiPHl6CTVCFShs6kyZCbbZ5RbO95JvZ33AU14
         ntcm27m1pu3VKxpB4M+d9IdCRRHwMf87NzGjJZwXKLAGZ/+t3X5wQWY+GmM78+9tfwge
         UMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769225590; x=1769830390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sguImxus6ArC1Mtelx9uzhpdKAYVx6JRUGEnc74urEw=;
        b=M5IlzKLrCR+1NlpR7trOJiWd41RT1BfiMwhMPFn5HY+h/eR+DjWBGqGv3PeqXLexhu
         bGX9iz7el2NHs5nawl4QZm+HHwbOsyrSD3XEkg3b6abRNzqC2EjRiUEj0CSH/PTYW8Yx
         aTS1Vour0Ey21ZLsindbFsxRyxbEJI783Pw/lF9MPlIFW7Q28RIPomkck7EnRqepphFn
         md1AL5Cg1ta6jnTGjl36QfYSLq5bQJifh4Mf3j9I5hHvtCXc0exrQkcDAvs0XyFxpzlq
         O33YK56BFONgFLUFmti90rs6qaL82h9tKErsbnNkzkXfQafJrpTcX5zHeE75UVbewzxR
         GBIg==
X-Forwarded-Encrypted: i=1; AJvYcCV7LvvNdqCElHf+OHPZ/LRaJqFZSiqDufplnMMjL1rPT4eL3dG0U/dmLqZPN3TDq8VFYD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+uYdPive15H9NjHrO5F2bGnveCZ8sDbW1KQgRzJE/uJyoiklr
	XWh5vBOkNPrDhZvSyF+nUSnc3pXec5g6qaQo5R5RlXqI+wEoZ1S2K2Uo
X-Gm-Gg: AZuq6aJQJn1+LCEUkc7SQRyri8fDHynG/GBDu5fTldE7iNsEqe98XyMC7ORrEEZTtGS
	3sPhqS4GTLHmuuToV6xcF1lWuOpGFqxLgSlKXAZA3GtyFWAbviW6bNE4aec2KR4zlrj+tJ3OWJl
	J/Xvj/NelIQ6TN5ucGku+eRs9TDoGs9bT0OD1OEzs6PjbRLZHU/EAi0JfpiN1Klz8buUW5uOvrw
	kYbOLZRi7E2VAWw5xg/FzqvCqXCKRVC/tu3MupkayGjdPbf7zUStH2Uc1jDfuDm9j9hvnURYXPw
	zXvmetcBSl1WdBsi1VplsGpn4Jc4AM5NXvV3wlNycnOT5weigfek0L1p3ZXIvPV+IOkrvR57XLU
	dmxXH/fbJt/y56bzI7krDMDarV8CH5zh+8u+tTbXEsSbHzQ/UIhv8N4v9KdOBfkqVvjB/CnwoQ2
	C1XiczUHpc
X-Received: by 2002:a17:903:2351:b0:2a7:5ed3:ba88 with SMTP id d9443c01a7336-2a7fe628b45mr51932365ad.29.1769225589577;
        Fri, 23 Jan 2026 19:33:09 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcddb0sm32539805ad.38.2026.01.23.19.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 19:33:09 -0800 (PST)
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
Subject: [PATCH bpf-next v12 11/13] selftests/bpf: test bpf_get_func_* for fsession
Date: Sat, 24 Jan 2026 11:31:17 +0800
Message-ID: <20260124033119.28682-12-dongml2@chinatelecom.cn>
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

Test following bpf helper for fsession:
  bpf_get_func_arg()
  bpf_get_func_arg_cnt()
  bpf_get_func_ret()
  bpf_get_func_ip()

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../bpf/prog_tests/get_func_args_test.c       |  1 +
 .../bpf/prog_tests/get_func_ip_test.c         |  2 ++
 .../selftests/bpf/progs/get_func_args_test.c  | 31 ++++++++++++++++++-
 .../selftests/bpf/progs/get_func_ip_test.c    | 14 +++++++++
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
index fadee95d3ae8..96b27de05524 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
@@ -41,6 +41,7 @@ void test_get_func_args_test(void)
 	ASSERT_EQ(skel->bss->test4_result, 1, "test4_result");
 	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
 	ASSERT_EQ(skel->bss->test6_result, 1, "test6_result");
+	ASSERT_EQ(skel->bss->test7_result, 1, "test7_result");
 
 cleanup:
 	get_func_args_test__destroy(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
index c40242dfa8fb..7772a0f288d3 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
@@ -46,6 +46,8 @@ static void test_function_entry(void)
 	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
 	ASSERT_EQ(skel->bss->test7_result, 1, "test7_result");
 	ASSERT_EQ(skel->bss->test8_result, 1, "test8_result");
+	ASSERT_EQ(skel->bss->test9_entry_result, 1, "test9_entry_result");
+	ASSERT_EQ(skel->bss->test9_exit_result, 1, "test9_exit_result");
 
 cleanup:
 	get_func_ip_test__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/tools/testing/selftests/bpf/progs/get_func_args_test.c
index 5b7233afef05..8ecc5f339552 100644
--- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/bpf.h>
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <errno.h>
@@ -165,3 +165,32 @@ int BPF_PROG(tp_test2)
 
 	return 0;
 }
+
+__u64 test7_result = 0;
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test7)
+{
+	__u64 cnt = bpf_get_func_arg_cnt(ctx);
+	__u64 a = 0, z = 0, ret = 0;
+	__s64 err;
+
+	test7_result = cnt == 1;
+
+	/* valid arguments */
+	err = bpf_get_func_arg(ctx, 0, &a);
+	test7_result &= err == 0 && ((int) a == 1);
+
+	/* not valid argument */
+	err = bpf_get_func_arg(ctx, 1, &z);
+	test7_result &= err == -EINVAL;
+
+	if (bpf_session_is_return(ctx)) {
+		err = bpf_get_func_ret(ctx, &ret);
+		test7_result &= err == 0 && ret == 2;
+	} else {
+		err = bpf_get_func_ret(ctx, &ret);
+		test7_result &= err == 0 && ret == 0;
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index 2011cacdeb18..bd7598a037cd 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -103,3 +103,17 @@ int BPF_URETPROBE(test8, int ret)
 	test8_result = (const void *) addr == (const void *) uprobe_trigger;
 	return 0;
 }
+
+__u64 test9_exit_result = 0;
+__u64 test9_entry_result = 0;
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test9, int a)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	if (bpf_session_is_return(ctx))
+		test9_exit_result = (const void *) addr == &bpf_fentry_test1;
+	else
+		test9_entry_result = (const void *) addr == &bpf_fentry_test1;
+	return 0;
+}
-- 
2.52.0

