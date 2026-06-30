Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961DC34389D
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782852862; cv=none; b=qhTPYP+8ckbxXJZPVnR5TnD71Ml7swvui2q0VML7mlBlvpKdV1UIcRe4tMlD9SA+D551k9GR2q+uqrUg4FKBK2aFt/eMO7BnFM5E9rdQhRmlc6BEgtB6Ija1Fc2A9Pyq/8lYXPeQvnzuagVGoasLCWxvojyW8mzmNKpP669+CXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782852862; c=relaxed/simple;
	bh=Dbq2Zl6BxjvSW4bP+ZPdlTsjFl4zmom5dMDBaXksXBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MsgcmaaQ4paCQ3Xctlikd8P2Tpa3k/C179tgp6SKac8gdWia5aYkRVHXJvE2wlZQ/s+J+W/dH0k/aav1lUuDrfM+Is9fn8wmqDjeE/ZenD6VXsf2F5S9exovUXLABRgjkzVmDr3qwBibT8regeIzXfnELJRkjFUpFL8d69xNEww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmNRWdPg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmNRWdPg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F3D1F000E9;
	Tue, 30 Jun 2026 20:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782852861;
	bh=cy0OLjPelcDruDvKD5ClLeq7GZ1aQdaVB7tq+lpfGNM=;
	h=From:To:Cc:Subject:Date;
	b=OmNRWdPgqHvW2PRSemyWIXn4iNR18P7kF7FPHGcZ7CSgGVgd8QU8p20I4czgu4Tjt
	 qCVG7LC13ScC+zzD0x5mnEmG0te85bTqMjkGhct6sITzgx/CMs2dZhTXaHACV24T/9
	 eEUWBpc/iP2Tj3D+a7sT17myhXo00M0tQKFhj0qVx2/I8akUT0HS7o6iaGmJq/C6Qo
	 COaHNI/zTaGqkn5cBX4LqSqRmbL87AKQmApqe7DYxde2lKCHtQDz3uOEt2yviYV/sf
	 yedH9tymMraTU8eTJAynw7cMJOeRRPsqOK0BeQXCR4REDU0S4VJXoPsCfof154lLPr
	 9Y0Qm+h5RIlBA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	qmo@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpftool: Strip all -Wformat* flags from bootstrap libbpf build
Date: Tue, 30 Jun 2026 13:54:18 -0700
Message-ID: <20260630205418.3483969-1-andrii@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9080b97689db ("bpftool: Pass host flags to bootstrap libbpf")
started building the bootstrap libbpf with HOST_CFLAGS, stripping the
warning options that are unsuitable for that build by filtering out
-W -Wall -Wextra -Wformat -Wformat-signedness.

HOST_CFLAGS inherits EXTRA_WARNINGS, which includes -Wformat-security
and -Wformat-y2k. The filter drops -Wall and -Wformat (the latter being
what actually enables -Wformat), but leaves those two -Wformat-* children
in LIBBPF_BOOTSTRAP_CFLAGS. Building the bootstrap libbpf with it then
warns:

  cc1: warning: '-Wformat-y2k' ignored without '-Wformat'
  cc1: warning: '-Wformat-security' ignored without '-Wformat'

The warning is easy to miss in an in-tree build: tools/lib/bpf/Makefile
re-adds -Wall via "override CFLAGS += -Wall", which re-enables -Wformat
for the libbpf objects, so only libbpf's feature-detection probe (which
uses the passed CFLAGS verbatim) leaks the two warnings. The standalone
libbpf Makefile (github.com/libbpf/libbpf, used by the bpftool mirror)
instead uses "CFLAGS ?= ... -Wall", which the passed-in CFLAGS overrides,
so -Wall is never re-added and every bootstrap object warns.

Use a -Wformat% wildcard in the filter-out so the orphaned children are
removed together with the parent.

Fixes: 9080b97689db ("bpftool: Pass host flags to bootstrap libbpf")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 271a7dc77273..b0f7168e7943 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -99,7 +99,7 @@ endif
 HOST_LDFLAGS := $(LDFLAGS)
 
 # Remove warnings for libbpf bootstrap build
-LIBBPF_BOOTSTRAP_CFLAGS := $(filter-out -W -Wall -Wextra -Wformat -Wformat-signedness,$(HOST_CFLAGS))
+LIBBPF_BOOTSTRAP_CFLAGS := $(filter-out -W -Wall -Wextra -Wformat%,$(HOST_CFLAGS))
 
 INSTALL ?= install
 RM ?= rm -f
-- 
2.53.0-Meta

