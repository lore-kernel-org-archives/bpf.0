Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175D4605CA
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721949; cv=none; b=H9xC6evu0pj7fYyjIPavlCwVy7/vMQQsPwgd0LLnf9yj5ZKBJayPLexNye33GQWrEHaJJ3AxgR928Ti6BNvJFsceLWWjbhq9Pp+f/wEuoLpGJciKDwXBpkeC0MDdu7VM3fxkIjIklS1vlo/FZFZqe2/Cyp2peK9JJfcUluCJ/n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721949; c=relaxed/simple;
	bh=560LnpXJyKDnc+o4x0AOeZKY76rsVdOyjpCP/vzD98o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgAZKEHZGTgtxETMb0W+mRpwmofHTakoJl0xDFzljMWdEiFKuI8HHjaNAVI6raDarLyt0zy3CMGM/5TBmvl7znfVv6pPV7PYq83DKkXMGvZHXSZ4p++vquennvMEzTm1iwf7yGLDe97MzFyiL1+s7N+VLj2qAf7KtNdUHjWUw68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyGmCYJZ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyGmCYJZ"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56781070f38so1210599a12.0
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 02:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709721946; x=1710326746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e69/kZxMiYRBsVrYW+fBLTtqbjlgUyrdHfF7WeGA9BA=;
        b=gyGmCYJZqcs0tCgWJY0GEuFBU/f0gGlNyxYjwLeeZ75MjVVxkKP63/E8n+cg/81VjG
         h0v5g59nvxFQzRkq5CQ4lx/CKpl3vH8oD2PBwOPi533D5V9tjsxwLJrJvoiZsp+INHrz
         +F3PpnOdGxh/mm7LhJ9noa7AbqCtscJyywUqtjKG3h8S47VR8lABsMEcGoJBQjWWET1O
         9LeLrQhaCz6Vu5sjHlQ50qx+1EKa6Q2nuw5+VKOc2HhOw/JdLZI8AVl0BugZfAyIRCZu
         DXHAfEao0CpDHvKjZl7cgd4Szh7TmJf01aPtolLga6NoXEyvY+N81qx4w7RjRPsMcCaZ
         fd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709721946; x=1710326746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e69/kZxMiYRBsVrYW+fBLTtqbjlgUyrdHfF7WeGA9BA=;
        b=uGENYso/PKI2A/7SV/tofoKOTbgIAwrvQVhh++1rMZVAilKEA5S1jsJTvMso9YhRU7
         XIskrMkLQd2XDiKqqhDpMhLhJW7njY99epfoUBOpU+7yoFBDcfQRmyNEXUgsQdmPvRgi
         L1zF/+2jt7ewhZooTKQfe3mjVrBp+h8cah4QcfQvNef57jraHxHpeTbg1WyWvpGKpJ4J
         KLzw++P/Nbe9zJCTiSidjwxH9umr+pKk0vD4xPU/EjzR+miHF9khiddG9XG5nZvTsJAE
         na65Qntf5EzVJuBWChLL/7q9u7QPVHSQrhT759GSVmQTo7h1JBdNzT0R5KR7QNjqoDKi
         O/Jg==
X-Gm-Message-State: AOJu0YzuH5vsBv+zfdRQk3pe78pmri9zwVnK4LveLBgGoClZX3K/qLbE
	Mbuaimc/3kIFFJpLgYUmprvFgB7QC6+cdiCrLgSRED3yc/evz1CM200aXNsl
X-Google-Smtp-Source: AGHT+IE40B4TjvD7zV2IeQ93vEQpvXdFAkQATM0WdHpkHI2wgGVon6p6BxX8lAFf8JIVwcMXCD9VcQ==
X-Received: by 2002:a17:906:8cc:b0:a45:7f61:8940 with SMTP id o12-20020a17090608cc00b00a457f618940mr5537893eje.18.1709721945948;
        Wed, 06 Mar 2024 02:45:45 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906591400b00a3d5efc65e0sm7002450ejq.91.2024.03.06.02.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:45:45 -0800 (PST)
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
Subject: [PATCH bpf-next v4 05/15] selftests/bpf: utility functions to capture libbpf log in test_progs
Date: Wed,  6 Mar 2024 12:45:19 +0200
Message-ID: <20240306104529.6453-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306104529.6453-1-eddyz87@gmail.com>
References: <20240306104529.6453-1-eddyz87@gmail.com>
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

    /* Creates a global memstream capturing INFO and WARN level output
     * passed to libbpf_print_fn.
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
 tools/testing/selftests/bpf/test_progs.c | 59 ++++++++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h |  3 ++
 2 files changed, 62 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 808550986f30..89ff704e9dad 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -683,11 +683,69 @@ static const struct argp_option opts[] = {
 	{},
 };
 
+static FILE *libbpf_capture_stream;
+
+static struct {
+	char *buf;
+	size_t buf_sz;
+} libbpf_output_capture;
+
+/* Creates a global memstream capturing INFO and WARN level output
+ * passed to libbpf_print_fn.
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
+	memset(&libbpf_output_capture, 0, sizeof(libbpf_output_capture));
+	return buf;
+}
+
 static int libbpf_print_fn(enum libbpf_print_level level,
 			   const char *format, va_list args)
 {
+	if (libbpf_capture_stream && level != LIBBPF_DEBUG) {
+		va_list args2;
+
+		va_copy(args2, args);
+		vfprintf(libbpf_capture_stream, format, args2);
+	}
+
 	if (env.verbosity < VERBOSE_VERY && level == LIBBPF_DEBUG)
 		return 0;
+
 	vfprintf(stdout, format, args);
 	return 0;
 }
@@ -1081,6 +1139,7 @@ static void run_one_test(int test_num)
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

