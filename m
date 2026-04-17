Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DC23CBE9C;
	Fri, 17 Apr 2026 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776453949; cv=none; b=jNfD8awrRD9RoKnt/KUZrjghUC2KYIcJaH/y89SDXLUKSqbg2qfOkoto2StRtUy0twHRn8gx3J388i/0od4izL42OjXbbl/nqiKsoFC+gGmATfUwMcHr9AmlYRKEcApVa5MZt1ykKYrCQOgRoRdZFV4pfKwkzwP4hv02ZQBtpkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776453949; c=relaxed/simple;
	bh=BAdsJHK8KMf+V9rAazwzDWD2lmvQe8O89AAllw4uu3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7Vpsc6UwtjJlKCOqfrdhm9s/NtBSpG7XBKTA911uJBTEdKFkGBQGvAxZkskvZM49JGsLP98BICGoV66uxCrrxWqzOi1TOZEDFk350I/xgFvcnar6z2fxxEiO+ki2J3vBI9gSyVuXDa8dlJzemA8I8mo41zMGFPlbhXisPp4Ors=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3JGaIx7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3JGaIx7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF862C19425;
	Fri, 17 Apr 2026 19:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776453948;
	bh=BAdsJHK8KMf+V9rAazwzDWD2lmvQe8O89AAllw4uu3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I3JGaIx7G9zLpDUgyUDxjPokecokDuPcNSzn/jh41Jdyz+0lpTl19+jsZMl3E7yfr
	 uCtLn5pVEBsUNJ59jR2qw4J0jfKeMWAHqowzV7Uz5tM5/X72bm/XKC1YBjcrEYdOE3
	 c5JuZA5v9Ia3nFR+QonZOmAFT89E6KjzfoYp8VGn6Bn8kg7h76fH39gCY4kSyNLvpb
	 pQeeu+IqBB5qC0d+ApRWBLoMYv598R5q6MKZjgnmItIvyN6Uz8BVCATHMpkpoGB90b
	 NaipkMz71ZdmW85N96EH4RscXLQm+q9stBMclR5J2ForBiNXwNI0cd75UggJ2i7/jg
	 XALgUAVUNLVnw==
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
Subject: [PATCHv5 bpf-next 03/28] ftrace: Add add_ftrace_hash_entry function
Date: Fri, 17 Apr 2026 21:24:37 +0200
Message-ID: <20260417192502.194548-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417192502.194548-1-jolsa@kernel.org>
References: <20260417192502.194548-1-jolsa@kernel.org>
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
 include/linux/ftrace.h | 2 ++
 kernel/trace/ftrace.c  | 9 ++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index dc93dd332b07..b42697084fae 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -415,6 +415,8 @@ struct ftrace_hash *alloc_ftrace_hash(int size_bits);
 void free_ftrace_hash(struct ftrace_hash *hash);
 struct ftrace_func_entry *add_ftrace_hash_entry_direct(struct ftrace_hash *hash,
 						       unsigned long ip, unsigned long direct);
+void add_ftrace_hash_entry(struct ftrace_hash *hash, struct ftrace_func_entry *entry);
+
 unsigned long ftrace_hash_count(struct ftrace_hash *hash);
 void ftrace_hash_remove(struct ftrace_hash *hash);
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 5119d01ef322..7d57aa6e92e2 100644
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
2.53.0

