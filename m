Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF619364038
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786781983; cv=none; b=so3TlPD53/reMm+u84jnkagdITnzROQtTLohqDnm+mdz+aXzVx+zo9qACA6Sqk1jH0QaRtX73ZVer89Sudo9FZKlgIVmVGtUplbZDLjszDNUhFoYNdNsLrE8KlsxgxUIbNXMsSTo+Dpv6CH/6NDELkFgU2rYu/JB2OHQo+vbKI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786781983; c=relaxed/simple;
	bh=00BAyC9l2NDWsNEOuGALJvAkiG/r86tPbO3/OERtUx4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Vh4SBKyp7hKuc2X8N877bovUnGZPq1liPhRuHsaxWc2su3VKEYQYwk9Mb1Zwq95TObdkMzjrIzxy6fFXT3AMPAml1hgKz8J6oLyf+cpc+70zKNTucGYkaBB6cpkfk/2a2uc7rxXu7dn1OD2hVIeIToTTmHHXAs8e55imUsBx3ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=FycF1dey; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="FycF1dey"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1786781974;
	bh=mkPUMPo3G1CDGU17bWF0zBBqV9vQekXFKd3qbFyhYPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FycF1deywBgqcljvoV3C2swk24sSpy6BduTru123tH2G+dsCX3h3/XDgG/4cyxJ8e
	 s0JpXyfjIgcmG0t+7xtLWgyJrIoLAxoMKkczQ6ri+XR76CGy85jFaw5H8lCs95FaP1
	 APaM9EBg4VjtdZBYk8g1IJRizBv7uZEHW2VNLPvg=
Received: from localhost.localdomain ([180.153.160.8])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 4D51223E; Sat, 15 Aug 2026 16:19:21 +0800
X-QQ-mid: xmsmtpt1786781971tji7hr0d8
Message-ID: <tencent_E2FD478B453F740591952AA7A502D4FCA609@qq.com>
X-QQ-XMAILINFO: Mv+0OqVCSt4ET/vJpRXQWLjZwJSaXqhxHmAruZOuABqR37CXO9i4TsMY/gdwN4
	 HQHSS1l39cgQeM6zHqoYtcjNiExOrSxFCdvD1VBwlexilrqCBOj32Jl46FU/2l13041/dNDhX4p+
	 DD8zG/q+gVEeMAChAYbkO8DdpcQZ3zO0nf+UA7xyjLBMKOpXFW5IOlBhlNNoYVNiOGMfsBmYzGpg
	 EhIOl0+semotNZthsmYeqj3+6oKfb1xAJNiRtwttFoHNaDFw2WCU/gW3Z7fO8o58IZsWWrz9gQ/4
	 2fx85YCN14hGQCC3a2Gzlkt11l/V7OlNxoubMP1Terf89aTLRm2TGz3hy8RGyDya3PM4pJJk/kbz
	 MvZu8Q7O4f3tjIvXKcRSSxHEWIGRfawcuUKjtZTbKzHmq/hU06yAKyAlotD2ldXk/wDT64U/EP9k
	 nqEJUASuEwXe7OvaGJzw/LsdrT76OUFXb0y+fYmoYT+e+mze8jfwxpCvOEHunrV0m4oLZhbzz/Il
	 otBhbXyG21TEj9kjAqPNdip9zW/fy07Y57Q+fgTJ2O0D1n3htV3MEo2aaXCDJajNlxIFZrGplXTE
	 NR9k0ZA5NN/7AklHs/TAh9XDQx8Ho9niHC0MfRRy4G0OWlWLLHd9IWGw/NgeItbJjZONT4+YDi0d
	 wjedRoIeaF4m12ovXKFxJO+oYeIJmmcUOmO9fvgs7fKgXqIpNsdt4gaHp8EvibQ6u3CRWS++kDxY
	 3IAsVi8rxqvcbJ5NuIDq0vOGh07H9ODFciBaOP0yda78x+q8tIyapwrzSPLcvUenC3UFASkUIBjA
	 adcSX1u31bZiJdkjDd4Rw7Z+ZOLX0hG5kQEZsxhJBSGYsz9yU63FYsoNI5ytVS/y/CNKOPq2EC6x
	 wbqX/yWPpc99DFwh12TZQU/vQizecvGFBlAVZMnryyQ5zlLvoKoLgKPWUgtvsS10SAoroy2XXjoA
	 qX2aPAX6wwvmAIOi1uKJ+1OlmWLkVO8ADuKwOmJOkXxd/Vn5QfUqlsumfxHENzIOZRDpmmKHFeFJ
	 72o677VYf3+P/Cm5s/GRJ6MchJc/MqRzwl8Lr9U938ijqYcN5OHwFL2xm17zXkUJ4P+GOdneThNh
	 keKp5AWrBDmN9chHg2STBQkJnSAg==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Jianlin Shi <shijianlin11@foxmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
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
	emil@etsalapatis.com,
	memxor@gmail.com,
	pulehui@huawei.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 5/5] selftests/bpf: cover stream capacity and partial read edge cases
Date: Sat, 15 Aug 2026 16:19:20 +0800
X-OQ-MSGID: <20260815081920.609936-6-shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815081920.609936-1-shijianlin11@foxmail.com>
References: <tencent_C919BB32458A4DAD645A68F441345B971E05@qq.com>
 <20260815081920.609936-1-shijianlin11@foxmail.com>
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
  capacity for a subsequent successful write;
- bpf_prog_stream_read() returns the successfully copied prefix when
  the userspace buffer straddles an unmapped page.

Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>
---
 .../testing/selftests/bpf/prog_tests/stream.c | 70 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/stream.c    | 12 ++++
 2 files changed, 82 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
index c3cce5c292bd..3ae98e3c4909 100644
--- a/tools/testing/selftests/bpf/prog_tests/stream.c
+++ b/tools/testing/selftests/bpf/prog_tests/stream.c
@@ -58,6 +58,76 @@ void test_stream_syscall(void)
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
+	ASSERT_EQ(opts.retval, -E2BIG, "oversize retval");
+
+	/* Oversized push must not permanently consume capacity. */
+	prog_fd = bpf_program__fd(skel->progs.stream_syscall);
+	ret = bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_OK(ret, "syscall run");
+	ASSERT_OK(opts.retval, "syscall retval");
+
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
index 6f999ba951a3..6fab9b8b21a0 100644
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
@@ -117,6 +122,13 @@ int stream_syscall(void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+__success __retval(-E2BIG)
+int stream_oversize(void *ctx)
+{
+	return bpf_stream_printk(BPF_STDOUT, _BIG_STR);
+}
+
 SEC("syscall")
 __arch_x86_64
 __arch_arm64
-- 
2.43.0


