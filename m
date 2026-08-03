Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DCE3016E7
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 02:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785723408; cv=none; b=hDdUd4UpYfiwuTHGBjBicAaM7Sq+o1TFJbApv9ez+yfUR6KkYHfc9+/mqcaR26IWPCI4x3YjTCAlL+pOcBhmIajVz2SvH47J50NBDCrplkunPmbsUiFla/5ExRthet1tLwyeP14tcVFl1iP4nAL4DnYMepY2uASEtwDa+IncndU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785723408; c=relaxed/simple;
	bh=RRYb10tyvTRL5UWz5J5bnMOkE+LH9Vt9WImlIquTPrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C5FRlllEIKrpwu8FexOG1RmPHY2nrGs8q5eAiF+uNloz1Z+nU8pYmgfOJ9yCTlOY8e9zdN7Grxh3g0PooS7h8tf7azyhQLzItQYdxcF+R1VJTyBBP8RWMtJ3XY+9XNx6ap5lq81QnWpl8aaVCeEQcXFFOx4dY7pHr19V+feOpfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLUkG/yI; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLUkG/yI"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c149c5722so19279201cf.0
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 19:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785723406; x=1786328206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o7IPzqIYzANRwl+glZBHXV1FOqZBxVdlzdTmCQ6WdPA=;
        b=hLUkG/yII2F7Ycci8yOt6VKXhpeW1+pipqDRx+hrQYsyUWbI9cHsbGtIQB/9ZpWh8G
         a4BapcGnEHNGcVc5kV1IgWGMATPsu/HkjOBSryCd/ls2CdnXlunRmyz980//AfVqG49q
         E8LUsAKaG/c1yt3V7PriixjnmYseK9fomHEYopProNfeSBgKyGKa6FQGsX7huuZYDwrh
         Nq+6AbsL3akYoHlaInXi99iI1wUfHPDvdeVd+7QpC+Pz0tLF80YbS8R1YJ6To1cJICzz
         +c6suLsGhdZDHmrEGDC88VC9x5S990IxPqHwbzyCc8hB1u4SwXJK4EqHmONnI5Kz8cLA
         ymZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785723406; x=1786328206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o7IPzqIYzANRwl+glZBHXV1FOqZBxVdlzdTmCQ6WdPA=;
        b=lUDMEZYk9N66FapHsCAXZTkLAfjde7XLX+dt5LqwEKS6d43WaRIuDvTiAO+i/NDzFu
         y699lGr5dDL+ZXdTCm0eCR3B1xMm4PZVvOJrqI90yG+5Uc6/J/tG8+EATs5UpkYtWiIn
         2k00OEfbgW9jX2BRIZ99nIoPgzgdkFSee8VnGWvkACl5GvNR1tIrM+WKFsj+gJQamopL
         Qglicphu/ikjDKqGfTCIC5jnJRItUM/WC2/9yEIJWZ29uATuK9KWht5eoZl3X5fnRbdc
         NQ7GbI5Q78TLx3Yl598XnmAISwriy47ybn+S/TcOW2yWOrVzr+9riloTT+dzaes1PAWl
         MraQ==
X-Gm-Message-State: AOJu0YyTgSWDjUmZg7qeaYLl3bm+iVT6hoLooCA3w1apIMJYTEITnvFn
	9BJzfpIVuqWgd3BXXBABPJw10+MS+RgBDoaLedj+bbs/PCYgQ8xdCcpz/iyd1cVQ
X-Gm-Gg: AR+sD12Ao2HK0eyF/dfJearl2LsnOOch3MdXVONs90rGz8OYPycRnGnYpuhPqKu7ezP
	oQx0s/42RAWU6Z2jga6bHTkC3SwxgeXaEBIR/rh04oHJS30jgkuuy344qIVNyNamMVqNZCTisCe
	8VydSPtDbj210KvF3tP+Q/ZQNcRrdwWpkdOL/hN3rcO4HsE01riXm1eCX29w1SPSDae62/c2pTz
	6v9nojLj89TXKJiyVzjTJgBELc2O3LJDtJIPxJ7ZeiGSTn7j6dJ8wZKZ6uDFsPjEuaie2+itRaw
	7bKC2th6M9TsiCV17omBQnKrnsHXHUvddlIEiOKY0zBkDiMNy6eiXuADTAV5aJFrcBVuzr9TE7/
	tDfUKUBNem4fkrS1P8km5AFavXl8st3yaseONPW9p9c2J6LzHncxcYF4acMSho0bCJCbUFL16wn
	BdjPSTtnrz7a6QPeIrTr+AQOyyxDkBaSqoYGGA/o8xqL5yERTf0Z+vfmRjc1j7Xq4Yh5scPX7vv
	Sz86cY8OatYjuXJbuT5tpKL7ryLCBGW8LbpkOHpwWiRCqHsHVrVESYNR7g4jPE=
X-Received: by 2002:a05:622a:1e10:b0:51b:f992:9e18 with SMTP id d75a77b69052e-52b4c434166mr199095511cf.2.1785723405773;
        Sun, 02 Aug 2026 19:16:45 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908435b609csm64263866d6.26.2026.08.02.19.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 19:16:45 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH bpf-next] bpf: add BPF_F_SEALED flag to seal BPF links at creation
