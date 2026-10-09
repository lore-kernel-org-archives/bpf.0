Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996AE4746A5
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542939; cv=none; b=VB9ZFbGBGjBSQ4GhKC+YTp39KUjYB2e2zEy98e/HbAHbxLdKA3vOTyJ+j6ldnGoS7wBHoWCidaegcVr1KHWcWkTGgmZv6r0XKe+jOJHLiwrKdRacWuRU2WJCtFM/b/w6RwTY1zEKCOj0EFXafF7kpTH7Wdzc9xC7KvuMRWVoZcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542939; c=relaxed/simple;
	bh=5nL+5NOHWDoLpB1U0/nGcg6BKVvXft4dcZaYD2sk+HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7Y0sTbkgugz5lijesLgabLsruafurKiT0eRIvxAB1EQhUchtNpNu2c6sfzSsC/+VToZQj8+Ya/WMczrRJKxifwyIL/n5WXeTWIwVMfNHQc3Lu0zXeAokAVqEPZDF4ttnB40ShlkJsfKsooTAz61xTlvBvxBnyTDReYMubgOVUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKNkFSR+; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKNkFSR+"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so120561a91.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542927; x=1792147727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bPcWjW8SfitsvQJAv0HnXXadXcqaOEEt3i9T9NXuSrs=;
        b=CKNkFSR+HB0H3L0sMmVAeCbr6EkzZZCKeEmHpwvCqWoIMipWs9nduBQtAsRd5Vhndc
         PPN2QFUGvMlGidjMW/XJ7yx2YSzxt4BIb1YZs/mlVXCwHETa7Bm8bqlrMXa4rVW3sOku
         tOdPXyPTkGxqF/kdFwt7UvUZUYQiKhuKZopthswJEbjgcM8HYCV8+231UIUf+bhqrcwy
         XRg4VFa7xIKqH9fvfEZBqfNnawH8CZlnQYh1Qvh9Rmmu5+PA9wjE+gFfZus7A8xq3uIs
         2ZTze2YFDqHDGIrgWKJV/lhK96vQPPWGJjwaFl6Bm8aS4Rq1JO5fP1SEp08sQNGsGz2c
         5n7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542927; x=1792147727;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bPcWjW8SfitsvQJAv0HnXXadXcqaOEEt3i9T9NXuSrs=;
        b=KTvmyhkcZD3jFFbdDbVR0P2ORR9EBDH3Ll3JvSZ4L5MvqK2Z2buYgxwEdXo1dBEHRh
         L7E39XXMByc3VqGaTctMA9JpgUttxus8wuhGD3bSSBNT7oWwNCPrmExH7l5IfDA1xdHu
         y67P3OsKbb2cxf4uAJQqOGGSuoJoIGhhVmLXd9YCo/uUZLEWmkZ+b1pXwPFuSnrSxLfh
         alvfcVJp1YDNjDS2O17gOiiFM1MRwoDHz0v6TbmZ1q032equ+e5B3JXt7sdwrp8odHfV
         Hk+Q+2lo99k1fF9kQN59xVzoeZrqWMVywIxR/MxtVyJkr0svZiey33UmJZhV4jz8RHqu
         5bCg==
X-Gm-Message-State: AFq9FYJWSwz21F2Bg5x2hfZrGhqNdj8pk3H3tgqVe7MYBI+e21Esm0AK
	n+DHlcKZoy569MHmh+QPn9uwenzXG3Ne8C1HWI7L9nM1lFWX9ugNEz2V8vqcvJlh
X-Gm-Gg: AYBFou2CrOVxKjgqHfphGvcT6Sy5JTe0fM87aLdmHYpzBQchyAexiz6vOxRaprBJXjA
	m+9i9g+fys42n32YK0Z2lgWOeC6i6CpGdg8lB9Tk8qvjxp5JvBSVHE1d/ejCGkmsWb7nWp+oQLo
	daGUn7yGxFY0+UGCv8Ykf9+m8DDI7JQNidKUuSfr20JdPnGa8rQKSIwWxYF5Asvt/iH+CdegKfq
	n/OqPCqtSYaJt/uHX2+2787zWdkqmIjSpqIuOufB9qXmSKgaWq3fn6enjGCnKWb+UlMEsx3pyxz
	rYbkF3/dbcp4XxGzXy9zfZsFokHpLjH49dFIOCg883WPNtOmnFipyfyk3Wyz4ZYFtI0t4svzuA5
	LWIRTuFWHtSf0X5+1Pi7xt6NX6p2y13nzV42foUTZyjGx38ZXcd4Cz9hsMb9xxaDrvhiKrnJSno
	/giBrDGsxstk+5YLEsU84c+kCLOg7ry1eviquRrqrflix2tQzffRdye1HxcwEkB0+pMyXok/jYv
	91eB3SVXZcbEw8=
X-Received: by 2002:a17:90b:1dc1:b0:3aa:f4af:1e14 with SMTP id 98e67ed59e1d1-3ab3ac7eeb8mr1460781a91.51.1791542926757;
        Fri, 09 Oct 2026 03:48:46 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:46 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 36/51] bpf: bpf_func_state size optimization
Date: Fri,  9 Oct 2026 03:47:54 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-36-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Pack bpf_reg_state to bring it's size from 88 bytes to 80.
Consequently, bpf_func_state changes from 1048 to 960.
Thus bpf_func_state moves from 2K to 1K allocator bucket.
1K bucket is the one it fit before the SCEV series.

With this optimization SCEV increases memory consumption on a subset
of Meta internal programs by 3%, without this optimization the
increase is 48%.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 4 ++--
 kernel/bpf/states.c          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 308e779c3f74..54cb6d3d0653 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -184,9 +184,9 @@ struct bpf_reg_state {
 	 * other registers. Kept outside the metadata union for ID remapping
 	 * during state comparisons.
 	 */
-	u32 map_uid;
+	u32 map_uid:31;
 	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
-	bool precise;
+	u32 precise:1;
 };
 
 static inline s64 reg_smin(const struct bpf_reg_state *reg)
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index c62ea992967b..953700822fa7 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -1171,7 +1171,7 @@ static bool states_maybe_looping(struct bpf_verifier_state *old,
 	fcur = cur->frame[fr];
 	for (i = 0; i < MAX_BPF_REG; i++)
 		if (memcmp(&fold->regs[i], &fcur->regs[i],
-			   offsetof(struct bpf_reg_state, precise)))
+			   offsetofend(struct bpf_reg_state, step)))
 			return false;
 	return true;
 }

-- 
2.53.0
