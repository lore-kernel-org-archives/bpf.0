Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9F33242D9
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 03:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773892022; cv=none; b=FISWSlCDUqyKooCB1WFg5cqc/snvPuwqu+bUyaeymaQ4og6KibTSb4EIOCKpzYvPqfAirQIJlwy/13/J1wvAS8k3AhjiyeXJDVzPkG+Zq9dr6LL6BD5WUnbyPi7d5VbTdCUddNsvb/t6U0fEW3CiJK2P8idom4ZpDzjIz+GBL48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773892022; c=relaxed/simple;
	bh=w43A32ElWzUFHVnnYSmGYUdM4Z3ZT7EHYE2wZgx0qf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMw44d/DQ08ZeSGk5MhLr00cc+NkdcukEE+fQxmQonQAWBS7HVdujcN3J0aHUhaiB6ZpgOQudBEtFiX0dm5MZSTaRtzOTln86AZQxC8WQndROYQpgGPQuRLeVS0Ob2MbkmX8sRCUeRsyd0QaaL/cyNyp4kpD855POQERbKHspNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnLDvzOd; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnLDvzOd"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12a693cdf29so278151c88.0
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 20:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773892020; x=1774496820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KbolAMX4QbaXf52snOUv/EVQt0h5F1GAcLobkdxUR8=;
        b=GnLDvzOd+sWIlZgGlIgHnvmCS4q2JefLDuTq5I1DfAIPl4FQUV8z6+WZcI6Tzc0A/u
         xY1nEPDg6mWSkJoxhpcd+DGVdQYHVwYdaw0VRH8XoDBQcXMilco6LOkzUZApIaF/259M
         g6E+CAyarT6z6WGgLSwbBq1ejCR248bSGLIdGSl/yLpjYRNrRJD6GVzQoYXdbSOtkRXK
         nvVspigFmvztULGvzjrwGaHVcLBpdcgTmgotHAU9r68lD4/tdZOZAjeGw5IBrIWM1uS3
         0H9RmBM34ssYq52OdHFTcIl1c69NHp5Jt7QG25wdqQmM3ZN1T/rWmxmtK6ydZIuWXiTg
         TLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773892020; x=1774496820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7KbolAMX4QbaXf52snOUv/EVQt0h5F1GAcLobkdxUR8=;
        b=QNwa0jYhk159r7/Tr/6ZwGN30JtJdY11jSJlvfCkIDrvFlb7haEtY4RfwudKlbOJwj
         bsIcuf8aRauzq+FYjU3ON1mjsa46FOPDgV13OPL9t/Fl1UXo9QU2wFwjL9OuQCVf+UfZ
         aLZvn4lp6dadke6jvzqZTNws4ZBWMjg8HO2v4m+hxbx2FJlOFfd28OtKouXjfGQYbY7D
         3vR1p+Nk/zdtm8+TugMasCyl8Zkgsii2WryIxelXGa5Yom2gx+yypADDh+i+xLhLOVjj
         fPHukmM2Dq6KPKpbT4ZczTVcILfYuxWLu1e6BNGrHzPKr97gq4KcmUfOAAfwW66nYV7z
         pk3A==
X-Forwarded-Encrypted: i=1; AJvYcCV9TIRZaY0AqD3u8+FSj2IQED19QK9dvvKZ1blc/bfdIfAWL4n50Yp5JHbXlfIX+qC/pDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJg+OOQx0eYhampXk5PRztr6jo3mbhJFgoXfHpvi7b7fZ7I6L8
	ex3qMaQWdF2/LnCoX48FgeNhZkvPyWddFykJIh1ArLaOj6Fkfg231pGy
X-Gm-Gg: ATEYQzwGI5C1ro5NYApuWzTD77BfajfOcv7b+KSUCNz7nbZZun+0Dq58+9MKVMbTtqv
	6Mgj9khgB3iS/kIevjnrIvf6vseI50WJaJCitxZk1FUQDbSNhF03v5VEpbyWO7IWGMa30HQq6N8
	wBVPiC6zazk+YlpWzpgKvskCkRtpkHNHrKt35gmsoUD7pV4Vab1e1+12PfWLzXcOoLCk94JmEyi
	mlqEfd4ZOzgIjHVBLzNnF534fwWZdesTuQ0FjSz3y7VJ22uk24uxT7ckbTdWTRf32ZfEPP0azIi
	ey9AputiI6MS8uIDVAJevr+Js2WVkgopQoAlwNDzhGTrnNRWHOQkaOWrLHQ4IV5nPd7lip7XYDd
	hMZ48LTtMKRmEqjJ/rqrdwSv0xCB4fxiZndH94T/gp4Mhz9vOGKN0BejnWptfg3lLwletDMBbCD
	fwj8eU6I7oa5yGaAvnLQKTL/S9IZEx7YjaqSlTl1GKPx74GtsmQgHB2dv990wXkGPtHuj/Kavsi
	90ihiAaKU2DRFXmlud9YS6C9Ys=
