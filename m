Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F583515D4
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 02:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792378415; cv=none; b=p+uoOpGUIBfPH5f0E6/I4cY7+/nIt1CxnIIVzyzOYKQUNJ1uh8cZgRqn/ygNJ7+ChP5tkuliBa/99wvvRh37692bn/Q6QXugAVUWtCb6VNfH8fGMJn11rXPIGO7YVtl3bwemrBrKLWqQ+8kay98Wa53VKpMZB0ulQINZB6vQ+MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792378415; c=relaxed/simple;
	bh=g88Hr+cEKlwVOqv7qPM1EbXDQsicsjNoVYFMbSNf9zQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XeEIAIBjOF3Mqw2qZ2tXKobfHQ9FMu40eDbt4fKF7/oAsngJcxTnfglzrz4vYTBpwbwRifVIcojJfqgOqLgT01ahIuxuPnvnBho6X64+LNvbVT4POSs6iOVV8sbmFtaR7Ho7N/OrsxQX+lQ8Y+LXmZzddV228CXAEL1d3rU9aNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m83MqevY; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m83MqevY"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-15dd124bbe7so3041974c88.1
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 19:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792378412; x=1792983212; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J0S5EuaZLa4NVRw+Z41PzbyY1diIZpVZR+4Fb+cEP44=;
        b=m83MqevYkRZi1/BTULFjPZmNf611z3au1jwKuJ4GPxbkpkfNb7EdsMbPxhO4zhFnbH
         28TB65ZWxZQ2Kx8lRGB+KSYQTegH21INQad8fOngCdCdQOZ38YFpIQ0jk/rozZ0r7tkr
         8okuq49DDjroAjZo+7WsJHVPPvoYAt2JOQzClcVPje6aILhJoV88ZS4+/CIwdnPhQ2jS
         Gta9QBru8jjeH5BO7cVPlLhErz1tdvYQiznwq9a8DuYJgOXiewxi4+G3NLFxMntWYXGk
         mL8maGLwSsaGD8yM8Txf2cR/rMKelXVQxvMQS+zFTwjhZugABvTH8OmJThLQcpQUMrkK
         buPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792378412; x=1792983212;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=J0S5EuaZLa4NVRw+Z41PzbyY1diIZpVZR+4Fb+cEP44=;
        b=bqpMJXmbLTyG6g8e4opNcX5+GVX+T2fsTBa6+Ci5+4pUFlNE0/Tp902w9ISUKrfl0D
         KPrq5cgBe4jQxzlpIc0mf5yctBsaF10SOjv5eu7/ducekQ/l1JbTsgQfV8l/V53NknIU
         +/HQ8738qiiYeA7LkycUDlXEYgASHatShZbkrSa5d6PiJI6kpXwQATFFKTPxEhHSnOTe
         GfMDaYnsce299t+nALuB2PHYz2bgQ3mTcY0gCQLnCdXyz4cIqXuXi9lz5n+5Fb09Ghin
         JlVxjQPv/jBaeJCO6FupdIqEaTKVzaGsS2KImPm+dF4QGUOf8kLLhg0b86mURMayHRSe
         ZHvg==
X-Gm-Message-State: AFq9FYIXKVeX7JfD/arSzQxLa9DqxZo7t/BEfWFPhEnrm1i/o9pv7KZ2
	sEZKI6tRvIvMwdtDu5813yTXemFsLc291weui/ZjrTNkUbR+95mjqB06
X-Gm-Gg: AYBFou0/ll7JdrPL3bsY78zwPZneTHtEenjGdzsp/D/Sx1nnLcSBr3EU9Ylj6YBgv3E
	j10SvmX33k6GtjqQFP6otZ+ekKqnxt+fPeQwMXecJ0tLH3a4IkabNazr5SKuD9UcnG/6bLImwrq
	hqUlW7zMXLuiGPIXLtS+q9s8iv0aG9fXxXNZZ6yn9tD8svGxwRPnBYoiO6UrCRBXCoG7T3uKC3Q
	phXcqAO51OQQgPCecg95Oqfs6l/e89XHgrY7rc3HVvoc1wM3QurC6+FS3gqosf6ILUpLrDm6JfQ
	F+zirYEdzLfYj3Ld4Ub02hyLyEUx9Q03Ix0xfhK5WY5oOJli3zJBQ+7zzsZmn1jqXbQq96Z4T6g
	WdAy3/fTLExABz7DaHJ7Xudul2Gl6sSBYIoY0CDI9kqsnfRbmCVVWZ63dPMfpALvQufM6GQ7twE
	pg7q5ShR0cgxywL+L0CEDCSnF1AEPk+nb63qc6F61u04qcn1BUij7EEaPwUOFvtTdJlA==
X-Received: by 2002:a05:7023:d0b:b0:186:4a57:94e5 with SMTP id a92af1059eb24-1864a5796e5mr9180051c88.34.1792378412241;
        Sun, 18 Oct 2026 19:53:32 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c5cb39esm26099277c88.22.2026.10.18.19.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 19:53:31 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 19 Oct 2026 10:53:25 +0800
