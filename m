Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EB046AF35
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488598; cv=none; b=rQ18uUCrULRXAMR3/ICGUsERGAidXV5U0YcSg1LhUYc6LgrHrA6iH8Ju5tNVEFulE4pFEP4M6tCdn9ZBDaShUr0ZOzXo9ztTJbhvlpdUsVjyeRD3bSWUin4d8QzrioKr7SpAgMU2hWqkqoVotWXQpm/OQOw8VbCTKyjtkylc+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488598; c=relaxed/simple;
	bh=ReN6bAqVRbieKSblnyc9hevwUQFlr1v3vOS5O36luJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KhmqjRin/JSysdkAFGslqPzOmfB4w7T0OfnFl5YZV47Q2NeMtV2fa98hCjU2z0JlD85ZuR6OWwZ1wFuRwdLTXBiTxfe5vVTX8hHP08wPxuJSnGyeDU/2S5pOu+9fZWuuCtyBArBdchR9KHjDeXdlDzjjsPzAyi/U05R1+Od3NaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2cRRtcL; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2cRRtcL"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2bf30d530bdso52082955ad.3
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 05:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780488595; x=1781093395; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1DPhm6q8a46PtLf3Pz5dlsNl2LRNqC/WLBxKPgEOTbw=;
        b=G2cRRtcLG1GJ8ZeAG64rHjxnmzYgWR3QtwWbWIM1C4olBPPZ0qkqbWqEYtNe0AE8WJ
         ckR57mG+6c0CStXJwUTOgegKw854mZzmhbvQNxYVBhsFz9s0CubOxCgODtAndFrD70Ux
         6bAuDV9KcuejDkptmHrIT8oP+fgExKBPmBDLCpyW7ErrfbvH2zNseEYjGBuY6RNuzgus
         coV0tX7OXz82vlqfGteArHHvM41nzprghsN6VcZtOHa5Qt9swzRxyh2Mdy9LshJVdXV/
         zWuSXNwSkLzRISBCRP1ca86vk/H/yaEruwykXfXjl25BjrDrKEOdtQlzLSBBMutSmcng
         8/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780488595; x=1781093395;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DPhm6q8a46PtLf3Pz5dlsNl2LRNqC/WLBxKPgEOTbw=;
        b=W9mylIGfQ1xNJhyxAIQIX8+SJSbxDeucrbr7kxlb6BvavKz3FuUW5Htsn9DyBSXwGS
         GlKipbR+g8CjJkZWaUftnv648w+cfvgXcO/f4BIQeDAHpQ8y2YDn25xOYWSGDaD5F8Wd
         tV15ALmMB9bNAFC/a0U7EB9I2wkBbEwSLyTHTipnsFaBmvdw4vwOtCkrWAsbB617MYKA
         7XUhPASgAafegPU741pcFK4Kiho1M+AzYwJTrRz0oaiKZJIdITxgTqO7U+iDBhiz91zV
         LCtlMh2qUxkPJ6jQqevhnlsq+Kusl6w1zZ5X8rrabajxqweTn74OxKGY2xiU4eVKVR4K
         wChg==
X-Forwarded-Encrypted: i=1; AFNElJ80rgq17q/Gjq9wK6UCrsas4B6099bfBajjiO51wcJcEXMddGvjr/ly1tolm0soBcLs6m8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjyg0Uq31UUtni+GT0TWkmrDcWYk0ozhrSybRX1W2ovQFsqrR4
	C/33YY4tfH6xsofny3X3yD+4umB1BIC5kqvyKELAwYLsbpA/bQ04+C8Y
X-Gm-Gg: Acq92OFzAoY2OyeXUKyD/+Dm6et+1YWGZEKWVXh5hEUligMYZC/e4Cp8erOoBulziKA
	FCHPQYxxrtXxnIGBy1YtW1RAKNUKdIs5opFRdQI9U0uOM1wLZupWkHA50lClJiUkMD3N1dm9Srn
	ZmMbH5dss7UzggPVbLoaV2LxkJG0OFYMqzwcJPKZNumL7VFMJ/l9rkVF6L9b0q7gfnqObzpgNJR
	vvZrSpr8pMk6ZSfaN4DbMLag2X3GNXb1ETvXLreEc3A0H65iwGyxBnk9oLG+Lz2e7oBEt/VJCxi
	hPw4KIQ5HpnVP3/DL9DY6u+r9OqLlXG4a4Bl4d8EN3Thrqae5K76LRB8ANkJIQrHlDFm35+TUSv
	ew97isk/i+Aj59zIUUW4BWSQBjEQo6klO4MmAqFFC/oFxqib0VLb4H6DHzBFSsE6ktAkzZuvbKs
	wbI+m9oI2Gt3o6AHMHMHp09h9BTf7J+a8p5jeeWO19fg==
