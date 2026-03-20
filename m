Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA5D355F5C
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 07:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773991613; cv=none; b=WsYKBdHleadUmNO/SFvTlspeOjNbaMHOoSQ+cZv6NlQFGCAHn1aGSEuPVcs5hVTcMmW+NFf/yAWP4YjKo5tERx/9i0anJr7nF59vaOxbxmZ9jr8s5glyDuOeRrYg3Ql2B8mZNbWPzWmhfm6/9MeePr+moseFhEoFY8Pj7tT0xoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773991613; c=relaxed/simple;
	bh=vMQdNvrRme6yVeAJXlE2gsl4gWcmXQsoRwYJ3tDkr/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mR/sFwPVUnSDmIu0NbsR10nVh5uJNig/XnTfclW4ghka9TvH9oBm+FG6nhN5LzgeGI9sjN0UtuYV5oVzMBlB5750eDfaCsdu5ZbcChvT1KC71SG75PqaxgCQEYfMJG5/s/8fvnkExBwDioXetID5FJSIfw6bAYtA132lmq3PhQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lo8JvIkh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo8JvIkh"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48700b1ba53so1523295e9.1
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 00:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773991608; x=1774596408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n3KJVSi9z2Jj/Hmyk1wzxgMI7Rqoa0UBGy/TFgOK0dk=;
        b=lo8JvIkh99/vtEmaRv0YbTHuIgkZXzP2yjuZfYhhyA8bQjWfIObyvcVgyOWT3e2BqS
         iFwoPn89scvSGd8fW3/1C6xb9i5XdwvraO40t3xYawzlrmm4aApfyoG4Jl+cJrJWgH08
         nFwp1JbvdLiGn8KZVQ6VSYH+tuQTHZGXyEaj+eQCbStSKkuMDS/ZFIUErKLOLkWM9St1
         2WwPjA4RzzlrTzJ1dnNLU6Zjdb4QuMF7crm3IwF1xY0UrOYfqRWuW7LsPhOtlkN/N5ry
         zNTLTM3nMNGojr5044DICXF0xu+yMAkHU3sjoJ0ib24j1MoYK/tYbR10JJP2GSu0vWiG
         PPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773991608; x=1774596408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3KJVSi9z2Jj/Hmyk1wzxgMI7Rqoa0UBGy/TFgOK0dk=;
        b=ipgsEIqLxGI7BIfeLYnDzlBiujDVn71guQmFD7Mj8evQZGWdCbXkLJv6nvM1QBH0Jo
         2y7Khn93EOtl1J0EOApNNVozZW0cRs/LDadoN0aaFU27FZWqf4z/EXu2PgbJpVbI+D+T
         S3C5EkKg5xl9hVSIGMGV63AFFRWITwqoFrRBAkQ6YIGhwkyOYdug6USXyONIWw7NXLn6
         Ngl0+Y9tf5gFTaUpLAR99EAv1xcsCFWp20g9E4mGNqgoHH67jZZYbXiQYsF0zi7qxTJs
         8v/+bNzxws6kWHdnShxKkT0TKL7bioLQopBEovH6VsPN/p++fhDQo9wfpeigiZ+DWEYW
         HPxg==
X-Forwarded-Encrypted: i=1; AJvYcCWSub5v4PRpAoq0II2VurpxO869wh73TcrCpaT+6bKnNsjrAayodOLhasYt7gFzt0gTUxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBzUR7S5T6KOWp1N4glR6oNewgCxrlOLYTWq/BSp7B04iFopmJ
	K9ue7hsKJAC2bG6ha/crt9pmfxeISdT6muACoPnpjDantt8oMW/OkndkAzS41HBE
