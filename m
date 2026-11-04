Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793792282;
	b=MmhfMa5iEjFHS3CzaXNyX1xTdUzrnizl/XONZs5F6NIPv62UHgetUsLTYIObWDiTUNKV
	 dp20ypRslQuVo7IzvD7qhv8DD5mydaJw3jiiCqipxehdShN0r6pMuenZkJ3fK2EbVW+1H
	 m3yOrWxx23pVCjJBlU4mS+NEnGtnqKYDNx0nMPByWnGJg9zum/+C9nDzCmKGGsKOCaZHU
	 aqtIi3bNK4ARBo8xw7z9Mzzk384XonUEVL6cljQc0h6lhsR9PPaQbq/NfpoMW0q2d/UUu
	 821OscrupiMLzW/6kn9JUlphh9NVmz/mAu6Fz1GBFoiDdGUtwVExG9UZfIslnI144rA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792282;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SEFXswB/54yoLIAyF9zXZHTMGQkVUwJJcAcp+hk8wFw=;
	b=LKoz+JDAlh3V5WBTBy74CIhcELbhxlN7WPs0uw6BEDOzjfKclSRtLY8pvXGWoJOWlhfB
	 v5z0kUcZd8zBXHr7lPt4GlyTlJJb7D9h3CM8f2rq8Gq8vGgQuRxgQn7fewnLOyLusm5gI
	 PkZWKNhx8HaTuRl3LxpQXvm37ntTPXSKIAYGjMYQieG/TdI7oMSFYBNgCRZAxq+BqKC4h
	 cf/0UCrQmtGwCRJFKsUClDPVqv4v4GureprHV1/GScA7dtkm3IcT9cq2m6MXA+rgi/k29
	 0NhhMSbcOFkLiZxFdhTf+GQtMolSi9KGAYb2o5aKNnuLNPhx0kDWoFNpIb/dxAnP8iA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMTw5Htq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B79606D804;
	Wed,  4 Nov 2026 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMTw5Htq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793792282;
	b=SNLkW7zE2s3Jj/j2SshI+w3U6DgR8mirxYwp7jvNpEB3FKJvjnnCB4ywrR2zC0xEf7lb
	 nVX34F5FWt0iHbN1+DxCBZiblroEhQa//p4SMropm+O607wDKUlvzSfvkZCayfz036kca
	 ppXFHLhZytF7KuimVNBgEnb8oZPOvTQ4fgaRc/BARls/OmsJsOh4bn61qMmAJ4dj5y4oh
	 CetP6H/kMNxr5NTXt1BJaBG0LMWHLJaGQoxHn66N/bQmTmTwzWi4XCVwXHiiS3An6+4Fn
	 FcfUot3SaEt7VcqUEkbuiFjgSo7tq3VoKEBw19LcFMGA0+tgiV8CEfkY2kE3xapENOw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793792282;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SEFXswB/54yoLIAyF9zXZHTMGQkVUwJJcAcp+hk8wFw=;
	b=eZNksM2IJABBvpD4abg/1WaJRrYFCu72XGslfymaxGiEBoYHsJmHsfTy34tyOG3LXB2A
	 QTFNM199MXyBF3sX5Y0t6izp9Yk7U/SkcpOA5i1Nd3lsQSEdaDGyKLIcZRsqtNzsu+fbs
	 ibdbS4R7jU+wKcV0x4SEV9jJmSrZahzCQQhfeVXq8TP1yXemphxEgO5hzcyxSyaMAbT/x
	 LzgCtqCr8BUBqxpEX03Niruj3MVOsOKyYrOEPFof14HRQT0LyeoBwonIMKW5JU9sqGeRJ
	 PShdDm0YK8G8UPf8afcb9foeISUrKfZR8hNryo0mlcUM8vwSLbd9kEzgIaN9tsOOokg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A5A251F000C1;
	Wed,  4 Nov 2026 11:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793792282;
	bh=SEFXswB/54yoLIAyF9zXZHTMGQkVUwJJcAcp+hk8wFw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YMTw5HtqWPK/VLeqeM3svQv6jDuLszAoj++UlmdBmqGbGII2w9mS71R6a1PGXqRO9
	 lNsIMvit9C3Ah43YnSNZO2D7Hegxwe5z7F+B9lsJmVuL7vTm1Ui0a03P10HnqUKsns
	 bar0QJf8MbrWiEGxZfVTSwrugC+CQ8RuZVDVTjP7D2w3QESHZN0Q8JKDm40PmikX3N
	 VczaNR1MmWgb+Iq1WlMD3Z/84sPYNGGuAxz0mBfETi4x1Y9RhU5oS/NPxGtOsjGqN3
	 5GcHAnkw/xi4ENMX+aJoXtoa9KolYvAWQHx8k2Nm+cu+Hl/i10JoyUwRlheUp7ubJh
	 kcWacpNUS3Rjg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1006646DEB;
	Wed,  4 Nov 2026 11:38:00 +0000 (UTC)
