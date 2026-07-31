Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DC6318BB5
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 02:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464480; cv=none; b=XnQmjljVFlxjKzDH5Dj1E/e3tuAJ2SfEa6Uw8IH7pBZwlZyHHJrGPePMMGWM9Rw+XDpZwxVy4Oweg4kGiEKxPZUfq+vctBytuo/8hMI93PnLBDs3rGzE2jJvYbSxxYGIkVhvG/qmTCYTqIB1kPIoVb/aY9TAnGbo+NeEZJsiH/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464480; c=relaxed/simple;
	bh=zF0tqApE3olWAH+8tKR7/tJlMlF9wC9LvCeUj33ogrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzBK97WaXGr9vRCu2ILPdU/V0YfltpS7+VN8lJG3rC7KHxFptwYr5/rxF1IKvxio/hE4Q7ASoY4tSkHYysevP1lNKMo3UFsvQNbE4AGxJWrJQuXxZdU6lAojHwRah2IG+JK5bVRSRnmwvq4NyLAvtNevvVvPqeVzRiL4FWOPDrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P20tIPxW; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P20tIPxW"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81f36179d72so7493287b3.2
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 19:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785464476; x=1786069276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dtKbTJ5THz2A+MXeqySnkUBiio4mcHLmT5n5t78F/X0=;
        b=P20tIPxW9iNwVUVyuwRVUOttXxFxiun5NslGeoiklCtpix/JbiGVJUmtBLvFWCWQ4T
         b/LPj+33jY5vbTp8pjUgKxuuTCniwXtSkxYtFiQLXw+Ap0GbTHG3M7oaeUsidsBqH4OW
         ZBCGyTHq47pZ4ySL8xJ7wuuaFFJY2FxlCwi+EvIQRbLSQk7CNnt6vD7076PNFJaoj/uJ
         6kkSD+hwjNkzGc6YOTcs/0Z8vRgDokCO0vgz+0FydaS2S+KahUrIxnW1hyP5tcKGuTl0
         a+SZPJuoHtbZ00+7sX5+YuJPYKesVCp+vFPs2PmfyH4vPh9X0nkPFd/T4vlEmI6MRmZu
         3O+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785464476; x=1786069276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dtKbTJ5THz2A+MXeqySnkUBiio4mcHLmT5n5t78F/X0=;
        b=JxCEfZgJtgqH0Yf5NwZY9kD/ueG1X7Cx+3+dn6KY1WatpsvlU8Y2+PLVEsMq6cfhd9
         WPjMHEIh0JJi62wDYICXCWmjwoDOqf8u0CYmCMF0MfaJRrv3or3Dhy1hPiNLIIjNJRCV
         TB4KHMCMXW8lWFbpHZgjXdG3ay4mCLQu2L7o7DWGb8UdZizVsszQzrgxSj9blBoanOBo
         ORJ5pkNrRu67SUaqeJKuiSRwYyTqMfmTEDYPTNfLQUde/iCHOErRyHkS+W6KK/fRORP5
         90ERHS6LQPzKKYwgKtpo/aGqVqDJcMkBY2/KOXOAuDE3TeD2pmhW6+iTKZxQ6m+Y19+q
         6EaQ==
X-Forwarded-Encrypted: i=1; AHgh+RoYXDvGZ4dIZTq8bYCjt5L6SsqDn7yB7BM/qpgoJEWivoF0HYRr65onkKTyy6Dz27G2D3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhovpCVS0+RdYUnq/7L2DhWFEKrJxEON5mLYkhm1lQnsaFU8Zd
	OxTaS/Y1Z2ccTuwQyRaR3MXeL7ukWTJmXpY7/72r0XTw/BWsF2eTssRZ
