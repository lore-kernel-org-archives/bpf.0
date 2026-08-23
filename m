Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD340330668
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787494695; cv=none; b=EUYVlvzLZfMXfFPDRfbfeoanBzhAkpvcUtRKje5k0QcVKS3DJngEK5Tib39fT5Q79rrCswfnHDzFXrEXX+wbbWsq3kFBrEA3dzGzglBRejlHELQrI+4E5LaExQLco8pK7S78BLwHlC1bZAIB+2UI/o1fX3JYIW8nALHj/GI2ZPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787494695; c=relaxed/simple;
	bh=f45uQTLcoCxQUacMtqdb5ScN6GaILQ79UNqIIFKowz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okxRNndKN/igeNhf3gsf6ppFXrjqIA9weoTWAd5ek6Sg67I3LKIwMcskCcimFY52LqS37/84KSTAg23KMzmOt/DdKO3UsLcD9F0pRP7p/KViJvA9TslihbmXmt3IYzhQjLSQh2l1I7gzEfPF42ttVg0apMW0VQDGSvBpPmkPBE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f7.google.com with SMTP id d9443c01a7336-2d561173f9fso16774495ad.0
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 07:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787494692; x=1788099492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e7oaM6iEIN9zmqUbo7qJbXRXk+4xR9zhjvD2NxdYN+M=;
        b=LuSVSjKdYGU0JNH2yrCfHgj19bYh6Fpzcd2D+rHvE6/eqcmrLHI+/stqwIjZPOYPh0
         T1vvAQjESmBrxBWJQDQ8rHf/raEZknitzeVfn4ZZi+f+7k7NdM6JwMt3xvZEqPaGSl1R
         /RFJ9bI2WpYtt8TBCIucdrY2UP8qOHCE/YmtHYNS8JTXDLoXGUZmBwXXwIOmaaU4v49J
         uLS1toYueqAMwHgN2ALdnqYCBafffvKozyc0i6MSb9N93rdIxKEUPqrFNEqa5jjg0GCQ
         H5jmOxN/acScZZ8/UbIXFuBji4ZDlmkLOluqTczo5rnC3GGR3KLdjVO9muO/T9tu0osL
         TvaQ==
X-Gm-Message-State: AFuF++kuly2LCHOduN51/5QSqCdQQOzIM+7wffDVuQNuMzgfTk0UiYJa
	79iZWt2iCIodjj1GPeFWhQIZHTN1H+xigjPvSXASLGV26Mk+4LoitjomxM7A1tHJX41qL11V
X-Gm-Gg: AR+sD11zCy1bE/hLax2KDp7766VWpjTMuoqtDdiqeeEEJhK8o4vT1esVNqMBBOSLOXx
	HLJqn33PTTBXfG2s21lA9hSvc6qwp+UtyD/H1WAN+5WLw29P+HU78eMqXGmpvJnyeySDtSxzues
	2z2bRUKXQZTIrtxmKW1QkZKQrvXwhXHmElURm7HaEUtB966fdp4I4Edt+i8mtsLbHUi4Yb5d0fr
	xvnuIYUYjEvGPGN+MFvm93YkTPVJ1RTMPOMRTRa9/Ckx3Nn0tbCV9j+5A3lipo8alzYZ1vvMkfu
	SkyR2yObSkQEkHv9yVBpJKSONqSEPpDPOmo1Q+Vnz58iGnsJuZp9unYmpWKsTY+3LdB9fv/qHlD
	iXiYrLCRrBinqIPMQftAYvtQvZjNskQ+kO6fWM8VGplEQD1p8NDYodDUt0YDKyFBBX9EOJbkkIw
	FMr9q1nZHxGvz+vYRG56Es9R/tsNWvwTOYtWOu7KSyxo/sQx90+3aN+MKQz5wn/gRrgb7xtaWND
	QwcRtBtyhBUPnSIIPE=
X-Received: by 2002:a17:902:e784:b0:2cf:ba10:6d6 with SMTP id d9443c01a7336-2d64af6f8dbmr368136745ad.4.1787494691824;
        Sun, 23 Aug 2026 07:18:11 -0700 (PDT)
