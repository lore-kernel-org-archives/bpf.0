Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290F83AAF73
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255132; cv=none; b=ikUc3r7EGpJ1zKohvWIQuWWJJq+a0Czs2y77MPi9B4Sm8wOUHM+7KjNuwc5NFxcNsPfz4FP9PSJU/YZfk7x4OkUi8gHORUfto21ROvSJzXIqmExyZLJ3JJ43KYsW1BPsz9hb7ElneJUGuoRCCZwfWBsfPqm06b28Mg8cd7xdHsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255132; c=relaxed/simple;
	bh=Er/uTSUJqJwQFr/bT7JAFBRgV8FEqRpD4CpEtcK6xpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDQ+je3Mm8l3F6Sll4a7s5TNlIiFMw69n2969/zGs3N5k7/xWg2lRF5Wx9HJKHNFoz4YXVHGo7jiS+vxmYIXhKGvsAPqpIrKECVt8sPR7RC4KKZQVivicXjAnlQ13ywq2rLi4OCRO2JH4uYw68ceJxHCxSPDweKuxu+SSnbW81g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlzZiVuw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlzZiVuw"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e831e86ebfso3574645ad.1
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255130; x=1792859930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iELm3bTnzk4B+pnNJ4263DpWkNBrv9oDYGlQ98xR3Ik=;
        b=XlzZiVuwot0pavBETp1r2opExtv1Fq2MrPL23kQTvocuqrGJa08Cp0FmLnUJru5Jps
         Ht2iwYwKAqJE+0NBShaKeeAvSsQy/CE5cMNG6HycyfimTLaRtlVi1WYQpMVgpoc18WaT
         nxhqrZCKPLsUCgBo9bvunlkDOu1xiYCH7x/FYBQPHXaejT7inafNm55KfzRbYoeukZiN
         oOMnXd8c2y5HRGAQDtYgr+or5E19ZAF6O9Glvmn0ECq0ztq45I6Z+57P/lMx8YIOza6T
         pdVXeuTocbPd3B2SWKzUlpjhzZnPpLdKjfdZhKRYLrhmY24SuGb+WAoQXl6uhIdIrO5a
         9dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255130; x=1792859930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iELm3bTnzk4B+pnNJ4263DpWkNBrv9oDYGlQ98xR3Ik=;
        b=0NAzH1rKWBwWUF9YHHSHfcbsjiARR67InMCuavyvdYHD5YWS0OADtDMC5UouQBchKd
         gU2eLe0b8+i0kRqE0nlQ5T6PBRE9fwnCWNB2DQZRDGMreZ3GDcJoVOOA/d5CGKJqb8Zj
         EUBnPmPgyO+XgGt2dLot3nWvERf0tR0WMujHxsRC3RJe8vw8dcl1wlz5RoXS0yPb6AL/
         8sw+QGEYyjVNiQM/bePYakyjzdfITcs+HMcYuUEDVMu+1Qyy5QUk5+YWpQ4ou6/h6Lzv
         05ykdn7EHgA8Uex4MC1blb21sR5TgtP37bM3sD9fC42nTtorDjsljjuE+i69EGPjnupD
         Pq9A==
X-Gm-Message-State: AFq9FYLzc6pGVTdA2OMsfgJiZ2rBKx96n3fUXsh7qDfzCgqgz6worGF/
	hGHFOqLqChrnajsLYtV66ZmyXw/48xCtepk54zhsEek41jTvLGGPys0Uxqpnkg==
X-Gm-Gg: AYBFou1MZSa/CTxj9MvTZggZHINNF2+on/DUj0t/Y8Ogr2Qu8r/WA7DOjj460SoU/i7
	02eg5NR8BWifPNRfVRHQcicVaehYitPQa73cvcLGcweTX09RANRGD0TqT5Hm0Zrv65egerCZO+B
	cnu9yUBG0bE7x0fyWIOYs1aAOrAPe73UgjHV1JT10hrWPeQDJmgNaKgQePInRFMrKoo7CDvV+Z9
	WqFh/aI4nQPxL97GRvMF0buBe0hC8ZP2J2KhxYwjfZAQ9P1hbE/Rpr9vsW5TcPwAwcW091n8z19
	BzcUo1wk7V18wpGOwonLUizvDgf9dalQA2D2SbzinJzZmO+KavGIeMX/Lde14UD4QcMqmpeYsSo
	NjJGQL1AtRMXkkOjpS4Sc3yIdHkY53AkvUUWmVUk/9d6UjkJRZQni3SlAQLzuV3XbeUpSLzwkIJ
	nvko2Y3GA8G3JgPM1yHfsetV3kBhllttcrwgHSkaA6nuiTBy6b8chLxo2DDTD3wrR+GkOD1Z7MO
	cHa4ft2dJlA82Pw2jvuZER0pJnYKgn9wi8I8LsxEJzTgc2yMoDIRlraUXYkP80ZIkXFcPNZ4iN1
	Nanc0mh/S95TkuaJfd5vl1s5MqFwnCWltZ/SmQVnoeOaIyd9jJvpGA==
X-Received: by 2002:a17:902:e5c8:b0:2e9:3395:cca8 with SMTP id d9443c01a7336-2e9a6d242f4mr28899175ad.46.1792255130228;
        Sat, 17 Oct 2026 09:38:50 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8997edsm22734595ad.63.2026.10.17.09.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:38:49 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 10/43] bpf: Don't saturate owner_refcnt on the last unpin
Date: Sat, 17 Oct 2026 16:37:12 +0000
Message-ID: <20261017163745.3341787-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
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

