Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611325;
	b=HMKs8sj82mRvKI7m2IbbO3n6kyke9af6Uaf6g1iFc9DLUo/ZE9AVFwYgdGeSCYELX0f+
	 tud0oPZNA0fjl9WfhIugYg5m28BZ6PoU0f1qul67kerVg7nYnwLTwKp0qa++xMHPR6EDG
	 wJHegZoD5IuK2vDof7f6AGi1f6lGrdtexbMFKPtnzojVc5PTQtmWS7qUamoIXRMpoGK/U
	 OoQbJGKyXxlr7hmE1FtIVQS67+jZTiJYM6L3n4yWvSUrwmnPdt4qGtVXqZuk2lfT5w+Gc
	 o8xjGj/V6aaUPOCmrgZh4+SjbvdvRo2+3GaCVpF65IfAo3Bl37H+c0CIkBRVwX72p2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=TtuR7YqeDmhnfJgd+bTQJdPUX0cLcGaSFgJndQm1lTo=;
	b=KYh652U1eRtsPs12DIfpQwp1nuo9ABZ9tGehsteRyzBcf/oeCk2JXxHctyMaa3Qs3nMK
	 gaOnYX41+mGIgqWRliHLU1CqpFnr3JY+V0jBFy9YRUmrwJPcVjaSk6FZp7f/gVeeXGBr9
	 TbyngFWM93JxH3FOjICnerW4RLQnJNS0voWJA1Wx/nPDHmr/rdXoivh2Pafm6tf7S5Odm
	 Gqz6z5qlr31aXt/Kdyt3DTqxbIUKpdUVru2lNXN7h07D8pMqf6yuGvduZh8AARWOCs8Df
	 qcDaSEA4dZCCWhfMoDzG7rBWg7YMsJm6GrTT5vLRjJOCvQrfw9W9qNf6eXAvqWRrB7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LM3dPZ2O;
	arc=none smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BC7606A323
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 23:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83BC7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LM3dPZ2O
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b309147589so14731857b3.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 15:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794611324; x=1795216124; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TtuR7YqeDmhnfJgd+bTQJdPUX0cLcGaSFgJndQm1lTo=;
        b=LM3dPZ2O4h2UqXu/0vtesBpka3nxA+13/I4+CfhwJN5TWUZm/qs956Ai2aON67o9k+
         cg9fb54WMkUCRfmtYOzmikBDOcWpvG8SI/9HcrrnbydLBipzL8zOvAQjFDP9QJGO5zbk
         KQn02SOgOMjfZ1EwiKIkd1VyjpIv76ax1ng5yW9ZJssOinf0cthfo2g+iAGwRgrBu5cF
         MvU822/RbF9smUM73Gttuz0sLFwwCYc4OuRClrvSJ6i/DofXmDgMNYLyLeFFVBvIwTGn
         yZJ0O7ES4MjN7VxvjUepwdfIna8Fs/KWl3TZr7MwVaPSiYkbRc4Yp619Hq9gnqm0lDoV
         9ZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794611324; x=1795216124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TtuR7YqeDmhnfJgd+bTQJdPUX0cLcGaSFgJndQm1lTo=;
        b=oXhs8QuSmPBKk+FlnLzrVspzhD6HHs346xV8u7HJHQlzTUlQPLEalzTAUHzvjxMR9w
         kfS1QxuD08gsh8oHuPOoUX0JP+2b4KWJooaDDrPQBgWbTz2hSEGqf+QqDJ2Wl5cUGXjy
         gAy+QJBPlHejAEOIjU9KIB8GVWbwLFsho5rleAVEe3ARHO21bLDgQlEvmf8E0JkKRPFW
         L3W47OwzjJnJLQ4JiNag9UfMB5uE0P5vN5rp6b+fh+L7P5K/I+wsdZEFoBjtrqE9po/a
         T0VJhKfXtD28/nMhJN2EwYUcUxbxMFp1y/nttEiHDzIpwjO9Wlp17lbj3yD4Ch5ce0Fi
         mVUg==
X-Gm-Message-State: APuU4Z9ecgGsWlvO6d/OOai3u9hqoL8bmQMTy2FZ9R+Z4w1AseYdOP1g
	yZlt+R5DVpsWrRv6DVgI0syCsYCJ7WCwKFhGJTszJNwT552YPIloQU1y
