Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243283;
	b=OrSnO0cTjVPpADumwLQjhDs639wTNSkv/8eRcbUoD0Hj9xXwLCehii7hj/iB4jm/djHV
	 0F3hs9edifwD13Kfb7MzrC4RMorL9IWuujG8O4YD6MhFTj81qpxpI2qQZZCPOG+fjcHAF
	 ubtqF7mxc3n5Q56DBkN0SlQEO3M9Ag7qTJ7c+g5xzQ0t0Ogq2wD+P3Mdjb45B5TBUjV7e
	 krztmlu/ytjJeXtj3vQjMtoOHXRhsnrC4s7/w/XUYTTu1IAurKkMe7M9T+Klq3JqL1b6e
	 bqix0IHGky4HnI1Wf4J2H05fLxI2pNGkPNsWkZAMlzz5XjqVN0o+2ELTuvZ2gjpAcCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9Y3kCsYcaDY5qwLaKX26SOy2iD45ozQ8Dc5QEanJuFg=;
	b=UTVM64R1Pl6ZKXJIv2YYa7KMXnUR75epYUwX7/gCQXhRLBJLGXe7Kj07K1Vs03SEVowj
	 p0ZN8CLrG0ejFaKshl13Uo+THznk9QIfnBNY/VecpUAbFmOOLRoKoVQp2UjgjddRsnt5I
	 5izGjGEWOu35CLs+xl0QS8FUS88d2uSuIQZRyE8HrKsJAhJ7pjmtfWtMzbqwMelbp9s54
	 nzqiW0eQmIz7TWry+9P8Qk1SqyAsh7CL8aX5dGwYf18m3C3zO0ny4H1p5rg1wW3DVRJs/
	 1R51ldllUqVxtJNAQD3K4f9Uqsw+/DbTgNX4ukfPFtqxuILK78xvhD01+v05G4X4+Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="v+t9/+Xs";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E8E60A380C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 16:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09E8E60A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v+t9/+Xs
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso7721455e9.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 08:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243281; x=1794848081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Y3kCsYcaDY5qwLaKX26SOy2iD45ozQ8Dc5QEanJuFg=;
        b=v+t9/+XsD2NdVTBBlS/4HDEp0YNRAfHx6ph2E67Lah+TN7FYohTAudGJKyyjjQmZkO
         NVbg3tc4ojdTCyh3jkD7ZsH0aTWqdXrCLOWDvwrlfRIkBTxnsMWxuatv6JeFnvX0pe+E
         f2zlCZduQFPF7rkwmjcFE9NVjRakmCfHtRvkQBWQkzay0vC+p88BvcuhCW77Y9LQEVNm
         WGC0CSbYfoD7Gr55PjxMRAVamQ2a0pfj63tK1aesX521AOfzPdX2WeiD/ztiuccJ8ybO
         QpY9vIb5TPfe7/upKVlCTzkZVX4GcXGL2g6IOt0xc1E6Jy5ffK8OH0CjQkNyp/zez2FV
         CQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243281; x=1794848081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Y3kCsYcaDY5qwLaKX26SOy2iD45ozQ8Dc5QEanJuFg=;
        b=bdBV8YGOliqKrNzqv6yrSbRHx7rbE1ecukzvougGv/GMFi/+rBtCqqtnrK6VdcNAkM
         vWKt/dWraJEobORzziwgvFeFG13bU9QT59XCk4JCmDWBeHzjrdJNv/VSyYY9aRf3XuNY
         wV1i2IlqpZxUd+j7Q7qIqdnFrqh/I5ovKNtMxIe3cntDXUMRNzAa3BZ7lcKyDG7bvRJK
         E2gppD/HsX74WpVg9u7Sm7vVJ4UoZVLaCgzAhIfjQsocfZsPPNZwqHyEv+tfax+llsu0
         SPa6+/ThRpq7sZt4uzKEcCVc/b6fQgdy9CQWQKeU1Yq+F83UKKilmdjR6gXLeYu7rUNd
         SJmA==
X-Forwarded-Encrypted: i=1; AL+hErEC69Cm7hZBckZwRYs+t8vZuLF+RDCaTmwCP+eNKizxzmRXilZSfL1tky2XC/IMLuoTeQo=@vger.kernel.org
X-Gm-Message-State: APuU4Z90wKGVXyQpO15+N2EJMsj/ktg6xXA9WkO0i37E09YCOGzUalmj
	fNIlJ3dgIZf5EbeVPEY44BBzch+nXzVNkodVB/n9/KpRsrACRn0Sk5Yd
