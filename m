Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C127637DAB1
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786105992; cv=none; b=XaUsbX3SC0i1+HviadfeC+9UsCryzjjQnaLf9AL2ilgGFSYfamslQcCgzlbp71yCYwV/udURINRhj31Gjqmqd8NdakExJ/ts4ocJa1MlaksnyhIFVxpi5lUArxNCytmUwYj0tS3ZZlrOOnha+yprZrBzLRM2YdbXfm7Qg5fZwWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786105992; c=relaxed/simple;
	bh=PDu+3BXTyXpwPgVrtJxUe/m0n6DzpTg9MQ5tOKffmxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=soD9556o3v7SkRK03irBM5WVLQFU9jKfxmiKNol+cpvXwAnbzULf/7GM/eZ8WlDWYlZo/LyN2+SpjYcCjlxydZXZ94ypV2kc6dyArm/nP1cMA8qnOv0LyZjQogL3MMX6G+rG9IlKC0TEdtani0M8g/4FuKvBYxu1kAFrrPysFqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=Db1Is0pI; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="Db1Is0pI"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e6b5737bb2so2922653a34.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 05:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786105980; x=1786710780;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aBpSBcnVEC7d3b8VCypHKN8KFVfSMJhdR2dxrFOJYmQ=;
        b=qHLEWyQUYaBHnjqMeUU5rKYbxgBwWrvk45esXvXDlIlFb+TZ+8UskOoDN5pSEnMeft
         XotoKY0Z83A95K3JSTKaME4wNiJ9kPiIXW4uAXcHcScwlViD5oJXP5ix6wVlKrPRoTJd
         XY9heUznPrRNxF2ekEjs8vGYtrtKG3ZFpOBe4pSTk6+yR0BgIfb5eXi8H//5XNUuMS0S
         ZW9cslqElbSkqTlWBu2kOZXqNmz6k5q1rpiradbX3tB02YF8lRdGm/hXxOAlP2PS2mf1
         vV8z7MLokbHWcrtXXfE4/tDDv1z1D2nn0U+NoIAyQFKl9bpS1OCbzaJgpvxb+yZ10aYo
         aTqA==
X-Gm-Message-State: AOJu0YwbFQ2neEA9TK34l73KfX/EI0vpS6Ypw2k08qnUW74ceDoqRNpa
	nAj8hhyGaHJhKq796N0qJ32qnoCU3ACt7iblxjuWB31cqwjwvGT5lRpK
X-Gm-Gg: AR+sD11R+MzEr5MnW5gk+aMFggUNaIq/DZvncQnVRF6a7Zc336aaeJCF3Za952r94W4
	I9CrNQblvI4dvBCzWwapjRNNYMnDh5yoxQSF3WgIOOoXYhWYlqirxb02W1J5Ea9Sn2wrURjjGL7
	9KyFWIUVXpGmMvbuDT15ePjQn78NO39S8hXFy1WI9w/69dEZJ7HVVba+qQrWIjrVIitLj6/rudZ
	AuoGSTvL1hrN+lP634r601+cPYnPvvOc3z+GMkWl07QakIIwhfDG49+/dMxZ/r9hG+ZFnfVnYom
	jB7nxVdAa3yg8im6TbkuwTRfh+LUU9KyjPcT2zi4+mpA21P9HALd1qOaAmx57IIu6EBpWt9r8DL
	9K2NgoYyQAt8vatwwyzHLQKmTYb/rUcjwrQp/wgcs7ZhHZHR3yAyL3OzQN+cYu9eJtljDRvCXwy
	13hZgJuuf26yI8O+hf/EnBXMDSDRjX3F7Cr/CibYWUSk4a6UkRH0yuuyUYxrQGsSyS813cGodcz
	9lPqVpVW21E6YYGSUaaNwovDtwPrsnJKoSFjaFUSKzhS24BDGVQ7txFxdjoMmbvqvASbzIxGHVu
X-Received: by 2002:a05:6830:67f6:b0:7e9:d3aa:e391 with SMTP id 46e09a7af769-7f1e5d182fbmr12781875a34.6.1786105980389;
        Fri, 07 Aug 2026 05:33:00 -0700 (PDT)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com. [34.66.65.137])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b807227sm1141532a34.27.2026.08.07.05.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 05:32:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 802C760895;
	Fri,  7 Aug 2026 12:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=dkim; t=1786105976;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=aBpSBcnVEC7d3b8VCypHKN8KFVfSMJhdR2dxrFOJYmQ=;
	b=Db1Is0pIQ3dOMju6mbp/5O1REnHMBoPTWAqsfE0Qv0lrG5Q1cHjx3P2j+N9N9osDfB/WQ2
	TQU5aE36pTpS96xn6y7I7WthValEuCGlBp3F5PUFSBCJzCa/51x7MLnRb7Qn3yB1VqjGNh
	LMyM1Z5WQZzKUH7QHUXg+QSreZmP+zBXgdWiFRP2GB1pIJrWRHoSyFdvYZqW8HKnTWVRDZ
	fs/ofJ3nkYvNbRTU6ltnuoxxwaiLzsjsJvaQAKD37938LN5G2pLLsX9bVMe+mpQ9pnk5oX
	/l5ANzKpXlYNhRNSoaCKqh1OaVpf4dM1rXgze7cxz3+F33pVA73ZEzHzgqaIRQ==
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
Date: Fri, 07 Aug 2026 09:32:43 -0300
Subject: [PATCH 7.1.y v2] selftests/bpf: Add tests for sleepable tracepoint
 programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260807-selftests-bpf-sleepable-v2-1-f7e6566f36a1@marliere.net>
