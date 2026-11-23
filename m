Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446964;
	b=XUnvcLD7oxKtLWhckCUYAnHZHxH3Qwm3F7cXmcQSpaGq6ry9iczvsTZ3ha0lAMCZMuq8
	 PVvHkuhvFBmlR9dPqVYkVp/hCHxyVfmLIUGdDKmrryuDuGLIGVbKBNCGcFUUoJA1LOrd9
	 JBp6cQzdfxOyTEosXCu8t6seJZCcLEbfaTVKYKTK2Qypx2NTgxET+NKpRB+m5vWZbML3X
	 jqlPaMwErz34Xqjtj/ju1oZKn2KDheV0KNnPnx/Y4OyXni0H5qdfSIH6xAyW8DXuEbY0P
	 Qv20XR99OfUcOIjurbGPyTO1ISaEWwkhF4ME73ELhOVLfYQxw8bXq3Oqr1bC4M9ZqWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=TtuR7YqeDmhnfJgd+bTQJdPUX0cLcGaSFgJndQm1lTo=;
	b=ON/n7inlama/n8PFosxbLvZqRl2gUhTLle4XZfVJEi3M3YbbVlqQ8oQEbJCpdW5Xw6Id
	 RoYy09ZjGs8bV4FTb/XXybHfe/tEqSrdkKYJw2ugK4up4AiAGNvIb9Uwzx1/9FNVhoN30
	 6BPIZuZAASf8Sf9uNOCVqk79AKgBCBB1DQB5YMZ1kz13d5qiFOXo/ecQeY4rt8MOcOA+u
	 uIlrcOwFWVLt9ihzVSb04/CWUEuYL2bo4wa0LXunQnLFnJMmrlwtOjwF+d2gbd9AydlrY
	 1TZL/nPGpQdetYbm5QBuCtHUccYF1faDSCIhdQNSDJ+iUYqAOtH6ZAsv+W6Q2UZQOKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xny6A5HQ;
	arc=none smtp.remote-ip=209.85.167.176
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8813606A32A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 15:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8813606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xny6A5HQ
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-57148b8ec14so1145036b6e.3
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 07:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795446962; x=1796051762; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TtuR7YqeDmhnfJgd+bTQJdPUX0cLcGaSFgJndQm1lTo=;
        b=xny6A5HQeJ5ZmD0pblsZCK+mdhlM8vo0BXZWNmdr+f08E3Wu0BkcYgY+WVGBnYyxwO
         sLB+c3sKAo48zjjDpnQ464a4X4AhgYBChydt//7GHBYhJf+4F3e0ShpnDDf3rkBTJBmK
         oJ+T1r8e90gPPtdq0mkx3X/OFwDZR2IF1D7KSyQHnkxLKzzDoZ7llLOPiTb7LdI1wNuY
         Yc1BJMwK37OTQT8Qh2dVNHGliKGFtmLtK1lQ/Y07FmtN+toHRIEmtWB1h472I9TsPgsD
         YoQtCpiscFuv9L/AsjCqFAJelWGE1PupuG4lwxPvqSPlT/5eYVzAB/tZN2xx0uw1kKlM
         H18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446962; x=1796051762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TtuR7YqeDmhnfJgd+bTQJdPUX0cLcGaSFgJndQm1lTo=;
        b=qluztgqesd6chXVnzAODudNq6xne4NXzttcFa1KW6V2SODXykTdkiD+7+kZhyOKM4P
         r/YiPfeS6bibqDClywG956ZyGZvmhV1a3POaAVzsgjtSaQlx0RYbl1cV68BXhcSkHgpS
         AABWQtdSi7jRhS3HghktvFXUq8eTo3rjUFsQ0X8uHVMLHrhxDDVuwwFJDUMxZRfB6v3M
         6AHKcWd4cnyKVgjAJGLkkc/EImNz3xb3VUbfEAtlWp+fCggHsWqg5e1aAjj6JcrQ/d/g
         bGrIoGQHZ2GwkjFSY4B+H1Wiv+iqtLTTcJved5m6OoAQ3qhrUO4ACs90tmDwwe38ZH/X
         79/A==
X-Gm-Message-State: APuU4Z9KqYkmLnH+CMx/r+PYk5u+tir1jtXMuBrMXaO0XMUMemuUv/CB
	jOFS6S04OWBGag3hfrBUNCbC5/l9fGX308czuOfUqoFWRd/L2UEIQftU
X-Gm-Gg: AZFdTZcOgtvGYXBvIhnZRJOJO//HCTHNHTzhgle8vjGmQ+fTFaDIsXJWe/LVHpCzuoD
	saDJmrz02hN/i/ITDhj26iWbxXdbTST/cvoCvzOr5YADXQsoOsB2f4YSQdHojepdW0HgxAnOvsh
	aAkkpr4uVcY9cYWnGpXwi+S47+GlxOyr1UG/7cJV6qfIdyH8mm3LgIT0xSldeyCxDGLh3qpv5C7
	FZcTstlZb3O/BrmjVTe25wEwSWqy+PzIu/qd4SCepvyz3mAkuffoHRECBNrTnyKIu+Hkf3/bx7g
	rKpBcGFn7WeG7KcgonyFJApfbbvtns65bqAJULopDc1XMOtft7taEc9kGnEy39eB48XhSCH44+q
	M+cRinCfTtaGAVJNwuQ14q+1UQgBrmk/5iqRYtw82Vbb7TRy3RdMlI3FDZ371kBKBLRO6W8Ckcs
	aPViDX3gQW8RnDS7GqkqgJUx4KWFwfsipnRuEZrut2ppuEiuqwMH0v0ewaavHj9HoGnDWXpb7jy
	O2tPcNG+NODi0UmcoV3AUBo6MLa7M6bemb/p6twVB80vk3vbJ97atRx83HJHxlDfU22mZ9GXmiP
	wUDjYQ==
X-Received: by 2002:a05:6808:244e:b0:4f5:aa1c:d934 with SMTP id 5614622812f47-57a0a71998fmr13627947b6e.38.1795446962458;
        Mon, 23 Nov 2026 07:16:02 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:42::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bcf0794755sm10396602fac.10.2026.11.23.07.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:16:02 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 23 Nov 2026 07:15:42 -0800
Subject: [PATCH bpf-next v2 02/13] bpf: Add obj_size to bpf_local_storage
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
Message-Id: <20261123-sls_f1-v2-2-76474de9b052@meta.com>
References: <20261123-sls_f1-v2-0-76474de9b052@meta.com>
In-Reply-To: <20261123-sls_f1-v2-0-76474de9b052@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795446955; l=2852;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=XGgYZBEDxTJTTMTfnkSuB9FlBa4shVtukrQ84OtNC8g=;
 b=s9A2anRldb15f/nXPmVA8uCnHNVZ+kJ5ol70JOqyK6mC5fUnLUkmIStQDVmRzZypchqVY6X6A
 TR39ijGBRfVCPvlnAflx1r22ffqqklsBC2P4T1smAalze9NV1o/P0A5
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