X-Gm-Gg: AYBFou2LSGlAubb8c2VkQvGgKMC00aeTw5Q3IykZlrDTzERXZ7Rlu9PNwp4M6QiQtEf
	zivMLtYh9h0O/qT/nhvFdtR17uzJp0NZfuaCbVpfRbgT1wO5LLGBj2xtnC1XP+Q5jnLKKxwASoP
	uIrxSL3yFB0nCjykmpcDgl0xUoUNR9LUpshi5ewRCQb6u0M6OMsgJZ04hNglOWK0bUHreO5M1uT
	aEoruOMJ1SRUvw7rSqaiKZbMLqimtO6cRVHNumq6xPyLNJUBb4NdN0OvaR6prTJNiS/zloVvsvz
	wZ4hghooW63OpDPZDzwOTxuKhktgsrMaq4GnLiH68X2hvH/aCEJAebVuh+rVG20trxoTdjOGYd5
	4tS57DKAgZlShvdUPp8T5zKhaVn3wUEDlHLQSXVcSmgVNvGd8F1eFIk9Qckw9iEZb3JWNYg1eVA
	exZNOy2VBQAofnZYAHLqqj4yZv48WE7g1F5rYQea0eyi6ZioV8e5jZJ6cB1fmuyAiYto2bWlcUS
	dZvTxdZnHFPi/umbgvhC0Qy7iQTVV0fAV91Hlmp0/uD51Fye+AWFqvNLEwHKkzX/WVyAywg/iNi
	Vd3dAKYjwO5OZ7exCdd3z13DRYLdCb+yZcgy/Li2yVQyXZM=
X-Received: by 2002:a05:600c:6c42:b0:4a5:a5ca:de1d with SMTP id 5b1f17b1804b1-4ba001d0e71mr15885685e9.30.1794243281388;
        Mon, 09 Nov 2026 08:54:41 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783fd04sm11392369f8f.47.2026.11.09.08.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:54:40 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v2 bpf-next 03/18] bpf: Build fmod_ret target sets from BTF decl tags
Date: Mon,  9 Nov 2026 17:05:23 +0000
Message-ID: <20261109170550.141443-4-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109170550.141443-1-a.s.protopopov@gmail.com>
References: <20261109170550.141443-1-a.s.protopopov@gmail.com>
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

Mark functions tagged with the "bpf_fmodret{,_sleepable}" decl tags
(added by resolve_btfids) as fmodret targets. Add the KF_SLEEPABLE flag
for the latter.

Do this for vmlinux at fs_initcall and for a module before its BTF
becomes visible to anyone else, so nothing can look at the set while it
is built.

The IDs come from the BTF after relocation, so they are final. Unlike
the IDs of a set registered by a module, they must not be relocated, and
the set is installed directly instead of through btf_populate_kfunc_set().
(The register_btf_fmodret_id_set() keeps working, it will be removed by
a later patch.)

The set shares kfunc_set_tab with the kfunc sets, but its flags only say
how a target may be attached. Skip it in btf_kfunc_check_flag(), so a
kfunc which is also an fmod_ret target keeps its own flags, such as
KF_IMPLICIT_ARGS. Otherwise btf_attach_func_proto() finds the flags of
such a kfunc inconsistent and attaching to it fails.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/btf.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 61d2df6776a9..2c45e5fa1d7b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9307,6 +9307,8 @@ enum {
 };
 
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+static int btf_register_fmodret_tags(struct btf *btf);
+
 struct btf_module {
 	struct list_head list;
 	struct module *module;
@@ -9476,6 +9478,15 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			}
 			goto out;
 		}
