Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446962;
	b=sVcup+YMZvl2q30JHgE+xYSqSC9aV5rWtvRgapC6w2lW0qIiJmqdihORqOhMGoak9dwa
	 YyAYoo+CC6nCWiWCR0EDfQWZpRV07ddGsevzhWe0VZ4UZRaDI3gISYDUSgpD1X6EmuZv/
	 Uz68D9bc+w8SR7JieWec8dn+9ThhBnuYFAFRQrE/o7XIZzSJFzymjEJ9dAA+Mm5dOsx3S
	 /nu6/cas9kJrDdQbMnD+7EycrF4UgsPSTHC8aiIY++ntkVsD3FZbRvvpkz/NPK21xJ5CB
	 SpHOe85IGZQw104wY/7QDyja0eX/alKvjognrtuYwS6R/cpY+779Y9E5AeXO1dNnWww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446962;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=J24RLR53zlPX5f5tzZyOuR6MXK+JSdJ7SqSssMORHsc=;
	b=Qb7QLIEnJwFBn2wm1uYKv4yw7cqJzmNxo8h50A3ULItYwqU4kd04yXC+dsqvfhS2txcx
	 +X7FcomNS2Ps907fRKWBirEqaHgpLQ4P1EUjxYqHlSEG0Ih0nk/YOP+WZ8Kd3nDASnUU9
	 J5KPhNI1N7DY2vxwysCUapi1goXTFgO5pCPQsgG5VyzpNzvkYlUR0TqD/pmyjtu836AIh
	 jmDdQpUgIL5I9IcRysgMiYjHjztAXbGJmqK4MAMcJaGKjj+k9DS/BqIpo51RJzeJnTwbM
	 JD59R7JarpJUSinBbSu4DU5VND26Y7S7IEvUlyaszqegHHkXZHNzkaf1WqVZ53+wHow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YEr5k8lU;
	arc=none smtp.remote-ip=209.85.160.52
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C6A606A31A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 15:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91C6A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YEr5k8lU
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-483d290f398so1942455fac.2
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 07:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795446960; x=1796051760; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J24RLR53zlPX5f5tzZyOuR6MXK+JSdJ7SqSssMORHsc=;
        b=YEr5k8lU5DFVhc17sWpU5V7NUTjJu6ww/YZOdWOq0cPvcAe5fYwfLI1++9siGlfM+B
         ndeyAHKObHAgChmbQUawXH/yG5XiFcaI/5YruF2xMy5EKMOncftv0mG9wWZsc2GVlCos
         mcQKT7zThgFvyVP6oQGj6sAS9Rx6j00DUvsj0vbrT+umunoml9405PpM5h2z7P/8UOo4
         Py1c9MnWWsDjT1HRvKlckDZUwS6FWDPszDN+BkupDuZImNpaHSC0dA4bMRa3b4vvkHh1
         zfwCdNVfdtCYUw09W6RmfSfMvJk4DZV3uxZ1EPszu+sGXkCKWG9fLrIdujKssvN20tuF
         qfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446960; x=1796051760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J24RLR53zlPX5f5tzZyOuR6MXK+JSdJ7SqSssMORHsc=;
        b=oKQAEex1fOoCYGt4GRIwDPwdL4ukFUmNR6RZ58gFEhmHKjHCRkHWV53iARZ6y+MIWb
         ZQxQPWN3SoxSEizN7WQi+qk6XGDsQiDOoTVY2MfKJeiEhBT97cCK5KhvcTNgBgh+Efwf
         ifhljherdlz4U41B1ctvzj+qTSKeBmHv9x49qyQSZYvXOJ2/X4WdNgXCjUhqCJG9P1kO
         BAoA8hAIHLET9tNQtcb44d5Trpm6bvB3Y/ieJwCsi5tYVYXRBhERSgCglbOX+KIHh+Hc
         AAsxGifGeGkfiLbPwqm7PtMn9uaVHqhFDoP2HgPx7pQAzGbHj8uPyOJ36x2VZSeplceb
         3uaQ==
X-Gm-Message-State: APuU4Z+UU0UnL8OeFC1CtuCh5hfb5YWNM3ZaAHdrP5oHF6Y3qHvRf29W
	4kaHLIXNAJGoTiVY6z2wqSGiUaeTukVUWOWZCQkRetuteJaWuMwSbh6y
