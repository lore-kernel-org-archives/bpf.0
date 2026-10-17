Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4262EEE8C
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200706; cv=none; b=Acva3XgRev5pUfNkpeJpT3ukcvvvb2lJljNG9B6/xaK5p2KdDyBnzz9Cw+49k3b01E0VVqAnUfX3Nxc6OAxDAaNpnclu9FZb3q6HPTEPR3gNsoM9Xs6JnlKCSZKPh8cRDcwJwpdsCs8USsXLuT900l/MLXgBI3I8TmNJdkEjkzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200706; c=relaxed/simple;
	bh=xHL80ZEn5PAxaypyWxZhEUPjys++jnkou+5URLONSTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OzSwK9M/gmRajnlXwlAwxZjnWyrXrWdqKiNL3CK3qFdqqkbaFisnd30T6UAxVgc+RGjdLn4h5fUBp08IWGfuvva+Gx+Fd0/Ene/9mC1qftKb5UMjXBNbuzrFXps870E1Y7KOr5uEaei+0xjJ1mtNbUR7IdwZSdUuWSVC9IC+qyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PS839tpC; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PS839tpC"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso271847a91.1
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200705; x=1792805505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ls4pTeNyhy+wNW5MbGiVA9pf5BYuGMXuZsBrKPxCtY0=;
        b=PS839tpCQ3njfSM0kSXPnOpEHV4SLW1usk2wsJSjz5EM7RNc9g80iM1uRitYgr7cy3
         aYnhOVke17eP/J/VtbOcXFcDzfLTEafiMJ4zhne7OqubW1+pMKuLWI431q/Skga4faRO
         f61cDf1w7sa8mrSK8YnmF8ag0AWqIXNSoGQOU/DrQggv2g3bKyM9aYC/3pjnS9X4z9oa
         VYZuL45JzAaBJ/cjN0qrjbxVeEufj6G0p2vrM8ipLaHMLIE2mz6N/d8UdqIXsTsF3jCf
         8Dtld27kyP+Xjy8/kEgjBKeEcO3DqpLTibjeOJg6yLRfjhKh5z0eiTjfLpLQJ+aXANEI
         N/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200705; x=1792805505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ls4pTeNyhy+wNW5MbGiVA9pf5BYuGMXuZsBrKPxCtY0=;
        b=Xkl9IQY8Ri9MSb28YQ9uO2248zv/lDLR08o+raPLkIUOAjlL2foeeAh6XSQoMV64MH
         V+nh1TNGoW8gcUSPfCV6bwPTNH4YFGgJ2z+m6tUDYeHyZA+38BhN5dBGFf2ZNWGkLlzh
         pj+KWv1RGgXoatyQo0cRCWZK/9YB7IE/rmmgAsBRsgGxgNE++DZNlRsj/IIFgyGLM8vQ
         WEMKlflkV4V+llug4XGUYp9rIfYny2VzsVZpAVejQmFgRT9bHmNG2P3xc5kE3+BEu2yQ
         d67stAhZiIEHnAraWzaWbPQrrfvEUjvl8EdJ7OZDUIT7Pvnu94fuK+vrX07M36dURtnW
         vIJg==
X-Gm-Message-State: AFq9FYJsj8jtHhshnpRF0gRXTW7+kYOH4O4vpfbvGP5+l0WY2bYYYSu9
	9DwNfGyX5W/iWdz0n/rbOc9N8SVUL+OLdu5p/9qfFLZD/5UgV3nodXey3dfPtztH
X-Gm-Gg: AYBFou2ws5Hnjd7Hw85xu7A09/OxxT2EnKa4D4MmWvRkThyqrmUVFHP81OgiRUVyLFx
	V89XMepCKaLjo09Q53UNYV27OzKXzGTxAeH/KL8fxypRzUPGjDi/oiTrLj1QYdhYBU/SJpm23iD
	AyAyX4wx07u8J/AsoUjWTxtlhVvZNgCiV/8A1H10JsZWWCUeSgYlvUc/OA+VVnOwmDvX4slDAul
	NBIpKHTHY2plGtIXxSvA7KejlAGGqvYBbNtfAt5jrLTdJHrxVaHDpVzlM7ZHPV2maTj4MoVXZ/P
	rWLW9vQDRNQ3IBY/4jN8KYhIG/CotoInCnW2jfrNwZgYZ2yU+X+VPbGr+S52jfXKv3/UoShMM4u
	7zLJ5kAP444Tp8HGI5ZrYYOnWJsMbofc63gM6nTaifKObfN66jZwpW3Mha49AlPhgij2cwBEmzD
	ht280e/U/sjLAL7lQyeaHjEwaujj5fzmHmQeitBGmroYhubnarH+n7dVSQd/aLxG7eK+wg+kTlP
	w9aixtosBPJem3DaAhJoGFFZbUtGrq7KF6xI7t9gd8wK5A13Q/6iX8Q15Yip3DMsbhZZiAGslyb
	bgTylmnW/qhPMdtyl7oVj8NKYSwuczfCC+9sf84gcCs=
X-Received: by 2002:a17:90a:c885:b0:3ac:9d14:feb1 with SMTP id 98e67ed59e1d1-3acef4e3427mr1246776a91.43.1792200704582;
        Fri, 16 Oct 2026 18:31:44 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc4872861sm6811277a91.7.2026.10.16.18.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:31:43 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 28/38] bpf: Free what map_free() unlinks for sleepable readers
Date: Sat, 17 Oct 2026 01:24:41 +0000
Message-ID: <20261017012451.364800-20-alexei.starovoitov@gmail.com>
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
index 7721834e4bff..f234f671e75f 100644
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

