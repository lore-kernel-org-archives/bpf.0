Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AEE3A0E85
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488695; cv=none; b=Ur82K2YsABh9XMGlI/TzZOYXOPiXK+lKKs+TP3bdVfVLgRO19FFB2wemDF9LLB0IdFtdKkJMwpnYuUAq98NnsTfoGgcV5p7Bww/m+kgAqfJzjfMkNy6+LC71S1PT/V7LMzamCpFxZZgtpPODioZCeX2M9F5c6cDOulrGAyeHcjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488695; c=relaxed/simple;
	bh=DkQgsOf4oWLjDyzP1Ws8A6pVVBAiVUE1MBC1e+lyttM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1MTsW383vY/YB7VTEu83iDMQfLQIhptf3rx/ZsmHW1MNANxZVs6OSzScooKc2LF9ydFS1NGldtWYrM6269zOZLh84f5Kahijfdm3w8ODfipo/rBDWGH3MvC6Ooj+GFIqonfbZr7Kv2T7K7T9k8t47dexgJMHe29BAy80UgL3J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h9/aWysJ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h9/aWysJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782488688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TAy7SABCVRJPKg5bI8zkCIFlQ2UwZWcEE07BJNjY2CY=;
	b=h9/aWysJ4tx9MXzc3MX8Dhsgw1+DHMqaSl1y5rLxRvrjj16L3CALNxwp2d5UeEwcfNdKkf
	/KvrISXff2FOP/oucqnysG4mWkm+/72gLcXyMiNUjnDy6KMeUPMW3ZT9STp9FNuVAw30tm
	osZ3kbUdMqrpXxikjw6p+a568mF0dFY=
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
Subject: [RFC PATCH bpf 5/6] bpf: Disallow interpreter fallback for gotox insn
Date: Fri, 26 Jun 2026 23:43:29 +0800
Message-ID: <20260626154330.33619-6-leon.hwang@linux.dev>
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

The interpreter does not recognize the BPF_JMP|BPF_JA|BPF_X insn, which
is used for insn_array map. Thereafter, it would hit the BUG_ON() in
___bpf_prog_run() at run time.

[    2.563726] BPF interpreter: unknown opcode 0d (imm: 0x0)
[    2.564557] ------------[ cut here ]------------
[    2.565206] kernel BUG at kernel/bpf/core.c:2349!
[    2.565882] Oops: invalid opcode: 0000 [#1] SMP PTI

On the fallback path from JIT in __bpf_prog_select_runtime(), reject
the BPF_JMP|BPF_JA|BPF_X insn to avoid the BUG.

Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 778ae565ebbe..427d4e54ede4 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2613,6 +2613,9 @@ static bool bpf_insn_requires_jit(struct bpf_insn *insn)
 	if (insn_is_mov_percpu_addr(insn))
 		return true;
 
+	if (insn_is_gotox(insn))
+		return true;
+
 	if (insn_is_cast_user(insn))
 		return true;
 
-- 
2.54.0

