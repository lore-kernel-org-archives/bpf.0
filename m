Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352F253D0DD
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875638; cv=none; b=d/U/Q2p2UN0RapSW5r2NCEJa8dRR/SqSm9kRPtjUGTb+NkE+9AblWLzk6d3ZNLTODBgFp8NQf0XOTO+hwmzGP+LegNIPPO4WSN3qUbYL+TsE4xZp9dICF8WxSbBh/HAjKsrm3CXTze2Ajcg5kKNO/fPWtIsjGks+zRSDjZVCWAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875638; c=relaxed/simple;
	bh=oxBm833C8T+jxHgAdbU6D4xcv4E4TYoli1xZPpTW0yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVe/K90IdI34FtbofSYpNwl3BJlGckthuzjOx+8hgz/1V9i4UC+MnJkr5HM7cCzS/wfMPsf0OBezHBikQSiJJVcHKtIsYIOotXb7Im0GHKwkZ71xBGeDf9hqBlOLN08SUqrlsSt948JiQ6eOmnqv/7+3dVW7WJhKmgA1qO4SIG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAHKORM0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAHKORM0"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-495590dde14so66360375e9.0
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 06:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788875620; x=1789480420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BcITG13Gvl8i0HA4g724jWVmnWns/ceZ5ECxTEaQlok=;
        b=UAHKORM0kC+yDLTSBDKwbIQHuzwkDqVjvc42Yc6/BTSTCwsUv67i+8lEy5PTHIWD/E
         /df1MkiUKxs+pUqsEp3+N0RWfnDljX1cL5QxRJjY4QUP75BGcx52Y0QeOvaLR1bPGIA3
         1tJkOHtIc/mZrIvrTL0idEV5z0njd4/bRq0duTX9hWBOTSTGmDoSFTzRdfWdnNbDY6oW
         qW/+d4Nvt/LI9Y+9LuS7czfbGRWvRLp9dxkq6h9+Zr3rmSvUqD5lDni3v+RDcVmzGXzg
         0zs3USCCPY5HZJF6ciPBUX+sybLXimNq7cCLS6IHliS5xy7+RQZcMcUdkU6GpHwQrA1z
         GpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788875620; x=1789480420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BcITG13Gvl8i0HA4g724jWVmnWns/ceZ5ECxTEaQlok=;
        b=SFUBsbG9PAktdJqewuKay8JS/7PTm7vm6g1Fvi/HcvLa2dH/Ry73NJJ9E1kMJHTwKQ
         wV22rA/nGMw385ZFq6pQ63IZrELK+PZSJG6RTWpP3h7SNtBjZz5r2wNS3E9UvbWmZUhg
         OGNhWpWf5w8CSWryCOtbYyXg4tBrVAxY/D+swjLqveIbvu5PP6+U7phoIPxr8yxLynKE
         6G4ReDjD7oKca8uOPHpibVcYJShOnn1aKX9gCLvBArvi5NuFy0hJ7uARiWPkCiOMC9n8
         KkrS8FbdJXE0aJxYG12t8cY+z933KUyNz2RJrcdh5HeIS4uARFPHKE0sLTWXTroxcSCz
         xHgg==
X-Gm-Message-State: AFuF++kYj6vUEheENU1JRRi5rcFOccfjLqVgpAuEG6C4pNDYseWHNw2o
	I499Al4wxK0Orret2a1PYeU6CQMZaAocUQlOwSJE+JrqFaXdpQnN42CcvcCB7gW0b+g=
X-Gm-Gg: AYBFou0HQRWh4Z862jqoNlex30XBB5S2Y5TLbrJCJRNCLXy2F82XNaVssj2Sba1db1t
	JE1UsH+27W2iIFm18ZGSAoHVrdizrvx5PcP90SBX7NSK5HWSxXA0cNp105ZdXsRTfL3BeWBlTRn
	Bz7QuMQncllirLMSnnvX1WApz7uw7EWBafX2IgbglqgEiOdSr9cj+sO2fEK+76MntF3BYU53i3z
	TgD5jkOD80s2Nuu8q8padKerM1mkmtgnOls9SzrBLUIeEC3iyyeNYrlwiZQFYcGX+YnNnrKgK56
	KYfoXKqtw76EwVFY/PYRq3K1dDAFtjeRWLK09SRhlmxQNmliZqjlBGZkQhA7EOJ/IyDg/jYCZAH
	wSBp4J9jpyV3Q/46y3uD3KMmEIBbfNTV8zba/NZqrQxb/VjTOz1CNQfzs3tLxIrY7MKLkQhwvVU
	Hq92CebeAQoRsFn80laeACNDtH5ZmTMtJpJLku8AhkvCCreWB4GTGZl5c2px4emlkx6p7O4EPFX
	zqwFWPwpBNY
X-Received: by 2002:a05:600c:4e51:b0:49c:ff8d:b548 with SMTP id 5b1f17b1804b1-49cff8db5demr513325935e9.11.1788875620062;
        Tue, 08 Sep 2026 06:53:40 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm377235005e9.3.2026.09.08.06.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:53:39 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 2/5] exec: Clear bprm->mm before dropping its reference
Date: Tue,  8 Sep 2026 16:52:59 +0300
Message-ID: <20260908135302.74963-3-tasos.papagiannnis@gmail.com>
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

