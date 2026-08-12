Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6098432BC1
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533138; cv=none; b=T01dXbpKAyHK4E591tbzzk1jhsJWIQ0sl1lk/QP5OrW4niKTw3kcJbr7pZgczIsfuIxfJwiIJ3EpebL2Fkr0+iy68rA3hgQ8p9wEghwgd2WWHrSP4x5bem4R4uhLvXrGA4ga8qbC5TNuvFHzqjQBPnB2zhs23Q/v632/3R0AwxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533138; c=relaxed/simple;
	bh=k8/yplRnzE3pBIdaL5LYAtd3u12jn0e747+hUY3CrZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C71+lA3+NXc27sxfVPL43K/W1rnnNP8iofs2m3O4gmZr2aBL8sIGrbqQKuT9PkeuGMczGENY24FohyKxWy106J1n0hh9jxDRtMYBQShU3PrQ4q2drbHNe0s69qQc9f6aG6QT+iijIc6jlMbyThL7f7ex1mKKNtTo02lKjUa+Im0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rFFTb4HY; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFFTb4HY"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4813ea321cdso1377878f8f.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 04:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786533135; x=1787137935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ZYIXmkyCBXJa09C5v4nt5nRF4vm0/NWKF3uSvZo5n4=;
        b=rFFTb4HYHa+0hm+npsiUYCcbS0IkUUWJmYJDmPduhEuyWbALQOGMPe3h8d6yi1+P6Y
         PL2fgHbNLpPQ5ZZaXCC1NJdzXjJ43nIzpZC8D5aUFGKKdNeSeS2/ZiD73QaUfVY3U+CQ
         4oHoITtChUXaqWVKeIT+fYNJ0KcTVYfh4CyTM2kRusiuim8sg2NOrz3yC33IcoKRQiMw
         gE0WblKqbekFE3uGWtE4vcZWdJwP9otr331udA0NnrfeANzrHo3G0/FDyrk9sNlzoTEr
         sAHfB5/VvODwsGdkIdhGlrna5mhflMD1D5DK1GOMmx3oSeCUSSwBGHjCkO3zxrST9YmJ
         G46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786533135; x=1787137935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ZYIXmkyCBXJa09C5v4nt5nRF4vm0/NWKF3uSvZo5n4=;
        b=NlcAhD/EyheiRV9avLXYfR3vSQjETCoXRPXqYWEBZ14JzLYEQtQiQolZXt+Pe2lV6d
         OdpGb2GrVbaNHj9Jq5F4REodD0WvcLA2mUCvBiPvI+Q2V+kTOMlS0HFjaP41RYDuBx9m
         sTpPksYagoHgoBxMGgRYv920b0zuFr+oxp0hlH1lNHQW0K31BjRFS/yOoS1X6mhsB1Lz
         eNDhzm6BdVHrjeI9V4PvCgGg73WJuEi3ZA6xl8YgOKrpmRdZ2en/26hEVeSy46Mf3FGH
         AGY+AFHc/2AfNnhJFXR68gd8/g/nNe6jLi27ydaf+QmigMnFjRaETPMErzLvUtmF/BLF
         pscg==
X-Gm-Message-State: AOJu0YxnR2TkEOaWslkd8QmCtsJzF7DAusSCjMJIaOi+WZtyJappcav/
	/d3BRt3W6b7/YwMwtR+s7NxaWQ3CG64mrWgE+EAC1bzyDiJL26Xcn86/Mshh5BR5
X-Gm-Gg: AR+sD10Zf3cpp6e4w8bITTpzZn1lYXL6A8Wp/iFOEaKwxJGV027oXTkAdDKOzJDtErJ
	pDF2rW62lmxhWABslHkajhV54H+oxDFMOMKou9dMeF0WcD80al+dAm7B6D5crLbEIOeURgqC7U0
	kpAAYSK0wXXI0Nw+okSrHFEs8hRWOSSzU+BSG/9nTievBQrTVNDDO4fkAAcMRAipEqc2gLZKWhH
	KgyRRvLs3BcoXiA4mh79PgkkQ4Gsz1hIMzM2Goh2y4Oq/HKVyC1SwrCFtpiOkYm+a+F5Rwz9FXM
	fQNeYTtluZDaT0RdDuE+1HGgeWw/QFJPxcp0skzK1PgjeVkvv1IvtHnUG6+ko8n+cwtm/Sp7YNV
	dlesF1M1bILrZGeuvKXLqb/WZXBv7CnfRQoEZuCNXBKiaO253dxEq+qwu62ItZ9Zf4fb3hu/BPb
	ISJJnh1bnswvD52+PnJAilZgZgK3cajfcJkuYGANtniumafjIB/1mkL1lNZP/Ql+vSP4EatI7LW
	0nR
X-Received: by 2002:a05:600c:1d0a:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-4997c379313mr43300375e9.1.1786533134636;
        Wed, 12 Aug 2026 04:12:14 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5e:1100:7303:647d:7cc4:8552])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997c9417bcsm54830855e9.4.2026.08.12.04.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 04:12:14 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	song@kernel.org,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next 2/3] bpf: Add user memory access kfuncs for linux_binprm
Date: Wed, 12 Aug 2026 14:11:39 +0300
Message-ID: <20260812111140.7762-3-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812111140.7762-1-tasos.papagiannnis@gmail.com>
References: <20260812111140.7762-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When security_bprm_check runs, the arg and env strings for the exec have
been copied into bprm->mm. The new address space has not been associated
yet with a task_struct until exec_mmap(), so existing BPF user memory
helpers can only read from the calling task's old address space.

