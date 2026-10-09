Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EFF318146
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 01:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791510539; cv=none; b=J1rKLzcZYwiv8ijIZyOZtzVmfHIj+WjGFEzDq7Zvj3nxICuJLAo9jmU3iH2fHMp1efbkDyj8Y+KaV+3QcWM7/OhZU6ZUW+D6ICs/da1fzt+4haPxkBhmTlogXlwnndDR1R7rDBhfuJktsqJO8IGOm7uuwOLQRemHmdVpvlpMVY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791510539; c=relaxed/simple;
	bh=q1A+5bY9JKcAap1X2UpIetoUf5WvQvLMS3llETCRifs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YPPLBmxJ7cg1vZwpOC67tNFYPKAzDUobhO80QEfwo161eREycU/PFrfh1nMlVTe8J/AZ2XwaITVMYj1DXWt0CKL3lS7qyVjBB2rKBhfdCxknyPEXoOu/B32tgZy2ad5wqVk7rB87PvVr4rFkSSZi5NIftUoAVqdwc5+hRAWbJag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIZk5ZLC; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIZk5ZLC"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-34bb8b31647so9154789eec.0
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 18:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791510537; x=1792115337; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FOAUYQsivtnmX6gmnt+M/vxUdyS2XU3fcOO6GL4Vu+I=;
        b=iIZk5ZLCHtxc1El6cXqOMUNkBvunOMsa5tPoRz1nyS2XArqx/i5FWD8jvuFl5IFyZ3
         1iVIWgqn0Hnz/naNugv2AvtT1v1Kl+s+xU98AWHa6Y4OdFPd+hyQkjWhroARDGkZOoWN
         SJaxPSvkOur3fIcnKiTrLqunsT/YE7pAG2NsyiwZosq0BDDpk+Bvu+GIQ109uV8eJaDv
         a+HQ9XtbyfTvHskK45FQ7xRJR5IeqfLdDV0uU1e1YWuTkjUTRPFM7/oh9K8ZuQ0MmPX8
         b1Bwg8yUiYK6oURkwAjvWFdnO2P53GNOj0lB9Q4GzYEGWY+egP6DHitvsFN6CzVNC0k2
         lQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791510537; x=1792115337;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FOAUYQsivtnmX6gmnt+M/vxUdyS2XU3fcOO6GL4Vu+I=;
        b=Px59GSxuXua51xdAgRG++tprLQ8DgPyvTe+zyIx8pG4Lr082+P2uCG+cFHoP74F5rz
         dRw2CMlFlD5DOS1566AX01lAIWfyiDX5jHUzxvOOM2uUicU3gjTAu2Wd9vTRtm7363iu
         p5mpDqlGGYeSYEHo76sJjBwBTc9HiQzINbjw14JPRcQSQ5+L17pUE8QaihlT65Qo3I4S
         MvPyOMDTqtCRsDb7ft91Bp1UOITKBK/HnJuifT20NFib/Ops/UWN6ZmcXKnsvYgEy7Us
         aQJGw9CGm+lXL/pN84wAZZyFbdXnKdn9Cs9AOHUCuI3QcmNzM2D3KdRNv9FPDm078JbP
         Tj7Q==
X-Gm-Message-State: AFq9FYKmQkBApP88OrM+h+fZMlt5Rmk5JGmCBMODt82heiqwwfnGqpV2
	g0HB8g2JQdZuia5X5pfqRaEenfZG59muvCHDwVhwrRgcj5iZq5bramok
X-Gm-Gg: AYBFou2QlFNPrS3q1pHBxWO3B6rlHJzrjkRHyd90rCPafF4RIbZdUbPoGyTYWeuxodv
	fCZ9yQvtXX2upGnZYqdgTMkgvLaqBCYyLnCIQ86HXM3a9eeZsaul/KV0Arq/qzHxQH7Iqd7Ab9j
	p/0nGO3URbLIwf5bmbuw6GQjqw7CLSNUVYsCbvnYQyZ6L9fcbHtexyDsUcfkwH14YYB9QTTb5Sq
	pjJBTgwH1+X72ethiYKprqTd26NezSfFs3SFf3AVEIxo8wyO/Y+LpPSlvmskPTQHMv8oOJ+wt7i
	i/v2vzCmllDYhtwiW5/g1eb5KX2eqf74DMwaT4bxLLDXagUtsSMyhZUlcsVBLVdVjP9TFmtINTp
	4/hKQ1jjvag/mw/Ect1rp1gfOJ/uGubaFoWjQSLRw7eZY2XhWnMDrUsjywa+9R0c1/BlzDuUhbL
	ydK9SmPIGkJ17/QUyE3dgBsh+bt5QI0swnTzmTXztnoCYd0R/vNiqbo4k5A9U7DC2hxQ==
