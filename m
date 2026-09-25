Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC56445ACF
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 06:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790318817; cv=none; b=iHFu/aQC2mOlpekmlybhvxGVMGCakbmPouM7k9jFFdHdVRgoAGumnE9AFxORQVkdBmXawza50ahAdNpdv09OXnagq9DcR0TIkgBj5DloiksuNCW5fPcvNxZ2o0zmVFcDtOigHKF63ail0Uj9ivFxBBs+hqZ+J6UPvN7QYr4D2qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790318817; c=relaxed/simple;
	bh=ZizJXe4DD9Y+GIELdLKpd3s6POPud7JDUeLz4zjMxx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I/DJi06D2j0H8E3YoVXjmejcZMcawf/FRTg04qiPJOZmC6D0n3YNsm9FO/xi0570RKdM11OYftAFP5DkyLu9sQ+LCtHAdYLBNle05JdBlee7VMRF4IHV/qFbEFD4Ssm9gtIk1B8q2cML6GuCW06K0cp2Ka9vFfuhhPw5IU7jZFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eV6wtjmE; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV6wtjmE"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49ccea58fe3so1821335e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 23:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790318814; x=1790923614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lq5AAJhxDbdupDNmvxVwXvzWlUMDJbyAQMmHZ5uPj10=;
        b=eV6wtjmE4XeEqAHJFygZxn0PlOay9IixYS0wS+lHia6KKNerelCT+t0EOM3mpxbbP9
         8ZRY055pMUML1l6heQVJVl7IKfTsFYwdZrJmQ/JyWwK8OFopcNNhtmmqfLVirBy/4UTU
         deMUnrKJigh3gumFroyN1u7xoHntX7IthXcQVltLN58Iy6mT2ftW0CDDvRG1r1ETNO1E
         yNQQoxhP/0pOob7HtqIHgKaGki6ISvDpP2+YC8+f/5lbki3wdiSiLVyfKDWF8dwsYN7K
         HDXGtvW7lTyFgCDvQ5+Z3FoKotWFPABxOLQvqN6k7yOMTL5lhxZ9mEIw2VNAU6XWiwBB
         47VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790318814; x=1790923614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lq5AAJhxDbdupDNmvxVwXvzWlUMDJbyAQMmHZ5uPj10=;
        b=NSiyeVavttpYCOsQbEHA4ThuV644SSnZc/b7n/pXNogwP2vAWuEmKsf3SiUCQsvD/B
         r3W9soIwGixuIoUQkJYQyEHl2dCoz4WtSpXDg2Xm/L2VUeYoCN4c6W4yrbq2hq271CFh
         JDsiLPHVmat2Rdzi58PCtP0rTE2LX8eCV2WUvLBfYRt2/Ak7wjp0Jog8RU5TeKj/m/pZ
         +NwDAMzgVFuApmDTIfWeT1JihNsmEXfGHqvQxH5uaV502TE/y68DRArD2txHZh+UOvTK
         YFS20jYbh30GXLLeJwGnV16fJeBlYHjMmmAlb4elAaK6StSJJFXEUoCXOtUfhs9IPKlk
         rVdw==
X-Gm-Message-State: AFuF++kpzb2KV0GqN5Yl+n4BzHWl17WSXPaw7JAGYsltylXTZ6Q8dK9Z
	4X4Mresa5u+kLpLdQnilMgVdhXOoqte8/14+iZgf9WctwNstPb6gTlISFKNpyIFizfM=
X-Gm-Gg: AYBFou3kjvUKUa6nPjDUjxJ7qwQIIZPpp0bpcUGHByNf78YoBxn4Md+NDqrNmCeOpCs
	y86DOsStpTSTgohvlGFOJBSNbAV32DSgvS39UAt7noF/WLRVtfcciOC1q6wWnlAJd48GrKQSPqR
	d+AaXD6y2mhQGmzE1AWtZhKM6d8ru5ypK06LfcF6XtjLxmDZXNYdNphfcmUtJlKKIg4KSw02ec1
	N1q47fM2ZvR4ACVHH0h5LNpxOk0fLWbVrp2mUByZQ6kH5FFd3DYPM/HaEZq23gEech4BOHAATGD
	5h58pQXpvTh8aRodVUAQJXHkmyAPi4XTIQ7hIInSyGc/E5kt0KAvcfLci2ZqF8IG9fBcofnd7LN
	9Ki/BsmtMKriJKoGsl3P1PXNsfbHRe+J62dv/AOFAtk5zVF4gF3i/O2LcF+MjFKvFV2XSdi/Zsy
	1eTzlu6hBeFewX+LcQ9zyF5JNnoYw0EaQZI2coNzZggVoJUEHXqNCCQ9D2/jIW1AHW9kHquL5WX
	09HKTd8ZpMJCSCT2G5cGF9UWMTFwaFMcxA9sEHTZ7Mh2/0ukHAHXo38irlOOX7sqXLeIRax5wZn
	T9AicTacpTC22z7JAXtDjNY0SqDC9KVOV+PGsw==
X-Received: by 2002:a05:600c:5394:b0:49c:fc6c:be00 with SMTP id 5b1f17b1804b1-49ff06ed6e7mr20100405e9.23.1790318813956;
        Thu, 24 Sep 2026 23:46:53 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff044422asm34448725e9.2.2026.09.24.23.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 23:46:53 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Yuan Chen <chenyuan@kylinos.cn>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf] bpf: Hold map BTF for the memory allocator destructor record
