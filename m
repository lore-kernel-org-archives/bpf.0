Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43021ACEDE
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 20:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777838909; cv=none; b=g2aiqYtQuGSH2l6eFqYO3GeDVFsJEW0aK48CkeXsoENcmhjGrnroRpRA8LgduZCvXGnZRmu5hvIp7sUhRPOZPJYovhS+CbSRz0kBwalG8UQfrOY+/z/9lgkmh1eLF5Znq/v5DlKP8dinxxY4cQfejReHMbO1BGpHbJUJK75Xhu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777838909; c=relaxed/simple;
	bh=HWlRZuHNGlpgt5W8GmwMJ+J30mhGoaFSsisafDojTk8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AGrUmKXX+/s8TiK/uJD8upKtxV5so7yDaMXUaulZvsj2ACNABoXID0Gf9ZQpptrcg8Wgu3yObi7zyB1+/N7qPcdmuIFOMoeu2KwSl5RxM+r2AmR+q2svg/gngMKN9wKywzaW1W0bOKVjV3meP8DOJjCBy4lAqj5yGAuBHF6I7Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HP13iNXB; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HP13iNXB"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-671bcc1e533so2929624a12.0
        for <bpf@vger.kernel.org>; Sun, 03 May 2026 13:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777838906; x=1778443706; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JmpWw4FcmIl4qsyN9GknTKo7AHvNuJg0BptOENFVXtA=;
        b=HP13iNXBhxeO8kLoEOelmMFQ351Q+5Hph9Z8vNsA/nx/WJlxNZ1P0v6LpUOecv0iUE
         Z2GGWA7UYlwdEtJM1loSMurDlIrB41SC7Twv/s0f53+9U18puW360yv4MlM/pGKo/cYO
         qixYXYlXL1GptBA5yFoj6EyKUSTxzD7sddyd4nj6v4AtdeJKp4T0HWXMfz0f4QNZAL2t
         I3V2pHnewC/1f2vU8kXmdV8sxaE6i6VXLUGDDj2w2XM3ALTaHqVCf16fIjgfo42nGyCy
         ozkpecpLW4fQS5ud7Za814hcPJPOF3GqmUL7wFKARdCCPUYdo0X90sjc6U1L8Ztv5ytd
         8sOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777838906; x=1778443706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JmpWw4FcmIl4qsyN9GknTKo7AHvNuJg0BptOENFVXtA=;
        b=mp+AbcIsI2MJT1wsn9n2w+3QTnEAEQv9CAHXD0XK0/pW/z4+7M/ow2Ck/NE+njoVvN
         TtkZvcodcU8YNFAhQmYcXvkWnb0GtwfysR9IZpqJqO9YvJWcdSRm7my1qUQ0A0ES9UKj
         nl3JUUo4h7nTh5Sb/1if7DNtvKrb+ewlOAEDx6YBWpnXzxQWzKDuWUmd9eOb4NFOr/Gg
         IQVUfYQcEJh/+dS3sSBDN7rbUIbB9CKqcypusyF3t0fVxobt8bzN7UOWLL0HS8vBbqNf
         VvvVPYkHxq/HYC1+J+qEu2D6M5pHnVtmxtkFUkmKsxOXM54+s9O7scLoZixBy7sA15QK
         4YfA==
X-Gm-Message-State: AOJu0Yyl+ih0302b+bmJ2A+Y5FgOD/SJV8vu6TQFmWwLJdKlVd6u5QGl
	sNQ+Ay6VwhIr55mZ99/lupit4UxRq5ziLhxqSQ+Cend0VFGMv7zZdE0WeRdX1LgeiXXpYUWoUjl
	0ZmKjjPAu3xJNejuu+BUG7+1pQV+N0hczitcJNIZ76QV1No1U3Y2RlFlVQ3TdyD1mbKIKmJCO6V
	1LAgFQCV9s69tb0vNTZjrqhqOU44uxAWucUs+fmCSoHaddzqVoHVVuoNQBGtQBw4q/Nltt+w==
