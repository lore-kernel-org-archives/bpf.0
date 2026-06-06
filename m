Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7A02D8767
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780767055; cv=none; b=WHOivdqlqLeenWiKGyacXhdW/sH1+LfQBY6PF/s2xUz78KN3PiS59cUXsJykyEgadtO//iouIL80SohYEScFyFbgQYN9ekA4HWqGZFKX7AkD3o15UnSkVrHmmhjYeeIlZsGCtjl8BHxfUw/x7gcgPk3P3KYB8nSIb/8VP8WJeAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780767055; c=relaxed/simple;
	bh=KhHPFtGddhvbGqrouM7o4LGuh5cbQX+sRxuTTBC/3Yo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L0N/wbLh4OddUuNXPhSNWIxZcYNT7JVVIEqa4APTMG5+gSGcBq7gMLV1FtYLHEgvCkZrJeJnK41ZGUZr7u5kXuXpP0obkOJSaL7Nvx0nkpaJHw2eeT4WoFo5eAOXNCtmCNje14qjOe+EbSzHD3VWhfYNFwAFvdj4LpUcdf4Bja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLZ5LT4N; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLZ5LT4N"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so25442755e9.3
        for <bpf@vger.kernel.org>; Sat, 06 Jun 2026 10:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780767050; x=1781371850; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8WWt0jB/eTMnLnunuUHyMCV3cRR0/N8bV7Y/N+sxwqc=;
        b=BLZ5LT4NkCeHDguvPeXqj2Vxw7z3va5TKY/YNF+v/jJfO8+Tv4ZOLCmgLkJDUzW9/U
         vgeQvEXUapcPfYaEVmOQfoqt4Wd3t9h0vjEi0zo33rZyK9sNtt/V8j/JzGRMsei4+qNm
         GQMGRnwxziYU3Ijoj9bdFjAt+rVEqytO9aOlYegnQ6II3RQ8gG7lXOek/KGi3DLmRH8r
         XnmP1memUgnGwwptetrKo83vjID+oQgGSpbIKXlj0IXtWjTdFsQYC8hUPLh0AgVlmup1
         aXtk3D23JAz2J9s6zlGd/hW5fMnmGrtPVqWJdomoWiCgUCZyiaMTRhFd6X+k57t6r96l
         2ICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780767050; x=1781371850;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WWt0jB/eTMnLnunuUHyMCV3cRR0/N8bV7Y/N+sxwqc=;
        b=LALOTS7HI1hN+157AY/+qZrpxMXTaGNOi8PoLLSU6XwAC+ja6naDfT/QyBDyC0CszW
         qp7Rg2ZrmlvaPVLrKsUnyZKhNQNWX6KxxPDmOJjkYEE69JkETeQeoc3fttVS2cZeglJW
         LlZLlkWjvQk6HCq2McTsPzGNA/rwnl4+/BJOeryXj+rGlfuz3lu27G8rHENKhhLhfp+/
         b9MA2WLeNeXMZ3AdiLCV3A85MW6WfprwUTfDWtSlpYWTc18Ko8eVofkq1kQI0XihlbrF
         itv3Xjt0sTMZBEnRsEr5BUG541aIus/6WO4mJkFfvynz3iFKV4OVp2qoDKT2OfJ4E8pC
         Dhgw==
X-Gm-Message-State: AOJu0YwfKrS6rJAozbAsAqLE933hgBvBFyhd5KmRI3MIHVp3iEAytRiZ
	rY8VHSE29r15vRZu8tXrUDqwYtKNove3PUqc9qTBfw3xS4Ox3WnHXGva
