Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBB936F42D
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200319; cv=none; b=iHzqRpp9tO2zaEj5kH/BIRsIxnnax5zyXN3Vl4EwOWX/8jToQdXsF1ht7qROxzxXZW+LkQgIwsIUCPQrBGSHyyLxXWuAB3QI8yzmDJ0SIedibyyNR9kKpSBa4K254YQ+5IIJ9dw8/7wYE4Ny2Vg+OfuRBqQcj2XMETcOBOyiGxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200319; c=relaxed/simple;
	bh=Er/uTSUJqJwQFr/bT7JAFBRgV8FEqRpD4CpEtcK6xpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWeaYfxdgoAfpKR/pUJ3gLZ/A2H2VX86Jdkv5kqoBWM62NMMuJyk3kL5W43lO1yFk/vX0WpY8AjpqcowS3Sz+KPfs1It+NuNTJPrGc5zUxxnVNS2/UluQ3fjsMoEOiNjF+NthZrIm/YFMW8fqFBqdhHU4WP9M4rKqmQagXJtpM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjYBLN+I; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjYBLN+I"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2db80fcdf8bso2426505ad.2
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200318; x=1792805118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iELm3bTnzk4B+pnNJ4263DpWkNBrv9oDYGlQ98xR3Ik=;
        b=MjYBLN+ITE+H5g6nxeJBu5ND9DRTEm4TnFJBw6FbqgdfGLFhBgfip3QQO30jUTi0KE
         BoV86dqnENLcU/YC3gNHYZ0yv2pNdS4bNI0Vz2BE1UjaBvECrgcqFXMULtok8pZeEnmi
         uxsGFKCiijrCGAIKrSSZL6jsKleBIe8L23Scoll6zaNb5rVZrFL+Jx2qeCj9clKjcEWp
         WV+51rLTPNaQXptxJqR0VcqIhEUgrHSL3IPGCBHKplyPz8mlXAxPI93ou0vaNkKeSzuH
         p5ppPs8MsF3wOyCUOENCqVuJIq/BHQ6sNlOMghticMhAjkAxszpUpd+m3BTFp4WdCgrv
         Pjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200318; x=1792805118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iELm3bTnzk4B+pnNJ4263DpWkNBrv9oDYGlQ98xR3Ik=;
        b=s/ncgh2GgfGUpDAx3OQQfhyJML4p/lGlTaFAOHZy6Nl9LuXLZ7ke6tSLDwF3OPro89
         VsyNb0awuQ4fzCaHhn1O/HBYWZZzAmG2SQkm/ezvmqu5aiCChb7avBZXlPqHuBqTJcDp
         wJLdJF4AFFmBJFHp5JhZrsjbxX9mWOIntP3l7YtXzY4DVCTZO1Enq+Ac4OAQ/cG4uP2D
         yVsc4NDmhMHCXR6oIVrQokCWIIYc8GLG0Jr3CvsMPHcWCwMPptrgxCr5x0QpCS8c8uwq
         6CeMrNdS2fmh/vJMp5mnd1oczIYNUQmQTwJEZSwpXCPfJ2shyAi/E6VrDkI4OuVptFbm
         8ewA==
X-Gm-Message-State: AFq9FYIWAfT7KCJbegwlffW6nLspqy+AyDcNHct6xwRvTh7VM5ucyxMk
	nB6YQVWtutkjaAdXQQ2QIYOqICenzb6vsqYVFx0qESo/cZIn6OFx7GBsR3wxpQSR
