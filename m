Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3FC4F4D1E
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737510; cv=none; b=EBaoscZln/EzjANi4pg05dUFiZSmk82/8nNWCOoZke21pCpTFAWWeulGFFIgL3hIQdOWVbFlFaJm0Md/lkaB57EvVrfiA0LUrNuhLf8apOqeqJRmGxNYa5yz5QaOenpQuqNMWgMZcFHEhy7A+EB/gaH88DanwiJfHHXm+/aMei4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737510; c=relaxed/simple;
	bh=oxBm833C8T+jxHgAdbU6D4xcv4E4TYoli1xZPpTW0yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7uU5Zu689TYltGza1+5RhnIdSi7/nhIRvmLYj/NRnnSuTj7BudIFVs0RZdkRULh6rNN0EYvfMvP1dFoj9i6TaloR+2B/hN1J2b0qSrIUQ130MVjk2a7gt0GSXsxsdeb4SQ8aXhs/b+0aXoVRh6HcgcFXQbhLXYr2rVoa8M9yW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTaCcuRB; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTaCcuRB"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351832so391137f8f.3
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 06:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789737505; x=1790342305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BcITG13Gvl8i0HA4g724jWVmnWns/ceZ5ECxTEaQlok=;
        b=DTaCcuRBPvPuYFBbtD+F2d6f25YKCbNgO+WTHSknWaLBGXmG2OpAVMuYbRsYynbO4p
         hU1O+Ft6/couaczpum1O1Irmi6BiCrWLwe3JmmzyTSmTnWbX3OSF5cdAhQk+Zq6w8bhV
         xU8QUQHZdn7FkIZ2bq2vht8ZC+ZWBDppbH4mZIQqgdyhfcOPRcLsCxY09HIs6SLsLX0A
         SxOyRv9mpuBNhWkhejOxIHV31BjEzumxFZWoq9FL1AYU8q3Bxk7bQFzGkzVuhnk+Mb3H
         MGnlvhPWbb7Fu1CV051czmm0c9C6u4OZdr1w/NJm3TYVpqVwjv1H4C++LhhdUon0Ra+7
         AL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789737505; x=1790342305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BcITG13Gvl8i0HA4g724jWVmnWns/ceZ5ECxTEaQlok=;
        b=CN9f8yFxE9+wX1nzy1J1h6byyegPn+ejbnjXi0rk9tpuLDM0yq4PeyQNllsluEe84B
         HIGngqXiMa78yBU7zATEDhG2KY+Wpn66OI5sFeNcbhdkbrU8b9gjtZryu+e5XJ/sJx58
         3FXr7kxK1ayOd4VNtEmaGPXqe14Idux6jmX++JQul8fPdi3mfEjDCcAcb4M+U8nPpMOY
         h8cr+cHj2+SJQ4QPWDC1b6tKeY9ATkt1fW7gsIcOPU9Q6MLI8YRZtE77cCygddI+W6T9
         oJsqARJFACGGaTefxxjDHsKeg4P+ZpdezjtXhRgSd596yDF9jcd8NwiuZHjoIOVaTc/X
         kblA==
X-Gm-Message-State: AFuF++kPcvbB810WNsBTK/K+dAw/JQGV2xCLVdyr5AvUgPZ5/xw/CaMk
	IdTyVN76sPaCxKQEuYe1DcJRLZr+35Rqs8BgF/nP0y7OzOrCXlxui+S0vDkR7tXU
X-Gm-Gg: AYBFou0/BeNY2Lcawzku8ti765LYSAHJhj5OYr+7XCk/pas0TEMOj6Qjy4uHBMvCN/R
	JJ3PkngA7Dpr6novb+bR4Nf04lqn2U5M5DAA1QlrDsEvj9HUDbpqtPlDFCv/wJKbmv/BYkSk+C4
	bO3Lgf2eg4Yy4f7+N76jtuTRStQburwLYIl7a0YE7P6GML2+Io0W+XVY/gHNZhpAifKAu//D6tZ
	QaougfieHfcial69i9jsVHxOjhUFveT+gBO4cz4Q6EMNFi6Jx/Q1kwhAggDV/z++8nyGK7egJdB
	bej5Br+b4olXzbPzuAhAwAdMKn0XNc4OOiMY/wUexTRi8190FUjkLK25iziHiZ6Xmotyph5MP7J
	xzlOf2RcrU/V4l5su9VyjDwdVCBLUvMdnWLW5YypRZuwNke6lNGKsxz3RdENOU5OVXVrwEONpne
	Od+xgi1zMhew6BF26XA2stIkaWOoyXr1jQYB+6T3jDmmgfkNErP2LtsxVNFj+T6Klsv/1VFaHbT
	wFq9CGVS6HaKppQ2MSp3zWQ4g==
X-Received: by 2002:a05:6000:490d:b0:485:8a47:5b91 with SMTP id ffacd0b85a97d-4871e36cb87mr3143383f8f.46.1789737504555;
        Fri, 18 Sep 2026 06:18:24 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871feb5de3sm4424549f8f.1.2026.09.18.06.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:18:23 -0700 (PDT)
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
Subject: [PATCH bpf-next v9 2/5] exec: Clear bprm->mm before dropping its reference
Date: Fri, 18 Sep 2026 16:17:54 +0300
Message-ID: <20260918131757.42802-3-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918131757.42802-1-tasos.papagiannnis@gmail.com>
References: <20260918131757.42802-1-tasos.papagiannnis@gmail.com>
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