X-B4-Tracking: v=1; b=H4sIAGrQdWoC/4XOQQ6CMBAF0KuYri2hFRRceQ/Doi2/UoNAOpVoC
 HeXoisXupw/My9/YgTvQOy4mZjH6Mj13TLI7YaZRnUXcFcvM5Op3KdFuuOE1gZQIK4Hy6kFBqV
 bcEBbWZd7KVPBlu/Bw7rHKp/ZIRHJk1XvmO76ChOiGg+1InDtVWeaGFGIXFw0jkLvn2u1UazO3
 xaj4ILXJjO6KHaHDOXppnzr4JF0CFH9EPlvArK0Klc2E+KLqOZ5fgEA4JSwNgEAAA==
X-Change-ID: 20260803-selftests-bpf-sleepable-eebf2d962201
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, sashal@kernel.org, 
 gregkh@linuxfoundation.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1786105970; l=2967;
 i=ricardo@marliere.net; h=from:subject:message-id;
 bh=QLheeulIJ7HGlvz8iFzvKmtgtUgQwyFXfWaZE6pfNsQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QI1sbqPaaYnCoqAVjS7/0CJAD6XeShanEL7075pmHQDoR8FTDMKYyPWGpnevcLGwjyZ+7e077gy
 AWSb2I+9WMAQ=
X-Developer-Key: i=ricardo@marliere.net; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Last-TLS-Session-Version: TLSv1.3

From: Mykyta Yatsenko <yatsenko@meta.com>

[ Upstream commit 8a20655749c625dcc4debdfdeeaa0cf8bb85c203 ]

Cover all three sleepable tracepoint types (tp_btf.s, raw_tp.s, tp.s)
and sys_exit (via bpf_task_pt_regs) with functional tests using
bpf_copy_from_user() on getcwd. Verify alias and bare SEC variants,
bpf_prog_test_run_raw_tp() with BPF_F_TEST_RUN_ON_CPU rejection,
attach-time rejection on non-faultable tracepoints, and load-time
rejection for sleepable tp_btf on non-faultable tracepoints.

[ rbm: Removed hunks from (new) files:
        tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
        tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c
        tools/testing/selftests/bpf/progs/test_sleepable_tracepoints_fail.c
       These rely on libbpf's ".s" tracepoint section handlers
       (0cd420a6f40c7) and on kernel-side sleepable tracepoint runtime
       support (439ebd5b5708, 12628ffaf98b, 57918341dd19), none of which
       are backported here; kept only the verifier/sleepable.c hunk, which
       is correct and needed on its own. ]

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/bpf/20260422-sleepable_tracepoints-v13-6-99005dff21ef@meta.com
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
Changes in v2:
- Dropped hunks which miss dependencies
- Added a small note about it in the commit
- Link to v1: https://patch.msgid.link/20260805-selftests-bpf-sleepable-v1-1-e29fa5af4119@marliere.net
---
 tools/testing/selftests/bpf/verifier/sleepable.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/testing/selftests/bpf/verifier/sleepable.c
index c2b7f5ebf168..6dabc5522945 100644
--- a/tools/testing/selftests/bpf/verifier/sleepable.c
+++ b/tools/testing/selftests/bpf/verifier/sleepable.c
@@ -76,7 +76,20 @@
 	.runs = -1,
 },
 {
-	"sleepable raw tracepoint reject",
+	"sleepable raw tracepoint accept",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_TRACING,
+	.expected_attach_type = BPF_TRACE_RAW_TP,
+	.kfunc = "sys_enter",
+	.result = ACCEPT,
+	.flags = BPF_F_SLEEPABLE,
+	.runs = -1,
+},
+{
+	"sleepable raw tracepoint reject non-faultable",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -85,7 +98,7 @@
 	.expected_attach_type = BPF_TRACE_RAW_TP,
 	.kfunc = "sched_switch",
 	.result = REJECT,
-	.errstr = "Only fentry/fexit/fsession/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable",
+	.errstr = "Sleepable program cannot attach to non-faultable tracepoint",
 	.flags = BPF_F_SLEEPABLE,
 	.runs = -1,
 },

---
base-commit: 74b69060ba6e44e20c2e4dc1847eca21db6e4a7c
change-id: 20260803-selftests-bpf-sleepable-eebf2d962201

Best regards,
--  
Ricardo B. Marlière (SUSE) <ricardo@marliere.net>

