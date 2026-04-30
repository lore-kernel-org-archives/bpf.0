Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444B93E51C4
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 07:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534734; cv=none; b=cIZxJfAswYpBuHA+kdLTUoW9BlYNjO+O7CxjRgnonUFUl0hIi4cqeF8zxihedhuc8Z+fwbtFyHaR6nLarfprQUdbc5TwH9Q+lElBSpqAkZ2DvpvHkAO0i8OzCPSERO10ysA82EGGvUYg+XCZFExpGkc4nSGUF2+KPF8HNgpuoxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534734; c=relaxed/simple;
	bh=rLFrXBKd6U1Ql5Xj7dlm8IRq37UTdsshIiw7PCrZBug=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Rc2B4oETq3f2lqWmxlzVPYfn2Zgc+ZABwf9weA54wN/Apeg0/PZdIbh7kTLLlqymQAZ00WO70XXW5BL3tvrGRsubHYTtOflLynhn44HfmpwYK2qpiCdhVWpjNm8JDrXyAQVLwU33k9AUe+b0uzraW6T+YjwWD9ARZCpNHhVXolg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oY/vlq0M; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oY/vlq0M"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-672a22b0cd3so615014a12.1
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 00:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777534725; x=1778139525; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=exNiwvjE5zG6+gZ+ceM79Cg2+WwLOuL3DIrvAGPRxQo=;
        b=oY/vlq0MX+NbzU4m4+XKk0VOzbR18F2H/yoUUh2GJB9KVfCTiq8C2sH3SXxUICq5Kh
         /hLyZdUA/Kf/HvLPi07fdDvBbiYEeds0VkMWEZ3AofBUp0OyfjFOxEXzLTzwLc14oUm1
         iHCihGsfq4zHbDetrIbpC8Zu3ZUQK3nCccMXy2zSMemPyj5dIrFh/oH58YLpq7lOGbIA
         ON3eji1SIRmmDY4cy3g/TyDmQma8t/vFqtOm9sjSlaW131NoqLl5bUBZ+JoRWHVlNmzH
         UzCRCw7oUIRsh1ykkgtfzGouuMe1PisUzFesVSTWYTZyuKatEZUb6ABscYKYtNG6vlM6
         pOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777534725; x=1778139525;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=exNiwvjE5zG6+gZ+ceM79Cg2+WwLOuL3DIrvAGPRxQo=;
        b=sKykK5v5fojReYlXPutEDNndHn8Y8o/9ZsAvxPX27HK7PW5//+mnZM5MPNUuyfZwFJ
         Ulwh3sjrsZSRq93ob/b01sbgUEdCqy9jR3vkbgGQ16KE24gJg3I8IpHpMeBQg0I0OYMU
         7tw/wVSKz05U/ReidmOAVndVsuOHRQW65732qJsMT8stWIS64PH7WzyTUberhTEwb5n5
         591o9kjCrL8o40iw4iv25Z5qyp8U2cg8KLGiuPi1nonFzFYhqmAJzeLgOXI54NpLVzTI
         5PNBfrtsEAwzOONp/aPR2nM7rAUkKAKoiz17JiUKFKM3QEkG4+pW/DSMpwrxQxwwliNn
         REIw==
X-Gm-Message-State: AOJu0YwubrYab0PHkz0679xPZaq4agCxjzgfX9aLSAQK3yf2MI0UXCSc
	HfI6f1mhjBQeg9SOXT9OZ3tpSZoOz6L5iP5nEuKFig59Ndc23IsLW+n8zrjrL3LUCROEJ4RqGB0
	5VEjBleWN9A/w0IeIEajOdvI/91XtzHRO8/GprzadWuVpgeKcLrDSEbn0duvS8QiYZiU6JrXoY+
	fVJzIS9m2BblOdHsZy9u9qwLymvRmWHH6FTuq3cgazofYp8w/SYUz82GzjQQk8yhkTQHYTvg==
X-Received: from edgg17.prod.google.com ([2002:a05:6402:1ed1:b0:676:e633:aa4b])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3512:b0:66f:76c8:f747 with SMTP id 4fb4d7f45d1cf-67b5e15c08emr591006a12.6.1777534724433;
 Thu, 30 Apr 2026 00:38:44 -0700 (PDT)
Date: Thu, 30 Apr 2026 07:38:36 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430073836.2894001-1-mattbobrowski@google.com>
Subject: [PATCH bpf-next v2] bpf: fix crash in bpf_[set|remove]_dentry_xattr
 for negative dentries
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matt Bobrowski <mattbobrowski@google.com>, Quan Sun <2022090917019@std.uestc.edu.cn>
Content-Type: text/plain; charset="UTF-8"

bpf_set_dentry_xattr and bpf_remove_dentry_xattr BPF kfuncs attempt to
lock the inode of the supplied dentry without checking if it is
NULL. If a negative dentry is passed (e.g. from
security_inode_create), d_inode(dentry) returns NULL, and
inode_lock(inode) will cause a NULL pointer dereference.

Trivially fix this by adding a NULL check for inode before attempting
to lock it, returning -EINVAL if it is NULL.

Additionally, drop WARN_ON(!inode) in bpf_xattr_read_permission() and
bpf_xattr_write_permission(). These warnings could be triggered by
passing a negative dentry to bpf_get_dentry_xattr() or the _locked
variants of the xattr kfuncs, potentially causing a Denial of Service
on systems with panic_on_warn enabled. Instead, simply return -EINVAL.

Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
Closes: https://lore.kernel.org/bpf/1587cbf4-1293-4e25-ad24-c970836a1686@std.uestc.edu.cn/
Fixes: 56467292794b ("bpf: fs/xattr: Add BPF kfuncs to set and remove xattrs")
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 fs/bpf_fs_kfuncs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 9d27be058494..8642a754b37d 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -100,7 +100,7 @@ static bool match_security_bpf_prefix(const char *name__str)
 
 static int bpf_xattr_read_permission(const char *name, struct inode *inode)
 {
-	if (WARN_ON(!inode))
+	if (!inode)
 		return -EINVAL;
 
 	/* Allow reading xattr with user. and security.bpf. prefix */
@@ -170,7 +170,7 @@ __bpf_kfunc_end_defs();
 
 static int bpf_xattr_write_permission(const char *name, struct inode *inode)
 {
-	if (WARN_ON(!inode))
+	if (!inode)
 		return -EINVAL;
 
 	/* Only allow setting and removing security.bpf. xattrs */
@@ -289,6 +289,9 @@ __bpf_kfunc int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__st
 	struct inode *inode = d_inode(dentry);
 	int ret;
 
+	if (!inode)
+		return -EINVAL;
+
 	inode_lock(inode);
 	ret = bpf_set_dentry_xattr_locked(dentry, name__str, value_p, flags);
 	inode_unlock(inode);
@@ -314,6 +317,9 @@ __bpf_kfunc int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name_
 	struct inode *inode = d_inode(dentry);
 	int ret;
 
+	if (!inode)
+		return -EINVAL;
+
 	inode_lock(inode);
 	ret = bpf_remove_dentry_xattr_locked(dentry, name__str);
 	inode_unlock(inode);
-- 
2.54.0.545.g6539524ca2-goog

