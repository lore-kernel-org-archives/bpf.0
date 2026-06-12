Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0674263F44
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 05:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781242023; cv=none; b=CxNMEMSnwQRXnZCa/Gap3pLHec4UaRGg0XcDHiZKFc10OHgdCy4GAtsmmJ/UnXIcSOgJDFNVszxKR45Ku5rje88ddmFkkL/v24I5cPO+C/IQ7PLzYAXBEyMX8L2TVVixnHPACuzpxW7QVcMF4C6fDM2H1RBog/eVq1uSI/r4Xi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781242023; c=relaxed/simple;
	bh=mEa1UDXibng4aZEmUUdmn1PpPVWobuiZVmGl6pw7tWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GToZRrNdZnrOfL6mdqgc21KPbRyp5IAwUvPtxcctUfiR/Bssbtun4bpDTPY6Sqh4TmU02WOZ+H7/XDdb5hLyHcV6SxxKwjW7EPUPsR4HD8CqXFzRpzqBB4uCqPZZ+AvPmLfNWbuzr55j83IJ2mGtw4jbKAaPOSJqvDTAnSHPXvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXWXvgAC; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXWXvgAC"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-36d6bb38b44so464681a91.0
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 22:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781242021; x=1781846821; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=steX7CVZcw+IllDuKCNXQPf2WwxRIMRQi6FTVSo1n5Y=;
        b=DXWXvgACmLGqbl/co/JRpUftyjq7cy+7tYGOeERjQK1Wx4wsTa0eAEx3Ix8kE3yQAq
         8mcDI+3opiYihKRf3IIOwbp2IU+UQLCHM3Ays5Qvjdg4OtSK3GbLhfNgmluQYmkdpBGN
         QXXWY/BOxic5WIeOdxuCWFtj8hRGMk3zcabk/QX8lhikWM3URJRth2ln2Qm0Cc6DP17w
         K87Ya9KB6cE/sJzw6MHUS4gXOu/YqTFBvZscgU6me5Tw/Bx6eSXPaJwIa0wawMbz9J3A
         cmpEZxzSZkk74Ya/mVeN4vBEJ6nk21lG3v1FaeuwgL1vf4U3fNWuw2NDctvfU1aEmAI5
         uL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781242021; x=1781846821;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=steX7CVZcw+IllDuKCNXQPf2WwxRIMRQi6FTVSo1n5Y=;
        b=RnV9LBspoXpb2PiXYq47DaZjfDJTiU1YT8hVVU11NpOWwE/hx3c56sZeEs1VhnYoUR
         eQag2gUYrSx6u6JQ9/2OnEE+qepYO+cP84VClbfVfnUPyjPRT4WhISFSVHDZ7dtiSdgs
         736/mDyAJlCkBA69ZoJ6o2sX/0h19sz6xW5nEoXjnU7FQmUy4qSNlO66FAokK3YnuBP5
         Ej6vzw3cv/uwNL9LjxNRwQ9pPe5J5+aekbcLA1CnwQJIFzkIh9J7LBfyBapR3oMcJTmU
         45uaOYDkDvLbTm5PV9DP6SEHxLkrQMjrKjrlPnx858D7pfzFcw4UsI/jffWPOLBip6+C
         LtkQ==
X-Forwarded-Encrypted: i=1; AFNElJ/32CIg8Kpa+wpP9uYppm4rT916+eZGouLTkpJtPhWA8iclWE2Aepm3jHHY+UG+Owv9m9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYw8l4IXEIaFbH/BsDCXFsD4TZs/stS9C1rvGLygDVpLWxcff5
	V/QdlUHETVP7Ji3lxDfiq+QDXsnIcgaa3m8BHaD3vBJ7WWSboUvCSCA7
X-Gm-Gg: Acq92OE5rN7DHanyQIpzC10jz6385LqmpapXoeZMRvYMgxMis7HbH497k7J2D3pXjot
	zIq8WOV6fGicowagd3o0TBTK5wipYdEJ8JkbfwM13enfk+eZWH+AH5sLQLr4t+Tgj3SJ+/G0MXV
	sPc/TvQqm8KPWP9m7dCzX0H4hBdb/HtFEQb/AhVqXHqEl0Pj96GnDh27e2E/IZ9DZei/EKwytqP
	yKb5LZ/LDFGv0bdUFc+/r7D2zNpqqYKF1hdKEyv1QrB+y4pfk/OpB5VA4IFIIMV4iJMus+3VP0h
	jOLNUlJNa8N3S40GybvPzQ1FCofVjuvOgxtsXvIRMp1CUjbDUsqaONvJWE3zYMA2YL8RFZg26XL
	NWvvYXHcbTyfUba6jnWEgSHxL4Cg2tKAwCUrOuLmm3/5JCixGssHfAjDSNDEWz3c9R93I6ZmSl+
	WA7N7Dn04tvM5HfrBTdOQOrVeYT7yr+g==
X-Received: by 2002:a17:90b:3143:b0:366:132:fda7 with SMTP id 98e67ed59e1d1-37a02224be0mr1651706a91.10.1781242021010;
        Thu, 11 Jun 2026 22:27:01 -0700 (PDT)
