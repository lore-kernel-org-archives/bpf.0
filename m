Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2298443D518;
	Tue,  9 Jun 2026 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017394; cv=none; b=N7vncLtazeCaumRagEhgtN8GUPydSz51EKokEdwA7rOSaeDjra73P37GVLz0FGH2PKyjjE4xEDLjmxbCi+/MNlqQYKbyUd7So5CvmFx7H1SABMtQdb0vQ0oOUi4MnIoJY26KiLzgRXgpl5N8+AAPaU2IQjk1xF334IAFofBx5/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017394; c=relaxed/simple;
	bh=VSTeJi1vMa+OGLlgwuxPBfPuXYR0PXQyqauRowUIIx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JoELywwY/CY7C43EJO3LGSUx6q73XcioJBaB+QXwBcaqVDcfycXX86s6b1odpfN4/TwWW0MfjL34JmJuWjEI1iPnoOobLkmtS/ttkbQG02ExQXknfUNSaHQwTaHXWrOBA/i1hKWCPqBj7hLzzCneBKdTWGsUt05aqZNk+CXb5RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=Hkz18R8U; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="Hkz18R8U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=dRwifbl9vFOPZnekgkBLAetwJmtegFW
	5sNWv+v758IQ=; b=Hkz18R8UQiKe8XNexZVENAQ4l4JOfYArTZeHgXNNzPeabiB
	Bqk+HmMtio3sZF7ekjMIttM2ncv2N8Nz4mFXusmIeXXnwL1uZyYuylKqDJzDPi0B
	yPeGfHaMAf0FpQiZvPP4Q4grAGQ8Qqi+IQJNnODn77KIiHCVV1UEjblzeLQ4=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQCXcporKyhqMNgjAg--.44237S4;
	Tue, 09 Jun 2026 23:03:08 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Tue, 09 Jun 2026 23:03:07 +0800
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add cross-subprog gotox target
 coverage
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-f01-02-gotox-bpf-next-v1-2-b441d63a1559@mails.tsinghua.edu.cn>
References: <20260609-f01-02-gotox-bpf-next-v1-0-b441d63a1559@mails.tsinghua.edu.cn>
In-Reply-To: <20260609-f01-02-gotox-bpf-next-v1-0-b441d63a1559@mails.tsinghua.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Anton Protopopov <a.s.protopopov@gmail.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781017389; l=3668;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=VSTeJi1vMa+OGLlgwuxPBfPuXYR0PXQyqauRowUIIx4=;
 b=9YwzUGi6u7A0AeWNUmWpDLyHnrvZ/uHS9EwTX+LPg+/Zc69qmVsGjR0z17DImWDK2YAx+A7d6
 RZQtyUndI9xAYPQBPV1naww1fsfTwC03Rq0Lz97N+wWSM9JbODmEiYI
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:yQQGZQCXcporKyhqMNgjAg--.44237S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4fGF15KF13ZrWUGw45ZFb_yoWrJFy5pa
	y8X34jkr4rtFW7tan5KFy7W34YgF48X39xCr9Fgw1xAr43Xwn3XFyrta15trnIvryrZF4S
	vw1SkrZ3GrW29rDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPl1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUXVWUAwAac4AC62xK8xCEY4
	vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VCjz48v1sIEY20_GrWkJr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxkIecxEwVAFwVW5WwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r4rKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
	pf9x0Jjoq2NUUUUU=
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQENA2ony4GgqwAEsG

Add a gotox regression test with two one-entry INSN_ARRAY maps. CFG can
model a map whose target stays in the main subprog, while the verified path
can load a different map whose target is the first instruction of another
subprog.

That second target is absent from the CFG jump table for this gotox
instruction, so program load must be rejected.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 tools/testing/selftests/bpf/prog_tests/bpf_gotox.c | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
index 73dc63882b7d..866b4a14ccb7 100644
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
+check_cross_subprog_gotox_target(struct bpf_gotox *skel __always_unused)
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
+	if (!ASSERT_EQ(prog_fd, -EACCES, "cross_subprog_gotox_prog_load"))
+		close(prog_fd);
+
+	close(bad_fd);
+	close(good_fd);
+}
+
 /*
  * Verify a bit more complex programs which include indirect jumps
  * and with jump tables loaded with a non-zero offset
@@ -538,6 +608,9 @@ void test_bpf_gotox(void)
 	if (test__start_subtest("check-ldimm64-off-gotox"))
 		__subtest(skel, check_ldimm64_off_gotox);
 
+	if (test__start_subtest("check-cross-subprog-gotox-target"))
+		__subtest(skel, check_cross_subprog_gotox_target);
+
 	if (test__start_subtest("check-ldimm64-off-gotox-llvm"))
 		__subtest(skel, check_ldimm64_off_gotox_llvm);
 

-- 
2.34.1

