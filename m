Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DB44399ED
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447376; cv=none; b=gNJlia20nkvppWtSV7+4NML7cPGW+SSjNLudE5V3l6rtdVhgcpH0NudwnsySYk7EuqYnl6FSXK/T417oTrbbRCobVsaTmEGb6pp+XI3ZaG/b28oCUQ00NZbaeRa+Ek18NlfLD6ifEIvUcYgIl7+FmUcHCOV+UtPvyIz6MkyT2IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447376; c=relaxed/simple;
	bh=cFs0xfmRfoyZco4JEYNq6ZrlZJuCFGmvzVSfHHDs8YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPVIfgYA3uCLg1HaqF16hX7ZgEpPjMDqT95Cjxv/0fvx/Dy0ZZKvrT9Ag00KUkYTzhsEaXB9RroOWf8RFlXthqk69fcLN6+hXjVngY/P7h1cwkg3bGBuLqjA8i4mRiiKonGvVO2qGJGPt0kS4VO2fICYKkcrt1ZSkVdekEZGL68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAS5AtwJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAS5AtwJ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4996f1ee4a4so16430255e9.2
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 04:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786447367; x=1787052167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vdXY11jYOJOgDrqsfvB+3m9H12a0vELp6Tr1U8V4Fak=;
        b=AAS5AtwJYo7/MnxDvtW+vn3eOb7+r8Xvk/G9KH2JJ2p3hNay6UTNeXT2dmJpLHJTOy
         gJpHS5lAf3IAj0hyyD8aHN2XCBxBwORMuiARjOm1CDzpMrUXQCEJ3epBC9ln2qlI8CWx
         3E8Ud1RypSEUqtjRIu+xGQmLq7DsPMVXgPFmevuuXr7IUUk95fy2IVKoPnF5+RvGahru
         lxg9VgaXEGcO9QsPudjmWJJ5k2vEorvSFGSR4SXGMZzwoaLIP7jphKIbYLPRBYRX8Q2u
         p/WuQ8lGClCSY4a5bq+y6i2vdzxOFZKAWDccLGvNzIxH6caNOSjBzpOp/EG0OvKsnV4+
         5Dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786447367; x=1787052167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vdXY11jYOJOgDrqsfvB+3m9H12a0vELp6Tr1U8V4Fak=;
        b=EpdS+H+yUZO/Ztd07CKlvf9KxHisIhCKSVbEcs3cfwkGuUMvnZfRAmTJ5fPV7vf0JT
         O0/Drm0uZM/b7I+y2E5oPJJjKyLS3qPobzSTi9eHP8Gz3NnWK8PpWAsu4SmcpPUETb4z
         QjWStsLtDyGD3USfnQG1QNm5/j6dpm4P77j1g1Ddo95vt3Qg+7kH/i1HYz83CuUm9zVk
         6Rkr8lgcTigiOSvgk0bLUbx4mZs+WmwZyjpB6vvcpT/OUsIXib74ylBDFyJMIOlb9jll
         dDVoWWA3sDWhNsr7xyB/y78xpRXX/Rv8ndctxNcIMOg7UR9JAnbz/LRSJyQBtYB64RLE
         6AMQ==
X-Gm-Message-State: AOJu0YyQFwjEwPvJsN+z63X7qc05gGHgo6+ON8Khy/Ux0hYDiTersXjP
	U6JlQQTjmhnUvnwqul7Hbi5SyhjzXA5tv8ait0NyJ39EoBAb6zRTtL4HBBWVO5ja
X-Gm-Gg: AR+sD10DdkEPsQBQDI/6IMQxWeBBBuWrVMnlGZd1d5DxFYpJcJqdkWSX5xpIOSfMAtc
	QweKeZDlkJuLP5nMTm3Dt966pwWn4OCLdQY9aZu3w4tFFIO8Ac1LY0quCXgrIfG3KsH0ibdccXZ
	HZ5PhRGoz9KsKWl48yLfdMaWGOPxFJfzzWNYpfzuOmXgg0i4rrfFzOcLqKPU60zo4MtQg7sXOhc
	Fn8ARJBczcJpz6nTYnz5vrsI9YPBXogHmcd4UvrUIGdrC5jee1GJh9a0BWbv+dxrOOJdp7j97TK
	sWTw3LoQ4OhsqzlowVqymwFh/lSJK8JW5nUIYyjTUmvC77COtiP694TyxsKzNSvJ0g/AaPFfLDP
	zOb+0GdXhBNfW7z4R0CGP6DZzyVFiSfr/UhXcc8b7UKilFYnm+PbLmUfkGxj/lxlsUw9AexLrUg
	XjoC/uCsPspc8WG0HmGD2Of3nBm81K84XR1h02s4t24gdFLa+PcFe+Q301Fn2vAXIXckJubDmzF
	4FG
X-Received: by 2002:a05:600c:1550:b0:498:952:e276 with SMTP id 5b1f17b1804b1-499784358eamr31222895e9.8.1786447366875;
        Tue, 11 Aug 2026 04:22:46 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5e:1100:7303:647d:7cc4:8552])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997889c2bcsm47547665e9.3.2026.08.11.04.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 04:22:46 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	song@kernel.org,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next 3/5] bpf: Mark linux_binprm->mm as trusted-or-null
Date: Tue, 11 Aug 2026 14:21:52 +0300
Message-ID: <20260811112154.94053-4-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811112154.94053-1-tasos.papagiannnis@gmail.com>
References: <20260811112154.94053-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark linux_binprm->mm as a trusted-or-null nested pointer so BPF programs
can pass it to kfuncs after a NULL check. The linux_binprm owns this mm
throughout the bprm_check_security hook and clears the pointer only after
exec_mmap() installs the new address space.

This patch also updates the existing LSM selftest to NULL-check bprm->mm
before dereferencing it.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 kernel/bpf/verifier.c                   | 5 +++++
 tools/testing/selftests/bpf/progs/lsm.c | 5 ++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index add3affc5703..8bdcb65618d0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5682,6 +5682,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry) {
 	struct inode *d_inode;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm) {
+	struct mm_struct *mm;
+};
+
 BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
 	struct sock *sk;
 };
@@ -5732,6 +5736,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 {
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
index 7de173daf27b..7441d66c080c 100644
--- a/tools/testing/selftests/bpf/progs/lsm.c
+++ b/tools/testing/selftests/bpf/progs/lsm.c
@@ -113,6 +113,7 @@ int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
 	struct inner_map *inner_map;
+	struct mm_struct *mm;
 	char args[64];
 	__u32 key = 0;
 	__u64 *value;
@@ -121,7 +122,9 @@ int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
 		bprm_count++;
 
 	bpf_copy_from_user(args, sizeof(args), (void *)bprm->vma->vm_mm->arg_start);
-	bpf_copy_from_user(args, sizeof(args), (void *)bprm->mm->arg_start);
+	mm = bprm->mm;
+	if (mm)
+		bpf_copy_from_user(args, sizeof(args), (void *)mm->arg_start);
 
 	value = bpf_map_lookup_elem(&array, &key);
 	if (value)
-- 
2.55.0

