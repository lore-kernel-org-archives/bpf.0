Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A042580F2
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 04:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773893050; cv=none; b=rQBmSHoen3tg1hl8z2CyjjaYRx+hwPqGoaeb8tv/WZI7sLcjzn8/SvU1fsQNYT6ccwc91HmEGiFgf/COmbDB+9Q0RPj0wKWeJILCNowSQiSa1HouZV7t1TmtmyMin+0RBXklA6nhmrU+yOakFJgt9Ld9R82X94mCxjxMybbIM1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773893050; c=relaxed/simple;
	bh=al28sz6aoPxmVJCaRFJbTqr9Acsx8Cb6Jpl7mkM1zU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RO1Awe4KS9zhRM9O/Z2r/gaOLk4Ef4sf/vYY3WTcrTwCX3cV4P6KYUizrnLZB3S0yARszVjZ7xNKsXi6W8FUqcFA1o3Me/K8xS+6Eq36bJ24QiOQe/F92QuV7MDdFaIqAJus0aq0hPDyJHa0RpX6WUHBGi4HN4q+/fdU3iytBXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PC8lTvwQ; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC8lTvwQ"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12732165d1eso791165c88.1
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 21:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773893048; x=1774497848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFidzLk14rThG8oUyNmMDZ2YZWMvX9mGuKIL63l9/g0=;
        b=PC8lTvwQVztLBlJ+bUrBvlKzamJQi40Tm4C2N62cg06c25F2Q4iDCPTofjZDiyTyWa
         yJn7aPsvNgUF4qkzadYxGuzyY1TPrxOnTAA5sJyoLvo9zex34zmJmRD5396R9aO+QFrS
         NWiUlB4lSl3iFbTKbt6OCJmw1zkDUQGSSewCwXTSxO2RN3B3oZ96rw13HMwF/f8kyLnx
         J+0GbJWQXOOWUPriuCwd9eWD1mpxdsd+lTDy++MdVgWUFQ8K99aO7T8EoT16lX5VveBa
         UcAp1l/ab6KJQfYluYTgcw5vs+y1xkZC3xJa2mLaCNRELIIXtTGyPA+stD7lNypXVZYz
         PicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773893048; x=1774497848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aFidzLk14rThG8oUyNmMDZ2YZWMvX9mGuKIL63l9/g0=;
        b=n9RtFEu6Qa+mjQpFAft8GWBWGA5J1PSYY6enjkDob6ZDZTnhVVqzj4VipX39OCk0xq
         urKwQYhsel/y9Xqr0YMVYbmEHw5yMS1QH82HbBOELX3lsbwiKAO8gB8T9gAYGLiV+ndS
         tfcHI1pF6tRLH1uA1BSHfpNCepCy0G/2owz5kyRiTq7AMncASXAWMa9aJXgUxBpQ90Ed
         gI5P/j1yITwaQKX0+cTSih/yTgILvn97JrkzhObgmVrc+xr06Uc7MkNcg9nLonb69YXC
         QNWmi6DUr3ZjJzVbC9POAEYV+/RQoOHAuAjcolFY3nE9VaDoQOFHBMDCs1TYWFVDvWrP
         Vbjw==
X-Forwarded-Encrypted: i=1; AJvYcCUy6T0O4UGmoHu+H2LLbxEGhDLUE7+EcKcv0bcsWB9tolzgXvXJ+Pn1AXfTQPsuLGlX6Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnJtVfIYA05+0Zak/0GTBpl77icNJNNdG6skrsXw4kfQ+S63tL
	fafXj6msMgoR1DZNHy/ornlKS2Xk+FzPQ9myHs2kHqqYXYacIt+s3Cla
X-Gm-Gg: ATEYQzyzKSVTCGwusLD2MBrsMBJxYuQ1bboIvR6Nmspk1x86MnrBf+H0/LzJLM5gljY
	hyNGxcoRIS3+nJVsnuYpHFz8epgxvMjixXNBS2pcd82RMjVE7tCqlvsLhy8a0TJ20cjAT/cC3uW
	mVO+XDnhkt2Lm5BWHPG/615rhGXA6uYDRUKDkcYCH++1xRXz+tBFjKHOGvq+knKYAf3MDu3PPEC
	Mll54IFpRSjbSCLfXJtOYLOrdPaMqVNtRGmRyCYP3IWAlwfZkjtopFQgAaF+IYjGwOGX5DwwOz5
	HlH58/xjBgh7ES5rcqUubBz+PrBoKnkDKUkNPd5Elc299vRfkgEw3yaVWZdcrlDyPc09/UM/X8d
	ItCt5V36riLWEXyt2Y0J9YD/SuWN4U1Nvk6UEaYJ+WKFtlK9Q3xIcuRjUG9jfk1gfPFpAMGSQHV
	tOjUY5+nWsjHGQoClV8cJdqS4CgSdSzT+k9rS5iEeEJJvGSqC2UF6jizXhCoQMTCnbRwkE5XXf0
	LaLtqEQvnfwe+iCqDNizQJGJ90=
X-Received: by 2002:a05:7022:410:b0:128:d577:dc21 with SMTP id a92af1059eb24-1299ba8eb6bmr2987001c88.13.1773893048389;
        Wed, 18 Mar 2026 21:04:08 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e560fb5fsm8470953eec.31.2026.03.18.21.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 21:04:08 -0700 (PDT)
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
Subject: [PATCH v2] selftests/bpf: move trampoline_count to dedicated bpf_testmod target
Date: Thu, 19 Mar 2026 12:03:37 +0800
Message-ID: <20260319040337.366375-1-sun.jian.kdev@gmail.com>
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

v2:
- rewrite the subject to describe the change
- resend with the correct patch content
- resend as a reply to v1

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

