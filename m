Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18893A63EF
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518545; cv=none; b=P/8z8IvKS/lzoHLXBgqhhcbMYTIc263MLPJkUV8wMyeMmkOOH7czkvfQFMbISZG7WPWjHtsraDbdRroSbcAqeydpv3hFWD1zHgPptgRrtvVYDOEoXV90ZNxrH4q1+Xy70oI0F/jpeV4F9X38JQkB2gUVwmwExrHM5VLa3vsa+CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518545; c=relaxed/simple;
	bh=kFOGxoJ6Z+wSzP5AS1DAmiGuTCFTzh3YmfYrVzHPi2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3RZAeEtwTSEqNo3P7VmIDenLNr9j0BkR3P4NXbuqpNM7IPUWkjAhWAhcX57eVx3zMPXzDGAJ/bWSkuh6uAhtEOFCxgpxBb/LsONudqz8JSM+mJJ2jDzFOVI4aLxZZE8KP91txLbBC739cBHg/4FXnwZFk01BNkxGu0HnItS8d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=op8eLsVz; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="op8eLsVz"
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4956bc73c0eso2991925e9.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 03:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788518540; x=1789123340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2b3yfK5vCKIp1RPwGWMOlCepA9hQBeSGyoOOs5PJZUM=;
        b=op8eLsVzxLn66vi7ju56kk5XhApZ1AskQVLPzjMGlEETPT15JrUcdTo+VI6TUyJ6ZB
         093MqiyImSB4WcjZYsZhJmVBXo1VqvWPkULJoDbXB31tBt7m6D+GFod1w+Y8Taa2LCbl
         k5ofbb5vlluaZKdcqjwIgYT/Kwx/fzPj07PMBgxxo1wjh+kj2Im/If3dli+PGKjh2oUO
         6Z1TX3yq7QojoncoFS0CIdmuXRcP8KdEYMpNG301lXMcUKiO4QNG1KelFc66/fZpOXk5
         YL533HZqEDB2ZUyYy8pQK4/oJ+pjmnrT8AgcHiENyAUEwjOvkKJzTx+IC8uxPdK43oOP
         W5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788518540; x=1789123340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2b3yfK5vCKIp1RPwGWMOlCepA9hQBeSGyoOOs5PJZUM=;
        b=U3X5UChh25sqVwA+u1wapwYUAgPaBayl23b04qQ6oq6P943QzJHKuitpvRJNuVkA19
         nhxokAOvG0gocm+osHA3ZfOl80RBIcAnIR/LoggcHeoOvIpzw9bbW6mQdb5bM5U4EVYi
         4nZSKxwHQyQM6ISatzHJsgH5sRoY4HPVdqWjDvivlo4iSqa8BBoSkSqBO8rBhTMPxq+P
         DsUWDkChf8eX1OTepM1jK2zAJzlcOumOXgezPwZvwliQKzRG7axfHfjBKJ6T3yNcpfKW
         10iqfVvhud9jxrqtsPeKq9HEGoQaBRM1B+1ZmGxqgpPXMyvcjW25W3ur+lGd3Zwd/f3n
         hwBg==
X-Gm-Message-State: AFuF++n5K1fWJ8AbAEISToMbTHaYs3mKmJRrhplwDkr3Q6HcsWiT3qvR
	bZgfyiOfQHllsQiW59ZC7MYavmbY9tAx6q0EOYa9G606qCKClz7OFjPMp6ItiQ/b
X-Gm-Gg: AYBFou1tYrQFPFYMYTAzbTCB5AeCYg4basoou+XtoPCynvV6e56dJpxDn+SP7cvBow0
	6KqE9OaryDTqfi74VcFG8Jm5yGUJCayXIEb+huwvpkIAWy5W1cycdLFM9MMotApsUB6c3Q3fiAv
	zbM61jfg0crJAu0YI6CO6pXUf+hGGPZAiouK5kclzZE9xvUwEyLzxW5auT3hLrYPRwr/g802bMz
	N9uHQjE33M+zYnefk0enQtUWE7JbZA9JNdEkCBiunRaHz/IpMpTSmauHQ7LhUINcYSSxD4F9YqG
	+phTYxE+X1WFoT6XKcbsD3cNAn5e/QKQpr4UY83iKX32rgssf+TRfscJhI9ci/NJ/eng8DCvr0t
	j7iQlpfrvQZYgYFaP2zAC+MmoFLnglssmdUNXcG1nIcVqrNDIf2pUemFvFwymNNoWZ9z33xrSR7
	QQrA3tgxgsAXN1en1FSC3ogr+T5pWf8jHywS1o52276NJmAKr/jknUi3lyGnlOAzDAlvmYX1NOx
	4GzFWxv4b10WNLVTVadQ/Lsvdo0Tl25GCQ4bQHa3B0bNgTB05a9mJGYACMKfAck/yzG5kAPKjqB
	uTlJphZdnUtqhhSYeaTowP83U2g=