X-Gm-Gg: ATEYQzxNcBfheuUIdPEynHcn/2Rj9BXOCpBSovMpxKyxUUpe/cjVJIvZz27vJOsk9+s
	TrkMU3okLXxWETwmKBtX2ywX4mIWEMOdwZ5ojTc3B0PT6maxHz9vBBQaCg9go0FG6mPV5focfl4
	qu4yNr9l8iXhQr6czSVYTv/y8zEpkboXa8N185fDyo2i99UCXChZXk1UehE9wNZY0Adt0aejoqZ
	Rd2c59Val2AEe7oRbHQnqVF9JhLYcLNIYmlj10bVTRiG9YyyfRRyOM1jYXwdGO1fa1V4usWyr4C
	acaRIPPn375vunuEFEKo7ZG0Bk/SVT3FhaYB9aYBNHmkSPVzoaRnXQCkt9rXxSRGRhWPYbXOgq+
	gj6ZPbDjSYyMZpfiLMGG8aqp4OBvN35l/l+jZ6r3vcku6hoDVRXDqO/m0WJEwwU/nphwqYNjB92
	x/ZpjlEp1jOUU//HSdgtRKWjiJGGmkVFITFdm4e3q5yt7K1kfSkeE9D8DdoEoyqERhmPIK2lZDq
	RVNyF8jj0Wt
X-Received: by 2002:a05:600c:698e:b0:480:3ad0:93bf with SMTP id 5b1f17b1804b1-486fee1af00mr24751375e9.24.1773991608143;
        Fri, 20 Mar 2026 00:26:48 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe879d37sm14871185e9.1.2026.03.20.00.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 00:26:47 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	bpf <bpf@vger.kernel.org>,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH bpf-next] bpf: use RCU-safe iteration in dev_map_redirect_multi() SKB path
Date: Fri, 20 Mar 2026 07:26:45 +0000
Message-ID: <20260320072645.16731-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DEVMAP_HASH branch in dev_map_redirect_multi() uses
hlist_for_each_entry_safe() to iterate hash buckets, but this function
runs under RCU protection (called from xdp_do_generic_redirect_map()
in softirq context). Concurrent writers (__dev_map_hash_update_elem,
dev_map_hash_delete_elem) modify the list using RCU primitives
(hlist_add_head_rcu, hlist_del_rcu).

hlist_for_each_entry_safe() performs plain pointer dereferences without
rcu_dereference(), missing the acquire barrier needed to pair with
writers' rcu_assign_pointer(). On weakly-ordered architectures (ARM64,
POWER), a reader can observe a partially-constructed node. It also
defeats CONFIG_PROVE_RCU lockdep validation and KCSAN data-race
detection.

Replace with hlist_for_each_entry_rcu() using rcu_read_lock_bh_held()
as the lockdep condition, consistent with the rcu_dereference_check()
used in the DEVMAP (non-hash) branch of the same functions. Also fix
the same incorrect lockdep_is_held(&dtab->index_lock) condition in
dev_map_enqueue_multi(), where the lock is not held either.

Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/bpf/devmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 3d619d01088e..cc0a43ebab6b 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -665,7 +665,7 @@ int dev_map_enqueue_multi(struct xdp_frame *xdpf, struct net_device *dev_rx,
 		for (i = 0; i < dtab->n_buckets; i++) {
 			head = dev_map_index_hash(dtab, i);
 			hlist_for_each_entry_rcu(dst, head, index_hlist,
-						 lockdep_is_held(&dtab->index_lock)) {
+						rcu_read_lock_bh_held()) {
 				if (!is_valid_dst(dst, xdpf))
 					continue;
 
@@ -747,7 +747,6 @@ int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
 	struct bpf_dtab_netdev *dst, *last_dst = NULL;
 	int excluded_devices[1+MAX_NEST_DEV];
 	struct hlist_head *head;
-	struct hlist_node *next;
 	int num_excluded = 0;
 	unsigned int i;
 	int err;
@@ -787,7 +786,7 @@ int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
 	} else { /* BPF_MAP_TYPE_DEVMAP_HASH */
 		for (i = 0; i < dtab->n_buckets; i++) {
 			head = dev_map_index_hash(dtab, i);
-			hlist_for_each_entry_safe(dst, next, head, index_hlist) {
+			hlist_for_each_entry_rcu(dst, head, index_hlist, rcu_read_lock_bh_held()) {
 				if (is_ifindex_excluded(excluded_devices, num_excluded,
 							dst->dev->ifindex))
 					continue;
-- 
2.53.0

