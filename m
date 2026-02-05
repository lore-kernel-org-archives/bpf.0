Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5994F35A92F
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 07:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274934; cv=none; b=d14fvxUn6uHEOOE1/EgUMsNToiVb10iuPLOaqB6hHkKdCdUcPHqP4kNbjk/4bL+43v2o2GAITMC6UR4LmevTfNpJfsZWdiETiKlq1sh74ihVVcyPArcqKUakT+5ELd0DXLgtD4LtnWDydM1tA1UBPzSWu8MdRLbUSZu00qjMHQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274934; c=relaxed/simple;
	bh=gdcsyDwNsQ2ytUCW/HWb7WipDs2hLnfg7IQSIR9TeL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbThreG8hxJ2Q8kpRzpF1kbL5hquxdLVrS5+DdHNeCSOoD+K86rF0POXv7VTBswoWnRZNlqhWU64r4VLbfcVbSAvIm902AefcsBNYCUdqEHZHBrGbfaf5UHXq3lOr60Iscwa/4FvVzxqFv6bJQRYGv3xV+hygrOXLgkxrtEFczk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5+onEYX; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5+onEYX"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-354a2f2754dso120795a91.3
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 23:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274934; x=1770879734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3g3juUlDLxi5nurQC1ri4utc2R15A7zEeplfXXAvTo=;
        b=i5+onEYXzXIFkCNxEHM8VNhPbGNfhAsYbCDPT9O3+CBIG+pYsP+ZkwwPKnrDu47OAy
         VWAbrc+au0c82AoTr3VeEbXqibLBepgStN+kuja1bqeSkbHhi2mNXMZsxFGSEYnGU0xf
         zDV3QB5R7HWMw9VkN3WPgbFGuMDQx/lHiUXDJzR1DXOd2wxN9+YaMlB5R/ff69YLGrqL
         Qwm/Pm+lAhprlUpUymD5vqA4uL9iMVG+oqenwSaB7s8AQn60L+RL7jXCV0emFGSVrNCH
         6Q8vLUuathSOckQbYCDA9XWa3hNAnfcdtnFFEpNuyzbZW1hLnkB/gzaSuoMvoRXoGtoZ
         HkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274934; x=1770879734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x3g3juUlDLxi5nurQC1ri4utc2R15A7zEeplfXXAvTo=;
        b=P6+b9qN8n2BeRPis3DegyqKgrlove+4bP3G0eIfelGUYz/PYJ+ck5kSTdkyARrpMBh
         Hk4jHWPCrH+c6Xi/iq1wlRlUN02GCYHepIEcTLe5WARDbs4EBB/VZc0MYs/IC1+LHsL5
         qUkrbZ/lfO0mBjyPYQdKuIEm3+D+ra92V46T0jMzYD2XZnmKzNAVpUyH+U5UDDrgruIW
         o4Qy4+wvTfehzQVJ85SSIkjg9vHePknGRoc8bxYh58fdX95GJSeMACW0G88av1M90Mvs
         EVYG+Pvoi/x/kxy4UGWG4S+Z1iLKquESx2fvtuXcKX1Toh5Bzkagthq2r+SBOJ8cFez5
         /evg==
X-Gm-Message-State: AOJu0YyV8O3J83oIPycX95rKsF5O42CGEdvVQCrDGQyBlf29J9evvbG9
	04z7lEc3zVpBL6dCiiI3Cabv9KrgdI0amyAgh67q0wA6+z1pN2t6y3FTxJE/eQ==
X-Gm-Gg: AZuq6aIGswIo/l9mn57AazJY4dE2VIesyZU8S0//y5wh8HwfHF6xdodGL5xw7gid7V2
	MIG4Gp2rRNEbzGiM4PXDOxxfsjnT0Y9G7aYaUCFJuCvtj8pgRTigqouOss1C/NHoO8nrSf0cB3o
	E1KlnOKLrgqRxsycPAaFlKPEyUsQiOs6S8liS373tgld45CkZGzcrxiG/PiTUV4lkuQFn32/rf4
	o2qv/vJnykHjyNuKCjXAvqS4e6+CJF+ReA3q5FzhNCzYPhTQmE+VgUafM/D5PF5SKGXUIY3pDQS
	+zvXPWWadDLqkY5nHsHo1FDKPFgzxrLATfLLe7JipHhx9g8gJErD3Yr7C5tmY9IcBFIUtMhZKAr
	ezUnDXZzJjFH2LzHBT30ps6MISbzPR9VBGvUFx07D8OduCiAAPH+tRI5a0kdU4xKdubsnZ4P/9m
	bC4gedfjeIOnSC
X-Received: by 2002:a17:90b:1a89:b0:343:eb40:8dca with SMTP id 98e67ed59e1d1-35487190e1emr5094064a91.19.1770274933364;
        Wed, 04 Feb 2026 23:02:13 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3549c0bce5esm2089559a91.5.2026.02.04.23.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:13 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 03/17] bpf: Convert bpf_selem_link_map to failable
Date: Wed,  4 Feb 2026 23:01:52 -0800
Message-ID: <20260205070208.186382-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205070208.186382-1-ameryhung@gmail.com>
References: <20260205070208.186382-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for changing bpf_local_storage_map_bucket::lock to rqspinlock,
convert bpf_selem_link_map() to failable. It still always succeeds and
returns 0 until the change happens. No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h | 6 +++---
 kernel/bpf/bpf_local_storage.c    | 8 +++++---
 net/core/bpf_sk_storage.c         | 9 ++++++++-
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 2638487425b8..709506e982a6 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -178,9 +178,9 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 
 void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
 
-void bpf_selem_link_map(struct bpf_local_storage_map *smap,
-			struct bpf_local_storage *local_storage,
-			struct bpf_local_storage_elem *selem);
+int bpf_selem_link_map(struct bpf_local_storage_map *smap,
+		       struct bpf_local_storage *local_storage,
+		       struct bpf_local_storage_elem *selem);
 
 struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 5f7869078c4f..bcf7e7f42d18 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -366,9 +366,9 @@ static void bpf_selem_unlink_map_nolock(struct bpf_local_storage_elem *selem)
 	hlist_del_init_rcu(&selem->map_node);
 }
 
-void bpf_selem_link_map(struct bpf_local_storage_map *smap,
-			struct bpf_local_storage *local_storage,
-			struct bpf_local_storage_elem *selem)
+int bpf_selem_link_map(struct bpf_local_storage_map *smap,
+		       struct bpf_local_storage *local_storage,
+		       struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
@@ -377,6 +377,8 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 	raw_spin_lock_irqsave(&b->lock, flags);
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 	raw_spin_unlock_irqrestore(&b->lock, flags);
+
+	return 0;
 }
 
 static void bpf_selem_link_map_nolock(struct bpf_local_storage_map_bucket *b,
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index e36273e4fcbd..0b85d8f2c17e 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -191,7 +191,14 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		}
 
 		if (new_sk_storage) {
-			bpf_selem_link_map(smap, new_sk_storage, copy_selem);
+			ret = bpf_selem_link_map(smap, new_sk_storage, copy_selem);
+			if (ret) {
+				bpf_selem_free(copy_selem, true);
+				atomic_sub(smap->elem_size,
+					   &newsk->sk_omem_alloc);
+				bpf_map_put(map);
+				goto out;
+			}
 			bpf_selem_link_storage_nolock(new_sk_storage, copy_selem);
 		} else {
 			ret = bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);
-- 
2.47.3

