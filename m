Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446966;
	b=BhL6gRmGRo/WCYL3u7WiDZ63UxXC/ec7yPwcCdDjjIangNLqmp47snE+k5AKiBoigZ6G
	 C3bJpknMQ2UKDuR2EdBkvQ+UZjiHoTcHExpnTIgG3EMQD6uyguBPnsWNe5nvzJQTjCOwV
	 CoVWJ6/h9MmAORL8y5HG9i7VIxyAp9YlY3IaYSZUR1zbaXSIO9KnOYDeXIPbcVGsdAO1A
	 gLIXFW3LNxQikXT/c+RP5yfvx6zwg+MQWtgvhpdrDRsizQVJthI6zfihdx5t9kATTGbe/
	 MJ0PveWDXvJ7F7NqEdUpZJr1MnQjdcwULv+tHcksWx9+k2ZUTh6d89tb+zit7xeIQNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=4oUbA8O+njdZNXSscj+F6aoVav9e6qOXALEFQ3dot50=;
	b=QVLgRF9xAocAazCGYVW+31SpeWCvF9g0fcMZj7q57iNTYYL0J7cBCjHdoALsf+eDW2Xa
	 1fyGwLdgVqya1lYg5GoFpSdAe4SUyguvET7OdAxVrFjKmiBXc4faRtENt7NZCBE+Qs4tu
	 RxuKzmMs+xzvlV46TJgPXzlWt9CeNOcYruKxJgYPbpX3BfR3HGTyLa6vAIEm76bN+LKZ5
	 G/PqrpSd+UR1jEWDOZOJSgdlc83o0Gerpd49IICvfJNNJ4d+JO6v/YeV4cFMp43GtobXN
	 HCQ0ZrZEUiLNwx1udtXuVAYZ9iw5ANxCpZYrDWjABMqMhvdMk0zfoHnxpY3KtFM2vLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KeVpAWQ8;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA618606A32D
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 15:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA618606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KeVpAWQ8
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-862b76e3c8cso1535086a34.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 07:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795446965; x=1796051765; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4oUbA8O+njdZNXSscj+F6aoVav9e6qOXALEFQ3dot50=;
        b=KeVpAWQ8SIuG3sYEEXlYPBw9aKamCaJMqDfaK/GIo39lmcUWjSN+iRRGZedv0G/kRh
         DqPPpIo5DmgueKgmN6GprUNwNFiIIE/so7svGW7q3b+vqsdLucs2feKWsLK7rSNeSpE7
         tqtfDAHFzn3R2D4Q1JynAcx4SKubwrAA6ESq/oCi26wsYdyvtx/FYaQAS2opZIrb/89x
         MfUT1XN1tuCdFgI+EKHt8G3JQbBduPGW9MQrAZPM/0MWFuS6jCVYnOPujeZhmk8mcR5x
         rVQHUkm4Khp6iYIZUdjcv4Amgb7a9gds2UgWln/Af+ru+H6Lsb6iRXjVoEIV/2j/zEK9
         OSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446965; x=1796051765;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4oUbA8O+njdZNXSscj+F6aoVav9e6qOXALEFQ3dot50=;
        b=jv9MUeHPNpgmIqj3CO43UfEDSNHkne/KWWB2OosQIRwl7dtKA2B5+za+IzaepsNrEd
         N8Gdsxt80hyfEMKOazdTD5T0WlQ/74P1RZ6fMa5knAPCQKNc8ImOJlDU7fvUWG6Pa78X
         QOef3uFY0a4UaUSzyWpzReFtB/k/M8Eo6l/Ng+5WXMnD33vWNHhzE+bkh8LBczt/JphU
         6Vecfm74aT5r18BDkz6zw5aBpb3TLbZmsEoMmsgzuJcwFuDGU9+W5kJuev1vYDe0rV4G
         J0TD12ehxB32IS8I3cqwWfsJQUL2W5sAGu4cmYa5+PWVisNbEdlVJd5iF1p3xaK9widR
         6UxQ==
X-Gm-Message-State: APuU4Z8S7BngJKhxWqQgbsHi11TVn/1NbIdJxGwEa9z7UifLhtgYvb7R
	zg0CjcMIuQ06rGf5YhKVljBmhq0KpYlWADMn6WuTTA5NajPUTH/Allkl
X-Gm-Gg: AZFdTZe3Ls8cQxlsQkalw3t8o4Yw8SKnaiahpk6wxXGixLu4Wa326MSYxr69Y0bpiTu
	tEGWmoQgRi5pDfMY5t4NHV3XOpV3xsiY+JnBIilT+fZ6E4XJG6fGYBPYvjBSmu8yUJG/zlVJztG
	HNg8SO+WZhSZrqGAQwI0aezl54Q7LmNzw8uhNRYvjpkcgGiXLsKMCyWw2hcNSTOIi+KwLKficDX
	yff9FyZ2XnyKfc/k38Ganh0Ay0VUKOh1bG6VyMvGD6W5e4mQ43vx6l4vUl1z1MOZqHU09n6dXL4
	K8iqbSZaxXwuRbzpUpO0Azfz3f/q7sCS02i3HkbG9iXg75B6pNO30DAqNZLQBE43Ck2R7hr6/xu
	E//bVeyfZza5r1YGZZP3lyfC8zciA6ebAkEBSNrFleeTSNRwDVDq8CqOH2UWayPAuaSmJZ8RHhQ
	vwVVyPmFeJP3ZvPJHj9oYx/LSV/nd2pvXpsifkWbyVPa5uRRToNxKKqU4OhiC0nPFE/oVu3SgJm
	BqFpLHL6FLjRhJrymrlG0Bjz/Me6uOfSjuhG+bF9ikcMMazYuTQhz5odIN3SPf1MB0/A0gmvwOl
	tMUTUsOcROQHQsHIp3navlgaf9kPjyyWfQSPEarg
