Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C6C44B69C;
	Wed,  3 Jun 2026 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484790; cv=none; b=eXJvIRTHC70wuJomwpKRS+MVOL6wBBAAv8jnpAf2MVeNb6sBkp1kzJR67rZqUaGhLK5Ee3Mywi2tSly0pYLz9b471nyk+tY3eFMS77FRTjsY+K/TNsfATYdXqxhWfxXk2mBCEc5DkIS1u2epc8cqlZPlhcKQpA64MCj9iQG1kSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484790; c=relaxed/simple;
	bh=BGK7gFzy7xwI8p7S2QnK2CY5EM2lGeT9sPUZV94GV3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7aLHaDHP9rJqHLApSIY/Gfe9j/W0njJGQzY88zMrfe5LpTyPBZFqz1zrKY/PPE0Bh7Md1MZrt5dqzADxOu/z5sjkwSIOwqstqhdHsZi+39wRQ4OQHyXYGgQntp6A/tT0A92M4pFcYvIE75mBFrwwSeTjJKVqG6pDDs04dff2n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjEGwyYB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjEGwyYB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826F51F00893;
	Wed,  3 Jun 2026 11:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780484789;
	bh=9C9iyyXicCikRUcZI625LZowoQI7FNr7EvEyd5b6+CE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HjEGwyYB8KFUr+iLaeSj2ygp9dsrB/aWLVrVZElEH9e9egsIGe06HMnQhXy5opq8g
	 uF6UhY0zwnr2Zj9gv2t/PjWmbkYfWp7eyurnyaoMMM3uWedl2nDMEqEOBvW7dq2m2f
	 QGN+XD6QUMp4LOsc3b+wCBTwuk9CQ+XMjqc+juLCe/aVY9m9RgENPtFvv8CTKeUII0
	 AZupso/ZCFE+cZgUE34PCCDt5kTjP2XhKZBTWROhgHNAoxOlTeWD5001Ke1NoEkHjt
	 tScMGfMi8Wablh5+Stua0pyY4YaOOZvlFnBrsdTILMoXIkVA0MV7TMH7Ghu+nWBXOM
	 QRkYS7MO1nGtQ==
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
Subject: [PATCHv7 bpf-next 03/29] ftrace: Add add_ftrace_hash_entry function
Date: Wed,  3 Jun 2026 13:05:27 +0200
Message-ID: <20260603110554.29590-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603110554.29590-1-jolsa@kernel.org>
References: <20260603110554.29590-1-jolsa@kernel.org>
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

