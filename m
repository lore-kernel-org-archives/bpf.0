Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF7837BE75;
	Sat,  6 Jun 2026 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749622; cv=none; b=OmBZgRaEh+TtXsjjYpAONR85IVg9eMu3NY3bof8bhNuR0CTCD9PMzgnVlBncUBN/eX77MFaJbULEgImsoUN+lFqko7b+7YIj6dWLhsgefm/fxwYRKGfgQZqZbfI4lyLriiVWjvPBPoQNFLhLNAg8iVk3r7AI8l7+0bP2G4uFM3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749622; c=relaxed/simple;
	bh=/P2aVMbllhpSCTKcJh4LAYY1a4fWv1WtEKnVEagpoRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmjcNTSbqgQwa3l7FeyyPpZTKESfVGPW7AUcW+NakOphP/MRYA+Ns+n6+6nTOzCflrPG5P61Dw4hi7Uxb3T4qcMCgmb6u5QkSoY6C2rMK6SblNXlqOa3k1b8SlHPJG0fMzmWQ0zoXNCwIsbZDHrmZijJIpQgeblYuEsvTff4ihY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BababAjC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BababAjC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3C21F00893;
	Sat,  6 Jun 2026 12:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749621;
	bh=DUViLivnhr22tZzVIR0cUlh7NZY4GvFWtdOine1stqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BababAjCcAjy4wQ70yjSeTV26kjlimPE/YNyscq7zPKACWYW7KC2y0eR5PV2LiQsC
	 poQmrWXOzEmwf2NemL1Y0NX29bF257UbDyQBgp6B3DwwppVxChmP6do9ryRDGoM8l6
	 jFsWwCeJZKzpcXLzsL0tdGcOA0B4ClAKr641kGeUc9cv2RX72b3FdTWX9HMRmB8JNp
	 chrPfoSRU6f6N4iFjsO9xQZVawL8urXrHkxRaKB5FOubzlZ6xgeb9OuxpoEMNO61LS
	 UBitkW3MmmzMkeVk3o7tpBD46lOf9XJA/mZgCcorQbFhl9D8I0N/qigJ4LjhZYqVn7
	 X5k0Mx2xPrwtA==
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
Subject: [PATCHv8 bpf-next 02/29] ftrace: Add ftrace_hash_remove function
Date: Sat,  6 Jun 2026 14:39:27 +0200
Message-ID: <20260606123955.345967-3-jolsa@kernel.org>
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

Adding ftrace_hash_remove function that removes all entries
from struct ftrace_hash object without freeing them.

It will be used in following changes where entries are allocated
as part of another structure and are free-ed separately.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h |  1 +
 kernel/trace/ftrace.c  | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 02c24bf766ce..b55ec9b25bb3 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -415,6 +415,7 @@ struct ftrace_hash *alloc_ftrace_hash(int size_bits);
 void free_ftrace_hash(struct ftrace_hash *hash);
 struct ftrace_func_entry *add_ftrace_hash_entry_direct(struct ftrace_hash *hash,
 						       unsigned long ip, unsigned long direct);
+void ftrace_hash_remove(struct ftrace_hash *hash);
 
 /* The hash used to know what functions callbacks trace */
 struct ftrace_ops_hash {
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 57ab01fd00bd..45548b0200eb 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1249,6 +1249,25 @@ remove_hash_entry(struct ftrace_hash *hash,
 	hash->count--;
 }
 
+void ftrace_hash_remove(struct ftrace_hash *hash)
+{
+	struct ftrace_func_entry *entry;
+	struct hlist_head *hhd;
+	struct hlist_node *tn;
+	int size;
+	int i;
+
+	if (!hash || !hash->count)
+		return;
+	size = 1 << hash->size_bits;
+	for (i = 0; i < size; i++) {
+		hhd = &hash->buckets[i];
+		hlist_for_each_entry_safe(entry, tn, hhd, hlist)
+			remove_hash_entry(hash, entry);
+	}
+	FTRACE_WARN_ON(hash->count);
+}
+
 static void ftrace_hash_clear(struct ftrace_hash *hash)
 {
 	struct hlist_head *hhd;
-- 
2.54.0

