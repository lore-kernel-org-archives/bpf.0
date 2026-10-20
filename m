Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508210;
	b=YWyGK0Q8i7KNqWPzSF1fPsKuSavDQLheXpWq521vHufXI4Wz/3OSfPFT/SvJNt1FreTu
	 RLDs6dnYRAjmfT51LUGB+bHS/46Vz+vt5jJWLJYak31ebUTF4WxKL4H13fs9mrrOK+/f3
	 VNTpKBO05ZbJnKEcvSWYowMdBmqQ6qbur4fCmGVcjc38Xzy9t3/OSTNXZcyZTchUUyazz
	 mcGPYL2jmHLNJIJckkxVRliFKD7VV4T66G0E2vzwDefZavxzvEpVNzDp//WnVRLcUtXyn
	 IjCiy0b/WuW9eUO0gPbzpokm3ld5UN1ObFlK1v26H49106nwa3k4LvD02DF9QITtUeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uiiIL8NFGD5DETU2s3g3/cnc9XKzRM8iH1yFYNpgoQc=;
	b=go+0Zx4ySDHpa72wpaFVBqHkjF5xxfu94G+2F5y9oy98cRRFXRTiZilrzXRPzfwyPpfl
	 3k5xfUvw0EuWBq9hVQyI5BcE8zeOdtSM7H1n36zrPZUMx0gYg81hYyUIlFitjJxU4e+AQ
	 FBNlygcjwyjaRsXiNrPI0uPH5wOKQni/NJ+Avmwa0OWhNCMl+3mlmryi4AeH/OoCIMtx2
	 0OeP1v9fMd5uLINAtk632sYIubQCZ5gz4LOnwGQk+TBkkOEftOzNPY1dCFJVvSnKm2ZNB
	 1hkiAsWnKkhWQORkVxLt+COqH2lXQoKoSCEoyvgUgMRz2ry4nLq1DWT3v3+OupwOhOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="dys6/S4d";
	arc=none smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA6606A31F
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 14:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5AA6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dys6/S4d
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8ab432273c5so26273917b3.3
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 07:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792508208; x=1793113008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uiiIL8NFGD5DETU2s3g3/cnc9XKzRM8iH1yFYNpgoQc=;
        b=dys6/S4dmC8/FQAgnJSVVfAmUAVkH3lDMexZZlMx4d2L/zHVtug/uiXotBrpfclY/S
         pBTdGqOZJ39oMHL8AQQxDJ+V5Lo0dsEd6S0yuhlA1JFJ2ax3xjSuDS2NNj1Qo8M4PYq3
         OTC0uho4DQ94H83ZgAJAE6qileaBK+hZRT5fzlv1i/wsJXP3/0Y/QjWtuaec/JloBZvp
         xdhfQ+mxfbk7Mu7oH1E/jg/IdeXHcbnJEGFJtgzHO1xos97VEnGqaYdX9LkOwoMgTiN3
         r8zLfBKQWi74qvyijH7XLkxxLzlmFLH21PQKwGIct/4V8QlQIi2hK7bxtEn2iidWr4X5
         yYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792508209; x=1793113009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uiiIL8NFGD5DETU2s3g3/cnc9XKzRM8iH1yFYNpgoQc=;
        b=v/ptZWLmlCUvV9m8PVmZiNSCQkXmjYqCIGkPEjeKIcxTCGeItWj3a+X4ki9II9Auey
         vFROD+qkSieWlY+udfuFbrJNv1clC5qdhy7FM+uq4T3oiyzK1Z1Mys4ulV//IR+xMF+s
         H1hlaJS5fwANDZh5PBqL4sIH9+lEGXOR6NFYtv4luh6i8LEtBAb3WPN5qH4Fp0jxsYo/
         fXM3VAhZJ/Yw8UbDgVWVnM0wT/xgMDnmblNY3Cbtm92vYE1oAtm+au9YX7rN5FKKqt1Q
         A0AtVHhoRqVMcIi1NwQXdX4ULw0oq9LKr1BaV2Zu8oNRp3zdcsGXXXCBfX0wgtyw2JZa
         f0lw==
X-Forwarded-Encrypted: i=1; AKwUvBy3gQIX7Xwtr51S0tIj45kamKUCnBuCrrMmTs4XYbGSx6B9s6z9GgX7++Ot62+QRXM3/3E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZ3ULyuPRZeji3RcMH4v/wYNmItfx4iWf6EDEVlHKlLYhsA9LG
	gWJtQ8q9rDv64X/FL8wsWzf90jAehr95LAOepSNkANfLuP2BpLbQcZu5