X-Gm-Gg: Acq92OHSbZ3igkLUZByX8pF1E5PLkfqU/gXE7/wGGB+bkuketE0+HLssTXo5O8eY4PD
	FzniNyq+kPpBrpoKAajZjRkDWF3TdcYKWZvq9irct64FBLv9jOWZ+B5IOPQLBrUFtpJt0oLHOor
	Xroq06I8ot+EpL8ax0CmZUB0qZ2mgT0bYNPK34p/4adPnVziQEVTLtyXK89lrh2lXTfWQIqLYI9
	EaeXASRZoaPlilQST32sbO3GYMK6Di9FMk3m6hYc0alCNvGjLniWPMGC1cf8dXW3bhC2KT/T2kp
	cDO7kLGAteYD+Q2TVIqy8vRfGglsvqH+MuGTa00ynm5Ph0WPONJ/rk7yXkJvUIQbVbBRu85EVGJ
	+M6Iw4Yp36UjTdNxlI6nwt+VVFb3SospVWPFYs+ASDXZH6SPT/5IzrsgXGdmPOGBv8aasCpjV+d
	MYeZaXLh9Rt5pmQOqmp0cPM8c=
X-Received: by 2002:adf:ff89:0:b0:45e:ef2e:25a8 with SMTP id ffacd0b85a97d-46030623f7emr10633257f8f.32.1780767050349;
        Sat, 06 Jun 2026 10:30:50 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344541sm33944127f8f.22.2026.06.06.10.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 10:30:49 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Sat, 06 Jun 2026 10:30:32 -0700
Subject: [PATCH bpf-next] rhashtable: Fix rhashtable_next_key() build
 warnings
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-rhash_fixes_1-v1-1-932ab036e6bc@meta.com>
X-B4-Tracking: v=1; b=H4sIADdZJGoC/x3JQQqDMBAF0KsMf20gySKVXKUUifptZhMlU4og3
 r3Qt30XjF1pyHKh86ume0OWMAiWWtqbTldkQfQx+eST67VYnTY9aVNwa+S8jCGxPIhBcHT+C1m
 emI/NNZ4fvO77B4jiW/xpAAAA
X-Change-ID: 20260606-rhash_fixes_1-d2ebc816ea7e
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780767048; l=5937;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=Yj6tnh4npk6QFFnOuuSYEgpUrwffjBtl/hpCzuFLRDQ=;
 b=q8k39tjjDAf+dF4/NrQy9m2sX7BAwrhZ+tyn3DeWi8qyRMtXao+TFHa/AGEd8K6uced+Khlez
 MYOTpg8qs8jCfJm1jz35RHilHE7NIQAYgPn0CWSyrD40o4HOOYF7GX7
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

rhashtable.o builds with warnings as rhashtable_next_key() kdoc
from lib/rhashtable.c does not have the arguments descriptions.

Move rhashtable_next_key() kdoc from header to c file, matching
other functions.

