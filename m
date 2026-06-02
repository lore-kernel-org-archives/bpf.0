Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF5A364EA4
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 02:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780368784; cv=none; b=ELoM2F3gS9EKoBCuveprDogyI7KjE8trgAro6Az3LzaNz3xd2mXr4xun8q3WMA1Fh7vkKt3tAJnHPLPdaZQAE7FuZzfIxlqGfDzj6siTRQJCu9TNDgh6uSRidD5NY//v9VecEdL9nRyXN1sYVkjboUwTca2AAEyvuCZ2Tfse8+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780368784; c=relaxed/simple;
	bh=nUkOad1LxkDB7InfdFrxWl940SuZWFh0sw52TuN1o+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OrsGkewb9vo2xxvejokaanGfMAp+LPvONdZHqvSHj6SLvDUyjUC2Z+n75GT7ZfY6aGeX1r+pDq8M9kkf83G9pI8SZCiJ5p4oDfe+VZYPVCXvFqhouaw4a5XN6Cwb/seoeucIOg81zCUm+oh5sVXacdIB4W4JCMF69BVHYkOq2e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZ9OgJV7; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZ9OgJV7"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36d98b9aa9aso1885483a91.3
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 19:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780368782; x=1780973582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C6fgJiTa2jS0FzGxL8U4lJxuZ7q1c50NeAFn+D4FX2o=;
        b=RZ9OgJV7nXPkb0jgGvt+P8TzistuDqXtoSnkxdfVbuu7qfukUkLz32LZ0wpksL2tZv
         bWmbRhNF0FWZ9Js+RLT4McatAaNH2nHGpHcmXaFbAisLZAQyEwKkGClqOKVtTeqwDwC/
         AzJNzAJUv6kv4jqKlowY+sCq2HgkYpBKXlgH+F6Bt5TrrSvz0KMB/WO0HFcTnORlFxg0
         dxKb5tWX82/9H32Dv+kgR8Sf9jc8sSmMimcDE77s4Qgq9UjQzOh1wpWWATh/MDDtVxgV
         EKjaGg0dnyq08Pvwp+N+2LjuoeT/JD0l7eMbTN30NxeLkXe8D46NkKacRFbowjLCVjSr
         5bTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780368782; x=1780973582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6fgJiTa2jS0FzGxL8U4lJxuZ7q1c50NeAFn+D4FX2o=;
        b=ggwEXMV3OmFtmebbAcEmnAdfL+8ELY2hfM5ySr4yPssGD8SUzdZmLgPB9D72ed+Hh1
         euGeqCkKixvzXO1PfWRXhndTWN5qNN9m9iX5ZbmUCQPtlO2LsS3dsDT2xbcSsc6qux2Y
         bNPKE0xL0DSmpyREUaRiMhE0c0IBiE127L5dLkQ3K92+w5sUgyVL3TtSNvQ4najgNDT8
         iumJgTAQmsxA50YP+gjBYWocYJJQGXzAnA4+n8cXP2p2JZo684scbKayNVZWpo1Qn1Mp
         LlG0Fx70LCFnmsH63usdIjBirG+jeYC6VaLwF+5nWNWGDrVxOIpym1EFoqn2mmW3vbf3
         qK2Q==
X-Forwarded-Encrypted: i=1; AFNElJ8LnfosO3ye6t4JMGVmU0AqeGHw4Y5kKUSrYlZdCj1Iowh271r+TiwNaS5fXAZ+awVDDr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJfYZMgmfjJK3+434KHYPOmZq/xR7pO4Yvm+1SoQx/wkUvxDQf
	vywcvereY0U7rrRfE6LVeMzVWk5T7AAHlA415uj4gOWNbKedC1jRTQfs
X-Gm-Gg: Acq92OFKQd/rl/OQRXJjm0DhtceSv82mei9vkeDGNnPedv0CDEP/9OCsihCE40RsGal
	pFNG7g6lSdMopMlykch9mYDBMyPwcBifNhiQvuPKT/i8BuC8O5zSFuBH56rGXxOeHKdvKnDcQRp
	qZ4ER0Cu0kVix+6yvKUgGhxS2vEVtKKgFjuPmlJQMA7sq+ifRPNiJLCwuFA0KAdtGAJWAVGvpLN
	pHNIxN5l2pihr8ZeYc+3NvqbB4xEA3PnstGdimFtYKeY5e7AWnIXMh5vybrJ2VIQAPH+9rvxdqY
	yWKZBgu8Vgg6qVskp/JnPMDtxM4qrvg1B+2lRBzhPIvMqxQmooXqEROznow3VtaafQjhXXMfN1J
	vVVioy42KcI/vwKIUu0TNKEL7MzdxyhSd52U3axiwu0iWitZjRVjpIKFII1+HplKC3RAPKiGhwt
	mt2MzHefFMeZsxogrReDZlfn/CMwaZMQzZB703rGlrocAZbT+X+2LoKKIgx5BAWC01/gQ9dIIkL
	BipN552MGH2/wpgKw==
