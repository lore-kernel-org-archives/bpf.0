Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1DE388363
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775122014; cv=none; b=lEufqaoUIUiZPbNkOGFk9Eyw0/CyW0rGIzr3pTFHUXU3o4FdEGetRa/a6Ax1azfFJhz4cOMSjYE18B68khLHT/bN4wkJpodhgtS696CTxbfNWzc6xK5zfHQtd/v/jfke+Z/eiS+7/JSNNw707ITFO8EjC11/j/8L7MuPdHLzA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775122014; c=relaxed/simple;
	bh=fg9gtssW70rqBjzjZemwy81+H2Jd6oM+l/xkQy5zuS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSFw2DPa7ZcvtaAJimHPQGpPzL+MnOhIKrSdkHLkFLFlC800vuwTvVuGjgO0jWWE1cCBFvy1Cy0XbfCGyenTbT7iboNqop+GjFATetjVav5yLPOFZw4X3eRXVmYlXXLHUhE2IjJMwaWLFl0cl0htfxbMyyCstJqrMwH/Re8Ioi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwjBuQCg; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwjBuQCg"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35d971fbcddso353176a91.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 02:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775122004; x=1775726804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcS6+ltlajemy60nMyxmGDon25GNRE0B5Cl/4uAqhyI=;
        b=NwjBuQCg+b08pUjtJ4kKR6QxL3EofbU+P1etAguRY5SkyGw65JUgXjogeGYGpXAacV
         N2UDTdgGH9KEx4RsQJ1sx654k6ZKfMOxAssT7RmifOy3UF7MmhNdppcmSe5eu+ycS92o
         VgOuVvYdMw/Qjz7qLB1LosBadeghQhTHXkyyxKSWWIuFyYiO0rIBYNxWYcLy87KijYqF
         J6nEjtHYuHfygTZF4dGZK9wZruYwpNEieAuNUD6Z+F7V1AjJCLD9+5dKfMHjG+E4SvFt
         1bP2XQy4J2We3hdie9ogx7N266tIguejWg+kF8jS+kL/Kz0Wx3pg2JQ8H2GuBiSyMMRy
         BtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775122004; x=1775726804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CcS6+ltlajemy60nMyxmGDon25GNRE0B5Cl/4uAqhyI=;
        b=pGEd7jSjNmjrPt/l1gilEr9teVpvLl7hqHPKP7DazHoeynXYjNGHDVyzkllE2CcqHS
         NAVJHhp//AY9imyWAhuhyU41UXM865vgbM9KY2ZMD42EW/Afqm+3oDtuiyyMs+ArnWv1
         ME1dv8nS88rLeEaJV7Brl0p7JSTlOqHEXI+gmr6BxnC/C7Bk5WrJ69beN2Ok2Q303tJS
         Zor5TW+NgjrYXZgVGMCwIANNDHXjTE/v2HoWyw2omEB/9nYSpEVP4xrLr/aac17nypAM
         lhvzHtydK3YWoWgMgkyrcf8yfxJUQnzZA87y1pztX854oPGzb+8NYfiLSnZhTnfd9cy8
         mDzA==
X-Forwarded-Encrypted: i=1; AJvYcCVZFpeYZliwvPg6ILlt4GkJiOegCRTW8CwmZ92nlYC7Fg5M/uAXqXz8W08LWnFaTL0h5M0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbQdMbLa7rxgWzZUlkdNnAXSaQCogbPYClzBLJcqAFG1Sacu45
	cHKf9/0FMIdHZ47L+laJZD1CkD5VxN0812W4OY7VC1m7f+x/d3DGn1Eg
X-Gm-Gg: AeBDiev1wMICqZKCkxZs7ZLpLX65G7tDciswlWF2jlE08drzPcRZyKNzFmNjBAadmo3
	0ayKNn0WWNbOTxqwF3mCy8BDvKFRwUgpfBvjLpkEu8wCGlQIbejf4Y0aQfPnMreTwAjJl2vSfXk
	5yWVn5Ph543DGaEecDOxXVXpoc+dGXJ/ldsf+glwt7XOdu8xEW4xkkYUCCsampzZVJOLiOYfpWj
	mUmKMSUDdJvmwariZLHqTPHYsI+kizb8ahJosw+D9JutpLbaJY1I/cUcd77COX5A6D7Bo5TFJGc
	a6G56mFi2CbMLnrMKyVVGsX/ctQRX9xwbFILHiwwqPeU5PxjUazlCQCFgjD0PyVZTuBfz/mCOmo
	/76bHnQ5RiYZrzl8eY3lMyuZnm56qMHkMun0KhqjgjqV5tvPW9vd8tZ3pNHcmXDLre0ltjhOzP1
	IWFu9FGJc3QdgxgkjBdly+lBdqoASOgskiCWci4gUJvhjI
