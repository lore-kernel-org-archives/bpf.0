Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753E1285CB4
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968266; cv=none; b=DlbmHoIgc9tKkBqCbpQEHtI2267nZ25MdLC7dB77Y+ZH94BLLyseVJqxQQJ5O/KWddaVi4erAd0znQx3CGTDlwSk2jQq/64HPDqEYl+vAQbxbCGMokwfq4X+h5o735CJJqn2AnhLzCSVuOHt3svG8y+I2wt7b9icavUv+Er8Z+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968266; c=relaxed/simple;
	bh=tqyw3tdxTDjap3zYB15sILBy3tvrSukfm+ZbTrKJ/Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTFdwEMTgvtvZX3k456Hgj+UTAnXcOrXxKbqwcLZZso5H8T1BwyK2Bv9yL4aR1gUgFkCYYZlhtMCW8H+kXbTvdSsTmFcwIHuEo/4O01FOIcIQxA+QUS6M7U6QeX3yA4mpgVuMBuZeAso7u0xKCsjl0Pw2j3STiBM9ooU2BQQEx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFGB8oWp; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFGB8oWp"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c551edc745eso1711354a12.2
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 09:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769968263; x=1770573063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDJEAOra13fhqSAyHSRmRMMglqt1FGPMQOen9Yczug8=;
        b=LFGB8oWpEGsY++qiBaVOmLDTLd8a8loaqveJKNgOxyftw83xV7pv6tmq6F74/bhwqu
         TaPKRrfrps5DBxS2BHX4pcrvraNk6SNbp+Ew3LpAtlCZnLNPeQCSfSvi2JTq4V747kCs
         1Lev3Kd05obNagGN6fyWWLGOhXObaSQl/bplwJC8mzC2UguBltCXe5niTFf6HA3QPPq5
         /r62R0E0KNuB1IRiZuR09BuIJWDihTai3NSSR5YSeXZ67NOvxdZjCjL25PFIZSYvDlVp
         8ubr4Bb2yMD265vBuIMwI8eOLQ+zgwnord37wfcuW7lPWFeYa9VslT7+l2P3XYZwEHuy
         H+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769968263; x=1770573063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DDJEAOra13fhqSAyHSRmRMMglqt1FGPMQOen9Yczug8=;
        b=W0ybAoxB1EQfVyWWsqDKVcDfnLEpFralYsdtT5aPr2L3Amw+UsBnclOh2XV3c57eGp
         P1oQKDjdv4eszolci343FEQHykSPHf47oBwqacU+GFST8Ra1CyG2lCImYKGSWPg17Wct
         8IAlCMYNUNNcZ8eks9mlCt//Ui0lkLDoSvuVqixlGzrpDbsDL6cvrayGRFOzQXmoQgpT
         gIU76Py3MolkpgUJsLX6Gp0RTs5S2f+pVP2Pbv+Zu+Icv1XDNMcSMtBfc7NgEIZldk+4
         537++31O1BlNCJJETNfV2BXQ4x+e/VMw/Y4eU1kQehsrj6TWYsicQiTVfYw+cgFP3UQx
         t9xA==
X-Gm-Message-State: AOJu0Yzssz+wMZNMozpQg1yrqDLc3uTCaZlG9QxBNFsQ7VA+fx2p+Q3V
	aIeNbUFiGZRLVhoUCP4QR7JqGwKi+eA0DnRN7oZxUfl2UM6eqcnuF9E4jJC8Nw==
