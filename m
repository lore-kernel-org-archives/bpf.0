Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3D746D0A8
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855482; cv=none; b=olbkciyUVePgtpPRMnPeJzf8eOR3g1Ao70XJfWNsskZvc+c2BXW4HMQ6NwfQ7gNTIoT5JqLTc5WTEPfd+/O/RmVIeBpkj/HawjQe8NzVgIkc9SNqqYorSA3it6xIsJW2GeA9wBC16A2dLfdjb4qX6EzCyPXTqLfS9tFYkYb3Ct8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855482; c=relaxed/simple;
	bh=tSl4ZcCJaQO2QgJCGFOfH8vTqTaFfBerbXP1wW2S840=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOFr9h1fRS1UiCEnkaBVdjdnmgXz6TPK3N7bOAGjxeux0qgqUZdTUWMn8cJzwBr9z+8vcZiDJFDJY4R2deBYf9CpbtT2T9+gsXJji2dL0ZWN2TTgdQsU9jSsPDtYXrplzSYJwfefXehFT56aCJRFPTJAl2JPf97bSHY5j0xTen8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d/JkbBsk; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d/JkbBsk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785855475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fs8nqwBOqL0v9GMZ6ryb7yeRi28md6/j0HbpFYrWssU=;
	b=d/JkbBskzHaxRY1pAK9nOsQARI89mnPc4Tqf9I+hcF3fTlCO+57lZEhBMkdZgPYnPY8ZHl
	0pDnWcF8xms4emKnsbmQAp/9+OhQjmKpITMTEYRRTistf2sXPDkqdNcaikUy/aBosoBES1
	2buQuvn/7DPVcr/OtymG+45/NknUurA=
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
	Shuah Khan <shuah@kernel.org>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Varun R Mallya <varunrmallya@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Viktor Malik <vmalik@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 1/2] bpf: Fix sleepable check for tracing prog
Date: Tue,  4 Aug 2026 22:57:09 +0800
Message-ID: <20260804145710.43062-2-leon.hwang@linux.dev>
In-Reply-To: <20260804145710.43062-1-leon.hwang@linux.dev>
References: <20260804145710.43062-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When CONFIG_FUNCTION_ERROR_INJECTION is disabled, a sleepable tracing prog
is allowed to attach to '__x64_'-alike prefix symbols.

It is because the verifier does not verify whether the symbol is a kernel
function or a bpf prog. That said, a sleepable tracing prog is allowed to
attach to a bpf prog target whose name has '__x64_'-alike prefix.

For example, a sleepable fentry prog attaches to a '__x64_sys_nop' XDP
prog, and copies buffer from a user pointer with bpf_copy_from_user()
helper. After attaching the XDP prog to lo interface, the kernel BUG
could be triggered by 'ping -c 1 -W 1 127.0.0.1':

[    3.460756] BUG: sleeping function called from invalid context at kernel/bpf/trampoline.c:1324

Fix it by disallowing sleepable tracing prog always when its target btf
is not kernel's btf.

Fixes: 16d9c5660692 ("bpf: Always allow sleepable programs on syscalls")
Acked-by: Viktor Malik <vmalik@redhat.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b274004fccfd..7bb541e343b2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19019,6 +19019,9 @@ static int btf_id_allow_sleepable(u32 btf_id, unsigned long addr, const struct b
 
 	switch (prog->type) {
 	case BPF_PROG_TYPE_TRACING:
+		if (!btf_is_kernel(btf))
+			return -EINVAL;
+
 		t = btf_type_by_id(btf, btf_id);
 		if (!t)
 			return -EINVAL;
-- 
2.55.0

