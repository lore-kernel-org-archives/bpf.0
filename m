Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DFA38D41F
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237011; cv=none; b=oDJ+14Ity3GAC+n44gRSBcYuYXV81oaIZuxw3UjPyTjY1i6EEPLhm42+VFic/Z9IlTjjj1AYw8QJgh5ob6IEuHHfy3Aw6qq+emrFMsFvdcbiyJV67Spddiw1FljQtT+Dgs60KuZpEv1P4gv49jR+YkHFJ/i/vO3m+CVX7qFnRbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237011; c=relaxed/simple;
	bh=5dxJpYNmNjYgsCeUDPk0LotgujMFjbFSpptiu28baoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+I37eWBgcyTv+9nuTGTiLC/xuqbi2y4UuvBWL9zFO3kB4m0IF1Jp5idYgypv+Xac9IOE4kFaPtWSFTYX54Q4scoedq6J80h4APwkSTD1uTe1gj2irsi7hN6rMRNYPpd7j053lW6KAliv6Xj0fczvp5qyrLbCrPFkwdRic9FzOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK6iG5t9; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK6iG5t9"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e6e21c47e6so115328a34.1
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 10:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237009; x=1782841809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91jm4JZIjKWf/o29bp0zeJwiE4GAwL4vFnu1UTAweC0=;
        b=dK6iG5t9ikD3s/LvJHtcKuI81Uqb+jGuY8jIte4TMJxVNwhKTp65k07zQhoJmxWNnf
         0yuwUfew8GfyZKfDMliOlQQSF7K2v7+sYPDjqLymTrIiGPQK0JWXXQbyMW/EPn7Vu+hU
         KbO5jsL8Cg/9NroEXx8TwGM0HfNxyiGMn4bQTVG2HIU5PdSyVKtwOBb8Czd41CYNWHfo
         TAuLKB9p2KIw+Ffas5LaMBzXFB7HssEjBI2SygGfDg8+S3lM8ySuZK4xafMn1UAvah6Y
         6JQzayYFM/8V2x89LdIBBoLjAd6Eq840FEY6bXNwNiGukIRr3iOja0iqt0N1I+7PeWXR
         /Z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237009; x=1782841809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=91jm4JZIjKWf/o29bp0zeJwiE4GAwL4vFnu1UTAweC0=;
        b=oXqJN5Jn+L9DywJ4QLKHfH9ENWu9R6lQ/Igi7xEs8k98O0aivLaRkj0zqp1LcDyoQX
         hQanmApvlGjLxM/90zr6puhtScb6aDnlkGOGPUa/+NCGQNNV7QaCfp73cgUNxX3nbuWk
         DR83OkonwpjEBJ84nvWXYzMtJNfh6SvJPILAddrIp/m1SW8jBT0sf26b9JcsOJr8R6Ci
         j/vxn2Xo4EfwqZJvsFezwLMCH2Ipx5SYbgKTGuWP/mlgiTNcG+KGZtlMulO51b/LehDZ
         e5hHa5K+07RY2MemFI1gtoC7dQ2f4sDQLsw4ZLf4wfscoZJTw/jVvmoFOQFkjGsYiWIo
         E+jw==
X-Gm-Message-State: AOJu0Yyz5BK5q2EMbCXYSFlxp0DQNjA0ZUbUtdzF/SnZOKpOWAwDJPyn
	Aa5S7ncR0WD61KER86fzOYFyJ58A7TZCSfOUNjsgrjm1M6wyc8IOoTxw6IPALA==
X-Gm-Gg: AfdE7cndqU/7OJsElgOkxjpCXsUSzbU2di9hGWo14JMyrK+mVE2MBhyABEREYOPyd7f
	/REe4B2PxCNzAqgKWskiYAhe/BgyNarcsmHLdkAg1onwXvJZermgdnvitkl9oWMwwTL8JYMfOXV
	H+fJ3WX34jtXVGkwI869fAEICdjxsjNKuvhtA9GDXjah7+1iPpKILvoV4aL7iSf4FLMw35gaX72
	it9Nk2uXUWYw4uQMkSAUEvHMzbbFQ2eGXY18tBO1fA92FtlxSXdqt8T3djYMxnb7VkMsz1yktqk
	VuI0TR52WwwIz2rdKkX9MYMIYeXBPm7w1jzu0DAJy2lgXpe3mmEz6eiLlNrEPpXRmkAuBr5IBtJ
	OrKrstbZ9RY5/C1iHQWmzS0MhAWzkQ0A6hPRY881ECA1Ue7UThR2W6/rVRixsx5Gv6Jpw3ZnclL
	9NJ/c=
