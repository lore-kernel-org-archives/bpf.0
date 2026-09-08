Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25A7556B96
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875644; cv=none; b=fo8GFgns8qFSYkk3fVbdshHirKLLUg8fJZfM+nzid1ZYfdlUkxyjj84CRSyRwSNYMX8YipjhjpfSKOJGt/r8uesrbBLDi6gJHz7AHPB4ZLOf+eQwLYCpeG3BezwMpZzMFJgx3n2cO3UECIVgecdItUE3zW2lrU2hAhdXyXzdOPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875644; c=relaxed/simple;
	bh=nn6iDL8B9k+PR6cXXKfLJz/cPg/XodyTbC68/H77o/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wyyg/YkcOjLYTYI4W4pb+nQH2vSKWtKQOEE9OX0roLDfBa8Q7obXfwaunbaZzZCRujxYIGGr5x7ViXLKgfMS3JtxdBdU02rWFbKFx+e2kZU9Cf1eu0/wZsCV4LzkJrAWJuzSpv6u/Pl8Apm8am9q0Ieo+7AhkE7TLMadtWMphPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmEdKU6F; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmEdKU6F"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-485850cf499so3080727f8f.3
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 06:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788875626; x=1789480426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EkB8DRl1+/pAks8Eb/LLAKOiFOjTpgaq+26U4zD1T/Y=;
        b=OmEdKU6FFfX3cTa3ls6LLkUB8mwlzpWVRknNJQPZ/X2keZku5/s8ry1o9zd57mYitL
         XsLehqLvUHpnRReQIJtNlh2J9kuMKD6Bg3qSuA7jLcTOblSMUnrF2tDUlZTIGdap2FyB
         l8h9XCEeQg/Y60hCdatflWmzMqhVopXvdHtHoyVd44EhRnSzsFuWzx55YTBuGl1jtZl7
         QMUEFj5PQ6nsi9vPEcf/MhKvvTTSg//A6Ic8zu0b/5LhyLIfxrEC7edGeEfKOWB/1At2
         p03jcq/oL3zaSRHCC/rAauQtbCDIPu3MZBUeGOZr4y8LalORiJ+coVjdHQdDgGtLTP1c
         Lklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788875626; x=1789480426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EkB8DRl1+/pAks8Eb/LLAKOiFOjTpgaq+26U4zD1T/Y=;
        b=Zf+r1ohrdSMSn25CslEUIUvKBcOj4I4nIr8V3YKJ5p6B8e+cAqZY37RgDgZqlIerVX
         RUFYwMF7wL1zLFMg1jYi03Pio7R375If1+cyUgk330ZqolKUAiTiIWptIU1EOD4yB6B6
         voNwYgAnP95z9V2OkxyTk9BVQXO6da2K+bjip3RL4qS1sYbYuWmiZhlzjNpQR1to2b5R
         gUZpExBzN6UKL9hm6ZNSGZ18/xkGjXtsAJW1tFxXUtu5menDoGT1U7juKooi0iPlNGoI
         1dwHQIlvhDTC0mx2oOqXpKlnURrf+1gYmliNcSZ/3PAk0gx6LTr0dM+FbCayBMgMp0mh
         14ZQ==
X-Gm-Message-State: AFuF++kYrGidaZbmIAVc5XxlekMCSqFmthX3YTmUw6kkwcSe476izRQl
	sCD23AaYfC6bQcAPcsNeOQB7xXsNn6sNjnZij5LXbX/SowmZ5eD2sA0hqPJhc0v1Wng=
X-Gm-Gg: AYBFou3hHFgllPjhQ/qjvtQLkgtYO9+v1eRTy0FUJQ6CW9L9oiXecebIY0mOVS/PFu7
	zI775wD0xD1xo7jEekEomMLAiChDUoaBXcfqdBnD+u44yNyPcEwL0x3zxS0D5vM5Pg0+YjUg4+u
	uc4RXVpYbG+Z9ILkdOPq1Hp2GrBhn1B/wZQp2oVZHX36p7rjyRD/04uMGe8G4ku8pbObqB0zUqa
	DLGYi7d98eKNB9ZYaHeUcjpwgop18WF69zwrBv0svvJMGhHG6Nu9dcTi6HzBcfIUVNYRLCc0xQm
	z9mXk0X0Ef6vTv3GkMdd7W5J2xftVRg5f4/MDbuO8LYKh/vvf3Iz4GMYtthRuDlKJzcdpUFYU7p
	th4XBU7zRN0VkM5L99J3lROXHcMgJHLvqYgjyO9EXshS6kfNubi4PhidXXvpze1PCqJfL3X0hcV
	rdLxR2n5swWcwVx1mtKon7RPvEvTM0dPww8zAfJzefejtUARbabe9oYiXR5xGQHMIXdQOJ3I5zl
	VkowLiDSzww
X-Received: by 2002:a05:600c:34ca:b0:49c:ee36:10fc with SMTP id 5b1f17b1804b1-49cf820e13bmr281314635e9.8.1788875625455;
        Tue, 08 Sep 2026 06:53:45 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm377235005e9.3.2026.09.08.06.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:53:45 -0700 (PDT)
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
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v6 4/5] bpf: Mark linux_binprm->mm as trusted-or-null
Date: Tue,  8 Sep 2026 16:53:01 +0300
Message-ID: <20260908135302.74963-5-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908135302.74963-1-tasos.papagiannnis@gmail.com>
References: <20260908135302.74963-1-tasos.papagiannnis@gmail.com>
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

Update the existing LSM selftest to check bprm->mm for NULL before
dereferencing it, as required for trusted-or-null pointers.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
Reviewed-By: Matt Bobrowski <matt@bobrowski.net>
---
 kernel/bpf/verifier.c                   | 5 +++++
 tools/testing/selftests/bpf/progs/lsm.c | 5 ++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e79750e2480..791b3d25caa5 100644
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

