Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2107E3AD52F
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 06:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959095; cv=none; b=O80bMpsqjP+muf++Kc9hAKbrSGgdHMBPNo/3UcvrtypAXAQfKgdmNEwGnLmua9T0wf529IUq0Jjw94ULQyrPLpRgg5m4ElrLJULPl/GaonaDQNmMMkQf4JosgF4uVcWAucFJ6gnkYbhH4/lTAAiXOtUEE0Xa4iKAVegiBve+QOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959095; c=relaxed/simple;
	bh=tsMMirb7JbAJEgD7k70v5m6p1jqBGk/zpTW9Tx71BL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRA3dzzdCyQPUUQ9huzsWufA7/FgWdw3MWCAZyPP+FkrviDQy63wrXbI8w6DL0GBrP8o3JWeHhTLG/OlbutdeTxF5CTqyWiTnxxfrMc5CWDJBEoUVMq72BwTbhUvJ+1auGMoW0WwZtHQyVZExdg8mIEiggevpC5GkYItEsOHcrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pq83fm0b; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pq83fm0b"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so25301a91.2
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 23:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791959093; x=1792563893; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G9iQZRfEjbzCYzqamIWO+RUX60Tw99oAAM6o1NtDjRI=;
        b=pq83fm0bTq+j/OBCz5U5TOWca4rh1UFqHS8RzkPJG40ovPAUnLqA4y45v5Qu8Vos87
         TtBtgUuu+lGIWB6O9+jwJiK/VDtiCwO/SNBLXJFR9yQ2QzDkIwAN/3gJa/YFXe8yV3CF
         153dH7Efvcmx704ebgxXNGYcSIFXkprDcon/O/dXvLNhADqZ8S2Qiroed3QZslzsUr1t
         JNiL/zw+hLBn4qZqmGqG9p7zKr23e/i3JiByOekSW8Z780RIXQRLMGvoPvFTgt4gpCN6
         wRhVF3ovEE2tJLvro/6+q3Vh+BFPQsS99TELLa/LnZVNYb0wuAkNE1i5D3eCFBu7/TAV
         2irg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791959093; x=1792563893;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G9iQZRfEjbzCYzqamIWO+RUX60Tw99oAAM6o1NtDjRI=;
        b=wdGLLDtyBGWbU1um+BwTNTkgaJPES2AYv1DOJsbQ1DjSbOOgVR8ZJ4X2mNMBeOKCpl
         zstbb2vX93bqcJJERymuQ53flC1PSx7EzZrVyN2OMdPBaTcQTd5leBSPb4reeyQjg8Cc
         KQZWDdky6Xv8SBnWqulbjqJ+PcsCpu9yQVCefTHeEH0l00WzCXNYzP0e7BBvzngw1x3m
         wymp8JXZWy7R3z0ZklTipuh2wpX3bX5DFqr8abVHWGCaRKgLtr847PCSrXjs+nJepRJB
         prDpvK/rIUCZ3ft38kkRDyY9WchI1vtL97MiGYJCDN4DljKIfPfG+q1GKBWayDcqKOVk
         emRA==
X-Gm-Message-State: AFq9FYKxG7SKja6wzOpHqbhclU2DpuQ6juIKiArwm3mQvIGYvPkjnOGc
	sS4cE0e+Jak/N0+L02kibs2fHlG4kvMHXD8niakM0vzM2w2nZat+CAgjz5cSKQ==
X-Gm-Gg: AYBFou1pc4AhWOuKl9iX/u4zIrdECbnlgQXO0VpEuOZpXTRdK7zlWsNqA9r+WhvQp8J
	Uajb6d6QmgUE3BEszTLmBoCcMuW5C34CVIKHV2dRMSORrmB2S2112Qjav73k5DQVn07+rGka3dT
	vM2mb1N2ARFyTsoAezkm1mr+o5NRx1MyPTBZI2jtNTz78ESJbdHTwk0RdCSvGzyvv8+W0NDaCKZ
	fiYzDJu/38cGVnh0QmTgis8mWQq6MWg7EoiYILXv6jfKOnO6yNyD/Pi8N8PbZei9hYnzafFDnI1
	edbYq4DmNwZLDjrZeDpYGRO+XJrpjRb+5bRenD7OmkBrtg9Li+kIwmp7Prnn1vq1AERfoPD/7g/
	v7nzGI4CqdTqBl5uX5PmeZKNN3bGgLynnIVSqXkv2ru/AfpV5xSB2N5ZI7UwKdQCH53uAjfqwez
	iA6d6cSVVW18RenxnOaMQqWX86bbH39x2ZLzosPD1WSX6ApBfzeZSWxITikzNZWW0wbvf2fW7bE
	ZHmIMQJg9TlYACA
X-Received: by 2002:a17:90b:3c04:b0:3a4:e9e4:37f9 with SMTP id 98e67ed59e1d1-3ab3ab219c3mr13127638a91.31.1791959093331;
        Tue, 13 Oct 2026 23:24:53 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e41126sm6614238a12.23.2026.10.13.23.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 23:24:53 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 3/7] bpf: reg_bounds_sync() comment fixup
Date: Tue, 13 Oct 2026 23:24:38 -0700
Message-ID: <20261013-scev-minimal-v3-followups-v2-3-6d9d61965486@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013-scev-minimal-v3-followups-v2-0-6d9d61965486@gmail.com>
References: <20261013-scev-minimal-v3-followups-v2-0-6d9d61965486@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Array traversal logic in btf_struct_access() starts from reg_smin().
Update comment to match the logic.

Fixes: 0892ef2a7ef3 ("bpf: Representation for intervals with steps")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e477ef4465d5..ec136cf377c1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2354,7 +2354,7 @@ static void reg_bounds_sync(struct bpf_reg_state *reg)
 	 * potentially w/o intersection, or intersecting after N
 	 * tnum_step()'s, where N can be large. On the other hand,
 	 * step+base *must* be in sync with r64 in order for
-	 * array traversal logic starting at reg_umin() to be sound.
+	 * array traversal logic starting at reg_smin() to be sound.
 	 * Hence, place this as a final step in the reg_bounds_sync().
 	 */
 	__update_bounds_from_step(reg);

-- 
2.53.0
