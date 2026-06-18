Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CB234250E
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781821166; cv=none; b=p7vlM3Mc4EqflOHbErFL37WHdAT8wsEPtY9opuRUPR7ZBbuiVcrk3fVSGUlda72VOyK5YII+8j7oSl1hqUCRaLrqz5bODcFs5DHNolRhnkpdVZCXPWjz+aIeTfyF/EOfmbkvqAkLucecyDrl6fOT867OZ/aGoWeCJRGI1aWJcs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781821166; c=relaxed/simple;
	bh=FmzOmhZBxNjxFSFbjZwVmAGfRwyaC2Dmhdc3b3Hqya8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQCav9ghFfDvLAJ1qNMt8XI+IwIXVFVA+WAMcn/hcOeU5MceB73okp6h5qXKJlaQhSmpeAA8vdcuyiPQFk/ppD1ROSi/J057PMXFrUWpxeKKkC9FOTRz1z+EnMm7Zcprkhdn3GiaowKrcc7gJcHSdgvduA5EjuIkI7Q77S93fTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvShXn5H; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvShXn5H"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6a0ddedcd00so11181eaf.1
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 15:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781821163; x=1782425963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wg3WXONidIuuP5JwY/U89JL0hLt2XYgWDvf5ly51wkg=;
        b=bvShXn5HCVmrUtF2z97N5Qup1ruzYb0ZpEIvSdvLQzPNLEPAPIXtId/aKgIUJZtQLN
         a/qsgSCeCOKTFJQmaRcIxymOZkozvzeph96s53D78cTsFDoIIxytIYQrNHBPUsBGJkzP
         cbGLOsGVogdIm0GLVWpB65xIHsk/YRwSpUOHebO7eE7eeC/j/8FfEO3lSuLHN0XLsXF2
         H90+EaNpOQQYtqRl0RgnbllcSqf3OqJ7lo8NT4DvpCQvKSXiUNd7JW8mzE/dXLulEXBE
         RijxbDgzqB0Gx+mW/gMKnr92g+XXL0o3M18ni4zyLNlktpNcTiiXC4biCyXrNCWrPnZE
         dUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781821163; x=1782425963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wg3WXONidIuuP5JwY/U89JL0hLt2XYgWDvf5ly51wkg=;
        b=i+6EJfdCkFzlv4LD3DL1eOBkgMMnpYNkPcRwogBT/WOkLroFxcXCn0aNkyY7pXSMjs
         FJ1J7PhIMDKIe98nN506t6S/XAS0jJmKYOD95cyJLX//7mI9SzKSOov1D2RSBhYVCdBU
         Dyzj4/7Cd1GTRLyPP7/YYUDqxtyuuwhI2RzISvu453tQr6LG2laalFDMeuYaXy2KvqXu
         rsdBQ0U1BesTvh8MKsUd5Co2erWYezxYnujkrBald1itil3wxdluode++A9nN1RFSzpH
         VIS/dxcYrLFUYchn1Jmjui3I4gTZjAJgK2oAljqiokuwkgcAoyX8M/qdVUkS1kF7fRjL
         K+6w==
X-Gm-Message-State: AOJu0Yyt71EIY+gv5AzQhUTqhHnO1FjEm9GsSb5GquJvOHAu74GRXTQQ
	LmjTOdGYg/UYKmlGHFSEvdKI808E0LoUs42xj3qMk81WiOkACukWv1lwo/qk+g==
X-Gm-Gg: AfdE7clfzX4d9iGoRn1ADVqnJd7tUjxGK+/zhEcBDysIkWZ9lftvx5MRZxoWB/2avWk
	10/xv3+iwSO5q38U913RIET1SLO+H4ZWZgYKCDF/riZmvUAVi1EDM3+XyfQtGmtu7BPwMjm2xJY
	1qhbOLyuUluUDAkhHYaKeswQOcWP1mdux3LS0J+1KJgttoPr/tyNA32bEBb+4bQOcGn9onz2VPa
	lPmR7LPlO6GVI5izJQ4AJ+ECAGyqP7FWzKeCwyHr9a6I6gg5GChqLLIkI3OLPzvdP291oNERNBy
	Yr8medxW9WWYYM1ep3F0RarUr44mP+NaXeEpn0rgMbZafMI/drMMteHSYa1ZnN5oYkxPV+5PTJE
	7LjBVW5qj/FIoRUFp70Fqp8QEoaAPhHYDQ+q4lf1bPSJqVna+hmbYW7JaNmS4iqSmtv3e6cEFis
	fSRB0=
