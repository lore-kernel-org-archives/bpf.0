Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B50934028B
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214421; cv=none; b=UFA2jUHuTV/HFXKYSSn4lvB5V1NPNKBw4wtfPR8lpx9oyx7d9UyBKFv6W1Kr24SXAiYES4db0TmB7gQnpwg/2HbF9pUNEXijq/+ANnMFqK0n3HEY7uzsiln32ZSFJ6R2k7f/7MdDyaz0d5EqHF22a65CrUIK8f050GUNn62/j/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214421; c=relaxed/simple;
	bh=QdNRFe0vIqkka4xbbVpTimo0ga8a86tcP8wKsinRgWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlk+27P/mDnYmQxcgmQIVwIJRsVd3Zf+wPYxF34BKN5n1yusYRwb6fgOISV5OKKSeHZCd8qyjjE/rAwtsln9BI2YrBkb6h8TXqlQXB5o2M0ph0PRnDKHqq5yx8HcpjkzNmPHxpJ9TkELL0n4qYYq4d7MFX4USaeJCTIo5FUWIXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKmJex/8; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKmJex/8"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7cd35604a95so28586617b3.1
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 11:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214417; x=1779819217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlP5n46PN41L6jV72akk3EQSHatEAlv9HooAnPxWzak=;
        b=EKmJex/8i1GBWWvXOPSm2HahWM4x41pa1zK9bkzrWaYgwpe43+lU65MutAupvqS+JK
         pbaSUgzx+p6jc1319wcqlZMbsgZC9FNvPua1z2jnWGrOi08r38aVswVTOcGezw+hBf9S
         IviGlJf7VUU3giDGdG4uyN7qkLau2DqFCzbOe9xbwwVIQKSSFaa1GieKQSH/2t/qaOmI
         R7uugDAjMXX7uBXdzw+dAAlZFZAMA2y6MPGaQ+kYwHEyrQTFpORVleOjFrGqiCilqxDo
         RSOHkhYw/C3Yw1a6nqr+E/a9t8z26GmkIGij1I+TNA4cCnoMh2dmlggvHhULZptG7G7e
         g7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214417; x=1779819217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PlP5n46PN41L6jV72akk3EQSHatEAlv9HooAnPxWzak=;
        b=R+ZmsVefn6W3MiXCfmZgTApz/OLoYE1OARZxV3gidrjt9HMGYfqbkIhQH2KYRz3SLa
         /rZK1BE/ggYfUgbB7AZaoG9N9I99V3mt+V9S888W9kzVb1Q62KPGQUPF98Nipto6J/iU
         uYWuy4T9RBKFuxnnwWFTyw65jzVnZ3kPJZPFONfH/dEEec1Ky+sOXDyrhd0fEH0gEdeX
         aAQjyKQGNZfUxpzJD0q9r1QF85dCiHBo1GITwDnvuXBbJDHnoGVfqc25q3RQVh7zCxqx
         8OzvlWZPxPbs34XLq69W3cj/ig0+hrZi7olzaPDjD4Db6InVwtPN+Gp/CE0rdrZMkGUD
         ln6A==
X-Gm-Message-State: AOJu0Yyj1d4bKelKeWIsK4thkJJCMm7xnVsCWJcNN5+iFy2T68q3kgYa
	TUVyAH6iXmOXO2P7d0HoZ0F7JlaJi70Q0Ylz4BzUR1gZ0qTWV/6wzwhHa0C5AHJO
X-Gm-Gg: Acq92OEK4HF9X30vfDQpLQruUz+QyUJi3+p/6x/AxZSJab9uVmuE7bIzrV/QtBVr+6q
	6BQotHyUg+5Q/5fsnJ74RVHmMnhr6TL7Og2DaZf0JkDmKRs9aPDKTcWfAQzIxNbi3aU9gLRvBtP
	LX3ySMBwdpmPUCDUTv2lbSE4ikIHF6XMmMrAj9yJKGiTL2bqL5l/eQ3sDMrsIevvdI+QZqSiqxW
	XOHwr9AsS/aSrNjGIlC/pckLEpPqLxqzC/+RFjcw4YbASTwFkaucEnxCcvVqq1SpZdix4pVzsCf
	e/471+mNOO66SpmzQSixhB+5UXU6AUp7LAkcn0XvHnCzxUWKZGevwEX+I3HdsJFkXqmHPJHA5f6
	Dbc1A9AsK6OdQGsuxUEmq6ICpcKpeIrpFLkcLUP4tb/hB/tElWObs7bz9T3MFFzTCLv89YIocgG
	FleBu2uONAdeZsvBusW5YPExDRhBvWMkGNow==
X-Received: by 2002:a05:690c:c4e8:b0:7bf:1433:8f92 with SMTP id 00721157ae682-7c7e5d9034amr210208817b3.7.1779214417481;
        Tue, 19 May 2026 11:13:37 -0700 (PDT)
Received: from localhost ([2a03:2880:f806::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9c6ce2f4sm40449947b3.39.2026.05.19.11.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:13:37 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 14/14] selftests/bpf: Test using file dynptr after the reference on file is dropped
Date: Tue, 19 May 2026 11:13:12 -0700
Message-ID: <20260519181314.2731658-15-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519181314.2731658-1-ameryhung@gmail.com>
References: <20260519181314.2731658-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

File dynptr and slice should be invalidated when the parent file's
reference is dropped in the program. Without the verifier tracking
dyntpr's parent referenced object, the dynptr would continute to be
incorrectly used even if the underlying file is being tear down or gone.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/progs/file_reader_fail.c    | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
index 0739620dea8a..d5fae5e4cf9a 100644
--- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
+++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
@@ -50,3 +50,63 @@ int xdp_no_dynptr_type(struct xdp_md *xdp)
 	bpf_dynptr_file_discard(&dynptr);
 	return 0;
 }
+
+SEC("lsm/file_open")
+__failure
+__msg("Leaking reference id={{[0-9]+}} alloc_insn={{[0-9]+}}. Release it first.")
+int use_file_dynptr_after_put_file(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct file *file = bpf_get_task_exe_file(task);
+	struct bpf_dynptr dynptr;
+	char buf[64];
+
+	if (!file)
+		return 0;
+
+	if (bpf_dynptr_from_file(file, 0, &dynptr))
+		goto out;
+
+	/* this should fail - file dynptr should be discarded first to prevent resource leak */
+	bpf_put_file(file);
+
+	bpf_dynptr_read(buf, sizeof(buf), &dynptr, 0, 0);
+	return 0;
+
+out:
+	bpf_dynptr_file_discard(&dynptr);
+	bpf_put_file(file);
+	return 0;
+}
+
+SEC("lsm/file_open")
+__failure
+__msg("Leaking reference id={{[0-9]+}} alloc_insn={{[0-9]+}}. Release it first.")
+int use_file_dynptr_slice_after_put_file(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct file *file = bpf_get_task_exe_file(task);
+	struct bpf_dynptr dynptr;
+	char *data;
+
+	if (!file)
+		return 0;
+
+	if (bpf_dynptr_from_file(file, 0, &dynptr))
+		goto out;
+
+	data = bpf_dynptr_data(&dynptr, 0, 1);
+	if (!data)
+		goto out;
+
+	/* this should fail - file dynptr should be discarded first to prevent resource leak */
+	bpf_put_file(file);
+
+	*data = 'x';
+	return 0;
+
+out:
+	bpf_dynptr_file_discard(&dynptr);
+	bpf_put_file(file);
+	return 0;
+}
-- 
2.53.0-Meta

