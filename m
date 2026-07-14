Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8D73806D9;
	Tue, 14 Jul 2026 02:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996842; cv=none; b=pm9FSnqTN9nAi4jtj82sS17FxKpXMATWtbS/2vXz3DWdEsF0OAIKHa3X0TL3tH4usAq0qlN7ftAQ+9jyYfeViN3KiofEYwhxPSvEYRlrjh1nyVRVdSyizWPt9478po+a6/8sWyR4MFdc19vH0wzZBOjPwmjqkj9ff9xwSgZAW7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996842; c=relaxed/simple;
	bh=5iEWaIvxbYl8N8dzufLxnspqVW/QaP6ByQGr5fsdY7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBCJc9ZRlbCKYs1EEnPilropDyLVHEn9IoMFga2fKpJxN02+HnD0poQ9Lbam4NiBjCsHJCCHH6Grj1Qe9qZ5O6+DG6/yVeSwmcp5ywb+UxsWMpGhosF+UNKDWkx7XFidrdJoy7KTe9SlUBfM0e82rmwmZRNLCrqZro3Xl1vnDEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gzk7B0W4hzYQtjY;
	Tue, 14 Jul 2026 10:40:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A74FB4056E;
	Tue, 14 Jul 2026 10:40:36 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgC3xXGioVVq8TueBA--.48464S3;
	Tue, 14 Jul 2026 10:40:36 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next v2 1/2] bpf: Reject callback subprogs invoke tailcall
Date: Tue, 14 Jul 2026 02:44:58 +0000
Message-Id: <20260714024459.420075-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714024459.420075-1-pulehui@huaweicloud.com>
References: <20260714024459.420075-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgC3xXGioVVq8TueBA--.48464S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1kJF47GF1xWr13AF1kKrg_yoW8CFW7pF
	WkWFn2qr10qa129FnFyF48AFWrtan8tw47Gr4kJw1Fyr1jkFyDWryFgFyS9ryY9r4Fkw10
	vr1jqFW3tw4UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfU8XdbUUUUU
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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

