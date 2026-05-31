Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F5125B0AC
	for <bpf@vger.kernel.org>; Sun, 31 May 2026 00:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780188512; cv=none; b=diGRf9KSbPop5TvH8alxO1AAgkiPTyMQFPMXjbtCkIvjXxvlcn9UrKG5CAN5A2/0bbM8KGNNLX7DdK+8mGs5uhrQ9CYufctoMUa/YI57198//f7pyBD1xxA4JVH8bJmRjraH1XCP5/ebFI1z4ajeZVOcN/ZCSekPHiK0QIFfwrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780188512; c=relaxed/simple;
	bh=nf7H52BiE00pfcsnE0so3Yy+4Kqlaf5sOzNGyBYj+pk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UFNWyNhW8TnfigBr/j7IfV8x5p/4n/n7Uu1xPBkZyXLoLthBcQB6wrKMBj/FFXd0oZiCeJrntueKPkeor6CMDjItgA03w420Gq+jyIS1V+Soexln3ArNY8sIRddXxscuFZ0HMyjd+qxYfyb9oc0ugJX/KXMPzEQUxYBt0HZk22E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RuUCsCgj; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RuUCsCgj"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8422875c676so597096b3a.0
        for <bpf@vger.kernel.org>; Sat, 30 May 2026 17:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780188510; x=1780793310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZwO/OlrIC4X5IlWqO2MUG4z3bwcShqiYLdiaVgWhfIU=;
        b=RuUCsCgjZI2MaJzgYolIOa2oKIy5birycm8UCXcV80iIx1DNiW3T4ZRV5ogAefFMhx
         tNOd/qgTap9viC0WTBoVZtT8tGYX2Wz1q5aFL+biDB4qEWbROi4vOUX8a9XU02P6nNhU
         SV1NKP5UeP1Pv9OpIPm5eekS+2R2rPVGjvEakB1h5zACwUI0V49AhhyGyosi7EAoO+Br
         mGjMvuQaQPmVo71z+okS8qMBv/+f0ePBNYmhlgooM2MibG4Jp0uPpiJ3nemDfytIo6hc
         3TAQCZjghjp4pNhdv9aCCz19ykrh2Tf2kzRdP7mgIvIZqtgWyZDRTGnH6X4mENhymD2O
         ZE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780188510; x=1780793310;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZwO/OlrIC4X5IlWqO2MUG4z3bwcShqiYLdiaVgWhfIU=;
        b=HsrCOEsFg57ORyyTmZxltOfAGIyqd5MEOFFkkt3806qRw+lt1hCfTzJOokW0ao/sYY
         Pg6lEiARrHAZJmdfPGLGD2x8M0j5IFEN3he8WQ/tKrlYoND+I71O3keinOsWjSsbJR/4
         wa0+fK0lNcMbYANEW/tU/NwgusZomkmoVMN0p+TZNsrbGTZJID+03Y6HQ/SsLy/ERhrn
         n3gnHuIsOHA8GHM2REO5gxUxdagOvwDQtJBGUx4IiaQIMMmq2CxrJ6gS4MHqBlv5t9/M
         MyS4w2bL3ffx7w55WEKcbIirR+ILWsNZTZo1UKJmoCenPRd3mErW35OOLdz2RTl9e+DG
         QQsg==
X-Forwarded-Encrypted: i=1; AFNElJ+Jt489x/ydsNcpfnQn4hlFNbWSVh5V9m2b3NgDhBDezDYVKuU4DfaAnI0TVWd0uzk/p4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza2WzRFGZ+KZ+m+5H40CGfXZQLAWQrsI4eJI9vJfyi5FAixQH2
	hAzWmxfP2p0hGxvC8Pa1KJw6XXbu2RbfQfnGFEB+TYHEEC5Vq3gNKWFwghTsHsFrEOB1qa1oBf+
	OeKXl1E0HIyhqHa1/XISjxGLUBA==
X-Received: from pfbgr7.prod.google.com ([2002:a05:6a00:4d07:b0:83f:2ce7:48ce])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3988:b0:835:3861:812c with SMTP id d2e1a72fcca58-84210c545c2mr7093486b3a.23.1780188509512;
 Sat, 30 May 2026 17:48:29 -0700 (PDT)
Date: Sun, 31 May 2026 08:47:48 +0800
In-Reply-To: <20260531004748.3567875-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531004748.3567875-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531004748.3567875-3-yuyanghuang@google.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: add verification for
 BPF_PROG_QUERY attr size boundaries
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add a new selftest to verify that the BPF syscall (specifically
BPF_PROG_QUERY) correctly rejects queries with a user-declared size below
the mandatory minimum (which now covers query.revision) with -EFAULT, and
succeeds when given the full size.

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
 .../selftests/bpf/prog_tests/bpf_attr_size.c  | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c b/tools=
/testing/selftests/bpf/prog_tests/bpf_attr_size.c
new file mode 100644
index 000000000000..4fbe56cb29d4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Google LLC */
+#include <linux/bpf.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <test_progs.h>
+#include <cgroup_helpers.h>
+#include "cgroup_skb_direct_packet_access.skel.h"
+
+#define OLD_QUERY_SIZE		offsetofend(union bpf_attr, query.prog_cnt)
+#define FULL_QUERY_SIZE		offsetofend(union bpf_attr, query.revision)
+
+static void test_query_size_boundaries(void)
+{
+	struct cgroup_skb_direct_packet_access *skel;
+	struct bpf_link *link =3D NULL;
+	union bpf_attr attr;
+	int cg_fd =3D -1;
+	int err;
+
+	skel =3D cgroup_skb_direct_packet_access__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		return;
+
+	cg_fd =3D test__join_cgroup("/attr_size_cg");
+	if (!ASSERT_GE(cg_fd, 0, "join_cgroup"))
+		goto cleanup;
+
+	link =3D bpf_program__attach_cgroup(skel->progs.direct_packet_access,
+					  cg_fd);
+	if (!ASSERT_OK_PTR(link, "cg_attach"))
+		goto cleanup;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.query.target_fd =3D cg_fd;
+	attr.query.attach_type =3D BPF_CGROUP_INET_INGRESS;
+
+	err =3D syscall(__NR_bpf, BPF_PROG_QUERY, &attr, OLD_QUERY_SIZE);
+	ASSERT_EQ(err, -1, "query_old_size_fails");
+	ASSERT_EQ(errno, EFAULT, "query_old_size_efault");
+
+	memset(&attr, 0, sizeof(attr));
+	attr.query.target_fd =3D cg_fd;
+	attr.query.attach_type =3D BPF_CGROUP_INET_INGRESS;
+
+	err =3D syscall(__NR_bpf, BPF_PROG_QUERY, &attr, FULL_QUERY_SIZE);
+	if (!ASSERT_OK(err, "query_full_size"))
+		goto cleanup;
+
+	ASSERT_EQ(attr.query.prog_cnt, 1, "prog_cnt_written");
+	ASSERT_GT(attr.query.revision, 0, "revision_written");
+
+cleanup:
+	if (link)
+		bpf_link__destroy(link);
+	if (cg_fd >=3D 0)
+		close(cg_fd);
+	cgroup_skb_direct_packet_access__destroy(skel);
+}
+
+void test_bpf_attr_size(void)
+{
+	if (test__start_subtest("query_size_boundaries"))
+		test_query_size_boundaries();
+}
--=20
2.54.0.823.g6e5bcc1fc9-goog

