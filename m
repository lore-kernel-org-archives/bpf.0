Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401865;
	b=OoqbYJnXqiKqBOiRQEAZ4Iq5JXQxgC6tcAM5N/7DLzYKsr4t3sgnYZemhiWXea+UltMh
	 vMLyExEWh/St7AWjQ1LZQ5rXZJayCAEHAANoePuztqR0k0brqGNrH4AqJuSt/AvTaxstM
	 ygihjQWOYhRjrq2utjvsBWmfguOu0X2a2SMeNhjsDvrgREEduGm//lcgM0L9DkiKXtJkD
	 cur6/pLlrqUnlEKoFWDG+MSxIJ3FoJGBGO+ZOyWhASwUL52wqjE1AqpsB5HB5bEuXvfIC
	 2jfeu9ZP0fz5F12JPBwi4PIdtTeHhU3wJwQA4y90s530uIKZFXFNwAk0pBe9R4eLZaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=/GPDE0UURkqH3XQRxXn56jeVhcII8LNZ3dX52s0TeLQ=;
	b=G6ps6zCKy/iHrYPjz4hFcI0ehO+XQA4t1poH115FR6k/i+sFhzsPbzSIgymzflIdbsFa
	 prVrGmU4Ilk2oTKjrYOeg8yYtfAQVorrSeHw2/5TF0LqQ4qe+togXox5t/of91loNDJg3
	 yVRWfeYjzRqEve1R6f8Kd7e7N54fLz3DFdXJ7Bu2DEDpxUCZev12b/fxU0Oo2tVmapjYY
	 zUHTWusysw1ukty8qsMBlKQRUGPX8ylZT5xif47xLNJBbu7ijVeKjUE4yTB9t3FySBVJY
	 Fnlbtgg7Cd3blhSDmVWMJjDEj1b63AxfWy9h82HE1bdVwCHSqyBNmlcgbdxEOO8UqQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c8bZYdpD;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE6D606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFE6D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c8bZYdpD
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4b76b2f6bd9so9315985e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401863; x=1795006663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/GPDE0UURkqH3XQRxXn56jeVhcII8LNZ3dX52s0TeLQ=;
        b=c8bZYdpD2I7I60vY1fwKBg8Tao7Q7bd2L52zY4XHVqb/NgIDFrmCgKz/+nUHe6i5Jz
         9LHBn92mcY5jizLqUVSPcRjgQphn+0MpPRD0Uj6tiAfWaum01ny0MURWTPU0XwYsudmC
         dx8tRPr+bJml7gLkrT/H3aOnjjyzMvAsXSHnXg6e6MiaQCT8LfVoT2CUItrRvoskZgYb
         jqYrHmQdnHEzt1XfvIp+aNrC3EDSAPZKkxnDv3YwZLi3yjrUNwarsCSteDm2DgQ30cX5
         dvdutdz+7Pst/k/yNtPmoL8MDgcq6OoO6ZsVcCyMv3CopFcZQzDOZSvyOeTgZhfbGprX
         fl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401863; x=1795006663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/GPDE0UURkqH3XQRxXn56jeVhcII8LNZ3dX52s0TeLQ=;
        b=jtG0+A40QxAD3lGA7kzRJOHvXUVDKJd30jVOG5dgGMqaOcIvN8NSKtdmL/7LAheTt6
         3YIkeVRymznbC5OGVtqwCDr8v7jZisZyWxUnBp9RzVCv2i0PdVbO27qg7vWRnGL3elLT
         h3s6Od4S30Y/kkjNIAKGv1y58CFbEQwU0/2yHgE+p5XoFJ6TCKbCH/qHlkpCofjiVaxf
         /Nv3liS/zVhPZuQXw2GsOkKgj2jX/hIP7ckXB37KDQvdP7p3tPdcGYQZvN7uzV6qL7HD
         iPvtVRNzp4dRkJ/JcataH+OfYXEl6IFrjFh4WJ2emZw6dBtRXHh8flRqgmTVGuJNiVDR
         AN6Q==