X-Received: by 2002:a17:90b:35c2:b0:36b:8873:d96d with SMTP id 98e67ed59e1d1-36c4ff65291mr12735143a91.11.1780368782123;
        Mon, 01 Jun 2026 19:53:02 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:efe4:e813:1db6:97e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36dd918f4aasm1035573a91.2.2026.06.01.19.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 19:53:01 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	viro@zeniv.linux.org.uk,
	jolsa@kernel.org
Cc: kafai.wan@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jack@suse.cz,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+36e50496c8ac4bcde3f9@syzkaller.appspotmail.com
Subject: [PATCH v2] bpf: fix UAF by restoring RCU-delayed inode freeing in bpffs
Date: Tue,  2 Jun 2026 08:22:49 +0530
Message-ID: <20260602025249.113828-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 4f375ade6aa9 ("bpf: Avoid RCU context warning when unpinning
htab with internal structs") moved inode cleanup from ->free_inode()
into ->destroy_inode() to avoid sleeping in RCU context when calling
bpf_any_put(). However this removed the RCU delay on freeing the
inode itself and the cached symlink body (i_link), both of which
can be accessed by RCU pathwalk (pick_link, may_lookup etc.).

This causes a use-after-free when a concurrent unlinkat() drops the
last inode reference and destroy_inode() frees the inode immediately,
while another task is still walking the path in RCU mode and reads
inode->i_opflags (offset +2) inside current_time() -> is_mgtime().

KASAN reports:
  BUG: KASAN: slab-use-after-free in is_mgtime include/linux/fs.h:2313
  Read of size 2 at addr ffff8880407e4282 (offset +2 = i_opflags)

The rules (per Al Viro):
  ->destroy_inode()  called immediately, can sleep, use for blocking
                     cleanup e.g. bpf_any_put()
  ->free_inode()     called after RCU grace period, use for freeing
                     inode and anything RCU-accessible e.g. i_link

Fix: split the two concerns properly:
  - keep bpf_any_put() in bpf_destroy_inode() since it is blocking
    and needs to run promptly
  - introduce bpf_free_inode() to handle kfree(i_link) and
    free_inode_nonrcu() with proper RCU delay, preventing the UAF

Fixes: 4f375ade6aa9 ("bpf: Avoid RCU context warning when unpinning htab with internal structs")
Reported-by: syzbot+36e50496c8ac4bcde3f9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=36e50496c8ac4bcde3f9
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/all/20260423043906.GN3518998@ZenIV/
Link: https://lore.kernel.org/all/20260602002607.110866-1-kartikey406@gmail.com/T/ [v1]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v2:
  - NAK on v1 fix in fs/namei.c (pick_link) by Al Viro
  - v1 was papering over the symptom not fixing root cause
  - real fix is in kernel/bpf/inode.c as suggested by Al Viro
  - restore ->free_inode() for RCU-delayed inode/symlink freeing
  - keep ->destroy_inode() only for blocking bpf_any_put() cleanup
---
 kernel/bpf/inode.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 25c06a011825..188c774a469c 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -766,10 +766,18 @@ static void bpf_destroy_inode(struct inode *inode)
 {
 	enum bpf_type type;
 
-	if (S_ISLNK(inode->i_mode))
-		kfree(inode->i_link);
 	if (!bpf_inode_type(inode, &type))
 		bpf_any_put(inode->i_private, type);
+}
+
+/*
+ * Called after RCU grace period - safe to free inode and anything
+ *  that might be accessed by RCU pathwalk (inode fields, i_link).
+ */
+static void bpf_free_inode(struct inode *inode)
+{
+	if (S_ISLNK(inode->i_mode))
+		kfree(inode->i_link);
 	free_inode_nonrcu(inode);
 }
 
@@ -778,6 +786,7 @@ const struct super_operations bpf_super_ops = {
 	.drop_inode	= inode_just_drop,
 	.show_options	= bpf_show_options,
 	.destroy_inode	= bpf_destroy_inode,
+	.free_inode	= bpf_free_inode,
 };
 
 enum {
-- 
2.43.0

