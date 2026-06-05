Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F813FCB3E
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684558; cv=none; b=S8dtNV1T78C/alTTBoPSe0uYetAxNZcU9ndIygYqZ/JvJu/qTDiOsyxsd3cT9Y30XfFTwbkrssto5U584n61DLzxX8+PfFyMC8vvGnphXu8tU3AsNGOuy+uoATiQynOR8maVDd+kMkh9KG8nWw4+AxsGXIA/sGjCqm8J2uyWxbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684558; c=relaxed/simple;
	bh=qV4hSRgYCAlZ/cX5eOLisIxPMgz7Jx59zHgWJ0fU8Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qN87ZuJbKTNCoCtx64ZKjWGL7Qz4Uc0yq6/PTp01XzaNl6LRo9TqmOvxAjiiH4M1ttvnjS7w52NnEN5749n+sEJ54NkHD9u4i/iEIAdABZmtj1U9B+tfSblOjSN6GbeSOtg6TQSVyvnDo45DVWsjjTtFPRyVpKO4PDuPy+HKGaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWjgTfNA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWjgTfNA"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf3781ca51so23492875ad.0
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 11:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780684556; x=1781289356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vd7mNB6n7oWwOEumxuPNE7buAh5DJvMLtPzxh9rFWLE=;
        b=nWjgTfNAYOxBscmkX8lS3VvhPsTJfZVyKbOgVo+rIXN0NIOtNDYh9G4pBRjm4azDR9
         zGGLmPfaJlS470uE1YFTy4IIBDxPNY6SHPwtFp00JEtQazDD8V2HqaKK1+Qd0Th0g5fs
         2STNu9B18av6EyDY6/t/cv8PSzzKbxF7Rf0uMy4srintEOOZUU/fvdULES2JxbwO33OV
         r1ftOaSl3P6ANb6eQZl5EMQaAfUkjoIuPGTZnXDYTCQge+e0KmVciFyhfFaK2rsHhCXZ
         LmVT2wZhLGOFYMHxE5jmzdY6YV656t5c1Oua665DnN/VRnMXjQ8m60zqM+OQyII51a0a
         qmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684556; x=1781289356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vd7mNB6n7oWwOEumxuPNE7buAh5DJvMLtPzxh9rFWLE=;
        b=HDdM53LnmUl5a5hZcZmDzlZQLLQuRh07gF4nZlvyiIP+aPXP4K0XYwwOBUJjhRMmDe
         y3TXxJbFhfwF52vOzPUDcnOhbmBZqM4fPmL9pUnIoCo4CNUnATVAsf2B83PNDMxzkIN9
         ZM8GRGBLRElr/7vyYfeRKTGemWcYdP5eUhCILNcQjT0KSgPPBosMFNxucmX9crWDjLUv
         JmbkWyUfw6BlPzJh6TD9BvLibhrnDy2746r9RkFIIv4sKurN+7aR/FFuEWVKkJ5N6E3A
         zLbh3Is8sbhBrtFdXuns2KGEigmuwzy5owr7u3JO/WL4vdlMeyPqsm32tvwbZRQYCeQg
         ioYA==
X-Gm-Message-State: AOJu0YyidNQGbNRcDG0fMOj16HFWXcpiURnx5pIQgureu6+9Ja7cDIPe
	B1ocA2GCVwLX1uFSepcKIM98V7GFOWOxGQdVQXnkg2CnP2ZMvWbO7hsRabDfsQ==
X-Gm-Gg: Acq92OHrdfcla1Yj0bHG0hJla0qMEtyWthCA/Ln0CjibThXhYBrQK7gyCM7PSiMg/EV
	0QQCgMJZ/+MyI3c+WMrInocdCJxwaUWaj3g7WlAUG46RCCvtdvnXdYHsHuXkTXol3dqWCvP9qeu
	mBSUZyEhJKlIOyINv7RXW60uZduZj16I6pAk0gJxtm0GogFFBTzSXB8br417GrQi6ksLtICJZ64
	ljp8u35nTrezoFFAkhzufheqm6wRUJj4buSW2sizFs+EYeFv65Mirr1Ux4oo55NwYT2nC1nO4Se
	+N4/5HGNIyrswY5yhl5HdMww4bdiTQP5HZFjWR60YPbEsCqUtTUAflCYjj/9Q/uffWs9RKi78Kc
	FLJd73jQisw2ruHr24kR2L+34FQqwgXr4rmYfWpF2t3WdCN5re5x+Lk6oMQ+tYxvnvx0+9VA1wB
	x/ENdc3NG3qqFCsZO+vGciGdw=
X-Received: by 2002:a17:902:ce8f:b0:2c1:f262:4962 with SMTP id d9443c01a7336-2c1f2624b85mr37613955ad.20.1780684556576;
        Fri, 05 Jun 2026 11:35:56 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e2d7sm100260565ad.39.2026.06.05.11.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:35:56 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 4/5] bpf: Remove WARN_ON_ONCE in check_ids()
Date: Fri,  5 Jun 2026 11:35:50 -0700
Message-ID: <20260605183551.969144-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605183551.969144-1-ameryhung@gmail.com>
References: <20260605183551.969144-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_ids() warned when it ran out of idmap slots, assuming this was
impossible because the slots are bounded by the number of registers and
stack slots. That assumption no longer holds: referenced dynptrs acquire
an intermediate reference that lives in refs[] but is not backed by any
register or stack slot [0], so a program can accumulate more reference
ids than the idmap can hold and exhaust it.

Exhaustion is fine for verification correctness. check_ids() already
returns false, which makes the states compare as not equivalent and
prevents unsound pruning. The only effect of the WARN_ON_ONCE() is log
noise, or a panic under panic_on_warn. Drop the warning and keep
returning false.

[0] 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/states.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 06d9ae24f006..32f346ce3ffc 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -343,8 +343,12 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 		return true;
 	}
 
-	/* We ran out of idmap slots, which should be impossible */
-	WARN_ON_ONCE(1);
+	/*
+	 * idmap slots are bounded by the number of registers and stack slots.
+	 * Since referenced dynptrs acquire intermediate references that do
+	 * not live in either, so the map can be exhausted. Since it is unlikely,
+	 * fail the verification by treating the states as not equivalent.
+	 */
 	return false;
 }
 
-- 
2.53.0-Meta

