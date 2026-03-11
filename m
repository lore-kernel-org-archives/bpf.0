Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC27116132A
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234206; cv=none; b=lSY53SePiTx5P1lT7e22d9XH/uFQwMMwlIClFb9g1nMfPytP8if0MkglFJitPq+uzFWz2tBFcU4frcSzf3zsN8hnSlKysoSW872W4moaQtOc1L20zcL1TRf6hg4O1IlFUdH1HXf587RfKPVw2fMFmTOwzVE7arhi3l2/JUraHR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234206; c=relaxed/simple;
	bh=yaIj6TkF3WZlGHEZ0BzuoLSddMhDcrMceTcLtxUov1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZAis+jrVxt/qeeLux4RNDeEJl9izJwWNmyPl0Wxc0M5PRxG+HpNlAPWNAL2Vp9wpJM2ut+08G51yM6ibQw1CpWjjEPJ0ZCnn5BmzuPA+CiHfGK+oOkczBgAk2XSVglcVDgcEUZj+h3lv6jsJSZoyE9amltj3c7XZMpoPQ7GgXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkG7vfFr; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkG7vfFr"
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-40ef10ec84cso6287898fac.2
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 06:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773234204; x=1773839004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9A3sRRXAA/QsbH7SOuN7o4Eztm2MeRKA+g2QjCnehHQ=;
        b=dkG7vfFr+ERKB+b35LHDKaQZ4+q7Wj9B9zGlmXuMojMxi/5FW1x3MHF+08bJKmVycU
         TBKrrcdiwIwcwJN46XIRwZxc0lwXwmMevLzHf5G+7a3b+b/vRDWc2YFrF0LgRYv9b7jY
         TyY75AHs6nvcm3Aba/BifS4IREoKYjGgk31R4ay0Y/+GvCpLblAihmOvHFG+53jqYLNr
         8MptMz36fzYAkT8EF7gR2VI0wKe9cwtAB/nk3cojEcXiyfIsXd4y8zoQ8YVPRt6prHr8
         CamtJoojP6TJjZ8Tk20Tn7qhVUhYPCOU5FZEsI1bV3ifFbmm7dWg3MhU2Nz5yYbV3EFs
         gewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773234204; x=1773839004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9A3sRRXAA/QsbH7SOuN7o4Eztm2MeRKA+g2QjCnehHQ=;
        b=hyC7Mr7np59MXH2l4Xvr1so5z3CyIekKlmcZchANjaOqHXQGXaMAoUQJsPWfmM3bXu
         UzrRJl0sgaT434rCwK8/0cD+Ph1d4mrUIYz4eeC/fMdkbNxDqkGGd86cm2oFDkm1qh1A
         RVhPkNu54SMj2MegXsK7LD4u9+ZRS6Zk6pKVGd6/2n1tQIc+DBkCNfAWIF3DxthOUASS
         b9cNLUVOOps1Gpd/vagtvu5O1QoBxOaGWtIviLNBFQVtULD+MyGxYqw7v3/LcpPpqkJ+
         a1dt1/5LsVTrjHV9leLLwxLFlb7qndJLcCpO0N5r4FVSWZGPWS73dSiKOAp9Pca3d/qT
         NNCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUD7S9X6F55yqQa4em4+KKahnHvl0XMhOnSRS4Dm4arLpMQX+LIXwK6G0QshqB4CEdxSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+IWfWsZlzZjlPlKTX8o7AGvLkcIPBQyiqXMvsJfoNoqKKLuDl
	vCHQu5S+rsvbxf4nzhtWLPn64andZzT6NjFjhSy7fts1WTSRJCeYyc0a
X-Gm-Gg: ATEYQzy4quIzmGDiyTjae5TnZhfhmME3Cn2iOzxR4lnpoAAXCmLc3EmeurlZ9qpu8b7
	Dc8+0iS8tQ27xIJhR88yaVAit6dU7O/vKybvgLrRvuGpbJpCDue6kIQozdQn4VaRtNCevpOz7iG
	MDWLuoA+dK9hTgX/ma/8btNF8LBwCCQpctyL88ZoFuAkYx765KXw2xpC5ITEEkqjEpxGm4lcj++
	2m67xcwpDZu0J1XuW+8o5nlkI1rm49P/i5MBIjLUABqeaxccvfuTtQmE0J+eImnqs4NvR1idCLW
	ttlWpLmvZIDts2MMD06siyH1o7b5oHPzE6v1ckx1fULZAU5hCfKEDxQPnxnv3pM+0gpHIvayhco
	i1U9JGd3SbPFXSfnz1gVXlwmupJYhnpx0WI5d3Dr90btZWlq6KNRNL89F/0GSIuAB840ZFXB1Ap
	1zQ/YcKofwSMrC1lQv0XygipegNa4xAzEQmN5ulw7l+hDU
X-Received: by 2002:a05:6870:7990:b0:40e:e8eb:b74b with SMTP id 586e51a60fabf-4177c96c6e1mr1535889fac.35.1773234203364;
        Wed, 11 Mar 2026 06:03:23 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:58::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e1f9f86sm2245982fac.2.2026.03.11.06.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 06:03:22 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: martin.lau@linux.dev
Cc: ameryhung@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	grbell@redhat.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	memxor@gmail.com,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH] bpf: Release module BTF IDR before module unload
Date: Wed, 11 Mar 2026 06:03:21 -0700
Message-ID: <20260311130321.1055808-1-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aed1731e-986e-484e-bc16-682b025d26cf@linux.dev>
References: <aed1731e-986e-484e-bc16-682b025d26cf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 09fcbb125155..d18e218049ed 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1883,10 +1883,17 @@ void btf_get(struct btf *btf)
 	refcount_inc(&btf->refcnt);
 }
 
+static bool btf_is_module(const struct btf *btf);
+
 void btf_put(struct btf *btf)
 {
 	if (btf && refcount_dec_and_test(&btf->refcnt)) {
-		btf_free_id(btf);
+		/*
+		 * IDR for module BTFs is freed when module's BTF reference is
+		 * dropped, which may happen before the final put.
+		 */
+		if (!btf_is_module(btf))
+			btf_free_id(btf);
 		call_rcu(&btf->rcu, btf_free_rcu);
 	}
 }
@@ -8383,6 +8390,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			if (btf_mod->module != module)
 				continue;
 
+			/*
+			 * For modules, we do the freeing of BTF IDR as soon as
+			 * module goes away to disable BTF discovery, since the
+			 * btf_try_get_module() on such BTFs will fail.
+			 */
+			btf_free_id(btf_mod->btf);
 			list_del(&btf_mod->list);
 			if (btf_mod->sysfs_attr)
 				sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);
-- 
2.52.0

