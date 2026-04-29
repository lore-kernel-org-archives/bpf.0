Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA902FE58C
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 20:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496103; cv=none; b=IdwzRUICwWMJtI/N7odMP/op1xBdAlsap5z3r3b57tigI7rDjMvc8SnwSyakQw3nnVPxfuL+qyljvMXiuDXUgzDUYGIRh0D2bezOlLOdnPEer2PeGNSTDR2U3O8e2Ew5WMN481+qGNXudEI33czLFcDs3lvCbLw5nyoOzdh7yIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496103; c=relaxed/simple;
	bh=Hxjbo3Zx2q/+uXsUBZGF198A7I4kf90j2iYWVhvYYXQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ls8J3Y0GkifOzr9Nm7L/TbgUlhn2wcki8QMRN1i0e/0bFmVsBz6blGoCpVROJqJOsu8hBR8wWXrALnX8lW70Gv6Ssu3fcZ63BRS551xwX/NbyGAf84T99vgNsrKJ+X7psZlUe/uNJUDybYRL4aVmtVZ6m4FHh/grUFjtN8+vb30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dgMltR0k; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dgMltR0k"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b90484c398cso10095666b.3
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777496100; x=1778100900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YWBETTdxULGRSZ3WoX6T32thw9DEb2PF1LKCiPKUtBI=;
        b=dgMltR0klZoUbzf/Qz37Wxgs4AUnnrZQS/bDhiZc/zfV3+TryH5ZM+s1oCZRrHNnj8
         AWcL62/Cn5JKrDBm7H5M6Vo4avY8/+5tF2DzwuGtO+ADwEau98Uknuq81tTkuxBN8dFa
         g1Affl0mJj0cGKtfYp/+wWelimbiWdAn/UnL2CBOF6J/FtE7qIMieqekGUSoLOSFhAYk
         gpyO3kUddzsOrQLRmz0qKdiOHOMRGpvO/7VXQ0ykjh97Ctf41t3VR3lAQnqCLCfD7uUf
         EfniTh8D63sDW1p3N5OjDT3VxhM1vyHG+trVortpbGwpkdseOC6cEH0k8t3hzk5wLsk9
         P46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777496100; x=1778100900;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YWBETTdxULGRSZ3WoX6T32thw9DEb2PF1LKCiPKUtBI=;
        b=GyoA0IJslgsmjNbzZM+IiK8tER9Kkx29dTce8Nm5LzrBnO74fyTqhJdGzoeFmMCJKg
         IrjsVzUo0hLX7Z3a1x/E/NiJkYKu2FEWdVzNwWZNj2dedFJ5S6xZXjk2bcW5eIpC9RE4
         ZTO32Z1ZNxh1FiYHX2W+9NvK33rtdN8w+NkYaAWcJQVXycTnghk9v9AL/Xf3b5g6JqCm
         oIncPhc9DUdr6ucYppGi9wFW0V7RnhuK8XsUJhyZmJnQ5RYKzKqwbhMD4sCcv1IV0ZZ7
         XdVhM9+OGqoRn/EFP5hY5BFUwK9eK8vq5x80xbU+skMQpQxuBvtQWwLjV6XcE0T7wq4t
         KaHA==
X-Gm-Message-State: AOJu0YxJzcIAGpPcOWHIeFQ2dZba485L6zoi7RkPusnlG3dDLSWdelA8
	IwZX7U0uNdCjSJAkf7pex//oSfY4NDox6/idJkr3gmzYbfzpIRWmLQWGnNXnjQ8PVHH3k2r5fVG
	ASImqFi9CxtIPrkVn+UTI9OrYB1O+9wzCmbzwfRc+9l2ERg161vrHk7YF7SXmkXPTNkLUMAITy7
	81u+Uf2J9em66ESGfbhjKiyFf9PclbkbwfHk3kFuBznsobY/88rYS80D4rxrUr6CpnWz421w==
X-Received: from edbbl16.prod.google.com ([2002:a05:6402:2110:b0:678:aaa4:67])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1f08:b0:677:1d09:56e7 with SMTP id 4fb4d7f45d1cf-679bb096ab5mr4971345a12.23.1777496099509;
 Wed, 29 Apr 2026 13:54:59 -0700 (PDT)
Date: Wed, 29 Apr 2026 20:54:38 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260429205438.2601592-1-mattbobrowski@google.com>
Subject: [PATCH bpf-next] bpf: fix crash in bpf_[set|remove]_dentry_xattr for
 negative dentries
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

Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
Closes: https://lore.kernel.org/bpf/1587cbf4-1293-4e25-ad24-c970836a1686@std.uestc.edu.cn/
Fixes: 56467292794b ("bpf: fs/xattr: Add BPF kfuncs to set and remove xattrs")
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 fs/bpf_fs_kfuncs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 9d27be058494..a0d58d5e3022 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
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

