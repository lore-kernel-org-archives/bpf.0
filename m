Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A60D3AEF22
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 12:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913708; cv=none; b=oAlSdnPYGyyi8+idj6oF40B7V+ld5mYvzQdKH4JPySKJWlAFCO9kHZmP9tF94OVMfuSZt5VHAQXAy6doHePF6mhlUSJLWfwNm9rRWtgX3/qbpc2gxOKzRN8E/Md19cSbKHmwFw/y68l9xCwa2k0Ihl2/QaX7jnxKhZFzMhPYyp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913708; c=relaxed/simple;
	bh=FmHiwxsgvbf8GNNmKKs5BCKLowXDSY81ZfU5MpvoCm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMOfWjs1T9XPlvLxfKQaRXMGIWymeTNvRfV059gfBx9Ljh5tUTtL4IH5evVE6/6tjJqv9k7KOGxfkNspac5vONDYkKDzPQgGkn0yrxi2ezNKC4c3Y2Alu22G7LJ2wslb/6HLWZMRdOw/T1L1zKQhte8KhqnVDUeYKqOw4Xp25Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=mqn3WTNT; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="mqn3WTNT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=eoCXvJtjbDTw9XdqRRVdDyYSc3i23t8baPubDF04fg8=; b=mqn3WTNTpDNpJdU00KQqx/dNwO
	0iphwMjjQZI8Jb6pWWNNcRQxoScmcB8NbgFFlqje7ZDhFQQwD3IJaBs6a6MkNQ6sNRe5WwTx2EAAf
	A6lOz16NLzlRiIYwcUzaAIruzBLeGho9Ruf+fbVDqzt9B0vqjjV/8zqdsK1M4SzhoFnDyxXVeV+3b
	sC9PLG+x1Ovyy0I+iaVA0RgOz4iLeyGT0B+P1HHckbN8CuM2SHm1+5KPoDodPhQn6Tb1D7fP+oYDI
	Xez6fylRbwl/PpF5DPh+6jGTtaJdZLeyfe1FUO8rtJNt5xzQfkQnDteQ3gT8zXgEOCf4zhlY/EOaQ
	Z0+w8hrg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1viBGA-0000NW-1d;
	Tue, 20 Jan 2026 13:55:02 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next] bpf: Remove leftover accounting in htab_map_mem_usage after rqspinlock
Date: Tue, 20 Jan 2026 13:55:01 +0100
Message-ID: <09703eb6bb249f12b1d5253b5a50a0c4fa239d27.1768913513.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27886/Tue Jan 20 08:24:12 2026)

After commit 4fa8d68aa53e ("bpf: Convert hashtab.c to rqspinlock")
we no longer use HASHTAB_MAP_LOCK_{COUNT,MASK} as the per-CPU
map_locked[HASHTAB_MAP_LOCK_COUNT] array got removed from struct
bpf_htab. Right now it is still accounted for in htab_map_mem_usage.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/hashtab.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 441ff5bc54ac..3b9d297a53be 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -82,9 +82,6 @@ struct bucket {
 	rqspinlock_t raw_lock;
 };
 
-#define HASHTAB_MAP_LOCK_COUNT 8
-#define HASHTAB_MAP_LOCK_MASK (HASHTAB_MAP_LOCK_COUNT - 1)
-
 struct bpf_htab {
 	struct bpf_map map;
 	struct bpf_mem_alloc ma;
@@ -2237,11 +2234,11 @@ static u64 htab_map_mem_usage(const struct bpf_map *map)
 	bool prealloc = htab_is_prealloc(htab);
 	bool percpu = htab_is_percpu(htab);
 	bool lru = htab_is_lru(htab);
-	u64 num_entries;
-	u64 usage = sizeof(struct bpf_htab);
+	u64 num_entries, usage;
+
+	usage = sizeof(struct bpf_htab) +
+		sizeof(struct bucket) * htab->n_buckets;
 
-	usage += sizeof(struct bucket) * htab->n_buckets;
-	usage += sizeof(int) * num_possible_cpus() * HASHTAB_MAP_LOCK_COUNT;
 	if (prealloc) {
 		num_entries = map->max_entries;
 		if (htab_has_extra_elems(htab))
-- 
2.43.0

