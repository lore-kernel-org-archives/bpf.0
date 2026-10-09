Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A26310784
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 02:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791511502; cv=none; b=CfQtSOW5ilAuCCZgyVraMo0QqcP5TOF3q1vG3iCB4E5J7LInB58rix+TdWxfWq8lq49pv+Rgz3pt1Wx//C7i7h4rPRPjxOBO8X5SvUrtPWyHq9jbxyj4+Lc3KIM4OBTiN3l9fZAzn4klxg/8QA6nymgmnCK/D1EsTe77CDxHudY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791511502; c=relaxed/simple;
	bh=3PzxtR+1mBAdyRx4eV1Dnd14mhtH+QhtatlKw0yvMyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UjeyOGMpA5R83GE3KuwlZ8MDSgpc7ZZJEWDE6A19YmJOCWBwGLD+sJcMIDd0If3Zbe43hAfuDPSEsCUkUW/ejMvsTEbvbj5RWbS3KT8JWSRYQTZCcsLdLsiULKVtRVWLAxGrLYJluZTEQZQ5I2+s6teNsC9gFh+kHnKsa5aYaHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Am25ouR6; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Am25ouR6"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-351f7a0b13bso789676eec.1
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 19:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791511500; x=1792116300; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QVVHBgvK6OKW53OVYnJLSJofdOQSOkfgS/m6Zeijg8o=;
        b=Am25ouR6zcE01ixQy9ZJkl9jx274CIOw1FwoDqXGvDxoEp3ZVxjyg9A6mdlG+4xtdc
         JsLef885thzm7oWDKjK991CgsFL5hZxyzqpYW9FiYEEMidyUX3QOXGjHnXicINph7LbX
         RliNBaFESkzTIjbwY1pbnV2j4H25iUqHghSO6VpHdN96qPb1jlps1Jok+bc2bbnKImw1
         oKUx+Gg7m+Dw624XsjJGtM93pnqTo8GQu8GFHv00SxLiHEyHD9prdjHNAfarXFwkjvOj
         fPMp67oO6gsbdSq9pdtt7vwjYInCYuMlHS4fNNQjAn2re3a06v88eA/TSpsJ5w8+VFuI
         EWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791511500; x=1792116300;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QVVHBgvK6OKW53OVYnJLSJofdOQSOkfgS/m6Zeijg8o=;
        b=enEn3o3df5CT91r35wKV78WYWfRVk/kVU9ZTsBf19nw1N78SemK52iaENjcbeWW5Y/
         h8rJcNpNYVMbzeDAxMBipvF49wQG9lKHAzRDlVIBDQO0hmQZCtaHZVKcAeOtqKrR7p5p
         CKqhn2pm+jtX1Hvj4q17s7+19jnySc35cbuWVuL5L9Gi0XEcFNrDxbZEUG1qt6bB1Bxf
         l5XL8RCQgjNUTUPfP+lm2QxEN2Zg5w02kRLm8UQVYAmA/KQOAen7qAdZUfSdAUqV6Aa6
         u96hNs3sR+IPJhoPHYTRU+447FUzPEmo2p7vZYgAdnFeiuFhn1PS7JXJrtGP7rxPm7Bw
         qJ7Q==
X-Gm-Message-State: AFuF++lzo+FHm+iRvlhpu9oNkjPcpRzaaZcuzy59dtvvunMot19lqy8B
	58DE8FvMMd8sSdHiR0zQ3/7Yz5VjqV0DnEXU6vZJUskZl/Py9EdL3GYn
X-Gm-Gg: AYBFou0pEm9LVBkXf1METnxs63yReKHySyQRB8w87M8D5/bTGtWgweNJqzUUxx/7YkH
	JxQvtb+/5sEC37IW0cCp88zDW7CDxlI26TawLCqyvRoy5uhIC39k7AWlnJMEBDWk8TBrGUu3pgf
	lA7Cvbh9G+czxwht+JDHyPuph+nW444p6FsNX/wDbEer3k59stmntOv5lYNvo5gVsdpx+4ZBzkw
	MfYwxt+EQzkhGzSFe3hGYtBfV8jDs2lbuBi82d110VyUCUt4NuvSKxoIzGBPO/Gzuca/NbJpGhs
	GHvn70cQaI+KK+ZO1wLwjsS6OR9EPhogbUJzl06ZaUG8U9VH6Qmz4K3TvfupBqiwM0cdlGlW8OJ
	HtWKR6q60QXsSGkeIUDTfAHog3YsPXcTnE+hHD7mWc3QsemhCUVHUUXJWQ4I7mWUZsYX8gNw7nY
	CHv+9LQKV0XTf1IMCAc6rKVzKTj0nPFZg6AoW20AYvcbFToG+pW7QUVfiXvytUOLjadw==
