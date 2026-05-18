Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12805282F00
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116201; cv=none; b=dO4oWTj9dmo1amsQVPrRb3hw1ynkxlheqk/rLXXRHwW7DEAtmn4GgUviWu/BoriytPmD9XeSBpIIu3Nfs7ur8MjYRJWvDwFr82c0qe78tI1+4GyxvET0BpwY8atbThqfdnEGHFPequwjMwAq56IX/Jr3weiLi2IkvK/eagzeASo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116201; c=relaxed/simple;
	bh=pGrid/MoHWKOyHGr/hGYclFjSiLInLI58doTfChTiyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrAJroh/Brv+mrW3qOIzYQUPfJMc1lZntBzcMlSN/pvhaCe2jBa7dInbnQ9/y3H30rdKGiQP3RcZqbjj/0pRHMd12vGORsEL+LTjkNVU3VNBWZSrB8FAta85EfAHl1eJwEJAXy1eeP0v2f47KYe9zBBLPilJlKeEHbwv5vcPf5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e/0vf8k+; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e/0vf8k+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779116193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JC5CXjDD2n44DjeRg6Hk4TrBdiWxB43TsPTPXprvrLI=;
	b=e/0vf8k+zvPIjaqDXm1ASgVyj7Egcg+D9gfqhxX+glr+LfFzw4zzd9tq08yGjv+oyS/PGI
	BVQpfhmhat/dfaDW0j3/ExK0iMkV6O5JY+Hr06iGM1IL2Y15TyegFlcedYnBmuCwckxfLl
	Nj4tEdRLTka2uBLyqNGyML6+fiYsccM=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 3/5] libbpf: Add OPTS_VALID() for log_opts in bpf_map_create
Date: Mon, 18 May 2026 22:54:44 +0800
Message-ID: <20260518145446.6794-4-leon.hwang@linux.dev>
In-Reply-To: <20260518145446.6794-1-leon.hwang@linux.dev>
References: <20260518145446.6794-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There should be an OPTS_VALID() check for log_opts before extracting its
fields.

If no such OPTS_VALID() check and an application compiled against a future
libbpf header passes a log_opts with new, non-zero fields to libbpf.so,
those fields will be ignored silently.

Fixes: 702259006f93 ("libbpf: Add syscall common attributes support for map_create")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 483c02cf21d1..3cd705802330 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -246,6 +246,9 @@ int bpf_map_create(enum bpf_map_type map_type,
 	attr.excl_prog_hash_size = OPTS_GET(opts, excl_prog_hash_size, 0);
 
 	log_opts = OPTS_GET(opts, log_opts, NULL);
+	if (!OPTS_VALID(log_opts, bpf_log_opts))
+		return libbpf_err(-EINVAL);
+
 	if (log_opts && feat_supported(NULL, FEAT_BPF_SYSCALL_COMMON_ATTRS)) {
 		memset(&attr_common, 0, attr_common_sz);
 		attr_common.log_buf = ptr_to_u64(OPTS_GET(log_opts, buf, NULL));
-- 
2.54.0