X-Gm-Message-State: APuU4Z8ptrO+k3dUNu3fjpMIdyJEx0Ckhs6jBJWGKxi05bbFm41If2yL
	fm6k+yuVKPDEAU/oiZiMjTeRxhKxrjD9+4nGyhnJNbG/KdfWPbPBhB9fY4D9ugngwTs=
X-Gm-Gg: AYBFou2dcjBI+8KTy8mnCCB5hZyO6DTnHfh6V7k759Gmph5n/T1ZgGNkTM1hpHOfmaw
	CGd1+9nJdtnGlfSMhfkSy4KbJvuO7nYi0XRlNcpNiIzuAA1PTY6iXp+TIt/ApEQzGDMfLDxus/9
	FHx2ConqiD33q9A0IqJLpkQRD3m6Ec6hv3nLpCdl9gN92/5AvkFctEN7N5yHgZs4n+wPHoajI+i
	FB4mk43uciAC9SWjWcGN7KlKP5cnY3PVBynhez3t3e1zcISAyT3b89PZzkmQ6P4um1J/9hJjx0O
	3cHahY6JM18f5W8aGahY8Sv7kjbcB+1v5boHpA0iTr6c5N3A/gOE3/BL2wQ53CpgoBNyc64UEfq
	+CUDDs3wf7A3OQ9FT49dvn5lIstj10DppCMppO+XEz2rnc9oxAVhy7vhgNYgsXDXzX0WlsUG3fe
	FPHJHDN/UdeQxSUSc0yUCRTHukvyUa2JxmwLXVGfnwP17sEozm+ojlOiWClGywnPWj/QtQia7f6
	HYGRzJP/uqDssRFcv/X5tLCt3URUkQAQI61MHVvmrbZ/N2PrJzvcUX5YqMUMPBqnZ8wOZ5I2qVW
	LlZzNVfzFd58dqO2bQCGMMMvJXK9wE8uHhG/01MToTx+b0skQqltpt85JH7lZO7yg9Qyn5Y8DPn
	FQL9arkK2OEAiuD219U7FVOpav/Y5Advr3aC+HaUYmHHBKNYqORL3U4auXvnOOsd8e/Or
X-Received: by 2002:a05:600c:1d03:b0:4b7:6b96:e431 with SMTP id 5b1f17b1804b1-4ba09399711mr48749205e9.28.1794401863209;
        Wed, 11 Nov 2026 04:57:43 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba020485bcsm130912325e9.11.2026.11.11.04.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:57:42 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 08/29] bpf: Add flags and release kfuncs to the dtor registry
Date: Wed, 11 Nov 2026 13:57:06 +0100
Message-ID: <ffc489a9770015068f1fe344435515d9265600be.1794399387.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16830; i=memxor@gmail.com; h=from:subject:message-id; bh=n8vUYtbTaaZ7L9cWN4NwfUfbUUOerQeb8F8oLToamVk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzLxNLNJ9rJwrhTTDvn49JSnG3nn6RNSNs2sTvj2Zu eqiS8fyjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzkfCHD/+rmw5N1grLOtxaU Mz14dE7ESm3+pllRfREVmxtWH/0bac7wz+CIq5fgjs73Jv8mpByQYq99v4nl98KKQC8xvtAnTDf XcwEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The BTF destructor registry maps a type to the void (*)(void *) function
that destroys a kptr of that type when a map element is freed. This is
its only use.

An unwinder that releases the references a program holds when it throws
needs the same table, with two additions:

 - An entry must say whether the unwinder may use it.
 - An entry must name the kfunc that a program calls to release such a
   reference. The verifier uses this to decide whether a destructor may
   run at a given point: if the program could call the release kfunc
   there, running the equivalent destructor is allowed.

