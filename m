Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8A64A4407
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791468225; cv=none; b=nnm9MgHbUxcJt5aUXGJZsbfB7HMPaDa6eeluQkYYGLsZ0fO/yfjW0aiCM7azTQDDnLA0xraxJ3rU/GK2uucsRn0XaNnvUzFzcXZNtpwd25K3bBHSQ5zXbQjE3JDrH0Uq3P45YO83bs+RRdbfUICXyQ9/cPNBpn/dgFYRMpPDCuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791468225; c=relaxed/simple;
	bh=fcWuRniJfG7FnytnGHSYxDYw7CnJkICYhX9CMJMB5qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qQXjz7IAghqX31p9yw0FQzmLP8PMq/b1uLtI6fGTWWcxLDCvhzUMQ5I3he/A2VIEFHXu3DxDG8QRWmv5G7/0WNNNb8eduTYPHdjwsD1E+3xJIQl+qoyUFnypBuZ4BZn0NOw6qonpgV3PR0sdrzQb93GE/5LmzdR5adk2XP2xE80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuCBYZ2K; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuCBYZ2K"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1433e7b057fso3733213c88.1
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 07:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791468224; x=1792073024; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M7uL3tEOiQiCctgTllbxUo4F81ApoTm3jkH2XRM5kkw=;
        b=AuCBYZ2KVw0bDDaZfrxy9e12nzaxmtWi+V3std8WbtkuhbBVzQIQPV7GlyOEoh1bm4
         hGlyukJR6dunH45KhWmF6LLg7ppogK3I/95bmjiiKwoPikZWZWhXIaXXAC39O+39ixtv
         OdCX6h06hV0B1q6saivzNG5HR5sAxk1fBDF/efZQFDPsdMbTN9NFs2fFgoBwurM5CgbB
         C5Wx0jJSZEg3dWhJYirAL82ZSi6yy+Cp/B7hMfJFNqdaZJUpRje+miqK9uSOvbWlSgLf
         whw7tPVN2+k4NpV7Wyu3Tq74EILk/cTT8aaXiCERBySZ1QwwrY1XDucxTOPo5uLWKreq
         ciNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791468224; x=1792073024;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=M7uL3tEOiQiCctgTllbxUo4F81ApoTm3jkH2XRM5kkw=;
        b=HUhArv7bEdm44+juQj04Q+MgsXC9QvnW2NeFhYoDHyMTnF0Js7iC8sB3qGg4I6EMiS
         DaSb54DVzDRVjA7DmTa48LIYEZDsZdtRqZjT2kyucjgQaJw+SRtI8Lweyep35IuY0l9d
         Qbfip7EqcesjcU/BN/GZKyK2W4n5ZLO/jbdxZXcC/kTzVHYOzFCljaSoX+IhigS6GE/m
         jlzkq3O/Qov4uDomby5yFQKlmDXug6m0BMq0hRfLsYCcLmVogP+dli2vLcsYKpxpQMaM
         HxssW9tlZXMIScXR58v7wDnuC62UPp8r2dostHluo+CzaggR19/CTTszXTADWlQB09eC
         g/JQ==
X-Gm-Message-State: AFuF++mnY10+ByDD6d1r9aoiRXx99BoMALxI1KlEwkmShmmEnojbUEkA
	4QyJS1hD2XoMh3bGeg3zcyHrV75Dwl39y3lGVVOIbAs6KVKsjTZhtUue
X-Gm-Gg: AYBFou2YVcIcIROuBcRAZjDhXRcYQWZIh6A6osUDujZtbY18k095pEklsgV/E+JdM1q
	h3+J8FliEP9N47Su1W6CoEqqqQwNdjkbHvK76dcGXbKjgeCa5mLXsRI2wk8eazq1wd0yQmCwoxH
	3KO5CvCCJVX8sd/mL9ixvgnYgQKCU8vyoqUhSkfyaz7BKVIdVWn0V/GbVpF1NwPkWxC1SBzsdyE
	bLB6X8xNXoQWV/du5Us80mmnZ3jnk8xsOnfBH1eXwpAECL7A5h8HonyEDSjThmh+XHNB9ZFzHF6
	fxQTNzlwzh3JURHcigNcKGIbXMnpSO46UIwy3QbSMkdT410RZMGYAMghYhZRWNX8WeRlMPkFelg
	kJTZ4JNGzdzwhWGH4S5H0YU1Jzzz14rTTxwSr0W5nXWcC8afwmCr+6Pk9kHwaTJay8XsQ+23dzy
	Qa69cUCQUMCq72jVEa9QSsL4nyuvIvj26WL48pleQqlxQkMnfRMLEgoIJ1RqA7iHujag==
X-Received: by 2002:a05:701b:42c7:10b0:144:eaa7:2763 with SMTP id a92af1059eb24-16205514412mr6682965c88.16.1791468223270;
        Thu, 08 Oct 2026 07:03:43 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-161680e191esm14504872c88.11.2026.10.08.07.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:03:42 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Thu, 08 Oct 2026 22:03:36 +0800
Subject: [PATCH bpf-next] selftests/bpf: Run the enable_stats program with
 BPF_PROG_TEST_RUN
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-selftests-bpf-enable-stats-inflight-v1-1-0cb92ee2c6d3@gmail.com>
X-B4-Tracking: v=1; b=H4sIALeix2oC/x2N0QqDMBAEf0XuuQcxgkh/pfQhqXt6EFLJhSKI/
 97o4yzMzkGGojB6dgcV/NT0mxv0j44+a8gLWOfG5J0fe+cmNiSpsGocN2HkEBPYamiDZkm6rJU
 xSxzG4CcnA7WnrUB0vysvurSMvdL7PP8SfJPGfwAAAA==
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

Run the program once with BPF_PROG_TEST_RUN instead of attaching it,
so that nothing else runs it and both counts are final when the test
reads them.

Fixes: 31a9f7fe9337 ("bpf: Add selftest for BPF_ENABLE_STATS")
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/enable_stats.c | 9 ++++-----
 tools/testing/selftests/bpf/progs/test_enable_stats.c | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/enable_stats.c b/tools/testing/selftests/bpf/prog_tests/enable_stats.c
index 75f85d0fe74a4..c4c63315e0798 100644
--- a/tools/testing/selftests/bpf/prog_tests/enable_stats.c
+++ b/tools/testing/selftests/bpf/prog_tests/enable_stats.c
@@ -9,6 +9,7 @@ void test_enable_stats(void)
 	struct bpf_prog_info info;
 	__u32 info_len = sizeof(info);
 	int duration = 0;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
 
 	skel = test_enable_stats__open_and_load();
 	if (CHECK(!skel, "skel_open_and_load", "skeleton open/load failed\n"))
@@ -20,13 +21,11 @@ void test_enable_stats(void)
 		return;
 	}
 
-	err = test_enable_stats__attach(skel);
-	if (CHECK(err, "attach_raw_tp", "err %d\n", err))
+	prog_fd = bpf_program__fd(skel->progs.test_enable_stats);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
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

