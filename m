Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09CD5C908
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710779; cv=none; b=bqmXJG17mJxGAJCKj4xBB9GCu8LGsVDURvuiZRmL4t+cgOQ0aOZ6zpG1DWB7T5kh6im589T9YOgKsF/ipmL9aQ6ZcSlnjlnSnetZaDdrEMvc7jA3j/yPWfDDA/2NsaXpOoNOdIGGgvhugns+fwEmSz14l/YYk09xAusr3ZtzcK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710779; c=relaxed/simple;
	bh=SjcPFs4FSNGJVgC8/xMl+u/Ln8ryXAZgM6Iqr7AKav8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzicwcepsxTmRcAYVfaydLWloIeIXOfXJxakCCpi5o0h8d2Jnj+ejF8WPxvOYKAb0inL031gMLZU24vg72C68Ht7q7jKARYR4rv2rLvCWJthQrIhJRIsxQivP8zG2iOrdncume1w97Rvehu8mmqUmfaetIpq231XrUZtlOcYdxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e9ONgnqH; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e9ONgnqH"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5673f7b3196so4138706a12.1
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 23:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709710776; x=1710315576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qxd4dSDwNv99KGxLpWUkcR9yGfGt5zeMhN6bbg1OOSY=;
        b=e9ONgnqH1+Bcbdfc84yzWIlabT7FE0a9H11/wM8LJ1/C/+yQCgWn/7XKeAHqOTj2Ie
         DYBlWNWB+JNdtKjq/jimQc7k1Y8TsoPAY2aqFLlbTYjrpj+AjWodVpFpFEArHAAnRbIh
         iodMIaVUxA3DESanSDyn83De5e9yqxfmP/eRnnjA4PO+eh55I1A1m4KnHdqaKyb6+/Gg
         NiH/RNc8tcnlu6JJfm6EMoZU/qjtfOdHvsGP5Ti8JlA2UUwAQUmfWQMp8lwnnaHoFf6V
         ADnHxGgJxQink44oLg6wSst9/AtkIBNkRClhFv/hrmfTATUhKD426W0KQdaMD/m18k/f
         1Tgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709710776; x=1710315576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qxd4dSDwNv99KGxLpWUkcR9yGfGt5zeMhN6bbg1OOSY=;
        b=JGuzrUsmK66oeBMq3zehm2Y01kr55KMuMLGg/disEHviE9Pl04K+uG/AzzrY3eYvZ4
         4K4byiU1/JPfc5fC8P3vlzUtuMYrOmJH3U7171m/a7qdk7I5JnQzcsDBkJKi29mOLqQF
         tQdrNsRweqvhMDQb3nbIpyp8g1WZzxJfkPAozlsUfvykubOmVjXBMXyFt0h8Elfcv6ck
         u3DYP28yc8K3wQSeZeVvj/18rbtl5h3iCyhob1C/e2K5cwKILhwzPNGmde3yXmQYQom7
         KspQ1XC8zo+b0n/HC90gwERbs4mMlfFCU7wWG3XfdeRVb/c/Ewhnv19iRSJGmG45x6/y
         vwlw==
X-Gm-Message-State: AOJu0Ywv1uzCxyeM5u7BuwTD4y7AOQfYnPw3ZM5XIa83jt1uUpCoxVkc
	mAFIoF9s5zUQZXUy4ujuwttCmsJzE99tqX9roUl+GXkPCaFhGq3hNYmNRJRQYd0gC0H5/Azm9en
	+IA==
X-Google-Smtp-Source: AGHT+IFrTJ3SPPS2VPtMnyftJIZ3jaBujsED6xYduhc/AQg4M3oootOZLPE4aPQqjEP7HRt9tCujOQ==
X-Received: by 2002:a17:906:7192:b0:a45:a928:8b65 with SMTP id h18-20020a170906719200b00a45a9288b65mr2845141ejk.28.1709710775587;
        Tue, 05 Mar 2024 23:39:35 -0800 (PST)
Received: from google.com (12.196.204.35.bc.googleusercontent.com. [35.204.196.12])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709060e1200b00a459094cf61sm1969118eji.115.2024.03.05.23.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 23:39:35 -0800 (PST)
Date: Wed, 6 Mar 2024 07:39:31 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 bpf-next 2/9] bpf: add new acquire/release BPF kfuncs for
 mm_struct