Add a flags field to struct btf_id_dtor_kfunc:

 - BPF_DTOR_KPTR keeps today's use. btf_find_dtor_kfunc() takes the
   flags that an entry must have, so the kptr lookup in btf_parse_kptr()
   sees the same entries as before.
 - BPF_DTOR_CLEANUP marks an entry that the unwinder may use. Such an
   entry carries release_btf_id: the KF_RELEASE kfunc of the type, or the
   KF_ITER_DESTROY kfunc of an iterator type.

btf_find_dtor() returns the whole entry for the unwinder. For a type of a
module BTF it also searches the base BTF, and falls back to a vmlinux
struct of the same name.

Registration rejects an entry without flags, a cleanup entry without a
release kfunc, and a release kfunc that is not registered with KF_RELEASE
or KF_ITER_DESTROY in a kfunc id set of the same BTF. The check runs at
registration time, so a module or initcall must register its kfunc id
sets before its destructors. Every current registration already does.

Mark the existing entries BPF_DTOR_KPTR. Also mark them BPF_DTOR_CLEANUP,
with their release kfunc, where the type has one: task_struct, cgroup,
bpf_cpumask, bpf_crypto_ctx, bpf_ksock, the sk_buff of a qdisc program,
the two test types in test_run.c, and bpf_testmod_ctx.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/btf.h                           |  23 +++-
 kernel/bpf/btf.c                              | 101 ++++++++++++++++--
 kernel/bpf/cpumask.c                          |   7 +-
 kernel/bpf/crypto.c                           |   7 +-
 kernel/bpf/helpers.c                          |  14 ++-
 net/bpf/test_run.c                            |  14 ++-
 net/core/bpf_ksock.c                          |   3 +
 net/sched/bpf_qdisc.c                         |  10 +-
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   5 +-
 9 files changed, 155 insertions(+), 29 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 87fad4076f0e..045c48bcf98c 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -141,9 +141,19 @@ struct btf_kfunc_id_set {
 	btf_kfunc_filter_t filter;
 };
 
+/*
+ * Flags for struct btf_id_dtor_kfunc::flags: BPF_DTOR_KPTR destroys the kptr fields of a map
+ * element when it is freed, BPF_DTOR_CLEANUP may release a reference held by a program that
+ * is being unwound.
+ */
+#define BPF_DTOR_KPTR		(1U << 0)
+#define BPF_DTOR_CLEANUP	(1U << 1)
+
 struct btf_id_dtor_kfunc {
-	u32 btf_id;
-	u32 kfunc_btf_id;
+	u32 btf_id;		/* type the destructor applies to */
+	u32 kfunc_btf_id;	/* BTF id of the void (*)(void *) destructor */
+	u32 release_btf_id;	/* KF_RELEASE kfunc of the type, required for BPF_DTOR_CLEANUP */
+	u32 flags;
 };
 
 struct btf_struct_meta {
@@ -627,7 +637,8 @@ u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 			      const struct btf_kfunc_id_set *s);
 int register_btf_fmodret_id_set(const struct btf_kfunc_id_set *kset);
-s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id);
+const struct btf_id_dtor_kfunc *btf_find_dtor(struct btf **btfp, u32 btf_id);
+s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id, u32 flags);
 int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
 				struct module *owner);
 struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf, u32 btf_id);
@@ -718,7 +729,11 @@ static inline int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 {
 	return 0;
 }
