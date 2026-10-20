Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508213;
	b=K9py0iCl3btHoDVWB4B8xAf6nERYdtz6pAaTmuXe6oXS/Ely2SqyTVhGhyjR9gbb5d+D
	 ClUPXjj7j8FHr6da22SYHVXyPIkf69IHMH7/9aYjPestXjzI515ogNmCicRVty51yHR/1
	 Jf8hXjsCCuFWUrBK32P1IrnJcE8zomqlRXjkWUDaUlDnNnXIwY0QIF+NQ75+/0dVj/HLD
	 9iljkBL3HLL7uij/aGiPu2fDfu+84em0UNQV37mu8ITFl4fKQpEmsIArGAixnmycUtzst
	 Mx0yXhUuPU/B8iKTqr0fkYzcJ0CUdjt0+dK7Qc4J3G8WFVOqJ6ELi/6S4kQgBYnjzEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=i3Jfkp9hIEUQZRTYVT2QSxlb33aqrHI5yayyK0Kb5fg=;
	b=fGSA6P9pBKlaVK6nMam1FXxhtO1muHK+sGZpJFEnIZL5uwslYHv6dGYYhRK6YASiIgaH
	 bqOVMlUufLBCaA5qrytGkNtPCcdHCo3pyxF5wfAlKnRv4EzrzglMFT0TOpoLuXHpXS7kK
	 I0EQXgkSayU9qYayQiNdEZV956LdmYlj3+M+Cl9A79PxBPLvlQAwfKbR1FQR7TCsksHOU
	 GGP19BAG6EcxSgwQ/m9pd1sPY94H9dV059dXHE28HsK364eqlX8lghaFL7xWHLEWe5uuO
	 KfDn6zypiU0QItBlXmZoUyKpzUCHdWn+cicQ5NhDT1Gf8atmvsyPMvbuf06QgYLqiTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C5RyRCzS;
	arc=none smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793EB606A323
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 14:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 793EB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C5RyRCzS
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-676804a3a22so3267547d50.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 07:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792508212; x=1793113012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i3Jfkp9hIEUQZRTYVT2QSxlb33aqrHI5yayyK0Kb5fg=;
        b=C5RyRCzSZF4Gb2mJPzCbEpOu2xb1aiZ9KV9CwBASE8GtyYiFKrQ1jI9yUjIE2fnV5a
         hmsk38XztCPRRvBzKxriuXDopM6lGpX3ucE0MRXUrI5fAr4u2nmuMpCOEETTFrOG0AEH
         tBQUKxjy28hvUm/LUj1eR7oBSePkcqYAzjk5grxJiLLW8lvFaEbGRYb/FfH11ThxoZ4C
         6uqOcwjtkRitkDHnr7VRAmlI1g64NIAeQC+iNnzI13TVZf16Q+TteUzVOEgq5J60mXvI
         qkFPOYMBmAD3mEgJhUvrPo8MP/6cXgQu4t+XsZa/Tr5/vNgXyuZhw8+wLx3pkQSaanhZ
         c25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792508212; x=1793113012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i3Jfkp9hIEUQZRTYVT2QSxlb33aqrHI5yayyK0Kb5fg=;
        b=IRhWbBtF2SW9RosGLlUyCNyi3WfUoD1s/xsriOpEtsmUIZrxaMaiJtMs/WauBHv1XU
         aBH5UumMgKav7VhalXIr0x8u7twUBHWjW1BGaPBYRzE+LxKoSYa/wDsL0bwzHP5Pnevr
         eahjmeAi7SCqQeYkecRN6aLY6RBhNu/Ur+8vR0MJwgx3gaVQX74M634FLudUOtXm14Z/
         L7lLcQEdI33h0Ux1Zt1Uqr/WLCvegUDdMHrcIBy3o/qWxxcP+92vfWY8kATrZ1Pugat5
         alBFuRGSPO3Dneo8cr77YMNfb8m+JzP8IKisDULGVegcrS3n4vcz1/xtgC5Wg0jJCgkA
         L1Zw==