Received: from localhost.localdomain ([180.153.160.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676791d44sm9944575ad.24.2026.08.23.07.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 07:18:11 -0700 (PDT)
From: Jianlin Shi <shijianlin11@foxmail.com>
To: bpf@vger.kernel.org,
	memxor@gmail.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@chromium.org,
	sdf@falco.dk,
	haoluo@google.com,
	jolsa@kernel.org,
	emil@tsalapatis.com,
	pulehui@huawei.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 5/5] selftests/bpf: cover stream capacity and partial read edge cases
Date: Sun, 23 Aug 2026 22:17:28 +0800
Message-ID: <c5a79efbd3cb52cc0668ab50db5379c907cfe6a6.1787492521.git.shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787492521.git.shijianlin11@foxmail.com>
References: <cover.1787492521.git.shijianlin11@foxmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add coverage for the stream fixes requested on the capacity rollback
series:

- oversized bpf_stream_printk() returns -E2BIG and does not leak
  capacity for a subsequent successful write on the same program;
- bpf_prog_stream_read() returns the successfully copied prefix when
  the userspace buffer straddles an unmapped page.

Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>
---
 .../testing/selftests/bpf/prog_tests/stream.c | 65 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/stream.c    | 18 +++++
 2 files changed, 83 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
index c3cce5c292bd..87170dcad3ad 100644
--- a/tools/testing/selftests/bpf/prog_tests/stream.c
+++ b/tools/testing/selftests/bpf/prog_tests/stream.c
@@ -58,6 +58,71 @@ void test_stream_syscall(void)
 	stream__destroy(skel);
 }
 
+void test_stream_oversize(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct stream *skel;
+	int ret, prog_fd;
+	char buf[8] = {};
+
+	skel = stream__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.stream_oversize);
+	ret = bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_OK(ret, "oversize run");
+	ASSERT_OK(opts.retval, "oversize retval");
+
+	/* Oversized push must not permanently consume capacity on this prog. */
+	ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDOUT, buf, sizeof(buf), NULL);
+	ASSERT_EQ(ret, 3, "bytes after oversize");
+	ASSERT_OK(memcmp(buf, "foo", 3), "payload after oversize");
+
+	stream__destroy(skel);
+}
+
+void test_stream_partial_read(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct stream *skel;
+	int ret, prog_fd;
+	long page_size;
+	char *page, *buf;
+	char rest[8] = {};
+
+	skel = stream__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.stream_syscall);
+	ret = bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_OK(ret, "ret");
+	ASSERT_OK(opts.retval, "retval");
+
+	page_size = sysconf(_SC_PAGESIZE);
+	page = mmap(NULL, page_size * 2, PROT_READ | PROT_WRITE,
+		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (!ASSERT_NEQ(page, MAP_FAILED, "mmap")) {
+		stream__destroy(skel);
+		return;
+	}
+	/* Leave only the first page mapped so a straddling copy faults. */
+	ASSERT_OK(munmap(page + page_size, page_size), "munmap second page");
+
+	buf = page + page_size - 1;
+	ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDOUT, buf, 3, NULL);
+	ASSERT_EQ(ret, 1, "partial bytes");
+	ASSERT_EQ(buf[0], 'f', "first byte");
+
+	ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDOUT, rest, sizeof(rest), NULL);
+	ASSERT_EQ(ret, 2, "remaining bytes");
+	ASSERT_OK(memcmp(rest, "oo", 2), "remaining data");
+
+	munmap(page, page_size);
+	stream__destroy(skel);
+}
+
 static void test_address(struct bpf_program *prog, unsigned long *fault_addr_p)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index 6f999ba951a3..9b97f5e01b83 100644
--- a/tools/testing/selftests/bpf/progs/stream.c
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -36,7 +36,12 @@ struct {
 } array SEC(".maps");
 
 #define ENOSPC 28
+#define E2BIG 7
 #define _STR "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
+#define _X64 "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
+/* 1024 bytes: truncated by bstr_printf, must return -E2BIG. */
+#define _BIG_STR (_X64 _X64 _X64 _X64 _X64 _X64 _X64 _X64 \
+		  _X64 _X64 _X64 _X64 _X64 _X64 _X64 _X64)
 
 int size;
 u64 fault_addr;
@@ -117,6 +122,19 @@ int stream_syscall(void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+__success __retval(0)
+int stream_oversize(void *ctx)
+{
+	int ret;
+
+	ret = bpf_stream_printk(BPF_STDOUT, _BIG_STR);
+	if (ret != -E2BIG)
+		return ret;
+
+	return bpf_stream_printk(BPF_STDOUT, "foo");
+}
+
 SEC("syscall")
 __arch_x86_64
 __arch_arm64
-- 
2.43.0