-static inline s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id)
+static inline const struct btf_id_dtor_kfunc *btf_find_dtor(struct btf **btfp, u32 btf_id)
+{
+	return NULL;
+}
+static inline s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id, u32 flags)
 {
 	return -ENOENT;
 }
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 228b93d4f8c9..6359c5e343bd 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4073,7 +4073,7 @@ static int btf_parse_kptr(const struct btf *btf, struct btf_field *field,
 		 * can be used as a referenced pointer and be stored in a map at
 		 * the same time.
 		 */
-		dtor_btf_id = btf_find_dtor_kfunc(kptr_btf, id);
+		dtor_btf_id = btf_find_dtor_kfunc(kptr_btf, id, BPF_DTOR_KPTR);
 		if (dtor_btf_id < 0) {
 			ret = dtor_btf_id;
 			goto end_btf;
@@ -10190,23 +10190,86 @@ int register_btf_fmodret_id_set(const struct btf_kfunc_id_set *kset)
 }
 EXPORT_SYMBOL_GPL(register_btf_fmodret_id_set);
 
-s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id)
+static const struct btf_id_dtor_kfunc *btf_dtor_tab_find(const struct btf *btf, u32 btf_id)
 {
 	struct btf_id_dtor_kfunc_tab *tab = btf->dtor_kfunc_tab;
-	struct btf_id_dtor_kfunc *dtor;
 
 	if (!tab)
-		return -ENOENT;
-	/* Even though the size of tab->dtors[0] is > sizeof(u32), we only need
+		return NULL;
+	/*
+	 * Even though the size of tab->dtors[0] is > sizeof(u32), we only need
 	 * to compare the first u32 with btf_id, so we can reuse btf_id_cmp_func.
 	 */
 	BUILD_BUG_ON(offsetof(struct btf_id_dtor_kfunc, btf_id) != 0);
-	dtor = bsearch(&btf_id, tab->dtors, tab->cnt, sizeof(tab->dtors[0]), btf_id_cmp_func);
-	if (!dtor)
+	return bsearch(&btf_id, tab->dtors, tab->cnt, sizeof(tab->dtors[0]), btf_id_cmp_func);
+}
+
+/*
+ * Find the destructor entry of type @btf_id of *@btfp, and set *@btfp to the
+ * BTF the entry and its kfunc ids belong to. A module's BTF is split on top of
+ * vmlinux's, so a type below its first id is vmlinux's, with its destructor
+ * registered there; and a struct a module defines under the name of a vmlinux
+ * struct is the same type to the verifier, which passes it to vmlinux kfuncs
+ * by name, so it is destroyed as that type.
+ */
+const struct btf_id_dtor_kfunc *btf_find_dtor(struct btf **btfp, u32 btf_id)
+{
+	const struct btf_id_dtor_kfunc *dtor;
+	struct btf *btf = *btfp, *vmlinux;
+	const struct btf_type *t;
+	s32 id;
+
+	while (btf_id < btf->start_id)
+		btf = btf->base_btf;
+	dtor = btf_dtor_tab_find(btf, btf_id);
+	if (dtor || !btf_is_module(btf)) {
+		*btfp = btf;
+		return dtor;
+	}
+	t = btf_type_by_id(btf, btf_id);
+	if (!t || !btf_type_is_struct(t))
+		return NULL;
+	vmlinux = bpf_get_btf_vmlinux();
+	if (IS_ERR_OR_NULL(vmlinux))
+		return NULL;
+	id = btf_find_by_name_kind(vmlinux, btf_name_by_offset(btf, t->name_off), BTF_KIND_STRUCT);
+	if (id < 0)
+		return NULL;
+	dtor = btf_dtor_tab_find(vmlinux, id);
+	if (dtor)
+		*btfp = vmlinux;
+	return dtor;
+}
+
+/* Return the destructor of btf_id if its entry has all of the BPF_DTOR_* bits in flags */
+s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id, u32 flags)
+{
+	const struct btf_id_dtor_kfunc *dtor = btf_find_dtor(&btf, btf_id);
+
+	if (!dtor || (dtor->flags & flags) != flags)
 		return -ENOENT;
 	return dtor->kfunc_btf_id;
 }
 