This patch adds bpf_copy_from_user_bprm() and
bpf_copy_from_user_bprm_str() kfuncs. Both use the mm_struct provided by
struct linux_binprm.

Register these kfuncs only when CONFIG_MMU is enabled. On NOMMU systems,
exec arguments are staged in bprm->page[] rather than mapped in bprm->mm,
so these accessors cannot read them.

bpf_copy_from_user_bprm() has similar semantics as
bpf_copy_from_user_task(). bpf_copy_from_user_bprm_str() copies one
NUL-terminated string and returns its size including the NUL terminator.
It accepts BPF_F_PAD_ZEROS to clear unused destination bytes on success.

This patch registers both kfuncs with KF_SLEEPABLE because accessing the
remote address space can fault. This allows BPF LSM programs attached to
security_bprm_check to read arguments beginning at bprm->p and reject an
exec based on its command-line arguments.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 fs/bpf_fs_kfuncs.c | 112 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index f1863a891db6..74befdadad68 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2024 Google LLC. */
 
+#include <linux/binfmts.h>
 #include <linux/bpf.h>
 #include <linux/bpf_lsm.h>
 #include <linux/btf.h>
@@ -379,6 +380,112 @@ __bpf_kfunc struct inode *bpf_real_data_inode(struct file *file)
 	return d_real_inode(file_dentry(file));
 }
 
+/**
+ * bpf_copy_from_user_bprm - Copy data from a binary parameter address space
+ * @dst:             Destination address, in kernel space
+ * @dst__sz:         Number of bytes to copy
+ * @unsafe_ptr__ign: Source address in the binary parameter address space
+ * @bprm:            Binary parameters whose address space will be used
+ * @flags:           Reserved for future use; must be zero
+ *
+ * Copies data from the nascent address space associated with @bprm. This is
+ * useful for reading the argument and environment strings before the new
+ * address space is installed by exec_mmap(). For example, at the
+ * bprm_check_security LSM hook, @bprm->p points at the first argument string.
+ *
+ * The destination is zeroed if the requested number of bytes cannot be copied
+ * in full.
+ *
+ * Return: 0 on success, -EINVAL if @flags is non-zero, or -EFAULT if the copy
+ * fails or is partial.
+ */
+__bpf_kfunc int bpf_copy_from_user_bprm(void *dst, u32 dst__sz,
+					const void __user *unsafe_ptr__ign,
+					const struct linux_binprm *bprm, u64 flags)
+{
+	struct mm_struct *mm;
+	int ret;
+
+	if (unlikely(flags))
+		return -EINVAL;
+
+	if (unlikely(!dst__sz))
+		return 0;
+
+	mm = bprm->mm;
+	if (!mm) {
+		memset(dst, 0, dst__sz);
+		return -EFAULT;
+	}
+
+	ret = access_remote_vm(mm, (unsigned long)unsafe_ptr__ign,
+			       dst, dst__sz, 0);
+	if (ret != dst__sz) {
+		memset(dst, 0, dst__sz);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+/**
+ * bpf_copy_from_user_bprm_str - Copy a string from binary parameter memory
+ * @dst:             Destination address, in kernel space. This buffer must be
+ *                   at least @dst__sz bytes long
+ * @dst__sz:         Maximum number of bytes to copy, including the trailing NUL
+ * @unsafe_ptr__ign: Source address in the binary parameter address space
+ * @bprm:            Binary parameters whose address space will be used
+ * @flags:           The only supported flag is BPF_F_PAD_ZEROS
+ *
+ * Copies a NUL-terminated string from the nascent address space associated
+ * with @bprm. If the string is too long, @dst is still NUL-terminated unless
+ * @dst__sz is zero.
+ *
+ * If BPF_F_PAD_ZEROS is set, the unused portion of @dst is cleared on success
+ * and all of @dst is cleared on failure.
+ *
+ * Return: The number of copied bytes including the NUL terminator on success,
+ * or a negative error code on failure.
+ */
+__bpf_kfunc int bpf_copy_from_user_bprm_str(void *dst, u32 dst__sz,
+					    const void __user *unsafe_ptr__ign,
+					    const struct linux_binprm *bprm,
+					    u64 flags)
+{
+	struct mm_struct *mm;
+	int ret;
+
+	if (unlikely(flags & ~BPF_F_PAD_ZEROS))
+		return -EINVAL;
+
+	if (unlikely(!dst__sz))
+		return 0;
+
+	mm = bprm->mm;
+	if (!mm) {
+		if (flags & BPF_F_PAD_ZEROS)
+			memset(dst, 0, dst__sz);
+		else
+			*(char *)dst = '\0';
+
+		return -EFAULT;
+	}
+
+	ret = copy_remote_mm_str(mm, (unsigned long)unsafe_ptr__ign,
+				 dst, dst__sz, 0);
+	if (ret < 0) {
+		if (flags & BPF_F_PAD_ZEROS)
+			memset(dst, 0, dst__sz);
+
+		return ret;
+	}
+
+	if (flags & BPF_F_PAD_ZEROS)
+		memset(dst + ret, 0, dst__sz - ret);
+
+	return ret + 1;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
@@ -390,6 +497,11 @@ BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_real_data_inode, KF_SLEEPABLE | KF_RET_NULL)
+#ifdef CONFIG_MMU
+/* NOMMU keeps the staged arguments in bprm->page[], not bprm->mm. */
+BTF_ID_FLAGS(func, bpf_copy_from_user_bprm, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_copy_from_user_bprm_str, KF_SLEEPABLE)
+#endif
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.55.0

