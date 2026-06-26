Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C043F9F48
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488663; cv=none; b=aq087IqlF/q/RyplSX+F6q5FX+Jx1YL8y7yhfZjo2z1+cWyDJTJ6AZXutumNEkNdidojl1fLMuNdEvW9wOv0RmF7GKgz2lpTZfS2BtxB/3fmbc0jXod1SarFrFS5eIl/ftEdllyQFDmOgH3TAcnnQ1mAJV1t+/3dprk2Aegw/iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488663; c=relaxed/simple;
	bh=CR7NgtRCEjEELU98sQpbtRaMiMtxEdPhwNes3Jw/NpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJKyNsvoLY7Z2gl23/azYjQeSYC5Pz5e5LiDym8raYGFe5gjIsimBhtaY0vFTKjDn2pWITpe5kVOdkXH8tCHb3jlEzBiNm2cJobIvsKODVNXR8V+WZ7fXed2vtogSWgD6sEdIZJiYvbUpfm3dBAdqyvG9Xww6ZUHPz4B2+JNXjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PV7dhtk5; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PV7dhtk5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782488658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIku7ff88HLif8faSkxStPCFLwjq3f69GSIkG3RzOvk=;
	b=PV7dhtk5C0RzCzz9CtkMFgPiCwV087Yl6w+UXWyt2HHo3gcjI6RMvMei7DLhLdvyKzkNMY
	X7sK3Q3UtVOFMi/GF0AvV9Xz1GBjoNXlfH4pccJxCNQs5UnrZusilASKuArCj4oC230bB7
	5xz52YuJq0H38hXIudPYJudCZq1rI+I=
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
Subject: [RFC PATCH bpf 3/6] bpf: Disallow interpreter fallback for BPF_MOV64_PERCPU_REG insn
Date: Fri, 26 Jun 2026 23:43:27 +0800
Message-ID: <20260626154330.33619-4-leon.hwang@linux.dev>
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

The BPF_MOV64_PERCPU_REG insn requires JIT to emit native code to for
'dst_reg = src_reg + <percpu_base_off>'.

However, the interpreter ignores the 'off' at its ALU64_MOV_K label.
The 'off' indicates the insn is BPF_MOV64_PERCPU_REG insn. Then, when
the interpreter loads memory from the register, it will hit a page
fault.

[    2.545572] BUG: unable to handle page fault for address: ffffffffacaaf034
[    2.546485] #PF: supervisor read access in kernel mode
[    2.547167] #PF: error_code(0x0000) - not-present page
[    2.547850] PGD 134e63067 P4D 134e63067 PUD 134e64063 PMD 10021c063 PTE 800ffffeca550062
[    2.548912] Oops: Oops: 0000 [#1] SMP PTI

On the fallback path from JIT in __bpf_prog_select_runtime(), reject
the BPF_MOV64_PERCPU_REG insn to avoid the page fault.

Fixes: 7bdbf7446305 ("bpf: add special internal-only MOV instruction to resolve per-CPU addrs")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 37b2fac22aa2..900ba10e1de9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2610,6 +2610,9 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
 
 static bool bpf_insn_requires_jit(struct bpf_insn *insn)
 {
+	if (insn_is_mov_percpu_addr(insn))
+		return true;
+
 	if (insn_is_cast_user(insn))
 		return true;
 
-- 
2.54.0