+/*
+ * The release kfunc of a BPF_DTOR_CLEANUP entry is what a program calls to release a
+ * reference of the type itself, so it must be a KF_RELEASE kfunc, or the KF_ITER_DESTROY
+ * kfunc of an iterator type. The kfunc id sets of the BTF are consulted, so they must be
+ * registered before the destructors.
+ */
+static int btf_check_release_kfunc(struct btf *btf, u32 release_btf_id)
+{
+	const struct btf_type *t;
+
+	t = btf_type_by_id(btf, release_btf_id);
+	if (!t || !btf_type_is_func(t))
+		return -EINVAL;
+	if (btf_kfunc_check_flag(btf, release_btf_id, KF_RELEASE) == 1 ||
+	    btf_kfunc_check_flag(btf, release_btf_id, KF_ITER_DESTROY) == 1)
+		return 0;
+	return -EINVAL;
+}
+
 static int btf_check_dtor_kfuncs(struct btf *btf, const struct btf_id_dtor_kfunc *dtors, u32 cnt)
 {
 	const struct btf_type *dtor_func, *dtor_func_proto, *t;
@@ -10217,6 +10280,22 @@ static int btf_check_dtor_kfuncs(struct btf *btf, const struct btf_id_dtor_kfunc
 	for (i = 0; i < cnt; i++) {
 		dtor_btf_id = btf_relocate_id(btf, dtors[i].kfunc_btf_id);
 
+		if (!dtors[i].flags) {
+			pr_err("no flags for the destructor of btf_id %u\n", dtors[i].btf_id);
+			return -EINVAL;
+		}
+		if ((dtors[i].flags & BPF_DTOR_CLEANUP) && !dtors[i].release_btf_id) {
+			pr_err("no release kfunc for the cleanup destructor of btf_id %u\n",
+			       dtors[i].btf_id);
+			return -EINVAL;
+		}
+		if (dtors[i].release_btf_id &&
+		    btf_check_release_kfunc(btf, btf_relocate_id(btf, dtors[i].release_btf_id))) {
+			pr_err("btf_id %u is not a release kfunc for the destructor of btf_id %u\n",
+			       dtors[i].release_btf_id, dtors[i].btf_id);
+			return -EINVAL;
+		}
+
 		dtor_func = btf_type_by_id(btf, dtor_btf_id);
 		if (!dtor_func || !btf_type_is_func(dtor_func))
 			return -EINVAL;
@@ -10311,8 +10390,12 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
 
 	/* remap BTF ids based on BTF relocation (if any) */
 	for (i = tab_cnt; i < tab_cnt + add_cnt; i++) {
-		tab->dtors[i].btf_id = btf_relocate_id(btf, tab->dtors[i].btf_id);
-		tab->dtors[i].kfunc_btf_id = btf_relocate_id(btf, tab->dtors[i].kfunc_btf_id);
+		struct btf_id_dtor_kfunc *dtor = &tab->dtors[i];
+
+		dtor->btf_id = btf_relocate_id(btf, dtor->btf_id);
+		dtor->kfunc_btf_id = btf_relocate_id(btf, dtor->kfunc_btf_id);
+		if (dtor->release_btf_id)
+			dtor->release_btf_id = btf_relocate_id(btf, dtor->release_btf_id);
 	}
 
 	tab->cnt += add_cnt;
diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 1336a4efa755..f552472d69b1 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -511,14 +511,17 @@ static const struct btf_kfunc_id_set cpumask_kfunc_set = {
 BTF_ID_LIST(cpumask_dtor_ids)
 BTF_ID(struct, bpf_cpumask)
 BTF_ID(func, bpf_cpumask_release_dtor)
+BTF_ID(func, bpf_cpumask_release)
 
 static int __init cpumask_kfunc_init(void)
 {
 	int ret;
 	const struct btf_id_dtor_kfunc cpumask_dtors[] = {
 		{
-			.btf_id	      = cpumask_dtor_ids[0],
-			.kfunc_btf_id = cpumask_dtor_ids[1]
+			.btf_id	        = cpumask_dtor_ids[0],
+			.kfunc_btf_id   = cpumask_dtor_ids[1],
+			.release_btf_id = cpumask_dtor_ids[2],
+			.flags          = BPF_DTOR_KPTR | BPF_DTOR_CLEANUP,
 		},
 	};
 
diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 69bc29d0a4d4..cd65da3dffcf 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -336,14 +336,17 @@ static const struct btf_kfunc_id_set crypt_kfunc_set = {
 BTF_ID_LIST(bpf_crypto_dtor_ids)
 BTF_ID(struct, bpf_crypto_ctx)
 BTF_ID(func, bpf_crypto_ctx_release_dtor)
+BTF_ID(func, bpf_crypto_ctx_release)
 
 static int __init crypto_kfunc_init(void)
 {
 	int ret;
 	const struct btf_id_dtor_kfunc bpf_crypto_dtors[] = {
 		{
-			.btf_id	      = bpf_crypto_dtor_ids[0],
-			.kfunc_btf_id = bpf_crypto_dtor_ids[1]
+			.btf_id	        = bpf_crypto_dtor_ids[0],
+			.kfunc_btf_id   = bpf_crypto_dtor_ids[1],
+			.release_btf_id = bpf_crypto_dtor_ids[2],
+			.flags          = BPF_DTOR_KPTR | BPF_DTOR_CLEANUP,
 		},
 	};
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 0164f183aade..cbed0c8952a7 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -5317,9 +5317,11 @@ static const struct btf_kfunc_id_set user_mem_kfunc_set = {
 BTF_ID_LIST(generic_dtor_ids)
 BTF_ID(struct, task_struct)
 BTF_ID(func, bpf_task_release_dtor)
+BTF_ID(func, bpf_task_release)
 #ifdef CONFIG_CGROUPS
 BTF_ID(struct, cgroup)
 BTF_ID(func, bpf_cgroup_release_dtor)
+BTF_ID(func, bpf_cgroup_release)
 #endif
 
 BTF_KFUNCS_START(common_btf_ids)
@@ -5429,13 +5431,17 @@ static int __init kfunc_init(void)
 	int ret;
 	const struct btf_id_dtor_kfunc generic_dtors[] = {
 		{
-			.btf_id       = generic_dtor_ids[0],
-			.kfunc_btf_id = generic_dtor_ids[1]
+			.btf_id         = generic_dtor_ids[0],
+			.kfunc_btf_id   = generic_dtor_ids[1],
+			.release_btf_id = generic_dtor_ids[2],
+			.flags          = BPF_DTOR_KPTR | BPF_DTOR_CLEANUP,
 		},
 #ifdef CONFIG_CGROUPS
 		{
-			.btf_id       = generic_dtor_ids[2],
-			.kfunc_btf_id = generic_dtor_ids[3]
+			.btf_id         = generic_dtor_ids[3],
+			.kfunc_btf_id   = generic_dtor_ids[4],
+			.release_btf_id = generic_dtor_ids[5],
+			.flags          = BPF_DTOR_KPTR | BPF_DTOR_CLEANUP,
 		},
 #endif
 	};
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index d6c9dc62182e..0eb11688aaa4 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1888,19 +1888,25 @@ static const struct btf_kfunc_id_set bpf_prog_test_kfunc_set = {
 BTF_ID_LIST(bpf_prog_test_dtor_kfunc_ids)
 BTF_ID(struct, prog_test_ref_kfunc)
 BTF_ID(func, bpf_kfunc_call_test_release_dtor)
+BTF_ID(func, bpf_kfunc_call_test_release)
 BTF_ID(struct, prog_test_member)
 BTF_ID(func, bpf_kfunc_call_memb_release_dtor)
+BTF_ID(func, bpf_kfunc_call_memb_release)
 
 static int __init bpf_prog_test_run_init(void)
 {
 	const struct btf_id_dtor_kfunc bpf_prog_test_dtor_kfunc[] = {
 		{
-		  .btf_id       = bpf_prog_test_dtor_kfunc_ids[0],
-		  .kfunc_btf_id = bpf_prog_test_dtor_kfunc_ids[1]
+		  .btf_id         = bpf_prog_test_dtor_kfunc_ids[0],
+		  .kfunc_btf_id   = bpf_prog_test_dtor_kfunc_ids[1],
+		  .release_btf_id = bpf_prog_test_dtor_kfunc_ids[2],
+		  .flags          = BPF_DTOR_KPTR | BPF_DTOR_CLEANUP,
 		},
 		{
-		  .btf_id	= bpf_prog_test_dtor_kfunc_ids[2],
-		  .kfunc_btf_id = bpf_prog_test_dtor_kfunc_ids[3],
+		  .btf_id         = bpf_prog_test_dtor_kfunc_ids[3],
+		  .kfunc_btf_id   = bpf_prog_test_dtor_kfunc_ids[4],
+		  .release_btf_id = bpf_prog_test_dtor_kfunc_ids[5],
+		  .flags          = BPF_DTOR_KPTR | BPF_DTOR_CLEANUP,
 		},
 	};
 	int ret;
diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
index 25111712b944..e7fba11cdb12 100644
--- a/net/core/bpf_ksock.c
+++ b/net/core/bpf_ksock.c
@@ -366,6 +366,7 @@ static const struct btf_kfunc_id_set ksock_kfunc_set = {
 BTF_ID_LIST(bpf_ksock_dtor_ids)
 BTF_ID(struct, bpf_ksock)
 BTF_ID(func, bpf_ksock_release_dtor)
+BTF_ID(func, bpf_ksock_release)
 
 static int __init bpf_ksock_kfunc_init(void)
 {
@@ -374,6 +375,8 @@ static int __init bpf_ksock_kfunc_init(void)
 		{
 			.btf_id = bpf_ksock_dtor_ids[0],
 			.kfunc_btf_id = bpf_ksock_dtor_ids[1],
+			.release_btf_id = bpf_ksock_dtor_ids[2],
+			.flags = BPF_DTOR_KPTR | BPF_DTOR_CLEANUP,
 		},
 	};
 
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 5691c13781a8..70e7a6dafc58 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -453,15 +453,19 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
 	.owner = THIS_MODULE,
 };
 
-BTF_ID_LIST_SINGLE(bpf_sk_buff_dtor_ids, func, bpf_kfree_skb_dtor)
+BTF_ID_LIST(bpf_sk_buff_dtor_ids)
+BTF_ID(func, bpf_kfree_skb_dtor)
+BTF_ID(func, bpf_kfree_skb)
 
 static int __init bpf_qdisc_kfunc_init(void)
 {
 	int ret;
 	const struct btf_id_dtor_kfunc skb_kfunc_dtors[] = {
 		{
-			.btf_id       = bpf_sk_buff_ids[0],
-			.kfunc_btf_id = bpf_sk_buff_dtor_ids[0]
+			.btf_id         = bpf_sk_buff_ids[0],
+			.kfunc_btf_id   = bpf_sk_buff_dtor_ids[0],
+			.release_btf_id = bpf_sk_buff_dtor_ids[1],
+			.flags          = BPF_DTOR_KPTR | BPF_DTOR_CLEANUP,
 		},
 	};
 
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 41ff36f0ca77..891f777a265a 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1084,6 +1084,7 @@ BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
 BTF_ID_LIST(bpf_testmod_dtor_ids)
 BTF_ID(struct, bpf_testmod_ctx)
 BTF_ID(func, bpf_testmod_ctx_release_dtor)
+BTF_ID(func, bpf_testmod_ctx_release)
 
 static const struct btf_kfunc_id_set bpf_testmod_common_kfunc_set = {
 	.owner = THIS_MODULE,
@@ -2622,7 +2623,9 @@ static int bpf_testmod_init(void)
 	const struct btf_id_dtor_kfunc bpf_testmod_dtors[] = {
 		{
 			.btf_id		= bpf_testmod_dtor_ids[0],
-			.kfunc_btf_id	= bpf_testmod_dtor_ids[1]
+			.kfunc_btf_id	= bpf_testmod_dtor_ids[1],
+			.release_btf_id	= bpf_testmod_dtor_ids[2],
+			.flags		= BPF_DTOR_KPTR | BPF_DTOR_CLEANUP,
 		},
 	};
 	void **tramp;
-- 
2.53.0

