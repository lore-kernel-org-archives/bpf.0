Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168125;
	b=LaIlBS6UFpKXbmQXxKn354IPjGQU829DNkQ3AQ/9AIhb9hwmwXn+5Mr6Hnilbid9+uhf
	 t8NNkT5/GNeM+N6LuR1LU28KraKbzlvNf9NjTB31OA+F1g07O2HKq2qY7xzU9bJawr0q0
	 iuLmdN44z3GPxox79uD0I84kYsk5X5o6jboV7thMnRRAcJfBUIqn4fCPysw8pwSCIdL8W
	 sVLTavzhbJZH572Bxs9lZ460dkyYEOk+3N4ST3HTAO3Tkzu+BvpTzuMpmlHSyGE1Qlpzt
	 0y68T+J/9DkLsLGBQxQcrJj0LNowTKQWQukm4Y4XSFQob+3kSTH1iNv+8nFIhBFOiiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g7RdVn0LMoEs2dfOGDRDG/kF9Dj5nfh11MC5a3PxnCE=;
	b=fD66rovFNKTgS6aptLc8+qfCFplR9/RQ3zltUsMBgNN3aXd7y51o22Y/UEKCrZdxCTY7
	 MGt3+1quVUpImGxR1ymdRIIwfq13IbJaoPlLJ3pvdOPjNpZ98QDCj69OgCeZMDBtbNn9/
	 Pnsrv1ZYvKIjn6jLRLOg8f7qGCfTU+qMAgJgDn660Xq7Pa5pNjQQBMzCkBIZkOR6Ba7wJ
	 uu4LARebEo7WByfNZcE4bLoH3ZaHxLbqXCu26nakHXI+x3vhmHiTaoyNrc+ahUTuxTqJ5
	 6gg/t6xun+MmEleXsowFVRdmBt1Y4unk/da7XdyfRucK1ZlukJO2frm1dmiVnTMXl4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ugbdGhIZ;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2A960A2601
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 09:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA2A960A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ugbdGhIZ
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so7947505e9.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 01:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795168123; x=1795772923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g7RdVn0LMoEs2dfOGDRDG/kF9Dj5nfh11MC5a3PxnCE=;
        b=ugbdGhIZJtUsZ6WmT/mPSVLomwtutW8nQfXgBmaN/lCuuo0bZGq182BQA57yn7pVaC
         Z6R5qYhoRMOxeJhRpOvqVsIpjV08d7+Uan8W2WpX38C9+SXrsN9AgqdLzo/DpaRC2yqO
         VPjdesb9fJ5Nqt6jYpGE+tjW6J88IT9q3w4XMZpxIcvlbxo7TOldCWXXAWZO54Mqu8Im
         xPzuPv2+Up4oCmjtkeGiT71Kcf+V+iKfCIC4nqZHcim7JIVYFjTXEPs39QWlLf/2akQw
         tUFWA67KcNk7jPlSsdJ4aJkkJGv7/rrG92Wk5g+V8sNbdJsd3OawM42PNQYdTIDZG3Kd
         BFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795168123; x=1795772923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g7RdVn0LMoEs2dfOGDRDG/kF9Dj5nfh11MC5a3PxnCE=;
        b=iC7Dy13LoYTHR9xNIHc1F+F08k/WCSVX3FEOW10N8NkSCHYWJxl9OflQqnuLw0qFrP
         Tt61ucS5TAikgnPEYYHgYlvp86Pf6qH4m6k55BQFzQiSs/soDkI2ZIsLUAY3zChJy5zJ
         tZJvmB32LVtaZr0zTKF6hpzjWVVGZjVfnzhUnSfuA//yffxNt/357XQ8xnJuVDWQFaWt
         j17tjbrwbm78Br1BrsQW9t5p8i8AkQ11yo2bekZUHtlyDwvmQvfWf/LfYaTedsaM5LC9
         6glbBQhZDE+LNGzEFPgee65koMzvTTKw/9cKC6AfYdbFEzFytfIQG1oanSzJ7peGIkzq
         sgXw==
