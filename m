Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EA63A9DBA;
	Sun, 28 Jun 2026 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782655214; cv=none; b=pbqyPgnR2J7Yr1Ygg73LlQsBWHFVWQLkpgiNyjCmJC3IObcSwjrINf/7e3wQOiVwXOuhRCB7MU3sVTSCW5nu1DNH5S/tVqTe4m/cac/onrrBrp1uDqqy1CKvayLTpv1U1zsKu7JMyeWxxn53BXWIc1+sNGYkG4d95JR5rHP7QN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782655214; c=relaxed/simple;
	bh=xqGUOx4cbV+J7JKpfgEbEv8h5ZhwLInWEn2S+le8/us=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NnWdXg/Kryg3n8TaR90zGQSAIzbCEHeSRLFkM06WekplAb572YOBLt7CyxHeTBi1VYl4fHNLXMhLpqodb9b4AUz51d6Jgm3Y4awY58YHOXArKvrK6TomV3xVacRewPXh3YiAQA6qk7RFGPCIPmiJC2shmxNL1frQZ0YEgx2U+D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=fiLyFlIY; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="fiLyFlIY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=1tACYG6ylVU6WZzS/Bn6DYuqDzCUqrO
	R1N6KKIGOWGI=; b=fiLyFlIYVWMdvNNVQDOpXDpRdFsfiam+tCn+QZ2ItomjEjd
	kCSTlKytLXMFkY5IRLE9KlD8OAfy/vQG36Bti3+4onr9X1E9oONgyizqAQQbRZS4
	VGD/pcJELX+lHv/Q2dtbM3C2mgaFJaiQuvm5cTWa/d8h5pfnJbXGI+wzNBjs=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQBnP5fdKEFqh1mYAg--.22544S3;
	Sun, 28 Jun 2026 21:59:58 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Sun, 28 Jun 2026 21:59:57 +0800
Subject: [PATCH bpf-next v3 1/2] bpf: Enforce gotox targets against subprog
 bounds
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-f01-03-gotox-bpf-next-v3-1-b744432e1361@mails.tsinghua.edu.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782655199; l=2185;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=xqGUOx4cbV+J7JKpfgEbEv8h5ZhwLInWEn2S+le8/us=;
 b=aKyOvP2PIsIOish0gOsqqpwCPltPy6edR8N4uEv+R3LxP3eIYSHnsoPEVBkT7PJvDDZBc0DSS
 //OVVv4/0j2DNtJH2rhVeaJZ/v8ERTtnORLnZOSdEPTmwa1goyorbKM
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:yQQGZQBnP5fdKEFqh1mYAg--.22544S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4fGw45Cr43AF4UCw4xtFb_yoW8uw4xpa
	1vqF93tF4ktFW2grnFyF4DZ3y3Kay0g3y3CayxZ34ftw1Yq3s8GF1Fgr9YvF98tFWSkr1I
	9F4jv390g3y7AFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgQMA2pATh3OggAAs8

During CFG construction, the verifier records the modeled gotox target set
in insn_aux_data->jt. Later, check_indirect_jump() follows targets from
the runtime PTR_TO_INSN register's actual INSN_ARRAY map.

This lets one gotox instruction observe different INSN_ARRAY maps on
different paths and accept a target outside the calling subprog. The
observed x86 JIT case can then enter another subprog without a matching
BPF call frame and crash when executed.

Reject every target copied from the actual PTR_TO_INSN map if it is
outside the calling subprog.

Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eb46a81a8c51..05a996a5ecdd 100644
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
@@ -17188,6 +17190,23 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
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
+			verbose(env, "gotox target %u outside subprog\n", target);
+			return -EINVAL;
+		}
+	}
+
 	for (i = 0; i < n - 1; i++) {
 		mark_indirect_target(env, env->gotox_tmp_buf->items[i]);
 		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],

-- 
2.34.1

