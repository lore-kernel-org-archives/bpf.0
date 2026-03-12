Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50236E573
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 00:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773274829; cv=none; b=LCwEyWzzCbn78nQpmIRaCIWuk0noByZZIXPKWxdoYJNgivCOYLLFi0FaM4BUsVDPh67yxhEaV/hyTrfTBkTiYWtjWw5tTt9jCMDWdUQWfs1vW8eh3Hu10SLjSVbwPjQ8vrIqzaBVUB7Ufk3heMsOgGrzoyBjr5TBKXzwbBpW8hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773274829; c=relaxed/simple;
	bh=0q1p1I8V8NWcVsAGF5zhAD0PxIzDPQDF1GEMjzFVr7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B8Xstd342m9r6QYcmuzD+6sx7SQHVwf+cqaEdCnIRycpx1g3nbm0SsSOJxmG5WglINAVaV5Ck5xegJ/BfgSw62TGHnrFq/8plYg+6OYpQCyJRS/uNKsXpD7bTNNrJYPQumUEk4AQDkMmEqYPudPmj59mNXCFQRcHyKP2cEh3z1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWMN/cOY; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWMN/cOY"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7d75e74f5adso533185a34.3
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 17:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773274827; x=1773879627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5oaVI5UBskb9+c6jC/AvnmFvsq4R1bBswGVFuTNgbZs=;
        b=JWMN/cOY5YoZceEyySZiRudw415Z3fYVRzttM+9VPzUKKflBvaEdvaE0oU82/YbjnH
         WNcgVKGj3lISFb27U0cDqTE4DeC4NJx+QIIAjT/jyYqgw8RFyYqcJOelqVe44JbEqTYh
         I4oD8xobKPSIgOej2e9i9nXxlZmdfHNAhKcm6i1+DyhbuOROH1aOb8YDIPQCF8jiz9oM
         g1oXz4S3gajYjsS7JUErSjAN/ojWmFLC9tBRQDIrU4MHo4dNJBZF3dS9ogTdmqKHXUN+
         QViTLrfite8bpkYY0Nvg6jM+/2NSN9oXWxsBTSsz/nvPA7QDg7AHt5nZOOcmmnFDGFzA
         RCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773274827; x=1773879627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oaVI5UBskb9+c6jC/AvnmFvsq4R1bBswGVFuTNgbZs=;
        b=t9SmBSe3t05ZdgoAYS86UrjdA1ivzByCJu+7BgXtN0TlEAH3C2QeDWH3xoanKEtuuy
         oTub5i0afzBQ/aFLftSC1zU7LdYy8sbAXELD0wemRvHl0vTOWQGMB6bsIparuokizBlK
         tbRyHisau4aw3jOYsIwmVSfD2XO2xo8XEDQ/eKDsNa6eeC85eyUzmmvwlkTglwsjvdCK
         8Mz8lAvtdqke9dsoHBUiJSW4H8loJXFDQWUkPWbh0y9bpFOYylOAHrYtzWMkQnWkpVFH
         4KR00/kccO31qWr22NYJpCsEIqXXDehoMZg0gASeGLNvcyC/AhRay6VHjxak0VlLk39B
         QQlg==
X-Gm-Message-State: AOJu0YzsYnYASAwY84R8pOcVfuT8bCZOxlsxQ+qpsnaB1f0K2e9E4q54
	NsvYyoEvJno4qIHqtvBjKsspxT/e3VJHpGcIcsyTLPn5+UfSTB/uawPaTX+p1UCqHFA=
X-Gm-Gg: ATEYQzz4jugh852XUjYbu9gsdmYy3PKQ4n7jwrritom9kf6yacmw9IHSm62ziN7/piE
	UIKQh81vNa5Dqs1Y8v7Kbb5gQHQKvA+kel85S20i3feNo8CKYmt4fVcDxn6NUgLbN7xWmtJLgTv
	MyO4XBjrqD+lniX9wqscxxjQY2ta7DYHBaV4hs2lRirKFIJaKu42MA3x5qha4lalAGa6aQfrdAp
	woZDC6NUi/DxBdlxej8NyjklBKkdAG34AtdqoOeOGrNtIfqvByi/+T42v3Jf9c5ZlxY9wJ4VBOv
	aRoDD0b6m0s9DDNLdC/ZuEdZ7cYbprCEKhcCUA0stnguPVWwMcUdu/hJ38aXCYLgAjIVL3UjDll
	5cji3V/hq2o4IA9Mm/qfNznTJS1gNTYissMCMTO9hadmU7avUP2bbD2vhSGi9ZG1WHDQQG1rz0o
	M4z8Rcx2x/wReEXKsTsTJbV7IrrStBGoUvdLi+8rrP8MFw7of0H/v32tM=
