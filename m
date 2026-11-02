Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622747;
	b=mNzr/A7wpm2UqWq0eYVknU0pu99jDEjgyJlXV2jXx+PX8bo4GNAbN3k07KH+lUAgZJSW
	 UqkM57qa5laRWOzVx9m2M/+wT+Age96S73WvhzMfiw79Ecyl7+I94+SI2knTURCNvqedZ
	 KlegSwdPvB2LtFAOp/CwpHkUFKbEcdwEzOQSHicXn8axJhUNtyWvwOSLdO+gzj9ptwg2w
	 KEdpMEwsgnEwsjb8D4wVXGa+fQtQw4BlfbzQQ7q6+wuInTa93bGOxKpwdlhoSv7JRHFQ8
	 6orzxfoZ4usftvhLaO0Y9epV0mAg8z5OZPahc1s/DovMSAWkqTImYnr5+L5hmh4AN7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=xnfmuth4GfVE2DkgiLmsPIZ8ILT7OTtQGQS1uT6EliE=;
	b=rklN0s33JEFdev3JSgJawrt2af1PToP1ZzzFfQCNuG8Nd3MLawrRuWCvuNJ2U6o6wm6A
	 Bb6MKJwaxWVb5MlTLZnq/kFALBScVZHGc4KdR8Y7kSiYAy5iOW4BvK0jqTQQghZAXic/O
	 v5Flytj4N707U7qR8+D1VuWPCkFiW2am8O3kfnjs8cGNFDEKm7HGHF0kUAsLE6DA4GIw6
	 /NaJugoqJUndadcfgDTgucOuwBGBPZQZWmKSPOQpn1A99SMvbrRxaFc3gdhoXlwmReWL1
	 wI6FsjDuyLlrnefR2Kav64/80xLANIvNBkIKEakhD/lmCtWe1PEm1nHjbfxiCA6ZPng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=03CQycp3;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20678606A331
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 12:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20678606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=03CQycp3
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so5512575eec.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 04:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793622746; x=1794227546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xnfmuth4GfVE2DkgiLmsPIZ8ILT7OTtQGQS1uT6EliE=;
        b=03CQycp3W/08XfEwsiJsaGPauBDfJ71NS7uD+dI92wbd8Bt1Go1NT28KEzamCNnVTD
         hioa2/UHDx+3aNKD6l6Zl578OY1ffhrTSRw/4R56a1fpdhSaTFzoMY6kSXFibA1z2cLA
         Sj7fdr053b9e8rvecYt2KnVBsDBKTJcG8QdTbhwrgTgpqywakRkrqLMz9Bz1Y1WfauTj
         dTezfRqAHSonF+H+9dwoZRQHht9hpOThQCFlCuXEaF8soyOs7+4fm+lqwRxwUKqP4Tw4
         /LLXFiMZTKCWRXHO6rdKXQseA9rWo0neSjDhNqu8OUYa+FZjV7tWhPqfvNVzaDkOz5B6
         oYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793622746; x=1794227546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xnfmuth4GfVE2DkgiLmsPIZ8ILT7OTtQGQS1uT6EliE=;
        b=SC1R7gc7v6HaErnRtHv7LlJW+1hhHYU7zpdYAo5Ia1aWXSnIOOUO3OP4BQbZDGenQY
         Zpj54jkU1HZ78xi8YnADVUx+fILlyKcdVKI3x15tAPSZynnACX70GJ3kHWXvgKn9t4w+
         xyJOL/1Sx+4FLBqIdrAfwylvtvSFcuyJMZd3EW0qTmRGz3wCKfCDdNeBBYJUykLH369e
         TjbjobWx+n9ZnSWfh9uHrITFxCx7VRQ8PgS2kI6aFen+4m5y7MVJwMzxazb0IwqknQLZ
         U/1ocsm2L1907pJBpizmI168MVlx04uGPz/ea2njlU9gHhJi5C8z287kObbALJOf5riS
         abgw==
X-Gm-Message-State: AFq9FYK2Q18x2C2E5UdOAUuUVwINAm5ExALLks08nSWlXiw7eVKsmiQx
	xScVbsYAI6XxnVkMMBz6E+SsYAoaoDd/y+B9RMob1EXYqJj6bbSSGOI1
X-Gm-Gg: AYBFou3fWXTMdIQMK5JioqRVyEfPEV/EauIYfog1anpmZ4ACQ3mkgY1rOCJpX9/QcMa
	UBmXbQoOo8MrhWZe2cAVYYAUsVganOH9QXvm9eB7010+Sfu7/OJQbo5Hno8G+ptiYDf54h8RLtR
	WELlDgKHFBvvQzwHjCNANEkKmtCZw0U8efl8IH6aTZi5wZb6NayIQrFDbav/+Ul0uxsNHvPHaqr
	MHVRj8fzArBBc5gSCnGj+yqkeU5HUvE0Wob11oNLwiyZWgDAO5wdBuk2gbRPdKMIfgB9Oa56LDv
	YqtBKf0tB/E0Q6c13Q9B2xZoXSTayKF4Fda46yKwBS7wPFbDktdEYJOjWahs52+YoLYY0v5DYGu
	1Mcnt6oeIVwJ1J9FBVLD5FuiwollRdouOCfcpZRTlg6mIhaOc9RoRnHk6yeTfNKI2VX1OrxJIhr
	jdzT4ZTxz4BmQ19SC1/Cz/1gXV92Sc/DFvvfsSlqZ7EPZ0MEu0nMtjoGLJfWAmuSLLUc2cn8yEe
	O2vC217OCRf9PTBlwM2V20UroSAzdmHuFjupkClq3wZ6PwtzTX5xi5qvDDTMeHMrtj+V6OseNVj
	BegP/Z5HRD8JaLGWy+ZfEXvZ