+		/*
+		 * Do this before the BTF is visible to anyone else. A failure
+		 * is not fatal: the module loads, but without fmod_ret targets.
+		 */
+		err = btf_register_fmodret_tags(btf);
+		if (err)
+			pr_warn("failed to register fmod_ret targets of module [%s]: %d\n",
+				mod->name, err);
+
 		err = btf_alloc_id(btf);
 		if (err) {
 			btf_free(btf);
@@ -10100,7 +10111,9 @@ u32 *btf_kfunc_flags(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_p
 }
 
 /*
- * Check a single KF_* @flag on a kfunc across all of its hook sets.
+ * Check a single KF_* @flag on a kfunc across all of its hook sets. The set of
+ * fmod_ret targets is not one of them: its flags only say how a target may be
+ * attached, and a kfunc which is also a target keeps its own flags.
  * Returns:
  *   * 1 if @flag is set
  *   * 0 if @flag is not set
@@ -10115,6 +10128,8 @@ int btf_kfunc_check_flag(const struct btf *btf, u32 kfunc_btf_id, u32 flag)
 	u32 *flags;
 
 	for (hook = 0; hook < BTF_KFUNC_HOOK_MAX; hook++) {
+		if (hook == BTF_KFUNC_HOOK_FMODRET)
+			continue;
 		flags = btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
 		if (!flags)
 			continue;
@@ -10182,6 +10197,103 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 }
 EXPORT_SYMBOL_GPL(register_btf_kfunc_id_set);
 
+/*
+ * Targets of fmod_ret programs are marked in BTF by resolve_btfids, see
+ * BTF_SET8_FMODRET. A "bpf_fmodret" decl tag on a function makes it a target.
+ * A target which sleepable programs may attach to also has a
+ * "bpf_fmodret_sleepable" tag, which never comes without "bpf_fmodret".
+ */
+#define BTF_FMODRET_TAG			"bpf_fmodret"
+#define BTF_FMODRET_SLEEPABLE_TAG	"bpf_fmodret_sleepable"
+
+/* Return the function which T tags with decl tag NAME, or 0 */
+static u32 btf_fmodret_tag_func(const struct btf *btf, const struct btf_type *t,
+				const char *name)
+{
+	const struct btf_type *func;
+
+	if (!btf_type_is_decl_tag(t) || btf_type_decl_tag(t)->component_idx != -1)
+		return 0;
+	if (strcmp(btf_name_by_offset(btf, t->name_off), name))
+		return 0;
+	func = btf_type_by_id(btf, t->type);
+	if (!func || !btf_type_is_func(func))
+		return 0;
+	return t->type;
+}
+
+/* Build the set of fmod_ret targets of BTF from its decl tags */
+static int btf_register_fmodret_tags(struct btf *btf)
+{
+	u32 id, func_id, nr_types = btf_nr_types(btf), cnt = 0;
+	struct btf_kfunc_set_tab *tab;
+	struct btf_id_set8 *set;
+
+	for (id = btf_start_id(btf); id < nr_types; id++)
+		cnt += !!btf_fmodret_tag_func(btf, btf_type_by_id(btf, id), BTF_FMODRET_TAG);
+	if (!cnt)
+		return 0;
+
+	set = kmalloc(struct_size(set, pairs, cnt), GFP_KERNEL | __GFP_NOWARN);
+	if (!set)
+		return -ENOMEM;
+	set->flags = 0;
+	set->cnt = 0;
+	for (id = btf_start_id(btf); id < nr_types; id++) {
+		func_id = btf_fmodret_tag_func(btf, btf_type_by_id(btf, id), BTF_FMODRET_TAG);
+		if (!func_id)
+			continue;
+		set->pairs[set->cnt].id = func_id;
+		set->pairs[set->cnt].flags = 0;
+		set->cnt++;
+	}
+	sort(set->pairs, set->cnt, sizeof(set->pairs[0]), btf_id_cmp_func, NULL);
+
+	/* Each sleepable tag marks a function which is already in the set */
+	for (id = btf_start_id(btf); id < nr_types; id++) {
+		struct btf_id_set8_pair *pair;
+
+		func_id = btf_fmodret_tag_func(btf, btf_type_by_id(btf, id),
+					       BTF_FMODRET_SLEEPABLE_TAG);
+		if (!func_id)
+			continue;
+		pair = btf_id_set8_entry(set, func_id);
+		if (pair)
+			pair->flags |= KF_SLEEPABLE;
+	}
+
+	tab = btf->kfunc_set_tab;
+	if (!tab) {
+		tab = kzalloc_obj(*tab, GFP_KERNEL | __GFP_NOWARN);
+		if (!tab) {
+			kfree(set);
+			return -ENOMEM;
+		}
+		btf->kfunc_set_tab = tab;
+	}
+	if (tab->sets[BTF_KFUNC_HOOK_FMODRET]) {
+		kfree(set);
+		return -EEXIST;
+	}
+	tab->sets[BTF_KFUNC_HOOK_FMODRET] = set;
+	return 0;
+}
+
+static int __init btf_fmodret_tags_init(void)
+{
+	struct btf *btf;
+	int err;
+
+	btf = btf_get_module_btf(NULL);
+	if (IS_ERR_OR_NULL(btf))
+		return PTR_ERR_OR_ZERO(btf);
+
+	err = btf_register_fmodret_tags(btf);
+	btf_put(btf);
+	return err;
+}
+fs_initcall(btf_fmodret_tags_init);
+
 /* This function must be invoked only from initcalls/module init functions */
 int register_btf_fmodret_id_set(const struct btf_kfunc_id_set *kset)
 {
-- 
2.43.0

