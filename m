Received: from mta1.migadu.com (out-151.mta1.migadu.com [95.215.58.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF054A64D4
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819768; cv=none; b=MxSOwbt+gE/z2X4zUJF9Qo9ZS4iwfipCSe+tLrskqPcrVzZEj+li6jq6wDpWENEtuPZ5HuKCtGOlZ911x5C3tyHUI/NmIToksJcJOpM6KGtQRnLWg5BfxC01co/A7hLIkM57DQelqu6U44jIesRSrQpfOm0+L+Ib9cW3HXAzTE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819768; c=relaxed/simple;
	bh=TBFr013muSrjqmBXfU5VS9nJWYXKQcqCrP4RWXqPIVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pp4guytaGbkh5/ZML6/5e9WAmFP+l4OlkjBlB/979qqVslrhPYmREFCshMP00vDvOtuE60igknHr28bBiWkRJpC81U3KvZ2efq9sN/pAeR1Qx7oJdJncvsVX9fXKDeEcLbDAh66zym7dt2Nuq7PtiAl5FUZz6yLTpdy+pMw3/Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P7v/SAbm; arc=none smtp.client-ip=95.215.58.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P7v/SAbm"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TBFr013muSrjqmBXfU5VS9nJWYXKQcqCrP4RWXqPIVA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819765; v=1; x=1792424565;
 b=P7v/SAbmi55gY7Odc6FAfweFYRmsjYVBB4aDYvVXh9/idvunfyHxfWrEFuPYK2OcCDneR3Ph
 A78kvwNeNwjnyFEClAxQWsdMzqH+5tB3/xDLFoVunz11tM6wQDKvX+pCRXbhywjQB6EPPEZ91Dt
 7O0SF8QzindCurB2Fzs96iEM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6ac1c4d5fb4ef64e;
	Mon, 12 Oct 2026 15:42:45 +0000
X-Mizu-Trace-ID: 6ac1c4d5fb4ef64e
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>,
	Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 06/21] bpf: Add bpf_text_poke_batch() helper in trampoline
Date: Mon, 12 Oct 2026 23:40:08 +0800
Message-ID: <20261012154024.29423-7-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012154024.29423-1-leon.hwang@linux.dev>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before calling bpf_arch_text_poke_batch(), check the duplicated target
pokes by sorting the pokes.

Sorting pokes is needed for smp_text_poke_batch_add() on x86_64 for better
performance, see arch/x86/kernel/alternative.c::smp_text_poke_batch_add().

If the arch does not implement bpf_arch_text_poke_batch(), fallback to
text-poke each target via bpf_arch_text_poke().

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/trampoline.c | 51 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 21d460866dfe..a2fd0bd8c685 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -13,6 +13,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/bpf_lsm.h>
 #include <linux/delay.h>
+#include <linux/sort.h>
 
 /* dummy _ops. The verifier will operate on target program's ops. */
 const struct bpf_verifier_ops bpf_extension_verifier_ops = {
@@ -1863,6 +1864,56 @@ void bpf_trampoline_multi_detach(struct bpf_prog *prog,
 	  CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS &&
 	  CONFIG_BPF_SYSCALL */
 
+static int bpf_text_poke_cmp(const void *a, const void *b)
+{
+	const struct bpf_text_poke *pa = *(struct bpf_text_poke * const *)a;
+	const struct bpf_text_poke *pb = *(struct bpf_text_poke * const *)b;
+	unsigned long ipa = (unsigned long) pa->ip;
+	unsigned long ipb = (unsigned long) pb->ip;
+
+	return (ipa > ipb) - (ipa < ipb);
+}
+
+static int bpf_text_poke_batch(struct bpf_text_poke **pokes, u32 cnt)
+{
+	int i, err;
+
+	/*
+	 * Sort pokes for two purposes:
+	 * 1. Check duplicated poke target IPs.
+	 * 2. Sorted poke target IPs would be friendly for poking them on x86,
+	 *    see arch/x86/kernel/alternative.c::smp_text_poke_batch_add().
+	 */
+	sort_nonatomic(pokes, cnt, sizeof(*pokes), bpf_text_poke_cmp, NULL);
+
+	for (i = 1; i < cnt; i++)
+		if (pokes[i - 1]->ip == pokes[i]->ip)
+			return -EINVAL;
+
+	err = bpf_arch_text_poke_batch(pokes, cnt);
+	if (err != -EOPNOTSUPP)
+		return err;
+
+	for (i = 0; i < cnt; i++) {
+		struct bpf_text_poke *p = pokes[i];
+
+		err = bpf_arch_text_poke(p->ip, p->old_t, p->new_t, p->old_addr, p->new_addr);
+		if (err)
+			goto rollback;
+	}
+
+	return 0;
+
+rollback:
+	for (i--; i >= 0; i--) {
+		struct bpf_text_poke *p = pokes[i];
+
+		WARN_ON_ONCE(bpf_arch_text_poke(p->ip, p->new_t, p->old_t, p->new_addr,
+						p->old_addr));
+	}
+	return err;
+}
+
 static int __init init_trampolines(void)
 {
 	int i;
-- 
2.55.0

