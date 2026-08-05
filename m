Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483DA355055;
	Wed,  5 Aug 2026 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942527; cv=none; b=NcNm8de4AnHh0/9rJwdgFbPPDVbEkWqZlIUC4q2olXvFydneel4harseUs9uxL8Avibqm/qcpIhi6EAZDdo/oIRcp48THf8xlDEBLDEVN+2AnYCvxA/T70Mh2/oE7qfz6+5r2Aq5I2KAVdlHB3OWhCoUk0mnl0A7qZKWBXMiS6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942527; c=relaxed/simple;
	bh=Xi1OgDbyB/Evc8ioBE8gFyoHFsNQEXX7oTxNLufPR/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLl+qyL9iW63Mx1LxJxd7puCuruDzXsQejOshfk1AnyHiu3ngTdALQfJNrJ47CSFl7EL2x70Zl2WsYO0k+z/eC2B9Qhyy3y2J/WrrIl0JrQGzxQrLEa9nzQRq+nVWiVuQ5hkLQtCwBPshCaGabmXjEiy/MQUQ94idybTNXyoVUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uYZ+1Xyy; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uYZ+1Xyy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785942519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AmGOoR5eHblWxTntREzpR+YPiusEuFcyx+N/a238v3o=;
	b=uYZ+1Xyymr+o0EfKUZB5tmSXYpHZIIxHrJaZ3FrgivNJuq085PdyzSxR2EFTHcPUJ+jLW7
	ISCjUovSqjDz/KX1t5+mR/5PlcDbBspgwXhjETKb8qUY2lIx5OUDKC/QQMvY4f7wQMvLwE
	7pZKlVSQlBCQ9QAFz5uYmcCU/3sR7rA=
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
Subject: [PATCH bpf-next v4 1/2] bpf: Fix sleepable check for tracing/lsm prog
Date: Wed,  5 Aug 2026 23:08:09 +0800
Message-ID: <20260805150810.34907-2-leon.hwang@linux.dev>
In-Reply-To: <20260805150810.34907-1-leon.hwang@linux.dev>
References: <20260805150810.34907-1-leon.hwang@linux.dev>
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

Similar issue could be applied to lsm prog, when the
prog->aux->attach_btf_id is in the LSM allowing list but the attach_btf is
a malicious bpf prog's btf.

Fix it by disallowing sleepable tracing/lsm prog always when its target
btf is not kernel's btf.

Fixes: 16d9c5660692 ("bpf: Always allow sleepable programs on syscalls")
Fixes: 1e6c62a88215 ("bpf: Introduce sleepable BPF programs")
Acked-by: Viktor Malik <vmalik@redhat.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7439afdc851a..f364453a2ecb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19022,6 +19022,9 @@ static int btf_id_allow_sleepable(u32 btf_id, unsigned long addr, const struct b
 	const struct btf_type *t;
 	const char *tname;
 
+	if (!btf_is_kernel(btf))
+		return -EINVAL;
+
 	switch (prog->type) {
 	case BPF_PROG_TYPE_TRACING:
 		t = btf_type_by_id(btf, btf_id);
-- 
2.55.0

