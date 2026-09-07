Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236445221FA
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799996; cv=none; b=Fbs5I16AEVsjqimstxXoqCneR0M3w40cKseiCDWQKP8Wi+rclsmdL02GnruNsigZ5EMra9b+kSf2dEsvGqP4Z2ljXoAt6rJgsGwyqmWJ0rbKgrFX8t5p6Zn2hszi9LsfE7nuBLzEusQ6Z4FZrxapth91oELgmG8+yF/9wTXSACw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799996; c=relaxed/simple;
	bh=37ZkkZNqxkhdoz/COm3n2Pon+sMf3f11UDjmNND0D2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vfnm4J0EC7A8bm43POCXgXe7Y3Czg4Wlu/VFgNuQGPs0JwXw0rHl4C9udWrBK2mHZK+qgIQh7/N+Ok8E1EyXPa/w7MyO9Et7Jci+n4VbhIVTWH7G6D+/wgGDooKyEUH4EaUrtEi2Q/vKDChZ+6dLH7sZeEkfdvhxaIl5P31OO+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmw1WqJC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmw1WqJC"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-499b2981a7bso40196215e9.3
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 09:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788799991; x=1789404791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OXEATw0LCoNw3+DI3xDTgsz8l5QDzPtCPOwXyA9u26Q=;
        b=hmw1WqJCHRhE3G87DR1g4BeBvh/68di1WUMzePtbbPNHpnNepsaWsyTZ058+17dMhj
         becWdVE0tzS8gom2LRDufMLM68HqVeOYy5QQI/HZMHR6X+aRPgZK/IKqGpMBiUpHgJ8G
         ghckD/wRZpeyY0vw/6wij58gXw0sDZ1t9uVkDQDnKbQiCAh98PxeGMqfES4xWaRKeBur
         MIxWCaHT778rCG7i4VkFPENR+3Y8fQFZOLkL0lUrRu2lcOVaW4j1zjTkKrtULdtMvD/d
         fyLvy13dXZXB/dftz/kymru7gvQ0MsKdRpXePwQ+ONRQ6BOtKfu21Wb0DFV9eZtq5DsZ
         T/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788799991; x=1789404791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OXEATw0LCoNw3+DI3xDTgsz8l5QDzPtCPOwXyA9u26Q=;
        b=o4NDImSlVg0m4VErVT/T1Mi4W3JnWNewzjB5HIhmD86430az6MfXQM7qVpT211VvK6
         qDaStOXpsbakj/UTOQgpCuMuZpyIlFIt7oln4hO6YjozGV56nuVXU5dInDYAP+5XJNFN
         1bM4ArYY02HUOjDRXyJYhVHdxYyAkrUZ6hKqcneBhNawPQtenqgzqbWb1YdOz2cGPHmN
         VTSpI7ha4TzGsgOdRvJ504cozcvOi8yJ+qggKNZZrIHYqz0fbcvQf6vAq70/NArnxzQy
         dcZ/QsyIfbp0xU4gX6x1YaTxIoyF4oo5zFbTbDqoMcXRpsk0ul7dJLFQYm0QeiSyzMd9
         y4VQ==
X-Gm-Message-State: AFuF++lXll5q+vL/TWqcrD4CP5+i5xHb4QRDirFNXl1SefvEjcGBUG2e
	MQv+aN5FHn2bNbrylhoV9tKVW373G8gV82ACb/X+kqJ2KjMt2UGFDf7B+yP1tQgdzJI=
X-Gm-Gg: AYBFou3KMGbhgqBZA1khaP62ehiz0ofwP4VrQ7nGXpIfuBq9XAcQ5pwlwZkseyA213L
	npttYVhzXeOnROby8Vrhc6zFuMxmjQ2HRqQZHU1uIPXDIioGu8U4D6n/AFBDIkm7TNpppY1CtL2
	WsrHGzGLXnNg0aYxuN8IpjrFMkXCfkKDEnxlYHu6VVW9wfmfrv0nRdAX4P2A/Q4ycE8bp76WstS
	CHyTLvXC1cfkBlnPH73WKu6kEO4kje+yFW4ePkn5ZIoz7R+RnB7ArDxNkHk85bKLLzr+cTcOB7B
	J1RU0otfYZdKuXF+rm5bzwmTNmFcEZaUB/dMJsowOs2h5LtenSmqwumu4uQzMCYEG9+UFNOPa/1
	PV2ZnKJN/BzTYzqEeV99s2ZGxMdNgK61M0wZnK8UoEJHvDcDUi9RbRRTnH03fDmPdXvoP6ShNS5
	rGM1e8npU51+GUoE7Px8FqUWsi/da2RkgDnHtX/t4f/4hkUA2Qe/F4wjSqxCCb1/Lvbn2CIu4SS
	Q==
X-Received: by 2002:a05:600c:3485:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-49cf825c119mr525133835e9.16.1788799991022;
        Mon, 07 Sep 2026 09:53:11 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d03543064sm233022415e9.13.2026.09.07.09.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 09:53:10 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	david@kernel.org,
	akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	ljs@kernel.org,
	matt@bobrowski.net,
	memxor@gmail.com,
	song@kernel.org,
	sun.jian.kdev@gmail.com,
	tasos.papagiannnis@gmail.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH bpf-next v5 6/7] bpf: Mark linux_binprm->mm as trusted-or-null
Date: Mon,  7 Sep 2026 19:52:19 +0300
Message-ID: <20260907165220.52431-7-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907165220.52431-1-tasos.papagiannnis@gmail.com>
References: <20260907165220.52431-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark linux_binprm->mm as a trusted-or-null nested pointer so BPF programs
can pass it to kfuncs after a NULL check.

The field is either NULL or points to a live mm_struct whenever BPF can
access a linux_binprm. On successful exec, exec_mmap() installs the new
address space before begin_new_exec() clears bprm->mm. The bprm_mm_init()
error path clears the field before mmdrop(), and free_bprm() clears it
before mmput(), as ensured by an earlier patch in this series.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b5186e664aea..6799d9e080fc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6004,6 +6004,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry) {
 	struct inode *d_inode;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm) {
+	struct mm_struct *mm;
+};
+
 BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
 	struct sock *sk;
 };
@@ -6058,6 +6062,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 {
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
-- 
2.55.0

