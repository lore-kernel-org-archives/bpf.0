Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660AF3A8746;
	Sat,  6 Jun 2026 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749632; cv=none; b=oU0Ou8bC6e9NtKCvOLu9KgP2ri4fM4ggTs7cmJOqtfRZK3LZARefsbmjHgWut87P+jIk9Ym6kRxZIwG3I+FZDhZD7NieghAgQ6b9dIGRInwM2SII4lN1gGk+tw7SA633ymu3kb6PLvG6kuNIE1hbLTdLsQJayzGamxIN8X0A/3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749632; c=relaxed/simple;
	bh=BGK7gFzy7xwI8p7S2QnK2CY5EM2lGeT9sPUZV94GV3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FG2QRPWMy4lQU5ub/fv8/TAExt7fqZM7Y7dDDV/xwty0fza5g3rmGFFKu4Gxg1D3GjsI8Q+FwBQ2BLZbfU0n0ePqtyX8rNmWQzwM2yz1y6nK2KnXealD9YnLkLC5bmwdTCwIJ5tsayFk5EcS9D4geSWCkh2ZlJRcuyIpwxkvLd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPgTVo23; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPgTVo23"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E351F00893;
	Sat,  6 Jun 2026 12:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749631;
	bh=9C9iyyXicCikRUcZI625LZowoQI7FNr7EvEyd5b6+CE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VPgTVo23wABhn2AjGnh/8Rd9EdvjiAX7JYEsUelfva1aMkqlddX1JznY0klK0LpfR
	 ewrgaRR4WxQwdZrmq6LRyMRmkSORVszboRvZo4/6/OuRcayE69SM2W5xZKnHvppC+B
	 6TE4n+gZ39pRf537SdqEnFpRMd3b1weslttdt8xzjXaOIW96Nk32NeGPZ57f+mybK3
	 wsEmpG5Tl8TaQBmSQadPAXW4A9DpYIlaJ7ol+0UxFikRc4/fCSf8KqM8XKH+zU7gJI
	 UyYkTVz53leydErmiyR45QknH4+QnIH26/g66NZfUlGcYxudSyCHf8SN07glJWOERx
	 DU/OxgJDV7O7w==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv8 bpf-next 03/29] ftrace: Add add_ftrace_hash_entry function
Date: Sat,  6 Jun 2026 14:39:28 +0200
Message-ID: <20260606123955.345967-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606123955.345967-1-jolsa@kernel.org>
References: <20260606123955.345967-1-jolsa@kernel.org>
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
index b55ec9b25bb3..02bc5027523a 100644
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

