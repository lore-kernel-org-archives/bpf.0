Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525BC346E50
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781850930; cv=none; b=VXvzEz4qL2jcQhRt6sOVL0h0pgWXnJWS5CQG37c+VJaeCr4dsWvj8Z7265Ys2NeLvXWvyccVPHEnHWK6vfjhq/H7TQOWbZr/BDETKmaeROh7VKKmW+rxUbjWJ8sqedS7gcjmafVwvp4V0pl5bw8MELk5ovqHYPRsX0k8iruqPCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781850930; c=relaxed/simple;
	bh=hk9DdqhfwheJu/mYJkcTkLeSGtlSNrFOdTvBRuYkBFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMO3khu7ibiM4zc9x7FORiDaOUacmPXzq4MAVuROp+413jXw/UEh88JQpUYpQ7GvnwPqhW/nV2moJwQGCJ4kvMFnN3s2I3JCRWqQYqNEPlifbbqeYyPsEOTaFqzCHpRvGfq/UD1mtzcd4SS5NmpjmkMHXuJ28xOiA+BzHCnwsPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qkxqO4Zw; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkxqO4Zw"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6a0a38a013eso1538977eaf.0
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 23:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781850928; x=1782455728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Us+DduHyKbwQNzBW1kJHsZjXnClMSjCwfH6t54+9lEs=;
        b=qkxqO4ZwNySrScQtl3FPmWNQr0zAiJRRHrobWXE4Or2zyb4rPVi/uqqaX8FL+1e/P4
         B3xZQhB8Y0lIeQtEjdITdYqrwf3dllmp0QAkTZHzk8XWHHH83yXYLom1Gjz7IGcw5MU0
         91odacbqOcfPBtlsbSVsb22kAmhJgI8kOD0BhB0ICBMpXwDLBiidvyBaUSvBF6s4DTYL
         l3KkdNGQuBDcHzAOCX40wt5udFx9hAvVjUtrQ5j6ypDQ2aogda184HljaRqwbz2iEeFX
         47jfgI4qjfIEtCQhD/8LLftz3MOeMEsrhZ/fPo2Sftxbrao8Q6FjhI9hi/FjQg8ZEzM0
         QZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781850928; x=1782455728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Us+DduHyKbwQNzBW1kJHsZjXnClMSjCwfH6t54+9lEs=;
        b=oJFZcpwYeG9lYDG/rDm9VboC/W7BI/mYwURooE9TiRETa1svsrT9T5z7ksLT8qXz2u
         L/bgWQky219d5pR8I95hg5GlWjAnW36CDo+Y6u8emmNR09vaGebq5AZ9u9GVkB97BR7Y
         3epAz3IvcwoQPSWcW5AvU+wVc09wDUb9uECLZgdkfA/in2ZxSGp88ZXwUJB8oh/iqK4i
         ACa3IUuQex08Zf0ozkP736ABKv/EVnJv3y5yUPsac5dJkL5giWUrGM2tXamfpTkm9iH8
         7vyCXXu44ljPxTcbzbknHtkhBgVwQhpHvwUEs7cfkTqI09Gb9ab5il8I1UWIwJfLD9cT
         7afA==
X-Gm-Message-State: AOJu0YyU2P1TulK7rdiAgHgmAyvAEHLIoiKysh2mwLqIQUfz0FE4GLJ6
	55TElXX+ciAHwp2oEtjRyR26PyiAeAcujeaepTZNCbUOl/xJ5vh2bv4iDvv5WQ==
X-Gm-Gg: AfdE7cmKIBgTRvfXP+1MAjkoIMUkJN/MsCa3RWBONjdAvOsEsGf9F3X+E/e0Hvf5Piy
	0c2JqekdDVDwHdo2TCYq204X8OLJG6q9PqCrtsAEOP4oORb8GqonwKgYfSrX556HxXEuF/pU7Ss
	shqkho5Ut0a3EciOUS2OtVzpKayiHwXBnqnMSLwbprtu1m/cKpPC5q6S9Bik9V+8c1971Y/sUX6
	JQVw8Fdft/xWgOkMmxUAy+KIcLGOT0b5+3e6vgdakt/vblFTEmxSiiZiiMntyA7feMR2MZAf0XY
	I+PxDcFtuPn+R9NX3QFJeIuivx56oVVfPwnKMc7IzkyHM7ws9vgv8e5DXupw3tDxDM0XjfV4Hx/
	A4eWPmH9EI4G5aPA0G9hPPdLIh3Ka1bOoy/inbH/lQ0aa4VCz/+sOy+afdyf3l5+dL9sQOxNajo
	zakJhB7hhAuNaFJQ==
X-Received: by 2002:a05:6820:4c84:b0:69e:88f3:14ac with SMTP id 006d021491bc7-6a0da0254e9mr1440053eaf.18.1781850927866;
        Thu, 18 Jun 2026 23:35:27 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:59::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44709c76d2csm1533775fac.3.2026.06.18.23.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 23:35:27 -0700 (PDT)
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
Subject: [PATCH bpf v2 2/2] selftests/bpf: Test cgroup link replace with BPF_F_PREORDER
Date: Thu, 18 Jun 2026 23:35:20 -0700
Message-ID: <20260619063520.2690547-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619063520.2690547-1-ameryhung@gmail.com>
References: <20260619063520.2690547-1-ameryhung@gmail.com>
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
 .../bpf/prog_tests/cgroup_preorder.c          | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_preorder.c b/tools/testing/selftests/bpf/prog_tests/cgroup_preorder.c
index d4d583872fa2..d2ccf409dfe3 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_preorder.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_preorder.c
@@ -102,6 +102,82 @@ static int run_getsockopt_test(int cg_parent, int cg_child, int sock_fd, bool al
 	return err;
 }
 
+/*
+ * Replacing a link's program (bpf_link_update) must target the correct slot in
+ * the effective array even when a BPF_F_PREORDER program is attached to the
+ * same cgroup. All programs here are attached to a single cgroup; "parent" is
+ * reused only as a third distinct program.
+ *
+ * Attach child(1) normally and child_2(2) with BPF_F_PREORDER, so the effective
+ * order is [2, 1]. Then replace child(1)'s program with parent(3): only the
+ * non-preorder slot changes, giving [2, 3].
+ */
+static int run_link_replace_test(int cgroup_fd, int sock_fd)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, create_opts);
+	int err = 0, normal_link = -1, preorder_link = -1;
+	struct cgroup_preorder *skel = NULL;
+	enum bpf_attach_type atype;
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
+	if (!ASSERT_GE(normal_link, 0, "create_normal_link")) {
+		err = normal_link;
+		goto close_skel;
+	}
+
+	create_opts.flags = BPF_F_PREORDER;
+	preorder_link = bpf_link_create(bpf_program__fd(skel->progs.child_2),
+					cgroup_fd, atype, &create_opts);
+	if (!ASSERT_GE(preorder_link, 0, "create_preorder_link")) {
+		err = preorder_link;
+		goto close_links;
+	}
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
@@ -120,6 +196,7 @@ void test_cgroup_preorder(void)
 
 	ASSERT_OK(run_getsockopt_test(cg_parent, cg_child, sock_fd, false), "getsockopt_test_1");
 	ASSERT_OK(run_getsockopt_test(cg_parent, cg_child, sock_fd, true), "getsockopt_test_2");
+	ASSERT_OK(run_link_replace_test(cg_child, sock_fd), "link_replace_test");
 
 out:
 	close(sock_fd);
-- 
2.53.0-Meta