X-Gm-Message-State: APuU4Z9V0FXpgJSvGmTUDJKgACJOPp9JGnCBZjWIYwUsMzrYsb5MUJy1
	+9XCeFPpD+qB3BWStpCj/QKbTtItZKK1n3y647u9uN20OzLJ8x/+VvhtB/K8dFpC
X-Gm-Gg: AYBFou3RHy7/Fz/LKMJzxmaS/EY/vovaHeJrUA3WSf84vtygNkLfuPPU4knKfmubq2M
	VHgE7D4557t9dfZlJ2v67EBQhZHg0QMzYfzIfmmmpqAsXmbrxDOMo/blprRTdxYN6lBKEoAC2W+
	TBZij4ghpoiVpKNPpnR6ORhg2Ti3WsgmYTdChR+nBXgjgBB0bhg5QnrQv6rtDQw2o6Xy4NAgWqo
	/0cIY0enHi9yY5mhVBKd3nCD9Gb1k7tAeJuvRkLCeucaAUyO7CLTg3DpCjKyYwz9oquBZAFT041
	ntl6Cb4JMUyhh2Rd3qI2D/Y/7TGV8y7YTYCaCP9gxQQjKdTaoHQTphqS8e9RqdxNzxi3Q1cSuN0
	KhpCWXR54/QOcRF84whPFn6XWiuNcbahyhtqOd0GcrAsGRxONm5sPmk5lM7Y5mCYq+f+OZye1Jh
	8feyv5uqSywW0LOhPw0CYH9Kr6COoKRDBPFSWpm6jFhbI4i4qEdNfOkhum/MCVRw12HPouEIamd
	5YIFCm7wtuhu6sVdD0/z/spGWvovPkXQPAUXdaivbaJeW9J6ac0qpLniCPw66YgHqcb5H1a5oXQ
	byECeSOM5ggOQO1DN1OEYgdN35wHqEC/2OjOAFbLH5o=
X-Received: by 2002:a05:600c:4e16:b0:4bb:6f77:1e35 with SMTP id 5b1f17b1804b1-4bb88810991mr58830945e9.21.1795168122957;
        Fri, 20 Nov 2026 01:48:42 -0800 (PST)
Received: from dell-desktop ([2a02:587:4b42:1400:8199:c552:2b9e:c33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88f635ffsm45137535e9.4.2026.11.20.01.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:48:42 -0800 (PST)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	eddyz87@gmail.com,
	tasos.papagiannnis@gmail.com
Subject: [RFC PATCH 1/2] security: Add hook for unresolved pathname opens
Date: Fri, 20 Nov 2026 11:48:19 +0200
Message-ID: <20261120094820.11929-2-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120094820.11929-1-tasos.papagiannnis@gmail.com>
References: <20261120094820.11929-1-tasos.papagiannnis@gmail.com>
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

Check the copied pathname against the selected base before traversal or
file changes, including O_PATH and O_TMPFILE.

Pass lookup flags so policy can request a referenced retry. Recheck the
base after each restart and cover kernel opens with an explicit root.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 fs/namei.c                    | 15 +++++++++++++--
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      | 10 ++++++++++
 security/security.c           | 27 +++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 925aeb63bfa1..fde11d36d434 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -749,6 +749,7 @@ struct nameidata {
 	} *stack, internal[EMBEDDED_LEVELS];
 	struct filename	*name;
 	const char *pathname;
+	const struct open_flags *open;
 	struct nameidata *saved;
 	unsigned	root_seq;
 	int		dfd;
@@ -768,6 +769,7 @@ static void __set_nameidata(struct nameidata *p, int dfd, struct filename *name)
 	p->dfd = dfd;
 	p->name = name;
 	p->pathname = likely(name) ? name->name : "";
+	p->open = NULL;
 	p->path.mnt = NULL;
 	p->path.dentry = NULL;
 	p->total_link_count = old ? old->total_link_count : 0;
@@ -2716,7 +2718,7 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 		} else {
 			path_get(&nd->path);
 		}
-		return s;
+		goto out;
 	}
 
 	nd->root.mnt = NULL;
@@ -2726,7 +2728,7 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 		error = nd_jump_root(nd);
 		if (unlikely(error))
 			return ERR_PTR(error);