Date: Sun,  2 Aug 2026 22:16:42 -0400
Message-ID: <20260803021643.2189641-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new BPF_F_SEALED flag for BPF_LINK_CREATE that creates the
link permanently sealed. A sealed link can never have its program
replaced via BPF_LINK_UPDATE, can never be detached via BPF_LINK_DETACH,
and holds an extra self-reference that is never released, so the link and
its program attachment persist until the machine reboots, even after user
space closes every fd referring to it. There is no way to unseal a link.

The sealed state is tracked by a new bool field on struct bpf_link.

Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 include/linux/bpf.h            |  2 ++
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/syscall.c           | 41 +++++++++++++++++++++++++++++++---
 tools/include/uapi/linux/bpf.h |  1 +
 4 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7bfc28673124..a9600a1483ec 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1934,6 +1934,8 @@ struct bpf_link {
 	 * link's semantics is determined by target attach hook
 	 */
 	bool sleepable;
+	/* set once by BPF_F_SEALED; blocks update/detach, pins link until reboot */
+	bool sealed;
 };
 
 struct bpf_link_ops {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ffd96e8b920b..8cb30d18fec7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1251,6 +1251,7 @@ enum bpf_perf_event_type {
 #define BPF_F_AFTER		(1U << 4)
 #define BPF_F_ID		(1U << 5)
 #define BPF_F_PREORDER		(1U << 6)
+#define BPF_F_SEALED		(1U << 7)
 #define BPF_F_LINK		BPF_F_LINK /* 1 << 13 */
 
 /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 94091130bcc5..e8bd57d5c907 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3411,6 +3411,7 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
 		seq_printf(m, "link_type:\t<%u>\n", type);
 	}
 	seq_printf(m, "link_id:\t%u\n", link->id);
+	seq_printf(m, "sealed:\t%d\n", READ_ONCE(link->sealed) ? 1 : 0);
 
 	rcu_read_lock();
 	prog = READ_ONCE(link->prog);
@@ -5776,17 +5777,41 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 	return err;
 }
 
+/* Seal the just-created link: take a self-reference that is never released. */
+static void link_seal_fd(int fd)
+{
+	struct bpf_link *link;
+
+	link = bpf_link_get_from_fd(fd);
+	if (IS_ERR(link))
+		return;
+
+	if (!READ_ONCE(link->sealed)) {
+		bpf_link_inc(link);
+		WRITE_ONCE(link->sealed, true);
+	}
+
+	bpf_link_put_direct(link);
+}
+
 #define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.path_fd
 static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 {
 	struct bpf_prog *prog;
+	bool seal;
 	int ret;
 
 	if (CHECK_ATTR(BPF_LINK_CREATE))
 		return -EINVAL;
 
-	if (attr->link_create.attach_type == BPF_STRUCT_OPS)
-		return bpf_struct_ops_link_create(attr);
+	/* Strip BPF_F_SEALED before per-type flag validation. */
+	seal = attr->link_create.flags & BPF_F_SEALED;
+	attr->link_create.flags &= ~BPF_F_SEALED;
+
+	if (attr->link_create.attach_type == BPF_STRUCT_OPS) {
+		ret = bpf_struct_ops_link_create(attr);
+		goto out_seal;
+	}
 
 	prog = bpf_prog_get(attr->link_create.prog_fd);
 	if (IS_ERR(prog))
@@ -5880,6 +5905,9 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 out:
 	if (ret < 0)
 		bpf_prog_put(prog);
+out_seal:
+	if (ret >= 0 && seal)
+		link_seal_fd(ret);
 	return ret;
 }
 
@@ -5932,6 +5960,11 @@ static int link_update(union bpf_attr *attr)
 	if (IS_ERR(link))
 		return PTR_ERR(link);
 
+	if (READ_ONCE(link->sealed)) {
+		ret = -EPERM;
+		goto out_put_link;
+	}
+
 	if (link->ops->update_map) {
 		ret = link_update_map(link, attr);
 		goto out_put_link;
@@ -5984,7 +6017,9 @@ static int link_detach(union bpf_attr *attr)
 	if (IS_ERR(link))
 		return PTR_ERR(link);
 
-	if (link->ops->detach)
+	if (READ_ONCE(link->sealed))
+		ret = -EPERM;
+	else if (link->ops->detach)
 		ret = link->ops->detach(link);
 	else
 		ret = -EOPNOTSUPP;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ffd96e8b920b..8cb30d18fec7 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1251,6 +1251,7 @@ enum bpf_perf_event_type {
 #define BPF_F_AFTER		(1U << 4)
 #define BPF_F_ID		(1U << 5)
 #define BPF_F_PREORDER		(1U << 6)
+#define BPF_F_SEALED		(1U << 7)
 #define BPF_F_LINK		BPF_F_LINK /* 1 << 13 */
 
 /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the

base-commit: 28e911d61d66b92a3bded8b54622ed3cd2795bf6
-- 
2.53.0

