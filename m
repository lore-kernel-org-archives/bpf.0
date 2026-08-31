Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EC74FECDC
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188422; cv=none; b=Xk4/lsFOIOoxKYA2t/gpBPKZ+eKZzyaLfS7Mx47gJY2gkTOV2omAwvVwipwcUe6eKzAi9D2YzB2sz1uQM4/Y4e/HSp9ArhOZUVCFvYouSLBf+mAARRaREL6neAJ9nMXeopDeY4WveTzM2/sug/hWN5pcufWZJ4lH83iZ6upkOjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188422; c=relaxed/simple;
	bh=fPvKQuDavmYJkKbFES3kYx/V3SZddiqGrWAf9c0rtvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOb/lO69VIPP52bV04VaCUNKNoDACiwNX3OhJpN+FfCbWSKZ/flhvs26W1fL4sJ9KJICC3tEfrnBUCRqPRhq5j/GwpVDx9QI7JY2O3Au7/Kp5Dmi7Qr3fEx4NxPNgFxUASXcDLoRm71Xq0RQ+NPAzqq6vyqPyb+dxC2ZFKRJ8CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrN7h+zN; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrN7h+zN"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-867a943b149so8568457b3.1
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 08:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788188420; x=1788793220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J9vg9u75aczYS2NdokKyQvYBzY1IUPtCFLk4j1zgxQI=;
        b=lrN7h+zN+/T3izk1jddtcvNzFhT/58FdaKvN7kxOYh1avtFZOzoE6g48uXPKNH7Rcy
         HLXeVYwLJ08nrALkdQhQgQEqEFCGaROxV2hCf4527rEOvhOBSblg8Eaj6dTVRVjjH9ve
         k/ntKYu+O3ZOdJ4n4nXDm8hVq9HxDoXjcIw+v7zx7wFriGr72CmHDz35MbS8HNoII5ZY
         8PyKR4/NurYfYDDmqj7gcrD8D/hjIbU7tB6vIElmbm15WP9vbNG1/jWxhPyOxCjOHTky
         HZvDc75B69/XihDxNbrH27nekxIt0kfYO/tsUNVBlFQgdU+uRfNoNQw2SJszQi4TwzRU
         8Vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188420; x=1788793220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J9vg9u75aczYS2NdokKyQvYBzY1IUPtCFLk4j1zgxQI=;
        b=URm6EcOn3x2w6l/BhiuWHwLUDZ3WCvxw5MErfBQIXcdzX3bbsrNafv0QOvvSAJzPF5
         sUxpnSFS9dTbEf1JyraB/YVmvfa2LaHcprdP1fgwQHCN7q+KzU9N1dDVpxwjpzpLWjrJ
         ioXDxWO/qun6iLatofADaZU8qPE8BISAofmMVIW91QUg/+ogk72vthqw6EW6n8aJHRbo
         TQfTBTvNJ25dpbpNQRx4COilP+ZClmTjY392AB2cQX9sbMezP59/6NctqHAk4E6hk2E0
         kR5Er37fkEtZa1LfRTMW8/RbVDpcnwsHbnNyqCAf5/2uRqWFEMvYizXod/8YwNNuQoWr
         5sKg==
X-Forwarded-Encrypted: i=1; AKwUvByAHAvXwC5p537HYdx+1/5EkW9H8dZxlMFU80yzEiKt13/LlAAXcKAknMwJupGMM8+AQmc=@vger.kernel.org
X-Gm-Message-State: AFuF++mtRghoEs87I7NG81fGVQke4+KS5ZZEBrj3y6kAI/4RAl9IggXD
	CL2tyrocIdBXhboJdFsgYTFYjVwoN005eNjukj5MhJDOr2aV0HkvAOMd
X-Gm-Gg: AYBFou3wSfQsMVd/1QSP5XubOV1/mGOLkWu4mc6CSgb2el9KIdWlm7Ec1c2nBAluMzT
	VDIlcBf4km0ZYpMOfHh8VXro+MgFtWOufnQ+Hmz3bNh/brW8CiHnJNo3dazaxTTgthotnMT/Zn6
	Grb70zDeWW622gNfTDM6tgAf7Wz5xpvNo+7nIQqRGZh61jdxKXbPP1sOPMYS6ziKbJpnjt0heJS
	u7Z+c0CTIkXhU+QhqeWkdR1CSnaISl8esb7UYlG+fXR/zjn3BUDGkmiJObhe83PKXYWpkBLVRGZ
	6ClaZMi9MFeM59ZRK3rm5vtkGziwGDTdf0Acyint3v1sMnhRMMGSqaQuPlIBC2X64Zxa6CexEW3
	nuVTmBv4ZNOi1FaSXbX9zfqRERfDf/+ovXKlEqyj+ipa75uExI8928SgM3k52mV0ai0kxxKl8fT
	TnIG6vx+20aSOnAfIfWlgN7hFrlFmOtYl7zAIay8T1FwQM12J7YZJek2Z/+O852mOY6tVPQoFXv
	Wk5NCMQU+c6H+zAxRMPOlQ=
