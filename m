Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5865327C00;
	Sat, 13 Jun 2026 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781343240; cv=none; b=IANFxUhJaeiqH8FtSIHkgPpx6yUahqWHB2Z7L8r6pTbUS9uHg1dh0PIdMDRc5jdxXTvt70RYUROcJPlHaD8trFerU8UCgIkR8E9IzFtx3YidAJieZ/1BWIzycWqc10vhnIG8rRT+mjkL24hf/pgZdzZ3wx2Y0MyEWGehdlaKJnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781343240; c=relaxed/simple;
	bh=Erg7HgVk+clSdI8s67D25tDrqYE88uu5Z515BAsKbSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OQVDO9YKXRY7v+IIKyaklzbH5n28drjP3zQhBsnRfsZISLMyPovzKLBnhHgzO1ooTtHGDO8o0InqjiHx94Sb/LRiw9bt7zatxQ1Xq24enZ6RgUUWs8QNTZKBVtbeVsMci46gcfFTRs6ZyIfHJvkem4vDce1jjBKax9jZ8BY5Ejg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=FhJqaCjY; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="FhJqaCjY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=mI4i6UNj3wvj1MT4q3SSV9qp/dZiJUd
	RdPkbP3jy9kI=; b=FhJqaCjYljh3a+myXVqUmJLBbCYO5SKa7CWFNDS7I5myJnc
	3cCIUopWGHTbIYWmoSuVXJeLomuEvsssElcHU6a9k4sygxiVhO5T1XBVcr2bK0Lx
	Rklts+p6ddxSclKONAou4ppdEs8qeIK5WYmfDKoFuhg9bKO7Py0F+PrK10A4=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web3 (Coremail) with SMTP id ygQGZQB3wo_8Iy1qpi9lAg--.5250S4;
	Sat, 13 Jun 2026 17:33:49 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Sat, 13 Jun 2026 17:33:46 +0800
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add cross-subprog gotox
 target coverage
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-f01-02-gotox-bpf-next-v2-send-v2-2-ff980bc5a329@mails.tsinghua.edu.cn>
References: <20260613-f01-02-gotox-bpf-next-v2-send-v2-0-ff980bc5a329@mails.tsinghua.edu.cn>
In-Reply-To: <20260613-f01-02-gotox-bpf-next-v2-send-v2-0-ff980bc5a329@mails.tsinghua.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Anton Protopopov <a.s.protopopov@gmail.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781343229; l=3669;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=Erg7HgVk+clSdI8s67D25tDrqYE88uu5Z515BAsKbSs=;
 b=Aur6A1o5vLCbsCdKaQW5Za7bioxRVJAl9drHQkrKbSXVGY/7TTGDLeBgz/2L/pkOIvBvrdEEB
 ZQQpubDp9pPD8Z6YhVR8cQRAxpsxjdpbeWcfjHcfFOd4PL0YJpbShOK
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ygQGZQB3wo_8Iy1qpi9lAg--.5250S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4kXw4xur1kKry5Jr4ktFb_yoWrJFy7pa
	y8X34UKr4rtFW7Jan5tFW7W34YgF4kX39rCr9Fq34xAr43Xwn3XFyrta15tr9IyryrZF4S
	vw1IkrZ3G3y2grDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Av
	z4vE14v_GFWl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU0YXd5UUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQIRA2oshq+CJAABsZ

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
index 73dc63882b7d..5252ca09689c 100644
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
@@ -538,6 +608,9 @@ void test_bpf_gotox(void)
 	if (test__start_subtest("check-ldimm64-off-gotox"))
 		__subtest(skel, check_ldimm64_off_gotox);
 
+	if (test__start_subtest("check-cross-subprog-gotox-target"))
+		check_cross_subprog_gotox_target(skel);
+
 	if (test__start_subtest("check-ldimm64-off-gotox-llvm"))
 		__subtest(skel, check_ldimm64_off_gotox_llvm);
 

-- 
2.34.1

