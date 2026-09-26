Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED0B4779A1
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432461; cv=none; b=qOTYxPEQGGTcgt1Y+s5kQq4KTk6k/VclOOGb7mJhaHPWopmMbxuwOBYWGBauTf5Ygrci+VhIpqupVjYo0mKhi9O5afuTKsaYjJhfgEM5W3EpfScJyejBe49c5aS0NzglTC7TSuoSWpEQt7QtTG7+R4dAOstOtYr9RZXjraho0X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432461; c=relaxed/simple;
	bh=Ym7BOJk9mWhBKSd8UHcQwBtSqkYLu5Z1taP012N5+/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AiUfle5c5vPgGTMBNF3WVecufItt5xxiObnWp+mDnZr9F1+ivYQamgxafuzMVD5sh51DpGLZMKKcytms05d+I3RRA3mA+Mxu03KhIVyF7EUEm4wrj802///z/Dw5UB/i80HLys97nanTvO27Twtu9uxZzrDWq4RzbLxxLG/5tUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nh1+5DQ8; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nh1+5DQ8"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d747ec6188so7728235ad.3
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432459; x=1791037259; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/uS+GgKTIqeWFhR6JrnM+J6p//ApfuUO9o+kmgEqHnA=;
        b=nh1+5DQ87YKfWFiXvvEAhCVp9/Iip4xi7M9CnsrZxV3TAmpEWZ1e4llTL/yX7nijk7
         sjCLP/NmfYm6b7HNoNurdRTwE4ckG893x6iHf8F7gwbRFxM1nhg7XOY9et0QLTojPobL
         Dmz9ej5hiMKapB32p0/5J2b0VYUDhkd4389gJ+BzQuSbOV9GfZOarnWAj76duYbmvtuL
         LBIAwIF1XRSDXX04e8UcvZluIYdEHz+iBWmhHbk2B1j3T3G51f6OtlL8Fi10Lh74hLPo
         SVuMPBypm/kaZ2IFJTrBasjxfPUrjIlptUD+6+G9NWEQ2nDDjgWsg0em7+pmnsZjIU4H
         KmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432459; x=1791037259;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/uS+GgKTIqeWFhR6JrnM+J6p//ApfuUO9o+kmgEqHnA=;
        b=xFu9bmOlwlofydj3SQbPmOwR5xGx7Z68AFAimoYYYR1gQnPLWc4tNDB8H+Ky95Jm9t
         mz9YSNH6/+PiBsaOyuwarxLD4zlupscVdSbUBBvk/FLDBbBusAHfa3+bt+MYDqcnQ3b5
         MJsGje9h34vlyP46UxZEBQ0SUELJLgtdPoiY76c7RWjh3jVvDA3XflXk/Da8h/LcBowy
         ydjdiARO+1EkzxO9WyvkfDHlqvQ6HKhWyEsoI11UEJwabljcuDkoUjI33hKmSCsOTt+D
         W/OJzUzXjARNfrcd9sztLUVPJVW085JEKM/3X3JJI18MQUOvH0T/bw2F8EeaLN/Ay+5q
         gyAQ==
X-Gm-Message-State: AFq9FYKRCRnoLHCJx/ZZ4HK8odPTFmsAvY9zfbWfBEQL5WvVXqN7Lu4G
	ovOagOf/kw6Q1n9dCqlYjdHBGy29sVbh6mINWiA8NJyN5T7CrKMGlcVarES+/RodDUc=
X-Gm-Gg: AYBFou1FhAyKUHG97Lz1VoE0OTlSZZc0mc1AqUIUXW0V19mAXTiH9+QWlP9Ytl0B8v/
	1yKuJU8RChgZczcCm9kP2cCxH4aG00OQGJkVZWyD6SFJCyP1rV91CbHAYygJPmMyBi3CJ5eFuv9
	mrTjgg4iN+wU+YhxB6KHZkM9eDwZLiYz0SOZLbiARH9WtAb5ES9aKiXDkN5LBQ7o55a56Yuy/XU
	URVG+amTiiC93u6RXJTlI7+6MsaxCPMsKNQrc1uYUaS4gW7YV23Tt0sqD7B7y42OcX/glp2CuGf
	0/c8Tz0hEHYDyB9fV9Yu3yt6435f27FOmB3CN+tEKQG3CKYgAOhNbJajaOOY2IqJUZab7oQuG6g
	WnJYXqm6o540sRDJVafSiqrdeUDdiKrUZpd4Aq0oN45uprY3pskK6tjn0Mquu9CA46tsR4Et5ID
	+xt8zmTgwvL6L8/4G/Alim8RVlx6aMuuU0cq7XWHJBUZVxOPLI5MAk2dF2nFmciKJf3wrcX9fAH
	kILkEuz/CFOaW/in4hN63I3qxnVsXgvMriPm9ie1snE5xkyuQHF
X-Received: by 2002:a17:90b:540f:b0:39e:4c80:f67e with SMTP id 98e67ed59e1d1-3a098980913mr7369205a91.29.1790432459084;
        Sat, 26 Sep 2026 07:20:59 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:20:58 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 13/36] bpf: allow subrange relations for PTR_TO_STACK in regsafe()
Date: Sat, 26 Sep 2026 07:20:11 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-13-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

regsafe() currently requires an exact match for PTR_TO_STACK registers.
This prevents an explored state from pruning a current state whose
variable-offset range is a subset of the explored range.

This change allows a checkpoint containing a widened stack pointer to
cover narrower offsets reached on subsequent loop iterations,
for example [-56, -8] within [-64, -8].

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/states.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 18bf7b660c2f..29d18520d27c 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -644,7 +644,12 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		return range_within(rold, rcur) &&
 		       tnum_in(rold->var_off, rcur->var_off);
 	case PTR_TO_STACK:
-		return regs_exact(rold, rcur, idmap);
+		return memcmp(rold, rcur, offsetof(struct bpf_reg_state, var_off)) == 0 &&
+		       range_within(rold, rcur) &&
+		       tnum_in(rold->var_off, rcur->var_off) &&
+		       check_ids(rold->id, rcur->id, idmap) &&
+		       check_ids(rold->parent_id, rcur->parent_id, idmap) &&
+		       rold->frameno == rcur->frameno;
 	case PTR_TO_ARENA:
 		return true;
 	case PTR_TO_INSN:

-- 
2.55.0
