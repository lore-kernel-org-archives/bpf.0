Received: from mta0.migadu.com (out-250.mta0.migadu.com [91.218.175.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2364A0135
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819729; cv=none; b=KiPSPJqn9ErM9lioXSca2tcvvoSR12NoDr5uC8DBZPBf3/Ezxl9BIa0uZUqGly49y/bgO92rVUOvuYgjZFWGBbJDSU5JU6ESJrYHSxqwZDUxSaUcNsaGUGRBGIe3ZntpItLWm0+dtVzydR2cu9kBSY0o2s7aqlCc5LylxHWKCBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819729; c=relaxed/simple;
	bh=s54T7ud4Allb5L//R3raxvCg95BkWf9Gd0S8HF2Bu+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjRUHYQeD2G7oDKUaz2zlHqTCd1zgVUGLnM/Xrx54TyS06/+4FjZWUn3IVSP8BM7ZKgt55gJTENHvLeg2ndRYBjuDkvCMmow8HPR3O2PuvMXqrzs7x00snjmueMq85aJ7Wb9dsNkZqA7eS+DtSUADDLuJQ40QuegpGAONk9tCMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KYES7Rh4; arc=none smtp.client-ip=91.218.175.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KYES7Rh4"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=s54T7ud4Allb5L//R3raxvCg95BkWf9Gd0S8HF2Bu+o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819726; v=1; x=1792424526;
 b=KYES7Rh46rQp9E4YTFqJlMjRN/6ObF8+f1I4imyNNdqqSP2YpsN99jGcAwzDMXpjjjBGCahZ
 sZmPZvNhSAMqtH+qYHAVysMRuqnrYSABiArdWyG439r431yOy50GZvxbpLX0PYuL1RY6cFd8bz7
 JHKUaavhGXh1EMMfGzfao8pM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 722f189b47c8927b;
	Mon, 12 Oct 2026 15:42:05 +0000
X-Mizu-Trace-ID: 722f189b47c8927b
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
Subject: [PATCH bpf-next v2 04/21] bpf, x86: Factor out bpf_arch_text_poke_check_ip() helper on x86_64
Date: Mon, 12 Oct 2026 23:40:06 +0800
Message-ID: <20261012154024.29423-5-leon.hwang@linux.dev>
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

In the following commit, it also needs to check the target IP and adds
ENDBR_INSN_SIZE when add text-poke batch support.

So, factor out bpf_arch_text_poke_check_ip() helper for text-poke batch
support.

No functional changes intended.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 74033373dc06..c80d3161d458 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -702,10 +702,10 @@ static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 	return 1;
 }
 
-int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
-		       enum bpf_text_poke_type new_t, void *old_addr,
-		       void *new_addr)
+static int bpf_arch_text_poke_check_ip(void **ipp)
 {
+	void *ip = *ipp;
+
 	if (!is_kernel_text((long)ip) &&
 	    !is_bpf_text_address((long)ip))
 		/* BPF poking in modules is not supported */
@@ -716,7 +716,20 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 	 * with an ENDBR instruction.
 	 */
 	if (is_endbr(ip))
-		ip += ENDBR_INSN_SIZE;
+		*ipp += ENDBR_INSN_SIZE;
+
+	return 0;
+}
+
+int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
+		       enum bpf_text_poke_type new_t, void *old_addr,
+		       void *new_addr)
+{
+	int ret;
+
+	ret = bpf_arch_text_poke_check_ip(&ip);
+	if (ret)
+		return ret;
 
 	return __bpf_arch_text_poke(ip, old_t, new_t, old_addr, new_addr);
 }
-- 
2.55.0

