Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03AF385D85
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 07:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781075632; cv=none; b=FV9oVPWsDWv6jy65suSdicH1xdZ1YJ3mkpX7HmYhYq+FFvC/XXXtS7qReOxL26Zc7pLLkRVWFAj/lwadhNLhsAqrAC/BLyaMFqTfaSjx73Frl6+yqacZYNom1u0BTwWuYgux4VA7TGuNpSY9mkJ/pS1Bpm+S4hpmDKtfZbOcuWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781075632; c=relaxed/simple;
	bh=53JyhO7i5frR2tFIJKi76YP5Onuf89dbn1JJ8Mp4sJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pfn/3k0duH8ilHHcV5TavSynU7/o+iCc7sVCmH6lo0IY06oXsOGEtqqZhfUs6AL2TbOrbG5vCVmDRmGQkzSMIn4xNkQE7mOxZEeDLyWJMXGehgvv2sazc9wav/AhIEsxXmdUTQLVqKaiPIE5w0hiir4OGdclnHYp9ZruGLwlUys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6UFO26m; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6UFO26m"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2c0c3315c5dso67211455ad.3
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 00:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781075630; x=1781680430; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yzdEMh5lHMBwcaHbKYzieVMCGt4oUIEY8iF46MdpcK0=;
        b=V6UFO26mrR8jlINLiVfxjBhxh+OvmhJPe3xZLarevWETHG6JgRGzcKr9DiLPstL0GE
         TypiCqLbJVS7PDUjBMI2wSsvM9EzPJtCidVz2TvGfiVkykckj6EwgPZgYh1AbysxIqOD
         YQjywpFFzmxK4h2eZJeq/ts5cawwXu6XAxL0Du9kP6kVwSE0cvEeC/rXrx7vFUBJbHlP
         sZkTcB++MXC5HdQ05zC3sWbftURxrxacgufM/WgSQyKgArnVHumn6BN4rsbF6piSqLsk
         UclhWVQwH4QLWUpYlSwdRY43X5Bwsrf0OtOuXj0GiOgvnPCSOrLdYANjtTvnlD6j0YvH
         X7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781075630; x=1781680430;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzdEMh5lHMBwcaHbKYzieVMCGt4oUIEY8iF46MdpcK0=;
        b=X706H2/EP8Nsry17o1pzifRTNQRKwUhZZ5T6XOXmXIhLQRftlCsvpQszXdpPxyEbwr
         IPxYBEGXvPXHSy5ARK/NYbYofugfT4l8RNldoZbpVv9YUJlBw8kt48WuAqgL0mkKROdc
         enFlSPUex06N4OVS+Y+C60b8kLsmr4WX1Xe7q8mLXhhng9LNlBcfUJDYYzCkQxnH0svx
         lvcM339+ljF4cCtHp6hmbbiN9yDp43/QUPCAvKOlkNpRNtStsmZD5bhf2kE6/rJ+1pjv
         6VRqstgUMnwJ0/XWkXEGJTxpvNcOzuRx7pqbgIlvHgbYc8fm2AfZO7qckisq/hiOJ0Oz
         pI4g==
X-Forwarded-Encrypted: i=1; AFNElJ8AEo0THuxiHUpHfvDeUdw9ZsnATfWQIE4rSkCbVZkAl9Stn7xLwXBNW2IgWfQVdcgs/50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5aGf5OIiMZmW2fg6bbam/Gz+05K+k6SpwcOhALKXWd7/NRZTd
	+O2FpTQxY1ip5VWhwbYIIE4D9queckeudczhMwbqL9pXmMy+xySt19eg