Move rhashtable_next_key() next to the other forward declarations
in the header file.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606061925.WI4bYI8k-lkp@intel.com/
Fixes: 8f4fa9f89b72 ("rhashtable: Add rhashtable_next_key() API")
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/rhashtable.h | 42 ++----------------------------------------
 lib/rhashtable.c           | 35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 41 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 3de3412d53c8..79f83b6eec27 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -263,6 +263,8 @@ struct rhash_lock_head __rcu **__rht_bucket_nested(
 struct rhash_lock_head __rcu **rht_bucket_nested_insert(
 	struct rhashtable *ht, struct bucket_table *tbl, unsigned int hash);
 
+void *rhashtable_next_key(struct rhashtable *ht, const void *prev_key);
+
 #define rht_dereference(p, ht) \
 	rcu_dereference_protected(p, lockdep_rht_mutex_is_held(ht))
 
@@ -650,46 +652,6 @@ static __always_inline struct rhash_head *__rhashtable_lookup(
 	return NULL;
 }
 
-/**
- * rhashtable_next_key - return next element after a given key
- * @ht:		hash table
- * @prev_key:	pointer to previous key, or NULL for the first element
- *
- * WARNING: this walk is highly unstable. Unlike rhashtable_walk_*(),
- * it cannot detect a concurrent resize or rehash, so a full iteration
- * is NOT guaranteed to terminate under adversarial or sustained
- * rehashing. Callers MUST tolerate skipped and duplicated elements and
- * SHOULD bound their loop externally.
- *
- * Returns the next element in best-effort iteration order, walking the
- * @tbl chain (including any future_tbl in flight). Caller must hold RCU.
- *
- * Pass @prev_key == NULL to obtain the first element. To iterate, set
- * @prev_key to the key of the previously returned element on each call,
- * and stop when NULL is returned.
- *
- * Best-effort semantics:
- *   - Across the tbl->future_tbl chain, an element being migrated may
- *     transiently appear in both tables and be observed twice.
- *   - Concurrent inserts may or may not be observed.
- *   - Termination of a full iteration loop is NOT guaranteed under
- *     adversarial continuous rehash; callers MUST tolerate skips and
- *     repeats and SHOULD bound their loop externally.
- *   - Behavior on tables that contain duplicate keys is undefined:
- *     duplicates may be skipped, repeated, or trap the walk in a
- *     cycle. Callers requiring duplicate-key iteration must use
- *     rhashtable_walk_*() instead.
- *   - rhltable instances are not supported and return
- *     ERR_PTR(-EOPNOTSUPP).
- *   - If prev_key was concurrently deleted and is not present in any
- *     in-flight table, returns ERR_PTR(-ENOENT).
- *
- * Returns entry of the next element, or NULL when iteration is exhausted,
- * or ERR_PTR(-ENOENT) if prev_key is not found, or
- * ERR_PTR(-EOPNOTSUPP) if @ht is an rhltable.
- */
-void *rhashtable_next_key(struct rhashtable *ht, const void *prev_key);
-
 /**
  * rhashtable_lookup - search hash table
  * @ht:		hash table
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index dd6eaa09c55d..907637967c0b 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -730,8 +730,41 @@ static struct rhash_head *__rhashtable_next_in_table(
 
 /**
  * rhashtable_next_key - return next element after a given key
+ * @ht:		hash table
+ * @prev_key:	pointer to previous key, or NULL for the first element
  *
- * See include/linux/rhashtable.h for the full contract.
+ * WARNING: this walk is highly unstable. Unlike rhashtable_walk_*(),
+ * it cannot detect a concurrent resize or rehash, so a full iteration
+ * is NOT guaranteed to terminate under adversarial or sustained
+ * rehashing. Callers MUST tolerate skipped and duplicated elements and
+ * SHOULD bound their loop externally.
+ *
+ * Returns the next element in best-effort iteration order, walking the
+ * @tbl chain (including any future_tbl in flight). Caller must hold RCU.
+ *
+ * Pass @prev_key == NULL to obtain the first element. To iterate, set
+ * @prev_key to the key of the previously returned element on each call,
+ * and stop when NULL is returned.
+ *
+ * Best-effort semantics:
+ *   - Across the tbl->future_tbl chain, an element being migrated may
+ *     transiently appear in both tables and be observed twice.
+ *   - Concurrent inserts may or may not be observed.
+ *   - Termination of a full iteration loop is NOT guaranteed under
+ *     adversarial continuous rehash; callers MUST tolerate skips and
+ *     repeats and SHOULD bound their loop externally.
+ *   - Behavior on tables that contain duplicate keys is undefined:
+ *     duplicates may be skipped, repeated, or trap the walk in a
+ *     cycle. Callers requiring duplicate-key iteration must use
+ *     rhashtable_walk_*() instead.
+ *   - rhltable instances are not supported and return
+ *     ERR_PTR(-EOPNOTSUPP).
+ *   - If prev_key was concurrently deleted and is not present in any
+ *     in-flight table, returns ERR_PTR(-ENOENT).
+ *
+ * Returns entry of the next element, or NULL when iteration is exhausted,
+ * or ERR_PTR(-ENOENT) if prev_key is not found, or
+ * ERR_PTR(-EOPNOTSUPP) if @ht is an rhltable.
  */
 void *rhashtable_next_key(struct rhashtable *ht, const void *prev_key)
 {

---
base-commit: 5a9a7457df6ca17e8a4a4551781eea1f4b02a64e
change-id: 20260606-rhash_fixes_1-d2ebc816ea7e

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

