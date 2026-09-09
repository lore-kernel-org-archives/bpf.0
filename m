Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3343C1411
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982672; cv=none; b=t4VeNWj8Eh1LAKVFFrdTMHiQyVld+UqxzrxT5mQc0KMY5Cq166k40Im3bshv1Jm2hJaG4rbKe6LFnO0+DnNXaurhGdAKu2g4m8IrMfp7tz7yOAk3nuOsEMOf+2sfFErFWYPG9Xw+d3IpmjrlI3w+qBVa/hMPNWElHN9e5Z6WO3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982672; c=relaxed/simple;
	bh=9ahnDuIzIlnNHViEcr2anfgH+TEO7ySvpOYjKqJILUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DuH0VSvxGcrkcAz/HSsb+SkiBhvvXGTict88dI1FukD2qh1foG422hGvKMYJ/hXwqOlzUAuR0yXUmbJEVK6pgFIe4n5Y3gr++SNiUykk+VZGbnHN98L5mwng3LOCExW6LFmr+EvQ9zx6JrYIULCoA+6L6/Ld2GRzOaal124PuIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWbu7cXk; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWbu7cXk"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdcdso17937717b3.2
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 12:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788982669; x=1789587469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zGIeBhiHsvfHjC9J6yImwRdInjaib4hfso2CvsNy6M8=;
        b=WWbu7cXkrcGobKj5zzYgB5oAaJskFwXd6md+/DAJHpGInc6YsfE3nAJvoSN6Hql4S3
         IzQXFmiNoqM7zgbz0crOyLlQLW3cnwx7MUA/n+szUOfF4HELMt8AgjTsG31ZNUAfwCD6
         Ld5B70ZNcbk23GpaiFlBMnuteJ47EH6+t4NDYJXMe75jL1t6Z3Hzodpq5XZB36oqQiaq
         kMCKNvaKcIdLZcCDTe7WK02d7yIZ8nA9tvl7mR9pipuQCIPL/K0tsZgEav8NaX4N07Gh
         X2Lwwbspp/iqUDfdbJNOEuZHH7C6JSnvxuAdqNcI9Gl3tcxnvWmmlq1/iKd5ae9NuBtr
         ZcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982669; x=1789587469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zGIeBhiHsvfHjC9J6yImwRdInjaib4hfso2CvsNy6M8=;
        b=fDDB8HXYaS9EYFGrgJgMGPYj6hEyr+IGn3pIispkqU4D9bwi3hRpSpiynXYNqtRj/0
         aXNUGGsyxoCLzQNPaK9rAYMjRr09O7p2ECGfDUEyu+D65KORIJfdt+QleIRu94YKvimt
         CXkXVLdx5l6zQbdaRqw28U1mKUehVBKqW/GX0qN+JBorfk1x30xyWVH1Vnt6JyUisJg5
         iAWO/Qcw2I6EUMR21XsDQXjezqt3QCJlWr4g7houLv48K2YQ2wpDhOsVuWheWijKhRmU
         G8v2gQ9wAFIN89CJ1dXGOX9KQOXlGpgcAxBKT7ofkGVTHAGYwPKQJ1D546SqfHdeAV+p
         tuBw==
X-Forwarded-Encrypted: i=1; AKwUvByrydMeE5ZA1igM4RdpdsfnvwEGa0ax+yd193r791MJkXtJClOXdIROUBxBF84yGG+hAbQ=@vger.kernel.org
X-Gm-Message-State: AFuF++m7NoKhlidg55aY0GCzPGn8QiChZ4Kxc3uFRvMHINwTUuN8w7Ba
	VbhuXwcIQBdu6W2r/bZ1heVdgUsvI+7pLnFX1AqaMpQ+7Opa5OooxcBd
X-Gm-Gg: AYBFou2f9/vIsH0SirYM9H9mScKGyffF81MQVTX6S2J+uhawUAEUciHBEcYYF0awdQG
	ZPsfqAqgdBmf5LDkH4w8eB2VMl0X8FCyoiDTFyA+Pfekmt9AYCP1LvbAyQVSvpmT6PIpGmF2ExI
	Wzxg2y+4mz6SYMTef2TpxF1hvtXTu9o8/QTX7mxiIHAz/xpRdu0o5zY88qJ9/gajZDtnShQpEcg
	DyUrpD9ZXQYPdI+XNOuA33lsH2GdWpXofHfEu0ypBrG7gHdjLnY4MW8lEFp/l0GxCjutLYZD622
	dTL7GELCLSQ+QIbZYkqMGVFxSQ5sXUbwMMSvPNol4J3UW/P3fEdNe1QzcuuX9xndw9CgqsnKpw4
	y9zkwFc9bpKP4HUNCBwnzgJuixc8K9lWkQ5618h/AFi/zaNJN4HMaOZXmTlaPG3ZPsx3aNwizDL
	Iiz9gbDWxa1hx9Nh9ZQwZQsF0OqrQ+fQDem0X4/kqaxClgEABH/YeE//bZCpM16sQ3hqoKp5SRe
	N4XPPlJGc/c/YXqYtamXGXGOLg1uVCc
X-Received: by 2002:a05:690c:7091:b0:872:1e2e:b496 with SMTP id 00721157ae682-87f29821932mr39000317b3.31.1788982667401;
        Wed, 09 Sep 2026 12:37:47 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:bae:bfc2:7e96:e5c8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871493155d3sm115277577b3.16.2026.09.09.12.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:37:47 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: casey@schaufler-ca.com,
	gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	jolsa@kernel.org,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v3 03/15] lsm: Move the lsm_for_each_hook() macro to security/lsm.h
Date: Wed,  9 Sep 2026 15:37:06 -0400
Message-ID: <20260909193719.518517-4-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909193719.518517-1-utilityemal77@gmail.com>
References: <20260909193719.518517-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the lsm_for_each_hook() iterator from security/security.c to
security/lsm.h, verbatim: a following commit adds a user outside
security.c, the file implementing the LSM policy object kfuncs.
No functional change.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v2->v3:
        - No change.

 security/lsm.h      | 6 ++++++
 security/security.c | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/security/lsm.h b/security/lsm.h
index 32f808ad4335..264ae63290a8 100644
--- a/security/lsm.h
+++ b/security/lsm.h
@@ -24,6 +24,12 @@ extern bool lsm_debug;
 extern unsigned int lsm_active_cnt;
 extern const struct lsm_id *lsm_idlist[];
 
+/* Iterate over the active implementations of a given hook */
+#define lsm_for_each_hook(scall, NAME)					\
+	for (scall = static_calls_table.NAME;				\
+	     scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++)  \
+		if (static_key_enabled(&scall->active->key))
+
 /* LSM blob configuration */
 extern struct lsm_blob_sizes blob_sizes;
 
diff --git a/security/security.c b/security/security.c
index 2ee276ab15c5..74f98ef8025e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -495,11 +495,6 @@ OUT:									\
 	RC;								\
 })
 
-#define lsm_for_each_hook(scall, NAME)					\
-	for (scall = static_calls_table.NAME;				\
-	     scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++)  \
-		if (static_key_enabled(&scall->active->key))
-
 /* Security operations */
 
 /**
-- 
2.55.0

