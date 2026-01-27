Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F253009F6
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 02:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769481920; cv=none; b=srRIdUZ8hSm3UilF6vxrZoDqYryfqf61RmVVqkXs7AFqMm3RtSFnlRX326RyFVjMU89r6beF2Uq1ESkJ8rOmE67jCsn8d4PQl+GBcWDNyhnj41KCRDET8/Qj3F+bEaMRMOJ8JGVhcfgOgg56OTC14AalGa3q2QwSq14gv3lnB0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769481920; c=relaxed/simple;
	bh=6TPxpQSxNTPIxifYGyRlgcf4glO1k8ahw2h8kr+hhCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEigpYXU3j24jLDw/IKI0StEpgIsBTivhTmIp/+GkYX5YK6AOVzXpV8+yTD4I9zyZws5tjmOeaeH1INDXQOCEEYZDTIJxTkbSBhMxtjTC0dHmb6fhs+blyncYJsVJ0UxP6CE4rDJYVEtG/yh0DUc4i7QAkWWEczFgYxu2VdINVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KMfJCSSQ; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KMfJCSSQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769481916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEVQFK1CrN96TOQDcyO6X4A15QdAoRxZUpYERHQ3KZk=;
	b=KMfJCSSQf2P4ZrLUijVUpTvZRdY8hJlZWg5fUctzU6XA6R1FwG/I3xdXLLAANwqQTt/t36
	GGuU0FtZ13SPc7efjbHnzSqGimTuBtLyBvAMBKNvtYrc1v1hyaFCZNEz+RlmguXGZFbCgi
	ZX/9xw+Dj0mu/vZh5Y1XMhlXp4j9vi0=
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
Subject: [PATCH bpf-next v3 14/17] sched: psi: add cgroup_id field to psi_group structure
Date: Mon, 26 Jan 2026 18:44:17 -0800
Message-ID: <20260127024421.494929-15-roman.gushchin@linux.dev>
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

To allow a more efficient filtering of cgroups in the psi work
tracepoint handler, let's add a u64 cgroup_id field to the psi_group
structure. For system PSI, 0 will be used.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/psi_types.h | 4 ++++
 kernel/sched/psi.c        | 1 +
 2 files changed, 5 insertions(+)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index dd10c22299ab..749a08d48abd 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -159,6 +159,10 @@ struct psi_trigger {
 
 struct psi_group {
 	struct psi_group *parent;
+
+	/* Cgroup id for cgroup PSI, 0 for system PSI */
+	u64 cgroup_id;
+
 	bool enabled;
 
 	/* Protects data used by the aggregator */
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 72757ba2ed96..cf1ec4dc242b 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1124,6 +1124,7 @@ int psi_cgroup_alloc(struct cgroup *cgroup)
 	if (!cgroup->psi)
 		return -ENOMEM;
 
+	cgroup->psi->cgroup_id = cgroup_id(cgroup);
 	cgroup->psi->pcpu = alloc_percpu(struct psi_group_cpu);
 	if (!cgroup->psi->pcpu) {
 		kfree(cgroup->psi);
-- 
2.52.0

