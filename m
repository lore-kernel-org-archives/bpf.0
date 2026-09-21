Received: from mta0.migadu.com (out-143.mta0.migadu.com [91.218.175.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27DC50257F
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017200; cv=none; b=USgdzBRWF8Emt2XukmOmyqQQwE03Zx5rUSMQICcDFCpiTlWxiQw62ke5hCV7VIYLA6QLkO0eBUndBXksKUsBtqKH3qGKUjK74Hs6iXF23AyY4rU42jQPqjfFsZ4J59kmxXeHVEm1I+2seaYBnFqbMrQlN7B151lKfOVSKRktXZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017200; c=relaxed/simple;
	bh=OMfLu+KwVGCEytv7WY2nCcPwqM2qjTmGujwtUDmwF2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U68cD2ZmEnb09MvsUx0tGIhw0zbqAB57Hx0Xl70I4Kj8F4vm3lxFiWi++jp/3LAEGcv17e+KxiDtMO2fck10MhNhrBJowXnaOhgjpgz05iD05+fO9pxRmZDyGW02eGjWLkjD/FNM+4BOkOeMpIAbZymvG9y7iwMqX+qjWiUK/VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DJzggoyG; arc=none smtp.client-ip=91.218.175.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DJzggoyG"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OMfLu+KwVGCEytv7WY2nCcPwqM2qjTmGujwtUDmwF2Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790017196; v=1; x=1790621996;
 b=DJzggoyG4KHLODwb/0N8kon7tYWSbmTvZzIVRMdLQc+i49MHQoUJPf2Yk4dJMhLKd7qz97Wy
 mAonsMxncx+jZa1y6PQjOtkdhTh1BKJDPcqmmnlfcIxeSpIpNhHj5cs9QSEutJzSF0cHkpsoiw5
 LJL0lCHgqnZSCNsu9PEJCHj4=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 197ee3b1a99efb1d;
	Mon, 21 Sep 2026 18:59:46 +0000
X-Mizu-Trace-ID: 197ee3b1a99efb1d
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
Subject: [PATCH 0/2] sched_ext: Specialize TID and scheduler hashtable compares
Date: Mon, 21 Sep 2026 11:59:10 -0700
Message-ID: <20260921185943.4031480-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_tid_hash and scx_sched_hash both use naturally aligned u64 keys but
do not provide obj_cmpfn callbacks. As a result, rhashtable falls back
to rhashtable_compare() for each object visited during a lookup:

  memcmp(ptr + ht->p.key_offset, arg->key, ht->p.key_len)

Although only eight bytes are compared, the generic path loads the key
offset and length at runtime and emits an out-of-line memcmp() call.

The first patch adds a specialized comparison for scx_tid_hash. This
turns comparisons in scx_bpf_tid_to_task() into direct equality tests
against scx->tid. The kfunc can be used from hot scheduling paths, so
avoiding the generic comparison is particularly useful there. The
specialized comparison also covers duplicate checks during insertion.

The second patch specializes scx_sched_hash by comparing keys directly
against ops.sub_cgroup_id. This removes the generic comparison from
scx_find_sub_sched(), which is used when dispatching child schedulers
and by the sub-scheduler capability and management kfuncs.

In both cases, the const rhashtable parameters allow the compiler to
inline the callback and reduce each object comparison to a single u64
compare. Disassembly confirms that the lookup loops no longer call
memcmp() or an out-of-line comparator.

No functional change intended.

Usama Arif (2):
  sched_ext: Specialize the TID hashtable compare
  sched_ext: Specialize the scheduler hashtable compare

 kernel/sched/ext/ext.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

-- 
2.53.0-Meta

