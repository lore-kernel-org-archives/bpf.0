Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ADE3309E
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 01:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677255; cv=none; b=bE8R4Pm6ZzWnk3loAyXqOSfTEkeI/cUvCbvbWiqAr8nT0mEPQ7DDPdXqtf53f4Z/VdJdba6nLl49k8EjJaKJ2WkDlfKQpm7wkPiCsq2/aUab4VVD/Rjf9Bc8R/W3T45dISH9veVElWx1RdDlgxxW3JkDqhDEGcu0LJm25ztQa90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677255; c=relaxed/simple;
	bh=eksvIxAmmQXuXXW8c6928tLpQjkLP4OTZFUN7IvQeAw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U3TQ7sAEL5B8eZJnXESJetorimKGnmK5ARYr9+Iy4CVwiHv0rZVE7gCKMEmPpL70awcYcO+rwJvz/KJM8H6LAcf04hjBpA1oJfoFyGv8ZX/KRaZdXIsAz1kOWBxmQeBkz1vbFz/xIEOtdvaQIsRA6wKDRpk6NjwEni5vDhXlZkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=izwZp+BM; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="izwZp+BM"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so2789180276.0
        for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 18:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677252; x=1712282052; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MmbRuGQ/QD3ODDkbWEuu2YWzLi7SZ6xa0DaniExgEL0=;
        b=izwZp+BMYISb1jG3g8WkhEkmwaGBXQcVF5KA84EDfxMQRwssSDCNH2O+QRdsW10UNn
         PvRZ3moPyi8KRkUdsWgMBHi5FCCGG5usvt0qIebLoxhsEqotNFamSD1y/rUbfvnSzzTD
         MdduiNUmO7ZLKHom7E1RRbnsd618QjpJywNm5lft8tiK/KR0DSvaR9cDvZxQEjks6wqw
         67RGbNMYH8plU8rJUsM6OY65jj0Umme/lS/goQG0KCSUljM/0E3ealzhaMDGHYd0rNJo
         OFTrIWkKMPEHHwcqJV38LDPrQ6Xb9fgxmH/j771u/vwBUMsxRKJsaarIeEav1T1jVAXb
         OEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677252; x=1712282052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmbRuGQ/QD3ODDkbWEuu2YWzLi7SZ6xa0DaniExgEL0=;
        b=p7nVYO8+Hie2xP3FDXn0sM1UL37xO3+CERSqwRotdxebtSV+emtkWIXO6qZLo6pm7U
         XLu4tdUK+lYRtfcy6hiSOro1p0oT/dvv+xxv3o/LgF+Z7VkOX+SlrVr00cdTpjW2k0z6
         C6Gcx3QWFpxFjH152Iba+vSgtvjqzrBOD9vRews6EL5VeU1NwEu2ykJR+PugDqBn7KrK
         KwbYV1TQeABOM7VQAEzXVjgysGm4aFIDzDB/FobI3LpRyLeh0jdZ8V8pNOLafU/R4mk1
         t7rlKk8z5RvlqSoIKa7K/R+XhezHqPNhNoKHA4cx5eFeIuPMC5/5zSfSDUAEQ1EpKnHq
         Rw9w==
X-Forwarded-Encrypted: i=1; AJvYcCXmKrC0uL13AJUQsTS001nD9Tuqc63e0b8MpiG3ciFwcheitzg7O5SNRCZUtqnKQW8FHzw9/g1LQcHKJ0pHkSpLvmn+
X-Gm-Message-State: AOJu0Yx4EI7eMZ6oiw+IiZvgVzdXQQ0GbvlVP1Mxx9hP0/xNbXGQvDRb
	jw4S2QnqY0HJvYoImaYyk7M4YPJtFghDzHtZRQN3QBOmMCZsEThqW8RjqayublJpEpFB7HRvkYJ
	EJw==
X-Google-Smtp-Source: AGHT+IHTtbLuJY0/Xd21xc4JGUtsmkGoiiTVX+jnYhPEA0lXMA0moNx8uO5mPUiTFXzzmc0XQmcHJ+pEMF4=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a05:6902:1b84:b0:dcc:e1a6:aca9 with SMTP id
 ei4-20020a0569021b8400b00dcce1a6aca9mr294907ybb.9.1711677252599; Thu, 28 Mar
 2024 18:54:12 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:21 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-7-drosen@google.com>
Subject: [RFC PATCH v4 06/36] fuse-bpf: Don't support export_operations
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
	Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"

In the future, we may choose to support these, but it poses some
challenges. In order to create a disconnected dentry/inode, we'll need
to encode the mountpoint and bpf into the file_handle, which means we'd
need a stable representation of them. This also won't hold up to cases
where the bpf is not stateless. One possibility is registering bpf
programs and mounts in a specific order, so they can be assigned
consistent ids we can use in the file_handle. We can defer to the lower
filesystem for the lower inode's representation in the file_handle.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/fuse/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 6570fe7a9b53..b47b2e41e5e4 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1187,6 +1187,14 @@ static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 	nodeid = get_fuse_inode(inode)->nodeid;
 	generation = inode->i_generation;
 
+#ifdef CONFIG_FUSE_BPF
+	/* TODO: Does it make sense to support this in some cases? */
+	if (!nodeid && get_fuse_inode(inode)->backing_inode) {
+		*max_len = 0;
+		return FILEID_INVALID;
+	}
+#endif
+
 	fh[0] = (u32)(nodeid >> 32);
 	fh[1] = (u32)(nodeid & 0xffffffff);
 	fh[2] = generation;
-- 
2.44.0.478.gd926399ef9-goog

