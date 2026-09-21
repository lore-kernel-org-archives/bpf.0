Received: from mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB303BCD05
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790011178; cv=none; b=un1ODB7RDXMxUoHUX/KHLpvr3EGSgcViMTzP9zgtiSUA5nqAEofhzjdoflBRJ+FUH45JncQDhloTO1pW3GovsmqX5YBADXnkuRpKaDg1T6jCpxhuEcTo5uCltGZTyUSNsIl/UZ1GJumCrxmIEBWuybnqwPYODOWIcHqav2rXitk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790011178; c=relaxed/simple;
	bh=n/3rqR1SXylUiKu59lxbqN9I91XnW8ne6Ykqya3PxMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i2SF5J6DDFGM6AvT49irav5uriWRLmEnmABP0FOpulFk19yrqGSWVke4Med5R1hB1P+ps5w7kbIjuIvUtYksna+szWTrNCT3OPdIVQG7j69rDOFexUTd0mYcTyMG53uqU9isJiEAeXrdx1H6EdK2xd8920n0BBY0Fxr2k5PKHz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QmXBbpzO; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QmXBbpzO"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=n/3rqR1SXylUiKu59lxbqN9I91XnW8ne6Ykqya3PxMc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790011173; v=1; x=1790615973;
 b=QmXBbpzOOrSqSQb9i1uT/MVkGfoxtU8eM6EmJk9GgSnTFlPIBBv7vg5CrmPhPCVbA2I5px7e
 IBxXl4zRX/qlBmnQIIPPauLKaIiHWgtgQzsqRYx6hyZL8ACvKUvRuobrlnBUZeXM1h+xy6ed8gF
 C/deVg3WO9fR/wvRwOHxXOD4=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 00ae2178923f4c09;
	Mon, 21 Sep 2026 17:19:33 +0000
X-Mizu-Trace-ID: 00ae2178923f4c09
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
Subject: [PATCH] sched_ext: Specialize the DSQ hashtable compare
Date: Mon, 21 Sep 2026 10:19:28 -0700
Message-ID: <20260921171928.1639407-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rhashtable is a generic container: it does not know what a key is, so it
carries the key's shape as data. dsq_hash_params declares key_len,
key_offset and head_offset and nothing else, so lookups fall back to
rhashtable_compare(), which reads both the offset and the length back out
of ht->p at runtime:

	memcmp(ptr + ht->p.key_offset, arg->key, ht->p.key_len)

The key is one naturally aligned u64, but neither the offset nor the
length is a compile-time constant there, so the compiler cannot narrow
the call and emits an out-of-line memcmp() for every element walked -
two loads, a call and a length dispatch to compare eight bytes. The
interpretation costs more than the comparison it is interpreting.

find_user_dsq() sits on the __schedule() path, and scx_layered calls
scx_bpf_dsq_nr_queued() once per layer per dispatch decision. On Meta's
fleet the lookup has a significant cost and shows up in fleet wide
profile.

Let's supply an obj_cmpfn. dsq_hash_params is a const object passed by
value into the __always_inline __rhashtable_lookup(), so
params.obj_cmpfn is a compile-time constant, the ternary that selects it
folds away and the callback inlines: the compare becomes a single cmp
against dsq->id. Every consumer of the result only tests it against
zero, so the ordering memcmp() also carries is never observed. No
functional change intended.

An in-kernel A/B over the DSQ ids scx_layered creates, both parameter
sets compiled into the same kernel, makes the lookup 2.9x faster.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 kernel/sched/ext/ext.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 9f40f366a1c13..646affba4e3c4 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -189,10 +189,21 @@ static DEFINE_PER_CPU(struct scx_tid_alloc, scx_tid_alloc);
  */
 static DEFINE_PER_CPU(struct task_struct *, direct_dispatch_task);
 
+static __always_inline int dsq_cmpfn(struct rhashtable_compare_arg *arg,
+				     const void *ptr)
+{
+	const struct scx_dispatch_q *dsq = ptr;
+
+	BUILD_BUG_ON(sizeof_field(struct scx_dispatch_q, id) != sizeof(u64));
+
+	return dsq->id != *(const u64 *)arg->key;
+}
+
 static const struct rhashtable_params dsq_hash_params = {
 	.key_len		= sizeof_field(struct scx_dispatch_q, id),
 	.key_offset		= offsetof(struct scx_dispatch_q, id),
 	.head_offset		= offsetof(struct scx_dispatch_q, hash_node),
+	.obj_cmpfn		= dsq_cmpfn,
 };
 
 static LLIST_HEAD(dsqs_to_free);

base-commit: d9ecc8c5e754065159bdd5cb580eb9295f7256b2
-- 
2.53.0-Meta

