Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0E623EABC
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 03:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889960; cv=none; b=snPdAHClrFDWZqxRINvXsroap7fZUP1GPfsKKfaJts3MtXyxhPLKRCji+I0cth83ylbEtlunf3cMd9+8dKtX+zpQfsByuBrpY2qlt3tppkljyoAVA/cG0q25Mqvkg3VDoVSkGISm/2ipOfW1dOj/3nVqYv2+MBcx8m2ghmvIHkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889960; c=relaxed/simple;
	bh=OQN1kt/oQVgvZ4HUaTJNxkHVzBBhZ3DiRkzvZeMcZdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QJe2R4e59jg3Uw1IYX+O7X87jjuUboA6Bpak1aR3G9hcRTGpX3Vob02rzE0bT63wkYfaDBm6KfGKOva/sYSoGGrA5vfR24mJHKCBLOtxUUWcJ9Ntkxg5f/tA2xUs6lKzHdLRNOeaQtAYt1AZoTTAw8qx9ietIqx38rbM0ZKBX6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZ9svj7R; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZ9svj7R"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-126ea4b77adso217342c88.1
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 20:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773889957; x=1774494757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HaQeluzw0pyS5dmNEqnoRowDSdw9ZIo82XeBTu2w18M=;
        b=QZ9svj7R29Q+I0lq27pL3BIaFzZfAwmwj6QGaETEataXkQZqFBWCYZrFt8h+nO8YD+
         sgr5cxk0cW7ghztqkl6/AeBhsduCoNP3U7y440UB73Hkry8ooqFFb1vYDAvapIJNc9AS
         G45sG+irzmAjOi/S+3RNjAXs5oXPhkakh1F7rGVaXfzHNqAZPU3EOurk/9/bNZUU7bmw
         jQArIof5hyuXHz86fZM6Y6lWLmKHM+J2m6d9qEYCeKWl06jyh9DH16aailf6VDo9TVLi
         lO4TztdrnQNO4MsHeRAWWlFEqPWUXj8ktHGErVb+4+WrWdZKqgpPV2Uv6tyiuIZEG2oN
         ZzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773889957; x=1774494757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaQeluzw0pyS5dmNEqnoRowDSdw9ZIo82XeBTu2w18M=;
        b=TsjkJGN/NM31XZ1U4Q1+hRUIvINSfNnsIFhvN3DYiw0/jVt4MdUVaTgGBTnRYB8At5
         6Ln1XRQmmpMHKax3lDzlGMikGikDpUE1Tn6xTFniW4NMx1lXSyiplHmi0nkGh36I53E0
         GrOZscOK8O3sBDUZuSY8iKqt6juryvJQ5lR8A8uxoYqCISqNGXsiqeYsCeBPD7npY9XV
         79QeG/DiJqwVxeHSnxVcgCv6qyxV6ymJtA4MiBXA2hCdYnirS/oUJMjh9onqlQqMEhvH
         9EAImv7uoL0vY6MKnVzil4T4ucF7aRMINiZzgWCR+mnxvDit1M/EGRY02y3u6A9zNu/0
         tidQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5tBTltVAkbDZtYDI6Gwvg7dE/aXJDoPfGySTcZ1JVmjfwHHYAB7rDqIA7PEKC32oDIDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM1153tA/KIuZDHZjagXOFij5K8QoO7CpDTw1XqHwobjfDREWp
	Dn3FTR28UY7MiUXoB8hzSXkzK5AVW5GVvhQ2drkWQXe+liwdgz/qa04E
X-Gm-Gg: ATEYQzxaSIOJUlVqov6i9RHMEl9zBT5Eq3eCeAohObwbcY6pGje1FnyAW24nAdQ7tkG
	C9LwbCY95y3VQ/4A5aCtCrnlBR0e+155KivE0cWndkQC8FPmsXNNG1O2RLcy+j5TyiU9qCw74St
	Muo1A6ih4iKjxIySt2g4CusUVX7xtW2GvrTrX+Ki1e5O4iRUg048Erp65Fi53NnZoKuxaqie7Ph
	5NOCD+dF3nLtm3wjGH1ECLSbtIiQAzGbVNXIdSLfPS/uIzwjGufC2mYXvDzgt/9C4s2K+gdxM+p
	qKz7vu8PX4jkA+gtvscqH/o6T2+nmh5wcwA2NNq0QQQUGjjTDPWNMBFr3n/rNS29dcXcKWQwuTF
	fwCcaCArB5l3X6V07MaMRTrQCRjPQ2I3+pxltZWA9lBy5MEjZR32TNuK2WjevzZZMPWRD0YCIEx
	2Jp7hCO5/Y8Xw3PStNvuKaGyPqAknkwollIIglnmGhczV68y4HIbmDYy+ffBry0vSQPl0iJq3cG
	QzlvhH0mzWagLEHinrpHu0ZvXI=
