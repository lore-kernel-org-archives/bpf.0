Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B5A37D104
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936183; cv=none; b=K0TOURtfCQvTDesaySm14pZlf3b9nyywqlPfBO2liysREq8NjOWKeA+cRQ7pWJKb8fSCEPBLyzXruMK+LvCZvHO9ZxstjtUcNn4yiehoPQH58f2RNDIbEQvP6di/+9tSgR06MWDtiTUYGMXDIl1CAi/TdUFfAeSdKOAN74DxPn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936183; c=relaxed/simple;
	bh=TVKoq5h1jzomecxa3xaRUn6UTIH8JTWem80beCKp/Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rkuV8swNMhtbVQW4zkt4oBnmPW495WZR+1m6+7hMwXAJ7tUp8qkuATaZKsuM+7vm9wK8K9BhdjZxGCVQ5DtftBy16TEdG8yNRV7Jm+DghmHbgHcj0pwhsm/hR6TSid8hc4D66zPBZKtXrK5a0n8VFplg2SINet9y3SYFyJPAExg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCLM+hhl; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCLM+hhl"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47fe89fb333so3587993f8f.3
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 23:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788936179; x=1789540979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=34EbQ0kkkdVKw0vcmyhvRZJ8gkzUUK1Hj8AwcwAqHQY=;
        b=XCLM+hhlIAu3BnV8Zjoo9oTiZRr88MLFSB7ARF54ecMSQ8+sSmKKdjFxDetZazi5DN
         FnTPif0083WmqBOAWonLn8mV5ZmcWNIxyjuDujzg2J6lXfV9kXtSHprJvYbMrYZW9n6i
         5AMR+l7sXwP0fSy6PDzHLs1EuMF+fxMkYL+clA9Mbhu0zOdztn0tza/jp3djivtbTutm
         X2pP1JiiwsKV/vYhP1JMjc22U+hhOp+f8Lx+6O+b+ExKgggRfetJfTjrYlmGvMmKTOon
         DCg1TUwb0CufBq5DbL3evtNDiiGrLL1ybWGzrhcXGCqrK83zg4sNdJlbijjOc96ytU5I
         En0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788936179; x=1789540979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=34EbQ0kkkdVKw0vcmyhvRZJ8gkzUUK1Hj8AwcwAqHQY=;
        b=LpGZg16ZJqlU3m5dGxchg3xT3ao/l6r4OK52DzUpeS5YjtrsdPmPDsAaWnlPL/jIRo
         D0RAGFjOIejg0JG7au1kk2ZVCb/p6Ff/qyvB7jrrK2xzDDe7P4Kko/4lANSQBZgvKwDq
         c7KvHh3eFpht0NaD/GokqQ5sM7vE6ABkA8gtlHPw5F/iBLvjQePKGVDw1dZ4Q/HcjHs1
         ksuKgxTMSJFo4Hcgk+Ba9HrvdJ6q2DH78SM9v9BZ9Pj1T+03Lcx34RFn0aRx/3QwaKNt
         0nMJYHGZXiOxSF+7N35oipIPIUsNNI5vUbJ6oS9z+geg0SOFjjzyD6TnCt1otTBt+Qv0
         13mg==
X-Gm-Message-State: AFuF++mgicd7Yt1tHQPZ7sv7wc/++8an66duRnVMhFBkKgcQwXen1O3V
	DSDCVxgRYPugMmsqoS4Zc8rw0cDBI3jkRP/kua3YZr+56FM6uOEoTlDTTljEhKMaYoU=
X-Gm-Gg: AYBFou25uEvUNuBnlLMHgnUew9hzNkwgZ7MLHWrUYI3cjk7vkISfOvU0yuUoExvz+iW
	72UD6gVKYLvFfcUgAXJ2AVrZ6dcK/E3YDI9oVHaVOcwTYtJh5AXMofmpagx/LkOj9ML3W6DpjB/
	VrAwwbvts7EfB7nGLAo9uDPn1KoNZUROggBMky1ZFbbruvVWgzPeOLFYvXIZVEEdWWuSl5pf/D5
	DjIP9wVJwTPaO7q2aDL/0y6ZmEE6DYJ9T9KvVqoPk+ah63NiYlrgAI7hWAHTzbEt3GIpLd+FS8G
	2xsA7u6j4BaJqbLeV0psDU6EkbeCb70A1PhkDbiBNiFRH7i28z9FGHya3pdZJJn/cNierteVrMh
	rtVz1qj7rBiTXDOHnEy+56K94g4uQguo98IeQ2xOQQDbVkR4NURB/D8pu9vD3qBsqJQh0fsC25x
	e2Hc9SC8GFZaFRBkswwYupTtt71AONgYOvEZftIwhXiSUPoAlIOXIk6rs1vv1u1m1f3peCo7Vbx
	M12JCR5FqEd
X-Received: by 2002:a05:600c:8b8c:b0:49c:e3ad:41d3 with SMTP id 5b1f17b1804b1-49cf7f4aea6mr327332105e9.0.1788936179364;
        Tue, 08 Sep 2026 23:42:59 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20dae82csm25030745e9.3.2026.09.08.23.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 23:42:58 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tasos.papagiannnis@gmail.com
Subject: [PATCH] mm/nommu: Reject wrapping ranges in access_remote_vm()
Date: Wed,  9 Sep 2026 09:42:31 +0300
Message-ID: <20260909064231.18693-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NOMMU implementation of access_process_vm() rejects address ranges
whose end wraps around, but access_remote_vm() bypasses this check even
though both functions delegate to __access_remote_vm().

Move the wraparound check into __access_remote_vm() so it applies to
both entry points.

This is originally reported in [1].

[1] https://lore.kernel.org/bpf/4ef240a5bea36ff84df9589671367832860795159386a4c8fba546a0fa8b786f@mail.kernel.org/

Fixes: f55f199b7d76 ("NOMMU: implement access_remote_vm")
Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 mm/nommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 498e01ee40b0..ed44510e3770 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1674,6 +1674,9 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
 	struct vm_area_struct *vma;
 	int write = gup_flags & FOLL_WRITE;
 
+	if (addr + len < addr)
+		return 0;
+
 	if (mmap_read_lock_killable(mm))
 		return 0;
 
@@ -1727,9 +1730,6 @@ int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, in
 {
 	struct mm_struct *mm;
 
-	if (addr + len < addr)
-		return 0;
-
 	mm = get_task_mm(tsk);
 	if (!mm)
 		return 0;

base-commit: 0d9ff90a5422cc7509258aaaba1e7481df4d332a
-- 
2.55.0