X-Received: by 2002:a05:7300:e82c:b0:2be:1a8e:10bb with SMTP id 5a478bee46e88-2c0f3c333d0mr856146eec.12.1773892020323;
        Wed, 18 Mar 2026 20:47:00 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0fb178b82sm829880eec.6.2026.03.18.20.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 20:46:59 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	shuah@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	paul.chaignon@gmail.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v2] selftests/bpf: trampoline_count: use dedicated target function
Date: Thu, 19 Mar 2026 11:46:38 +0800
Message-ID: <20260319034638.330749-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319031227.330505-1-sun.jian.kdev@gmail.com>
References: <20260319031227.330505-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trampoline_count fills all trampoline attachment slots for a single
target function and verifies that one extra attach fails with -E2BIG.

It currently targets bpf_modify_return_test, which is also used by
modify_return and get_func_ip_test. When those tests run in parallel,
they can contend for the same per-function trampoline quota and
cause unexpected attach failures. This issue is currently masked by
harness serialization.

Add a dedicated bpf_trampoline_count_test target and switch
trampoline_count to use it. This keeps the test semantics unchanged
while isolating it from other modify_return-based selftests, so it no
longer needs to run in serial mode. Remove the TODO comment as
well.

Tested:
  ./test_progs -t trampoline_count -vv
  ./test_progs -t modify_return -vv
  ./test_progs -t get_func_ip_test -vv
  ./test_progs -j$(nproc) -t trampoline_count -vv
  ./test_progs -j$(nproc) -t
    trampoline_count,modify_return,get_func_ip_test -vv

Tested-by: Paul Chaignon <paul.chaignon@gmail.com>
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---

v2:
- add Paul's Tested-by

 net/bpf/test_run.c                                        | 7 +++++++
 tools/testing/selftests/bpf/prog_tests/trampoline_count.c | 3 +--
 tools/testing/selftests/bpf/progs/test_trampoline_count.c | 6 +++---
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 178c4738e63b..b41147a29f16 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -580,6 +580,12 @@ __bpf_kfunc int bpf_modify_return_test2(int a, int *b, short c, int d,
 	return a + *b + c + d + (long)e + f + g;
 }
 
+__bpf_kfunc int bpf_trampoline_count_test(int a, int *b)
+{
+	*b += 1;
+	return a + *b;
+}
+
 __bpf_kfunc int bpf_modify_return_test_tp(int nonce)
 {
 	trace_bpf_trigger_tp(nonce);
@@ -635,6 +641,7 @@ BTF_KFUNCS_START(bpf_test_modify_return_ids)
 BTF_ID_FLAGS(func, bpf_modify_return_test)
 BTF_ID_FLAGS(func, bpf_modify_return_test2)
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
+BTF_ID_FLAGS(func, bpf_trampoline_count_test)
 BTF_ID_FLAGS(func, bpf_fentry_test1, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_test_modify_return_ids)
 
diff --git a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
index 6cd7349d4a2b..b19358aed126 100644
--- a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
+++ b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
@@ -30,8 +30,7 @@ static struct bpf_program *load_prog(char *file, char *name, struct inst *inst)
 	return prog;
 }
 
-/* TODO: use different target function to run in concurrent mode */
-void serial_test_trampoline_count(void)
+void test_trampoline_count(void)
 {
 	char *file = "test_trampoline_count.bpf.o";
 	char *const progs[] = { "fentry_test", "fmod_ret_test", "fexit_test" };
diff --git a/tools/testing/selftests/bpf/progs/test_trampoline_count.c b/tools/testing/selftests/bpf/progs/test_trampoline_count.c
index 7765720da7d5..911d282fd423 100644
--- a/tools/testing/selftests/bpf/progs/test_trampoline_count.c
+++ b/tools/testing/selftests/bpf/progs/test_trampoline_count.c
@@ -3,19 +3,19 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
-SEC("fentry/bpf_modify_return_test")
+SEC("fentry/bpf_trampoline_count_test")
 int BPF_PROG(fentry_test, int a, int *b)
 {
 	return 0;
 }
 
-SEC("fmod_ret/bpf_modify_return_test")
+SEC("fmod_ret/bpf_trampoline_count_test")
 int BPF_PROG(fmod_ret_test, int a, int *b, int ret)
 {
 	return 0;
 }
 
-SEC("fexit/bpf_modify_return_test")
+SEC("fexit/bpf_trampoline_count_test")
 int BPF_PROG(fexit_test, int a, int *b, int ret)
 {
 	return 0;

base-commit: 267594792a71018788af69e836c52e34bb8054af
-- 
2.43.0