X-Received: by 2002:a05:600c:3f0a:b0:49c:e27c:6b10 with SMTP id 5b1f17b1804b1-49cf81e4a10mr54234165e9.3.1788518539609;
        Fri, 04 Sep 2026 03:42:19 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf5135353sm74923785e9.2.2026.09.04.03.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:42:19 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 3/8] bpf: Cancel special fields when recycling rhtab elements
Date: Fri,  4 Sep 2026 12:41:54 +0200
Message-ID: <20260904104203.345917-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904104203.345917-1-memxor@gmail.com>
References: <20260904104203.345917-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3026; i=memxor@gmail.com; h=from:subject; bh=A1Rg/cHN5F+NeOPqbp5Cayfd5IAut4CKQ1DhikmVkMU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvW/LMNzH/V/P5tWqnvX6ZrKp/8jG1hmYi0WGR+m92Ni e6LGRs6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMBHmV4wME73n2d7R3FP82tZb UVS+tzngrHfzie0z+v3CuHjmvzt3ipFhvkMP17RFZwTMX/A9uintelI1ocVt15Ldi+VDzyYumxT GBwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

rhtab_map_update_existing() and rhtab_delete_elem() call
bpf_obj_free_fields() when replacing or deleting a value. These map
operations can run from BPF programs in NMI context, where releasing a
referenced kptr or another complex field is not generally safe.

Array and hash maps avoid that problem by cancelling only the asynchronous
fields which can be stopped safely in the caller context. Other ownership
state remains attached to the allocation until its memory allocator
destructor performs the final cleanup.

Use bpf_obj_cancel_fields() for the corresponding rhtab paths as well. This
cancels timers, workqueues, and task work while allowing rhtab_mem_dtor() to
release referenced kptrs when the allocation is eventually destroyed.

Fixes: 6905f8601298 ("bpf: Allow special fields in resizable hashtab")
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
[ kkd: Rebased, used direct helper calls, and rewrote the commit log ]
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/hashtab.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 527cc5716ee8..cc60e99ffbe9 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2868,16 +2868,6 @@ static int rhtab_map_alloc_check(union bpf_attr *attr)
 	return htab_map_alloc_check(attr);
 }
 
-static void rhtab_check_and_free_fields(struct bpf_rhtab *rhtab,
-					struct rhtab_elem *elem)
-{
-	if (IS_ERR_OR_NULL(rhtab->map.record))
-		return;
-
-	bpf_obj_free_fields(rhtab->map.record,
-			    rhtab_elem_value(elem, rhtab->map.key_size));
-}
-
 static void rhtab_mem_dtor(void *obj, void *ctx)
 {
 	struct htab_btf_record *hrec = ctx;
@@ -2967,8 +2957,8 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
 		rhtab_read_elem_value(&rhtab->map, copy, elem, flags);
 		check_and_init_map_value(&rhtab->map, copy);
 	}
-	/* Release internal structs: kptr, bpf_timer, task_work, wq */
-	rhtab_check_and_free_fields(rhtab, elem);
+	bpf_obj_cancel_fields(&rhtab->map,
+			      rhtab_elem_value(elem, rhtab->map.key_size));
 	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
 	return 0;
 }
@@ -3009,7 +2999,6 @@ static int rhtab_map_lookup_and_delete_elem(struct bpf_map *map, void *key, void
 static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *elem, void *value,
 				      u64 map_flags)
 {
-	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
 	void *old_val = rhtab_elem_value(elem, map->key_size);
 
 	if (map_flags & BPF_NOEXIST)
@@ -3029,7 +3018,7 @@ static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *el
 	 * kptrs/etc. still sit in the slot. Cancel them after the copy
 	 * to match arraymap's update semantics.
 	 */
-	rhtab_check_and_free_fields(rhtab, elem);
+	bpf_obj_cancel_fields(map, old_val);
 	return 0;
 }
 
-- 
2.53.0

