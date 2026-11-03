Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1739760A5BE9
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 10:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1739760A5BE9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HVuGw24O
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso2945496a12.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 02:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1793700898; x=1794305698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tKdtG2s6IZ3j7IH/DuwyQ1OpXzzjxl5BXBKUm8dGf6U=;
        b=HVuGw24OF5tV7lS/rJdR15vv8N8owU7Y6aySKXgwyKVOX0chnZXa1Em8+abbAgaekg
         QRGVIf3yUhXI1k6qsWBCyUPwQvq0uVayHZQctHuBqxMcxaTgyfS7odtiM0wb1FrMaxjl
         d29hktLGSKd+nCBvW8Ec60IlmX3fhev7eMo7F2Kkea1rquHKqmI374G7WX58q3xVO+A2
         XZsrA6urKO6PZFd56Sdksv3Ma7JhQYqt/WvxLbVDVotWE5IMvZ1BITOlIcSh0AXfX7lN
         khcexoOY4YghEzIuLoeevP+ARZxwpdanTTYqLgRtMua7EgfPxK8eQKJVJbEvqy1SYsHu
         WkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793700898; x=1794305698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tKdtG2s6IZ3j7IH/DuwyQ1OpXzzjxl5BXBKUm8dGf6U=;
        b=nLMPOIe7ZUqcBnZzRWlEn3p7zMaEYN7Af8+Oxq38wabL1tGz64M7sRm3gYZ895wC6w
         dkTfX+OmPMkaeuNp4AqdzliPxvjyigF/xjVCVCITqBFm8S8tFen3+rzKhv1fwGvcxWej
         hEce+zUzjKchgxYKT17Hhyz79rQ+puACR8cOHhKzpDaylg4LLev6UhufnmCiJ3zWpvTL
         WB7VK9ZvIRrSKDE7O0818nSUK50DbXnNOSE487Y994cF28jhbpt5mx1gbLA7nKtKFBeA
         TU7MJskXWHswoh5oAMpN1BbXzgMM/XsYBZPEgG8zrA9TO5uDE2MLKI5+jM9V8e64aHbY
         crjg==
X-Forwarded-Encrypted: i=1; AKwUvBwv+bo8CjGcIF9ypZiTPfj3EgGAmcHtZDiod5yxA1jNGNrRnEB0V8n5WiuKFIHpOAmUiA8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+NjDW/810RJ1dwCGKM+XIXnAiD6CgxE0BVi5YFmhaEujPKdsrx
	ddBxsgqUSzbXnDAutc415ciWxvTANuCnvgUvfc2lIJ+8VDeb8Y92a+DtKUAJo3Y/9kpb
X-Gm-Gg: AYBFou1X610YtQ5eNdUXdlm3YLosyNcSjY85VI9NHcWYfQYP61VH6cejI4fvUY0ituL
	VAhW4Fw0MpnHr5NDZ0uRMykW5QSlrKQc4we9+DpjSt+NwveRHDnTWNInKcfR3kH4TNj7YhFEN3Y
	ZzdYNwxQq2xlBhmnWDEy2trAIJpIkLvAONLrXVfbHehvdjoWXS63SJjB/cQrz/Kf3mJfE+22/sB
	3jLZ6emyToZBDXlCCrdncc1ussaEtApHH+VoPmh+V58aKNork/5OpWX5almBSk3Lp68lj5ZUxVt
	baggMkOQAz9glggsLhjocSUhkNjdOi0M3LPZgxqbCUgkN1OpdTWjkdfiPUG9QvymC+tYOCGvYhY
	oPPxTMiRwammhr59xXH7fc61as82EQnEQn5ZD6G3Ryt+8mXIbkYnifRfW6Nv+I+aCCQv3eDyYnt
	OJy5AO1oe6PM63OybOrPvA7PdzUqTyUW36wVM1rDhCCSOsbTZQ0UwuaFSIPcl/9eBwGv3t0afNi
	lyn+t8+rEcZFtNLbNPFY27tjrPpFVR9qzrzPKJRsgUe2lEU4hWduV8F0QgShcq/BHNavbgkjR12
	O7EVryXWcIcfsHLoAQd7rGWdQaCGWHIcqs0OVUqp3zbsJtqjst23eGHMK8JP8EZ+YQBlV9YRm7r
	ov6kuPCAx7qTpVhbV//wV
X-Received: by 2002:a17:907:3f88:b0:c48:1977:e1c3 with SMTP id a640c23a62f3a-c4ca7a4e638mr1198543066b.21.1793700898407;
        Tue, 03 Nov 2026 02:14:58 -0800 (PST)
Received: from alex-t14g7.localdomain (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cec189195sm69976366b.86.2026.11.03.02.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:14:57 -0800 (PST)
From: Alexander Mikhalitsyn <alex@amutable.com>
To: ast@kernel.org
Cc: brauner@kernel.org,
	jlayton@kernel.org,
	Alexander Mikhalitsyn <alex@amutable.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: use FS_USERNS_DELEGATABLE for bpffs
Date: Tue,  3 Nov 2026 11:14:05 +0100
Message-ID: <20261103101405.70180-1-alex@amutable.com>
X-Mailer: git-send-email 2.47.3
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

Instead of FS_USERNS_MOUNT we should use recently introduced [1]
FS_USERNS_DELEGATABLE cause it better expresses what we
really want to get there. Filesystem should not be allowed
to be mounted by an unprivileged user, but at the same time
we want to have sb->s_user_ns to point to the container's
user namespace, at the same time superblock should be allowed
be created only if capable(CAP_SYS_ADMIN) check is successful.

Tested and no regressions noticed.

No functional change intended.

Link: https://lore.kernel.org/all/20260129-twmount-v1-1-4874ed2a15c4@kernel.org/ [1]
Signed-off-by: Alexander Mikhalitsyn <alex@amutable.com>
---
 kernel/bpf/inode.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index c6f328e4752e..e8ec41f095fd 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -1188,10 +1188,6 @@ static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct bpf_mount_opts *opts = sb->s_fs_info;
 	struct inode *inode;
 
-	/* Mounting an instance of BPF FS requires privileges */
-	if (fc->user_ns != &init_user_ns && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	sb->s_blocksize = PAGE_SIZE;
 	sb->s_blocksize_bits = PAGE_SHIFT;
 	sb->s_magic = BPF_FS_MAGIC;
@@ -1280,7 +1276,7 @@ static struct file_system_type bpf_fs_type = {
 	.init_fs_context = bpf_init_fs_context,
 	.parameters	= bpf_fs_parameters,
 	.kill_sb	= bpf_kill_super,
-	.fs_flags	= FS_USERNS_MOUNT,
+	.fs_flags	= FS_USERNS_DELEGATABLE,
 };
 
 static void bpf_fs_inode_init_once(void *foo)
-- 
2.47.3