X-Received: by 2002:a05:6820:3084:b0:69e:89a1:ee0f with SMTP id 006d021491bc7-6a0d89350f8mr1186479eaf.33.1781821163523;
        Thu, 18 Jun 2026 15:19:23 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0d8d471b5sm555523eaf.8.2026.06.18.15.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 15:19:23 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 2/2] selftests/bpf: Test cgroup link replace with BPF_F_PREORDER
Date: Thu, 18 Jun 2026 15:19:19 -0700
Message-ID: <20260618221919.2919512-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618221919.2919512-1-ameryhung@gmail.com>
References: <20260618221919.2919512-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a cgroup_preorder case that attaches a normal and a BPF_F_PREORDER
program to a cgroup (effective order [2, 1]), then replaces the normal
link's program via bpf_link_update() and checks the effective order
becomes [2, 3] — i.e. only the non-preorder slot changes. Without the
replace_effective_prog() fix the array is corrupted and the order is
wrong.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/cgroup_preorder.c          | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_preorder.c b/tools/testing/selftests/bpf/prog_tests/cgroup_preorder.c
index d4d583872fa2..80a17203c4fd 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_preorder.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_preorder.c
@@ -102,6 +102,75 @@ static int run_getsockopt_test(int cg_parent, int cg_child, int sock_fd, bool al
 	return err;
 }
 
+/*
+ * Replacing a link's program (bpf_link_update) must target the correct slot in
+ * the effective array even when a BPF_F_PREORDER program is attached to the
+ * same cgroup. Attach child(1) normally and child_2(2) with BPF_F_PREORDER, so
+ * the effective order is [2, 1]. Then replace child(1)'s program with
+ * parent(3): only the non-preorder slot changes, giving [2, 3].
+ */
+static int run_link_replace_test(int cgroup_fd, int sock_fd)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, create_opts);
+	struct cgroup_preorder *skel = NULL;
+	int normal_link = -1, preorder_link = -1;
+	int atype, err = 0;
+	__u8 *result, buf = 0x00;
+	socklen_t optlen = 1;
+
+	skel = cgroup_preorder__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "cgroup_preorder__open_and_load"))
+		return -1;
+
+	err = setsockopt(sock_fd, SOL_IP, IP_TOS, &buf, 1);
+	if (!ASSERT_OK(err, "setsockopt"))
+		goto close_skel;
+
+	atype = bpf_program__expected_attach_type(skel->progs.child);
+
+	create_opts.flags = 0;
+	normal_link = bpf_link_create(bpf_program__fd(skel->progs.child),
+				      cgroup_fd, atype, &create_opts);
+	if (!ASSERT_GE(normal_link, 0, "create_normal_link"))
+		goto close_skel;
+
+	create_opts.flags = BPF_F_PREORDER;
+	preorder_link = bpf_link_create(bpf_program__fd(skel->progs.child_2),
+					cgroup_fd, atype, &create_opts);
+	if (!ASSERT_GE(preorder_link, 0, "create_preorder_link"))
+		goto close_links;
+
+	result = skel->bss->result;
+	skel->bss->idx = 0;
+	memset(result, 0, 4);
+
+	err = getsockopt(sock_fd, SOL_IP, IP_TOS, &buf, &optlen);
+	if (!ASSERT_OK(err, "getsockopt-before"))
+		goto close_links;
+	ASSERT_TRUE(result[0] == 2 && result[1] == 1, "order before update");
+
+	/* Replace the normal link's program child(1) -> parent(3). */
+	err = bpf_link_update(normal_link, bpf_program__fd(skel->progs.parent), NULL);
+	if (!ASSERT_OK(err, "bpf_link_update"))
+		goto close_links;
+
+	skel->bss->idx = 0;
+	memset(result, 0, 4);
+
+	err = getsockopt(sock_fd, SOL_IP, IP_TOS, &buf, &optlen);
+	if (!ASSERT_OK(err, "getsockopt-after"))
+		goto close_links;
+	ASSERT_TRUE(result[0] == 2 && result[1] == 3, "order after update");
+
+close_links:
+	if (preorder_link >= 0)
+		close(preorder_link);
+	close(normal_link);
+close_skel:
+	cgroup_preorder__destroy(skel);
+	return err;
+}
+
 void test_cgroup_preorder(void)
 {
 	int cg_parent = -1, cg_child = -1, sock_fd = -1;
@@ -120,6 +189,7 @@ void test_cgroup_preorder(void)
 
 	ASSERT_OK(run_getsockopt_test(cg_parent, cg_child, sock_fd, false), "getsockopt_test_1");
 	ASSERT_OK(run_getsockopt_test(cg_parent, cg_child, sock_fd, true), "getsockopt_test_2");
+	ASSERT_OK(run_link_replace_test(cg_child, sock_fd), "link_replace_test");
 
 out:
 	close(sock_fd);
-- 
2.53.0-Meta

