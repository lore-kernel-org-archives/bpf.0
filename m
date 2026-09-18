Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB354AF682
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722687; cv=none; b=A1RYRKjxK69N+nVG5OemyQFAPeY008pjyU3SVFX3ok4xAPXTZzjEMVWrwNuFRQoQ02HmjrimyvrPO8HSpC15YU56oiJtlpysGWf/QeyPGfPAXR9zOnmmAl7Y+xZrKJbQyxjKNXLe5ZsLowS1c0Rzst1KKmQtIB/gu7Ub9qSeySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722687; c=relaxed/simple;
	bh=oxBm833C8T+jxHgAdbU6D4xcv4E4TYoli1xZPpTW0yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByN994CayLnOlfmJrPqZ0Ji8biID2EKeDzRww8FAPj9kb2pbPPWTKTuWWlwnmTQDCqU0QL/5qKlsOaj6TK1JkgR3cQ0gc0bbJ0GlFxCJsB2/jUmzGntZzW9JtItr7OBSPhbHpRKpE0pWfYxNxc1h6CjkhPu4RpAudj8VT0thdRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIb6S5VI; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIb6S5VI"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd4ba9f68so6776655e9.1
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 02:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789722684; x=1790327484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BcITG13Gvl8i0HA4g724jWVmnWns/ceZ5ECxTEaQlok=;
        b=FIb6S5VIl9HErXLXf5Fe7PjNK0bfdAWcityzeJbbPZkdgXU2pDq7mjpHJZyLUJjW8q
         SdyZvJddNcR4feZ8rlSEthkn69Qr5BFKlt5pT9FFuIimXOFkeopLSjz8jgeRFt3X2Uvr
         pdNb9HmpLKM1SGHE7kI7qbnQduD8fRQv0MpBaM5NBFAYo9pfoiUSIUkWW0Y86ciVptfW
         jV/OIr9u8w5Ocp8KoYH4Jum21j/3k9Vw1xCDDUIZHXSsjUeWUDwCarbOweFu57yGUsoZ
         d2e+hRuQ/QdfE1yE61YzY0RPRCSunnV+/K8BXUz7e/QdDIUU/zH8G3bpKp4z/KK8yXr+
         ghgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789722684; x=1790327484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BcITG13Gvl8i0HA4g724jWVmnWns/ceZ5ECxTEaQlok=;
        b=1EsjJCwllP+CSLSphp0Rmd7cPE34dGRQzkHhEttVx+vuhp+OHi+Fr4B9LQz8j1Mqzi
         UHFejcCQ+tqeluBIwzNFM0kHLWNfZNqeRTgkA6LZanjSm2Zk0g0Els4HleCXZdGt/Wze
         yclvzYqHtXyNDfOqI2Vl6ufnJcKunLKdbDV2TGGpWG1E0J91Y7rr52qTT6zxk/ys+h1w
         U9pcZ0Ix1QE1Wdn4vvzhtPJXPCNq/pNNCMyOaTwZYpp1YWgdKHypZPS/6nG+cIxcpQb6
         aWwH/rSJzGtLgWtxEyngd2t29FNm9Xsdmzo8iG0WVMmX1ouVjLXfQn+fmTTkgGnQMX5F
         +N1w==
X-Gm-Message-State: AFuF++lWrM8RjT/nlaspE2WsUOJb/ieQkW7PeWO+BWQhfWtO83JiIsYw
	ckT/m8Xv2mYNncs+i2SxZantOVZgVqn5cmZWYKb8pyIMJ8+kBQSywl/4Sowd++hg
X-Gm-Gg: AYBFou0HnrocttP4tYv+kJqUuJuZIQXyLvxqk8ziyNlV0+ANIZGTFG5CxebpMMgVhv+
	lzxZMEw0Gx2JtXkl4HjNAfVGlXNHj680YaZ2BYo852Igd8VITHz9hpK4ZQoZmAwIYijpb0qmpSu
	Hv92P2K2VRXdlN82LIeN5CnpmS4ty59iI8mu8s55V01WKDexEKTGnTn8G5Mz2noDfKSDHb+Qn12
	8DMCcc6JGU02+8ZKtbcXEwYKIY4eSA38+xBEZ63mQfER42djlnfB+ehKY3WKiD8vjfhZDtmDj6u
	mqWeFQPkjNOcijnVHkH7Jkemko68zXpsiTj4dg7IAPJTo7S5L/wUztUIjkdjLpQ+xWRhNgdqHmm
	9sRYFjBwWJDz8Wx1h95XA/Hc0rcX/CpHGUxDdECHzPVyisJwNFP+9297LlFMtrbVQ7MI3dMvfmV
	2pHy9FsODTQKjn/4XkEYu1j4nVVUxENAVq6it5UJV8zE7vGeQdb7oRRBy+U4Y/HocHVUFge6hRU
	K0ckI7lyzhfiyA=
X-Received: by 2002:a05:600c:468c:b0:49d:16df:8521 with SMTP id 5b1f17b1804b1-49fc56811dcmr23639585e9.4.1789722683646;
        Fri, 18 Sep 2026 02:11:23 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd1d0978sm138774275e9.2.2026.09.18.02.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:11:23 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 2/5] exec: Clear bprm->mm before dropping its reference
Date: Fri, 18 Sep 2026 12:10:55 +0300
Message-ID: <20260918091058.297740-3-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918091058.297740-1-tasos.papagiannnis@gmail.com>
References: <20260918091058.297740-1-tasos.papagiannnis@gmail.com>
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

