Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780A726B955
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968257; cv=none; b=pGCsFyOOWEaEN5+fHPPIfxG/ha99zWgAhuo16cxf7MqI3G7HpeKvqpfwr77e08edCh5FZGkIFCWtivbIw2cz/ZF5DyFMAiaVOJkxz5aa79b+WnazFFohlr3L4UrMPcfC/gLOGyr9OsTQE7ZB+bTRIV0QD74kvNddpt5Kohyb/L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968257; c=relaxed/simple;
	bh=gdcsyDwNsQ2ytUCW/HWb7WipDs2hLnfg7IQSIR9TeL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DT0OOCbPmXD8ea09iwGOV4tgGESWc/sfoihrSUxgm5YJ5zXAvy7DIHk9Y35CILU95K16u28TJU9zmyAjowrm2axEXRYqdazqZo03vVF2M1xixvIVcm0OhkCM+ZROoWx9BrGm6NUxVEFPNA2y+ORbEHTOYNeUElmkfFhaC0YD/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FT7Bkw13; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FT7Bkw13"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82361bcbd8fso2137846b3a.0
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 09:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769968256; x=1770573056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3g3juUlDLxi5nurQC1ri4utc2R15A7zEeplfXXAvTo=;
        b=FT7Bkw13ZyTDgzjPr+GFANGXMpuhoAsGuBv/Rpy3selgiPaZT3otsQPwVvL+ufSL2D
         /7T608SxVvV8jPe3bFTqI2FeydS5rvof58zLzaB9A1bCOuDIxIgaOjIf4+zyt8g9+69d
         GZWHweLCx6sW1VNYppkR8GeAhy39b3ZCEpz7OM9tWxX9gGrKOHNzlnXRP27Ek2X0nMud
         kpQAQwH0+5mpjdgqD0AZgv4GnvWfNiNwnyPioGucI/zPmWNpUeIM2k6twKCjkyjmD2Bx
         KpQNJpweYuiccsckFu3RpXEUXtkfW7LP7d0n3rlSyDJZUrp4XpmAV7OdzKQYAtnv6wKl
         hS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769968256; x=1770573056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x3g3juUlDLxi5nurQC1ri4utc2R15A7zEeplfXXAvTo=;
        b=iCgT7vqpJdN/GNZkWxLEHFnTgL08u3fBrJX9VfwtACz5kksa1AR2U+5RK2og5iXDoc
         ns9p3F+7PUNlE2z5DCk0TAWMarK2Wi2SROhLG2CmaiMu8u2tDEvPWpOrozpA3ei6inw0
         1SvQHG9/wGmfP2ac1mHxynFtAUOQMV8PNv381JB6OmjqTPpKSo23BcVbR2M46rpmugpx
         4ZxkAVQo5X0dtSFgPsOsg+DUgxpeBoJ4JZOMfcjYqU1vqT2paEc6LCCTNL3YsSJ6XJk0
         eqSqHsYBakfspSwgKQ+Ft2LskHUa7VlgvIKC1fWv4kQStdKq/a3G8T9mbLMNCKeRUSmv
         vybA==
X-Gm-Message-State: AOJu0YwRJHsr9ux0tTq5gpyM0eGylL+lAmjQ69wfJxmxeaqwC0Y3QCBr
	7QA/lsoXTP7Qkpoh61+IonxSP1AvP5tIUYEMeAxbNDhluww0KQILt1Ltuu1SRA==
X-Gm-Gg: AZuq6aK+4tKkOyEdLThyG2btzIWP/w8NJ8znn7UsreVrVheHxoFL0yEhc99w+FE6b0P
	BqEPpVmTIO3yEXtgka0r1EvPt1H41Kdzln381we+NsUVfNhx8WDfi8hDhLNtDohbz2Bvwi22pof
	Yddi3NlIQcc6SUEM/jFaV9fu0lOGliAbolFqCmrLNjLFWXPUb6vPkHDd9hgquWpf1hyShVWJhQF
	/vS8d61qS+ce6P4W2EUzLX7dMpdcPNaawiXxfw4WPpt1vBikDG8gVy4LHm7gbiAbq03uNaQ5IhB
	3hakfr6KNI/C9T5NTbktEdrX9RTzcHd3lx8xPqjC2ffKqLJNfRi6EcaZaAqrMlBRBgGuIdfxbat
	qx3YnjeFM6rGukbp7wm8QZ709iA/RL7ARDa18e8YtZxt4Mkkgx4CaOUtLrBMHxaFHg/ggwFYIkr
	IINA==
X-Received: by 2002:a05:6300:404c:b0:38d:e87c:48c2 with SMTP id adf61e73a8af0-392e015baabmr8968666637.58.1769968255664;
        Sun, 01 Feb 2026 09:50:55 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c64283710e1sm12264732a12.14.2026.02.01.09.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:50:55 -0800 (PST)
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
Subject: [PATCH bpf-next v5 03/16] bpf: Convert bpf_selem_link_map to failable
Date: Sun,  1 Feb 2026 09:50:36 -0800
Message-ID: <20260201175050.468601-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260201175050.468601-1-ameryhung@gmail.com>
References: <20260201175050.468601-1-ameryhung@gmail.com>
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

