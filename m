Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210543F8ED3
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488657; cv=none; b=ClKxr0QTXu7MVtRjEhCIk2G/i5SaSGtoYI/NpuI/KObGajGLmGDu/IOW5I7WtJ2DlYZ5Zr+hsIm2Ggvc1EAYgWUgs72kZBe31Wan+ab+acgHz6dN+HreVFdHcRFTR6HUv4A1zXpV7VpjrG8mgdHzYcWSL4y3OIL7eHsOdoL86HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488657; c=relaxed/simple;
	bh=LFJI83/WYpHfuRc1m3m73OyE0zcpWX/q8/bQyd/m6lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1yRw2bH+9n/VwPawFQ8WRjJ3MhcqhH1CDa6lucu6uyyhfAITG80WcAbQFhLBAHPLDdomfeHlZaIokSl3+SoxSAITYnq9LnmOMFND3Y3yOtdtuOddsQvShCa2Z4JzUijXbcu8EA3FAByDoPeEf2jY9aRTNpTrWVpgBO+/EfSc7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PtgCOI24; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PtgCOI24"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782488651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+7NjT/bLMzyhjKZ36rht9UI2veslGOj1wDwmks47Yxg=;
	b=PtgCOI248GDf4DNl95akD02zT2MvTD+T8ZwkqBrxawqhOUMtAslMQu1djDMYZdgu29dhoS
	B5dMzk8gCaF5NIzHg3Tk60mLKkqTlMQEVVAfja6p/NzOw/GdvL93fnDXc+XLq8auDRo+bK
	cBc/QtfIqXaUAb7SaCgOG5xl6I67at4=
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
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf 2/6] bpf: Disallow interpreter fallback for arena insn
Date: Fri, 26 Jun 2026 23:43:26 +0800
Message-ID: <20260626154330.33619-3-leon.hwang@linux.dev>
In-Reply-To: <20260626154330.33619-1-leon.hwang@linux.dev>
References: <20260626154330.33619-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The interpreter does not recognize the arena ST/LDX/STX insns.
Thereafter, it would hit the BUG_ON() in ___bpf_prog_run() at run time.

[    2.579196] BPF interpreter: unknown opcode a2 (imm: 0x0)
[    2.579998] ------------[ cut here ]------------
[    2.580652] kernel BUG at kernel/bpf/core.c:2349!
[    2.581314] Oops: invalid opcode: 0000 [#1] SMP PTI

On the fallback path from JIT in __bpf_prog_select_runtime(), reject
the BPF_PROBE_MEM32/BPF_PROBE_MEM32SX insn to avoid the BUG.

Fixes: 2fe99eb0ccf2 ("bpf: Add x86-64 JIT support for PROBE_MEM32 pseudo instructions.")
Fixes: a91ae3c89311 ("bpf, x86: Add support for signed arena loads")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e92eb8b7f945..37b2fac22aa2 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2613,6 +2613,22 @@ static bool bpf_insn_requires_jit(struct bpf_insn *insn)
 	if (insn_is_cast_user(insn))
 		return true;
 
+	switch (BPF_CLASS(insn->code)) {
+	case BPF_ST:
+	case BPF_LDX:
+	case BPF_STX:
+		/* arena ST/LDX/STX insns */
+		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32)
+			return true;
+		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32SX &&
+		    BPF_CLASS(insn->code) == BPF_LDX &&
+		    BPF_SIZE(insn->code) != BPF_DW)
+			return true;
+		break;
+	default:
+		return false;
+	}
+
 	return false;
 }
 
-- 
2.54.0

