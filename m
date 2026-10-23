Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790514;
	b=HqK8kmf5emQLH+l99ijlXlYQpXl0zT4mKrnFDILUTID9NKhLclUn2o02BLqa7FsfyQ2f
	 M0ZDiKkjwDt0WEozqmdS2zhZsiw6cC1uQ7dSTtRMwyc8t8pFl+SMtURUnLvgXSHMmK4jP
	 g46JwmltIDCg8g9FmaBRU8s20+Pw4HPn0hinYSzewLWYE14yAI4zcwXbHFXKjvp/jg/66
	 +1eDXApfHGPoPXGYEHVjpC0hxuxgUpsGLqIkO3kGP5kgyjPp0Gd9H2HANERFDmBAGC+gm
	 zVhFXt6BE9jXLrgaJzsYzupzMdgtfBuAh/mi/TGEMywWEBaQ2Zx6WB0TMvJj7Bv/g5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1a/3mJ9RL3VFDriisY8tqDL+U2OMAQiIBsZpKlqSyzw=;
	b=cWiq0u5LK10hKIBckQhCJ1vOTIk9LK0f7nqoKCLHHJzkcz16Da8CQ/BrLCO0c0Ng5g2e
	 RryBvVj3lTUNkiyqeKB8Iez9d8dpDuv9Uvzh6z4KBIgkln89cgopTmvncl7s4ftXYKR/v
	 Y+ZgGroKoU/Vyt+11rkGsj3IIOOsjbKVy0EoUv7nKMuDcWxXsFj4upvIu1UHdmeQsi/BW
	 odhns5fggC+SLoURbAERznlkyvtP9U4zFsuVRv5frPDzCK2byq6172AYDC6bMAG6bSgt8
	 ssfJ3S5ESwPZMlTtLs2cCp4z9CyOAX95lvJTKxQT93ufloWXXcOtqkLJcdbMg+qRnmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=msZiZ7Ik;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ED2606A31A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 21:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3ED2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=msZiZ7Ik
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8ab432273c5so11594437b3.3
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 14:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792790513; x=1793395313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1a/3mJ9RL3VFDriisY8tqDL+U2OMAQiIBsZpKlqSyzw=;
        b=msZiZ7IkzdgIdzr12eFG7R7Q0ZQ9iGurA5K84Ce7CLEnMH8VWvKrXdS3j0Tf6kzFFq
         rFxgf9QiJRF7Nlw8s6zm9cRmyPnR+AXPmdUcl9ymHCq1ZmbcTmfZTzfB6gfEKlZ9d5Wb
         n1q6lOLPKPyxo1XHjUrsPJ56+zpEARb8yF5o7Fkshjr/DqglgtvcWQf7QkXtFrY5ldou
         +r96/sGmgp2UHMJcFU6dcPM/jI+BWuQNy/yQCbzA+VsT30Fj3mPLygMG9IW9vK6e31/M
         dsIfIekKuulOcv4sPiszeFge6EW2nuG4LTwHuR9fc5LPZcEZ6gksxZV0IMUp4AymYKbB
         MC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792790513; x=1793395313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1a/3mJ9RL3VFDriisY8tqDL+U2OMAQiIBsZpKlqSyzw=;
        b=BXmWbCeectHSlza0Ad5Cgdcs0gTAdE0WW2sqXYDH4f3aiYaDqoBRO5RewnGR1EN3Mv
         rDqQFF6Ir9VCBQsIi8qVBgNmSH4xQMEnQO00c907H6dFIk6yyNx8MFq2u3oCaXgdvN/m
         COe6TFMcu01gB2AC4aZdbMaiYj4OITg75UANKTJFTky98QaruEOOFe3izE+Jf8+sp27n
         TYmyQdVMPqI6qN2GlPVakaC/g5gn9SmfeYuacRL7jLbkLjOLWWfJEMVHaR6GFOgLyinq
         mvaE2G7TS9HD0bW94Ab9CzkHJuBEjjhrXRUjVOXfRe/a0vTucalzhaWAnjT1pFJlZiTt
         r1Hg==
X-Forwarded-Encrypted: i=1; AKwUvBwS2/lNX3Tjs4+vKAdbhYWsWOjofR7ENOHhlUjZQMEik45BPwwp87Dk/ta3Blaousj5rEs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgGwWSdCsY97AHeB7XkJsTHVzKV86CmjhbijXMBnCTmsxwFCJU
	1KJlhVZ4PATnghP0JNSU33WrAXfbmA3QpEtNVGJqgvmCgaqvCDpjtSDF
