Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620797B3FA
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 22:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592737; cv=none; b=MieywzS0m7+OaBBti6eAeLjhPtVdft0/H4hoscg17MR3z7gBJj3oQ8yg5mzIcNZADrl7VyFqO2q/+Gktm27DUqBSGBfqn8o5AGDAGc84C6e7Y7Yln+RG/h3XvAsiOXDGhCmjQ6AZd6aQx8DD42Fjk/JG0poe5ge6lqBeOIN5HYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592737; c=relaxed/simple;
	bh=zV/RB5EXo6qwUaRe+c4r7c329aduzNSbkkEXrlo/8L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCfvzeFnNV8KehD1kv8rBKQOShD3fiI7E9w0NMfWewTmP87yVis3CodJLCQ2HwloDzyk/ZwKWVmOMxVR9NdhavHG8jNYJfFtSPr+jKqkoR3+VvdFWY1CVAOY2TBNqHemhKQpbq0JbwL4PbMTsDG+WwV/gBFwbTnadVqjngVA3z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mB0b8fm6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mB0b8fm6"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4429c556efso687871366b.0
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 14:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709592733; x=1710197533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ki6OFj/2RK5ad0QaqWrtytsE2QFidQdKKWOOEY5Z/2E=;
        b=mB0b8fm6miW8L+Ce5encvsLyBAcu6fJ29eEHyOaxBBgzuLg5xzsIn6noK0Z7CHoK+7
         UFB0yWDn8BY60qwR8FqR2vdDwOpqZ0U7l3bTW8A2++1rmxZ2G91Rux7k8sC3qVgNjXPK
         PtHeNud1ITbYjth2aZOA4Uwee21boazdZnGQFij+RBZX9cmLDtywkPAh73XRoZkI2hol
         f0vsbgTgtJpEcToEnP1Kc0/2+mZCsewdLjtmawaUDPzl0Wmi8gj9DO7QRr/lDFRXVJdk
         8OaRjxreToKfud3yoM36MoPEcdC6GAfg55UKvdYVyhR+MvMU8TQ6GSMLGVX0WiEdEM4F
         2MDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709592733; x=1710197533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ki6OFj/2RK5ad0QaqWrtytsE2QFidQdKKWOOEY5Z/2E=;
        b=Dp/fleSsLnUHqELLz3AG1CUyeqSNeOOA3e34SEfcCgnFa5YqU33a0Nuc7gbzHr10Xl
         EKXmb33PQ3nbPG2faHdZ2TKl9vwmSM0MWkmX3TBpCyfieOSDps9OhM+FU7ivYCgCAkfy
         EC8rcqTkJxBN7/+m58RFNSk8E2FBMCbxJDML06+TFK25vCHa5Iv8gr7w/hJx+g9LbInD
         1JgIh1ACvixJ1aRIWa5EkpF+egv5tEfqLx+nkFZRnUcXsDO7ZPxHv+6L4tEdbnc5zDMe
         du1ZxGUfXUuKkoMOywaho5W4w7i9HBys3krcRj9ylqLFmWpMEoqHQ6AlzhTvvEzgPexm
         LcmA==
X-Gm-Message-State: AOJu0YxnsoysLCyXXIkZ/suhJzb6PMTLJonxxd+JkBbux+me472PfxMW
	5z+/TzWJJk4Ztg5rdWEfFMKmnJtXYuM+1Zgc5ZjeeV89QiQJDSiC2A84cmXC
X-Google-Smtp-Source: AGHT+IF6ZK0SDXC3AUhJHop1L8t35+/RhnrMwrzmNxq3QXHt2ZYUVI6UhogcSbIK7+7QNOonBTBrbg==
X-Received: by 2002:a17:906:b80b:b0:a45:1c4b:54eb with SMTP id dv11-20020a170906b80b00b00a451c4b54ebmr3574310ejb.3.1709592733300;
        Mon, 04 Mar 2024 14:52:13 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qx22-20020a170906fcd600b00a4302eb448dsm5315499ejb.134.2024.03.04.14.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 14:52:12 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	sinquersw@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 05/15] selftests/bpf: utility functions to capture libbpf log in test_progs
