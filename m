Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793494601;
	b=rEeF40d58FKuEnK/qat8BHlqe5Z8LujcR0MEfK8c/yug3qFhKk03r7QJaf2r++S85CvL
	 +w1pLM8vHCUofba+AgN3ww/OR2RLKc44oy8mDDxeX+4kIB0GTKKH7aK4dvkO4lOzNnmcQ
	 qfK4izGDn6f/PxudkK+OpNIze4nQOxBL3t0rvU2AhPrXq5tHDVa9ZqWkGypzXtrfjgatb
	 ugdslc7HuxvkAyyhSC1wc4dUVrbhGWyKE4LG0dnWLhGBCtWoB1sQNzOCv22edkwA4tHFe
	 Q1/HyH10Ixz3YAom7aoBxHu9504enmLDhjBSEKRanXCNBVvTiHbywOPtTU3RQrKwSow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793494601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=WpPmlyynvDUMe1He5kADoWQv2vMHrwCbBfff4xiiiVY=;
	b=IcI4syBotZ7445tOu31CIRtTN0uxcPiasIbuNZXcxbzreHK83Ypapi9vx29oJea3jyO1
	 EH266pUvKCDvkyBUV1m0WDEuWl25V/tUT8Ah1BbbxLq0NrEE4ANyuf5BRJu2Yf7MmTIjl
	 t33oiH9plBnAaaZtpM6+pB/r02fX7nQo7lAqxOyFRBTqZRNpGahIRlsBjLOQ5Roreajuz
	 8IBPn4D3yW+TSrGLNOVq/wjQmFGlwRi6bf01idwXGSqoZDxZy688+3nYbMqgiYNSTbyiL
	 BtEYu53F/zWtCTCP5vDTfqs3gQeyfxIlfrW4uZe6IcTU6uQWtzqhOZpyi+sFGh+/BFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Xxu/mCu/";
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66AA606A31C
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 00:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C66AA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xxu/mCu/
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ada8bc2380so839760a91.3
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 17:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793494600; x=1794099400; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WpPmlyynvDUMe1He5kADoWQv2vMHrwCbBfff4xiiiVY=;
        b=Xxu/mCu/OESL41DxQmT3WfQHPJJsrR4xVMtYEYQ0t0SplR5AaE0nB+FFeycO0fv99G
         QeV5kqJw04aM2yv9L3RVq5xoMMqAxapcIBkPRdAxn4DqZaRM70kQGAtH87eaPHFBlxXg
         KeTyW3gHRaeVi+c0weAHStWKQVFttPKKXaOF/Gx98HGGhQDaRfwUvSqaJM4Nn/AWqIpC
         FasfEij4IBss6TEkUYjnsce476QMHqGpg95S8rZkdABCJ1GjDvA6NrXs5Ak97uRsWPnr
         6n4ehoRWkGKA0mXUJN5owRgKTLJoeCtKQZmyoeU3WiFELnTJv0E9dvggRpgqP8SHFVTt
         udWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793494600; x=1794099400;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WpPmlyynvDUMe1He5kADoWQv2vMHrwCbBfff4xiiiVY=;
        b=N6F7bYfUdRDuTGQ0W8aXLPHnLcvmSLUfAnxlZfjVjeIU47a07xJL2LTZcKpIQqJSwR
         JDxEcBekRMJjn/5QuQYj/kWuNCMGmM2KTYkuMbsldFsBZQsAwxo7G0ghJfKoXZ1T5Bl8
         LdBRUlvJCq9h8Bd4zeRuOspYp8aMsa9tFUkyEH+x/EXZas6Rv3AbE1eXIEtQ3eQmn5rH
         Rg4URQ7IXIRAT4ClA563hlcWQMkQgwqQkNadUN2SO9WhGqPfNKOb/oaR80+dYr4gwafg
         Fl9nkYcB0wjMY3GMCb+369fiaYGV9XYmXxqyEBT5fCM+iPRk4Kzjymo90CrHXSc8nXcI
         JbXg==
X-Forwarded-Encrypted: i=1; AKwUvByDXasNSUxq0oIpLMGdW1N/rCIc07aQHJZec8FRwI6KGYJMl48N/STPg7Es25hPivAqS94=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TzeNCNNeBP5q0SsUf8Pdc6wrR7lCViXlGtfyhblLaf/6sJ9ne
	TBb+PYreDsdwqX4jADl1SvJgYpWYo1vF2609pjnWyGrO0zq/BCvyTEZs
