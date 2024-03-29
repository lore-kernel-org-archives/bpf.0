Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D663B290
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 01:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677259; cv=none; b=sZNAhDLYbG0GrkDaxcPbBfrygDccieC57cJT7We5rzJVCVuktc/Ljb5mVWuP7kWpXrofIBG+ZpwAB71Ny+1qBzRHA3FxyvaKrD7DsMHPXZDUx/1vp2FcX/4SS70FQfkeM8zx0u4ULFROOrDE+Hdav/PB6MML0cOb3ValQvDwzMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677259; c=relaxed/simple;
	bh=v5AwnjQKV/7OH7UGGRZtC3sy6l1pNzMEDPgRfXAhH7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HJl9488/ls6e8E4JGjSEYqocOY4LQqF0mJEQRLTCD3xY9wCEzo8suTZa8KslITEz9Z9JodUr5+SPEfZlY4/kx84nvvCXlEfDaVUnD0LtcDywZ7VctJfTtNAsQJjAGTLvv0f90SNZr4mmIlhXIup62imi6E73DAU1uwFiJ07EpDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=imRu2q3Z; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="imRu2q3Z"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6144244c60cso2355737b3.2
        for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 18:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677257; x=1712282057; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1qqFZWrpXHSloU4DHzngdNGiVBp7dRUntmvVSQg8HHI=;
        b=imRu2q3ZUgP4igk/dyN9A0ZpjyHHhMbidocZhV7Q9uzufiZOawkgJjQyO0OMwzyq5u
         D+taXfRplr6J0gESe53K23uhR1J9xFTMLRsDuP5TCj+qwVG0Ynt7RsUsoanoddS0Ybng
         2TR4Yt9CWGPhrDwZpDq/DOY4jZTKZyYio+6xF9myWMZ8I2sTiy3qP5wbPGvInFyHUSpG
         oiTicVQ/LnCeOwSgWZr8UA9ABwT1sMkeEJQek6KJlOoCqdPrsxnfCw2RdMHW8Ozq9Kd3
         GQaJXeCaOKB+/2TJqH5UoHeaNMLJIqTwZOS2DMvtOYIRejWbl2WqbQBkEAO48FDvsiZo
         qinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677257; x=1712282057;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1qqFZWrpXHSloU4DHzngdNGiVBp7dRUntmvVSQg8HHI=;
        b=bT0DuMt6Mp8naWhTDNdq0gaCrQ7kIPAB1neiX6mNppfM3dydoYt4JB1xenOaH1V5sX
         5b0BQURiK9+tyPRkDYH8sZuVpzi9YT6y0WzCuu2rHfO0yc8bZHXXWhAJ9NBERMghRdO0
         4t87fhwVg7a8cDLh+VaRhkdKfTaIQHI+tdexJz64aJPbVUp0I3Rndg3i+x/t6dMsCaYb
         E7rvrLzx5vXL+9vbOqWtJQhnzzgk+JpH9380Bcha2vol1NcimuBNIZLGAjFYHePFqKwv
         /KYF6z6vXaXdvY065ilhW3sDA0hznut+r3hvkhuIZo2WSwFyrnqNslf+xyyiDuZ28/zu
         qtsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe7DKoUoN3VJPYLDUr6RjBesCV3dd5/nTqkYLc+iXdQsaOxkrB6hfV7/RKx3smzmXKzGFDeO8HXdrHobwSmTRNCrOT
X-Gm-Message-State: AOJu0YwOa7l9X8DmOkeVHtI6l9z0SlDnoCBCaNjAGsNiVRPsd9t0Avi3
	WWBxV3V9jgiVaqj/4WPlwjp2QfDnDTxbzH6tEb0GJ8F3SHLMn3JAY669yCCihJ5v5QXG4QJ6g8o
	IPQ==
X-Google-Smtp-Source: AGHT+IEqoqcj1yZ2rfja/2VzBLgaTmhWJV22bhweKMkMmlc4g7KXcHe2vHz2DKsC848nZSKQHKYRB2huEss=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a0d:d816:0:b0:611:a254:8b9 with SMTP id
 a22-20020a0dd816000000b00611a25408b9mr254675ywe.0.1711677257071; Thu, 28 Mar
 2024 18:54:17 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:23 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-9-drosen@google.com>
Subject: [RFC PATCH v4 08/36] fuse-bpf: Partially add mapping support
From: Daniel Rosenberg <drosen@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, 
	Daniel Rosenberg <drosen@google.com>, Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"

This adds a backing implementation for mapping, but is not currently
hooked into the infrastructure that will call the bpf programs.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 41 +++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c    |  6 ++++++
 fs/fuse/fuse_i.h  |  4 +++-
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index a94d99ff9862..331b3f23ef78 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -210,6 +210,47 @@ static void fuse_stat_to_attr(struct fuse_conn *fc, struct inode *inode,
 	attr->blksize = 1 << blkbits;
 }
 
+ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	int ret;
+	struct fuse_file *ff = file->private_data;
+	struct inode *fuse_inode = file_inode(file);
+	struct file *backing_file = ff->backing_file;
+	struct inode *backing_inode = file_inode(backing_file);
+	struct timespec64 mtime, bmtime, ctime, bctime;
+
+	if (!backing_file->f_op->mmap)
+		return -ENODEV;
+
+	if (WARN_ON(file != vma->vm_file))
+		return -EIO;
+
+	vma->vm_file = get_file(backing_file);
+
+	ret = call_mmap(vma->vm_file, vma);
+
+	if (ret)
+		fput(backing_file);
+	else
+		fput(file);
+
+	if (file->f_flags & O_NOATIME)
+		return ret;
+
+	mtime = inode_get_mtime(fuse_inode);
+	bmtime = inode_get_mtime(backing_inode);
+	ctime = inode_get_ctime(fuse_inode);
+	bctime = inode_get_ctime(backing_inode);
+	if ((!timespec64_equal(&mtime, &bmtime) ||
+	     !timespec64_equal(&ctime, &bctime))) {
+		inode_set_mtime_to_ts(fuse_inode, bmtime);
+		inode_set_ctime_to_ts(fuse_inode, bctime);
+	}
+	touch_atime(&file->f_path);
+
+	return ret;
+}
+
 /*******************************************************************************
  * Directory operations after here                                             *
  ******************************************************************************/
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 41a2e88e8646..b15a0c30fec8 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2486,6 +2486,12 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 	if (FUSE_IS_DAX(file_inode(file)))
 		return fuse_dax_mmap(file, vma);
 
+#ifdef CONFIG_FUSE_BPF
+	/* TODO - this is simply passthrough, not a proper BPF filter */
+	if (ff->backing_file)
+		return fuse_backing_mmap(file, vma);
+#endif
+
 	if (ff->open_flags & FOPEN_DIRECT_IO) {
 		/* Can't provide the coherency needed for MAP_SHARED
 		 * if FUSE_DIRECT_IO_ALLOW_MMAP isn't set.
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 08ee98b7bb95..5f76ba3c1e4b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1455,7 +1455,9 @@ static inline int fuse_bpf_access(int *out, struct inode *inode, int mask)
 
 #endif // CONFIG_FUSE_BPF
 
-int fuse_handle_backing(struct fuse_bpf_entry *feb, struct path *backing_path);
+ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma);
+
+int fuse_handle_backing(struct fuse_bpf_entry *fbe, struct path *backing_path);
 
 int fuse_revalidate_backing(struct dentry *entry, unsigned int flags);
 
-- 
2.44.0.478.gd926399ef9-goog

