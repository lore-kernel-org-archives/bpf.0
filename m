Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B9032B115;
	Sat, 13 Jun 2026 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781343239; cv=none; b=SMhW0uO6jcbaeElpsvng5yF+9KCMttrepDVzVBTO5vV3WxT9GcGexfi44EVAN2DeFzsOViYsIXf7AUU7nFK3wHf5txr+v0swFKI519qPtROJoQa1erUQVOCV6t3nrVj0OYMk+qOG8uIgvrJXLhCG+EpCSuugQC5WaYdHHhJiFew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781343239; c=relaxed/simple;
	bh=wQWDW/hWzSxaSX86E8RPR9Sf16S+QxCzaYcRXjhmW9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jpkcuqH/BybdPHlrgXD9XX+tX38kyoKqEr0I+96Djmar8d3maq+gfLZGn5i6C4qghosFQs50Tz1HGm96guc1oRapQwjf5ZGq1jZkR0AaTc0eWFbDvBBsvSm5wLngDEAYH+yGdwXRBvbgesNlgItRjflvl4NgOShX/q4RdGr7sZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=UKcMn+v6; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="UKcMn+v6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=zy0pZFrvI2JW/FXoq918GmjuWgYA9IE
	tZSLGnRKtlww=; b=UKcMn+v6spRnWUEopocxsxla09W5pp3x2wd6kOmGqf87dlZ
	cByUhXrXFTRixMDD3SMsUoogS251+2hnAlEMC1r9mKNjTFefgfGJHGucONtz51CM
	VISyl99C6o6NHcf0s7sNDWLZ6iwpmz1VL7FfcwwQVCaA1rwBaWm8+qxRmInc=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web3 (Coremail) with SMTP id ygQGZQB3wo_8Iy1qpi9lAg--.5250S3;
	Sat, 13 Jun 2026 17:33:48 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Sat, 13 Jun 2026 17:33:45 +0800
Subject: [PATCH bpf-next v2 1/2] bpf: Enforce gotox targets against subprog
 bounds
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-f01-02-gotox-bpf-next-v2-send-v2-1-ff980bc5a329@mails.tsinghua.edu.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781343229; l=2930;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=wQWDW/hWzSxaSX86E8RPR9Sf16S+QxCzaYcRXjhmW9I=;
 b=InFQ37QONsEOHtvmbqrxeLjrXwIRg4Zah008AWJfPk1yqNNT1mp173/l+H1G2/YsQzDcTqwHe
 1cm7RmQ06hpBOr9agi/sqVVHaOS8aO+S74htN5KU+HK3Au8zB0zv2Q1
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ygQGZQB3wo_8Iy1qpi9lAg--.5250S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4xuFWrCF4xJryUAr1DWrg_yoW5Ar18pa
	1vg3s3tF4kJFZ2grnFyF48A3y3KFWjg3y5CrWxX34xtw15t3s8KFW8KF95ZF9xAF4Skr1I
	9FWjv39xG3y7AFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgIRA2osh5yAmgABsU

CFG construction records the modeled gotox target set in
insn_aux_data->jt. It includes INSN_ARRAY maps based on whether the map
target is in the current subprog. check_indirect_jump() later validates and
follows the current PTR_TO_INSN register's actual INSN_ARRAY map. The
verifier does not check that targets copied from that map stay inside the
same subprog as the gotox instruction.

This lets one gotox instruction observe two different INSN_ARRAY maps. CFG
can select a map whose target is in the current subprog. Another path to
the same gotox can carry a PTR_TO_INSN value from a map whose target points
at a different subprog. The verifier then accepts a cross-subprog edge that
CFG construction did not allow for this gotox instruction.

On x86, gotox becomes a raw indirect jump in the JIT image. Accepting a
target outside the gotox subprog can enter another subprog without a
matching BPF call frame and crash when executed. Validation observed a GPF
in bpf_test_run().

Fix this by requiring every target copied from the actual PTR_TO_INSN
map to stay within the subprog that contains the current gotox instruction.
Reject the program before pushing verifier states for any cross-subprog
target.

Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eb46a81a8c51..98d3fa2f162a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17145,9 +17145,11 @@ static int indirect_jump_min_max_index(struct bpf_verifier_env *env,
 static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
 	struct bpf_verifier_state *other_branch;
+	struct bpf_subprog_info *subprog;
 	struct bpf_reg_state *dst_reg;
 	struct bpf_map *map;
 	u32 min_index, max_index;
+	int subprog_start, subprog_end;
 	int err = 0;
 	int n;
 	int i;
@@ -17188,6 +17190,25 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
 		return -EINVAL;
 	}
 
+	subprog = bpf_find_containing_subprog(env, env->insn_idx);
+	if (verifier_bug_if(!subprog, env,
+			    "gotox insn %d is outside subprog bounds\n",
+			    env->insn_idx))
+		return -EFAULT;
+	subprog_start = subprog->start;
+	subprog_end = (subprog + 1)->start;
+
+	for (i = 0; i < n; i++) {
+		u32 target = env->gotox_tmp_buf->items[i];
+
+		if (target < subprog_start || target >= subprog_end) {
+			verbose(env,
+				"gotox target %u from map id=%d is outside subprog [%d,%d)\n",
+				target, map->id, subprog_start, subprog_end);
+			return -EINVAL;
+		}
+	}
+
 	for (i = 0; i < n - 1; i++) {
 		mark_indirect_target(env, env->gotox_tmp_buf->items[i]);
 		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],

-- 
2.34.1

