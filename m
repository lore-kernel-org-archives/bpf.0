Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F0B51990C
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 16:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799982; cv=none; b=upIpUo0OTAwi1hnlImtTs5vAc5YZFm8dsbeZKHYtiUuZFu9ylZAuM1mY4OXGTUeJzlSh1MACCptu1nLVy1ydKaB0b7pTOCL5dbvuaaUzc4IxNL+IwGTD2838wuzKFqgegdt0fNH96ulG1QaykFYzFiFJXzdCiTtIEIhOZkIv87s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799982; c=relaxed/simple;
	bh=oxBm833C8T+jxHgAdbU6D4xcv4E4TYoli1xZPpTW0yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UR+7urHHRZ3wFwEf4LAZTj3QIQnFRKaUVZU+xX0D+SKUP98jEDi3nY1FGB7paYvwvHZTEpt82yHzDNhgVvJfFtV1rq/PhugMI3p+VutqXKoYI6lmo9q1FQtkvrkZr+g3P+PRMeC+OomnaxPTNNYVwpB2anN/9//D+HsKxqHYcDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfBW7WzR; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfBW7WzR"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-484362f5c4aso4725635f8f.3
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 09:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788799978; x=1789404778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BcITG13Gvl8i0HA4g724jWVmnWns/ceZ5ECxTEaQlok=;
        b=jfBW7WzRy1LDdYAfQnEc9I7mCDw90Ps5LjnC8imAutx+H5oG0GQNtSpUarqQPRbWvc
         dXgYKxKmJTx1ZVCWaubdw1ZKolpVgVxr9pwoO+RzGUkmtSW4oHtHB4vFDCKUt83lUEsq
         0krNRDpkkYQXu+QbiTCavOwrrSvxY34ZRAzpqMYg8VtF/rw+efZUbxzwmd89/4R2xULf
         ZSrFj+ctcmCm+CrY1oAN9JEugFOMgn/8aX1C4MZXxLia6XQqpjKnZn1iUf/2O0La3qk9
         SwjoKhy6G2allTRGy4WXZDkcM3J8l59twAQOMwYkWiM7O1rxm59RVwsjW1yHieQ/nk6D
         68QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788799978; x=1789404778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BcITG13Gvl8i0HA4g724jWVmnWns/ceZ5ECxTEaQlok=;
        b=g8UrFpCEOt+0zc5zqJzTZTkea/YjzJQdoAEpwSTTpK3kz0vW4Dsd8GhoBRpVPMAh3U
         +aPiO3Cu5ileiBQVhT/Pt8rugajJGQmVrCd1eETlEEFcFhARSBK0l5v+Uqyf6N1z3a1G
         X+iEpVQVbnCUyEpZsiHaUWDQOxJm1zFUEGcVZjy6YAHeIRhtI2KvoJF6uqos0NIjKLhm
         mc8zCiFZGkt736n3x0TmtPrccTjDXwPRpLGTG2pBSU1dMfEWmwWZ6TH1FQmz7COSgAAh
         3QXrSnMP5Hkn1Kn11SNpPzBlwL8t7+Cc6tyaK/oz+eU9pJFsTfJG9yHhlL0YxJEIVBzg
         RodA==
X-Gm-Message-State: AFuF++mFI+VWXS0aDhxu+ZDtaqiPH4b0Avn865gwmaPtU+mRkaNef7wW
	XqU6h8Gm8BXCDLMc52CH9uthFd3LY9vcJrYpD/cxTyvcqmdFso/PYXuoiRarZwlMASE=
X-Gm-Gg: AYBFou1eWyV5FistCGqWl9p9Hzq6Gc7fpzWZ+P/YY59ls7jFu/q0KQQIAKHehfJ+sMt
	eF8lIA3MPq3iE5lMxMPabm32KjWTeDudVwVlFN6WDYdLlTTWhmDDwT8Arx+lLMBPtQ3rfY9xyEJ
	aT5Vh31xvNyvhJkSlbdu8U94hyHA8EgA2jDTNny7BPykAeIlQspdT6ymp96uJ88MzhrFe9+evnf
	oajT7G7AffbN+wSfZGEAbYMaHvvnH1UzdvTyVRa+qFWkXt5g17t79cJiQOSF1lehWGLKRxH9/wT
	oE+K9NDWerM5oVdZc653t5rD2Rrkf8XL0u6Ubh7cqHBG9Zh8TnzGS6EdI5inN11xk4uUaLC5DH/
	h6PYCekablzri4Ng26et1o7uEMVmzfy0RGfDLDhLbgGHRHpYaNiRunw9Uhsqic/70w2qlK7q5FG
	BwdxLJMx5/kFQyU4U7GDcYTnA/25nDec7PrHi2jsPBLMDOeQVIrdCbEckMMMPX/9vk0WHIvE2m5
	A==
X-Received: by 2002:a05:600c:8b6d:b0:499:a277:e8b5 with SMTP id 5b1f17b1804b1-49cf7fdd67emr472395245e9.3.1788799978274;
        Mon, 07 Sep 2026 09:52:58 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d03543064sm233022415e9.13.2026.09.07.09.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 09:52:57 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 2/7] exec: Clear bprm->mm before dropping its reference
Date: Mon,  7 Sep 2026 19:52:15 +0300
Message-ID: <20260907165220.52431-3-tasos.papagiannnis@gmail.com>
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

Once mmput() drops the final reference to bprm->mm, the pointer must no
longer remain accessible through struct linux_binprm.

The successful exec path and the bprm initialization error path already
clear bprm->mm when ownership is transferred or released. Do the same in
free_bprm() before calling mmput().

This is required for BPF kfuncs where bprm->mm is either NULL or points
to a live mm_struct to ensure safe access.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 fs/exec.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 745f6eb5279e..4ddd403fd91c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1456,9 +1456,12 @@ void bprm_drop_loader(struct linux_binprm *bprm)
 
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

