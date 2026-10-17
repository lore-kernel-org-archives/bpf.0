Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5D73AEB39
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255253; cv=none; b=ZqlFeOM78UZK61TqDeRbgJ8TbKU8ypRHXjeenp7gjHJjVB7mE1GtPaYUhVRC6jK6tUNDkedBOCJ77geyuImFV2p6E2msGY60WV3O5D7EJIlQ/KTJiMPiY9ik72kQaTn4CsPjCGw5LB6o/fEp3ioViCVKjfbtQScA8UPJhCRJdz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255253; c=relaxed/simple;
	bh=F5ypGhGrXQRgNzYcea3gh/x4wzaAQGoCt9O7XgC/S4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKsuz/ChmVlOAANNOcF82KdQo5vvgvgCkkpnkTSlsUb5b4Ou6iOa9B9TqDVSNR2v8t9Eh/b4lB/urevvkekNW+19DLviERptrzsI/TMsKeqLwRzgQF2mLilXBTo4WrsG/9R2i1tMFaE9dyJIAgXmCR5jV5peLigPXuS8abfCZDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VE8PiN9Z; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VE8PiN9Z"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3a4b3ac8fb7so461128a91.0
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255252; x=1792860052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ALCKFhZxfGRpc9XVHQleZRBKm41+pLgfZR8jRrV8E9k=;
        b=VE8PiN9ZYCVkozZ8YotWtrBhAsxdyoZJm6UOi0EaNNOZOiqXFasD7l/zOFH79iya2K
         SASfcADOGLPljlLfykpmMsRX91BFofWMnKerPy/M/n0YPxESP/uqNgihKWlcFw1/PW9M
         GO/LU9aklvEpZt7wfExTcrFLstlQ2w4z//xaKOLzuKy2c7t9jYnS6aT/m3Yvmq/Ae+iv
         VpVBXIOyHayb0xZiDqRKdS0s4Kz/CppYHz4FoLqDQFPvwKSYbVB7139ZEIHUsJs68Am5
         7tBOmrukhgASNxlLEkI0smxz/wAI8c4XrqNDGWVbfGW4mLClFrjKIIskPfyMl02zSfm2
         DwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255252; x=1792860052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ALCKFhZxfGRpc9XVHQleZRBKm41+pLgfZR8jRrV8E9k=;
        b=s9z5Ag6WrIJyXrbJfzswrULxyWQmtLRG6YbT58EuG9Tsnnn7FX1EO4vr/o2qSUdZMg
         v39FhrmQDFksnUn8dq3NyBXCKbR4zaR+uRJ9Q5Gf0CJLhMBQ2WCLhQgUquVLDrdZpfej
         VsCtZROa5sogm1JSiGLEaQOp2JTQ29ljgNrSZrIzsmQh2ni707XBta/KYpAFbcjXuGBV
         ya1gRWf394y68/C72hvCH0CMc9RCU+LI2poHTBNgOBlGo1Zr5ZKU/sjT8lqXIzhP3JC6
         brZOjGYev0BJZ5MMLRJH4SJ3HzIC+XpDgSFBRx1C0pL8d/oCUfsWEs2QGTYDFQHC3rxm
         3Nnw==
X-Gm-Message-State: AFq9FYLr2BgKjI9J/P1V9dBV/iWUzVXQLjmFRYeUz3m8BlqueXQVNciB
	ExdgcD1pq+L7nke2DFbEc+JBDAiavw1Jh3LYyvEyxkfuIWcflprkfK+DXnxuWQ==
X-Gm-Gg: AYBFou076z53sjOovFDpQjhSsHP7DNPuJB9vn26c2BHgspei4YzYj1zb4DdXoCBI5ZM
	mI9Q78dAmx5R5+sk2PR2m3rrxAVflGAa6mmmGUitNPtGrj04McuIGGAKMBJJYlGHzmsDti7PdHl
	izp2SM9yhfPGfYqTuo0amB7unr0FzQp5VeXdPKfc0etHQengx+rV4HIMXmggdAt0gwtPxk3wS5m
	aa4QN0QvX9lsxjPlzbijDzK9uVEor1pT2u2X0csxo2Lsnr2kmLjhZsI+TZ6Lk+GgRWdde4nbdJa
	X15BKZtRbCLkDFn9seJZ5odij7CAfUKpYG6RinL+QiDVffLF3/nuz7dT4y/5AdGzb/dXohH7mhi
	GU7755Som7BrdyQto298FhGkGrR7iePCIwTfFDrTU9hkiBtdN4+1fBzI5HKIZbrHciCcbZ6x5VB
	cYGd0g4umjR7x8fucCYGfiab/rLyvscEbcHfkwvRQaBzgHsh/hBwC+PTHv/TYGCSSvRkwslCGbD
	dA9VoT+/YDgamfxlVmphlIkXLoRpfS4fpt0O+80iYJD9iz+USFlqiG8FGu6ivoU3LKDUMzxT30w
	2wGKk22fVuP8LQEY+stBoByec/SU2+f/waJs7HCC3mc=
X-Received: by 2002:a17:90b:3851:b0:3a6:f1d2:57f8 with SMTP id 98e67ed59e1d1-3acee97a19emr2662478a91.2.1792255251564;
        Sat, 17 Oct 2026 09:40:51 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc46ee274sm8580182a91.4.2026.10.17.09.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:40:51 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 30/43] bpf: Free what map_free() unlinks for sleepable readers
Date: Sat, 17 Oct 2026 16:37:32 +0000
Message-ID: <20261017163745.3341787-31-alexei.starovoitov@gmail.com>
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

bpf_local_storage_map_free() takes the elements of the map off the lists
of their owners, which are alive, and frees them, and the storage of an
owner with its last element, behind a plain RCU grace period.  Nobody uses
the map any more, but the other maps of these owners are in use.  A
sleepable program calls the get and delete helpers under
rcu_read_lock_trace() only.  While it walks the list of an owner for its
own map, or is about to lock the storage, the element it stands on, or the
storage, can be freed under it.

Whatever else takes an element off the list of a live owner frees it
behind an RCU Tasks Trace grace period, which implies a plain one.  Do so
in bpf_local_storage_map_free() as well.  It waits for these callbacks
before it frees the map.

This does not help a sleepable program that hands an owner to the helpers
which nobody holds, and which may be gone by then.

Fixes: dcf456c9a095 ("bpf: Fix usage of trace RCU in local storage.")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/bpf_local_storage.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index c08afb33d038..49ea00c99390 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -431,13 +431,17 @@ static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
 	 * then freed after an RCU grace period. However, if destroy() and map_free() are
 	 * racing or rqspinlock returns errors in unlikely situations (unlink != 2), free
 	 * the selem only after both map_free() and destroy() see the selem.
+	 *
+	 * The owner that map_free() takes an selem from is alive: sleepable code, which
+	 * is in no RCU read side critical section, may be walking its list for another
+	 * map.
 	 */
 	if (unlink == 2 ||
 	    atomic_cmpxchg(&selem->state, SELEM_UNLINKED, SELEM_TOFREE) == SELEM_UNLINKED)
-		bpf_selem_free(selem, true);
+		bpf_selem_free(selem, !in_map_free);
 
 	if (free_storage)
-		bpf_local_storage_free(local_storage, true);
+		bpf_local_storage_free(local_storage, !in_map_free);
 }
 
 void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
-- 
2.55.0