X-Received: by 2002:a05:701b:2910:b0:1ac:1022:b60c with SMTP id a92af1059eb24-1ac56c9fdb1mr14250539c88.1.1793622746035;
        Mon, 02 Nov 2026 04:32:26 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b2360d2066sm4950951c88.11.2026.11.02.04.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:32:25 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 02 Nov 2026 07:32:12 -0500
Subject: [PATCH bpf-next 2/4] selftests/bpf: Run the patch list tests with
 bpf_jit_harden off
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-bpf-patch-list-followups-v1-2-ddc8ccf40f43@gmail.com>
References: <20261102-bpf-patch-list-followups-v1-0-ddc8ccf40f43@gmail.com>
In-Reply-To: <20261102-bpf-patch-list-followups-v1-0-ddc8ccf40f43@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

The patch list tests compare the xlated insns of their progs, and
patch_list/line_and_func_info and patch_list/poke_descriptor look at
the line info and the poke descriptors of a prog. They run serially,
because other tests change net.core.bpf_jit_harden.

They don't set the sysctl themselves, though. When it is 2 at the
start, constant blinding rewrites the progs: 8 of the
verifier_patch_list tests and patch_list/line_and_func_info fail, and
patch_list/poke_descriptor passes with no poke descriptor to check:

  XLATED:
  ...
  5: r12 = -360925233
  6: r12 ^= -360925238
  7: if r1 > r12 goto pc+3
  ...
  #719/1   verifier_patch_list/patch list: forward jumps to and over patched insns:FAIL
  ...
  test_line_and_func_info:FAIL:fn_1001 unexpected fn_1001: got FALSE

Set the sysctl to 0 while verifier_patch_list and the first two
subtests of patch_list run, and restore it afterwards, the way
patch_list/classic_filter does.

Fixes: 67d4d0b73c29 ("selftests/bpf: Test jumps around patched instructions")
Fixes: d86e6695cb2f ("selftests/bpf: Test the tables that follow patched and removed instructions")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Closes: https://lore.kernel.org/bpf/DMKHZS5B5CNO.186F6YH1T6YU4@gmail.com/
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/patch_list.c | 10 +++++++++-
 tools/testing/selftests/bpf/prog_tests/verifier.c   | 17 +++++++++++++++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/patch_list.c b/tools/testing/selftests/bpf/prog_tests/patch_list.c
index 127ed58cfc39d..43bd8a4428060 100644
--- a/tools/testing/selftests/bpf/prog_tests/patch_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/patch_list.c
@@ -243,14 +243,22 @@ static void test_classic_filter(void)
 
 /*
  * Serial: the xlated code is another one and there are no poke descriptors
- * while another test sets bpf_jit_harden, and classic_filter sets it.
+ * while another test sets bpf_jit_harden, and classic_filter sets it. Keep
+ * the sysctl at 0 for the subtests that need the code unblinded.
  */
 void serial_test_patch_list(void)
 {
+	const char *harden = "/proc/sys/net/core/bpf_jit_harden";
+	char old[16] = {};
+
+	if (sysctl_set_or_fail(harden, old, "0"))
+		return;
 	if (test__start_subtest("line_and_func_info"))
 		test_line_and_func_info();
 	if (test__start_subtest("poke_descriptor"))
 		test_poke_descriptor();
+	sysctl_set_or_fail(harden, NULL, old);
+
 	if (test__start_subtest("classic_filter"))
 		test_classic_filter();
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 99f0551c8b592..1108fd5e4d162 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -6,6 +6,7 @@
 #include "arena_noarena.skel.h"
 #include "arena_kfunc_jit.skel.h"
 #include "cap_helpers.h"
+#include "sysctl_helpers.h"
 #include "cb_refs.skel.h"
 #include "verifier_aggregate_arg.skel.h"
 #include "verifier_aggregate_ret.skel.h"
@@ -288,8 +289,20 @@ void test_verifier_netfilter_ctx(void)        { RUN(verifier_netfilter_ctx); }
 void test_verifier_netfilter_retcode(void)    { RUN(verifier_netfilter_retcode); }
 void test_verifier_bpf_fastcall(void)         { RUN(verifier_bpf_fastcall); }
 void test_verifier_or_jmp32_k(void)           { RUN(verifier_or_jmp32_k); }
-/* Serial: the xlated code is another one while another test sets bpf_jit_harden */
-void serial_test_verifier_patch_list(void)    { RUN(verifier_patch_list); }
+/*
+ * Run serially with bpf_jit_harden at 0: blinding changes the xlated insns that
+ * the tests compare, and other tests set the sysctl.
+ */
+void serial_test_verifier_patch_list(void)
+{
+	const char *harden = "/proc/sys/net/core/bpf_jit_harden";
+	char old[16] = {};
+
+	if (sysctl_set_or_fail(harden, old, "0"))
+		return;
+	RUN(verifier_patch_list);
+	sysctl_set_or_fail(harden, NULL, old);
+}
 void test_verifier_percpu_addr(void)          { RUN(verifier_percpu_addr); }
 void test_verifier_precision(void)            { RUN(verifier_precision); }
 void test_verifier_prevent_map_lookup(void)   { RUN(verifier_prevent_map_lookup); }

-- 
2.43.0