X-Forwarded-Encrypted: i=1; AKwUvBwYjWVnHAbuu4FEKx3fImP7OhA5af09cjvAGAnYDkHb7FZo4xMgf4rCTh+G8tuDFDRXdCc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOdY0OdVrb099XgQijFbPjl4n/WY0dFT3tEkgZzDj5O2kj+e6G
	CzgksMmc5Glr2bihnfvEX0b8NJii68eP8LUmbP4lTvExfZKIrQB4JM6DQKA7qQ==
X-Gm-Gg: AYBFou3dWAUCqnorbogfps+KkjcU0yRiIQV+gGs+ZzWTfGGk7gJfmqSSAH0e18WbyCT
	bzEQTAkSlVl9XxKlmcHAT6OHDjJro3b80RGIrUrI3H1YIuajjinyxhQAMNtHlE5lTUz+7tNltQs
	ZrkIzmFSUk+OzsEOt/tkI2+EHuJm96ETjxKbl/4FmPVtqVJ/aaCDNUSwNE4KcZwAOe4HE9YTLel
	9LKFcccSRJWljWLer3Tjw0pbh4ha0L+dym0AETt72JuFYkxsOKnHG9Uusuc2nIovMiy7a5yiCY0
	1pz9AIMhgtk9Ys2UNAoFhhVcREXeLJ24tPJitiCn2M33o5LHHDTQyz/kepegFDQyk/gqXMidwPH
	H9XVPVAArPgNuNNjIpfaUg4mhE58jK4F5hmybmVnzFOyH/rUMquZWtBexsKTvDEzvj/FoHqx5g1
	3EkYkemQolLpYdbF80gKgW2ho8zOxAZWiDntVSkxHXUqxQ8Vd9AQZeyloVKgjDoIEDDmwBsoY=
X-Received: by 2002:a05:690e:1304:b0:679:b9ad:d64d with SMTP id 956f58d0204a3-679ca72d570mr3389454d50.27.1792508212489;
        Tue, 20 Oct 2026 07:56:52 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:8701:205:573e:17eb])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679b1c98a1esm5239944d50.1.2026.10.20.07.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:56:51 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 4/6] selftests/bpf: Test trusted-field invalidation on parent release
Date: Tue, 20 Oct 2026 10:50:57 -0400
Message-ID: <20261020145059.2146170-5-utilityemal77@gmail.com>
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

Walking file->f_inode out of an acquired file must not outlive
bpf_put_file(). Add a reject test where the inode is used as a trusted
argument after the file's reference is released and an accept test
where it is read before.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 .../selftests/bpf/progs/verifier_vfs_accept.c | 17 +++++++++++++++++
 .../selftests/bpf/progs/verifier_vfs_reject.c | 19 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
index 34919abcff04..53441391bcae 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
@@ -124,4 +124,21 @@ int BPF_PROG(trusted_field_used_in_rcu_cs, struct linux_binprm *bprm)
 	return 0;
 }
 
+SEC("lsm.s/file_open")
+__success
+int BPF_PROG(trusted_field_used_before_put)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct file *file = bpf_get_task_exe_file(task);
+	ino_t ino;
+
+	if (!file)
+		return 0;
+
+	ino = file->f_inode->i_ino;
+	bpf_put_file(file);
+	__sink(ino);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
index 7ca0d8c3edf1..c2be63ad8055 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
@@ -224,4 +224,23 @@ int BPF_PROG(trusted_field_escapes_rcu_cs, struct linux_binprm *bprm)
 	subprog_trusted_inode(inode);
 	return 0;
 }
+
+SEC("lsm.s/file_open")
+__failure __msg("R1 type=scalar expected=ptr_, trusted_ptr_, rcu_ptr_")
+int BPF_PROG(trusted_field_outlives_parent_reference)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct file *file = bpf_get_task_exe_file(task);
+	struct inode *inode;
+
+	if (!file)
+		return 0;
+
+	inode = file->f_inode;
+	bpf_put_file(file);
+
+	/* inode was pinned by file's reference and died with it. */
+	subprog_trusted_inode(inode);
+	return 0;
+}
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

