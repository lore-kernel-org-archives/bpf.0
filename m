Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790503;
	b=RTyWVGUJgDR4cOPuZdBuoDOeRwHynAfeXgK89XCkp6sI55UiTUcghPLtJBi+AUConeTP
	 Cr0a81+LkvNTEq3NJfw0kow71Ta04VmBNg39QuZLy7aU7r8FygWwmtlIil8aGn0keA7aH
	 5enSrNFJ7Q6qRypMJF7e3L/qn6jjWJ+nS6NFIN6hwU5axlY6tZ1tDNW+WY5FyD+DuPznw
	 3W6RhM1n6maIGKDPE4jy672fPxinONqgCkJl70JlZcq9hNBx5jlOQFJTlgK1nbQdVqZeN
	 rJx+l/X8I9jfiuz+ZucXQwBcP0ms6ldM99B4KRXLZ2VgTEHUkow4cYiBCbBCACMbMgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Cxf5OGVtt64HO/EUorQIz6/17tnDBQQtKzhVw0jTRWc=;
	b=iUV6/fD0RizFcbRPPAA61ttdYK4E//NIagr95jzZ82ZHTYdV3aXrWttkAd/H75zQVevS
	 RyqLsKpn26GHCEz+jPhURjZ0/NHruiwff1XZ+nQG8sPeRqazuOg1jHLyAhaOyU/ZI+6zk
	 qApauG311rAWRYRNUxnBTt90+XL+A7BO6fVfFi4Tet1IFtnEf/1cB/va3OIAaD6DJT/As
	 IgJUbD8rCcIm9uYNVwgxePX/rs6T2TNsWKzliHnsA2OMEDOfJ8BcCYenKd5yGfXsg5Vlv
	 10GS3A8CbENvNFlU+4LoHLkAfDWQU8EV68FC1fPJSI9i4o5gD84pvgkv04ZBjDQKuPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bOpOBHsA;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793AD606A326
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 21:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 793AD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bOpOBHsA
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b05bf699easo13462717b3.2
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 14:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792790502; x=1793395302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cxf5OGVtt64HO/EUorQIz6/17tnDBQQtKzhVw0jTRWc=;
        b=bOpOBHsABxjSxWcPp5eQxR6H6gks1skbOR8mrJWnFMEVnKaNiY2jVDA45gCMp1X1AJ
         HUpGyB70LIn7QJpGbnEjMq92Du+O6gN8XcmUB1nHYUDav+j9FPtsawO68ygIQlpjpW+P
         KmwSjNfl/xlPzPTba3aOOUGhndLhS8GumHSXNxbekErxvJ+cXqfYpgbfy88gBUJC8zAI
         +EL+O/dgQ3av+ww5ALCiLByjdz9eMViK1mgLTb4uM/0YaJUkuUWD08XaNfMEdTurnsbk
         wERMAMzTvDR6ZiAynE+/nvF9ST+rB5y7V0leVPYSIpv0bW9a9L4AuYpsIm/rHSLNlv+R
         paFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792790502; x=1793395302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cxf5OGVtt64HO/EUorQIz6/17tnDBQQtKzhVw0jTRWc=;
        b=os29RRk7XR7k2Pfif8bDraG6w5igPSRfD19sno2podaYmFmvNl/h65aIv3XaqGMuVi
         y9Pi4MwZSs5ClnXR2sC0AmYQnJeeYumvXSQbjgvoCDaRvIb6I0EoEoPFw5QPNJTrnUxu
         MS8ILh1gMYHAkbm3+uhDULHwF3JQPrD859EL6pUpzSUnpyqn7XXBMd+k6V0rAMkQL40P
         j7yef0XLmhXV0aMZCzsSlL4BoOb4ONIDI1L+J+Ve9B02X6nrbTZKmxrzh7YVZrU15tCl
         FTfk1ZLORvzLSYbs43p/vFPWIozefN8pJVFlPGGVxc9qa6tehqHpIlZ8qM9pTY/pubA+
         qkhw==
X-Forwarded-Encrypted: i=1; AKwUvBz25DKTCXh/6JAMMbdXj+LO8ZkwZX/PR4cxEhF0fqDu0WFb+wFezXRgrHcP6DwOxJ46P5M=@vger.kernel.org
X-Gm-Message-State: AFq9FYIcc3nbkhoaF1bD6fan2X8xA9LgnFC9XkD8S7iILeEiCQOcK/vK
	7NU+2v0Xehu3cT0hCGtSS/513YPE/hU3ZcFSn/YMiilzmHi2ZuBEf8YU
X-Gm-Gg: AYBFou3dZhWbodSltGQYjLZtSU50eIKcrslTJ+9v5XaOp542XQ2Y2S1lU1zj7IeLUtu
	01mmKthocF7w3ar6w4hfb190qPhtdpsT44zZqhg6NI2IGb3qNbbQmjCYSYp+q71EwB+4QwPfv3c
	C44h7yA6UWtZVR+t7H7Iv1fSHNWyAo+uq3zOpcM1cP1Mce4zmRsk7q5RvBCMWOp/Bobh7iYOCQb
	lypFEMCo413qmWxJPSrz4ve0G0Jo0gLEwtnOEggIy1Td9M9qlm209BA5c1/s2rA2hHSz46hf2j4
	5cYjvgLTL5SkrZahxeQFngWTJiHh0pvse7kr2zRe37T8GDbYrcReEeNG/k2H7fHQXmJtJmkydL3
	JMALIUx8qHnCMmZCsnZPqbWDX824nnwNE8RzhuhLMyhUpjph8eEpZ6GSKUXdt7voMA9mK9FZbi+
	1SoBTZoa1FkqPuGvDLgwNFmRJd+Do8WjUGlSrRwhtDSdWS/GzUgMQAbyE3NNOaALBC8rt92t1XM
	uOEJyUm4/1s76opt+t7tPlQbv7MdZbEnR1mCezt8xE7gy6IwJO8Xh7ZyQ==
X-Received: by 2002:a05:690c:e3ce:b0:8a8:8945:c423 with SMTP id 00721157ae682-8b166c5d5ebmr2992637b3.56.1792790502422;
        Fri, 23 Oct 2026 14:21:42 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:35e2:98f8:e90a:1695])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166e46a93sm1915667b3.26.2026.10.23.14.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 14:21:42 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/5] selftests/bpf: Test f_inode of an RCU-protected file
Date: Fri, 23 Oct 2026 17:20:38 -0400
Message-ID: <20261023212041.884996-3-utilityemal77@gmail.com>
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
index b5f456d57669..067b4f979902 100644
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
+	/* inode is an RCU pointer like file and is untrusted after unlock. */
+	subprog_trusted_inode(inode);
+	return 0;
+}
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

