Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1624A4EE4
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791468236; cv=none; b=pvgy0q9F0rTsB5X2UiscIVQMJGon2+u/RsG/BywtTYmwQln3O/fPYm7pUQechQfzXp2Zn3sMmFbAVEvfOu6K4kIsp8XAbIK8N3Ri2wBykt6FTYVqvuNzl+5RPWyYzYI5zC7LCGOzQ/ebWYuk4TbqyvbXyx93Ljh4qQVBV8xdYq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791468236; c=relaxed/simple;
	bh=hSnqrYr59r6+2IrGfqK0dOpGKMpQIyo6f4j/GsC7lx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UWqvBmGYh/BoLUkZbYb0GY38gGMG0V5ksZ2H9vj7SUDodi0iSexpgegTEBb3K9rq3GJEMKmSB5upnchFX+K1OzQg+0dkkfyeR7u0eh7aL3K0VbfiNbR6TdjtzgTAULr9vOww+L9huzx+QS4fbBt7pxxJfyxN4OkC53QVWDmd06I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXhSEjqO; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXhSEjqO"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35154cb9de2so4376013eec.1
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 07:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791468233; x=1792073033; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pPHduXWA0u9IbJBWg3xAHMNW8/DANfhF7wZagwVHkdg=;
        b=kXhSEjqO99e73MLulZHcg0M9KdxMg8g/I8cll4DX7Mlsox8mPULhcifvSAOSSvHlM1
         TVjoPs+MxN7lTgq8A0U7VxZOcc2V6Gzo/6hBxZggQvVxb8msQZvliDmQ423vvgedQOI5
         dPcKzuiPDgBwxgcBIMgTTtpbVt40WMWfHcF/heaxVl+d9Rwsc5/NswcBlBfEdyDHE7+H
         e4aRfNASK/MfCmURYp4H6HEWY2SggBlUBVoR/FfeRyRe+JfwtwVrUftpSshKPaLd0Onc
         t9S8upARDU0ponz5M0mahMSjyxrVcAi52uiwZAZvN2/MZRGbFPOyWNJychBGK+iSKrEH
         8xQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791468233; x=1792073033;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pPHduXWA0u9IbJBWg3xAHMNW8/DANfhF7wZagwVHkdg=;
        b=J6HdWku6JESBhkEM1Kupm6nyF+8Ba7touNPwLcS0VRxWgRWX6m7mxEt2QJErnWdsUg
         xxYYPEXtIYknuhjdCiPACZlWSkOlVOS8CJY/mrlION2X77ORawtATr6qTagc/0TUscBQ
         Gh+6FrPyFeQN+f2JpWyFsKZ+3ePLr+laPbwP+OXQjMG+UhyQIFuNcGpK/FwULvRmAEsW
         tTTgfzo6J+foD+wRzX5zz7rhFgBaLpUmCtB6bBVsfTssoESVXMiGUChfS4ZSixA0i9/v
         tdhCUvWAPUPxVMgWO94vuVbrF44h5Hv+d7FYLcBm7Ai5D0FoMAOZQDCbqv1Ek897J60w
         hXSg==
X-Gm-Message-State: AFq9FYKCTMpyIlcBE1JTBzMAyDKDlCuSa9Ef2A72AyJRQhCEHhaTjLc5
	L0LL2cqOF/mqgKdmK61YD+Rcs+EE7QDrhyHlC4C34JU15cwtqcuGe1pZRV05V8751uXo4g==
