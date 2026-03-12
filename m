Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D667C3FEB2B
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773338809; cv=none; b=PPdpfVeJ5LXXWw1SRkQm87G+g23AcjfdzTEUTV0bzG15RElbG/iNQtqEAeQFsTscjNqRhWbBlBD4lsFjeR+3LVjCfV1ACPZcWTtfkwp4Fz3qHyD97C+I+WIf7XP8OqgGfvNbc1mdqMw4P0JYD14kbFy+k0NGiDrhBMpqAipCx8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773338809; c=relaxed/simple;
	bh=xYmahEBN//NhiPP3kBPaAIO/85/RZ5R0WDc/UvXssjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IBxui5ecWox+Ev8SjIQPw56cIWecW7R+buncc6Rt4w0v7S4gvelYQxM2FYuQtA4Sgeo3PQcpSfF8H2ELUfHjGXRv9ZOrWinDxNQ/szLZsm2vXKO09gi/y74FxkUObwSc89E6J98IA5K+NAy9Q81xh0OxcLANUPRTcFlg/t43u7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRZXGUJi; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRZXGUJi"
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-40ea36b56b7so1007204fac.3
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 11:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773338805; x=1773943605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HzgVMFuhoc+RyjWmP29z2gH+3u85udaHXaBOsDEvRbA=;
        b=iRZXGUJiV2rz01kCPVdn99TWMY0ENkZxKYZNAF0NDMkzOBNckT1Okx7zPdnx4tvMb0
         7h2R7ayM6jaAz1RF1dYpPOY15dhhc0tkbvOXns/a91Q9D2wLyUfFFpIg/AN0kCbLY0qm
         M4g7hGcXJD0Lws6HAOkso6pf5Qx3ydZbp73AvaRvRrgHlB5iUfqZo5tGgnDxPOHPNKuz
         6w+yAl7BMaAEN1dfxt7wy+fT0JHMsXVR6bns4Z8ZSQ+e5BQhm+30tz1TfHejJf6nNCFD
         dhOS7KdDJMHnnpzh/fli6+6mfZv5YPQuNBndzf9zMy/SSWTHzl8h99sH9w+g/eT/5eiZ
         cB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773338805; x=1773943605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzgVMFuhoc+RyjWmP29z2gH+3u85udaHXaBOsDEvRbA=;
        b=Q3PnEY3T0YgeDqggh/JsU7TeSs41kSHAA0jnaJHZayTO4tvDzTjK+iEky3tOGJ6Z1X
         dgCQ1qKgirpXEtbTdLlQJE2biHaJUpNyH2U21Ngf+tNYbPokiyKdV413ITb7++1UJeqc
         cm3hXyNQ5/U+MtOgl4AJHx9JY7mXLKU08Gz53rdqre8Vpml4i7QsbWcIIo6pO1Zvqt0s
         OHrK1gWaTeZwtRTeBFs6RxOZaFery1NWAhbQe8dIc1rPdTJH2zZwoHTmWV/tr/IagPam
         qges5OAO2sBRxKjG/Ow7hbvLnwofHQPxmCvzQ7vlr/HciBP135oKAMtCqM4ET2Z4XpHy
         nCEg==
X-Gm-Message-State: AOJu0YyyX1HtQ9EfjdycdBJ25ul2FXHiWh+ZdIi4IzJf6MUW+LgFRoaY
	mcBQw+B1h0pR29RuS/Zf4eUUWAZIF4eZkEdFKgtifvUdmPjSvsUtFEDSMWR9c2+UsSw=
X-Gm-Gg: ATEYQzzwLkwa2ymbxNOzGZ82Arc7wEsxhKnZjNXENw5XNa5J2BTe6ZK4v564i/4ke3I
	N/Znsdu95tMImunxOd67JeSAL1q4q+g0IOBAeDJcL/2DGu7EPIdnKhqPTkGaUT7afNknIZH66Nn
	rpedcq3g9X5qduyO1IoVnXlXNQjFF3k63IOLMHUxOngquYv67W6h2Lo70H7czbTKgONygr4qL04
	Wljl5kqYsZLXrDURSW7X8w3Uj3lDZgaeKfozX14uiU3huAimKhJwA/fGXlBKtrISx/q+I+R90t2
	JTIpP3Yq+mY+zVezDWmIVVe3A1Ql8NrYdUVtuNiA4iS7WqjH11yxTL44y4m0mmDVvBsA7NPM8fp
	Uisdp3aWuHo96OTDQIMT0HM8Y1btRvOKT6BuS2jHPjVAcfmeX1J5puZsLXqiWMNgyvKz5VVI6lg
	NlcILqkDTGnFKW/cgcEJiW/CZv3TPKDTCttSzjBG48wxnGP1XMaiLGpe8=
