Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACF34A5C4A
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188390; cv=none; b=UslqaqirQSSEwEWhItQZQB/EbG0WVzQYpuHEtgntwzqvjVbbwFeYde77/xgKuXujIobCsQZXUkrt28sTigOI/DwCJ/tInzpVPkRJ43L8c0STJlsHd72/j9EJX0+iNosVWmxO1MBWhDNAjmhdXTcYua/OQ7KL2/LqJpqbepwEvYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188390; c=relaxed/simple;
	bh=lBMOIU6CWsLN3ziU8VrmYYDs3RoekpMxdj/Po6RCFC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOucBgwI8xn7/OZHwRrmIemAJsPbPnSiUdzVHNZsDQywJC63szLpEJtztGslTWPRj9dsOf6uBtmHGIXLW1P2X4KcOGWXyKOtssfW7tAhD6O672/3CogSo5waHT5llypUL0eiXaXD8La3ZY3jkz38nCFRXy+L1jcx3zIcz/kNP3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQFP4e4u; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQFP4e4u"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-855c26cf490so24477407b3.0
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 07:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788188387; x=1788793187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1usyBp9aft3dyeY3uN5coYzOfoJwuHJfSY/skJ61OQQ=;
        b=BQFP4e4ubiv8+GA7M1P3gvEPOxGXLUlMVfV95F9jdsRVKt/d35M0gLgII2tVJFbmzn
         jrE5vIMuUN8U/3x2QopqPZunQWc/ruGOIDVAvNcxVTCyvoT00oADPNbhz6XpaP4JzDH2
         3uGYdwby9MXwtvdhyVDgsqpZgzm44Fl8tieZuaL3CKOy44agzIBIEb1k4u0MAiupoCAy
         +RH/PFNxL35sMZrQmvVPt3qVTureDGQeka8xegkWJXXVhcuu1jyOD4MA9krQpRVG5uk+
         JfVpsMkdMzgKJ7dM3nhQLFhRgRYoOKnILFopmIzZfPsBtaP6WaMPzd5MSjgUR5DrXq5D
         kVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188387; x=1788793187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1usyBp9aft3dyeY3uN5coYzOfoJwuHJfSY/skJ61OQQ=;
        b=i5wHXd+HJ0ENpLs3gdl1jrhXALBzk0iS0rfcEV6DtaZstVRVCaND7SNPeKr/u0uZTa
         HlX1JrotYkQkG5BumxM33dHQ7BdlOJbkUn9N1v8aqzh2FD/IUG09/v7sgVTmWjGIAsrU
         CgCrvcdweHxFQlqbS/VCLTW6KblNT4IdD+5pN7XBENkl5BoOeokxeixda4+k222hJ0eC
         Hn0SxyE6vmQrfEYXVIEryyGceH9zUdv2cRWIdzx76Wc9xlG38uzppNqWWKHPgxwJG4dE
         j1TF/vXcN7KAZvLbhukm8IRMNkj8TmBOuWXa3/xbfHmwJhWNBeeGKANkqZ15DgCnEn6U
         0hyw==
X-Forwarded-Encrypted: i=1; AKwUvBy5J1k+or6EaAMdTr6NPjwTTCDZUL/JHMoR6pMCmdtwAEnZbwcqWXnVaQY8o8YpZrQfNoo=@vger.kernel.org
X-Gm-Message-State: AFuF++mCUn2PK/WOVyl1NdYeLv3bQKZfLKDSWE5s9m/GmbpcPZK3jUwr
	pvdkX6BzWLW7phBnKMR5+/PDYmouyE0CAjTIPgEriWmJHenWsh/Uquw3