X-Gm-Gg: AYBFou17bT9RVnnwS8x5Iyk33ku9rlNaERe5LAB4ukmr9gJ4zBqYkt29Cm4GC6VBhud
	tEdDiCjCpkwQS5RQMxyyzxV2fkMuPUmBbqDrAagZIOT0nHaL7YnvZTCEjPb3XvA9C0GCl8m98iN
	wtzPdqkPut75gErBNDh8HgeRRu3Peck/UMMiAZnodGW4WUiYkfxwnHjcanSGVBCZZ9QfDgYpFAi
	S4X6ZU3ZT9SO9/RSpvY3lylru/6tOj0izpA2kJDw5g2wkNnXzTCwAUoCV5TdJqszecYCTmFWAH4
	OgyxDK1XhdnlBdafIONNk0JFQfjtAs1tffAbZFegJqnIbHySEol98EE1LVQp0QL86q9q73g3qER
	Wa1cAMEI1cnH5frqdZ8bF9ksbtw1R+b1RHGimpUr9jfuiVFMwJlyww7tydpQeXzog9JeNsUbohW
	eXOxPLLB3sXqTlBdnrnAOhCdHqZiSH4rpeppJcmhyH5dMrGt3VTgMUDUwgg3cTMmffLQ==
X-Received: by 2002:a05:693c:2512:b0:33c:e82:70c9 with SMTP id 5a478bee46e88-3515dea1d6bmr6528070eec.32.1791468232971;
        Thu, 08 Oct 2026 07:03:52 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515aeb5c00sm16629124eec.8.2026.10.08.07.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:03:51 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Thu, 08 Oct 2026 22:03:47 +0800
Subject: [PATCH bpf-next] selftests/bpf: Expect at least one tp_recursion
 miss in missed
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-selftests-bpf-missed-tp-recursion-v1-1-0dd60471d655@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMKix2oC/x2NwQrCMBAFf6Xs2YVsCkX9FfEQ0xdd0BiyUQql/
 27qcQ4zs5KhKozOw0oVXzV95w5yGCg+Qr6Dde5M3vlJnDuy4ZkarBnfSuKXmmHmVrgifupus09
 RZDxNIYxCvVMqki7/x4V2KWNpdN22H8QQqnl9AAAA
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

missed_tp_recursion attaches its tp programs to bpf_trace_printk and
expects each of them to miss exactly one run, the one that its kprobe
program triggers by calling bpf_printk().

Any other kprobe program calling bpf_printk() hits bpf_trace_printk as
well. When another test runs one in parallel, the tp programs that are
already attached at that point count an extra miss, and
test2_recursion_misses comes out as 2 instead of 1.

Expect at least one miss, as missed_kprobe_recursion does since
commit 08a7078feacf ("selftests/bpf: Improve missed_kprobe_recursion test robustness").

Fixes: 85981e0f9e9f ("selftests/bpf: Add test for recursion counts of perf event link tracepoint")
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/missed.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/missed.c b/tools/testing/selftests/bpf/prog_tests/missed.c
index ed8857ae914a6..0b8f1aa5a3e74 100644
--- a/tools/testing/selftests/bpf/prog_tests/missed.c
+++ b/tools/testing/selftests/bpf/prog_tests/missed.c
@@ -120,9 +120,9 @@ static void test_missed_tp_recursion(void)
 	ASSERT_EQ(topts.retval, 0, "test_run");
 
 	ASSERT_EQ(get_missed_count(bpf_program__fd(skel->progs.test1)), 0, "test1_recursion_misses");
-	ASSERT_EQ(get_missed_count(bpf_program__fd(skel->progs.test2)), 1, "test2_recursion_misses");
-	ASSERT_EQ(get_missed_count(bpf_program__fd(skel->progs.test3)), 1, "test3_recursion_misses");
-	ASSERT_EQ(get_missed_count(bpf_program__fd(skel->progs.test4)), 1, "test4_recursion_misses");
+	ASSERT_GE(get_missed_count(bpf_program__fd(skel->progs.test2)), 1, "test2_recursion_misses");
+	ASSERT_GE(get_missed_count(bpf_program__fd(skel->progs.test3)), 1, "test3_recursion_misses");
+	ASSERT_GE(get_missed_count(bpf_program__fd(skel->progs.test4)), 1, "test4_recursion_misses");
 
 cleanup:
 	missed_tp_recursion__destroy(skel);

---
base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
change-id: 20261008-selftests-bpf-missed-tp-recursion-2fc11396aa31

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