X-Received: by 2002:a05:690c:c3f1:b0:81e:98d3:cac7 with SMTP id 00721157ae682-8686f52fe19mr6867327b3.12.1788188419607;
        Mon, 31 Aug 2026 08:00:19 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f6fc:b424:b1bb:6ff0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e58666e15sm53903827b3.0.2026.08.31.08.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:00:19 -0700 (PDT)
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
Subject: [PATCH v2 08/15] lsm: Document the LSM policy object interface
Date: Mon, 31 Aug 2026 10:58:50 -0400
Message-ID: <20260831145858.3869191-9-utilityemal77@gmail.com>
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

Describe the split of responsibilities in lsm-development.rst: the
LSM framework owns the BPF-facing kfuncs, an LSM opts in by embedding
struct lsm_policy_object, tagged with its lsmid and an LSM-private
type, and implementing ordinary LSM hooks, and the lifetime contract
those hooks must satisfy comes from BPF's execution model.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 Documentation/security/lsm-development.rst | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/security/lsm-development.rst b/Documentation/security/lsm-development.rst
index 5895e529da7f..190d9b8f2346 100644
--- a/Documentation/security/lsm-development.rst
+++ b/Documentation/security/lsm-development.rst
@@ -15,3 +15,52 @@ see ``security/security.c`` and associated structures:
 
 .. kernel-doc:: security/security.c
    :export:
+
+LSM policy objects and BPF kfuncs
+=================================
+
+The LSM framework implements an interface for individual LSMs to
+expose their policy through BPF kfuncs and kptrs. An LSM may not
+export any kfunc or other BPF interface directly.
+
+An LSM opts in by embedding ``struct lsm_policy_object`` in one of
+its own objects, setting its ``lsmid`` to the LSM's ``LSM_ID_*``
+value and its ``type`` to a nonzero value of the LSM's choosing, and
+implementing the policy object hooks (``policy_object_from_fd``,
+``policy_object_get``, ``policy_object_put``, and per-operation hooks
+such as ``bprm_apply_policy_object``) like any other hook, resolving
+the containing object with ``container_of()``. The ``type`` namespace
+is private to the owning LSM, which uses it to tell its own policy
+object kinds apart; the framework never interprets it, and 0 is
+reserved as "unset".
+
+The kfuncs, defined once in ``security/bpf_lsm_kfuncs.c``, dispatch
+each call on an object to the single LSM matching its ``lsmid``. The
+fd translation has no object yet: the framework offers the fd to
+every ``policy_object_from_fd`` implementation in turn, and an LSM
+declines a fd that is not one of its own with ``-EOPNOTSUPP``; any
+other error fails the translation. A program that expects a policy of
+a specific LSM can read the returned object's ``lsmid``. Either way,
+a BPF program reaches an LSM the same way every other kernel caller
+does, through an LSM hook, while the BPF verifier tracks the object
+as a referenced kptr.
+
+An LSM opting in must satisfy the lifetime contract that BPF's
+execution model imposes: the containing object is reference counted,
+``policy_object_get`` acquires with inc-not-zero semantics and fails
+once the count dropped to zero, ``policy_object_put`` may be called
+from contexts that cannot sleep (map destructors), and the object's
+memory is freed only after an RCU grace period, as programs load
+policy object kptrs from BPF maps under RCU. Hooks for operations an
+LSM does not provide are simply not implemented: the corresponding
+kfunc then fails with ``-EOPNOTSUPP`` at runtime. Whether the LSM
+providing an operation is built in and active is likewise a runtime
+property: the kfuncs are always registered when ``CONFIG_BPF_LSM`` is
+enabled, so BPF program loading is independent of the boot-time LSM
+configuration.
+
+.. kernel-doc:: security/bpf_lsm_kfuncs.c
+   :identifiers: bpf_lsm_policy_acquire
+                 bpf_lsm_policy_apply_bprm
+                 bpf_lsm_policy_from_fd
+                 bpf_lsm_policy_release
-- 
2.55.0