-		return s;
+		goto out;
 	}
 
 	/* Relative pathname -- get the starting-point it is relative to. */
@@ -2784,6 +2786,14 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 			nd->state |= ND_ROOT_GRABBED;
 		}
 	}
+out:
+	if (nd->open) {
+		error = security_file_open_name(nd->name, &nd->path,
+						nd->open->open_flag, nd->open->mode,
+						nd->flags);
+		if (error)
+			return ERR_PTR(error);
+	}
 	return s;
 }
 
@@ -4999,6 +5009,7 @@ static struct file *path_openat(struct nameidata *nd,
 	struct file *file;
 	int error;
 
+	nd->open = op;
 	file = alloc_empty_file(op->open_flag, current_cred());
 	if (IS_ERR(file))
 		return file;
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 87d9d06710cb..3537f2b73d8c 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -213,6 +213,8 @@ LSM_HOOK(void, LSM_RET_VOID, file_set_fowner, struct file *file)
 LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
 	 struct fown_struct *fown, int sig)
 LSM_HOOK(int, 0, file_receive, struct file *file)
+LSM_HOOK(int, 0, file_open_name, const struct filename *name,
+	 const struct path *base, int flags, umode_t mode, unsigned int lookup_flags)
 LSM_HOOK(int, 0, file_open, struct file *file)
 LSM_HOOK(int, 0, file_post_open, struct file *file, int mask)
 LSM_HOOK(int, 0, file_truncate, struct file *file)
diff --git a/include/linux/security.h b/include/linux/security.h
index 40831fab5470..e6c66cf1cd1c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -498,6 +498,9 @@ void security_file_set_fowner(struct file *file);
 int security_file_send_sigiotask(struct task_struct *tsk,
 				 struct fown_struct *fown, int sig);
 int security_file_receive(struct file *file);
+int security_file_open_name(const struct filename *name,
+			    const struct path *base, int flags, umode_t mode,
+			    unsigned int lookup_flags);
 int security_file_open(struct file *file);
 int security_file_post_open(struct file *file, int mask);
 int security_file_truncate(struct file *file);
@@ -1238,6 +1241,13 @@ static inline int security_file_receive(struct file *file)
 	return 0;
 }
 
+static inline int security_file_open_name(const struct filename *name,
+					  const struct path *base, int flags, umode_t mode,
+					  unsigned int lookup_flags)
+{
+	return 0;
+}
+
 static inline int security_file_open(struct file *file)
 {
 	return 0;
diff --git a/security/security.c b/security/security.c
index f6583d507395..d265f9347791 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2742,6 +2742,33 @@ int security_file_receive(struct file *file)
 	return call_int_hook(file_receive, file);
 }
 
+/**
+ * security_file_open_name() - Authorize a pathname open before lookup
+ * @name: kernel copy of the unresolved pathname, which may be empty
+ * @base: starting path selected by the lookup
+ * @flags: effective open flags
+ * @mode: creation mode, including the file type, before applying the umask
+ * @lookup_flags: current pathname lookup flags, including LOOKUP_RCU
+ *
+ * Check the original pathname before lookup, creation, or opening the file.
+ * @base is the starting path for this attempt, or the file itself for an empty
+ * pathname.  This hook also covers O_PATH and io_uring opens.
+ *
+ * This hook must not sleep.  @name and @base are borrowed for the call.  With
+ * LOOKUP_RCU, @base is RCU-protected; otherwise it holds path references.
+ *
+ * Return: 0 to allow the open or -EACCES or -EPERM to deny it.
+ * During RCU walk, -ECHILD requests a referenced retry. A cached-only
+ * lookup returns -EAGAIN instead.
+ */
+int security_file_open_name(const struct filename *name,
+			    const struct path *base, int flags, umode_t mode,
+			    unsigned int lookup_flags)
+{
+	return call_int_hook(file_open_name, name, base, flags, mode,
+			     lookup_flags);
+}
+
 /**
  * security_file_open() - Save open() time state for late use by the LSM
  * @file:
-- 
2.56.0

