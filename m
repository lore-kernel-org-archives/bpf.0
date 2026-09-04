Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196BF4CC29F
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533663; cv=none; b=Lh4yyqqQMcF0OXHKUpqv80HmkoK8zyIyD9paTUipUJBjHHIdMAXyL+Bop88+a2VZ5LUbBlknmBubL2q7MyIuai4fF5tOkF9YYkadVC2pT4NFhvdVDK0DefIsGzdI12SVKlJafaM+jyiMuQYWYQpjhvCFAt8fmvxkXxGSwqjzLF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533663; c=relaxed/simple;
	bh=H0PjCPTa3w7wilyel1zRSrNHGZqgVebyP6uA3RW6oM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HcSlJOpLxdr28GQx561JKzHd/yOL/d/hJiWXNn/DPkL1NZ2f5iNrk2y+nOsIo0L9o+szNO7jaNNuGb/Enb31n7FjAYfdadRyOLk38KDRFxCQpvEyFkHs8yvO+Huj6fRae/5RMpNUDxnLPe0GnApPLZLZ72Kp2Ux4pByMVNlsBwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G14j6431; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G14j6431"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4957eefd361so8479125e9.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 07:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788533658; x=1789138458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YZ+Ou2H8lPx1TAAGkvNkr9pKRWk8vksitXFvIwQOCbY=;
        b=G14j6431mqz4DH/V6fLP/ifE9EnEVFaEfHlZ/TYMxgQAanNEZh3NoGFfgvHP7ELxN1
         0RKebuZ//BgOBb05xpqX+5IwL+yl7enc+EkkivO+XKXd/t/NUm+cxzD6OLO5MKQpBwjw
         m/x7sE0yQ/k3TZSkHTD2d5j5o6Z5WSXR1Mg0alFmHomBmkNVBs78REEK9soOXubiWJhd
         IwYH58/KQEjnQNHbU5ff3dWpIFijQR+jjpL2C+kb5bPMlma0Atygl/8Xc3VVbcvZCLb6
         nmcryAivqFz1/T3th74mCr7rCnrXPpADzjrkYzIXwFqP0F2iSAOKnFH4+EQemUyGGkhB
         ggAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788533658; x=1789138458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YZ+Ou2H8lPx1TAAGkvNkr9pKRWk8vksitXFvIwQOCbY=;
        b=ocmbhL+fdXQh+Pmi9MGclCEbhI0pyyHRRi5j+xgXTjowrdN/em7iYkctoPIEKR1s/d
         CA+wXLsu3pyXcfTt0ZKx2E0zjzFkuDgeYXX1NVleuJAB/JC4VPukQ47kJWVwwabvOuK0
         TWxZImdM75cAfxMCbWQlg9cHYzJrxE1zm0hUjUmyq3z9KuOYz3ldhR/IzTpZrb/snWGh
         90CpzKun5vK3Dd1FNyZkTty9CRg1yqkoNnHG+5OkA9R7QOPP96izdGDyx54cjpAD6/Xl
         jX/v/otR4l8Db0Cct7ATtgSya5ApumskktLn6iFqJL/65RCSio45K2gM+WiW4D8Rs8tF
         M8Mg==
X-Gm-Message-State: AFuF++ku2Yce1ywy6J9CRvGyihnyARGylD7j6fjHLnjju5o79d1Q+lkf
	v+eZtRzkQJbB3ohdi3B98FtO5MbBfTd2GcvwF0ops425ab0wrQ2f29J7y9eoWh1/bnM=
X-Gm-Gg: AYBFou2WL/X6MKEPMq6Eir+2pvh+ARMXzPZ5RfKPWWllPxyMsFd/D7q2xJtogG9vhGu
	tODxZjN6d3qohSBO50BIcbr4Q6PEXq4G9XFvqulmAveN01gm1HUoBMV5GL0IBtV6qav4l5HwP4c
	R6te9CgIoVpF5d3Fr0jTp+X0lieLLogI9vsCKiN6UWz4EICnB10i3e1gvk+aDjDy9YnZPSqk0vE
	V5bMDvEgjeF1KWrTtaSKm2OS01iQwbUPuGGQUdHkzZsMjmQdglJ6AogQpr+8J9a6asC6NchIQsc
	x7aq3WSkTOVugqhKn/SMFNaZK12N6DJ9e2uCBT2q67Hy2BJ12ONfM5/GS/xOmkjLf+Z7JJpkima
	u+CBnk0fvkGRdkpG/briOkNyY6mLCbuCVPrvdsm1oZy0is1SnlCarAqu8BMIaBta+t8HamnrelT
	6y8n8Y7+35a6Yqfd15pKlvzfp+eAUy0lRx7ptCeUGddWCskmwc9cHzj//zPryXLbI7xLYgCtvEJ
	A==
X-Received: by 2002:a05:600c:310d:b0:49c:dc14:d681 with SMTP id 5b1f17b1804b1-49cf81e5449mr69837005e9.3.1788533658417;
        Fri, 04 Sep 2026 07:54:18 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885cb03asm6802799f8f.37.2026.09.04.07.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 07:54:17 -0700 (PDT)
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
	sun.jian.kdev@gmail.com,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v4 2/7] exec: Clear bprm->mm before dropping its reference
Date: Fri,  4 Sep 2026 17:53:35 +0300
Message-ID: <20260904145340.40212-3-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904145340.40212-1-tasos.papagiannnis@gmail.com>
References: <20260904145340.40212-1-tasos.papagiannnis@gmail.com>
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