X-Received: by 2002:a05:6830:83ac:b0:7e7:8dc0:3945 with SMTP id 46e09a7af769-7e9867c52b3mr164537a34.8.1782237009413;
        Tue, 23 Jun 2026 10:50:09 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e944005ae8sm10073961a34.3.2026.06.23.10.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:09 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 01/15] bpf: Remove __rcu tagging in st_link->map
Date: Tue, 23 Jun 2026 10:49:49 -0700
Message-ID: <20260623175006.3136053-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623175006.3136053-1-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

st_link->map is always written under update_mutex. The paths that read
st_link->map with rcu_read_lock() are not in the fast path, so they can
simply take update_mutex instead. Remove the __rcu annotation and replace
all RCU accessors with direct pointer reads under update_mutex. Use
READ_ONCE() in bpf_struct_ops_map_link_poll() which reads the pointer
without holding update_mutex.

It is a simplification change.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 51b16e5f5534..d06b3d9bcc13 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -57,7 +57,7 @@ struct bpf_struct_ops_map {
 
 struct bpf_struct_ops_link {
 	struct bpf_link link;
-	struct bpf_map __rcu *map;
+	struct bpf_map *map;
 	wait_queue_head_t wait_hup;
 };
 
@@ -1257,8 +1257,7 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
 	struct bpf_struct_ops_map *st_map;
 
 	st_link = container_of(link, struct bpf_struct_ops_link, link);
-	st_map = (struct bpf_struct_ops_map *)
-		rcu_dereference_protected(st_link->map, true);
+	st_map = (struct bpf_struct_ops_map *)st_link->map;
 	if (st_map) {
 		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
 		bpf_map_put(&st_map->map);
@@ -1273,11 +1272,11 @@ static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link *link,
 	struct bpf_map *map;
 
 	st_link = container_of(link, struct bpf_struct_ops_link, link);
-	rcu_read_lock();
-	map = rcu_dereference(st_link->map);
+	mutex_lock(&update_mutex);
+	map = st_link->map;
 	if (map)
 		seq_printf(seq, "map_id:\t%d\n", map->id);
-	rcu_read_unlock();
+	mutex_unlock(&update_mutex);
 }
 
 static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
@@ -1287,11 +1286,11 @@ static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
 	struct bpf_map *map;
 
 	st_link = container_of(link, struct bpf_struct_ops_link, link);
-	rcu_read_lock();
-	map = rcu_dereference(st_link->map);
+	mutex_lock(&update_mutex);
+	map = st_link->map;
 	if (map)
 		info->struct_ops.map_id = map->id;
-	rcu_read_unlock();
+	mutex_unlock(&update_mutex);
 	return 0;
 }
 
@@ -1314,7 +1313,7 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 
 	mutex_lock(&update_mutex);
 
-	old_map = rcu_dereference_protected(st_link->map, lockdep_is_held(&update_mutex));
+	old_map = st_link->map;
 	if (!old_map) {
 		err = -ENOLINK;
 		goto err_out;
@@ -1336,7 +1335,7 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 		goto err_out;
 
 	bpf_map_inc(new_map);
-	rcu_assign_pointer(st_link->map, new_map);
+	WRITE_ONCE(st_link->map, new_map);
 	bpf_map_put(old_map);
 
 err_out:
@@ -1353,7 +1352,7 @@ static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
 
 	mutex_lock(&update_mutex);
 
-	map = rcu_dereference_protected(st_link->map, lockdep_is_held(&update_mutex));
+	map = st_link->map;
 	if (!map) {
 		mutex_unlock(&update_mutex);
 		return 0;
@@ -1362,7 +1361,7 @@ static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
 
 	st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
 
-	RCU_INIT_POINTER(st_link->map, NULL);
+	WRITE_ONCE(st_link->map, NULL);
 	/* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
 	 * bpf_map_inc() in bpf_struct_ops_map_link_update().
 	 */
@@ -1382,7 +1381,7 @@ static __poll_t bpf_struct_ops_map_link_poll(struct file *file,
 
 	poll_wait(file, &st_link->wait_hup, pts);
 
-	return rcu_access_pointer(st_link->map) ? 0 : EPOLLHUP;
+	return READ_ONCE(st_link->map) ? 0 : EPOLLHUP;
 }
 
 static const struct bpf_link_ops bpf_struct_ops_map_lops = {
@@ -1438,7 +1437,7 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 		link = NULL;
 		goto err_out;
 	}
-	RCU_INIT_POINTER(link->map, map);
+	link->map = map;
 	mutex_unlock(&update_mutex);
 
 	return bpf_link_settle(&link_primer);
-- 
2.53.0-Meta

