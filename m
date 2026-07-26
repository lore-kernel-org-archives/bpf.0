Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0AD3C1977;
	Sun, 26 Jul 2026 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785081109; cv=none; b=i5AemTkyG7xhpUiBRrZ/rxTnanPopcobUB4BW5qJv6gzLermWwqr3lhNTA7ro75UA0hkRUb/0pTJDNGuqfDWsuOmAa9tXP21VPxOKTFIaC0X1FbkrLpkIur17f8UC9uwTJksK2bvekBXDhdowZTJBv7TBHb+EX4EAsKlDP94Y1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785081109; c=relaxed/simple;
	bh=F3VGP5qFcG0dh7NSLI40qcc6OwRbZ3xhBeoGMR0s7o4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fr33WMTZAiB9xRnaIkJ7Z9TmATDzHWPf0cgUQOgKvIUwWBLpCXXzfhhgfsswhpMdp9IjK1F2uUyGffGGW8BPHUFXWajK/CQpwJCEEk097y5sayYjhOfSHBkQQ3jnc5EQ/puROr1DMWWJeI/GBBEF5KimE4IwKlXqD7nLb3ATfd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=CuhJ873V; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="CuhJ873V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=ko4S4GtnHOTid7R/klIX1S/SeT+lva0
	zlPajEOiQTLU=; b=CuhJ873VhDQRkNS9cnxm4jPY5aCJ2u4fVWEhx6nlhFwF3rX
	vUPGZoZj4MHUiS+jEkpvyRXwcIf7ysvsR5Fei1L4hliyQ4yb/MIZoJfw7e9p/eOX
	Hnae194ImUqKHJ3zsj5D9bmnBFTKuThbD9UV8fVFBr+Gx7tkn8jWVBLs3cU0=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web1 (Coremail) with SMTP id yAQGZQDXcsL_LGZqS_CgAA--.34846S3;
	Sun, 26 Jul 2026 23:51:27 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Sun, 26 Jul 2026 23:51:17 +0800
Subject: [PATCH bpf-next 1/2] bpf: Cancel RHash special fields on value
 recycle
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260726-f01-23-rhash-cancel-bpf-next-v1-1-6e5e1131d885@mails.tsinghua.edu.cn>
References: <20260726-f01-23-rhash-cancel-bpf-next-v1-0-6e5e1131d885@mails.tsinghua.edu.cn>
In-Reply-To: <20260726-f01-23-rhash-cancel-bpf-next-v1-0-6e5e1131d885@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Mykyta Yatsenko <yatsenko@meta.com>, Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785081088; l=2442;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=F3VGP5qFcG0dh7NSLI40qcc6OwRbZ3xhBeoGMR0s7o4=;
 b=8/1wgwfuJdu+3HoDNsh70O4HFgUF+WF4OpSByigY9iOmvrcmgQi18b+eYvrS/zblfxurYfn5a
 Oo80fcr0jcEA1FLWvGAzO+kbNQTFeIAHZofVxLVf1zTovwcA00TjOtk
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:yAQGZQDXcsL_LGZqS_CgAA--.34846S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1xJr1kWr1DJFyUJr4kXrb_yoW5JF4rpF
	Z5Gry2kw48AFn8ZFWDtFs293yrWr15G34SkFW5Ka4Fvw1fZF92qr15JFWxJFyftF95Can3
	try0qF45Xw4rCrDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBa1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r1Y6r17M2vYz4IE04k24VAvwV
	AKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6x8ErcxFaVAv8VW8Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrw
	ACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wrylc2xSY4AK67AK6ryrMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_GrWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUgF4_UUUUU=
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgYAA2plOCDawgADsL

Commit 6905f8601298 ("bpf: Allow special fields in resizable hashtab") says
that "kptr semantics under in-place updates are identical to array map."
However, after copy_map_value() preserves special fields,
rhtab_map_update_existing() calls bpf_obj_free_fields() and drops retained
kptrs. BPF_EXIST can therefore unexpectedly clear a kptr.

Use bpf_obj_cancel_fields() in the update and deferred deletion paths, as
hash and array maps do. It cancels timer, workqueue, and task-work state
while the allocator destructor releases kptrs at final reclamation.

Fixes: 6905f8601298 ("bpf: Allow special fields in resizable hashtab")
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 kernel/bpf/hashtab.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 9f394e1aa2e8..54ea111daa8b 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2865,14 +2865,14 @@ static int rhtab_map_alloc_check(union bpf_attr *attr)
 	return htab_map_alloc_check(attr);
 }
 
-static void rhtab_check_and_free_fields(struct bpf_rhtab *rhtab,
-					struct rhtab_elem *elem)
+static void rhtab_check_and_cancel_fields(struct bpf_rhtab *rhtab,
+					  struct rhtab_elem *elem)
 {
 	if (IS_ERR_OR_NULL(rhtab->map.record))
 		return;
 
-	bpf_obj_free_fields(rhtab->map.record,
-			    rhtab_elem_value(elem, rhtab->map.key_size));
+	bpf_obj_cancel_fields(&rhtab->map,
+			      rhtab_elem_value(elem, rhtab->map.key_size));
 }
 
 static void rhtab_mem_dtor(void *obj, void *ctx)
@@ -2964,8 +2964,8 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
 		rhtab_read_elem_value(&rhtab->map, copy, elem, flags);
 		check_and_init_map_value(&rhtab->map, copy);
 	}
-	/* Release internal structs: kptr, bpf_timer, task_work, wq */
-	rhtab_check_and_free_fields(rhtab, elem);
+	/* Cancel reusable internal structs: bpf_timer, task_work, wq */
+	rhtab_check_and_cancel_fields(rhtab, elem);
 	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
 	return 0;
 }
@@ -3027,7 +3027,7 @@ static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *el
 	 * kptrs/etc. still sit in the slot. Cancel them after the copy
 	 * to match arraymap's update semantics.
 	 */
-	rhtab_check_and_free_fields(rhtab, elem);
+	rhtab_check_and_cancel_fields(rhtab, elem);
 	return 0;
 }
 

-- 
2.34.1