X-Received: by 2002:a17:90b:4a48:b0:35d:9fe9:f830 with SMTP id 98e67ed59e1d1-35dd684eacamr1324687a91.12.1775122003834;
        Thu, 02 Apr 2026 02:26:43 -0700 (PDT)
Received: from yafangs-Air ([2409:891f:1aa0:8613:19f3:7bee:2e41:149e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35f50e9sm2227645a91.6.2026.04.02.02.26.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 02:26:43 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 3/4] livepatch: Add "replaceable" attribute to klp_patch
Date: Thu,  2 Apr 2026 17:26:06 +0800
Message-ID: <20260402092607.96430-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402092607.96430-1-laoar.shao@gmail.com>
References: <20260402092607.96430-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new replaceable attribute to allow the coexistence of both
atomic-replace and non-atomic-replace livepatches. If replaceable is set to
0, the livepatch will not be replaced by a subsequent atomic-replace
operation.

This is a preparatory patch for following changes.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/livepatch.h |  2 ++
 kernel/livepatch/core.c   | 44 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index ba9e3988c07c..d88a6966e5f2 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -124,6 +124,7 @@ struct klp_state {
  * @objs:	object entries for kernel objects to be patched
  * @states:	system states that can get modified
  * @replace:	replace all actively used patches
+ * @replaceable:	whether this patch can be replaced or not
  * @list:	list node for global list of actively used patches
  * @kobj:	kobject for sysfs resources
  * @obj_list:	dynamic list of the object entries
@@ -138,6 +139,7 @@ struct klp_patch {
 	struct klp_object *objs;
 	struct klp_state *states;
 	bool replace;
+	bool replaceable;
 
 	/* internal */
 	struct list_head list;
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 28d15ba58a26..04f9e84f114f 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -351,6 +351,7 @@ int klp_apply_section_relocs(struct module *pmod, Elf_Shdr *sechdrs,
  * /sys/kernel/livepatch/<patch>/transition
  * /sys/kernel/livepatch/<patch>/force
  * /sys/kernel/livepatch/<patch>/replace
+ * /sys/kernel/livepatch/<patch>/replaceable
  * /sys/kernel/livepatch/<patch>/stack_order
  * /sys/kernel/livepatch/<patch>/<object>
  * /sys/kernel/livepatch/<patch>/<object>/patched
@@ -478,17 +479,60 @@ static ssize_t stack_order_show(struct kobject *kobj,
 	return sysfs_emit(buf, "%d\n", stack_order);
 }
 
+static ssize_t replaceable_store(struct kobject *kobj, struct kobj_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct klp_patch *patch;
+	bool replaceable;
+	int ret;
+
+	ret = kstrtobool(buf, &replaceable);
+	if (ret)
+		return ret;
+
+	patch = container_of(kobj, struct klp_patch, kobj);
+
+	mutex_lock(&klp_mutex);
+
+	if (patch->replaceable == replaceable)
+		goto out;
+
+	if (patch == klp_transition_patch) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	patch->replaceable = replaceable;
+
+out:
+	mutex_unlock(&klp_mutex);
+
+	if (ret)
+		return ret;
+	return count;
+}
+static ssize_t replaceable_show(struct kobject *kobj,
+			       struct kobj_attribute *attr, char *buf)
+{
+	struct klp_patch *patch;
+
+	patch = container_of(kobj, struct klp_patch, kobj);
+	return sysfs_emit(buf, "%d\n", patch->replaceable);
+}
+
 static struct kobj_attribute enabled_kobj_attr = __ATTR_RW(enabled);
 static struct kobj_attribute transition_kobj_attr = __ATTR_RO(transition);
 static struct kobj_attribute force_kobj_attr = __ATTR_WO(force);
 static struct kobj_attribute replace_kobj_attr = __ATTR_RO(replace);
 static struct kobj_attribute stack_order_kobj_attr = __ATTR_RO(stack_order);
+static struct kobj_attribute replaceable_kobj_attr = __ATTR_RW(replaceable);
 static struct attribute *klp_patch_attrs[] = {
 	&enabled_kobj_attr.attr,
 	&transition_kobj_attr.attr,
 	&force_kobj_attr.attr,
 	&replace_kobj_attr.attr,
 	&stack_order_kobj_attr.attr,
+	&replaceable_kobj_attr.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(klp_patch);
-- 
2.47.3