From: Jonathan Bastari Thamrin via B4 Relay <devnull+thamrinjonathan.gmail.com@kernel.org>
Date: Wed, 04 Nov 2026 18:37:57 +0700
Subject: [PATCH bpf-next 1/2] bpf: Limit local storage value size to max
 kmalloc_nolock() allocation
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261104-local-storage-max-v1-1-c836731bd184@gmail.com>
References: <20261104-local-storage-max-v1-0-c836731bd184@gmail.com>
In-Reply-To: <20261104-local-storage-max-v1-0-c836731bd184@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Amery Hung <ameryhung@gmail.com>, 
 Slava Imameev <slava.imameev@crowdstrike.com>, 
 Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793792278; l=4249;
 i=thamrinjonathan@gmail.com; s=20261102; h=from:subject:message-id;
 bh=Degv3fbAgO6TESwqgj+YkYxSZ9RU1+DcLlSWyENFy7g=;
 b=cen+qO4ur3YTB/SmL21hKq4U36/Q64zQ63ccC0saOivh2BAnXSGqNMS715rPRfGM1KA84y7Kg
 PxNvP7QGjRlDeLleHApEb3SA97iuvrJBD1IK21KPEjZpC63CldPomvl
X-Developer-Key: i=thamrinjonathan@gmail.com; a=ed25519;
 pk=mr0q5PZVaUIrv8WvTxIfK7QVcAiRSYI8hOByBQL1ZRo=
X-Endpoint-Received: by B4 Relay for thamrinjonathan@gmail.com/20261102
 with auth_id=1383
X-Original-From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
Reply-To: thamrinjonathan@gmail.com
Content-Transfer-Encoding: 7bit

From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>

Since commit f484f4a3e058 ("bpf: Replace bpf memory allocator
with kmalloc_nolock() in local storage") for task and cgroup
local storage and commit 5063e7758899 ("bpf: Use kmalloc_nolock()
universally in local storage") for the rest, elements are
allocated using kmalloc_nolock() which has a maximum
allocation size of KMALLOC_MAX_CACHE_SIZE. Map creation still
doesn't match this and accepts values up to ~64KB. This causes
map updates to fail with ENOMEM due to the map not being able
to store anything.

BPF_LOCAL_STORAGE_MAX_VALUE_SIZE is now based on
KMALLOC_MAX_CACHE_SIZE and maps with larger values fail on
creation with E2BIG. Cgroup storage (BPF_MAP_TYPE_CGROUP_STORAGE)
still uses the previous limit as its own constant since it
allocates with kmalloc().

Fixes: f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolock() in local storage")
Fixes: 5063e7758899 ("bpf: Use kmalloc_nolock() universally in local storage")
Reported-by: Slava Imameev <slava.imameev@crowdstrike.com>
Closes: https://lore.kernel.org/bpf/20260410014341.47043-1-slava.imameev@crowdstrike.com/
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/CAADnVQKeFF--bgnZZSU12UY0muuwYA=7EdzLyOi837oZs+bXTA@mail.gmail.com/
Signed-off-by: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
---
 include/linux/bpf_local_storage.h | 10 +++++-----
 kernel/bpf/local_storage.c        | 13 +++++++++++--
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 6c643ac51079..e1ce75b0fb0a 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -117,13 +117,13 @@ bpf_local_storage_unpin_owner(struct bpf_local_storage *local_storage)
 	last = refcount_dec_and_test(&local_storage->owner_refcnt);
 }
 
-/* U16_MAX is much more than enough for sk local storage
- * considering a tcp_sock is ~2k.
+/* Elements come from kmalloc_nolock() where the max size
+ * is KMALLOC_MAX_CACHE_SIZE.
  */
-#define BPF_LOCAL_STORAGE_MAX_VALUE_SIZE				       \
+#define BPF_LOCAL_STORAGE_MAX_VALUE_SIZE                                       \
 	min_t(u32,                                                             \
-	      (KMALLOC_MAX_SIZE - MAX_BPF_STACK -                              \
-	       sizeof(struct bpf_local_storage_elem)),                         \
+	      (KMALLOC_MAX_CACHE_SIZE -                                        \
+	       offsetof(struct bpf_local_storage_elem, sdata.data)),           \
 	      (U16_MAX - sizeof(struct bpf_local_storage_elem)))
 
 #define SELEM(_SDATA)                                                          \
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 83cd527a2542..22a9841d4fd5 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -18,6 +18,15 @@
 #define LOCAL_STORAGE_CREATE_FLAG_MASK					\
 	(BPF_F_NUMA_NODE | BPF_F_ACCESS_MASK)
 
+/* Cgroup storage allocates with kmalloc() where the max size is
+ * larger than kmalloc_nolock() used by other local storages.
+ */
+#define BPF_CGROUP_STORAGE_MAX_VALUE_SIZE                                      \
+	min_t(u32,                                                             \
+	      (KMALLOC_MAX_SIZE - MAX_BPF_STACK -                              \
+	       sizeof(struct bpf_local_storage_elem)),                         \
+	      (U16_MAX - sizeof(struct bpf_local_storage_elem)))
+
 struct bpf_cgroup_storage_map {
 	struct bpf_map map;
 
@@ -296,12 +305,12 @@ static int cgroup_storage_get_next_key(struct bpf_map *_map, void *key,
 
 static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 {
-	__u32 max_value_size = BPF_LOCAL_STORAGE_MAX_VALUE_SIZE;
+	__u32 max_value_size = BPF_CGROUP_STORAGE_MAX_VALUE_SIZE;
 	int numa_node = bpf_map_attr_numa_node(attr);
 	struct bpf_cgroup_storage_map *map;
 
 	/* percpu is bound by PCPU_MIN_UNIT_SIZE, non-percu
-	 * is the same as other local storages.
+	 * uses the cgroup storage limit above
 	 */
 	if (attr->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
 		max_value_size = min_t(__u32, max_value_size,

-- 
2.56.0


