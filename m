Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370AF5111B2
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910100; cv=none; b=bRZo7Kl2U27gVKNzzf/MfE9g4pvNfZmwz6WosaYjagZvdvas08Um5fDcpnr3xH3r+/qWanMUK7xUURm6K/dEGGD0e3E4cw5hXLDmTyMViQdjZZIG09i7sz/2ulKoNnDAiTLJaHyysc1rMQD75HKYDp9LlR7mfMP30CQbWXqixtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910100; c=relaxed/simple;
	bh=CrnP/j6cbPUgh+l4ikUyaCHY+R2QqsjDap3IgzAfqBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YV2cZWDuQvHsKtK6kKPbJYZlDxpsf05Ft1+HYEPFBlQwReFVczyYmMOHElYXUxhadHnVRxLvx6sg49mD89Jz2bsYpF5P5bZl5NPhzGr2FRrXLtIdgdgcHK/8FS8gT/QyAat0hRJjaZU4DImX+nsgfc4CQ/H/COu9ASUJVU3XorI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0VLgG52; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0VLgG52"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66fca0709caso2586860d50.1
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 09:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791910098; x=1792514898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nd9w4dPTZ+abWi8KVOZVVNdngpKRtmSbi2Eu/1b0iCI=;
        b=G0VLgG52OjWKpAdLzmuQH80aLIwCVuG1I1nJtCY+IWUrOOnRkQqfhpWAzioarCygxk
         +CaTDVXpB9yk+/tDxmMD7psOnSBlFNzQYL+GLIyCtMD3uGFr+B1rIpcD/urYUjIVaDsL
         cjVSty2lQH2eRIr7Uz5ctAv1KsRXkc5OpXR26NIvujiZ+H/vofBXJvEe/j6cbXJaN9n/
         DtJLWSN3efD7r5iVKlovixP5z5dTRFUOBBFp5+/SDkts/D+GVuf3sJ4F7wEtXtqoKXZa
         lF7gJOeNNwXd2/OA1RW2QBf5vrM6ksO5RS0XYIQgJEQsCJAixULRoYgoSC0vQcrMrnSN
         qoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791910098; x=1792514898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nd9w4dPTZ+abWi8KVOZVVNdngpKRtmSbi2Eu/1b0iCI=;
        b=zJGQoVOgNMrRpu0UdTgusHzehqe/IRGMiuJBv7WFOGY/mdzWTErPQllxd+IjhjmFGR
         Y+5Lkm4wkxh0F6sDnxD/kTOUK8OGsFxwFnXvQie/KgNvDJRH+Cei7lUA2Hn7oltap4qH
         pG4GMIoq52lxGxQ1DnlfOnns512YrXQoxiNwN0xfHyA6Wk6Kw+pbGfMXBRVRoxIlh+D/
         jtgJZQtTpuzGLngr8Zdntu4w55Ee5xgtWjjv0+5U42KMxZWaBlgwck87CnHYW04SpiLC
         rW8Ch2JKtt947aK2Rmwh3Q6RXwEXsHzXRzTetvJQTZgzj/9+o+oCXBq5/egKEb069iIh
         TWwQ==
X-Forwarded-Encrypted: i=1; AKwUvBx8y1hAo2Pnjs0phximSvbah+RIHbefYIbSP8ZliuwLp9lbhhMp1uhaR10TbHmHxr+hd34=@vger.kernel.org
X-Gm-Message-State: AFq9FYJgTA1+Q+L64T8JfCcSubOQ0nw2uGB+JpC4YI6Rd+Clr6K/SwJk
	voAE+zk8Gn7aGbOYVVVGoX736XvnpLRFfDvc9LFyQu3o8z2F6/lr6P9h
X-Gm-Gg: AYBFou0u1XdhvC8ocad4M0NP4+MpcnG4YjszgU0MN2pRfRNk0bp6SGiJf1whduQJp5X
	k7c11TOvA3gvODRb6JBVWiETFfCQKoHGcTYSfnJ66CfVbYh/PwV31a1vjz7ZhVhxQ/cNlP3elPv
	/FZjWqya+7mB75/QzewAezynZpDDcj778P1QxxUy+JuQEOdCQq8VrPeGVHp474qie/raAVKujq7
	mhxPb5vPSH33nEjTMh33oMzNleKrvX5A17445kqycrkt6QSwFmGUzwcbuM7XcwCUIhdWNQqd9Oh
	uNe1Gaqb4ivAFNDf7omxPPdCB4FsP9YTjQi2axQcG/IwRMHtjMGC1C9XRGMKhKJARqZ/dyOIVZZ
	NbpWFBy4OVPq5VoMW/69Tk/3GamP8YWhSjmeQ1iKeMgu8cyS8N0WxKeNKSeY/tIGle25XcUIon+
	vrNwZ3ub0N7+NWcpL1RXHqagQ87P96JsOoWXcKWci5DeZLcDTsqleFKscdCFpJhRWxvrxH5o3k