X-Gm-Gg: AYBFou0DxupwucjmBGIBp44zPj7fyXyAlOHs0e7IsLqvvsOwTw8YtFUx6Qj2sec4DlX
	6W89E1yY68NckV+mULOEbvbLMRK50arJLRAeEheblOEpsu8ECsWJvnb/A96tvozc2L8V0oEbs0i
	rMhcTnD7hCMpGSYbrrKRyJ44yAy0Kf4b2p+mPdpgqEpdX0aiTOzebyqHBDcuYAXPvhjwR4PMixB
	bS9Wqptah9lNqnw6m7DsLc6lA/R1qIUrL5VJp55LGXRjTfIJYzbwXxl+9Kc6oXH7iMqQJViVMT4
	pw1kXKxS/dpyGgr6LHKbEL4jnOZsnmBaX6Nh4UmvxBu/aSTXqZN7XpVL0ZPY+p1w93luNb5u4Jf
	aDcq9+oUWoc8VH2r2cx0mZQQcVO/Sh+D1+pgM2ZWlA4ytDLzha0oAhjW3uW+FkAZ29oqZJuZYeZ
	+d91i8ZUklAS9kT0MoiC9QMXt7U35cgun09ZO5xueP9J+pLswOa7FKCIYBt2j86RNeV1haAPRwM
	7w0yTh/3gwAtZAra4X/qEQ=
X-Received: by 2002:a05:690c:4021:b0:845:ddf4:a3a7 with SMTP id 00721157ae682-85d6cbd8637mr82959027b3.16.1788188387414;
        Mon, 31 Aug 2026 07:59:47 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f6fc:b424:b1bb:6ff0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e58666e15sm53903827b3.0.2026.08.31.07.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 07:59:46 -0700 (PDT)
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
Subject: [PATCH v2 02/15] lsm: Add the bprm_apply_policy_object LSM hook
Date: Mon, 31 Aug 2026 10:58:44 -0400
Message-ID: <20260831145858.3869191-3-utilityemal77@gmail.com>
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

Add the first policy object operation, applying a policy to the
credentials prepared for an execution:

  bprm_apply_policy_object(bprm, object, flags)

The hook is only called between the preparation and the commitment of
the bprm's credentials, i.e. from a bprm_creds_for_exec() or
bprm_creds_from_file() context, where the executed task can still be
arranged to start confined by the policy.

How the policy composes with restrictions the credentials already
carry, and the meaning of @flags, are defined by the implementing
LSM, which must reject unsupported flags with -EINVAL.  An LSM with
no notion of applying a policy object to an execution does not
implement the hook, and the calling kfunc fails with -EOPNOTSUPP.

Like the lifetime hooks, this hook is excluded from the "bpf" LSM's
attachment points, as the targeted dispatch makes an attachment there
unreachable.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 include/linux/lsm_hook_defs.h | 2 ++
 kernel/bpf/bpf_lsm.c          | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index d7684407737a..ddb15bea383e 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -452,6 +452,8 @@ LSM_HOOK(int, 0, bpf_token_create, struct bpf_token *token, union bpf_attr *attr
 LSM_HOOK(void, LSM_RET_VOID, bpf_token_free, struct bpf_token *token)
 LSM_HOOK(int, 0, bpf_token_cmd, const struct bpf_token *token, enum bpf_cmd cmd)
 LSM_HOOK(int, 0, bpf_token_capable, const struct bpf_token *token, int cap)
+LSM_HOOK(int, -EOPNOTSUPP, bprm_apply_policy_object, struct linux_binprm *bprm,
+	 struct lsm_policy_object *object, u32 flags)
 LSM_HOOK(int, -EOPNOTSUPP, policy_object_from_fd, int fd,
 	 struct lsm_policy_object **object)
 LSM_HOOK(int, -EOPNOTSUPP, policy_object_get, struct lsm_policy_object *object)
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index d06744d72e04..d5859553f7f8 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -56,6 +56,7 @@ BTF_ID(func, bpf_lsm_xfrm_decode_session)
 #endif
 BTF_ID(func, bpf_lsm_ismaclabel)
 BTF_ID(func, bpf_lsm_file_alloc_security)
+BTF_ID(func, bpf_lsm_bprm_apply_policy_object)
 BTF_ID(func, bpf_lsm_policy_object_from_fd)
 BTF_ID(func, bpf_lsm_policy_object_get)
 BTF_ID(func, bpf_lsm_policy_object_put)
-- 
2.55.0