X-Received: by 2002:a05:7022:6608:b0:11b:82b8:40ae with SMTP id a92af1059eb24-129a70e5ecbmr3309714c88.18.1773889957433;
        Wed, 18 Mar 2026 20:12:37 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e53b51easm6458674eec.7.2026.03.18.20.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 20:12:37 -0700 (PDT)
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
Subject: [PATCH] selftests/bpf: trampoline_count: use dedicated bpf_testmod target
Date: Thu, 19 Mar 2026 11:12:27 +0800
Message-ID: <20260319031227.330505-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
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
other selftests such as modify_return, get_func_ip_test, and
get_func_args_test. When such tests run in parallel, they can contend
for the same per-function trampoline quota and cause unexpected attach
failures. This issue is currently masked by harness serialization.

Move trampoline_count to a dedicated bpf_testmod target and register it
for fmod_ret attachment. This keeps the test semantics unchanged while
isolating it from other selftests, so it no longer needs to run in
serial mode. Remove the TODO comment as well.

Tested:
  ./test_progs -t trampoline_count -vv
  ./test_progs -t modify_return -vv
  ./test_progs -t get_func_ip_test -vv
  ./test_progs -t get_func_args_test -vv
  ./test_progs -j$(nproc) -t trampoline_count -vv
  ./test_progs -j$(nproc) -t
    trampoline_count,modify_return,get_func_ip_test,get_func_args_test,\
kprobe_multi_test -vv
  20 runs of:
    ./test_progs -j$(nproc) -t
    trampoline_count,modify_return,get_func_ip_test,get_func_args_test,\
kprobe_multi_test

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../selftests/bpf/prog_tests/trampoline_count.c |  3 +--
 .../selftests/bpf/progs/test_trampoline_count.c |  6 +++---
 .../selftests/bpf/test_kmods/bpf_testmod.c      | 17 +++++++++++++++++
 3 files changed, 21 insertions(+), 5 deletions(-)

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
index 7765720da7d5..14ad2f53cf33 100644
--- a/tools/testing/selftests/bpf/progs/test_trampoline_count.c
+++ b/tools/testing/selftests/bpf/progs/test_trampoline_count.c
@@ -3,19 +3,19 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
-SEC("fentry/bpf_modify_return_test")
+SEC("fentry/bpf_testmod_trampoline_count_test")
 int BPF_PROG(fentry_test, int a, int *b)
 {
 	return 0;
 }
 
-SEC("fmod_ret/bpf_modify_return_test")
+SEC("fmod_ret/bpf_testmod_trampoline_count_test")
 int BPF_PROG(fmod_ret_test, int a, int *b, int ret)
 {
 	return 0;
 }
 
-SEC("fexit/bpf_modify_return_test")
+SEC("fexit/bpf_testmod_trampoline_count_test")
 int BPF_PROG(fexit_test, int a, int *b, int ret)
 {
 	return 0;
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index e62c6b78657f..6eaceb4dfbec 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -581,6 +581,12 @@ noinline int bpf_fentry_shadow_test(int a)
 }
 EXPORT_SYMBOL_GPL(bpf_fentry_shadow_test);
 
+noinline int bpf_testmod_trampoline_count_test(int a, int *b)
+{
+	*b += 1;
+	return a + *b;
+}
+
 __bpf_hook_end();
 
 static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
@@ -1843,6 +1849,16 @@ struct bpf_struct_ops testmod_multi_st_ops = {
 
 extern int bpf_fentry_test1(int a);
 
+BTF_KFUNCS_START(bpf_testmod_trampoline_count_ids)
+BTF_ID_FLAGS(func, bpf_testmod_trampoline_count_test)
+BTF_KFUNCS_END(bpf_testmod_trampoline_count_ids)
+
+static const struct
+btf_kfunc_id_set bpf_testmod_trampoline_count_fmodret_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_testmod_trampoline_count_ids,
+};
+
 static int bpf_testmod_init(void)
 {
 	const struct btf_id_dtor_kfunc bpf_testmod_dtors[] = {
@@ -1859,6 +1875,7 @@ static int bpf_testmod_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_testmod_kfunc_set);
+	ret = ret ?: register_btf_fmodret_id_set(&bpf_testmod_trampoline_count_fmodret_set);
 	ret = ret ?: register_bpf_struct_ops(&bpf_bpf_testmod_ops, bpf_testmod_ops);
 	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_ops2, bpf_testmod_ops2);
 	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_ops3, bpf_testmod_ops3);

base-commit: 8a30aeb0d1b4e4aaf7f7bae72f20f2ae75385ccb
-- 
2.43.0