X-Gm-Gg: AR+sD10SMAZm8u2GsvuDZm5FtT6Jeg6pzsf+Ock6Z19JFRdGqFCbxarsT56xGWdSYDT
	v8iW0/jBldWcgbLXAH/iejfHZ6lvglAK5HSFNXM8cuP25Fnarg7A/Umb/PwVf2taedcZqv8cwkX
	c8NCVzAmVpqiLuoeo720egYwSVvV7Q5u3zC344gCBNUQvdh+kWTsJP25/xN3cKyOEHcjxbJdGj0
	4QZP0vXWvomJIUz39Aif7nllFwuks+qFN1yo1n+kZXHgcsRaa//6Makk30fp6Izxbnm0bg3cIgK
	TNB5WLF3zzJkBhum+UOKvOyb12mOp5ORVlnsNKd5pyuiA0aVW61RFcbunRMX89avruJPKKu8P2D
	1FB20HyOinfPzdFk9ffAihNBIqI3eaAzbyo0XQh9ACyEuGVvJUdWOJZ0JONnNQprBG9WQRO+p2Z
	qV9A18DH1c8B7V51ew/2KfRIICbtlMnXU6KV8SmeSzTPiUDXzZUmqIaZBCzNi6bQJty22xPxc6U
	dMXhobdERuRu4Mjm+b+GJmOnfnZvU6/
X-Received: by 2002:a05:690c:38a:b0:81f:69e:1c70 with SMTP id 00721157ae682-81fcbb3fcb6mr634587b3.38.1785464476435;
        Thu, 30 Jul 2026 19:21:16 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:e94:8a83:feea:6720])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8b26e8bsm20519047b3.47.2026.07.30.19.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:21:16 -0700 (PDT)
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
Subject: [PATCH bpf-next 03/13] lsm: Add LSM hook security_bprm_enforce_policy_kptr
Date: Thu, 30 Jul 2026 22:20:36 -0400
Message-ID: <20260731022047.189137-4-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731022047.189137-1-utilityemal77@gmail.com>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a generic LSM hook enforcing an LSM policy object on the
credentials prepared for an execution:

  security_bprm_enforce_policy_kptr(lsmid, bprm, &policy, flags)

The policy object is obtained from the owning LSM through
security_policy_kptr_from_fd(), travels in that LSM's member of
union lsm_policy_kptr, and is handed back only to that same LSM: the
shim uses the same targeted dispatch by @lsmid as the policy kptr
lifetime hooks, and returns -EOPNOTSUPP when no active LSM matches.

This is the first policy operation backed by the BPF-owned LSM
kfuncs: it lets a sleepable LSM BPF program attached to
bprm_creds_for_exec() or bprm_creds_from_file() arrange for the
executed task to start confined by a policy created through the LSM's
own userspace API, e.g. a Landlock ruleset applied to a binprm.  The
BPF-facing kfunc keeps the policy pointer strongly BTF-typed all the
way to the union member the implementing LSM reads back.

The hook contract is LSM agnostic: any LSM with a notion of a
per-task policy object can implement it, with its own semantics for
how the policy composes with restrictions the credentials already
carry and for the meaning of @flags, unsupported values of which it
must reject with -EINVAL.  Implementations can rely on being called
only between the preparation and the commitment of the bprm's
credentials.

Like the policy kptr lifetime hooks, this hook is excluded from the
"bpf" LSM's attachment points, as the targeted dispatch makes an
attachment there unreachable.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      | 12 ++++++++++
 kernel/bpf/bpf_lsm.c          |  1 +
 security/security.c           | 41 +++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 0800622e317f..a70edbd7b761 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -455,6 +455,8 @@ LSM_HOOK(int, 0, bpf_token_capable, const struct bpf_token *token, int cap)
 LSM_HOOK(int, -EOPNOTSUPP, policy_kptr_from_fd, int fd,
 	 union lsm_policy_kptr *policy)
 LSM_HOOK(void, LSM_RET_VOID, policy_kptr_put, union lsm_policy_kptr *policy)
+LSM_HOOK(int, -EOPNOTSUPP, bprm_enforce_policy_kptr, struct linux_binprm *bprm,
+	 union lsm_policy_kptr *policy, u32 flags)
 #endif /* CONFIG_BPF_SYSCALL */
 
 LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