Message-ID: <eb9fb133d5611d40ab1f073cc2fcaa48cb581998.1709675979.git.mattbobrowski@google.com>
References: <cover.1709675979.git.mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1709675979.git.mattbobrowski@google.com>

A BPF LSM program will at times introspect the mm_struct that is
nested within a given task_struct. Such introspection performed by a
BPF LSM program may involve reading virtual addresses out from fields
like arg_start/arg_end and env_start/env_end, or reading fields
directly out from the backing exe_file. In order to perform reliable
reads against fields contained within mm_struct, we need to introduce
a new set of BPF kfuncs that have the ability to acquire and release
references on the mm_struct that is nested within a task_struct.

The following BPF kfuncs have been added in order to support this
capability:

struct mm_struct *bpf_task_mm_grab(struct task_struct *task);
void bpf_mm_drop(struct mm_struct *mm);

These new BPF kfuncs are pretty self-explanatory, but in kernel terms
bpf_task_mm_grab() effectively allows you to get a reference on the
mm_struct nested within a supplied task_struct. Whereas, bpf_mm_drop()
allows you put a reference on a previously gotten mm_struct
reference. Both BPF kfuncs are also backed by BPF's respective
KF_ACQUIRE/KF_RELEASE semantics, ensuring that the BPF program behaves
in accordance to the constraints enforced upon it when operating on
reference counted in-kernel data structures.

Notably, these newly added BPF kfuncs are simple wrappers around the
mmgrab() and mmdrop() in-kernel helpers. Both mmgrab() and mmdrop()
are used in favour of their somewhat similar counterparts mmget() and
mmput() as they're considered to be the more lightweight variants in
comparison, and there's no requirement to also pin the underlying
address spaces just yet.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/trace/bpf_trace.c | 47 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f639663ac339..801808b6efb0 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1473,10 +1473,57 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
 	return __vfs_getxattr(dentry, dentry->d_inode, name__str, value, value_len);
 }
 
+/**
+ * bpf_task_mm_grab - get a reference on the mm_struct nested within the
+ * 		      supplied task_struct
+ * @task: task_struct nesting the mm_struct that is to be referenced
+ *
+ * Grab a reference on the mm_struct that is nested within the supplied
+ * *task*. This kfunc will return NULL for threads that do not possess a valid
+ * mm_struct. For example, those that are flagged as PF_KTHREAD. A reference on
+ * a mm_struct acquired by this kfunc must be released using bpf_mm_drop().
+ *
+ * This helper only pins the mm_struct and not necessarily the address space
+ * associated with the referenced mm_struct that is returned from this
+ * kfunc. Internally, this kfunc leans on mmgrab(), such that calling
+ * bpf_task_mm_grab() would be analogous to calling mmgrab() outside of BPF
+ * program context.
+ *
+ * Return: A referenced pointer to the mm_struct nested within the supplied
+ * *task*, or NULL.
+ */
+__bpf_kfunc struct mm_struct *bpf_task_mm_grab(struct task_struct *task)
+{
+	struct mm_struct *mm;
+
+	task_lock(task);
+	mm = task->mm;
+	if (likely(mm))
+		mmgrab(mm);
+	task_unlock(task);
+
+	return mm;
+}
+
+/**
+ * bpf_mm_drop - put a reference on the supplied mm_struct
+ * @mm: mm_struct of which to put a reference on
+ *
+ * Put a reference on the supplied *mm*. This kfunc internally leans on
+ * mmdrop(), such that calling bpf_mm_drop() would be analogous to calling
+ * mmdrop() outside of BPF program context.
+ */
+__bpf_kfunc void bpf_mm_drop(struct mm_struct *mm)
+{
+	mmdrop(mm);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(lsm_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_mm_grab, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL);
+BTF_ID_FLAGS(func, bpf_mm_drop, KF_RELEASE);
 BTF_KFUNCS_END(lsm_kfunc_set_ids)
 
 static int bpf_lsm_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.44.0.278.ge034bb2e1d-goog

/M
