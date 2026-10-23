Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790498;
	b=LNo1xq9oi2ntYr/3LMF7eA6spSUNZwg/I1ph4DZ/rupoxs6ujni9wmqKFaPTSFwylq0C
	 4pkhAMYdYaSshb71W1iLQC+Af+Lv8U2x/lxdRWc/+AMOO1HA5kQ57yXUYnHxbMHhR8bCE
	 Ig9dmo0dfP69TAwl7vfLcZq5RIiwrqY9IEyepx35x1t/5TpHcLydbPtORu6Zx3dsD9aNP
	 F4H9wgbO4EO2fEI8gQ2glh6QhekTSuOCph9NDSWjdanzte1om4s1PLuDgp4IWdUlkoJOa
	 lSk68hNeDr1rOmFNE4wnfrVh/JDC82ban1sJyJp4TFYbo1l6dztjr/c0xWzMml3nvog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=541CjRYRq1Ame9KcsbUzxtaQvKuIIhHMIDtTn0eszSE=;
	b=zWD8u63va7pUdJQs0/EBDLlu+I499UP/yLS8jzpjytkYZlNfXR8nZZQfWveuWopPlW1o
	 ncfkl0DD6RHPVq2zHNloqhle69hp/3kT9hffMRu9yfBkR4FPz2OJTiemaDuOssrG1roBG
	 ittFLrsOVQfbZ+kcD5tczfMKsQlUvoKvPgIF5yhe8ffOI5aeyI/Zx4IdLKqKrXpcCYw9J
	 Fgp9Gi3lwWpU8cvjBoppuf3yqmjM9aoE6BbVYn571CopbE3ry9WOFc+30DWIrADBEgLRu
	 29fc0V7keZEVa+KDGxGY0fWlOUknItuwbuMJgiwj14Pn+ItxyuV/KaH5Nm29KitcZNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Mx9lM0gy;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F8B606A320
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 21:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51F8B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Mx9lM0gy
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8ab395abf79so13043697b3.0
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792790497; x=1793395297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=541CjRYRq1Ame9KcsbUzxtaQvKuIIhHMIDtTn0eszSE=;
        b=Mx9lM0gygze4DxRHjDv/5iKcf50Jxqb7pKoxCkNBcSoqS3Dki80jB6wvtq5fOkdQGH
         oeAgP7fSrYaBCTzM1edf2bO5Ub18vzDi+wYMiSz7xEIa2RU2fWi4T9E3Nv+RbtxQHlqW
         0ZqyWXwPkrZsNrOGX/fkYdjdjMlzIfpjS0dlSxMEAvH36H5StU8dHF0sQT/4klxPP/Ff
         7e05VgUv/e3owLz01vRLFNDeLdTfluEpZ+07PiewcxeVxG2aXYz23Gi4io8qNkuQhq6/
         Z2XZ3CBk+VYSNXEdMp8J7qeWijV7SpSha0tLfO5WdVWeQLZiOg3RYZHyg64qZMxPXKM3
         s9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792790497; x=1793395297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=541CjRYRq1Ame9KcsbUzxtaQvKuIIhHMIDtTn0eszSE=;
        b=NQivIqcMwxWw9FMl6mut+RZRuKrIDzGqoaPvh1D/QabndhssaYxYBGm4dgzFS6zRQM
         7oFfurrh9JYmLCgzrmxioP+5JeWL26+x6U/043l9U7wnxdSwen60+DixqHMwYmwA3W4F
         vIL+7G4OPxJw7ptPgK8uZApjdMHmtXALUfRo8thJ5k+hSuGgZl85mzIVTKY/gp1TlTIB
         3VvmI9SOBdhwZDvOBOh70Hr0ihfjSJSHFS62Vp6hr/gcqLGS48TyVmKiR8CERuS3MrKA
         WBTOdOEFmHv3GSJfT14+61Lim9RooaF/EEb2DIYDHS3+xRqLpy2VvAT3khw1ip8fPnkf
         fa7g==
X-Forwarded-Encrypted: i=1; AKwUvByvPuXgr6f5uaw5L7zzr/4yydU5b8Ayhfw3nTynP7n4HUTXsHKP6heRzd0oRs/vl6JtRYw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdjhxIou1j+av4wvUJyVoSjm65vR3Olaa5gv61nPjeHq1uImFC
	HY1jsFGHGdo9XyR45ZGtmBKq1asZwxMggNYKVfR0CuoknP/SBqvYbERkP4JGrQ==
