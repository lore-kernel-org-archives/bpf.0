Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E7A2EA159
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 02:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769481923; cv=none; b=exyp5+4qdKSUDtP/gy1SyIeN1kxLwJCZ5zH1VVGoKRLhyy7FO1ZXkpCnObdjo85JikJq2IpGYwTlbPA6UVlPN80fxhmGYtl10tgZyJtJBiTc8aeyyrRMPSpORrzXi7uUEBrvFDu9+hYTUAcSsChxnPUtdJhHbGXdIk/KfwGWZ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769481923; c=relaxed/simple;
	bh=VQJBUryOfB+5knfvThumOQ1TrljIAyYVhK3zZ93kKjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoG+gxPm6Yy18pGCJ9PX3lukkgTIWMZbcrw/80FCAef76ijE6hM7ag9AT99Oa8Dcd4yBtWnFx9kdyUZQS/NpDfXVKfq/Wgxj1B/HDo9l3wUT8CyW795sqzyOc25QedFkkjMLHipDl9ndTHbU4jWBjCgn5C7hTuOA6buxwevT2Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W4NnxCpR; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W4NnxCpR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769481920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VzpBZDmAb1p4WP9vTC/OiXnbOKBtuGA4TcHKnC3OdoY=;
	b=W4NnxCpR+zzlLvZAm2ipOemGZT10gSpKlvevrGrARxYlDRfCjKQrMfzBmHj0q3VNQ8I6eq
	RyhTFtiNlV5tlocFaPiWBYGbgzq3OSGTzjjcZFXXYLRt6vCAR5O0o5/qQ0xha7iYrNVbl/
	kQdIRbLHdk8Md7JFLfOgvea/HJN3zWE=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bpf@vger.kernel.org
Cc: Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH bpf-next v3 15/17] bpf: allow calling bpf_out_of_memory() from a PSI tracepoint
Date: Mon, 26 Jan 2026 18:44:18 -0800
Message-ID: <20260127024421.494929-16-roman.gushchin@linux.dev>
In-Reply-To: <20260127024421.494929-1-roman.gushchin@linux.dev>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Allow calling bpf_out_of_memory() from a PSI tracepoint to enable
PSI-based OOM killer policies.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/oom_kill.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 53f9f9674658..276cf8a34449 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1421,6 +1421,13 @@ BTF_KFUNCS_START(bpf_declare_oom_kfuncs)
 BTF_ID_FLAGS(func, bpf_out_of_memory, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_declare_oom_kfuncs)
 
+BTF_ID_LIST(bpf_oom_trace_ids)
+#ifdef CONFIG_PSI
+BTF_ID(typedef, btf_trace_psi_avgs_work)
+#else
+BTF_ID_UNUSED
+#endif
+
 static int bpf_declare_oom_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
 	if (!btf_id_set8_contains(&bpf_declare_oom_kfuncs, kfunc_id))
@@ -1430,7 +1437,8 @@ static int bpf_declare_oom_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_i
 	    prog->aux->attach_btf_id == bpf_oom_ops_ids[0])
 		return -EACCES;
 
-	if (prog->type == BPF_PROG_TYPE_TRACING)
+	if (prog->type == BPF_PROG_TYPE_TRACING &&
+	    prog->aux->attach_btf_id != bpf_oom_trace_ids[0])
 		return -EACCES;
 
 	return 0;
-- 
2.52.0