Date: Tue,  5 Mar 2024 00:51:46 +0200
Message-ID: <20240304225156.24765-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304225156.24765-1-eddyz87@gmail.com>
References: <20240304225156.24765-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several test_progs tests already capture libbpf log in order to check
for some expected output, e.g bpf_tcp_ca.c, kfunc_dynptr_param.c,
log_buf.c and a few others.

This commit provides a, hopefully, simple API to capture libbpf log
w/o necessity to define new print callback in each test:

    /* Creates a global memstream capturing all output passed to
     * libbpf_print_fn.
     * Returns 0 on success, negative value on failure.
     * On failure the description is printed using PRINT_FAIL and
     * current test case is marked as fail.
     */
    int start_libbpf_log_capture(void)

    /* Destroys global memstream created by start_libbpf_log_capture().
     * Returns a pointer to captured data which has to be freed.
     * Returned buffer is null terminated.
     */
    char *stop_libbpf_log_capture(void)

The intended usage is as follows:

    if (start_libbpf_log_capture())
            return;
    use_libbpf();
    char *log = stop_libbpf_log_capture();
    ASSERT_HAS_SUBSTR(log, "... expected ...", "expected some message");
    free(log);

As a safety measure, free(start_libbpf_log_capture()) is invoked in the
epilogue of the test_progs.c:run_one_test().

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_progs.c | 57 ++++++++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h |  3 ++
 2 files changed, 60 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 808550986f30..698c7387b310 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -683,9 +683,65 @@ static const struct argp_option opts[] = {
 	{},
 };
 
+static FILE *libbpf_capture_stream;
+
+static struct {
+	char *buf;
+	size_t buf_sz;
+} libbpf_output_capture;
+
+/* Creates a global memstream capturing all output passed to libbpf_print_fn.
+ * Returns 0 on success, negative value on failure.
+ * On failure the description is printed using PRINT_FAIL and
+ * current test case is marked as fail.
+ */
+int start_libbpf_log_capture(void)
+{
+	if (libbpf_capture_stream) {
+		PRINT_FAIL("%s: libbpf_capture_stream != NULL\n", __func__);
+		return -EINVAL;
+	}
+
+	libbpf_capture_stream = open_memstream(&libbpf_output_capture.buf,
+					       &libbpf_output_capture.buf_sz);
+	if (!libbpf_capture_stream) {
+		PRINT_FAIL("%s: open_memstream failed errno=%d\n", __func__, errno);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* Destroys global memstream created by start_libbpf_log_capture().
+ * Returns a pointer to captured data which has to be freed.
+ * Returned buffer is null terminated.
+ */
+char *stop_libbpf_log_capture(void)
+{
+	char *buf;
+
+	if (!libbpf_capture_stream)
+		return NULL;
+
+	fputc(0, libbpf_capture_stream);
+	fclose(libbpf_capture_stream);
+	libbpf_capture_stream = NULL;
+	/* get 'buf' after fclose(), see open_memstream() documentation */
+	buf = libbpf_output_capture.buf;
+	bzero(&libbpf_output_capture, sizeof(libbpf_output_capture));
+	return buf;
+}
+
 static int libbpf_print_fn(enum libbpf_print_level level,
 			   const char *format, va_list args)
 {
+	if (libbpf_capture_stream) {
+		va_list args2;
+
+		va_copy(args2, args);
+		vfprintf(libbpf_capture_stream, format, args2);
+	}
+
 	if (env.verbosity < VERBOSE_VERY && level == LIBBPF_DEBUG)
 		return 0;
 	vfprintf(stdout, format, args);
@@ -1081,6 +1137,7 @@ static void run_one_test(int test_num)
 		cleanup_cgroup_environment();
 
 	stdio_restore();
+	free(stop_libbpf_log_capture());
 
 	dump_test_log(test, state, false, false, NULL);
 }
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 80df51244886..0ba5a20b19ba 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -397,6 +397,9 @@ int test__join_cgroup(const char *path);
 		system(cmd);						\
 	})
 
+int start_libbpf_log_capture(void);
+char *stop_libbpf_log_capture(void);
+
 static inline __u64 ptr_to_u64(const void *ptr)
 {
 	return (__u64) (unsigned long) ptr;
-- 
2.43.0