X-Gm-Gg: AYBFou3S/9l50GjsVIe6stAI5u7HOWRBNA+J8g27/bXuEjY0lD/GhCCzv68bNbkm9xV
	W9eXKEzZnN+Z/k6OQDtGLJ2t+eZ31E1lWc4VQnfJ4Py9cEXsQSbsP4olgf11zDlBCMXFh1z8pAI
	yqKuK+0mbrkbmP4xYbgq/KGwj9UquR/nPd9ejpIqouoYU7Onncji0SrnFim4pb5vY1sENrODJXO
	Ty5V+1fIhHWY477bD/Aj03Be5xp98PmfP5ycviUY7ZoWWn2B+xBJaSIEyhZI+AIw9NW1j3HP35x
	rq0ikGSeNOtbyVvpKKG6/Gmbod96lyjNMmMFMCHDFtpf20xWXlCNqEaM1BXvIfDd2tVbOMJ6qin
	lOuajYr2VSPKDjsiA8Fhsf77IAoDKOcX/Bf32C8trL/laBbMrNSxpuYQqtjffraIdgppJxPBCOM
	QrfRXbSZuoLoffz/ieWFboXFYDIuEm6gJP6AYXoZp4OU2DrWlQkUannR1VynoY4lfWjsc3HwBn4
	geW4Sdh/hwDSRUVdlmyVmyWDKoiTOOq+MtioUJBUVnEBGHSOWP/1yUgaw==
X-Received: by 2002:a05:690c:60c1:b0:8ac:927:f7c9 with SMTP id 00721157ae682-8b166c1ae39mr3925367b3.26.1792790497097;
        Fri, 23 Oct 2026 14:21:37 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:35e2:98f8:e90a:1695])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166e46a93sm1915667b3.26.2026.10.23.14.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 14:21:36 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Song Liu <song@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Xu Yunxiang <xyx2021@mail.ustc.edu.cn>,
	Amery Hung <ameryhung@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v3 1/5] bpf: Don't apply the trusted field lists to an RCU-protected parent
Date: Fri, 23 Oct 2026 17:20:37 -0400
Message-ID: <20261023212041.884996-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023212041.884996-1-utilityemal77@gmail.com>
References: <20261023212041.884996-1-utilityemal77@gmail.com>
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

Walking a field in the __safe_trusted or __safe_trusted_or_null set
yields PTR_TRUSTED whenever the parent is trusted or RCU-protected. For
an RCU-protected parent that is wrong: RCU only keeps the parent's
memory valid, and the resulting pointer survives bpf_rcu_read_unlock()
as fully trusted. mm->exe_file read under bpf_rcu_read_lock() is
MEM_RCU, and file->f_inode walked out of it escapes the RCU critical
section as a trusted inode that can be dereferenced without PROBE_MEM
and passed to kfuncs expecting trusted arguments after the grace period.

Substituting MEM_RCU for PTR_TRUSTED on an RCU parent is not a fix
either. A field of an RCU-protected object is only safe to read under
RCU if the object it points to is itself RCU-freed: inode is, but
mm_struct is not, as __mmdrop() does kmem_cache_free() without a grace
period, so an RCU-protected vma would hand out vma->vm_mm as an RCU
pointer that can be freed under the reader.

Apply the trusted lists only to a trusted parent, so a field of an
RCU-protected parent falls through to the RCU lists and is otherwise
untrusted. Add file->f_inode to the __safe_rcu_or_null list: inode is
RCU-freed, and struct file is SLAB_TYPESAFE_BY_RCU, so a file read
under RCU may have been freed and reused, in which case init_file() has
zeroed f_inode. The field may be NULL and programs have to check it.
exe_file->f_inode is now rcu_ptr_or_null_inode, bounded by the critical
section like every other RCU pointer.

Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/verifier.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5601d2056218..4a32875d7077 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6517,6 +6517,11 @@ BTF_TYPE_SAFE_RCU_OR_NULL(struct request_sock) {
 	struct sock *sk;
 };
 
+/* struct file is SLAB_TYPESAFE_BY_RCU. A reused file has f_inode == NULL. */
+BTF_TYPE_SAFE_RCU_OR_NULL(struct file) {
+	struct inode *f_inode;
+};
+
 /* full trusted: these fields are trusted even outside of RCU CS and never NULL */
 BTF_TYPE_SAFE_TRUSTED(struct bpf_iter_meta) {
 	struct seq_file *seq;
@@ -6593,6 +6598,7 @@ static bool type_is_rcu_or_null(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_RCU_OR_NULL(struct mm_struct));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_RCU_OR_NULL(struct sk_buff));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_RCU_OR_NULL(struct request_sock));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_RCU_OR_NULL(struct file));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_rcu_or_null");
 }
@@ -6798,10 +6804,14 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		 *
 		 * A regular RCU-protected pointer with __rcu tag can also be deemed
 		 * trusted if we are in an RCU CS. Such pointer can be NULL.
+		 *
+		 * If the parent is not trusted, the field can't regain trusted status.
 		 */
-		if (type_is_trusted(env, reg, field_name, btf_id)) {
+		bool trusted = is_trusted_reg(env, reg);
+
+		if (trusted && type_is_trusted(env, reg, field_name, btf_id)) {
 			flag |= PTR_TRUSTED;
-		} else if (type_is_trusted_or_null(env, reg, field_name, btf_id)) {
+		} else if (trusted && type_is_trusted_or_null(env, reg, field_name, btf_id)) {
 			flag |= PTR_TRUSTED | PTR_MAYBE_NULL;
 		} else if (in_rcu_cs(env) && !type_may_be_null(reg->type)) {
 			if (type_is_rcu(env, reg, field_name, btf_id)) {
-- 
2.55.0

