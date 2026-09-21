Received: from mta0.migadu.com (out-137.mta0.migadu.com [91.218.175.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2844F96D6
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017197; cv=none; b=WVWbsxYFxzBVJS/T4iAo5rxBr/fV3pBID4zx3fQAeke4HXNJETVaClfDB5xhn3h+xOfW8quLZ2GHKwdjAnHr8eLz0r1C7tbcJPEAjEXtLT/nIcOPaU9ZS0o6jW3XZSdXyQMzLL27BzuQPcPxIeHgyNJ2fjY29NLhL/M5nkA1vck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017197; c=relaxed/simple;
	bh=owL6q3Fk9/55Zw1NYDaaYKrFvFrDV8FYtck2SkEVXUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUCEQIBHgnyAmAbz97pK/Lf+kXdTd6XMpMebpj8AwHmzcgedsCmQHc/L3JVKDH9CX7tSXGalE8uRznFDHOjhim8g0vr9qU7ATwtIBXT8ZblA6Wpw+TQmWhSuPkmU5wkqilFBo1pIr4lpVFpX1x7hHODBFpDTbAocS0/ua89JqG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vGRQM2Gx; arc=none smtp.client-ip=91.218.175.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vGRQM2Gx"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=owL6q3Fk9/55Zw1NYDaaYKrFvFrDV8FYtck2SkEVXUk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790017192; v=1; x=1790621992;
 b=vGRQM2GxPtn9yhfYeP2kSB6orQZ641hGUiBhFnYhqS5p7qdGdFaDtTV8j6WKOLHq+0+Q5Y8A
 xh056bi544xXDJunL9Qe989UPO9HzxXb+6K4EcKZsDwnOdDNjlwCbsFRv3ql1Bx7HoJXlaRJlX6
 Uq3pEZcHOENlusOytBwcE8cY=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id c7c189aa1dad7a7d;
	Mon, 21 Sep 2026 18:59:52 +0000
X-Mizu-Trace-ID: c7c189aa1dad7a7d
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: arighi@nvidia.com,
	bpf@vger.kernel.org,
	bsegall@google.com,
	changwoo@igalia.com,
	dietmar.eggemann@arm.com,
	etsal@meta.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	tj@kernel.org,
	vincent.guittot@linaro.org,
	void@manifault.com,
	vschneid@redhat.com,
	yphbchou0911@gmail.com
Cc: Usama Arif <usama.arif@linux.dev>
Subject: [PATCH 2/2] sched_ext: Specialize the scheduler hashtable compare
Date: Mon, 21 Sep 2026 11:59:12 -0700
Message-ID: <20260921185943.4031480-3-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921185943.4031480-1-usama.arif@linux.dev>
References: <20260921185943.4031480-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_sched_hash_params does not provide an object comparison function,
so rhashtable falls back to rhashtable_compare(). Although the
sub-cgroup ID key is one naturally aligned u64, the generic comparison
reads the key offset and length from the table parameters at runtime and
emits an out-of-line memcmp() for each element walked.

Supply an obj_cmpfn so lookups specialize to a single equality test
against ops.sub_cgroup_id. ext.c and sub.c are included in the same
build_policy.c translation unit, so the compiler can fold the const
callback into scx_find_sub_sched() even though its source is in sub.c.

The result is only tested against zero, so the ordering provided by
memcmp() is not observable. No functional change intended.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 kernel/sched/ext/ext.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 288d6b80bbca0..87fa09c71eb0f 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -41,10 +41,21 @@ struct scx_sched __rcu *scx_root;
 LIST_HEAD(scx_sched_all);
 
 #ifdef CONFIG_EXT_SUB_SCHED
+static __always_inline int scx_sched_cmpfn(struct rhashtable_compare_arg *arg,
+					   const void *ptr)
+{
+	const struct scx_sched *sch = ptr;
+
+	BUILD_BUG_ON(sizeof_field(struct scx_sched, ops.sub_cgroup_id) != sizeof(u64));
+
+	return sch->ops.sub_cgroup_id != *(const u64 *)arg->key;
+}
+
 const struct rhashtable_params scx_sched_hash_params = {
 	.key_len		= sizeof_field(struct scx_sched, ops.sub_cgroup_id),
 	.key_offset		= offsetof(struct scx_sched, ops.sub_cgroup_id),
 	.head_offset		= offsetof(struct scx_sched, hash_node),
+	.obj_cmpfn		= scx_sched_cmpfn,
 	.insecure_elasticity	= true,	/* inserted under scx_sched_lock */
 };
 
-- 
2.53.0-Meta

