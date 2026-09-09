Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1467439DBD0
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982672; cv=none; b=Gn/I7d56tIvT45zSCjbYE52B+jhI5xzcaBVOPVG09PD2hcIyuOxGibYPnOeT0/1Vr4ONEkXQU7bF7D951ikkllfULlHngYHLMngCJkk/b1KsNRwfIBHYdIoHyTcYnLSac9RxqNzeDox0qqRW7JKB7eE/SNGLDsYGMg3HC85afYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982672; c=relaxed/simple;
	bh=1LzvLV16xeBAkstMGb/MXqY0fnWj9soFnay87GQLE4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HI0eLbb+4F7cvyBaw58bf2V12EajGCv5pz1JKg2n7Cvbh+CC4iJHdT6IV/MU/1caBbcFyypIShSIuedwajTLjBABNdqcaOhyQaiTDtgjdL0PUDDDa2J69Y0Y5JyLCrOvtm4pUwFoCtNB/zc7oBFwbYvZKEdZ76qeJwxhAk2OINQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5nx9Tnw; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5nx9Tnw"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81ecf499af9so89484087b3.1
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 12:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788982668; x=1789587468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gtEYMRE/KFKlT1/9bXmERUsL0M9lvoNkItLmndtSgzs=;
        b=c5nx9TnwbshWEhZbrVF9ZujNZIFiXbaTuWk6BLqKx558pE1Vd78OARzWjJZ1AgPDax
         tklhQgl03uaycvCbmuad9P9hRm/NHFZm9ifW1AnwdF+hE9H/yHbZAlA39S60pAuse85w
         EIUoANZTo5gxhJVNEPsWbkvbLkAb9ER6TpEmhhBrpjE2F+45WZnL6fLcyY9zzVMux1uY
         6nyBFIkwCcvn2ADTf5FHJ6x+DmcF5NwZCv6HqT6EPCw41xM0RudXItHO23p1CvmPXiWi
         tT/PIkMHYdNZGFmCAN58pcFSqoYqxtaQ2o48Fs96jsiuOtbp37/ata3lGyv8rOSy/JfN
         kkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982668; x=1789587468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gtEYMRE/KFKlT1/9bXmERUsL0M9lvoNkItLmndtSgzs=;
        b=bbuWhEoYmnPl+/zqALGVFWV1D9M1202DPNPyZKcd9IH0NO8NhfFKsrC5PljgALTuE1
         V79l0ld9UeYNXHvlG0XilfUESDpfynME5KUN1yK476ep9I3OuYjokBx6v8UWGYGwNOdx
         KK4FH4v5R1sPVLgLNpUaQs4JRI/qQCZ3RKZbCghh+A/E0K0id49IVjL93xO9ys36jUK2
         7SmBr8FLY3fJrNOeu1ssy4OBndASL0yfUctZl7YeI94ZwGxNxAUNh4YIEnNlERYE7ixG
         BYDaZIdaQv9qFy+Uf6XI9vuuleX2+zrNTGvBcW+JV02V+Ay731cGwN5qOQwiz35F33Vh
         ZlWw==
X-Forwarded-Encrypted: i=1; AKwUvBxO7Elnr+LT3fucI2NyjmaX8Q8yjrEX+yxKMF6tj9YlzG2NPPLj9/FUTF1jH49V+G9DYdI=@vger.kernel.org
X-Gm-Message-State: AFuF++lIGAFMwT9/8Bz+uSrdKlH3iyl3LDDzJSJDa0IR8tpjJ6ONDN4P
	kvFIKwMTZV/WOby/oXDtKxwH8+opE4uq5uUA9fiMJP3ifoCz36SLY7Ja
X-Gm-Gg: AYBFou21XqU/mEJAxG1uyTpPslT8VxOdSpSrno7cq4usdgx8IYlEXOql+8KiIEA2tvC
	GU0SQHm0lFdkyapI77alf06ZvKCnKY9Y2RM99VPVV4Mjhn7T5eYmJwtJIIbpOmhvy2qWTcMWWiS
	wdagkbPH5NK5p+NfMhxBpcCdExt7ERIoBHyl37gFkdU+4elZFDNm0y7BPTV6dotnp5PIsJoo/tx
	1fRiYjqNN/x+wcEIBO47r/SH+Eg1k1lHRpstLY/c2rySWkzwQsLwzVnJpzWsPr3jwGJNOkncQda
	thaVIr0k0aRq3vYASSyZ23Xvhew0v9x1PajxUY7jHfZqSjSyYejUPq8PtEpd3FIK4mSGRFm7nit
	b8RV6KH2i1mXssOuCiEptltjYCJ4ckw5LDRvHOET2EdeBfHL8I2zx/DGGR1ZZ0rPhKT++XClSxj
	P6S1OnlDldhAiv/cdR8jpdd1AjRg6xY//dVU4sYO9Q8Ry/h2xCP64meRGRpCalOFhjlI6tdvyT8
	MVh7C2C8hmnJAm2upRIdx6HpNjCDiVB
X-Received: by 2002:a05:690c:c501:b0:871:a319:3ee8 with SMTP id 00721157ae682-871a31948c5mr132151937b3.10.1788982663710;
        Wed, 09 Sep 2026 12:37:43 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:bae:bfc2:7e96:e5c8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871493155d3sm115277577b3.16.2026.09.09.12.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:37:43 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 02/15] lsm: Add the bprm_apply_policy_object LSM hook
Date: Wed,  9 Sep 2026 15:37:05 -0400
Message-ID: <20260909193719.518517-3-utilityemal77@gmail.com>
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

Notes:
    v2->v3:
        - No change.

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
index f762cac6838b..f3de70511c0f 100644
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

