Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611328;
	b=Kbol4gojp8jpVuCUufMZgnYePp0RtGk9T4UjS1vQuGR41nUvhDAaEk01sdz8TP9Q7DpZ
	 UZNZrYJNCrlkSIzCXYePiHo9r83OzuTf7Fye8wZ9ibpnJA1BvFp34blhPRTB+jirNfwJG
	 IoPCa/qHDfkI8ep0sf6WYBUfqBk/azEjLwpgLC5ZBpJh6q6C7M5xlszz4plQrSDb4lR+V
	 umiw98FkPOIwXZ03JqAahzg9/iTmCvRTb72nl8dcfWnc+xZlQx9Fs22aQCWT0s1v2347a
	 oCOAj18V3GFha0wfXDaR7v7c0Etq2ui7yaoytwoQiLmMbn0Jgrw3ty/xBVt+GmWpM4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=4oUbA8O+njdZNXSscj+F6aoVav9e6qOXALEFQ3dot50=;
	b=soL47dCoHO+av3E7iCEPQfC0Vcu3nIbFv5UZt8StS2HnREjknV5RDgBeuziUADQ94VZn
	 TbFFxnX/KqU+cesDuUnVBvXCtnsYIXVN6byXRzTYj8GxBYLzKfnbwSgHbWrgHeQtk7TJk
	 w14UdTwraVR8TQjKpzjJx5i5/TTV4D72afhC0q90rGZ3Li3j8Z8cr5dFeMZGUbVlydYAr
	 3dm2qWlbTbmBrqx/kmG+mSA/nR+6SmJtKGxl3yHj+VhhqiNpB/YwUOISi6a3BRwrLP6r/
	 Q2a6Fx6IY9+itjBKEBw/U/vhjfDIo2jNffGGVFonNyODNN4gT5NxqK3T8lzkBm7zF8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SOnujpnU;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B20606A32D
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 23:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97B20606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SOnujpnU
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b0d63f60bcso18615017b3.3
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 15:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794611326; x=1795216126; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4oUbA8O+njdZNXSscj+F6aoVav9e6qOXALEFQ3dot50=;
        b=SOnujpnUEKM1VpMGC8PFFHpS5C4/7fJBK9/X//NK+vZrVurSGK0TD5W71bESlLqtW8
         o8giBYODapCoiRCrSSif+KI2WIxnzpnbWoXPv+ux9c4VzFVtZ7qYRpRZ80Xtsx3wz3tE
         6pjZapVp4WAT/p7tQhrW/xa8BNhDcPC9/8GB46mIwkSDM9VVEnZJQFbYH2laikYjTyhU
         aIccfJC42xDk+eJ9lL+oB/q3ZDWTRz7wsrN0XCjiKPHYSDRf6M3VNkMilZqFNygXHzmV
         3t3p9j31IiGcYyNc/PPFYkq7os1vECsddYBG63Rug57KGCldoWV4A8YlfEuOA6n8/1B4
         n0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794611326; x=1795216126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4oUbA8O+njdZNXSscj+F6aoVav9e6qOXALEFQ3dot50=;
        b=dvQ8aj2xN0/Un3VirzpJ4vk+pVGMQ33mULP/PkGI/BkB7PWrxQBPAeYfrEeO2ei/JR
         3AfdMF7MMtzLQBtBSSqWazKsWgamMPsmzLCZ9wefRSIr89ACbC3ZhU02e5p5Qs7eVTcK
         +05U6Jqfw52HsU7pn77Fm6riNTSpZFpbOsTO5t1usdYGolr9FYhDOKHG7OJWi/6fSXEr
         jpxNhmi+hEXzUndj9tfTjgBtxikNNWA4gz/KMYwrpRVhjPBAtl4W19PEztS0xwxiLlBZ
         LSoOJCzf1/AsFCON6lnILhBUQ4wBaaqIIj0VemHrOSDVy/Ga+AhcT4uVTLLVsGI5qq6W
         b00A==
X-Gm-Message-State: APuU4Z9DNaRozPoUP6fui6TTpQdFf1HCOjfq/6vj/SK/LzQ8+x+XGmj3
	CPZ+tyWE4peclF3cT3h+soFeWh1B2aRaM6eKdFV3u5ZGgHsT687Y8nG2
X-Gm-Gg: AYBFou1tyHoB2v7JgDM4rbE0lFFiTDYh7moTIH1YbcxMfQIIsaf+A0WXx1IhgLM3MjL
	klICnsJuQeWjXUAU7fXeFpuNoht82Wm16eq4SW5RO0CQ1H5zgj9v5B8qGwJvinsmpx9PZj1ukL1
	C7II3C1JJWcRfK6KZBBASRiMCILIKJyzLX2ohIvgZRRiPWBX2W+0h6Rvzhzy/PSI9xWOYrs3w6n
	p/ko0UaRKJH9dUpC8j1lu5GdJOnTFQmYTrDTXAVoYeEGLSGpfv5l4Ntiw1DVIP/S5VxRORFTn1P
	b1DOchxBxHC/w1mIMwSV4fH931fmizFeQ0F3LY5w6m7pJBiUijVOrI/9Pp3SduUYjKcdlx2t7aS
	b0IIpP1sFdfJZXjM5JSkl1bkZZw070Ypbs6C4Evpovz+5jRIJxL0EG+gmoFGpe6wDEZQYzstTLb
	gU+n+VTUWBH2vCiFR3j4/PDDxr61Lj3z2BmrLujlNQ6qBM6S3msryb3CaqGT/cWOxewnicbbJMq
	brudfvMxu4jMM8+4XJMjKmyg1r31saIMOaE/OPAEUMtcJaenJRSZmIQj6DY+VrpVjFBFnz91sfK
	CileVWzkAP/PnMOkuVIc
X-Received: by 2002:a05:690e:1c1b:b0:67c:b95:6757 with SMTP id 956f58d0204a3-67d897366a7mr2711637d50.80.1794611326583;
        Fri, 13 Nov 2026 15:08:46 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:40::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a59e70asm3306815d50.10.2026.11.13.15.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:08:46 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 13 Nov 2026 15:08:26 -0800
Subject: [PATCH RFC bpf-next 03/13] bpf: Add bpf_local_storage_delete()
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
Message-Id: <20261113-sls_f1-v1-3-1b9492bd3f97@meta.com>
References: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
In-Reply-To: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794611317; l=5082;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=WEsvDJG5ZhZ+4Rt7u0Y6K/KhE3SReITGK/9Nv9iYou0=;
 b=cGoAL9x4WQWejANAq3wK5LO/7v2CaOdPRDUL9Y1rh4p/vjVdhAtYf8rbpRdwJIl77Q9e3At4y
 2vMNUwZaLMoBDK87NefDOOwuek/p5GSJhNCtqugDzxTiqPykvduNZRy
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