X-Received: by 2002:a17:902:c947:b0:2c0:ab92:584c with SMTP id d9443c01a7336-2c163fa8a01mr35117245ad.25.1780488595359;
        Wed, 03 Jun 2026 05:09:55 -0700 (PDT)
Received: from [192.168.1.198] ([220.149.255.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629cfb4sm25090835ad.59.2026.06.03.05.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 05:09:54 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
Date: Wed, 03 Jun 2026 21:09:28 +0900
Subject: [PATCH bpf-next] selftests/bpf: Add arena direct-value
 one-past-end reject test
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-arena-direct-value-v1-v1-1-7b31cc0a8cac@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQ6CMBAFf4Xs2U0KKqK/Yjy09FXXmEq20JAQ/
 p2ix8lkZqEEFSS6VQspsiT5xgL1oaL+ZeMTLL4wNaZpTWuObBXRshdFP3K2nwmca0Y4+dCdL+7
 aOSrtoAgy/753ckPgiHmkx9+kyb1LvW9pXTdwsOpCgwAAAA==
X-Change-ID: 20260603-arena-direct-value-v1-ef4df857b98b
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Woojin Ji <random6.xyz@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3928; i=random6.xyz@gmail.com;
 h=from:subject:message-id; bh=ReN6bAqVRbieKSblnyc9hevwUQFlr1v3vOS5O36luJI=;
 b=owEBbQKS/ZANAwAKAUOXRMMVrfhrAcsmYgBqIBmQQF6GCnx1/2WkO2x0xulVQcssuPTzSeKVs
 8xjaLhPIICJAjMEAAEKAB0WIQSrknTJbxUcAdPNt5BDl0TDFa34awUCaiAZkAAKCRBDl0TDFa34
 a+LwD/9mtohcI+nVkWhkyN10JgieoxRmdbdvJYEBxBdo26c++kl88hOm23AtnXvi1xbdwctP6zb
 fWJvNGxD2SFd/4scF0cG+9CpkNABftn3mk4AGUliUBk67Ia5E5UziQclSm45ZBzrQWtLHUde6bU
 VQsK+CKEk6zpAQcO4F5TJGEDKK0Hy8F01z6qeH7SSR2zINnStDkh8lRL85dkRt/RikxqDSb9RAv
 esENL0oebIbWt3TpiH2s4rjxJN+9ejYpKshY3QKkBF3TXMHl76AFiLmwqyIfjWNnX/FJbLxwIMe
 SHK752pR00rXL+Tet0J1QYv9XqPEilGUEGwj8dCpzRRwOnNCUWqwpYDkhMc0Qzs8E1spHlFHKep
 tOvocLi4H022hFLM3feQDdilCTYivbguve1tVUbBXnUpFP6napI3rmz2pplD2t03vrNhOQMUZj4
 hDX2Xri8Y7v1bGPDGVszC/QdOZq/WWr2aCPEvULML0a/O1c/stJKgKdo1lqxZqCyeMsHREnUpg6
 Vjz7y7FES3AHXQ0d/2JUEQgqCAoF0DpkAST7H8OqE/8BTkrDqjIOIFboV4pcATnIY9Zfeel88r2
 YcqQDSWaqrIrfU6fe7T8fXU2+t7sEXAEcfqH3UGtTQtn02FhMpK9Ml1DX1Jq3jO4vixgMdtIaWA
 SyQVmcWbtX3OlNQ==
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

Unlike __arena global relocation, where insn[1].imm depends on
compiler/layout, this raw instruction directly drives
map_direct_value_addr(map, &addr, off) with off == arena_size, so the
boundary check is exercised directly.

Assisted-by: ChatGPT:gpt-5.5
Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
---
Tested with a reduced test_progs runner because the local source/output
combination has unrelated build failures in progs/bpf_cubic.c and
test_kmods/bpf_testmod.ko, so the stock full test_progs binary is not
produced.

Before fix, on host Arch kernel 7.0.10-arch1-1:
  arena_direct_value/one_past_end: FAIL, prog_load returned fd 5

After fix, on QEMU guest 7.1.0-rc6-00063-gba3e43a9e601:
  #1/1     arena_direct_value/one_past_end:OK
  #1       arena_direct_value:OK
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

