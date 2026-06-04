Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AEB33EB06
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586634; cv=none; b=QsPn7JcZy0gV5/jtzqQ4sXiygjNe8/GQ9PttNxUI8CzaUA9U6ZGg+4sI1Q2yOKrz6I5VevN4iHIbmu4vjLB7ppbeqH2DEnv8mIVvJE+37qIpjmhEKC2p5Xf/b7uhwEh6l9o/EBxSPb2htFtsjCeeDaqC0ILQvdkpKozG8tAhyW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586634; c=relaxed/simple;
	bh=95kni8HQazuDcL0ympluLEzhJLkWzdMKC9pwnpv7hSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VTV5b8cWhXzxjie7WdUpsiWa/sW4yfHExMWjVCfuZ+Fd5Sboc/8GziVKhjvf5F+utV8fo+CMIBfJcEJgwZIk7DCSJFUSJSlkwDNJtuL6+4EC5Mph6u0ML0/nfYHzh1jf59Wf+iGzxkmxYgi++KhVxvj6WEv2s5SMzNfTCBh+mIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDZKzgpE; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDZKzgpE"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2c0c2c7e0c5so6050585ad.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 08:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780586632; x=1781191432; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Yc+URibwRi6dCLLpz9Jk7Op5vAlkYtzhW0j7vQLlJk=;
        b=cDZKzgpEQ+V+bQ3jbewIOLdmY/nfYMCBZEWZHDYGvh7fuVsuYcq2UocPVuslF/Ilq1
         BO0i/yTGV+zA1yXi4ninyTL05aZrbiBMpNkz2AiCj1eOL1yUISB7xSZStE+R3zHi0mMn
         8U6SxMJUIw8xXT6yn874hqsetXd1WsDB22eOEvcgXJ88Q+qg2h0eSQmKfJEVG5/3loXp
         VDd94DBMBfvA5VCsBleKp+FEVggM6OT8Ij53TpztUd09jkCAuPTPmuoHelzrRek1qiHv
         UouGn7Ip8PwMgFK2AHM/98vVH6jHBhzGFs/eTzd8o/VmUFVwngg8zut1r1YMLkVO3bK7
         g+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780586632; x=1781191432;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Yc+URibwRi6dCLLpz9Jk7Op5vAlkYtzhW0j7vQLlJk=;
        b=G82EgKWQoiLcfa4n+CdmFMJND3zYIkz7DyZoSarvS66WzDiJ2BHmlPUcD3BZaG3ht0
         Aup4eHuwDovfwnOAlb3SRcljjeiQnu9Ou7YN7FnAWV0Hq8XREjEsLVQynkg+KdefD6vK
         drD9R+EHsZ12v86NARmWCDXTZK0xPBeMNxb8BE20zm94qdIM2XXeBsztkose7rmAOVwW
         Zg8zUmkXByhEnls3Dva7ir18sCxtmdYse4M/tUya+yNuQn4ZdXiTHBZ8fd+60meS4bLH
         ToW2tTKZITTpdCkcTP9MR0OnOzFcQPrA9OKSF5F54ji6RSgmB+nfWiUwGulyIja21R8C
         cYkA==
X-Forwarded-Encrypted: i=1; AFNElJ8OXeqdYmSxebI07NE/124ay0fsIvPjQeO/llHXMxa7TbzYUs1iMgcFxRvsJ06ejxP+LVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyneES8YGdZ6Or5OJpFILXfih7tvr05IOoxySGaQZT+1UXucdUh
	h/IQt0wD/EL3rVR9zjeqG5LxlZvdP9ZjGbM6ov/PjBreFTG4u5iXLT4M
X-Gm-Gg: Acq92OHgG1XUv9h1c+06f1Mlyxh0U0DbZLXJb4ev8ILti9osGg+YFKwRVr5fN7KJSse
	zzJT/i5VGnUfyDsd6FpRhNM0QakyP9uokQUVj+PY+G/rQqbZU4MdoVcW2ErWzcLXmcyZJEdszrt
	ex7/91293wOC0o6rHAj2O9u+YstokCED2yNBqIJEX8STeokpREZyHKr9yZjiofmGarX23mzDFna
	nDbnUnvssTYfAOKB2p8V3Qo3y5NZ2BFCOsEgFIwroA2e+C9cKyopNQy4vg5XD8Wnj33awkV+xU3
	Nq1vNFBSHlBotViruOTFBg5/dQ69bVrnP8zd3nsCM/0rkUxWacHY2ofLkIjIrXHlwUEs+7YBQSu
	t69AQQ6Cl2y75ZhiWKAm2Ow4pF9Vrl7IHrLimEZBu+UlY7HCmBP3DM28oYPm6yfIyJFCQkkCLcJ
	piYVIebMEhno8ewwRJWPzh3EoUDJWexZ+4bWB6DSKH2THCNN2+U1c=