Subject: [PATCH bpf-next v3] selftests/bpf: Run the enable_stats program
 with BPF_PROG_TEST_RUN
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-selftests-bpf-enable-stats-inflight-v3-1-e7728f5b061a@gmail.com>
X-B4-Tracking: v=1; b=H4sIACWG1WoC/5XNTQ6CMBAF4KuYrh3Tn1jBlfcwLkqZwiSlkLYhG
 MLdraxY6vLNy3xvZQkjYWL308oizpRoDCWo84nZ3oQOgdqSmeRSC84rSOhdxpQTNJMDDKbxCCm
 bcqDgPHV9Bmxdo7SRFXeKFWmK6GjZV57s+xZwyexVmp5SHuN7n5/F3v+1NAsQwG1TS0Rpdase3
 WDIX+w47P4sj2b9mymLqWuBqG41XoU4mtu2fQCghB8xNAEAAA==
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

enable_stats attaches its program to sys_enter, so every syscall of the
system runs it. Once the program is detached, the test compares its
run_cnt to the number of runs the program counted itself.

Detaching doesn't wait for the runs already started on other CPUs, and
each of them increments count before run_cnt. With other tests making
syscalls in parallel, the test reads run_cnt one run behind count now
and then:

  test_enable_stats:FAIL:check_run_cnt_valid invalid run_cnt stats

Run the program 1000 times with BPF_PROG_TEST_RUN instead of attaching
it, so that nothing else runs it and both counts are final when the test
reads them.

enable_stats run 100 times with 32 processes calling dd with bs=1 in
the background, on a bpf-next kernel with KASAN enabled, x86_64 VM with
32 vCPUs, before and after this patch:

            before                                after
  outcome   3 of 100 failed (check_run_cnt_valid)   0 of 100 failed

Fixes: 31a9f7fe9337 ("bpf: Add selftest for BPF_ENABLE_STATS")
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
V2 -> V3:
- Run the program 1000 times and keep getting the info as in v1, as the
  loop of v2 never ends if the kernel counts the runs but not their
  time (Alexei)
- Add before/after data

V1 -> V2:
- Run the program until its run time shows, as a single run can be
  shorter than the resolution of the clock (Sashiko)

v2: https://lore.kernel.org/r/20261009-selftests-bpf-enable-stats-inflight-v2-1-691ee379e511@gmail.com
v1: https://lore.kernel.org/r/20261008-selftests-bpf-enable-stats-inflight-v1-1-0cb92ee2c6d3@gmail.com
---
 tools/testing/selftests/bpf/prog_tests/enable_stats.c | 15 +++++++++------
 tools/testing/selftests/bpf/progs/test_enable_stats.c |  2 +-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/enable_stats.c b/tools/testing/selftests/bpf/prog_tests/enable_stats.c
index 75f85d0fe74a4..5b9cc119d072d 100644
--- a/tools/testing/selftests/bpf/prog_tests/enable_stats.c
+++ b/tools/testing/selftests/bpf/prog_tests/enable_stats.c
@@ -5,10 +5,11 @@
 void test_enable_stats(void)
 {
 	struct test_enable_stats *skel;
-	int stats_fd, err, prog_fd;
+	int stats_fd, err, prog_fd, i;
 	struct bpf_prog_info info;
 	__u32 info_len = sizeof(info);
 	int duration = 0;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
 
 	skel = test_enable_stats__open_and_load();
 	if (CHECK(!skel, "skel_open_and_load", "skeleton open/load failed\n"))
@@ -20,13 +21,15 @@ void test_enable_stats(void)
 		return;
 	}
 
-	err = test_enable_stats__attach(skel);
-	if (CHECK(err, "attach_raw_tp", "err %d\n", err))
+	prog_fd = bpf_program__fd(skel->progs.test_enable_stats);
+	for (i = 0; i < 1000; i++) {
+		err = bpf_prog_test_run_opts(prog_fd, &topts);
+		if (err)
+			break;
+	}
+	if (CHECK(err, "test_run", "err %d\n", err))
 		goto cleanup;
 
-	test_enable_stats__detach(skel);
-
-	prog_fd = bpf_program__fd(skel->progs.test_enable_stats);
 	memset(&info, 0, info_len);
 	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 	if (CHECK(err, "get_prog_info",
diff --git a/tools/testing/selftests/bpf/progs/test_enable_stats.c b/tools/testing/selftests/bpf/progs/test_enable_stats.c
index 1705097d01d7b..e28d674fc77ac 100644
--- a/tools/testing/selftests/bpf/progs/test_enable_stats.c
+++ b/tools/testing/selftests/bpf/progs/test_enable_stats.c
@@ -10,7 +10,7 @@ char _license[] SEC("license") = "GPL";
 
 __u64 count = 0;
 
-SEC("raw_tracepoint/sys_enter")
+SEC("raw_tp")
 int test_enable_stats(void *ctx)
 {
 	__sync_fetch_and_add(&count, 1);

---
base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
change-id: 20261008-selftests-bpf-enable-stats-inflight-edfb36a280f3

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

