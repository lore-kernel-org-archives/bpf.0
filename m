Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C5835B64C
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 03:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781753935; cv=none; b=BClZUUnkkDH3F0PCkBwa0CmEdHSmiy0k7EXJ8AwjGlAfYd8Fk/h5qgcfFOW9Mw5S+P+VzPVOx3laV5CkucxypTdohA7EHnR/wEjGUkL+KiehZ3VHyEHaPW84CZUpMeIHTHZVg4UHx3iYLZYKMQ8szrxk9uOnss5BExnubTW1sMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781753935; c=relaxed/simple;
	bh=ovsbRvIYV94RJkE83kDaGqq1x9ekMUzJ+NwM5Tl7wto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aTf4yvogZu+Dy4p+mpU0d0ZKCwxsbJ4b2OmqbZDQqEB32mG8HDvZnIvWXfJnsYQ/URxWlfdcy4A4gjX03A0XYY+5TVF7Lc8LuqMGcpAtvebO9EZkvxl99myJKcVvhQTBTk8VPBJ8gwh2b2HKGZD2CLJPqqvbZXRx8kWQ8i/Qmlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YmGlAyWM; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YmGlAyWM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781753931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5OcVGsLvEZQ+bxxlq5bKf6LxTvsCgsMqZkIFCqYtCg=;
	b=YmGlAyWMDCFcliLQzpne87BPRj11Pb46eE6vrQIAkWnMgxHIMQnXdtWYyAiMjA/JtLj+aG
	4Rtq9Hkba68tKiuZKIDIe+gK8qeBT0vGQDCR6ISe3LJw5bQltadEPBRgzJjMmuTopaiuww
	bIumS+Pf/dgp1CtIpuyZJA3FWvn93wY=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	hengqi.chen@gmail.com
Cc: kernel@xen0n.name,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 1/5] LoongArch: BPF: Gate unsupported arena instructions via bpf_jit_supports_insn()
Date: Thu, 18 Jun 2026 11:38:05 +0800
Message-Id: <20260618033809.98253-2-dongtai.guo@linux.dev>
In-Reply-To: <20260618033809.98253-1-dongtai.guo@linux.dev>
References: <20260618033809.98253-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

The JIT does not implement atomics on arena pointers (BPF_PROBE_ATOMIC)
nor sign-extending loads from the arena (BPF_PROBE_MEM32SX). Without a
bpf_jit_supports_insn() callback the verifier assumes both are available,
so such programs are accepted only to fail later in the JIT with a
confusing -EINVAL 'unknown opcode'.

Implement bpf_jit_supports_insn() to reject these instructions in the
arena case. The verifier then rejects the program early with a clear
message ('BPF_ATOMIC stores into R<n> ... is not allowed' / 'sign
extending loads from arena are not supported yet'). Regular arena
accesses (BPF_PROBE_MEM32 loads/stores of all sizes) remain supported.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 24913dc7f4e8..3f9ffdde2491 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -2357,6 +2357,26 @@ bool bpf_jit_supports_arena(void)
 	return true;
 }
 
+bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
+{
+	if (!in_arena)
+		return true;
+
+	switch (insn->code) {
+	case BPF_STX | BPF_ATOMIC | BPF_W:
+	case BPF_STX | BPF_ATOMIC | BPF_DW:
+		/* Atomics on arena pointers are not implemented yet. */
+		return false;
+	case BPF_LDX | BPF_MEMSX | BPF_B:
+	case BPF_LDX | BPF_MEMSX | BPF_H:
+	case BPF_LDX | BPF_MEMSX | BPF_W:
+		/* Sign-extending loads from arena are not implemented yet. */
+		return false;
+	}
+
+	return true;
+}
+
 bool bpf_jit_supports_fsession(void)
 {
 	return true;
-- 
2.25.1

