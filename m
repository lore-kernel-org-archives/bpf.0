Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A321D47F799;
	Mon, 31 Aug 2026 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184954; cv=none; b=i7X2flEvuzSjjozKphK/dgs6zTu37Fr1IlkketqoxDCPHvfB5kQxC/Cx9y+Dkaiq9y/FT8YPMSJDS9ReHepaPYY6WFeTar7E4otgZdG8GglaqChi5XU411CjMIL2no5QJh3pTE0+m7cVZP0uKbFo+AFGkgHKwjONKLL16cgl4UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184954; c=relaxed/simple;
	bh=5uwaa1NIAWW3T8nHk238CbEi75a/IOxD3dTC/Sy3kkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DbkSaR02YEszEQzHorsMUtkPtCvnNlmRY7ZFbtUIICOdpj3PEbEqfMEQ03Zwlwj3rbJnPGH78vcxAYpJs17/i3y+hZPE7HCaVxvCWzQQnd6GXeM3ROUG6ifguMKi48KVwrMZLGe1PyKY8jhNQJkzXphlFZK5Kk6ksJI7oYV00u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dgM6urY1; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dgM6urY1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Cj
	IBvaKQsYcyr6iivoQos9mfZdnOb+fHdjbkMAcK6uA=; b=dgM6urY1ABGVwihgqz
	D/r+wwb2+sApPtZFU/EoEc+iRyRzOHGy87CKFwDC04iDZOVnmQtZMbSW3MJMvyyf
	kGLOIaD4yYiOYxu9p07YkuSOUpp3RfyDAwojVh5VWF7XaS9oqbntqCEuOR8KdLJn
	RWp2hNZNsQp5Q8dQUfVozNY0Y=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBnAIU8iZVqVfC8Sg--.7724S2;
	Mon, 31 Aug 2026 22:01:33 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	shuah@kernel.org,
	yatsenko@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 1/2] bpf: bound resizable hash map iteration
Date: Mon, 31 Aug 2026 22:01:31 +0800
Message-ID: <20260831140132.117755-1-sh_def@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnAIU8iZVqVfC8Sg--.7724S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFWDXrWxuF4rXFW3Cw1fCrg_yoW5JF4UpF
	W09r1jqw4xAFs7A3yxua1vga4YkrZ8ZFZrGF4kG3yrtwnxGrnFq34vyrW8KF90yrWrur1Y
	vr4I9rn0vw4rC37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UNAwsUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwR9x0GqViT8L7AAA3R

rhashtable_next_key() provides a best-effort walk that may revisit
entries and is not guaranteed to terminate under sustained rehashing.
Callers performing a full iteration are expected to bound the walk
externally.

bpf_each_rhash_elem() currently loops until rhashtable_next_key()
returns NULL, leaving callback execution without a finite bound. Sample
rhashtable's current element count and use it as the iteration budget.
This keeps the bound proportional to current occupancy instead of the
potentially much larger map capacity.

Duplicate visits may consume the budget and cause the walk to stop before
all keys are observed, but RHASH iteration already permits missed
elements under concurrent mutation.

This is reproducible with concurrent updates and deletes triggering
rehash. With max_entries=4096, one walk invoked the callback 5239 times
on an unpatched kernel. With the bound in place, callback invocations did
not exceed 4096 in the same stress test.

Fixes: 818e00848227 ("bpf: Implement iteration ops for resizable hashtab")
Signed-off-by: Hui Su <sh_def@163.com>
---
Changes in v2:
- Bound the walk by the sampled rhashtable element count instead of
  map->max_entries, keeping the budget proportional to occupancy.

Link: https://lore.kernel.org/bpf/20260828183326.3330530-1-sh_def@163.com/
---
 kernel/bpf/hashtab.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index d40cb5dd446c..2cad67c90154 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -3198,7 +3198,8 @@ static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
 	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
 	void *prev_key = NULL;
 	struct rhtab_elem *elem;
-	int num_elems = 0;
+	u32 visit_budget;
+	u32 num_elems = 0;
 	u64 ret = 0;
 
 	cant_migrate();
@@ -3212,7 +3213,9 @@ static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
 	 * elements are deleted/inserted, there may be missed or duplicate
 	 * elements visited.
 	 */
-	while ((elem = rhashtable_next_key(&rhtab->ht, prev_key))) {
+	visit_budget = atomic_read(&rhtab->ht.nelems);
+	while (num_elems < visit_budget &&
+	       (elem = rhashtable_next_key(&rhtab->ht, prev_key))) {
 		if (IS_ERR(elem))
 			break;
 		num_elems++;

base-commit: c20313e98b04ce543936431b6122dd639d3a8346
-- 
2.54.0