X-Received: by 2002:a05:6870:187:b0:404:2fdc:1ac4 with SMTP id 586e51a60fabf-417b918e50dmr140862fac.22.1773338805051;
        Thu, 12 Mar 2026 11:06:45 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e716485sm5248529fac.19.2026.03.12.11.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 11:06:44 -0700 (PDT)
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
Subject: [PATCH bpf v2] bpf: Release module BTF IDR before module unload
Date: Thu, 12 Mar 2026 11:06:43 -0700
Message-ID: <20260312180643.3806586-1-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3783; h=from:subject; bh=0ONKV2LpfgyW+KFW9wePLIFey7ZF9zcy5AITvYTFQUI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpsvrkUMrlc0hH5jGj8p16CtsoeDUs7+nOAAXSqxNF eRLYFumJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCabL65AAKCRBM4MiGSL8RykgyD/ 9rz7Nb6GlJwB0wWBHXnEw6pi4PKEYZXWJ3e8Ij+wTlACkOA4Mrq8SGHMACsh7722yxsMfZwY8mTvZz 5W5penAnw5WTUdkthyl8k7Rxdk5oPByvyMcpFrICp/nsfI//Lz8qP6BgOpsc/SkFrWj+21y6FAY3Ws kqAaBZD53KwHnMIcetcf1UOuoARTiSzvemNKve/T3+WDlcxEJrPjBPLKk435SkgdJh5u+4NYsPU+Fb 0oFJdkkuVgHcPMbJOhhqKpCm1XG7YkLtKnvHg47DuKlAorNMm6dP1qk9FRif/h2m4P8CPypVIK+28n MH/Ea6D13v6+4yT+Ads0WjUS7spqvsWQdTCp5+FHEPjZ/ztMN9fM/C7lDM33aIK7XaPUQ8oMtpa3mb h8xF9CiY0XgZtIpo4u4+WZHO4sOSyfmCSBoZgtWlfl98tuN4TqBIQDp574wr+/8P5hYIrF23gbDUou yn7MyFo/hlL8p3oQv4HNerJGxvkiO+W7PxaB/LUN+Ukxiz+dAlwcXg9EeN1b5inbSq/wwvM1/3C/fJ yrz/PK88bxWFrmy48l4LExRAHyF3Bk+iFtujKqSfno4wpWF4LYWICWIbvWHIwX3NLtvtp7pGixMXJ2 RgC2t2bSZAzQUrL+mJIbtxDfJaJw39afMpvB95ECMiwCDir5gNFNZxRwICKQ==
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
Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Reported-by: Gregory Bell <grbell@redhat.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
Changelog:
v1 -> v2
v1: https://lore.kernel.org/bpf/20260312002025.2495953-1-memxor@gmail.com

 * Remove special case from btf_free_id(), and call it unconditionally. (Alexei)
---
 kernel/bpf/btf.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4872d2a6c42d..d08ae973df69 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1788,6 +1788,13 @@ static void btf_free_id(struct btf *btf)
 	 */
 	spin_lock_irqsave(&btf_idr_lock, flags);
 	idr_remove(&btf_idr, btf->id);
+	/*
+	 * Clear the id here to make this function idempotent, since it will get
+	 * called a couple of times for module BTFs: on module unload, and then
+	 * the final btf_put(). btf_alloc_id() starts IDs with 1, so we can use
+	 * 0 as sentinel value.
+	 */
+	btf->id = 0;
 	spin_unlock_irqrestore(&btf_idr_lock, flags);
 }

@@ -8382,6 +8389,13 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
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

