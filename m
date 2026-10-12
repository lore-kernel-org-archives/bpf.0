Received: from mta0.migadu.com (out-23.mta0.migadu.com [91.218.175.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8514A68AA
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819752; cv=none; b=P+YscYWD15LY4XhchHLl8pte8fomBpFJ1HOkYjb33ttJ+N6p7ZPlA9sU3b0hNSpj/bPSHkHbvJxxzYpclHf+Ml7zag9iLMWZ+ynIatJrZgl11/yqwZmQAubCUlzZSiTLx+NLAKbnkckGgM8E4s9/wd2fiz55oIoOAGK5F0sBlvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819752; c=relaxed/simple;
	bh=5DxR1s+LPijNQM6Qjyq68lt4V4WGoCE/dBj4zlO0PxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ugoMiC/Jv9XYUB0NZ98zensSSdd6vZiz9cV+zgB47d53lhrcRBXnH2kTlLYfJ2J3EmpXkxmuNRCLS+dtIcoHlJJt2TkXohebUtTG+OKYazxrrX30u6ZcIVg5QI/oGhXjf/Oog7+tUcq1gSrvUAGw9E9zkaI3GzgcdxeDAV6XIew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dMM9LXzT; arc=none smtp.client-ip=91.218.175.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dMM9LXzT"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5DxR1s+LPijNQM6Qjyq68lt4V4WGoCE/dBj4zlO0PxY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819749; v=1; x=1792424549;
 b=dMM9LXzT6Z+x5xarOVoCYT6c40CydSjd6hBgMw7qEbl3QovK2ZHwXHvO3E/3cJ37EN0dhzXz
 olBTY265+E6xoXV+f6TPkWT3mcYTWCbBcZ+CLfWYOGd6+JW5z9iN9iNBI65AGS3vWeRdINbP5ow
 /a080y1BsC2XVWUtgQcPfSk0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 64c13862dd3b4313;
	Mon, 12 Oct 2026 15:42:29 +0000
X-Mizu-Trace-ID: 64c13862dd3b4313
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
Subject: [PATCH bpf-next v2 05/21] bpf, x86: Introduce bpf_arch_text_poke_batch() on x86_64
Date: Mon, 12 Oct 2026 23:40:07 +0800
Message-ID: <20261012154024.29423-6-leon.hwang@linux.dev>
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

Introduce bpf_arch_text_poke_batch() to patch multiple targets in batch,
which utilizes smp_text_poke_batch_add/finish() on x86_64.

Thereafter, it will able to text-poke multiple bpf progs at once via
bpf_arch_text_poke_batch().

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 41 +++++++++++++++++++++++++++++++++++++
 include/linux/bpf.h         |  9 ++++++++
 kernel/bpf/core.c           |  5 +++++
 3 files changed, 55 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index c80d3161d458..b2040ae09273 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -734,6 +734,47 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 	return __bpf_arch_text_poke(ip, old_t, new_t, old_addr, new_addr);
 }
 
+int bpf_arch_text_poke_batch(struct bpf_text_poke **pokes, u32 cnt)
+{
+	u8 old_insn[X86_PATCH_SIZE];
+	u8 new_insn[X86_PATCH_SIZE];
+	int err;
+	u32 i;
+
+	for (i = 0; i < cnt; i++) {
+		err = bpf_arch_text_poke_check_ip(&pokes[i]->ip);
+		if (err)
+			return err;
+	}
+
+	guard(mutex)(&text_mutex);
+
+	for (i = 0; i < cnt; i++) {
+		struct bpf_text_poke *poke = pokes[i];
+
+		err = bpf_arch_text_poke_prepare_insns(poke->ip, poke->old_t, poke->new_t,
+						       poke->old_addr, poke->new_addr, old_insn,
+						       new_insn);
+		if (err)
+			return err;
+		if (memcmp(poke->ip, old_insn, X86_PATCH_SIZE))
+			return -EBUSY;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		struct bpf_text_poke *poke = pokes[i];
+
+		bpf_arch_text_poke_prepare_insns(poke->ip, poke->old_t, poke->new_t,
+						 poke->old_addr, poke->new_addr, old_insn,
+						 new_insn);
+		if (memcmp(poke->ip, new_insn, X86_PATCH_SIZE))
+			smp_text_poke_batch_add(poke->ip, new_insn, X86_PATCH_SIZE, NULL);
+	}
+
+	smp_text_poke_batch_finish();
+	return 0;
+}
+
 #define EMIT_LFENCE()	EMIT3(0x0F, 0xAE, 0xE8)
 
 static void __emit_indirect_jump(u8 **pprog, int reg, bool ereg)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 54144372281c..5b1a189e6e89 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4231,6 +4231,15 @@ enum bpf_text_poke_type {
 	BPF_MOD_JUMP,
 };
 
+struct bpf_text_poke {
+	void *ip;
+	void *old_addr;
+	void *new_addr;
+	enum bpf_text_poke_type old_t;
+	enum bpf_text_poke_type new_t;
+};
+
+int bpf_arch_text_poke_batch(struct bpf_text_poke **pokes, u32 cnt);
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 		       enum bpf_text_poke_type new_t, void *old_addr,
 		       void *new_addr);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 05c89396119a..49b794878c11 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3484,6 +3484,11 @@ int __weak skb_copy_bits(const struct sk_buff *skb, int offset, void *to,
 	return -EFAULT;
 }
 
+int __weak bpf_arch_text_poke_batch(struct bpf_text_poke **pokes, u32 cnt)
+{
+	return -EOPNOTSUPP;
+}
+
 int __weak bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 			      enum bpf_text_poke_type new_t, void *old_addr,
 			      void *new_addr)
-- 
2.55.0

