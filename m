Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064623BB122;
	Sat, 11 Jul 2026 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766594; cv=none; b=oNnF4qgCdkwhfUlyK7KqwMSRnDV1UWiR0dzgiY24NEiKO0bBhcseo+AXeJ3Zsy+sq2uGwwH5Obt0zRv/e5HQMJdrrNEiF/PVOcgnZ3VeRghGdhpErt26JsRjES+TNOPKu/KLvSmucI32QUy7ORi12tP1oRveVNZ4TcZG4bRYolQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766594; c=relaxed/simple;
	bh=RGbsmagyI+5lqoArfvfkdSGQgqyUVD7BnN3CUECYHE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AD4x9dpCPGaeJic4gyXnqB7hmPZwrFrQ9SVs5Jba+0MgV8p1/VciNPhmKVWFXp4WRZumSwudrc1naPdimSEjUH9JxsY45F+vIOwwFLj3iL7yq4I3leuvrKQpIGhAvMMCPMvZFK1sqaPJCFmq760Q9k7s/g6D94JxEjjbol2Z9pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gy4zN1dH7zYQth8;
	Sat, 11 Jul 2026 18:42:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4040C4056F;
	Sat, 11 Jul 2026 18:43:06 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgDHIm84HlJqX_VcAw--.36025S3;
	Sat, 11 Jul 2026 18:43:06 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next 1/2] bpf: Reject callback subprogs invoke tailcall
Date: Sat, 11 Jul 2026 10:47:26 +0000
Message-Id: <20260711104727.4023420-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260711104727.4023420-1-pulehui@huaweicloud.com>
References: <20260711104727.4023420-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHIm84HlJqX_VcAw--.36025S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1kJF47GF1xWr13Ary8uFg_yoW8CrW8pF
	WvgF97Xr10qa1293ZFkF48ZFWrtan8ta17Gr4kAw1rAr1j9FyDuryFgFyS9ryY9r4Fkw10
	9r4jqay3tw48AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JU4OJ5UUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Some JIT compilers, such as x86_64, rely on a register to pass the TCC.
When subprograms of synchronous callback invoke tailcall, C helpers
invoking bpf callback clobber this register, and the corrupted TCC may
bypass the TCC limit, leading to infinite tailcall.

Fix this by rejecting tailcall inside all subprogs of sync callback.
This also cleanly consolidates the existing async and exception callback
checks into a single unified `is_cb` check.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Reported-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 kernel/bpf/verifier.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03e2202cca13..3f6c8b8fc04d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5258,10 +5258,6 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		if (verifier_bug_if(sidx < 0, env, "callee not found at insn %d", next_insn))
 			return -EFAULT;
 		if (subprog[sidx].is_async_cb) {
-			if (subprog[sidx].has_tail_call) {
-				verifier_bug(env, "subprog has tail_call and async cb");
-				return -EFAULT;
-			}
 			/* async callbacks don't increase bpf prog stack size unless called directly */
 			if (!bpf_pseudo_call(insn + i))
 				continue;
@@ -5302,8 +5298,8 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	 */
 	if (tail_call_reachable) {
 		for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller) {
-			if (subprog[tmp].is_exception_cb) {
-				verbose(env, "cannot tail call within exception cb\n");
+			if (subprog[tmp].is_cb) {
+				verbose(env, "cannot tail call within callback\n");
 				return -EINVAL;
 			}
 			if (subprog[tmp].stack_arg_cnt) {
-- 
2.34.1

