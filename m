Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0348B39EF23
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 20:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773348798; cv=none; b=NWIYOT8CrWaEzu0oD+KH12yswNvx9pJEEP6v3V1uMlmHurMNB6mldlgXv3PUXl8c1+ZR37W3XjTFeQI+sgIIiBG49SX279RLhO5ZwCOMjdGRvju4VcqlCXbpNj1W5qkJJLSu+NJB+qeORdirFpKpxef+6O+DPRIkxk9UWXD/YSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773348798; c=relaxed/simple;
	bh=jywq6ZapvLyqMtdAnKez9k1msXr+I1rB/CIhp8XCZy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ExtDxutihX2znkmKfjyXcfsrCZ4THNPZntaKy/V4rToNRI7P9KlL9ZkhWgk9X0IaAG2rgJe9P2pcs22Vb071EybQDNwhpo01ddzH8qG2bZMDeYN81ZKqp4oBUAOUIrIhowziXR8AdEn/2Fjpuy9Q8gK7d69xbYPegVVHg+em9LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hp6iuEaF; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hp6iuEaF"
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-4673790ab85so1013427b6e.3
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 13:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773348789; x=1773953589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=94uu4mGDGIm3eu56zPwC5IDPU+HLID50cuaKAJHOoY4=;
        b=hp6iuEaFrWHpgdcp+7qPMBAcVhNenyhW1ruHCz6EFPQkaZiaPykGlJW1kaqwHhl8Yq
         paoiX+0Ew2MszifMt3yhvw71nvVZp6Gc3OeBsc5GeDVdegytGRKzCoCZPklwiTz86KDU
         88dBjql6tEVkf7XZZWkr5wsdSA8HF3TFjF9Jj4NCVcuCkVLeaLqKwL6FE5W4FgF2H/eY
         zn1cyUO7dyFHXyKgjDaEZz7tkrj+32Nq38lAicsA0DS7hixnvdDqGJVqcyNyZdTO8St3
         3Rvp9lo/e1HnvBo0PgzvMxpHeh9HZI8u5N6ucdGMa7yxKHO36ferLIqn6R/SolxHwUUz
         L2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773348789; x=1773953589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94uu4mGDGIm3eu56zPwC5IDPU+HLID50cuaKAJHOoY4=;
        b=OGbRb112xgjp0yzqkHqOdqwc6Et221y33EISw5J7wrLAdS0fxb6pO+i4p8ir/dc9iq
         sWsjvsBeFPwnyyU7AF7qlJX9X843G/IAY9ps0nb0o2vXa9m0qQte8c1M4bGeMDwLDwEd
         V0GALRVSpcjELvvL537qRWxVq8Pr7vz3acaQcK5W4D+Seo71I9H6OUvOend+udk1IyKS
         SuqDq+y+/+1Rv4/GbqJ7qQU67zHD76y4qzqPoWzyIBVforG01FejET45FUzHyykaH7Yj
         56zTT3POZKdvUIAzNMryDPFr6lGitcBVTAS0yIvrwFei6lTN1Iwl8TM0rxEKVuB09ox3
         Gbiw==
X-Gm-Message-State: AOJu0YwFnLaQG9X1LZ8pl7xoAgSkFEYm/CWepLY7rH8iahnoY3yYIp2L
	YXluSxQJEqwlyvCfXVI5oO9iSYhUs59pfBL+Ietzg06Qumny/DIr8lK+XIFQVXRqSlM=
X-Gm-Gg: ATEYQzz9IShTE0rJpt5h18p7GCpBd61AUsK7WFKh9qTnAvqQjzg3tREEBf9wfYFlWV4
	yNeXxUnBmIpYQmJNs24KgeDG2e4oCOOWPl97vR7/w5DdFR/fJms7kmu9KTNASQqsvHF7ajfzcgI
	sA4PO90uWNygxR7fSk/h47tI2CXzbvVGPzNdYPcHcTi79w3IRdsX2PDEA17CracdJXNcMPeIXUW
	7pnyhZ2NNkDcu8bVJZVu6SkcyLQG8xTG0nAE1edSGuI4bU9PCZYxZNhE5R69D65yUrP4fOj2G9S
	+wh/ykRMRtzWhV5T0cg8SJgx9k9JLnAhi+P9z6fBgKk0cEg7HY5s4+XqSbAuI09W473VfABgzXx
	pM6xIImJ36SAdft+gydxeqkzggWUZhbAtWeR1tOm9/PkFy6Yyv8q/jwDUfe2asQWvLrvlEeIOkH
	GImuox2OKJ8m1petebk2+XvZbg8QQ2RQ2GZr00PnmW6YtV
