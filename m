Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C31F3033DD
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 02:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769481889; cv=none; b=D/9+n4AKILD/Ft0XfGCpkka2o4sKC7cR/Nq0owlEKw96UsoBAAGLRsOneXb0Djjwo9QYD9FJbc7FQnu3C22S81ltQ51N9xcoct9BqRe5w2+ght6gdFa6vj1c84+bbCNSHPM2sdxoD5idGu7oBRvlWn4eGyuEkJDoOXkiTwxPGMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769481889; c=relaxed/simple;
	bh=z0RVkCmdJdDDNrCdseww54S96faJsbAvjQEyWF1866s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxLcwmOzpqXPHMEgkueOALpLsVmvsiMkwNbpSaW9Ki5Xpz030ZM35Wr6ELgEnl7wvsxBAYHpJjZoLqXF4y2xnU3trlMEhV1gQh5vd9pWQmqWUWwrgTaRa/oPvs5KY5JPo5W7jRt39wazcBVEBqXOBVLvaKpRgenzP7X/ku25DlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e7K+ACi9; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e7K+ACi9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769481885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7vIbktSHcqXA79Byy9E+tFFPUOD4j27CypvW5n/XGM=;
	b=e7K+ACi9n83DQDrLs2gEyZxviqSCTioKtYK/6R2Y1KGkxiJq+PltmgZRjD4uPP2dmip1bI
	5902E3TbHB9SilvMJ5/obvDx/18kyu4hDGILzd0QyuPZgSHy2rJZ3wkN4vN0jsDOwK+s+p
	Y0PamNzRWNBsZqAdHYuRvLH9MSXAFkA=
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
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v3 05/17] bpf: mark struct oom_control's memcg field as TRUSTED_OR_NULL
Date: Mon, 26 Jan 2026 18:44:08 -0800
Message-ID: <20260127024421.494929-6-roman.gushchin@linux.dev>
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

Struct oom_control is used to describe the OOM context.
It's memcg field defines the scope of OOM: it's NULL for global
OOMs and a valid memcg pointer for memcg-scoped OOMs.
Teach bpf verifier to recognize it as trusted or NULL pointer.
It will provide the bpf OOM handler a trusted memcg pointer,
which for example is required for iterating the memcg's subtree.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c2f2650db9fd..cca36edb460d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7242,6 +7242,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
 	struct file *vm_file;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct oom_control) {
+	struct mem_cgroup *memcg;
+};
+
 static bool type_is_rcu(struct bpf_verifier_env *env,
 			struct bpf_reg_state *reg,
 			const char *field_name, u32 btf_id)
@@ -7284,6 +7288,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct oom_control));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
 					  "__safe_trusted_or_null");
-- 
2.52.0

