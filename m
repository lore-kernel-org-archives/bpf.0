Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998330;
	b=mbybRhs5tZ+hJswplWUMIGDsRx3n5nJSkf/iucOcgmT5dBvyitYi/HsB4UCppGRESJCM
	 xoEXZjzhfKmLVH+MN0POABSdP9THehadHsxtSpRD8+9uyr5dQYi2JL4zeWCSp+7IN0GPC
	 +e6U81I3aVn9Dcky9EkA4vUSqgNegtyXjaIgjwXcDnKbyRXAay/kFmI1k75FEKNQDUMe6
	 JEIpnxr9ULQ3QqEJXbGcBX1iQtVfqcIBPn441HwY9W7N1iY5dFO+Gzb22vA0eenlvgkJl
	 RWEBRfj0g6gsaBd3hZIYscBlt1s4D6Z9/eZ2auz8zHZE5oY72bZ+o+7W3fLIX/wx6Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9Y3kCsYcaDY5qwLaKX26SOy2iD45ozQ8Dc5QEanJuFg=;
	b=RKF92wdY2pheRAOhdL2TRK3mqHLj50fM05yTQgX7mWWbCjmNQ5OSTEUsv0i76sNDa5YZ
	 X30b622kUDCe7UEhZ5lh+VeK+4oNCO1VB5CaL5SCXMnThkLysKE8qYDZbTcWgl8/CCkhZ
	 FXNqN9LEt7d/WYyHeURHyxFJuvQvj+myb5HbYrkE2XbtI4vPNpK5UFLXgBtmTd24Y1O1/
	 2vEO/vlQIr/QupshDgPIgh2LMLVrekTma+Zz2tPJwQAHMKZZIrdE0MBCS5pNC77kVmGqE
	 bHLDm7RR5+/BSUS7JjumfqOICMQ4n9PmOTpkznKSJmiN6UFMGbTmKtZPDUuJJe5Ugjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bVisYJNG;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC95606D804
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCC95606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bVisYJNG
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso9873935e9.2
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 12:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793998323; x=1794603123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Y3kCsYcaDY5qwLaKX26SOy2iD45ozQ8Dc5QEanJuFg=;
        b=bVisYJNGBs8pSIw7foQqwmdbAgIV850KX+5PaI7yMzRed2ltACVOYDdcqXMRHIuXyW
         tAewCJJS2lN+Vi22e0W8VPMvb0/LImy3fgs3bcDai03OrFd0YBhwLhIKpJhEhheoSOG6
         XodFeLqbwxVPSrQ/oVGQbsQ6Gq5RvGvdoR4VznBpOuFsbxoALbW9uY6Z/7zoqcwV0PQT
         aoHKOtrYMrn3hBWb5A13UC0galAjUe7iEuIiZL4D/Vm+5VdGA/2kgJkHvGCHzqCVqgtT
         cDT1akPZb6XmIkBcJfW8ScLjMc3i8zdQDzfbLkBGcZCtqRlMRfaSy8d+6iFJcPLpxGoK
         1YbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793998323; x=1794603123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Y3kCsYcaDY5qwLaKX26SOy2iD45ozQ8Dc5QEanJuFg=;
        b=1V4Th+LQse0Op7YUvGhcHhYSQjH4RwJDJW1yOlIGzx9tXNLNkYRfMovvPne7GG9Jgo
         ckragHIlBZP5ZtaB/3/qw7owDgeYVLrIzC7Ep1qJsIR9hnYrL1NDj0DBK7Unjuh5LB/C
         6FdYUMxg7YlQYwcZY3Mgq/Ft2D/MuA91Af98ZwDtfvJK3NGUMfA2Q42KNi2zVYVCCvNM
         ykY0Wv6Zsuo1bbYZYBslmrSL4HdpskFr/Eoy5AefyJ3eaadfbQ6KKFB22zxOdl2dM0N1
         CRpfSjkLhz2xCgpf3+J1NkPCgLkVUwxqZvoUcebsx5eLPhHpMMt1z6rzbzWHekJQkdfo
         gNWA==
X-Forwarded-Encrypted: i=1; AKwUvBwSWOccuo55EnZAfN+2X37IMIW+sw3Cc5a9FWymIFJy3knGmmG+nzp9dKRIEKcfb5uJttk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1ud5QfkXoijc8kJkzRwf5kWgBqjb/wStSkAnhD81K0RyDFZw8
	Uvl3MNpEgWhqSDScaHSaCzlcr5g0uJ+kMLILc8AHs3FPqVKzbcWDPR2L
X-Gm-Gg: AYBFou0D+qWtCvi91/MBqZNnB7OkM7gDmnqVp0QSKHjZrl47IaioHauMGUUy0JH53PB
	IGNQmX7B0Tz6rAncra7jaaDSAJ7WtX4LtlyEzCvSRKlfgcy0hTv80x1j1MptxfP7rl6TNLEchgf
	qMlL0VWUt1RFZAMsxBBT09lGaP2EUMGBHJXrZJzMotm762SK29zC3EfMfXAnBBVjNWfo+DIUzU6
	oLQmhJ9KwtQOho8VDNhzOAPitnDVdV5HNX5CXo7ExIcLKFiNpzJA9REs6d976Rtgziw+3VxI1Wn
	kpzPHJoR8jsFltJY5cz+xHhRjvUdFwFyzr9cyH3FAYs/CoBzOAicnrmGZMj4vC9zYRb2QDhehLq
	WTZuA/GYMhBOzvj8kTxv7lizTTk1/a/Nr9ZwgrJg6kMKI8/aza2RPIe8yYwKDuv1l90HaLbRH7a
	IxlGMB1JFspzPdE81ABEnAV7l/jlq4gMFdfBPwnfeqYZWxuUW4djDmkig31xljlZOvHBbEvQRHW
	YroHBvcRnpVPU0yhVBLDjYoz6agp8f1YtvPefSKH5AtX65g4TfonmO1GWoKn+j90NmMxNB8xvek
	cdlL39m6c+VRT3oZgNz3A7Yr4yoVA8msPFgfB0ADWhIXReA=
X-Received: by 2002:a05:600c:529a:b0:4a6:42cc:bf6c with SMTP id 5b1f17b1804b1-4b6de789187mr58252605e9.7.1793998323166;
        Fri, 06 Nov 2026 12:52:03 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7da62edb4sm9075425e9.1.2026.11.06.12.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:52:02 -0800 (PST)
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
Subject: [PATCH v1 bpf-next 03/18] bpf: Build fmod_ret target sets from BTF decl tags
Date: Fri,  6 Nov 2026 21:02:52 +0000
Message-ID: <20261106210314.1767267-3-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: 20261106205523.1765622-1-a.s.protopopov@gmail.com
References: <20261106210314.1767267-1-a.s.protopopov@gmail.com>
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