X-Received: by 2002:a17:902:d592:b0:2bd:a529:4b5e with SMTP id d9443c01a7336-2c1644dc8f7mr86507235ad.41.1780586632120;
        Thu, 04 Jun 2026 08:23:52 -0700 (PDT)
Received: from [192.168.0.6] ([223.131.147.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649fcdfsm81544985ad.78.2026.06.04.08.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:23:51 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
Date: Fri, 05 Jun 2026 00:23:42 +0900
Subject: [PATCH bpf-next v2] selftests/bpf: Add arena direct-value
 one-past-end reject test
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-arena-direct-value-v1-v2-1-a92cb281e376@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOwQ6CMBBEf4Xs2TUFFNCT/2E4tGULa7CQFhoM4
 d8t+AEmc5nMvtlZwZNj8nBPVnAU2PNgo8lOCehO2paQm+ghE1khCpGjdGQlNuxITxhkPxOGFMl
 cGlNdS3WrFER2dGR4OXqfoEaDlpYJ6l/iZ/WK9F6733bsp8F9jgkhPYg/36JSLFWeai1kpaV+t
 G/J/VkPb6i3bfsCi5eyjtYAAAA=
X-Change-ID: 20260603-arena-direct-value-v1-ef4df857b98b
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Emil Tsalapatis <emil@etsalapatis.com>, 
 Junyoung Jang <graypanda.inzag@gmail.com>, 
 Woojin Ji <random6.xyz@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4586; i=random6.xyz@gmail.com;
 h=from:subject:message-id; bh=95kni8HQazuDcL0ympluLEzhJLkWzdMKC9pwnpv7hSY=;
 b=owEBbQKS/ZANAwAKAUOXRMMVrfhrAcsmYgBqIZiEf99tri7zvOqby/mMpue3vHl1wINfzsbCI
 YsSAfpToRmJAjMEAAEKAB0WIQSrknTJbxUcAdPNt5BDl0TDFa34awUCaiGYhAAKCRBDl0TDFa34
 a0IpD/9ys2rncP0odXFe2D8VhkkV4OHfcV5ypPhwADvPEK6EnncWrX1febkEfRK70eK9Y5cCfOs
 GJ3prW9ylNi9c4kdsdRHDSoPWe4MG2c15Mz8WYTFa5FKTZ1DMev8CViZ/xmqQcTT+zIV2y80Mzi
 jyGWiRqDC78lKPZPTneCCPa7eK63LOJvuKVjexoerxhZAI2z11n1xz1z10YDRJfl9WjGN8rYysp
 U0VOrSNKmtYj0wg6hb2yjZJuXX4NFdeKgFBY6tzyNqlr3wmM0fiJYFiia8uX2rJyGS4T015GOld
 JLokrEP4k3b6Cdm0Fbcq1myIZnAh31z4NgGQ23P2EKlAMli0pFi0Rrho4X9eGDahWPeuh6koGA0
 Z76+RsCkw2eyRrTuJVtK998eFcGp/l4Ii+cFbu+0F5zkcsnPPLvGN1JRsedKX+luuaepb1NnGFr
 GgkoA+0n4MuB95vWXcM6TRUMlxbQ3xqamT5HortQ68ROe1Vo/8PqzwVM+Vo0du7tU4xFPeaEyZ8
 FEg86TqJr5N0fBIeQ0RNaWEA9bpysjvm+VQklE/QuXqxmyzOOIso434MShU5vYODPAM0kQNARO+
 XWFUaVowNd67yXCGHkWc3vkcnd7+Ff9Q5SzDQMcj8EqZI9bievsPW5RYZ5l6Fdmhg1B65/fgIHr
 3efXVNjmeobO/tQ==
X-Developer-Key: i=random6.xyz@gmail.com; a=openpgp;
 fpr=AB9274C96F151C01D3CDB790439744C315ADF86B

BPF_MAP_TYPE_ARENA supports direct-value pseudo loads, but unlike array
maps its map value_size is zero and the valid direct-value range is the
arena mmap size, max_entries * PAGE_SIZE.

Commit 3ac1a467e376 ("bpf: Fix off-by-one boundary validation in arena
direct-value access") fixed arena_map_direct_value_addr() to reject an
offset exactly at the end of the arena mapping. Add a regression test
that loads a BPF_PSEUDO_MAP_VALUE with off == arena_size and verifies
that the verifier rejects it with the expected offset in the log.

This is awkward to express as a verifier_arena.c failure program. For
arena globals, libbpf handles the relocation as RELO_DATA and sets
BPF_PSEUDO_MAP_VALUE from that relocation. The second ldimm64 slot is
derived from the arena-relative symbol offset, so a C-level __arena
global cannot make that immediate equal to arena_size without placing a
global one past the end of the arena.

Use a userspace raw-instruction test instead, following the existing
selftests pattern used for direct map-value pseudo loads, so insns[1].imm
can be set to arena_size precisely.

Assisted-by: ChatGPT:gpt-5.5
Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Junyoung Jang <graypanda.inzag@gmail.com>
---
Changes in v2:
- Explain why this uses a userspace raw-instruction test rather than a
  verifier_arena.c failure program: the test must set the second
  BPF_PSEUDO_MAP_VALUE ldimm64 immediate to arena_size exactly. For
  arena globals, libbpf derives that immediate from the arena-relative
  symbol offset, so the boundary value cannot be represented directly as
  a verifier_arena.c C-level failure program.
- Link to v1: https://patch.msgid.link/20260603-arena-direct-value-v1-v1-1-7b31cc0a8cac@gmail.com

Tested on x86_64 with tools/testing/selftests/bpf/vmtest.sh:
  $ ./test_progs -t arena_direct_value
  #2/1     arena_direct_value/one_past_end:OK
  #2       arena_direct_value:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
---
 .../selftests/bpf/prog_tests/arena_direct_value.c  | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_direct_value.c b/tools/testing/selftests/bpf/prog_tests/arena_direct_value.c
new file mode 100644
index 000000000000..b7760b021670
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_direct_value.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <bpf/bpf.h>
+#include <errno.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#define ARENA_PAGES 32
+
+static void test_arena_direct_value_one_past_end(void)
+{
+	char log_buf[16384] = {}, expected[128];
+	__u32 arena_sz = ARENA_PAGES * getpagesize();
+	struct bpf_insn insns[] = {
+		BPF_LD_IMM64_RAW(BPF_REG_1, BPF_PSEUDO_MAP_VALUE, 0),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts);
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts);
+	void *arena = MAP_FAILED;
+	int map_fd, prog_fd;
+
+	map_opts.map_flags = BPF_F_MMAPABLE;
+	prog_opts.log_buf = log_buf;
+	prog_opts.log_size = sizeof(log_buf);
+	prog_opts.log_level = 1;
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARENA, "arena_direct_value",
+				0, 0, ARENA_PAGES, &map_opts);
+	if (map_fd < 0) {
+		if (errno == EOPNOTSUPP || errno == EINVAL) {
+			test__skip();
+			return;
+		}
+		ASSERT_GE(map_fd, 0, "bpf_map_create");
+		return;
+	}
+
+	arena = mmap(NULL, arena_sz, PROT_READ | PROT_WRITE, MAP_SHARED, map_fd, 0);
+	if (!ASSERT_NEQ(arena, MAP_FAILED, "arena_mmap"))
+		goto cleanup;
+
+	insns[0].imm = map_fd;
+	insns[1].imm = arena_sz;
+
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT,
+				"arena_direct_value", "GPL", insns,
+				ARRAY_SIZE(insns), &prog_opts);
+	if (!ASSERT_LT(prog_fd, 0, "prog_load")) {
+		if (prog_fd >= 0)
+			close(prog_fd);
+		prog_fd = -1;
+		goto cleanup;
+	}
+
+	snprintf(expected, sizeof(expected),
+		 "invalid access to map value pointer, value_size=0 off=%u",
+		 arena_sz);
+	ASSERT_HAS_SUBSTR(log_buf, expected, "verifier_log");
+
+cleanup:
+	if (arena != MAP_FAILED)
+		munmap(arena, arena_sz);
+	close(map_fd);
+}
+
+void test_arena_direct_value(void)
+{
+	if (test__start_subtest("one_past_end"))
+		test_arena_direct_value_one_past_end();
+}

---
base-commit: ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
change-id: 20260603-arena-direct-value-v1-ef4df857b98b

Best regards,
--  
Woojin Ji <random6.xyz@gmail.com>

