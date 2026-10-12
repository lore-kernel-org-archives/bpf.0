Received: from mta0.migadu.com (out-234.mta0.migadu.com [91.218.175.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21024A3F0C
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819710; cv=none; b=TYQ1vhooWK3Q6izMjxn1rVc4LvfRe+79LMXju/Bc+K9It5eIBDXWaJBUv7BHYCAczb7AhN0Qi/ldX6yvyRCUd37RGVtF/Uyk+YdgbADDKhEmdKboz2gtR1UTFxGZS+nuPnaBCHtSBizLM1RH8Er68MDBlueWxa6Nh8DGIh1UKFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819710; c=relaxed/simple;
	bh=9GFCviZe2NrKLTFyGeCejEgBuk7CeWnqBry+7WSrryc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swMJan/0vHr93fROZAYKGIrcK0WOSqYkxAqt37NQ/EvqC0aUOE2BjrtTNUxvb0fTKmHXoATEpnwut6RC6n96w6kf+1srNB4f4Upr/AK1ZhVNVCCbESESkGYuZxuGQt9tOvnbvJ4Rc/zxUVUMLH1MPv5YLooMrm6ETkRffi8/VNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MEymq/9w; arc=none smtp.client-ip=91.218.175.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MEymq/9w"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9GFCviZe2NrKLTFyGeCejEgBuk7CeWnqBry+7WSrryc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819706; v=1; x=1792424506;
 b=MEymq/9wwTPO3tJICUdJZACo3FZVhZ6JuwyhDagnqRy9LU+yytFHoqwgMK0G/KN9YE0TKdYn
 m93oRvF/qzQ0xVyKsHvh5NcXAXyrPqDOz6HANj4cfypucIAF9ybUDzmQUnlzjlS45v1D+hS/ISw
 8I4Tkzvei5BZT53DLwQHb5a0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 397ec0e34a64babe;
	Mon, 12 Oct 2026 15:41:46 +0000
X-Mizu-Trace-ID: 397ec0e34a64babe
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
Subject: [PATCH bpf-next v2 03/21] bpf, x86: Factor out bpf_arch_text_poke_prepare_insns() helper on x86_64
Date: Mon, 12 Oct 2026 23:40:05 +0800
Message-ID: <20261012154024.29423-4-leon.hwang@linux.dev>
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

In the following commit, it also needs to prepare both old_insn and
new_insn when add text-poke batch support.

So, factor out bpf_arch_text_poke_prepare_insns() helper for text-poke
batch support.

No functional changes intended.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 38 ++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 083fcd6cf15b..74033373dc06 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -646,13 +646,12 @@ static int emit_jump(u8 **pprog, void *func, void *ip)
 	return emit_patch(pprog, func, ip, 0xE9);
 }
 
-static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
-				enum bpf_text_poke_type new_t,
-				void *old_addr, void *new_addr)
+static int bpf_arch_text_poke_prepare_insns(void *ip, enum bpf_text_poke_type old_t,
+					    enum bpf_text_poke_type new_t,
+					    void *old_addr, void *new_addr,
+					    u8 *old_insn, u8 *new_insn)
 {
 	const u8 *nop_insn = x86_nops[5];
-	u8 old_insn[X86_PATCH_SIZE];
-	u8 new_insn[X86_PATCH_SIZE];
 	u8 *prog;
 	int ret;
 
@@ -676,18 +675,31 @@ static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 			return ret;
 	}
 
-	ret = -EBUSY;
-	mutex_lock(&text_mutex);
+	return 0;
+}
+
+static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
+				enum bpf_text_poke_type new_t,
+				void *old_addr, void *new_addr)
+{
+	u8 old_insn[X86_PATCH_SIZE];
+	u8 new_insn[X86_PATCH_SIZE];
+	int ret;
+
+	ret = bpf_arch_text_poke_prepare_insns(ip, old_t, new_t, old_addr, new_addr, old_insn,
+					       new_insn);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&text_mutex);
+
 	if (memcmp(ip, old_insn, X86_PATCH_SIZE))
-		goto out;
-	ret = 1;
+		return -EBUSY;
 	if (memcmp(ip, new_insn, X86_PATCH_SIZE)) {
 		smp_text_poke_single(ip, new_insn, X86_PATCH_SIZE, NULL);
-		ret = 0;
+		return 0;
 	}
-out:
-	mutex_unlock(&text_mutex);
-	return ret;
+	return 1;
 }
 
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
-- 
2.55.0

