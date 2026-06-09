Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21E6341062;
	Tue,  9 Jun 2026 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017394; cv=none; b=d/ww5GGEfZRuMk067L3M+fIfnP01wWcbIeSQoRlWFk78JyjU18aoxjw4HKfTreQHgZ423qHFmXySKF6Xy9dsJmLXT1Wkg/ZTuX9u5cGpZQoOe1BL0c6vu7VxJJH606/Ba0/rV9sf+p/ihBDv9WFego8qG4Tg4GlYbNHzj7fImEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017394; c=relaxed/simple;
	bh=MiRFfNkd0l8xm9rBTeYxdgz62An0xG8BJUuDI04X68k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eLD5zTIanucT7U631f3AgzSl7ssHbj4bP1QlcMuqL/OZdFwwooTVnsl9y9MTlim6U+i2NNitJ2rPcDxa4hGzYUpCuqNCIen9Jlltzq1ilWx7xvwObmqBcgVjSfnhEs0u/UX+crlFBuu+xe8dZclPPefXQgRPn/9yYoq2sSktqC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=Sj6g6iKO; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="Sj6g6iKO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=+tRO8w3UkDyoMG5FyX5HmJSCvC/l54Z
	H2fuj5GLZG10=; b=Sj6g6iKOKGIWl2L03zL5fdSxFJveEXPVTfxB3oMVE9a9mkO
	tRufzLxPqpo/05MxvE/NE1rxZnqn+TzdvZsaybfHtq5ZVVNTY+Vn9UrtpQLCuwnM
	R1PCgkQtDOTvTWO5H3hm2LW1y2p2SlVdGiM9o9Gh7h0BQ9QOuJAJ152YbfQk=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQCXcporKyhqMNgjAg--.44237S3;
	Tue, 09 Jun 2026 23:03:07 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Tue, 09 Jun 2026 23:03:06 +0800
Subject: [PATCH bpf-next 1/2] bpf: Fix gotox target validation against CFG
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-f01-02-gotox-bpf-next-v1-1-b441d63a1559@mails.tsinghua.edu.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781017389; l=2707;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=MiRFfNkd0l8xm9rBTeYxdgz62An0xG8BJUuDI04X68k=;
 b=H5uDYOZplt+pr3wJDSReTLtLvItFa1gkIhTugTAnN6Knzf3wQgSr7cb3p9tGTfczIJSYOoxVX
 zoji/DVwbVxCPv2vWDnlbK4wGu0G3hcctNZPU6qzOb/c92BdEOwEDtr
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:yQQGZQCXcporKyhqMNgjAg--.44237S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4xWFyDuFW3KryxZr43ZFb_yoW5Xr17pa
	10q3sxtFWkCFZ7WrnxAF4UAr13KrW8K3y5CrWxCw10yw45tr98JF4rWF9IvF9IyF1S9r1I
	vF4jvw45K3yUAFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQENA2ony4GgqwACsA

CFG construction records the modeled gotox target set in
insn_aux_data->jt. It includes INSN_ARRAY maps based on whether the map
target is in the current subprog. check_indirect_jump() later validates and
follows the current PTR_TO_INSN register's actual INSN_ARRAY map. The
verifier does not check that targets copied from that map match the targets
that CFG construction modeled for this gotox instruction.

This lets one gotox instruction observe two different INSN_ARRAY maps. CFG
can select a map whose target is in the current subprog. Another path to
the same gotox can carry a PTR_TO_INSN value from a map whose target points
at a different subprog. The verifier then accepts an edge absent from the
CFG.

On x86, gotox becomes a raw indirect jump in the JIT image. Accepting a
target not modeled by CFG can enter another subprog without a matching BPF
call frame and crash when executed. Validation observed a GPF in
bpf_test_run().

Fix this by requiring every target copied from the actual PTR_TO_INSN map
to be present in the CFG jump table built for the current gotox
instruction.
Reject the program before pushing verifier states for any unmodeled target.

Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ed7ba0e6a9ce..25fa90e731e3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17124,6 +17124,23 @@ static int indirect_jump_min_max_index(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static bool is_cfg_indirect_jump_target(struct bpf_verifier_env *env,
+					u32 target)
+{
+	struct bpf_iarray *jt = env->insn_aux_data[env->insn_idx].jt;
+	int i;
+
+	if (!jt)
+		return false;
+
+	for (i = 0; i < jt->cnt; i++) {
+		if (jt->items[i] == target)
+			return true;
+	}
+
+	return false;
+}
+
 /* gotox *dst_reg */
 static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
@@ -17171,6 +17188,15 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
 		return -EINVAL;
 	}
 
+	for (i = 0; i < n; i++) {
+		if (!is_cfg_indirect_jump_target(env, env->gotox_tmp_buf->items[i])) {
+			verbose(env,
+				"gotox target %u from map id=%d is not in the CFG jump table\n",
+				env->gotox_tmp_buf->items[i], map->id);
+			return -EINVAL;
+		}
+	}
+
 	for (i = 0; i < n - 1; i++) {
 		mark_indirect_target(env, env->gotox_tmp_buf->items[i]);
 		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],

-- 
2.34.1

