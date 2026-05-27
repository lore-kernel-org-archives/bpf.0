Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C913F9A15;
	Wed, 27 May 2026 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882038; cv=none; b=D65iZIWaxCIobPa0+T1FdygRQ+O3vGiYeeUjfLJmM8b8tNuF5yPG2IjFpT2j9tN2kQXiX5eD4V+kbWRXEKM6DoUp0a1QIF7NudqGa4oKvxfnytKdrCF/f9YCzoITy4cV+A+KbvbPViL0nfPzRXcakS7QevZ6zLfWv3Rm9H6Rzbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882038; c=relaxed/simple;
	bh=prfwDtNnEkjJ+uY1sKNcmJR75jRQgh7iCbwZWZ2u+Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElzTMKKb013hJNBYb/396DaqDN/XrOzfQM/sEgG0XvpKuT0AS2Y4YW0W9HF1dn6uxEEprWOVLKbow6yn2Ayk/Krusot0ZMeUnr8FtgeKLdwezcxMeJD1LI44KToIGGTIqOV7BEcpzKAZwR3HbzMTBnm1fRo6medo0fAV9lehQ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGLp933Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGLp933Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75021F000E9;
	Wed, 27 May 2026 11:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779882032;
	bh=QT4ZkSOFfbNL70HBeUejBn5ln085exmqoRRMN+wnyBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HGLp933ZW4KxoO0Yv3Zp4Y0AIRs+MKrQN0wCZAUfQQj3wSbI6bLNCbcpjFChhK0Fk
	 V+8cLPssv0vPvkQXNxs0Ql644J8/G1ItdvvfD3SlqLSEpBRF5WcCaeG3uBU/t6kAXy
	 uyXHh+21ogR7utvSL79HncBMwXw37y9IIpfryv8XVjSi84DBFk61ropC7IopYvTwQy
	 vQdcSImjCoE49afLKC3dNqEmQOqsXChlsdlfj5wCIdJm2j/jhNj6r9TFCkd5/AAhBH
	 2pfJBP0435/itQM7UX3WQdgd4fBTV8To1JcoJU6q1wf5YqVwPOwQB7HEEb+cyp9LbC
	 Wsn+3R8c1NdKg==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv6 bpf-next 03/29] ftrace: Add add_ftrace_hash_entry function
Date: Wed, 27 May 2026 13:39:25 +0200
Message-ID: <20260527113951.46265-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527113951.46265-1-jolsa@kernel.org>
References: <20260527113951.46265-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Renaming __add_hash_entry to add_ftrace_hash_entry and making it global,
it will be used in following changes outside ftrace.c object.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h | 1 +
 kernel/trace/ftrace.c  | 9 ++++-----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index d3acfac4f8a7..cccbe21493ce 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -415,6 +415,7 @@ struct ftrace_hash *alloc_ftrace_hash(int size_bits);
 void free_ftrace_hash(struct ftrace_hash *hash);
 struct ftrace_func_entry *add_ftrace_hash_entry_direct(struct ftrace_hash *hash,
 						       unsigned long ip, unsigned long direct);
+void add_ftrace_hash_entry(struct ftrace_hash *hash, struct ftrace_func_entry *entry);
 void ftrace_hash_remove(struct ftrace_hash *hash);
 
 /* The hash used to know what functions callbacks trace */
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 45548b0200eb..f93e34dd2328 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1198,8 +1198,7 @@ ftrace_lookup_ip(struct ftrace_hash *hash, unsigned long ip)
 	return __ftrace_lookup_ip(hash, ip);
 }
 
-static void __add_hash_entry(struct ftrace_hash *hash,
-			     struct ftrace_func_entry *entry)
+void add_ftrace_hash_entry(struct ftrace_hash *hash, struct ftrace_func_entry *entry)
 {
 	struct hlist_head *hhd;
 	unsigned long key;
@@ -1221,7 +1220,7 @@ add_ftrace_hash_entry_direct(struct ftrace_hash *hash, unsigned long ip, unsigne
 
 	entry->ip = ip;
 	entry->direct = direct;
-	__add_hash_entry(hash, entry);
+	add_ftrace_hash_entry(hash, entry);
 
 	return entry;
 }
@@ -1477,7 +1476,7 @@ static struct ftrace_hash *__move_hash(struct ftrace_hash *src, int size)
 		hhd = &src->buckets[i];
 		hlist_for_each_entry_safe(entry, tn, hhd, hlist) {
 			remove_hash_entry(src, entry);
-			__add_hash_entry(new_hash, entry);
+			add_ftrace_hash_entry(new_hash, entry);
 		}
 	}
 	return new_hash;
@@ -5360,7 +5359,7 @@ int ftrace_func_mapper_add_ip(struct ftrace_func_mapper *mapper,
 	map->entry.ip = ip;
 	map->data = data;
 
-	__add_hash_entry(&mapper->hash, &map->entry);
+	add_ftrace_hash_entry(&mapper->hash, &map->entry);
 
 	return 0;
 }
-- 
2.54.0

