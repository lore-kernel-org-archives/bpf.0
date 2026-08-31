Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA923E0255
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168232; cv=none; b=ofEdr+Jrd48b7rcA/7enzwG0VwKaoe59BNRKyDW6bUopZEF5pjmvAJw/7KOGlFTbcsLqoZPop/0kI2kwf9p3SAoeSCgtd36FH2dDxMoZKqTnRV3S5z8Kty822hiqyaRy41/PrQIAPa/YYPi6FtPYbUn7fISEjc4ML6ji/Y3Tjro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168232; c=relaxed/simple;
	bh=fdI9y3sylK76iM9oY9DbpTJU8s7hpw7GE1UUBVIND9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oy1mG5idNiuV/Z8KyebSg6yT5u/cV661YZ5sLyvFZL62Pt507xsW+icRPjxBpk79MqXeDo9zNYSCWoxnB/hj7D+XrphdCvqoa5NLHbx+/2EI8+GvneiipGzGubAy04gCc2TjYT6PEQPj3K3UEDsvOjj73icTPs+5oGu4VEsbHw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/oeyLUJ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/oeyLUJ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49ccfae359fso10639295e9.3
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 02:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788168227; x=1788773027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zON5T+icRRTPJe/tuLdlxvvWhTEjuOvsxI3luAAgobA=;
        b=H/oeyLUJpdq9rl4eElOKD4dYR+SUsuEaRqbpQGC3OUERqIuAFjsVE3Y9bUN5c6nwvm
         Ne7+F2nJu9bYIODsWN+wf51R7x9rG2lCIw837k4WLnYBuZdWf43IsuW73KTdgZDnnIHq
         dw3I+vcB7jwMAlfFU7thDucKRTFkJMXaHnBbU4ZLQsYHlQnwVfDi3EZELVaFz65VG+aA
         m8mj/DDeuImB8zq2NEMyhWgjS824ddWL96dXuteEKaMIVnENnPuAmMAA1IdzVLGJjsTR
         itS5hQkooW4mTZrPkKDxvrTRRgFeD8xp2WncTuUxELDilzqxwKhnaAv5Z+0joyKz9tGs
         aVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788168227; x=1788773027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zON5T+icRRTPJe/tuLdlxvvWhTEjuOvsxI3luAAgobA=;
        b=JtmzVsV1mm0mk/4uofkh7eyMKmO8+g0MtT1PgkAgzmKCjVY+MKHYRgUBFTcGeGJm1a
         pbEakbVlv08B4TUh+G2PbgrcAkfcYH1bsxZQ9b5QXaYaF6PXRnocEmZOixwcvxYrWqpi
         pUqg7HQrRr1DLM6KUJazg4vU38Am53+9SRWhpnAPE9aoFSvm27fqbk/HQ7uqpnhW5W11
         wZytRzG+V6QgUG0CcByhiCvym3M9SfSM4wz+bCt++CnbNMVGZyOPq2ThTjo+aVMyl5DZ
         Tpow0Y6dll9xKxH15qxSdrlJmKWlI6xs23FL3dTEgY1gw9bPfgYsWtkad7AWGQn9ZpeC
         aQWw==
X-Gm-Message-State: AFuF++nmslqDOLjjv4YN7jJSlTF4bLVD69gGuRdasKBXvD08szLh0SEK
	HRCKxKV4UJ3GcQWxYZHppdsr4uqUksFalZ/AcnOBAXlcabJu5BtBqWYo1Nib8weXZHc=
X-Gm-Gg: AR+sD10vdxPla9pd97u0NSF33cUBouso3kwQxP+4YkprhwXweTqPwVTrzjGYkjYDC6+
	8YAN5smkFWPTCAgARIzvtX8u4eIzGz1z7sj56pGXPMhJAHtBnh7sAELUypMkBOrZYQOvjZ917Sx
	0KJtweGh5ijYbUVqO9f9HSZSFRyC7/nu90qnM9DT5pkmJ6y2VaGJ0+TXWfobqowbTJKlLusGRfH
	AlMx19qPh6kySR5Ol8+t/z6GDSx8OiwKjzsZDyD0BwIwO+RFhoOOFvOQ2NDLwT1fSpdbg2iH+cV
	NG5fdWx3qcG4Rzd3RKCGxLTiUN/uTz+/vjg3uKZBJCmTVaxTDk2s2VkXlq3slBAJlL7LZTSSO+K
	n5n3ImtZ8Py5DYTb0B9YvXmYnU0sAesrDrrojH8YYGWJlS+Hf9/FTSe4PZMx06PcVGjUQCR9jrO
	zuYbSwip3ETPKLolWMCRfFTpABOoWNdnZb9ZeIWAV1L0tXcxZc6gImUG7IFppFwAtJiup9uvjBa
	Q==
X-Received: by 2002:a05:600c:b85:b0:49c:c96a:d36b with SMTP id 5b1f17b1804b1-49cc96ad411mr286995945e9.12.1788168227398;
        Mon, 31 Aug 2026 02:23:47 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9500c80asm318248155e9.9.2026.08.31.02.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 02:23:46 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
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
	utilityemal77@gmail.com,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v3 3/7] exec: Clear bprm->mm before dropping its reference
Date: Mon, 31 Aug 2026 12:23:01 +0300
Message-ID: <20260831092305.42062-4-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831092305.42062-1-tasos.papagiannnis@gmail.com>
References: <20260831092305.42062-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once mmput() drops the final reference to bprm->mm, the pointer must no
longer remain accessible through struct linux_binprm.

The successful exec path and the bprm initialization error path already
clear bprm->mm when ownership is transferred or released. Do the same in
free_bprm() before calling mmput().

This is required for eBPF kfuncs where bprm->mm is either NULL or points
to a live mm_struct to ensure safe access.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 fs/exec.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a14f28b15607..4b4d8f0627a7 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1453,9 +1453,12 @@ void bprm_drop_loader(struct linux_binprm *bprm)
 
 static void free_bprm(struct linux_binprm *bprm)
 {
-	if (bprm->mm) {
+	struct mm_struct *mm = bprm->mm;
+
+	if (mm) {
 		acct_arg_size(bprm, 0);
-		mmput(bprm->mm);
+		bprm->mm = NULL;
+		mmput(mm);
 	}
 	if (bprm->user_ns)
 		put_user_ns(bprm->user_ns);
-- 
2.55.0