X-Received: by 2002:a05:690e:480d:b0:675:5d66:765f with SMTP id 956f58d0204a3-67936274256mr3383929d50.28.1791910098167;
        Tue, 13 Oct 2026 09:48:18 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:d326:f863:5ae3:683])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67986a89294sm81136d50.15.2026.10.13.09.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:48:17 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v1 01/11] namei: introduce __path_walk_parent()
Date: Tue, 13 Oct 2026 12:47:50 -0400
Message-ID: <20261013164800.2906577-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013164800.2906577-1-utilityemal77@gmail.com>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Song Liu <song@kernel.org>

Factor the step-to-parent logic out of follow_dotdot() into
__path_walk_parent(), which walks a plain struct path to its parent,
crossing mount trees via choose_mountpoint().

This will be used by a VFS ancestor walker serving landlock and BPF.

Suggested-by: Neil Brown <neil@brown.name>
Signed-off-by: Song Liu <song@kernel.org>
[justin: rebased, kept the helper static to namei.c, dropped the
 path_walk_parent() wrapper and the namei.h export]
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 fs/namei.c | 62 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 20a6534ea3ef..808fb4bed7c4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2192,36 +2192,62 @@ static struct dentry *follow_dotdot_rcu(struct nameidata *nd)
 	return nd->path.dentry;
 }
 
-static struct dentry *follow_dotdot(struct nameidata *nd)
+/**
+ * __path_walk_parent - step towards the parent of the given struct path
+ * @path: position to step up from; if it is the root of a mounted tree, it
+ *        is first updated to the mount point that tree is mounted on
+ * @root: boundary not to be crossed; if zero'ed, walk all the way to the
+ *        global root
+ * @flags: %LOOKUP_NO_XDEV returns -EXDEV once @path was updated to a new
+ *         mount; %LOOKUP_BENEATH returns -EXDEV at @root or at the root of
+ *         an unmounted tree, where @path->dentry itself is returned
+ *         otherwise
+ *
+ * Returns: the parent dentry with its refcount incremented, or an ERR_PTR().
+ */
+static struct dentry *__path_walk_parent(struct path *path, const struct path *root, int flags)
 {
-	struct dentry *parent;
-
-	if (path_equal(&nd->path, &nd->root))
+	if (path_equal(path, root))
 		goto in_root;
-	if (unlikely(nd->path.dentry == nd->path.mnt->mnt_root)) {
-		struct path path;
+	if (unlikely(path->dentry == path->mnt->mnt_root)) {
+		struct path new_path;
 
-		if (!choose_mountpoint(real_mount(nd->path.mnt),
-				       &nd->root, &path))
+		if (!choose_mountpoint(real_mount(path->mnt),
+				       root, &new_path))
 			goto in_root;
-		path_put(&nd->path);
-		nd->path = path;
-		nd->inode = path.dentry->d_inode;
-		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
+		path_put(path);
+		*path = new_path;
+		if (unlikely(flags & LOOKUP_NO_XDEV))
 			return ERR_PTR(-EXDEV);
 	}
 	/* rare case of legitimate dget_parent()... */
-	parent = dget_parent(nd->path.dentry);
+	return dget_parent(path->dentry);
+
+in_root:
+	if (unlikely(flags & LOOKUP_BENEATH))
+		return ERR_PTR(-EXDEV);
+	return dget(path->dentry);
+}
+
+static struct dentry *follow_dotdot(struct nameidata *nd)
+{
+	struct dentry *parent;
+
+	if (path_equal(&nd->path, &nd->root)) {
+		/* nd->root is never path_connected()-checked. */
+		if (unlikely(nd->flags & LOOKUP_BENEATH))
+			return ERR_PTR(-EXDEV);
+		return dget(nd->path.dentry);
+	}
+	parent = __path_walk_parent(&nd->path, &nd->root, nd->flags);
+	nd->inode = nd->path.dentry->d_inode;
+	if (IS_ERR(parent))
+		return parent;
 	if (unlikely(!path_connected(nd->path.mnt, parent))) {
 		dput(parent);
 		return ERR_PTR(-ENOENT);
 	}
 	return parent;
-
-in_root:
-	if (unlikely(nd->flags & LOOKUP_BENEATH))
-		return ERR_PTR(-EXDEV);
-	return dget(nd->path.dentry);
 }
 
 static const char *handle_dots(struct nameidata *nd, enum last_type type)
-- 
2.55.0