X-Received: by 2002:a05:7022:e881:b0:14b:1ef8:698d with SMTP id a92af1059eb24-16a5d174c3bmr630165c88.15.1791511500470;
        Thu, 08 Oct 2026 19:05:00 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a31f6f5csm1979850c88.11.2026.10.08.19.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 19:05:00 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 09 Oct 2026 10:04:55 +0800
Subject: [PATCH bpf-next v2] selftests/bpf: Run the enable_stats program
 with BPF_PROG_TEST_RUN
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-selftests-bpf-enable-stats-inflight-v2-1-691ee379e511@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMZLyGoC/5WNQQqDMBBFryKz7pQkgtiueo/iIokTHYhRnCAW8
 e5NvUGX73/+fwcIrUwCz+qAlTYWnlMBc6vAjzYNhNwXBqNMo5VqUSiGTJIF3RKQknWRULItAac
 QeRgzUh9c3VjTqlBDeVpWCrxfljf8Zon2DF1pRpY8r59Lv+mr/8u0adSovHsYIuObvn4Nk+V49
 /ME3XmeX+9fkt/gAAAA
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

Run the program with BPF_PROG_TEST_RUN instead of attaching it, so that
nothing else runs it and both counts are final when the test reads
them. As a single run can be shorter than the resolution of the clock,
run it until its run time shows, unless its runs aren't counted at all.

Fixes: 31a9f7fe9337 ("bpf: Add selftest for BPF_ENABLE_STATS")
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
V1 -> V2:
- Run the program until its run time shows, as a single run can be
  shorter than the resolution of the clock (Sashiko)

v1: https://lore.kernel.org/r/20261008-selftests-bpf-enable-stats-inflight-v1-1-0cb92ee2c6d3@gmail.com
---
 .../selftests/bpf/prog_tests/enable_stats.c        | 26 +++++++++++++---------
 .../selftests/bpf/progs/test_enable_stats.c        |  2 +-
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/enable_stats.c b/tools/testing/selftests/bpf/prog_tests/enable_stats.c
index 75f85d0fe74a4..691a82a4d6d20 100644
--- a/tools/testing/selftests/bpf/prog_tests/enable_stats.c
+++ b/tools/testing/selftests/bpf/prog_tests/enable_stats.c
@@ -9,6 +9,7 @@ void test_enable_stats(void)
 	struct bpf_prog_info info;
 	__u32 info_len = sizeof(info);
 	int duration = 0;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
 
 	skel = test_enable_stats__open_and_load();
 	if (CHECK(!skel, "skel_open_and_load", "skeleton open/load failed\n"))
@@ -20,18 +21,23 @@ void test_enable_stats(void)
 		return;
 	}
 
-	err = test_enable_stats__attach(skel);
-	if (CHECK(err, "attach_raw_tp", "err %d\n", err))
-		goto cleanup;
-
-	test_enable_stats__detach(skel);
-
 	prog_fd = bpf_program__fd(skel->progs.test_enable_stats);
-	memset(&info, 0, info_len);
-	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
-	if (CHECK(err, "get_prog_info",
-		  "failed to get bpf_prog_info for fd %d\n", prog_fd))
+
+	/*
+	 * A single run can be too short for the clock to tell. Run the program
+	 * until its run time shows, unless its runs aren't counted at all.
+	 */
+	do {
+		err = bpf_prog_test_run_opts(prog_fd, &topts);
+		if (err)
+			break;
+
+		memset(&info, 0, info_len);
+		err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
+	} while (!err && info.run_cnt && !info.run_time_ns);
+	if (CHECK(err, "run_and_get_prog_info", "err %d\n", err))
 		goto cleanup;
+
 	if (CHECK(info.run_time_ns == 0, "check_stats_enabled",
 		  "failed to enable run_time_ns stats\n"))
 		goto cleanup;
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