X-Gm-Gg: AYBFou3w5HcygbRbE/3mtI0xNgEhL2JhpfSjNiHTr1goazZQq/81fU2pJODcLH0J+mj
	SFb6I8RuHxowYVQt0UElhealB6tWPbBE23vmAjBnvPxdzJ6hkOGELGHKeHJaMIwWNInhbZn7kTj
	kile6B+Q82OFQv9zW5py5eBlTr2DHvZRhtMBNo9qrNb2RxCW4GwD0H8ag26hyT1PFwjmUOOGKpt
	fR/Vzi5CQPa+OoTFvC0tVkSkU28IO+o+Qsif3eXNRwyO7YheYftJpJUGJsUdaqlhz3JnzSSo5E4
	mU5YOn5enOxbZxgvLc6UIhLtpM9DTzlBG7v1FnM32DYJLolHGfKT4szXHEBvQaCmqfrYNT7lfE5
	JHAC7amw4YaOCDCm1PjpkvkBS5G+AI1YXN2aRDBoT6OMAytPmax4LAbu7pZgm6gQks+KBFdRHww
	Vo7vuEjrgcMg8lvbuZmEg84uPsHRZz0XCWgMjmge7iQ2FAb+0hXkHutaRX7PfdNI/Pb9DfeYZb3
	lETupfnmGGxLB10ezSE6u0lteqz+LAxP60w/SJxvote/AfRM7INCPDgLqMcrH5NS9YmO4L+0gOQ
	zf+jPqpLFZ/iC2CU7J8Bxa7wiEJjfg37tDl47D2xVGOZxEYb48fuZ5BqOOgHdRhA1bus5LdCozB
	xJ1GKqMNDFw4/zZcc2IEtO24F4QSioTGTVBCGGRq5O1nRQQc6yDu9eV0=
X-Received: by 2002:a17:90b:1644:b0:3ac:17c:6e85 with SMTP id 98e67ed59e1d1-3ae897c94ddmr5486226a91.47.1793494600050;
        Sat, 31 Oct 2026 17:56:40 -0700 (PDT)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae880a46f1sm3921333a91.3.2026.10.31.17.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 17:56:39 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Nov 2026 00:56:38 +0000
Message-Id: <DMJGRWDYEWL1.3FPGI4KTRWAPW@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Anastasios Papagiannis" <tasos.papagiannnis@gmail.com>,
 <bpf@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
 <jack@suse.cz>
Subject: Re: [PATCH bpf-next 0/3] bpf: Add bpf_path_getattr()
In-Reply-To: <20261029095952.44833-1-tasos.papagiannnis@gmail.com>
References: <20261029095952.44833-1-tasos.papagiannnis@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Oct 29, 2026 at 02:59 AM Anastasios Papagiannis <tasos.papagiannnis@gmail.com> wrote:
> The kfunc returns a 64-byte bpf_file_stat. We avoid using struct kstat
> directly as this is an internal structure and this can lead to changing
> the user API. Inode and device identity follow the filesystem's getattr

kfuncs are not uapi. See "kfunc lifecycle expectations" in
Documentation/bpf/kfuncs.rst.
The prog reads struct kstat with CO-RE like any other kernel struct.
No need for bpf_file_stat.

> operation, and the device number uses stat(2) encoding. Mount IDs,
> mount-root attributes and ownership translation follow statx(), including
> mount idmapping and translation into the current task's user namespace.

bpf_path_d_path(), bpf_real_data_inode(), bpf_get_task_exe_file() are
thin wrappers of vfs functions.
Lets do the same with vfs_getattr_nosec().
like:

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -96,6 +96,37 @@ __bpf_kfunc int bpf_path_d_path(const struct path *path, char *buf, size_t buf__
 	return len;
 }
 
+/**
+ * bpf_path_getattr - get the attributes of the supplied path
+ * @path: path to get the attributes of
+ * @request_mask: STATX_* flags of the attributes that the caller wants
+ * @query_flags: AT_STATX_SYNC_AS_STAT, AT_STATX_FORCE_SYNC or AT_STATX_DONT_SYNC
+ * @stat__uninit: buffer to return the attributes in
+ * @stat__sz: size of the supplied buffer
+ *
+ * Ask the filesystem for the attributes of *path*. This is vfs_getattr()
+ * without the call into security_inode_getattr().
+ *
+ * This BPF kfunc may only be called from sleepable BPF LSM programs.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_path_getattr(const struct path *path, u32 request_mask,
+				 u32 query_flags, struct kstat *stat__uninit,
+				 size_t stat__sz)
+{
+	struct kstat stat;
+	int ret;
+
+	ret = vfs_getattr_nosec(path, &stat, request_mask, query_flags);
+	if (ret)
+		return ret;
+
+	/* struct kstat in the prog's vmlinux.h can be smaller or larger */
+	memcpy(stat__uninit, &stat, min(stat__sz, sizeof(stat)));
+	return 0;
+}
+
 static bool match_security_bpf_prefix(const char *name__str)
 {
 	return !strncmp(name__str, XATTR_NAME_BPF_LSM, XATTR_NAME_BPF_LSM_LEN);
@@ -504,6 +535,7 @@ BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_get_task_exe_file, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_path_d_path)
+BTF_ID_FLAGS(func, bpf_path_getattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
@@ -515,8 +547,9 @@ BTF_ID_FLAGS(func, bpf_sock_read_xattr, KF_RCU)
 #endif
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
-/* Side-effecting kfuncs that stay exclusive to LSM programs. */
+/* Kfuncs that stay exclusive to LSM programs. */
 BTF_SET_START(bpf_fs_kfunc_lsm_only_ids)
+BTF_ID(func, bpf_path_getattr)
 BTF_ID(func, bpf_set_dentry_xattr)
 BTF_ID(func, bpf_remove_dentry_xattr)
 BTF_SET_END(bpf_fs_kfunc_lsm_only_ids)

pw-bot: cr