diff --git a/include/linux/security.h b/include/linux/security.h
index 5017a335918c..40dfa96b6a71 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2332,6 +2332,10 @@ extern int security_bpf_token_capable(const struct bpf_token *token, int cap);
 extern int security_policy_kptr_from_fd(u64 lsmid, int fd,
 					union lsm_policy_kptr *policy);
 extern void security_policy_kptr_put(u64 lsmid, union lsm_policy_kptr *policy);
+extern int security_bprm_enforce_policy_kptr(u64 lsmid,
+					     struct linux_binprm *bprm,
+					     union lsm_policy_kptr *policy,
+					     u32 flags);
 #else
 static inline int security_bpf(int cmd, union bpf_attr *attr,
 			       unsigned int size, bool kernel)
@@ -2396,6 +2400,14 @@ static inline void security_policy_kptr_put(u64 lsmid,
 					    union lsm_policy_kptr *policy)
 {
 }
+
+static inline int security_bprm_enforce_policy_kptr(u64 lsmid,
+						    struct linux_binprm *bprm,
+						    union lsm_policy_kptr *policy,
+						    u32 flags)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_BPF_SYSCALL */
 
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index e9059d43e92c..d847a180489f 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -58,6 +58,7 @@ BTF_ID(func, bpf_lsm_ismaclabel)
 BTF_ID(func, bpf_lsm_file_alloc_security)
 BTF_ID(func, bpf_lsm_policy_kptr_from_fd)
 BTF_ID(func, bpf_lsm_policy_kptr_put)
+BTF_ID(func, bpf_lsm_bprm_enforce_policy_kptr)
 BTF_SET_END(bpf_lsm_disabled_hooks)
 
 /* List of LSM hooks that should operate on 'current' cgroup regardless
diff --git a/security/security.c b/security/security.c
index fd535bd00c24..e9d8c9492bdb 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5506,6 +5506,47 @@ void security_policy_kptr_put(u64 lsmid, union lsm_policy_kptr *policy)
 	WARN_ON_ONCE(1);
 }
 
+/**
+ * security_bprm_enforce_policy_kptr() - Enforce a policy on exec credentials
+ * @lsmid: LSM_ID_* value of the LSM owning @policy
+ * @bprm: execution context providing the prepared credentials to restrict
+ * @policy: the policy object to enforce, in the member of the LSM
+ *          identified by @lsmid
+ * @flags: LSM-specific enforcement flags
+ *
+ * Ask the LSM identified by @lsmid to restrict the credentials
+ * prepared in @bprm with @policy, so that the executed task starts
+ * confined by it.  @policy must have been obtained from the same LSM
+ * with security_policy_kptr_from_fd(); the hook borrows the
+ * reference and the caller remains responsible for releasing it.
+ * Only the hook implementation of the LSM identified by @lsmid is
+ * called: an LSM never receives a policy object meant for another LSM.
+ *
+ * This hook may only be called from an exec security context where
+ * @bprm's credentials are prepared but not yet committed, i.e. from a
+ * bprm_creds_for_exec() or bprm_creds_from_file() hook.
+ *
+ * How @policy composes with restrictions the credentials already
+ * carry is defined by the implementing LSM, as is the meaning of
+ * @flags, unsupported values of which it must reject with -EINVAL.
+ *
+ * Return: Returns 0 on success, -EOPNOTSUPP if the LSM does not
+ * implement the hook, negative values on other failures.
+ */
+int security_bprm_enforce_policy_kptr(u64 lsmid, struct linux_binprm *bprm,
+				      union lsm_policy_kptr *policy, u32 flags)
+{
+	struct lsm_static_call *scall;
+
+	lsm_for_each_hook(scall, bprm_enforce_policy_kptr) {
+		if (scall->hl->lsmid->id != lsmid)
+			continue;
+		return scall->hl->hook.bprm_enforce_policy_kptr(bprm, policy,
+								 flags);
+	}
+	return LSM_RET_DEFAULT(bprm_enforce_policy_kptr);
+}
+
 /**
  * security_bpf_map_free() - Free a bpf map's LSM blob
  * @map: bpf map
-- 
2.54.0