X-Gm-Gg: AYBFou0aZ87H6UF6PSiV4zwSjVKwRFOYvtXXImBdm7GhnCVVJkcmKZAkIaAxIlgnRgr
	5DBcsXDZGbQUPJfUEyxsvkvJ+/HEwk2buvhQW7dgTakno/N03V7L/Gc4yvefBzqGrNJGZhnAYhL
	i81l3uUer4+nXXu8qmMEya/lCRn2hpZnNggHFO7+s3/sEqDJ7BydOJZPVXZF8ysx1GUtb3fOX4W
	He8WOIt3JZ82c6/a12OZAba+FetrSpI0mseGKv+1ZzZmzUHqlSpWegF2Zg/vh3EvS41qSCCYo2d
	kH+BHxrbJ+YMns8l5WX0/ceaZJh6n83QM8DY+bHtSOSzmLtmSejkmMyWa94w/sny+Cy/xE21UkL
	+XMYKj8K0lt+CQ8gr8/csNFe+wUBp8+mcBsVUW4JeYRB1UG7HVcneYjKQ0oKz+8Na4UUs7v1cmE
	yPs/0iVVxyOl/TeIj4ukAqIMk+mgrPdxxgWDNPfDxESRYOFvY8AjHCIiVsEc5FspchguMOZeRPE
	0OubT3NgISeR1fAJzpMs5JG4IRB644GUmScpUZtv9mTnq5T3+VZYK/6q5MOex5eBLxUab9YRIZi
	28Ffg43nneNreJAE
X-Received: by 2002:a05:690c:102:b0:8b4:bc98:aa51 with SMTP id 00721157ae682-8b4bc98ae52mr3665577b3.45.1794611324367;
        Fri, 13 Nov 2026 15:08:44 -0800 (PST)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa8ee47asm32225407b3.8.2026.11.13.15.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:08:44 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 13 Nov 2026 15:08:25 -0800
Subject: [PATCH RFC bpf-next 02/13] bpf: Add obj_size to bpf_local_storage
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-sls_f1-v1-2-1b9492bd3f97@meta.com>
References: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
In-Reply-To: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794611317; l=2852;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=XGgYZBEDxTJTTMTfnkSuB9FlBa4shVtukrQ84OtNC8g=;
 b=kC5SfuJb16N9ldDgSj+8rtIudnFEjAUN1xsWEhCnxUGXhHriU71577OTqHW4XZAvAVbvZ043P
 ENqY/fDtLhkA4H58tnRIFMCifhTgQyVQC3DF3A4XF5X2axdl4iDGm96
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

A later patch makes storage objects that are bigger than the struct.
Keep the size in the object, and charge and uncharge that size.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf_local_storage.h |  1 +
 kernel/bpf/bpf_local_storage.c    | 14 ++++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 6c643ac51079..d336fc051054 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -100,6 +100,7 @@ struct bpf_local_storage {
 				 */
 	struct rcu_head rcu;
 	rqspinlock_t lock;	/* Protect adding/removing from the "list" */
+	u32 obj_size;		/* Size of this object. It does not change. */
 	u64 mem_charge;		/* Copy of mem charged to owner. Protected by "lock" */
 	refcount_t owner_refcnt;/* Used to pin owner when map_free is uncharging */
 };
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 3abfe7034df8..6f884c9fdcea 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -199,7 +199,7 @@ static void bpf_selem_unlink_storage_nolock_misc(struct bpf_local_storage_elem *
 	if (pin_owner && !refcount_inc_not_zero(&local_storage->owner_refcnt))
 		return;
 
-	uncharge += free_local_storage ? sizeof(*local_storage) : 0;
+	uncharge += free_local_storage ? local_storage->obj_size : 0;
 	mem_uncharge(smap, local_storage->owner, uncharge);
 	local_storage->mem_charge -= uncharge;
 
@@ -517,15 +517,16 @@ int bpf_local_storage_alloc(void *owner,
 	struct bpf_local_storage *prev_storage, *storage;
 	struct bpf_local_storage **owner_storage_ptr;
 	struct bpf_local_storage_map_bucket *b;
+	u32 size = sizeof(*storage);
 	unsigned long flags;
 	int err;
 
-	err = mem_charge(smap, owner, sizeof(*storage));
+	err = mem_charge(smap, owner, size);
 	if (err)
 		return err;
 
-	storage = bpf_map_kmalloc_nolock(&smap->map, sizeof(*storage),
-					 __GFP_ZERO, NUMA_NO_NODE);
+	storage = bpf_map_kmalloc_nolock(&smap->map, size, __GFP_ZERO,
+					 NUMA_NO_NODE);
 	if (!storage) {
 		err = -ENOMEM;
 		goto uncharge;
@@ -534,7 +535,8 @@ int bpf_local_storage_alloc(void *owner,
 	INIT_HLIST_HEAD(&storage->list);
 	raw_res_spin_lock_init(&storage->lock);
 	storage->owner = owner;
-	storage->mem_charge = sizeof(*storage);
+	storage->obj_size = size;
+	storage->mem_charge = size;
 	refcount_set(&storage->owner_refcnt, 1);
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
@@ -576,7 +578,7 @@ int bpf_local_storage_alloc(void *owner,
 uncharge:
 	/* storage was never published: no reader can see it */
 	kfree_nolock(storage);
-	mem_uncharge(smap, owner, sizeof(*storage));
+	mem_uncharge(smap, owner, size);
 	return err;
 }
 

-- 
2.53.1-Meta

