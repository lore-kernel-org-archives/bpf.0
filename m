Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15E94A5ED4
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188395; cv=none; b=hN4Q4Ujp53DbBONa/KLcFphpqCTRCsoc/Q/Y0cpxb3zFlmVzp0DupjofAPndMHJ3xS/RNziIPHAxiroxvqN+LykMxwrJjkIhzoZO9NbWyF2+WHFCn9LxJhA9dxZ/KLfYYdB0ZWRRimnaMer+KpaqC1EciGe+fB3b7y+0yFjgPpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188395; c=relaxed/simple;
	bh=6UZqgo1pNVnRYUaLOBFpn2TGeofhqUttyRB0yoGXOFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaLLsK0n0EfVtxyjTgYt0tyoIugZDJdKl//vYiln0KjV9mOjxNSSCJRQGh3gcr48MxoSRKHFNS/me8D7jP6O+25lSuNICRdc3FdTjlfFZwVpUEa3cEKad2wlsdZSnRz8iDQqVYaDlpGf6swLViOIdjLdUq4Q0fPRph9+A6e1ECw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYkvfYRh; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYkvfYRh"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-865bdc6ed72so15669887b3.2
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 07:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788188392; x=1788793192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8vHIsNy/IN9t6970qY2+L8dSJ+0VAmbxT4VuLQXYbHc=;
        b=nYkvfYRh2kCVnaN0Tj2EhYB4/lWIH1hkSdlsFcbqjPxAEq5YMsvux0IdUOlHxORVhs
         OPs3zXVqr52d5DJJWQV/h/YDwG8JbGlo84KsmHEdYhfT8aRnxlKCATTYmLtY0PPyBFMX
         bDRFKFrunByFw4eiLcdi+Dtc0rIwgI7JDRAOt57HgFtVMiW1uwzxt0yHh1ysFckqKFeC
         Wx9K/9lPtaqDpXnkXMk6eTU70OnEU5y68Q2MGJGsPd53v5keBmKqsby9d9vyH4R3kW+J
         9VD4atWFGTx8rkwuin7omcU8cAbc19CluS1sDkXBGVopeKcIJ4TIvTWp+bVM6VvWfXaX
         S92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188392; x=1788793192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8vHIsNy/IN9t6970qY2+L8dSJ+0VAmbxT4VuLQXYbHc=;
        b=eMnVVDmNLOzY79tpxYlpaAs/LFpxViDTmGTIjcrOMc242dxog3is4BrYZbowxNKK3c
         dJ/xYxD+n+e3n1debQq+EtLQ6gZReznKGxyU3rBM0r+Ig9prRvtL7EyVyfWtPPqYw1s3
         tk+GF3yTReTkgDQmY7SICmZOdKJtpldrUqcTbiH086vKi4bJYMjZhE57bQ82EKaB4xnb
         GJEEul33V94X1p48w8IoLK82KCtEXeccTKkCwKqxzkAvgv53vXIzFr0wgQgGKR01j4DH
         D5inykybwYyoOVOB4a74beHg81nwoGlpPF08+ggnYj4OrU9jJUTD14w7Wom07iwRUPU5
         QOgw==
X-Forwarded-Encrypted: i=1; AKwUvByxEejHAGXR3pNKwkWXg5+uvvdQ6zShcmfSGjHUMrbUTh67v7GOlD7zh+0Kecy94IZgPjo=@vger.kernel.org
X-Gm-Message-State: AFuF++mToJruvBpvn4zMDm2urNmhw9E7ITpZK36a7Muzwrg83/NwUz56
	O8qyXsshUK6IAfTUr89IMP0z1jGHDccrWxEXT5b/23NEEcwB5O/McNK8
X-Gm-Gg: AYBFou3nvFKEcBSC68ROxWPwaOcrZlkpq/oak1qS8zAwZznG8Z/jNRVwZPUBQ3ncHRw
	j17/unzSCSQ+hqAjUy6JkkoN8bRcL9jzE9dlA6qeb+/T1sSW9Gh9tENlQbklPf6MPSbtGyYHoh8
	o5fKNHJkjnd0GkiNGFOBeWsWKvgSese0aiW8GBxyH2oWTZ/2a6TcAntGOu/RlUCvhAeGzOMo4WO
	DtP5nXm4Jv7U9VMZ9MNEfXXNYUN4prFTOfJ7UFjXAqZAtDtx2k50ys3ciO3uvQIcrinCU1TN6uy
	YvPhuPqylkXngw+E8Igtb/fgG50fQCU6eBC9vaGbxX4fkb5N1yX4+bl/MjXVztVAnOLHhUh7qUS
	Yz5dYhQWbq7xn1Nlt8GzUHUkuAsgjchMBaH3EAWo+whc20OYrcpnhIVXVw65eCHEXnwatBaUwfA
	kcOuZpQRILEGNyNuUrpUC+4M/3Y9qPab4SbZe6BLuEhrZ9kMZRHihUeiEQUOgoveuQiEqOawIGK
	0Ie954KXhuf9ceVwkwm4ZLov3kvFwOxUA==
X-Received: by 2002:a05:690c:c4e6:b0:7fe:4069:d3fe with SMTP id 00721157ae682-868747fe33emr6595577b3.30.1788188392315;
        Mon, 31 Aug 2026 07:59:52 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f6fc:b424:b1bb:6ff0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e58666e15sm53903827b3.0.2026.08.31.07.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 07:59:52 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v2 03/15] lsm: Move the lsm_for_each_hook() macro to security/lsm.h
Date: Mon, 31 Aug 2026 10:58:45 -0400
Message-ID: <20260831145858.3869191-4-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831145858.3869191-1-utilityemal77@gmail.com>
References: <20260831145858.3869191-1-utilityemal77@gmail.com>
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
index 71aea8fdf014..0a6fa21cc31b 100644
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

