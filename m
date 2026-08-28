Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEB3356759;
	Fri, 28 Aug 2026 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787942081; cv=none; b=aq1BVot1Zy79Fl8iMW5qmD0nEL9ZC5Q5OK7lQDWRQe2x/8mUozlXQhQVI7lyCRVYOqCATnif9zizcquqp3N08p/E0wGf/DGo38mDxUwS+78HjZ1lZxdqOGdNpu6kUE9Rrjl86aP+lWWPfTPV0Szf4TiVGGoFpPEQjUSptt5+xFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787942081; c=relaxed/simple;
	bh=BFyYHyaHffDUrbHyjS3NkLPCoXZf0iAo/GIIJxOs17w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gDNPbni91GlPQyGQk4wkHU5N6Q9jr1jqYpfZiWSMfdxCAe1vXYhTyG/YFm2apUBGENN5it8OvuXfDLrSZYcdm39TzblMT7Bd5dC2u21Gr4w67QT1FGG/GkkPAjOTOmSvZ61saaWFG3NfNt89Z3vmvFzo7dg/usxB1Gf/b5DT2JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dDF4pyjy; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dDF4pyjy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=tJ
	4XbzI/0OrXCdmfidLZJcNcXl2lG20eecra6DUo/Iw=; b=dDF4pyjy6iTXNkA/Kz
	vV+WEf9asYoLajzhIOyOVh9hIZSowLMaiDDPyi0Kzn0EBjLDB8sMfthuoSF30Xj0
	2OEVa1lTH0/H6UMv3dwxR+NvulSKXW+2RBF39tq7/yb5a8SuB0hxU0ldv9M40/39
	kddRYLmVKNV1916PC9pyb9RZo=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDHLpN71JFq9llOSg--.64121S2;
	Sat, 29 Aug 2026 02:33:32 +0800 (CST)
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
Subject: [PATCH bpf 1/2] bpf: bound resizable hash map iteration
Date: Sat, 29 Aug 2026 02:33:25 +0800
Message-ID: <20260828183326.3330530-1-sh_def@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHLpN71JFq9llOSg--.64121S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFWDXrWxuF4rXFW3Cw1fCrg_yoW8uF1DpF
	W09r18Xw4xAF1xJ3yxuw4vga45WrW5ury7GF4kG3y5twnxWrnFg3yDtay7KFZ0yr4rur1Y
	vr42934UAw4rC37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UNAwsUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6RxTsmqR1HwuCwAA3i

rhashtable_next_key() provides a best-effort walk that may revisit
entries and is not guaranteed to terminate under sustained rehashing.
Callers performing a full iteration are expected to bound the walk
externally.

bpf_each_rhash_elem() currently loops until rhashtable_next_key()
returns NULL, leaving callback execution without a finite bound. Bound
one walk by map->max_entries while preserving the existing best-effort
semantics.

Use map->max_entries as the iteration budget. Duplicate visits may
consume the budget and cause the walk to stop before all keys are
observed, but RHASH iteration already permits missed elements under
concurrent mutation.

This is reproducible with concurrent updates and deletes triggering
rehash. With max_entries=4096, one walk invoked the callback 5239 times
on an unpatched kernel. With the bound in place, callback invocations did
not exceed 4096 in the same stress test.

Fixes: 818e00848227 ("bpf: Implement iteration ops for resizable hashtab")
Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/bpf/hashtab.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index d40cb5dd446c..3772e63f2f12 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -3198,7 +3198,7 @@ static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
 	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
 	void *prev_key = NULL;
 	struct rhtab_elem *elem;
-	int num_elems = 0;
+	u32 num_elems = 0;
 	u64 ret = 0;
 
 	cant_migrate();
@@ -3212,7 +3212,8 @@ static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
 	 * elements are deleted/inserted, there may be missed or duplicate
 	 * elements visited.
 	 */
-	while ((elem = rhashtable_next_key(&rhtab->ht, prev_key))) {
+	while (num_elems < map->max_entries &&
+	       (elem = rhashtable_next_key(&rhtab->ht, prev_key))) {
 		if (IS_ERR(elem))
 			break;
 		num_elems++;

base-commit: c20313e98b04ce543936431b6122dd639d3a8346
-- 
2.54.0