X-Gm-Gg: AYBFou1YQrn8yagdrvKmUgSR1dYYei6ZvMaQ0nk+ZK4PmrozCR5FN7yXs+pNMkL5Wzw
	woEUJynvv9TmS18CkCvEGn9EuEv8ASTHFwsq7xvD/AadgIUWXkizXogbI/n2stUX6P2ru7lQCmJ
	XJynqmXqZ22cEP5CnsDTUHs9G+UZMGR7Ae+4p1slL+lgXcNH/pd41+pfLtrZpqrwdk2MZFpcIDG
	fScakvJMYGFg4ZctHJWNVwfzoyi8Jcx3Rw79Zl9EdNEv9Vk84/vL9B79oCbPN9H7m76nXZHKT57
	fAZgTfSY+LbPm/P6Zu2Z0jl5UAIW5aaWa0Kza1GwOhdGkYU5+Q9E/t9Ydivy/X6ReJgovqaJ4V8
	4Hjj9KsXHK3d0nuSAD9M9O3LHomazdfLY6cv1P1p9CzZAlI/182xVffcuEUTy6Fbs4ZJ89DhGgE
	k+vltq5XYX/PuLT1hSRYKXo0oFrPDwqQ39Po3uiuD+Y1V3n+vcYePx4qJbQL3Ap1hLQ7/Ppy0=
X-Received: by 2002:a05:690e:2606:b0:677:bb39:4c1b with SMTP id 956f58d0204a3-679ca913128mr2850089d50.105.1792508208677;
        Tue, 20 Oct 2026 07:56:48 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:8701:205:573e:17eb])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679b1c98a1esm5239944d50.1.2026.10.20.07.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:56:48 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Song Liu <song@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v2 2/6] selftests/bpf: Test MEM_RCU carry-over for trusted fields
Date: Tue, 20 Oct 2026 10:50:55 -0400
Message-ID: <20261020145059.2146170-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020145059.2146170-1-utilityemal77@gmail.com>
References: <20261020145059.2146170-1-utilityemal77@gmail.com>
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

Walking file->f_inode out of an RCU-protected mm->exe_file must yield
an RCU pointer that may be NULL rather than a trusted one. Add reject
tests where the inode is dereferenced without a NULL check and where it
is used as a trusted argument after bpf_rcu_read_unlock(), and an
accept test where it is checked and dereferenced inside the RCU
critical section.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 .../selftests/bpf/progs/verifier_vfs_accept.c | 24 +++++++++
 .../selftests/bpf/progs/verifier_vfs_reject.c | 51 +++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
index 55398c04290a..34919abcff04 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
@@ -100,4 +100,28 @@ int BPF_PROG(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
 	return 0;
 }
 
+SEC("lsm.s/bprm_committed_creds")
+__success
+int BPF_PROG(trusted_field_used_in_rcu_cs, struct linux_binprm *bprm)
+{
+	struct mm_struct *mm = bprm->mm;
+	struct inode *inode;
+	struct file *file;
+	ino_t ino = 0;
+
+	if (!mm)
+		return 0;
+
+	bpf_rcu_read_lock();
+	file = mm->exe_file;
+	if (file) {
+		inode = file->f_inode;
+		if (inode)
+			ino = inode->i_ino;
+	}
+	bpf_rcu_read_unlock();
+	__sink(ino);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
index b5f456d57669..7ca0d8c3edf1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
@@ -173,4 +173,55 @@ int BPF_PROG(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
 		return -EACCES;
 	return 0;
 }
+
+__weak int subprog_trusted_inode(struct inode *inode __arg_trusted)
+{
+	return inode->i_ino;
+}
+
+SEC("lsm.s/bprm_committed_creds")
+__failure __msg("invalid mem access 'rcu_ptr_or_null_'")
+int BPF_PROG(trusted_field_of_rcu_parent_unchecked, struct linux_binprm *bprm)
+{
+	struct mm_struct *mm = bprm->mm;
+	struct file *file;
+	ino_t ino = 0;
+
+	if (!mm)
+		return 0;
+
+	bpf_rcu_read_lock();
+	file = mm->exe_file;
+	/* The file may have been recycled under RCU: f_inode can be NULL. */
+	if (file)
+		ino = file->f_inode->i_ino;
+	bpf_rcu_read_unlock();
+	__sink(ino);
+	return 0;
+}
+
+SEC("lsm.s/bprm_committed_creds")
+__failure __msg("R1 type=untrusted_ptr_ expected=ptr_, trusted_ptr_, rcu_ptr_")
+int BPF_PROG(trusted_field_escapes_rcu_cs, struct linux_binprm *bprm)
+{
+	struct mm_struct *mm = bprm->mm;
+	struct inode *inode;
+	struct file *file;
+
+	if (!mm)
+		return 0;
+
+	bpf_rcu_read_lock();
+	file = mm->exe_file;
+	if (!file) {
+		bpf_rcu_read_unlock();
+		return 0;
+	}
+	inode = file->f_inode;
+	bpf_rcu_read_unlock();
+
+	/* inode inherited MEM_RCU from file and is untrusted after unlock. */
+	subprog_trusted_inode(inode);
+	return 0;
+}
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