X-Received: by 2002:a05:6871:2ed3:b0:417:6713:5dae with SMTP id 586e51a60fabf-4177c82c4f2mr2825001fac.24.1773274826686;
        Wed, 11 Mar 2026 17:20:26 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:45::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177de88106sm3836836fac.0.2026.03.11.17.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 17:20:26 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@kernel.org>,
	Gregory Bell <grbell@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1] bpf: Release module BTF IDR before module unload
Date: Wed, 11 Mar 2026 17:20:25 -0700
Message-ID: <20260312002025.2495953-1-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3394; h=from:subject; bh=4cEBJyirbpRzl2PymBeEHW5P1idR4O3alCm6lGMVePg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpsgTmu7rtAOeAk1OChTcfYB50bMnc9HAvY34y+EGd 5QoZ0n+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCabIE5gAKCRBM4MiGSL8RytSlEA CJP3cVMvPVgsaXmjZamP8L/ApmjI3XtgvYHo+K/X6zbi9OVx0Hk5j9QrrOYvwksqOT4+C7ce9RFEpr Kmp82/2iDRermlO84SbBCTJv4xJmsGBgFU3vYr7OoUf0eMuQhCf8AAVfjfzY4DCS1Itx8GAqk5sQ0x l0t39H1LjAs77DCbH0ooJ/LOS3OsC2yZnQPbzD+8ELAxDLnQzjEiu6HE4CewkSIgf1gDm7Q38nr5IM 12h+kNedr0vjr+UKPqF9J/BoWmyXK4g7BmujTm5cdWMLZFYuO6Y4BeWGMFQ2sbZcD+biKznLDa7u7L EgvRB0LOUFX7yFcpdpG9rSnakWpCKn243/1N3Rwq/syOTyOI+N22DCGq0qhXejlnUPihoNBT50PpKY fu3HH9GmRggJVa3xDTHVzwXks6i3g8SYUseSTf6xsZcXCfz2jl342A0IqidOF6LrzhWA9hb+k8mWQg u3wetpKik5B048tKfOI+3+iU8HSpf4AekP51jXSrFPwcB4xaxBPJk+LZDiBL7rjN4Ll+A545la5IFA bwZUTFNy1UQCoydp/yROmfl/ssdcGrLaIBBTDetYRasRXSSvFWh6s6YECgdM1lVhf1zQVaItEAdTf6 ta/Y+9ZbpQojcE0DzXtRNY0uJrTCxJxAmX8v7DjKt2UxYLJqhVc740PSaJ4Q==
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

We can be sure that by the time we reach final btf_put() for
btf_is_module() case, the btf_free_id() is already done, since the
module itself holds the BTF reference, and it will call this function
for the BTF before dropping its own reference.

  [0]: https://lore.kernel.org/bpf/cover.1773170190.git.grbell@redhat.com

Fixes: 36e68442d1af ("bpf: Load and verify kernel module BTFs")
Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Reported-by: Gregory Bell <grbell@redhat.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4872d2a6c42d..c44fb9c9386f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1883,10 +1883,17 @@ void btf_get(struct btf *btf)
 	refcount_inc(&btf->refcnt);
 }

+bool btf_is_module(const struct btf *btf);
+
 void btf_put(struct btf *btf)
 {
 	if (btf && refcount_dec_and_test(&btf->refcnt)) {
-		btf_free_id(btf);
+		/*
+		 * IDR for module BTFs is freed when module's BTF reference is
+		 * dropped, which _will_ happen before the final put.
+		 */
+		if (!btf_is_module(btf))
+			btf_free_id(btf);
 		call_rcu(&btf->rcu, btf_free_rcu);
 	}
 }
@@ -8382,6 +8389,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
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