X-Gm-Gg: AZuq6aIySQktIIilDFQQRsRutoh8+gmUKESjM7W7I9DAZkTZUFJyuQxAqfC/qNbYYYW
	Bt6PDQ2fKxjhzF1Jf6fbHo2bhmkMmaPAf7dtQt2XRbx+muA5DhWKkZJ0dZUj+8JKfI9b6FYrLlz
	UQLtyqaM8DBeL3VXfmP03EjRMoWlI0In2QGeO4ZDxhFNIRB5a9BtlX0Dq4rNebU8WWklisgp59y
	Fw8iOlmHv86cuQVnzPVYM016LgQMaIaWrpH1FXkHdvMs2snNsfgSRoCCep7bYcOGmXh8yNv7wo3
	eHm48yAH41+5e80Dq/ULeIozG8sSPCJXDJJb0cngsfLTE8s2itKg/v9abl+ILd2oBgo/m8WIVIm
	9B1c1fHRQPNnk2oJ4v9tQARuADvO0IXxjO49XNoLIcSqMp9oo/z8jEouPsOj7iFRFAkm4kAM6Ue
	ts3hDWQZrPWIlR
X-Received: by 2002:a17:903:2796:b0:2a7:3daa:583f with SMTP id d9443c01a7336-2a8d9593415mr60544755ad.2.1769968262709;
        Sun, 01 Feb 2026 09:51:02 -0800 (PST)
Received: from localhost ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d99eesm122897775ad.78.2026.02.01.09.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:51:02 -0800 (PST)
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
Subject: [PATCH bpf-next v5 09/16] bpf: Prepare for bpf_selem_unlink_nofail()
Date: Sun,  1 Feb 2026 09:50:42 -0800
Message-ID: <20260201175050.468601-10-ameryhung@gmail.com>
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

The next patch will introduce bpf_selem_unlink_nofail() to handle
rqspinlock errors. bpf_selem_unlink_nofail() will allow an selem to be
partially unlinked from map or local storage. Save memory allocation
method in selem so that later an selem can be correctly freed even when
SDATA(selem)->smap is init to NULL.

In addition, keep track of memory charge to the owner in local storage
so that later bpf_selem_unlink_nofail() can return the correct memory
charge to the owner. Updating selems_size is protected by
local_storage->lock.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  4 +++-
 kernel/bpf/bpf_local_storage.c    | 10 +++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index fba3354988d3..6fb02ffdb8aa 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -80,7 +80,8 @@ struct bpf_local_storage_elem {
 						 * after raw_spin_unlock
 						 */
 	};
-	/* 8 bytes hole */
+	bool use_kmalloc_nolock;
+	/* 7 bytes hole */
 	/* The data is stored in another cacheline to minimize
 	 * the number of cachelines access during a cache hit.
 	 */
@@ -96,6 +97,7 @@ struct bpf_local_storage {
 				 */
 	struct rcu_head rcu;
 	rqspinlock_t lock;	/* Protect adding/removing from the "list" */
+	u64 selems_size;	/* Total selem size. Protected by "lock" */
 	bool use_kmalloc_nolock;
 };
 
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 3735f79a7b55..0b8d7eaa2f92 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -85,6 +85,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 
 	if (selem) {
 		RCU_INIT_POINTER(SDATA(selem)->smap, smap);
+		selem->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 
 		if (value) {
 			/* No need to call check_and_init_map_value as memory is zero init */
@@ -214,7 +215,7 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 
-	if (!smap->use_kmalloc_nolock) {
+	if (!selem->use_kmalloc_nolock) {
 		/*
 		 * No uptr will be unpin even when reuse_now == false since uptr
 		 * is only supported in task local storage, where
@@ -305,12 +306,19 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 	if (rcu_access_pointer(local_storage->smap) == smap)
 		RCU_INIT_POINTER(local_storage->smap, NULL);
 
+	local_storage->selems_size -= smap->elem_size;
+
 	return free_local_storage;
 }
 
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 				   struct bpf_local_storage_elem *selem)
 {
+	struct bpf_local_storage_map *smap;
+
+	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
+	local_storage->selems_size += smap->elem_size;
+
 	RCU_INIT_POINTER(selem->local_storage, local_storage);
 	hlist_add_head_rcu(&selem->snode, &local_storage->list);
 }
-- 
2.47.3

