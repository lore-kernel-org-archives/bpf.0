Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5494EDCB2
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790847363; cv=none; b=p6oKx8LMnz+xpIppsR5x8lLn8hYtS0Ge433AwZlZCmjp3lcKHaxj6iF8EsJc+M5SEhIjH3M/whOX1aS1P49FdhNVMVED6jWTRa/NQpOm/ryNldg2zJ998BIVVbAEhXohbPIB6keJ93R+SRw2ntCCK0py6AdcD/VUHW3Yv9yK5yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790847363; c=relaxed/simple;
	bh=qm//W2ACASQMMeGfzC6o5JYQ2elhZbrpfT6Jvt75e2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W5Y4TDBTE4Kr3U/TJraVk0L5eQ5qWrA6YTAwTWuMqa+vn36z9zJ/iT4ND3weyy4BVEAEs/fkGhemZVefhoxkXLtfvS4s7gSpS+1QdnPn+EQDRuVagSGFy/Moj5O8VpOZkRSo8wgCdYX+lDFKf5W8fo6D0HH+F9PGynxtUvTjSbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K08kD4ow; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K08kD4ow"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-3396cec93b6so7171498eec.3
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2026 02:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790847360; x=1791452160; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MwUOMTspkkXHgX9A+hS2Ljvlb6FdIM56gQO1o7QfI6I=;
        b=K08kD4owIGCZSbX/GAUzwlgyWGXmOdXGiJdGMk+yu3NqfNrIqOLS6b+beDng63YN4G
         P37Z3Ty/oERaKdbLGX4Ms86ksSwSyDNe6ouFl5YJb0IOW2xx90QmtIUDeZxoc9B+d730
         MiAd1fhNI6cCaMv1m4yYh1Q32HsEFbvMgzWOMXGNamK6DHdK52fB4T4lEBLmnkjY1Tqp
         MUSKwnVdtFVD2BW6YKFU9raURf5ujgAPc0cqL7RxNUPeCVec62TWqDwU0tmLYi0rftU0
         XHDa0MpSktZlHSlCElYmpOYAhm22kfRtayPHVqth7gro9Vlt4B+JCyEuD3k6soTg9uUv
         c9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790847360; x=1791452160;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MwUOMTspkkXHgX9A+hS2Ljvlb6FdIM56gQO1o7QfI6I=;
        b=bqAJ6VZRvffYsN7mx0bRQyiWYMfDw4EFUZTri14YnwVHQ1lVMD+26k0kEXn4cJxxPo
         +UgFgN03gMWrAEVk1nyp9iArbYH9oKrLoXIxTSuEVi65cz0DiD1MRxRZD9i6cD3FLCQM
         cBFOdjUwqaBe5n4KlrkyysIeIFaPNP403UcRp8E33hRpVmPQghJYwIw1zflalK5f2vsE
         2G8g7FkDydu9Qj2+QmwmsrYR9B/P5kXHYqVM/2WteAhnYPhQr6ILX8cBbH5pFTCj59eJ
         FaeVUfIRO00+OxYj2bbLI2YhOR56bVoYQ6tOmahVdp9BuFRq1S69bswneksJnr2nen4e
         iNQw==
X-Gm-Message-State: AFq9FYJ+vABNE4d5HLyDhAgr93scHce+eEKcN+nejfjmqTBvO9RwGNqo
	T8+a0a5TxYT5FJISQkNH0fsGIx3IdHc+YFyT6PeEVh096pHnTlTa9Z5G
X-Gm-Gg: AYBFou3WQftki+QFuluUuBNtcwWGbloRk1kMr6SkFFj5iEyNY36XPDDCC0NTFYZ8226
	kAagl0Q3ZqnrxrhbZx5NAUrK7khfPwe8Ozz2A2GJ2gNJPnkNciA4fbK7H+iw9F0TUU6HZuUUyjt
	piPrDIKVDzyAfUacz+KB7APFlKvJu4Qe0MAu3Rz8cOTnYXpdaftHcInVY39N4rgXNfbwshn/n+L
	Z2yX9o/4xXCHxMoCYYarid701v6F5Ov32khA45GBcwvloYDCtfbx1jT1P8Wfrl5WqOytybloRLX
	8hffO68aEMsjJa7jhEQ8VV4ZvSco57BtqMHV65BhEkqnSDGlE0A2aZ5NRYd+keCJxD4aEl0ze4V
	K4k+x59pSj/0QJ2pTsNzARxhsvfb0vcOFjDj9dT+pVppv6w3nMYOJluKCzIyTLAQY1XazAMqqLT
	RZn8u8HKxPHy+06x/WOriDWFE6Qs5oTpHdB19lywebucucRsDIE1BvUbEO3EH3DW/AF/CNHUFSP
	fP0
X-Received: by 2002:a05:7301:6196:20b0:34b:7e89:9a7 with SMTP id 5a478bee46e88-34ce0156f04mr4369034eec.20.1790847360332;
        Thu, 01 Oct 2026 02:36:00 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db37507a7sm6003982eec.13.2026.10.01.02.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 02:36:00 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Thu, 01 Oct 2026 17:35:35 +0800
Subject: [PATCH bpf-next 4/4] selftests/bpf: Test jumps around patches of
 bpf_do_misc_fixups()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-bpf-verifier-patch-batch-v1-4-a12df8a09160@gmail.com>