X-Received: by 2002:a05:7300:ec8e:b0:351:7e90:6035 with SMTP id 5a478bee46e88-3537ddf9efemr908440eec.4.1791510537009;
        Thu, 08 Oct 2026 18:48:57 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b53dsm1829232eec.6.2026.10.08.18.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 18:48:56 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 09 Oct 2026 09:48:52 +0800
Subject: [PATCH bpf-next] selftests/bpf: Wait for the struct_ops map to be
 freed in assoc_in_timer
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-selftests-bpf-struct-ops-assoc-timer-v1-1-9a97a9b3d1db@gmail.com>
X-B4-Tracking: v=1; b=H4sIAANIyGoC/x2NwQrCMBAFf6Xs2YVtpEL9FfHQxhdd0CRkVymU/
 rvV4xxmZiVDUxidu5UaPmpa8g79oaP4mPIdrLedKUg49SIjG57JYW4818Tm7R2dSzWezEpk1xc
 aD5gljAPiUYT2VG1Iuvw3F/p5GYvTddu+mTqEOYAAAAA=
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

st_ops_assoc_in_timer_no_uref runs .test_1, which starts a timer to
call it again 500ms later, drops every reference to the struct_ops map,
and expects the timer callback to find no struct_ops associated with
its program anymore.

The association goes away only when the map is freed, which happens in
a work item after an RCU grace period. With other tests running in
parallel, that can take longer than 500ms, and the callback still
reaches the struct_ops and gets MAP_MAGIC instead of -1.

Restart the timer from its callback until the map is gone.

Fixes: 0e841d19263a ("selftests/bpf: Test getting associated struct_ops in timer callback")
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c | 4 +++-
 tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c  | 7 +++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
index 461ded7223515..84da2c8651bec 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
@@ -158,9 +158,11 @@ static void test_st_ops_assoc_in_timer_no_uref(void)
 	 * Run .test_1 by calling kfunc bpf_kfunc_multi_st_ops_test_1_prog_arg() and checks
 	 * the return value. .test_1 will also schedule timer_cb that runs .test_1 again.
 	 * timer_cb will run 500ms after syscall_prog runs, when the user space no longer
-	 * holds a reference to st_ops_map.
+	 * holds a reference to st_ops_map, and every 500ms after that until the map is
+	 * freed.
 	 */
 	skel->bss->timer_ns = 500000000;
+	skel->bss->wait_map_free = 1;
 	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.syscall_prog), NULL);
 	ASSERT_OK(err, "bpf_prog_test_run_opts");
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c b/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c
index 0bed49e9f2170..9f3124acd9b04 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c
@@ -25,6 +25,7 @@ int test_err;
 int timer_ns;
 int timer_test_1_ret;
 int timer_cb_run;
+int wait_map_free;
 
 __noinline static int timer_cb(void *map, int *key, struct bpf_timer *timer)
 {
@@ -34,6 +35,12 @@ __noinline static int timer_cb(void *map, int *key, struct bpf_timer *timer)
 	timer_test_1_ret = bpf_kfunc_multi_st_ops_test_1_assoc(&args);
 	recur--;
 
+	/* Try again later until the map is freed */
+	if (wait_map_free && timer_test_1_ret != -1) {
+		bpf_timer_start(timer, timer_ns, 0);
+		return 0;
+	}
+
 	timer_cb_run++;
 
 	return 0;

---
base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
change-id: 20261009-selftests-bpf-struct-ops-assoc-timer-5eb0295ec300

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

