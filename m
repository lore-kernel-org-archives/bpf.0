Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7A83FAE04
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488672; cv=none; b=mcrbtBLuS0CmLbVrHOSDrQE4II6TPOJ7jMrJPPVA3I9caoeEHNl5Px3SMIXesAQkTm64Iihn7nOo3V+aps4Q+rCfmogzFlbdW5qlf+FNQesoAMcK2L+uFpugXZtBMPXQLN9Y2DC7kydeRwO1FTsTtfOqM8VABhsfHiQNTzI6lMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488672; c=relaxed/simple;
	bh=NIXtF+T6E3zcvPIXklfJSgnlpCitNPBGzmh3IJuVsGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBJVhK5leaeFJT4H7t95ZUT5jspRRSl6exqRJDiCa94zvpAujdbpiOueLx0euq84fIXqnVGBa+CSah07FpVlsB4r/3EZigc5kDzYhBvOQoTNalGMA2rvs0lIm82GbTynH1f/b4jg847MkDonnGgkGDJZWwwGqQ0aTC4+nBylmqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XL2wxM3+; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XL2wxM3+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782488665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+uwqkAO1BQ+J3KhGog7D8zuITv8Z+hU/sFRam0ZILA=;
	b=XL2wxM3+0LiOLY+mdRZ8G5TN5bWxuMxaSbo9Ffkb3fRCdL6sjp4svrUeXhkvdidhfz32B4
	b6NMf4sAh2eKEzwlm7AGqG4XwVssKTgHfY7/pHxuklwHhjCk2S9qROi7QVG7VrBCWLMqqY
	ESA4RYak26geSU+NLq920eZJ8FATqUU=
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
Subject: [RFC PATCH bpf 4/6] bpf: Disallow interpreter fallback for internal BPF_PROBE_ATOMIC insn
Date: Fri, 26 Jun 2026 23:43:28 +0800
Message-ID: <20260626154330.33619-5-leon.hwang@linux.dev>
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

The interpreter does not recognize the BPF_PROBE_ATOMIC insn.
Thereafter, it would hit the BUG_ON() in ___bpf_prog_run() at run time.

[    2.617849] BPF interpreter: unknown opcode e3 (imm: 0x110)
[    2.618643] ------------[ cut here ]------------
[    2.619277] kernel BUG at kernel/bpf/core.c:2349!
[    2.619928] Oops: invalid opcode: 0000 [#1] SMP PTI

On the fallback path from JIT in __bpf_prog_select_runtime(), reject
the BPF_PROBE_ATOMIC insn to avoid the BUG.

Fixes: d503a04f8bc0 ("bpf: Add support for certain atomics in bpf_arena to x86 JIT")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 900ba10e1de9..778ae565ebbe 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2627,6 +2627,9 @@ static bool bpf_insn_requires_jit(struct bpf_insn *insn)
 		    BPF_CLASS(insn->code) == BPF_LDX &&
 		    BPF_SIZE(insn->code) != BPF_DW)
 			return true;
+		/* BPF_LOAD_ACQ, BPF_STORE_REL insns */
+		if (BPF_MODE(insn->code) == BPF_PROBE_ATOMIC)
+			return true;
 		break;
 	default:
 		return false;
-- 
2.54.0