X-Received: by 2002:a05:6808:15a2:b0:467:1e5:6766 with SMTP id 5614622812f47-4675766748fmr435692b6e.45.1773348788993;
        Thu, 12 Mar 2026 13:53:08 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:44::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e1fb90csm6513403fac.4.2026.03.12.13.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 13:53:08 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@kernel.org>,
	Gregory Bell <grbell@redhat.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v3] bpf: Release module BTF IDR before module unload
Date: Thu, 12 Mar 2026 13:53:07 -0700
Message-ID: <20260312205307.1346991-1-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4712; h=from:subject; bh=uTKTtXrr/HBsusqh0xHGSq/egWIL4eFKRIomq4ZQJ2g=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpsya3PCV5vyKCywOyAIJimklZVnOXnq1Fzv9Vln3J eF9CxZSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCabMmtwAKCRBM4MiGSL8RylsYD/ sEVm3NzjR4oPdMbHz8M+RdZlafiGLWYhEUGlYjrofONuiwWg2vOJ5YcKF3wsiSKeUYeC/QytewDc05 73B/jMrx6rRjZQvlxoHZjGwCApxjGv8jk2OjPvVHK3B4JUn7S4RK03igJqL3txnCWTsU7jg4HGLaBq nSE48TghWPbkaYnO2ZbUDnEowxSH5wZKYmwJ5XeSWKvvOrxCavyr0CzhgF3b1KNCdosfP/Ce8JOGB2 EsjuKv3uk+pxSSgEBnpOr/br8+fcOvyKv47RzcBPtVXqPwmptcItDgwHD6skXEUBytlLWnjdxtjJ5p 1ROr8Sg1Tw/vntdfHov5kKnDphczvC0ZqJxyoQW5V6gdj1U3wQZbc9C06K4zMYIeTKeX0K5bqQqsQh 6eHmy5ev1kbyCXBpl0dtLDeHn1qtcR+a5nWNhYA4md7tI6QneGitwn82tZR67XSdu96bf7AGe4zJ6x VvdnWZKpNhPrKiENSm1TCHEk1b6Wk5cE91bzahhMJ6/qcLJa8bVYhW+B0PeIUlhkNb7tQLA/PzZY4s sf/43SY3Ohv8M5TDqDyiGFL+3SD+htYrcRfc/1Vp5dddCFX1IdI5UM7jpH5zloIz/bWNh5FQnqsznn YspLAN4cshDoj8Ax04SltD09FZr5H4TQHbddjIN0yxTHGUNkvxMg0r7Ws7jA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Gregory reported in [0] that the global_map_resize test when run in
repeatedly ends up failing during program load. This stems from the fact
that BTF reference has not dropped to zero after the previous run's
module is unloaded, and the older module's BTF is still discoverable and
visible. Later, in libbpf, load_module_btfs() will find the ID for this
stale BTF, open its fd, and then it will be used during program load
where later steps taking module reference using btf_try_get_module()
fail since the underlying module for the BTF is gone.

Logically, once a module is unloaded, it's associated BTF artifacts
should become hidden. The BTF object inside the kernel may still remain
alive as long its reference counts are alive, but it should no longer be
discoverable.

To fix this, let us call btf_free_id() from the MODULE_STATE_GOING case
for the module unload to free the BTF associated IDR entry, and disable
its discovery once module unload returns to user space. If a race
happens during unload, the outcome is non-deterministic anyway. However,
user space should be able to rely on the guarantee that once it has
synchronously established a successful module unload, no more stale
artifacts associated with this module can be obtained subsequently.