References: <20261001-bpf-verifier-patch-batch-v1-0-a12df8a09160@gmail.com>
In-Reply-To: <20261001-bpf-verifier-patch-batch-v1-0-a12df8a09160@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

bpf_do_misc_fixups() now queues its patches and applies them at once.
Check the xlated code for forward and backward jumps to a patched insn,
jumps over patches, and a may_goto whose jump leaves its own patch and
crosses another one.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/progs/verifier_patch_list.c      | 120 +++++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 8a6d341b754ac..af107b0c1595e 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -90,6 +90,7 @@
 #include "verifier_netfilter_retcode.skel.h"
 #include "verifier_bpf_fastcall.skel.h"
 #include "verifier_or_jmp32_k.skel.h"
+#include "verifier_patch_list.skel.h"
 #include "verifier_percpu_addr.skel.h"
 #include "verifier_precision.skel.h"
 #include "verifier_prevent_map_lookup.skel.h"
@@ -273,6 +274,7 @@ void test_verifier_netfilter_ctx(void)        { RUN(verifier_netfilter_ctx); }
 void test_verifier_netfilter_retcode(void)    { RUN(verifier_netfilter_retcode); }
 void test_verifier_bpf_fastcall(void)         { RUN(verifier_bpf_fastcall); }
 void test_verifier_or_jmp32_k(void)           { RUN(verifier_or_jmp32_k); }
+void test_verifier_patch_list(void)           { RUN(verifier_patch_list); }
 void test_verifier_percpu_addr(void)          { RUN(verifier_percpu_addr); }
 void test_verifier_precision(void)            { RUN(verifier_precision); }
 void test_verifier_prevent_map_lookup(void)   { RUN(verifier_prevent_map_lookup); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_patch_list.c b/tools/testing/selftests/bpf/progs/verifier_patch_list.c
new file mode 100644
index 0000000000000..268cebd179984
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_patch_list.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+/*
+ * bpf_do_misc_fixups() guards each division by a register against division
+ * by zero with a 4 insn patch. Jumps to a patched insn must land on the
+ * first insn of its patch, other jumps must follow the insns they target.
+ */
+
+SEC("raw_tp")
+__description("patch list: forward jumps to and over patched insns")
+__arch_x86_64
+__arch_arm64
+__success
+__xlated("0: call")
+__xlated("1: r1 = r0")
+__xlated("2: r0 = 7")
+__xlated("3: if r1 > 0x5 goto pc+1")
+__xlated("4: r0 = 9")
+__xlated("5: if r1 != 0x0 goto pc+2")
+__xlated("6: w0 ^= w0")
+__xlated("7: goto pc+1")
+__xlated("8: r0 /= r1")
+__xlated("9: if r0 > 0x3 goto pc+4")
+__xlated("10: if r1 != 0x0 goto pc+2")
+__xlated("11: w0 ^= w0")
+__xlated("12: goto pc+1")
+__xlated("13: r0 /= r1")
+__xlated("14: exit")
+__naked void patch_list_forward(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r1 = r0;"
+	"r0 = 7;"
+	"if r1 > 5 goto l0_%=;"
+	"r0 = 9;"
+"l0_%=:"
+	"r0 /= r1;"
+	"if r0 > 3 goto l1_%=;"
+	"r0 /= r1;"
+"l1_%=:"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__description("patch list: backward jump to a patched insn")
+__arch_x86_64
+__arch_arm64
+__success
+__xlated("0: call")
+__xlated("1: r1 = r0")
+__xlated("2: r2 = 0")
+__xlated("3: if r1 != 0x0 goto pc+2")
+__xlated("4: w0 ^= w0")
+__xlated("5: goto pc+1")
+__xlated("6: r0 /= r1")
+__xlated("7: r2 += 1")
+__xlated("8: if r2 < 0x3 goto pc-6")
+__xlated("9: exit")
+__naked void patch_list_backward(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r1 = r0;"
+	"r2 = 0;"
+"l0_%=:"
+	"r0 /= r1;"
+	"r2 += 1;"
+	"if r2 < 3 goto l0_%=;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* The jump of may_goto leaves its own patch and crosses another one. */
+SEC("raw_tp")
+__description("patch list: may_goto between patched insns")
+__arch_x86_64
+__success
+__xlated("0: *(u64 *)(r10 -16) = 65535")
+__xlated("1: *(u64 *)(r10 -8) = 0")
+__xlated("2: call")
+__xlated("3: r1 = r0")
+__xlated("4: if r1 != 0x0 goto pc+2")
+__xlated("5: w0 ^= w0")
+__xlated("6: goto pc+1")
+__xlated("7: r0 /= r1")
+__xlated("8: r12 = *(u64 *)(r10 -16)")
+__xlated("9: if r12 == 0x0 goto pc+9")
+__xlated("...")
+__xlated("15: if r1 != 0x0 goto pc+2")
+__xlated("16: w0 ^= w0")
+__xlated("17: goto pc+1")
+__xlated("18: r0 /= r1")
+__xlated("19: exit")
+__naked void patch_list_may_goto(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r1 = r0;"
+	"r0 /= r1;"
+	".8byte %[may_goto];"
+	"r0 /= r1;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 1 /* offset */, 0))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.43.0