X-Gm-Gg: AZFdTZcVSiaxKAf5ZSHOU+7A2h+6N9MDbyvfZVob/+urp87+A6strujLgYtDx69O7v7
	yQS1KVaYyycThiREcqCuNy4f6BffyeTUIIpchR2HfOLj2BMTAAKE0L0QlS6qgdNV82YtPSijbru
	QjEc5qo3OjXL/afQvVEY0tCbBztCkvarlmmXoURzgJ82VCAKoKbQgaTWWmkJN+hhAKmkJN51pG/
	EU9mAwP8YMaw5b7ymbIcDOBYrk8FFcKB2mNVa2IaZZSi0pBDz14ShC723ctbeYHRsPSz0KyLlWh
	xqrVQHOzUPQBJXzdSQQuJhS7dTha1FaKKtUJGxtZimfWZdItbQuTwbBgi4629VTYjAQvZAK8HrZ
	4dGpgQZPPH3k9Yye8Cjwe7oHBbOCzjFe4qkTviLaXzHvhby1XiGb/v52PR2kb059+i8Bc4uPwha
	GoMa9EqNMmMpK1+FhNxNzL+fELzmj4RNLbO3pWnNJnHXQcBa3H3KvPUOUIJLKeTRxgrWM+RIxGv
	RSEJBZreTt0/pe1IwsawejXSqRw+yX8LtTQgnDCdaB9AhM8E2yq860fGjLS06lfG3ag++afVIG9
	PwgWAPC2OJNvrnyW0KZphw==
X-Received: by 2002:a05:6809:2792:20b0:57e:3c4f:4b4c with SMTP id 5614622812f47-57e3c4f5369mr674626b6e.68.1795446960084;
        Mon, 23 Nov 2026 07:16:00 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:75::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a2eb50d63sm9414635b6e.0.2026.11.23.07.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:15:59 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 23 Nov 2026 07:15:41 -0800
Subject: [PATCH bpf-next v2 01/13] bpf: Free unpublished local storage with
 kfree_nolock()
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
Message-Id: <20261123-sls_f1-v2-1-76474de9b052@meta.com>
References: <20261123-sls_f1-v2-0-76474de9b052@meta.com>
In-Reply-To: <20261123-sls_f1-v2-0-76474de9b052@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795446955; l=2691;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=x7XFB2uSqCSLnN2T6J6S0To4SeK+7aYkkdeErraTbSc=;
 b=0ma33oi296xFHCs9uRUQ5P/bVLA8WkXkEC5CujD3XZBMDX+Nup7XRb5ENXIXZ+mMxVi2So9rj
 FJgfMN+tCyAAmooRs8FWtTJcSQ0M7+p5VHa44VkslxWAgvAvHnnAzWP
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

A tracing program can create local storage in NMI. When the create
fails, the new storage and selem are freed with kfree_rcu(), which is
not safe in NMI. Nobody has seen them yet, so free them at once with
kfree_nolock(), which works in any context for kmalloc_nolock() memory.

This fix needs commit bd897919e4dc ("bpf: Link the first element after
its storage is published"). Before that commit, an iterator can find the
first selem before the storage is published, so an immediate free is not
safe.

Fixes: f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolock() in local storage")
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/bpf_local_storage.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b12fcec47ffa..3abfe7034df8 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -158,6 +158,18 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 	call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_trace_rcu);
 }
 
+/*
+ * selem was never published: no reader can see it, and this works in NMI.
+ * Only the syscall update puts special fields (uptrs) in a new selem, and it
+ * never runs in NMI, so freeing them here is safe too.
+ */
+static void bpf_selem_free_unpublished(struct bpf_local_storage_elem *selem,
+				       struct bpf_local_storage_map *smap)
+{
+	bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
+	kfree_nolock(selem);
+}
+
 static void bpf_selem_free_list(struct hlist_head *list, bool reuse_now)
 {
 	struct bpf_local_storage_elem *selem;
@@ -562,7 +574,8 @@ int bpf_local_storage_alloc(void *owner,
 	return 0;
 
 uncharge:
-	bpf_local_storage_free(storage, true);
+	/* storage was never published: no reader can see it */
+	kfree_nolock(storage);
 	mem_uncharge(smap, owner, sizeof(*storage));
 	return err;
 }
@@ -605,7 +618,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 
 		err = bpf_local_storage_alloc(owner, smap, selem);
 		if (err) {
-			bpf_selem_free(selem, true);
+			bpf_selem_free_unpublished(selem, smap);
 			mem_uncharge(smap, owner, smap->elem_size);
 			return ERR_PTR(err);
 		}
@@ -692,7 +705,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	bpf_selem_free_list(&old_selem_free_list, false);
 	if (alloc_selem) {
 		mem_uncharge(smap, owner, smap->elem_size);
-		bpf_selem_free(alloc_selem, true);
+		bpf_selem_free_unpublished(alloc_selem, smap);
 	}
 	return err ? ERR_PTR(err) : SDATA(selem);
 }

-- 
2.53.1-Meta