Date: Fri, 25 Sep 2026 08:46:51 +0200
Message-ID: <20260925064652.2261885-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4457; i=memxor@gmail.com; h=from:subject; bh=ZizJXe4DD9Y+GIELdLKpd3s6POPud7JDUeLz4zjMxx4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWubxIWmycz3tvp9W1DiYp8lWZLm8K5/xrtfb6Nk+l1eP w2skPfsKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQ2X2H4zbr8Am8M++mD38zO ntzMfv7/v7CTbj6iJy5+Y9+rmTrX6RYjw8e+DRN+1qu+UNgpcSdAwfrY3bNlm2dLBe9iuhsRuUT /EicA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

bpf_ma_set_dtor() duplicates map->record so that the bpf_mem_alloc
destructor can release the special fields of hash and rhash map elements
once the allocator frees them for good. btf_record_dup() only acquires
references on kernel and module BTF. Fields whose types live in the map
BTF keep pointing into it: a kptr to a local type refers to map->btf,
and a list_head or rb_root field carries a value_rec owned by the struct
meta table of map->btf.

That borrowed state can outlive the map. When RCU callbacks are still in
flight, bpf_mem_alloc_destroy() copies the allocator and defers the final
drain, together with the destructor context, to a workqueue.
bpf_map_free() then frees map->record and drops the map's BTF reference
as soon as map_free() returns. Once the program that loaded the BTF is
gone as well, the BTF is freed while the worker still uses the
duplicate. The worker dereferences it through btf_is_kernel() and
btf_find_struct_meta() in bpf_obj_free_fields() when destroying elements
that were freed under RCU, and through btf_is_kernel() in
btf_record_free() when releasing the context itself:

  BUG: KASAN: slab-use-after-free in btf_is_kernel+0x19/0x30
  Read of size 1 at addr ffff88811505dce8 by task kworker/u16:2/50
  Workqueue: events_unbound free_mem_alloc_deferred
  Call Trace:
   btf_is_kernel+0x19/0x30
   btf_record_free+0xc7/0xf0
   htab_dtor_ctx_free+0x1a/0x30
   free_mem_alloc_no_barrier+0x39/0x230
   free_mem_alloc_deferred+0x2a/0x40
   process_scheduled_works+0x5ce/0x9d0
   worker_thread+0x42a/0x5e0
   kthread+0x1f5/0x230
   ret_from_fork+0x1dd/0x390
   ret_from_fork_asm+0x1a/0x30

  Allocated by task 358:
   __kmalloc_cache_noprof+0x287/0x510
   btf_new_fd+0xf7/0x3d0
   __sys_bpf+0x487/0x840

  Freed by task 0:
   kfree+0x186/0x560
   rcu_core+0x6f6/0xd40

Freeing a map that still holds more elements than the allocator's high
watermark is enough to get there, because the bulk free during teardown
queues the RCU callback that makes bpf_mem_alloc_destroy() defer.
Non-preallocated hash maps and resizable hash maps both register the
destructor and are affected alike.

Keep one reference on the map BTF in the destructor context. Every
non-kernel pointer in the duplicated record is either map->btf or memory
owned by it, so a single reference covers kptrs, list heads, and rb
roots, and mirrors what bpf_map_meta_alloc() does for the duplicated
record of an inner map. Release it only after the duplicated record has
been freed: the worker is preemptible and not in an RCU read-side
critical section, so dropping the last reference first would let the
BTF be freed while btf_record_free() still reads its fields.

Fixes: 1df97a7453ee ("bpf: Register dtor for freeing special fields")
Reported-by: Yuan Chen <chenyuan@kylinos.cn>
Link: https://lore.kernel.org/bpf/20260901062845.1379760-3-chenyuan_fl@163.com
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/hashtab.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index f9464e566f10..548eb1cc7c45 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -128,6 +128,7 @@ struct htab_elem {
 
 struct htab_btf_record {
 	struct btf_record *record;
+	struct btf *btf;
 	u32 key_size;
 };
 
@@ -497,8 +498,13 @@ static void htab_dtor_ctx_free(void *ctx)
 {
 	struct htab_btf_record *hrec = ctx;
 
+	/*
+	 * The duplicated record still points into the map BTF, so free it
+	 * before dropping the reference that keeps that BTF alive.
+	 */
 	btf_record_free(hrec->record);
-	kfree(ctx);
+	btf_put(hrec->btf);
+	kfree(hrec);
 }
 
 static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *ma,
@@ -521,6 +527,15 @@ static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *ma,
 		kfree(hrec);
 		return err;
 	}
+	/*
+	 * btf_record_dup() only acquires kernel and module BTF. Fields whose
+	 * types live in the map BTF keep pointing into it: kptrs to local
+	 * types refer to map->btf, and graph roots carry a value record owned
+	 * by its struct meta table. The context can outlive the map when the
+	 * allocator defers its teardown, so hold a reference of our own.
+	 */
+	hrec->btf = map->btf;
+	btf_get(hrec->btf);
 	bpf_mem_alloc_set_dtor(ma, dtor, htab_dtor_ctx_free, hrec);
 	return 0;
 }
-- 
2.53.0

