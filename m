Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEBA3AA500;
	Sun, 28 Jun 2026 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782655214; cv=none; b=LQkXB53CcXKzM5JRfcQ0M1hQonz/TD6MZUvBpbZ/PCyXiZ1KPwXc6Rlm7IhPalTirindtwLGgPyCH7pF1O4uCb/xZjZgCWmXZq+vDYkMAGN1YT9Hzb9s6uv90EKHPVlIocW+q9ta5Y65h+1a0f3KoLUPnVNrDdpQ1lQ37mN7Tjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782655214; c=relaxed/simple;
	bh=49NdNpQz0BTFZpaxpTZWVWY+Aq/c9zLobhYBBzbrhhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bi5Ez28W5ACsJltMuxedeF6BrR6mwGB2hOI3IOXdXuSrmLUsjjjBsyrvT2cwWTjBmXtMxaiy2NhudveuZi7CVuF5lHYW5D75stcH9KJOXUKP2t9+SSrc8SLxxH/eNSymyZY/qT6mTSbrkfS8vFPvnE2+vZFCjcRt0tthb/eeago=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=XUuX29+g; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="XUuX29+g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=14rQ9wCtFGzrIL4cdRyM+fWzfaDoeSd
	g50kZIqBMMw8=; b=XUuX29+gJEldXLEHPYWItTNBhuzjdOjADfyHZLflAuKdnEH
	/UY8Ad6kUAddw1WN6HtYvzJwZgooa/RhmrNIQyz3yDc4sMdtzEua/RaFKuNt+2MA
	Qe+PDN03fQidy57hhELLr5PXxZkY3ci8hOZMBfKHT/2vAKJAfKP4KSueMqW0=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQBnP5fdKEFqh1mYAg--.22544S4;
	Sun, 28 Jun 2026 21:59:58 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Sun, 28 Jun 2026 21:59:58 +0800
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add cross-subprog gotox
 target coverage
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-f01-03-gotox-bpf-next-v3-2-b744432e1361@mails.tsinghua.edu.cn>
References: <20260628-f01-03-gotox-bpf-next-v3-0-b744432e1361@mails.tsinghua.edu.cn>
In-Reply-To: <20260628-f01-03-gotox-bpf-next-v3-0-b744432e1361@mails.tsinghua.edu.cn>
To: bpf@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Anton Protopopov <a.s.protopopov@gmail.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782655199; l=3560;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=49NdNpQz0BTFZpaxpTZWVWY+Aq/c9zLobhYBBzbrhhE=;
 b=b2s8PJn68VE7JKXrUVw9x7sWT4+9QuY8mGVzMn02lL1+k6rgmKpqC61p5Mgp2FsIiRDy0WPjZ
 kyNgBCi3TnHBun1OVxrVvaXmJNSUTL3zmVp8XSbRsabw3yGnVymuIj7
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:yQQGZQBnP5fdKEFqh1mYAg--.22544S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4kXw4xur1kKry5Jr4ktFb_yoW5KFyxpa
	y8X34jkr4rtrW7ta1kKay7u345KF4kX39rCr9FgryxAr43Xwn3XFyrKa13tr9IkryrZF4F
	vw1SkrZ3G3y2qrDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xS
	Y4AK67AK6ry8MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUojgxUUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQEMA2pATTHP5wACsz

Add a gotox regression test with two one-entry INSN_ARRAY maps. CFG can
model a map whose target stays in the main subprog, while the verified path
can load a different map whose target is the first instruction of another
subprog.

That second target is outside the subprog that contains this gotox
instruction, so program load must be rejected with -EINVAL.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 tools/testing/selftests/bpf/prog_tests/bpf_gotox.c | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
index 73dc63882b7d..997724c61c8b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
@@ -255,6 +255,30 @@ static int create_jt_map(__u32 max_entries)
 			      key_size, value_size, max_entries, NULL);
 }
 
+static int create_jt_map_with_target(__u32 target)
+{
+	struct bpf_insn_array_value val = { .orig_off = target };
+	__u32 key = 0;
+	int map_fd;
+
+	map_fd = create_jt_map(1);
+	if (!ASSERT_GE(map_fd, 0, "create_jt_map"))
+		return -1;
+
+	if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &key, &val, 0),
+		       0, "bpf_map_update_elem")) {
+		close(map_fd);
+		return -1;
+	}
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze")) {
+		close(map_fd);
+		return -1;
+	}
+
+	return map_fd;
+}
+
 static int prog_load(struct bpf_insn *insns, __u32 insn_cnt)
 {
 	return bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT, NULL, "GPL", insns, insn_cnt, NULL);
@@ -393,6 +417,52 @@ reject_offsets(struct bpf_insn *insns, __u32 insn_cnt, int off1, int off2, int o
 		close(prog_fd);
 }
 
+static void
+check_cross_subprog_gotox_target(void)
+{
+	struct bpf_insn insns[] = {
+		/* main subprog [0,14) */
+		BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_CALL, 0, 12),
+		BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6, 0),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_7, 0, 4),
+		BPF_LD_IMM64_RAW(BPF_REG_2, BPF_PSEUDO_MAP_VALUE, 0),
+		BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_2, 0),
+		BPF_JMP_A(3),
+		BPF_LD_IMM64_RAW(BPF_REG_2, BPF_PSEUDO_MAP_VALUE, 0),
+		BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_2, 0),
+		BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_2, 0, 0, 0),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+
+		/* static subprog [14,16) */
+		BPF_MOV64_IMM(BPF_REG_0, 42),
+		BPF_EXIT_INSN(),
+	};
+	int good_fd, bad_fd, prog_fd;
+
+	good_fd = create_jt_map_with_target(12);
+	if (!ASSERT_GE(good_fd, 0, "create_good_jt_map"))
+		return;
+
+	bad_fd = create_jt_map_with_target(14);
+	if (!ASSERT_GE(bad_fd, 0, "create_bad_jt_map")) {
+		close(good_fd);
+		return;
+	}
+
+	insns[4].imm = bad_fd;
+	insns[8].imm = good_fd;
+
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL",
+				insns, ARRAY_SIZE(insns), NULL);
+	if (!ASSERT_EQ(prog_fd, -EINVAL, "cross_subprog_gotox_prog_load"))
+		close(prog_fd);
+
+	close(bad_fd);
+	close(good_fd);
+}
+
 /*
  * Verify a bit more complex programs which include indirect jumps
  * and with jump tables loaded with a non-zero offset
@@ -541,5 +611,8 @@ void test_bpf_gotox(void)
 	if (test__start_subtest("check-ldimm64-off-gotox-llvm"))
 		__subtest(skel, check_ldimm64_off_gotox_llvm);
 
+	if (test__start_subtest("check-cross-subprog-gotox-target"))
+		check_cross_subprog_gotox_target();
+
 	bpf_gotox__destroy(skel);
 }

-- 
2.34.1