X-Received: from eduf14.prod.google.com ([2002:a05:6402:4e:b0:67b:7d11:718d])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:d40b:0:b0:672:40fd:d7d2 with SMTP id 4fb4d7f45d1cf-67c1a2e4edemr2584951a12.11.1777838905928;
 Sun, 03 May 2026 13:08:25 -0700 (PDT)
Date: Sun,  3 May 2026 20:08:19 +0000
In-Reply-To: <20260503200819.1530328-1-mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503200819.1530328-1-mattbobrowski@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503200819.1530328-2-mattbobrowski@google.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: add new negative tests for xattr
 related BPF kfuncs
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a set of negative tests to verify the newly enforced constraints
applied to xattr related BPF kfuncs.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 13 ++++++++++++
 .../bpf/progs/test_set_remove_xattr.c         | 21 +++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
index 43a26ec69a8e..168ffcdccc4a 100644
--- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
@@ -128,6 +128,11 @@ static void test_set_remove_xattr(void)
 	if (!ASSERT_OK_PTR(skel, "test_set_remove_xattr__open_and_load"))
 		return;
 
+	/* Prepare the long name for negative test */
+	memset(skel->bss->long_name, 'a', 256);
+	memcpy(skel->bss->long_name, "security.bpf.", 13);
+	skel->bss->long_name[256] = '\0';
+
 	/* Set security.bpf.foo to "hello" */
 	err = setxattr(testfile, skel->rodata->xattr_foo, value_foo, strlen(value_foo) + 1, 0);
 	if (err && errno == EOPNOTSUPP) {
@@ -188,6 +193,14 @@ static void test_set_remove_xattr(void)
 	ASSERT_TRUE(skel->bss->locked_remove_security_selinux_fail,
 		    "locked_remove_security_selinux_fail");
 
+	ASSERT_EQ(skel->bss->ret_name_empty, -ERANGE, "ret_code_name_empty");
+	ASSERT_EQ(skel->bss->ret_name_too_long, -ERANGE,
+		  "ret_code_name_too_long");
+	ASSERT_EQ(skel->bss->ret_value_too_large, -E2BIG,
+		  "ret_code_value_too_large");
+	ASSERT_EQ(skel->bss->ret_invalid_flags, -EINVAL,
+		  "ret_code_invalid_flags");
+
 out:
 	close(fd);
 	test_set_remove_xattr__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/test_set_remove_xattr.c b/tools/testing/selftests/bpf/progs/test_set_remove_xattr.c
index 6a612cf168d3..7c857d665eae 100644
--- a/tools/testing/selftests/bpf/progs/test_set_remove_xattr.c
+++ b/tools/testing/selftests/bpf/progs/test_set_remove_xattr.c
@@ -17,6 +17,14 @@ static const char xattr_selinux[] = "security.selinux";
 char value_bar[] = "world";
 char read_value[32];
 
+const char xattr_negative[] = "security.bpf.negative";
+int ret_code_name_empty;
+int ret_code_name_too_long;
+int ret_code_value_too_large;
+int ret_code_invalid_flags;
+char long_name[257];
+char large_value[65537];
+
 bool set_security_bpf_bar_success;
 bool remove_security_bpf_bar_success;
 bool set_security_selinux_fail;
@@ -73,6 +81,19 @@ int BPF_PROG(test_inode_getxattr, struct dentry *dentry, char *name)
 			remove_security_selinux_fail = true;
 	}
 
+	bpf_dynptr_from_mem(read_value, sizeof(read_value), 0, &value_ptr);
+	ret_code_name_empty = bpf_get_dentry_xattr(dentry, "", &value_ptr);
+	ret_code_name_too_long =
+		bpf_get_dentry_xattr(dentry, long_name, &value_ptr);
+
+	bpf_dynptr_from_mem(large_value, sizeof(large_value), 0, &value_ptr);
+	ret_code_value_too_large =
+		bpf_set_dentry_xattr(dentry, xattr_negative, &value_ptr, 0);
+
+	bpf_dynptr_from_mem(value_bar, sizeof(value_bar), 0, &value_ptr);
+	ret_code_invalid_flags = bpf_set_dentry_xattr(dentry, xattr_negative,
+						      &value_ptr, 0xFFFF);
+
 	return 0;
 }
 
-- 
2.54.0.545.g6539524ca2-goog

