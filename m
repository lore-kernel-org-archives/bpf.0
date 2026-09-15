Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D80E3ACEFF
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459417; cv=none; b=ebr8B9ALxgNpSnOOnvNeJB7+XnnflwrfZGy4LgPPj3bfULOPGqVE9WzBODXJpgpkDrndRi7vKig1z3yrP8HaLaPBKCuRhM1Ih03yPMrXwwZXN3udFWHbZoP/NSJdPr/xceXkfavu1vpgzOz77WcH5KYwyWciEX3wrZdksLKLdUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459417; c=relaxed/simple;
	bh=oxBm833C8T+jxHgAdbU6D4xcv4E4TYoli1xZPpTW0yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqYlST/crOFsVCUkDVeq1oZ4NPGipHa1azzs5UxYOI/EA96N2wRvW5dOfkmRSeYPWB1GvKVoWWWPc+Cd5f0cex9llyJVzfeCIeunk/qj6XjYN/WaQR9iGBioAWIW4P5PIioTqUTSBTGnIiwonnpbNsVbzDmRPAhJorEgdcPpUs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWvY3Oh2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWvY3Oh2"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49b965570d7so52970445e9.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 01:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789459411; x=1790064211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BcITG13Gvl8i0HA4g724jWVmnWns/ceZ5ECxTEaQlok=;
        b=IWvY3Oh2hOkMZTpQDhBFLKNByCuBv/M1AtXa7HF///XG3qWAO1LqR35wT2PSYQeoQc
         vEY8/T6TtINWfgTX13h1Cz69IoQTyhrgMs/yWzpTgCg+5F98c0Ap+nX0Jg2PLuaFOrK+
         kyqF8IeofK4zWbLMM1jzkq6kx81NW76Y/3EZ6M7Yg9TLAQgD7/RsU3EG+Wx+gWmXtvX8
         lU5Wus++LBDpryNqS+GZnkpWkbv3u+/z0QryXYrmdiKCbcZ+KDKvoZhfTR4xzukVgJXN
         dBEvqEMDXm1ft4qulXaJDm8KopcfZQoiajqFcsrA8qQtDq2AdDGa6VmIy0rAEdPKYCi2
         3PRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789459411; x=1790064211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BcITG13Gvl8i0HA4g724jWVmnWns/ceZ5ECxTEaQlok=;
        b=c9+8ADg5Ehpr6kwCm/HXl/9eZPnDrbyIF4PHCbIZ0eKdJNsBV6wl7jgNyj2TDULckE
         bB2Jqq8uvq/Vd92erF0rLExdJzcomRIXRznQMIBeV3UNInm8JKvaSO7eMwA3ixtsro6I
         ovlKRZdhQN+Prq7mpKPEnnuaHBSpSlb85bBORPRquZsvvn/ahNhkjAvoHAMeXxTYmKFG
         1jO67QVeyYKVKjdI321BQNje2Bz+6YJA4Hf5CzCooC7ZiWccEC0ZK14qCo8wW854spxW
         SSl9R9VVpF7DpCMwH2NaPAUU22v1UFCHbBemG/vDSjBKfpcFJ7H+hLemsW/Meo0nKwvI
         vBVA==
X-Gm-Message-State: AFuF++ki+AKA+T26MZmZLiKNfV/aBev2/JZcB1td0ZRpUpR/NnWO1IYV
	8hoD3dr+bWvRZl6JYB/67+UFZEWmIKsxMCoKc0WMXF1Ekci8UOKWbYOwKt8XZefSwOQ=
X-Gm-Gg: AYBFou3AxQUGCRfK6K3qDUlBS1x3rJHYaB5OTV7XPMNvtBBshWlwfJQdCpAbKCZmPPs
	l0qVoOd980ehU1K5yccYl3nVOLaviGzQKNKQuokbznH6JF6T3wSoosnzjIulrHaGfQnkqlTJYSY
	XPrSQQOWcgBkVQ33shoI4Iv6kFFcI5m1OXMnhYmuIxurscZycC1ZM3Xa7sE6KNrbeIHhFzd3W8Q
	IyY7AVk3udXqI663ek12/y2nLy7TKmFPFiBl8m3MB5Az6lyNmkJBkNPH7ifsCkQEi2Qcar+hbVz
	X8Psb9g1pg0wF/qUnQEkY/q0fJSaFOzGGTRpus087yJ/Pkk/XXi3qpINbr/I+0PiqYgxJu0Tyqw
	pYw6arH4WzjGfuHvfTeyPsh8PDwXUjKs/z7i9E9hE/QM3d2pn7paZSM7LOg5wbeEWIVQvLuR5Wf
	chxpjsVmF/e69seWukMTJd3kVxBXUjVPXjiAW+YN3KFwC4MD9BLE4UYxj94ebBJrrVWGvgnItSk
	1zI8L1SZR4GhVEfcjMKEiFIM/I=
X-Received: by 2002:adf:e19c:0:b0:487:939:23aa with SMTP id ffacd0b85a97d-487093923e3mr1057036f8f.10.1789459411449;
        Tue, 15 Sep 2026 01:03:31 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb35c071sm33764675f8f.33.2026.09.15.01.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:03:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 2/5] exec: Clear bprm->mm before dropping its reference
Date: Tue, 15 Sep 2026 11:02:52 +0300
Message-ID: <20260915080255.48929-3-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915080255.48929-1-tasos.papagiannnis@gmail.com>
References: <20260915080255.48929-1-tasos.papagiannnis@gmail.com>
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