X-Gm-Gg: Acq92OGChfqjiXbMmgXuSGZeybW8vFImbQKxl5couzWMR6fEnnX9/oxJZiyQYF8DJCe
	/6W8yLhIgaxeBFcIojVeqMftzUbUcziuoP2VouV3Nyu0BD2Fkec9VWn+pqxSx9NkF7WPrNEq4rn
	8Szd+SRax86U6dmBhOToXqDfWWXA9+vFtbmnW6VohjOtcxb6FDpbDNNzV6GNM7N0ukrhjfLoUCE
	D46fnhvwvXm+YJbiHJ1DEvigx87o8qhUhMWaPo1qicEf9f9tYdxNncjm7+xuhr/PWgoYY9GfRqx
	ii1z2jE/fpvL/jE9UBXv3LgC/QwKB3GjPInUfgZ8LK0to9m22YTuGy/U+Ba8CDuP7DC+77/xjYp
	O+6evAPjHv9fK/udtlb5Rex0IyXnvfMS3drnuwFZjQSTGqjiMlUPf1PHFpJ6d+JDv3vXk6oS3by
	y5UlrcJ+MxxCIsEP5BaDfN6JRyHUf3Huj4
X-Received: by 2002:a17:902:ef08:b0:2b9:6458:1a2c with SMTP id d9443c01a7336-2c1e820e30bmr298583035ad.13.1781075629930;
        Wed, 10 Jun 2026 00:13:49 -0700 (PDT)
Received: from [172.30.1.91] ([59.6.68.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f875casm237059765ad.22.2026.06.10.00.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 00:13:49 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
Date: Wed, 10 Jun 2026 16:13:45 +0900
Subject: [PATCH bpf-next v3] selftests/bpf: Add arena direct-value
 one-past-end reject test
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-arena-direct-value-v1-v3-1-d5f0d935ee45@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOyw6DIBBFf6VhXRoe9dVV/6PpAnBQGkUDSmyM/
 16kGzdNk9nczJxzZ0UenAGPbqcVOQjGm8HGwM8npFphG8CmjhkxwnKSE46FAytwbRyoCQfRzYA
 DxaCvtS6zQlalRJEdHWizJO8DyVFjC8uEnt+Nn+Ur0rt2v22Nnwb3Ti8Emog/bXEoLiSnShFRK
 qHuTS9Md1FDnzoCO1qyXxYWLaJiSrKSAi/yo2Xbtg/ppg5jHAEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5647; i=random6.xyz@gmail.com;
 h=from:subject:message-id; bh=53JyhO7i5frR2tFIJKi76YP5Onuf89dbn1JJ8Mp4sJ0=;
 b=owEBbQKS/ZANAwAKAUOXRMMVrfhrAcsmYgBqKQ6q/0Mnw8OjeZLWplgHEnkOYShXxKmetW4OQ
 f6Q92Vn4+mJAjMEAAEKAB0WIQSrknTJbxUcAdPNt5BDl0TDFa34awUCaikOqgAKCRBDl0TDFa34
 axveEACfexJ/1G1cZljjcqjlGuRWEziCRKgYU15g/chjQTl7g7ce7+MNBPJURxttv7VmgW8uZyM
 secmTrgsg4TwTKq6Wfskg2RjJe3P4PRdILTfmNrUtP16bH3UqHC9Btq0vJsgv7jTOz29wlt2I4a
 MVjM3D9QsjZCG5Di0aMYscwcDJXJ4qhfHDeS53PoIeEekdyeB77nH08zgqScL/x0rT3WpCmniwt
 SxIJe/bsgZeDHafcB8uj69SD06r+wp7TcbRZ0h5VyOJmDmer/AUAxa+6t2A41t5akW4DRoI4eE1
 AmygEVyo3tIp7mVxCaTnlhlzw2aIIu77F6iqFaCyPQaBDCKVzksuW0ntC705i6r0NzgQaecTCfE
 BvxShBIn1RXvR79xlWWVICvn+mpQ6YI/lod57n6L5EaTVPI6k2ugHAfl5wbolZhlvUJNEE3i7Qd
 syNJdaATVgpv1EJE0dd6cUx/66H5EFzraxcUhnoDDqk0VLGQ+RHhyErtRYgO07OGYPsouZe41j3
 sB0nMJlUuqn6jijDuLbwpiXwz6+hnjx4b3O3qCYqKEZ/AbtZJK0PP5H2JI7RjcVJS34iLOhbSTM
 jsFBgEn98SICUzKnrdTRITXJ2oWZmSzPm+mMs/Vx6Mwu4HM4JfvBFXhJvuBCe1T8X0cTgLLF0qQ
 WFf8czg0/HWX1Cg==
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
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Junyoung Jang <graypanda.inzag@gmail.com>
---
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