Note that we must be careful to not invoke btf_free_id() in btf_put()
when btf_is_module() is true now. There could be a window where the
module unload drops a non-terminal reference, frees the IDR, but the
same ID gets reused and the second unconditional btf_free_id() ends up
releasing an unrelated entry.

To avoid a special case for btf_is_module() case, set btf->id to zero to
make btf_free_id() idempotent, such that we can unconditionally invoke it
from btf_put(), and also from the MODULE_STATE_GOING case. Since zero is
an invalid IDR, the idr_remove() should be a noop.

Note that we can be sure that by the time we reach final btf_put() for
btf_is_module() case, the btf_free_id() is already done, since the
module itself holds the BTF reference, and it will call this function
for the BTF before dropping its own reference.

  [0]: https://lore.kernel.org/bpf/cover.1773170190.git.grbell@redhat.com

Fixes: 36e68442d1af ("bpf: Load and verify kernel module BTFs")
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Reported-by: Gregory Bell <grbell@redhat.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
Changelog:
v2 -> v3
v2: https://lore.kernel.org/bpf/20260312180643.3806586-1-memxor@gmail.com

 * Condition idr_remove(). (Andrii)
 * Use READ_ONCE()/WRITE_ONCE() for btf->id accesses. (Martin)

v1 -> v2
v1: https://lore.kernel.org/bpf/20260312002025.2495953-1-memxor@gmail.com

* Remove special case from btf_free_id(), and call it unconditionally. (Andrii)
---
 kernel/bpf/btf.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4872d2a6c42d..71f9143fe90f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1787,7 +1787,16 @@ static void btf_free_id(struct btf *btf)
 	 * of the _bh() version.
 	 */
 	spin_lock_irqsave(&btf_idr_lock, flags);
-	idr_remove(&btf_idr, btf->id);
+	if (btf->id) {
+		idr_remove(&btf_idr, btf->id);
+		/*
+		 * Clear the id here to make this function idempotent, since it will get
+		 * called a couple of times for module BTFs: on module unload, and then
+		 * the final btf_put(). btf_alloc_id() starts IDs with 1, so we can use
+		 * 0 as sentinel value.
+		 */
+		WRITE_ONCE(btf->id, 0);
+	}
 	spin_unlock_irqrestore(&btf_idr_lock, flags);
 }

@@ -8115,7 +8124,7 @@ static void bpf_btf_show_fdinfo(struct seq_file *m, struct file *filp)
 {
 	const struct btf *btf = filp->private_data;

-	seq_printf(m, "btf_id:\t%u\n", btf->id);
+	seq_printf(m, "btf_id:\t%u\n", READ_ONCE(btf->id));
 }
 #endif

@@ -8197,7 +8206,7 @@ int btf_get_info_by_fd(const struct btf *btf,
 	if (copy_from_user(&info, uinfo, info_copy))
 		return -EFAULT;

-	info.id = btf->id;
+	info.id = READ_ONCE(btf->id);
 	ubtf = u64_to_user_ptr(info.btf);
 	btf_copy = min_t(u32, btf->data_size, info.btf_size);
 	if (copy_to_user(ubtf, btf->data, btf_copy))
@@ -8260,7 +8269,7 @@ int btf_get_fd_by_id(u32 id)

 u32 btf_obj_id(const struct btf *btf)
 {
-	return btf->id;
+	return READ_ONCE(btf->id);
 }

 bool btf_is_kernel(const struct btf *btf)
@@ -8382,6 +8391,13 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			if (btf_mod->module != module)
 				continue;

+			/*
+			 * For modules, we do the freeing of BTF IDR as soon as
+			 * module goes away to disable BTF discovery, since the
+			 * btf_try_get_module() on such BTFs will fail. This may
+			 * be called again on btf_put(), but it's ok to do so.
+			 */
+			btf_free_id(btf_mod->btf);
 			list_del(&btf_mod->list);
 			if (btf_mod->sysfs_attr)
 				sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);
--
2.52.0