X-Gm-Gg: AYBFou2+k2X5tsGpDJAEJ0ONCOE4zZWJUUb1HMHQClpXeUS5dwcXMSP/LhEEvvU+Qbw
	rmAoJ5IJD1hX0FLwu5Tb/pHKeVHs7elDb1uIYY3rthQ3W+3t7+fkUfk8dyJGDa6i/ojTnFgV74F
	AR2jNdCOl0T98gav6p2tFJWC0ureoHAjtqEGeXycq18ildfbENCBm+f7HDWlVi31OHbi5TWAhjC
	vLVZSwlr6GJHRmJqXmIxmPBcSaQZDDMQ/o2mYlyn59HvM4LWCDaPUxXisqhZPUd/699yaQ2Sghc
	B3xQQAgnNtZ4XVhJTJX86eU/+SaXY1IHahNKqrhK3IlsLtbuhyu+5I5E2yulaWBOn7SNZ21z5u0
	a/aBeJ2JyeqP5ko/YXf5nEizhZlWCoQlLZvQcV4mGYh+/K1/y4amaxiQ52GNxvIZytHNSygAqeR
	kvmP2r4SrDKZxDNIMjp0A5+yICoVW6Ed0jsM75qkkjvmI4JAN8Ej4W7ZU2nx5BMu0VAxTDZl/df
	u4oXQEotXmRNcKhavcB0etPDvdoaJMIJmmFhd3gXc/ZbVNGr9vOOIkGSWw=
X-Received: by 2002:a05:690c:4f90:20b0:8b0:76e5:ecf0 with SMTP id 00721157ae682-8b1669e64a6mr3325417b3.4.1792790512591;
        Fri, 23 Oct 2026 14:21:52 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:35e2:98f8:e90a:1695])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166e46a93sm1915667b3.26.2026.10.23.14.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 14:21:52 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Song Liu <song@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Xu Yunxiang <xyx2021@mail.ustc.edu.cn>,
	Amery Hung <ameryhung@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v3 4/5] bpf: Bind the inode bpf_real_data_inode() returns to the file
Date: Fri, 23 Oct 2026 17:20:40 -0400
Message-ID: <20261023212041.884996-5-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023212041.884996-1-utilityemal77@gmail.com>
References: <20261023212041.884996-1-utilityemal77@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_real_data_inode() returns the inode behind the file's dentry
without taking a reference on it: the file keeps the inode alive. The
verifier types the return as trusted for the whole program, so a
program that acquired the file from bpf_get_task_exe_file() can keep
using the inode after bpf_put_file(), when the file's last reference
may have gone and the inode with it.

Mark the file argument __derives_ret so the returned inode lives
exactly as long as the file does.

Fixes: 3f8c65b06faf ("bpf: have bpf_real_data_inode() take a struct file")
Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 fs/bpf_fs_kfuncs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 08f0847c4970..8b58379536ca 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -480,7 +480,7 @@ __bpf_kfunc int bpf_sock_read_xattr(struct socket *sock, const char *name__str,
 
 /**
  * bpf_real_data_inode - get the real inode hosting a file's data
- * @file: file to resolve
+ * @file__derives_ret: file to resolve, which keeps the returned inode alive
  *
  * Resolve @file to the inode that hosts its data. For a regular file on a
  * union/overlay filesystem this is the underlying (upper or lower) inode that
@@ -491,11 +491,14 @@ __bpf_kfunc int bpf_sock_read_xattr(struct socket *sock, const char *name__str,
  * inode itself is returned; for any file on a non-union filesystem the inode
  * attached to @file is returned.
  *
+ * The returned inode is only valid for as long as the file is: a program
+ * that acquired the file must not use the inode after releasing it.
+ *
  * Return: The inode hosting @file's data, or NULL.
  */
-__bpf_kfunc struct inode *bpf_real_data_inode(struct file *file)
+__bpf_kfunc struct inode *bpf_real_data_inode(struct file *file__derives_ret)
 {
-	return d_real_inode(file_dentry(file));
+	return d_real_inode(file_dentry(file__derives_ret));
 }
 
 __bpf_kfunc_end_defs();
-- 
2.55.0