X-Received: by 2002:a05:6830:448d:b0:85f:1601:d3 with SMTP id 46e09a7af769-863157af868mr11924974a34.23.1795446964901;
        Mon, 23 Nov 2026 07:16:04 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863169105b7sm9224560a34.22.2026.11.23.07.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:16:04 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 23 Nov 2026 07:15:43 -0800
Subject: [PATCH bpf-next v2 03/13] bpf: Add bpf_local_storage_delete()
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
Message-Id: <20261123-sls_f1-v2-3-76474de9b052@meta.com>
References: <20261123-sls_f1-v2-0-76474de9b052@meta.com>
In-Reply-To: <20261123-sls_f1-v2-0-76474de9b052@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795446955; l=5082;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=WEsvDJG5ZhZ+4Rt7u0Y6K/KhE3SReITGK/9Nv9iYou0=;
 b=NN3hH9gvZdgdUozUOGmcjtI/eJtFmgl6Mv0wa8Y95933Gv55A9aWhwTa2+Q+Rnbe7DwsixtuG
 /F6NyM9IWFIC5o0XxKa+EVXwccCvQEEL2EDsczl6Q7EMLzPA1q+xj5Z
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

The four owner types have the same delete code. A later patch changes how
a value is deleted. One function keeps that change in one place.

No functional change intended.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf_local_storage.h |  2 ++
 kernel/bpf/bpf_cgrp_storage.c     |  8 +-------
 kernel/bpf/bpf_inode_storage.c    |  8 +-------
 kernel/bpf/bpf_local_storage.c    | 15 +++++++++++++++
 kernel/bpf/bpf_task_storage.c     |  8 +-------
 net/core/bpf_sk_storage.c         |  8 +-------
 6 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index d336fc051054..ba8de9f5ec33 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -196,6 +196,8 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 
 int bpf_selem_unlink(struct bpf_local_storage_elem *selem);
 
+int bpf_local_storage_delete(void *owner, struct bpf_local_storage_map *smap);
+
 int bpf_selem_link_map(struct bpf_local_storage_map *smap,
 		       struct bpf_local_storage *local_storage,
 		       struct bpf_local_storage_elem *selem);
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index c76e9b0fabba..d335e2965ea8 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -83,13 +83,7 @@ static long bpf_cgrp_storage_update_elem(struct bpf_map *map, void *key,
 
 static int cgroup_storage_delete(struct cgroup *cgroup, struct bpf_map *map)
 {
-	struct bpf_local_storage_data *sdata;
-
-	sdata = cgroup_storage_lookup(cgroup, map, false);
-	if (!sdata)
-		return -ENOENT;
-
-	return bpf_selem_unlink(SELEM(sdata));
+	return bpf_local_storage_delete(cgroup, (struct bpf_local_storage_map *)map);
 }
 
 static long bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index f9e81060c1f4..07ba08707979 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -104,13 +104,7 @@ static long bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
 
 static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
 {
-	struct bpf_local_storage_data *sdata;
-
-	sdata = inode_storage_lookup(inode, map, false);
-	if (!sdata)
-		return -ENOENT;
-
-	return bpf_selem_unlink(SELEM(sdata));
+	return bpf_local_storage_delete(inode, (struct bpf_local_storage_map *)map);
 }
 
 static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 6f884c9fdcea..2d2a627360fe 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -356,6 +356,21 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem)
 	return err;
 }
 
+int bpf_local_storage_delete(void *owner, struct bpf_local_storage_map *smap)
+{
+	struct bpf_local_storage __rcu **owner_ptr = owner_storage(smap, owner);
+	struct bpf_local_storage *local_storage;
+	struct bpf_local_storage_data *sdata;
+
+	/* An inode can have no LSM blob, so no storage pointer */
+	local_storage = owner_ptr ? rcu_dereference_check(*owner_ptr, bpf_rcu_lock_held()) : NULL;
+	sdata = local_storage ? bpf_local_storage_lookup(local_storage, smap, false) : NULL;
+	if (!sdata)
+		return -ENOENT;
+
+	return bpf_selem_unlink(SELEM(sdata));
+}
+
 /*
  * Unlink an selem from map and local storage with lockless fallback if callers
  * are racing or rqspinlock returns error. It should only be called by
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 4b342be29eac..1f73292755b4 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -128,13 +128,7 @@ static long bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
 
 static int task_storage_delete(struct task_struct *task, struct bpf_map *map)
 {
-	struct bpf_local_storage_data *sdata;
-
-	sdata = task_storage_lookup(task, map, false);
-	if (!sdata)
-		return -ENOENT;
-
-	return bpf_selem_unlink(SELEM(sdata));
+	return bpf_local_storage_delete(task, (struct bpf_local_storage_map *)map);
 }
 
 static long bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 1c59300af05c..a838be80ebbd 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -34,13 +34,7 @@ bpf_sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
 
 static int bpf_sk_storage_del(struct sock *sk, struct bpf_map *map)
 {
-	struct bpf_local_storage_data *sdata;
-
-	sdata = bpf_sk_storage_lookup(sk, map, false);
-	if (!sdata)
-		return -ENOENT;
-
-	return bpf_selem_unlink(SELEM(sdata));
+	return bpf_local_storage_delete(sk, (struct bpf_local_storage_map *)map);
 }
 
 /* Called by __sk_destruct() & bpf_sk_storage_clone() */

-- 
2.53.1-Meta