X-Gm-Gg: AYBFou07268Bqs5UjpKYAvI6K0nFmJetQKM3QEz7j/FBjTwNON4NXBWsjCXitfw4V6M
	HLBBieWDYjmhE169bO+VNKGYsfx2SCe5z62bNHHYIJZu1yS/zuHEqmyNCS1biSKCWj+17aQTwVE
	6KeDZ5amosn90AFb+Jt9yWsF+fsCMYuhqMTADqL0DEq0Tm2FyEfmjI9tmtYu6MZKZMWetbzRjZh
	cMqG8WYspRA2urJcXfkuL8j55wFtRyrP1GuC4EBwkatxJxf+HxNvRAbvvmtd4vI8q0U3dzm613n
	zp0c9hb0+mjejILut63Bkk8EWRKE2xtOhe1GBItTiB35kZKmDlC5V3/zWhTV9+vDDbVSIqtRjba
	rAx1NCFQIKwZu5KrR3mAsvDUdS9w61k2rZz7WRyie5CMKANVB1UIrNHJozYLm3n9jiN4yffUgJR
	8OSQex3bjtF54M1rC/Z09Dti376PEU2C8XA9YpEzlVuvt+tFTfmjFiarckgJc9UBhBud0lkkuPF
	39MXpKDFsqi7RBxLjwObI61hJr4HyiBEpGENFaE5uZaDAhEgE+GpSb5XidiikmCHIz5S+r0DnK4
	b6b7Q9jwI4Mafu5RfeHZS3V0tFORSS9B1Pg+5Hx75/M=
X-Received: by 2002:a17:902:f70f:b0:2e9:5829:9b3b with SMTP id d9443c01a7336-2e9a6d36836mr13212965ad.35.1792200317544;
        Fri, 16 Oct 2026 18:25:17 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804ea9sm16928105ad.13.2026.10.16.18.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:25:16 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 10/38] bpf: Don't saturate owner_refcnt on the last unpin
Date: Sat, 17 Oct 2026 01:24:23 +0000
Message-ID: <20261017012451.364800-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

bpf_local_storage_map_free() pins the owner with refcount_inc_not_zero()
while it uncharges an element.  The pin counts when
bpf_local_storage_destroy() could not get local_storage->lock: destroy()
then goes on, drops the owner's reference and spins until the count is
zero.  So the pin is the last reference whenever it is needed, and
refcount_dec() takes that for a bug: it warns "decrement hit 0; leaking
memory" and saturates the count.  Unless destroy() happens to read the
count between the two stores it spins for ever, under rcu_read_lock().

Drop the pin with refcount_dec_and_test().

Fixes: 5d800f87d0a5 ("bpf: Support lockless unlink when freeing map or local storage")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_local_storage.h | 13 +++++++++++++
 kernel/bpf/bpf_local_storage.c    |  6 +++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 9e4f5c45c974..6c643ac51079 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -104,6 +104,19 @@ struct bpf_local_storage {
 	refcount_t owner_refcnt;/* Used to pin owner when map_free is uncharging */
 };
 
+/*
+ * Drop a reference got by refcount_inc_not_zero(&local_storage->owner_refcnt).
+ * bpf_local_storage_destroy() may have dropped the owner's reference meanwhile
+ * and wait for the count to reach zero, so this one can be the last.
+ */
+static inline void
+bpf_local_storage_unpin_owner(struct bpf_local_storage *local_storage)
+{
+	bool last __maybe_unused;
+
+	last = refcount_dec_and_test(&local_storage->owner_refcnt);
+}
+
 /* U16_MAX is much more than enough for sk local storage
  * considering a tcp_sock is ~2k.
  */
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 4642da062f0f..7721834e4bff 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -199,7 +199,7 @@ static void bpf_selem_unlink_storage_nolock_misc(struct bpf_local_storage_elem *
 	}
 
 	if (pin_owner)
-		refcount_dec(&local_storage->owner_refcnt);
+		bpf_local_storage_unpin_owner(local_storage);
 }
 
 /* local_storage->lock must be held and selem->local_storage == local_storage.
@@ -753,8 +753,8 @@ u32 bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 		while (refcount_read(&local_storage->owner_refcnt))
 			cpu_relax();
 		/*
-		 * Paired with refcount_dec() in bpf_selem_unlink_nofail()
-		 * to make sure destroy() sees the correct local_storage->mem_charge.
+		 * Paired with bpf_local_storage_unpin_owner() to make sure
+		 * destroy() sees the correct local_storage->mem_charge.
 		 */
 		smp_mb();
 	}
-- 
2.55.0