Received: from [172.30.1.93] ([121.156.247.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a1eba8e9asm689172a91.2.2026.06.11.22.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 22:26:59 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
Date: Fri, 12 Jun 2026 14:26:55 +0900
Subject: [PATCH bpf-next v4] selftests/bpf: Add arena direct-value
 one-past-end reject test
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-arena-direct-value-v1-v4-1-b81b642f5277@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XOyQ6CMBAG4FcxPVvThbJ48j2Mhy5TrFEgLTQYw
 rtb8EJMiMlcJjP/NzOhAN5BQOfDhDxEF1zbpCY7HpC+y6YG7EzqESMsJznhWHpoJDbOg+5xlM8
 BcKQYbGZsKQpVlQqlbOfBunF1r0h1Fjcw9uj2nYRBPVJ6YZfduwt969/rC5GuiT/XUlFcKE61J
 rLUUl/ql3TPk25f643ItorYU1hSZMW0YiUFXuS/Ct8olOwpPClGWGIqLgAysVXmef4AkekRFmI
 BAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6049; i=random6.xyz@gmail.com;
 h=from:subject:message-id; bh=mEa1UDXibng4aZEmUUdmn1PpPVWobuiZVmGl6pw7tWs=;
 b=owEBbQKS/ZANAwAKAUOXRMMVrfhrAcsmYgBqK5iguc60ChqhIrG/i66KELkG0AuJHczqKG2yb
 pGeWKvfOZ6JAjMEAAEKAB0WIQSrknTJbxUcAdPNt5BDl0TDFa34awUCaiuYoAAKCRBDl0TDFa34
 azS9D/9Fppw6L72WULzhRoWLG3MEqgnEKltyQpOh2yjLB6Tz6glV0PNoHcemt0Vzx+1grGKqlHx
 1vRYnd48jDfyRDCAIrcLFPWFryE7ATB8wdQe1wq7Nd/uTbNZcLiCRhL3RffvLaGBL4ZWTXGLB5/
 r4Vh0W5jv3dFfKhx49zL2NkfY9cuL9k2bdKmzkTU+rzjdMNevNyHcZA373iDjbZ0i2ZY/oPQvOl
 BuJijGdwFR682NaAMlUdoCdlA1R7debQ2m1siCfj1sAjprfmZixXLkp5B7g97o2BEz/o1c7xx8A
 Edb6LYrOBrC22SouVtkjk2FqY3k8/qAdduJIyDo8Bbu+atwW52b0G00qh98OgsutLcX8tpRwmPO
 PNdsBcq4JAO434NjEA6CC3YHd5c9Cdfx0xAoPaTIJmy8FEHz3AeLZF+M9oDmIBZJpya4tQFZvqN
 mXRq7RA+tGufyKlohKBnOg1hOBrDBIcCfsELMIRkaX/2PB4hO24/e08IsIMSN33fpDQN9czeiNj
 +XwDBe589XQiX1Qpl2kg2gXU/cK3IO6GZV6BbCRGsCKW7htW/Lh42BAdRM0Gn4KPO7Xj2hbXWwy
 iU7L2Brpgizwdzp6+aaw9qn5LIrY+IH6hY091oOdWEnnPW3PesI8imYYoOqngG3b6hTLoDkT0uE
 lwtO/8GY3m0YC4w==
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

This is intentionally kept as a userspace raw-instruction test. I tried
expressing the same BPF_PSEUDO_MAP_VALUE + off == arena_size case in
verifier_arena.c with inline assembly. The only form that produces the
desired instruction bytes uses __imm_addr(arena), but that emits
R_BPF_64_NODYLD32, which the libbpf/bpftool link step rejects. Other
register, immediate, and memory constraints either fail in the BPF
backend or lower to a normal R_BPF_64_64 load followed by an ALU add,
which does not exercise arena_map_direct_value_addr() with the boundary
offset in the second ldimm64 slot.

A legacy test_verifier fixture can express the raw instruction directly,
but it needs arena map creation, mmap, and fixup plumbing in the legacy
runner. That is more intrusive than the small prog_tests raw-instruction
test.

Use the userspace raw-instruction test, following the existing selftests
pattern used for direct map-value pseudo loads, so insns[1].imm can be
set to arena_size precisely.

Assisted-by: ChatGPT:gpt-5.5
Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Junyoung Jang <graypanda.inzag@gmail.com>
---
Changes in v4:
- Move verifier log buffer to BSS.
- Treat EINVAL from arena map creation as a test failure instead of a skip;
  only EOPNOTSUPP remains skippable.
- Drop unnecessary arena initialization before mmap().
- Simplify unexpected successful program load cleanup.
- Add Reviewed-by from Emil.
- Link to v3: https://patch.msgid.link/20260610-arena-direct-value-v1-v3-1-d5f0d935ee45@gmail.com

Changes in v3:
- Document why verifier_arena.c inline assembly cannot express this case:
  __imm_addr emits R_BPF_64_NODYLD32, while other constraints either fail
  in the BPF backend or miss the pseudo-load boundary path.
- Mention that natural C forms lower to a normal load plus ALU add, so they
  do not exercise arena_map_direct_value_addr() with off == arena_size.
- Keep the userspace raw-instruction test as the least intrusive option;
  test_verifier was checked but would require legacy runner arena plumbing.
- Link to v2: https://patch.msgid.link/20260605-arena-direct-value-v1-v2-1-a92cb281e376@gmail.com

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
index 000000000000..4b4adb3f4b71
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
+static char log_buf[16384];
+
+static void test_arena_direct_value_one_past_end(void)
+{
+	char expected[128];
+	__u32 arena_sz = ARENA_PAGES * getpagesize();
+	struct bpf_insn insns[] = {
+		BPF_LD_IMM64_RAW(BPF_REG_1, BPF_PSEUDO_MAP_VALUE, 0),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts);
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts);
+	void *arena;
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
+		if (errno == EOPNOTSUPP) {
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
+		close(prog_fd);
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

