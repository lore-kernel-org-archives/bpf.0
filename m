Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540073DCDBD
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785971241; cv=none; b=AQu2DAduT2nXA1JMLqG/XRgX/TLxZBsTTtYbobiHeGZKLRlLJApwUtrfkJ4PHzHS6I0E5nwc+O2bFdA6ZZzQtHkdtzgX18N8ZLoWEoZvgwDqZ0B1Ijr5rII017ieuVJ9a9+8mPWUOWLk9e8y8QP2IiZM3kcWuAGMkbPfOCtjBmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785971241; c=relaxed/simple;
	bh=lWO0BUyig2uQrwhct59p1eXWmocFQInO19Fop/CcW+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AICSIwnX2eCfyCtl8eyGnXB582LcTAXauBfeu43vNVOWShEYv5yPAPJrcuGWFq75sFVHCou26jqNrGTl0wMARUEv+kd9KuqyYvEHkd+VSb2eb9cn8hWp8uR80rKblM0iIFnXWT4sz9okLi9Gct0NSUWXEA2/aeURcMhQ4oQiVfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G50jynkN; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G50jynkN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785971236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6j4CGcMRZnVH0HNp7I4qgWE0Cw9spdjMugAb7zzbRt4=;
	b=G50jynkNBP5xACsJ0ca5C1XQ9kmToOr9X+yi7uNb+ESBxOp9gGkdu0k8v/3+Y/2kT1nTwW
	ywHesFxefoBVPynKba202rgA93kdPPazqWQqY6BgF9ttrHB4fmFlEnrApOt9+Q1hsSk5nE
	yvZyrwos4Lx15YUyxUV0XylUdXPt+rU=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 1/6] resolve_btfids: Deduplicate BTF after btf2btf transformations
Date: Wed,  5 Aug 2026 16:06:43 -0700
Message-ID: <20260805230648.2354989-2-ihor.solodrai@linux.dev>
In-Reply-To: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
References: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

btf2btf() adds new types to the BTF: the KF_IMPLICIT_ARGS transform
synthesizes an _impl FUNC together with its FUNC_PROTO and copies of the
kfunc's decl tags. Nothing deduplicates them afterwards. pahole runs
btf__dedup() on its own output, but that happens before resolve_btfids
sees the BTF, so any type the tool itself creates is emitted as-is, even
when a structurally identical type is already present.

Call btf__dedup() at the start of finalize_btf(), so that base
distillation and the by-name sort both operate on the canonical set of
types.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 85488935909d..5d168c2a5ff5 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -1379,6 +1379,12 @@ static int finalize_btf(struct object *obj)
 	struct btf *base_btf = obj->base_btf, *btf = obj->btf;
 	int err;
 
+	err = btf__dedup(obj->btf, NULL);
+	if (err) {
+		pr_err("FAILED to dedup BTF: %s\n", strerror(errno));
+		goto out_err;
+	}
+
 	if (obj->base_btf && obj->distill_base) {
 		err = btf__distill_base(obj->btf, &base_btf, &btf);
 		if (err) {
-- 
2.55.0

