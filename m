Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B78565105
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999074; cv=none; b=Y2HP7ZbCV5NXBGWoTj5InDHKt0ExJ0Kf7VM1KpIikHl2EEidp7i4Np5MW24TOGe7LyJ316umkb3xRVMzzYEjleniLd5F9OBSfmaxsPrkU4MCBGs0HOSXtVefCgNXIKIUcAQDGJgiaWwhEqQqb/VmrY7H5Sttt8vsXgj7U+gLdfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999074; c=relaxed/simple;
	bh=f8Z4d5ObIvlovymtpbAbXGnL+m4tjWD08Ntx8IVZECI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VS2/vW5ZXlwBvagnuH5/h4WwqZfvyP1EmxcJiYbHHlubAveqRDabAZTQ9oIy1J978vOnJxRkHFVcjuTsvIMjxqMD+qtmpjXLUR1mmY8wgz+zqcxC/VtQXFw/5Yt/8aPHWGo1B7wqd315+zcyrsIloSCD23H5ntG/rQMtFOVOgp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRSXAkhW; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRSXAkhW"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67990a45e02so912100d50.3
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 10:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791999068; x=1792603868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xp9k6QEpRNkLSTAVDBv+PgA4HydAw3mKZ4jg24dYEMs=;
        b=YRSXAkhW7TRqFfxL23sn9FFPabqsGa7syNDDg4No9JiKt15kLdj3Qm2Ba9fiJrOkU4
         6f5Dtyk4Pvhe48dqlJ05qZr2EtLUs2O8HNGAYfuh3SvpdJSaJR+RKOSOhBnWeW2D/NPl
         h2r8ME4Mo8QHvAiAI68FrnswawzTCa32HcvppPNLePIi9WubABsH4VHncsFRf7UHHTur
         TJuhlIPNedEaBIFj1qo3/Gihbte8uxw5lSog1I+FJiHS7CyYfV2u3DrIHHZ8di/x/DB4
         DG4oiOEqOc4Dvw5/nM0d4aOAnJD5S8qbdkYU9IAsod4eJR3CXmlBPnDf/qooJ3Ss+9HB
         G2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999068; x=1792603868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xp9k6QEpRNkLSTAVDBv+PgA4HydAw3mKZ4jg24dYEMs=;
        b=g+nwtEJ6WqU9HlAj9TjLiw8mdXbhqahzFHfHNmNcgCUYvq3WhhKqrrTbgtmOq6JWd2
         q/X8nCNNVyXbZqJUHYjfegZqXsbLmJFOPMkUR6C1l2uIgVjsuY4+DbuEqECD9rf5e/PP
         Bc0Rd0qfp7tkF9Awk2GL42WxR9qRU7L2zfmbx55Lm8dUKgobcu7+z70Hk+seiGHEuYbx
         fTvZMckSFgGxVu+f+1+yhje9vWvQ09APYgA4KiETMWCdQCDNGO7HIc61kCZ4oNBAOdlT
         Tw2nFLCgamgQ2GssSA7Cvg1qtyAM1mKBAsbwx/InJiwCBF4ydfBQ/4Nlg3mNmvONs40C
         XH7Q==
X-Gm-Message-State: AFq9FYI5QNVK6nphrHkWUfRbK7hJKd0X3AfFMGSqGqV2tcrHwmfGZjl3
	mz3eWum/HfdCa/4s8iRRaxqCOBC14Is0kz9gj+cvtD2VMMugbMeJoNLbMjIl3w==
X-Gm-Gg: AYBFou1Vr6FdIx0KTRlE+k6QX6vnbmP7gF8ZgCLgvVqpgiOh3AkPIfyI/GyRNF6nEdr
	rjbCbxgPeqNIjouhxrIvZ/5JATcT7ctehU4ni2L4x8xirYGha2laXm+vN7yduX58O5z5TedBacI
	BeOFv5ei/oXdFxKGAugNcVgR1+kK7gGDVcV1LrWF9fjIWbnlxljlzUu3Qb2Rv6iAmt32/e7lm4z
	ljBt1dVohBI5DFQbJmmgeTehN+EoEJXjl3HDpwJ4dWbW8uLgTdtNglentvLCZR6KKYovhu6R7ej
	uaNilsvNpmeSLGrHsTmq4YlqId1YDPRzGTmeh2c5SE/O3jRNx0qjahNNwL93gwy03Q3XFqMUnMS
	WozXWHot0WGBdKBIfkQw8Bw23/y8v6RoUsT0FWNPIBFzw9C9wlWvgOefdefMstgD6qgtwnKknnQ
	no6M7qc/eupaA/lm+wO9IhrArzs7xY24mmk/T3CDcO0jlEdFnx4iGbU6SBU8LUT9Is9A7kn6Ek
X-Received: by 2002:a05:690e:4102:b0:677:c605:b736 with SMTP id 956f58d0204a3-679369ec2dfmr6085115d50.43.1791999068422;
        Wed, 14 Oct 2026 10:31:08 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:8784:7d62:1705:ef5f])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67986a66262sm1277803d50.11.2026.10.14.10.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:31:08 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v1 2/4] selftests/bpf: Test MEM_RCU carry-over for trusted fields
Date: Wed, 14 Oct 2026 13:30:37 -0400
Message-ID: <20261014173039.3666415-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014173039.3666415-1-utilityemal77@gmail.com>
References: <20261014173039.3666415-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Walking file->f_inode out of an RCU-protected mm->exe_file must yield an
RCU pointer rather than a trusted one. Add a reject test where the inode
is used as a trusted argument after bpf_rcu_read_unlock() and an accept
test where it is dereferenced inside the RCU critical section.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 .../selftests/bpf/progs/verifier_vfs_accept.c | 23 ++++++++++++++
 .../selftests/bpf/progs/verifier_vfs_reject.c | 30 +++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
index 55398c04290a..f519ba5f4ea2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
@@ -100,4 +100,27 @@ int BPF_PROG(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
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
+		ino = inode->i_ino;
+	}
+	bpf_rcu_read_unlock();
+	__sink(ino);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
index b5f456d57669..b71ef8ac1798 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
@@ -173,4 +173,34 @@ int BPF_PROG(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
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

