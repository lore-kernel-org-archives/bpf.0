Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376143233
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 02:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712199210; cv=none; b=nn82fX7oS+rELwdQ+ZDHmMJdryRNl1yf8uCYQw+DU1y2WbBkPOGTjOJzUEDPRKWXkCSHZq9PrRTlId7lzUqX9P/6yBTYaY8CGXfXZLexU6gAjqbOc2vRiYoetbmV0de4jUB/JiqidNwHZIr/nSG1GRzr6BKCjzFjycVO/JJxD1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712199210; c=relaxed/simple;
	bh=Vt/5OHAvvtqqXf0Mbp2y/FGwyc7dcDz5fJOWmq6CVJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCmXRcr8B2I9Fox1CJMv5503/MULlLWwrlTLCFwXbLx4NdmL6yzSvwuP6xl4aWAvD2l5x3D+vpR/2CSLs7v//EO7rjNuZQhB3J7q74jNHz6KNjfi99m6jE62fVtAphU3o/tMX/S+Yg7Hes2pFAgFv3Wg2GPwzov7/IHofmYBv58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 0825829CEB19; Wed,  3 Apr 2024 19:53:16 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 2/5] libbpf: Add bpf_link support for BPF_PROG_TYPE_SOCKMAP
Date: Wed,  3 Apr 2024 19:53:16 -0700
Message-ID: <20240404025316.2212069-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404025305.2210999-1-yonghong.song@linux.dev>
References: <20240404025305.2210999-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Introduce a libbpf API function bpf_program__attach_sockmap()
which allow user to get a bpf_link for their corresponding programs.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/libbpf.c         | 7 +++++++
 tools/lib/bpf/libbpf.h         | 2 ++
 tools/lib/bpf/libbpf.map       | 6 ++++++
 tools/lib/bpf/libbpf_version.h | 2 +-
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b091154bc5b5..97eb6e5dd7c8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -149,6 +149,7 @@ static const char * const link_type_name[] =3D {
 	[BPF_LINK_TYPE_TCX]			=3D "tcx",
 	[BPF_LINK_TYPE_UPROBE_MULTI]		=3D "uprobe_multi",
 	[BPF_LINK_TYPE_NETKIT]			=3D "netkit",
+	[BPF_LINK_TYPE_SOCKMAP]			=3D "sockmap",
 };
=20
 static const char * const map_type_name[] =3D {
@@ -12533,6 +12534,12 @@ bpf_program__attach_netns(const struct bpf_progr=
am *prog, int netns_fd)
 	return bpf_program_attach_fd(prog, netns_fd, "netns", NULL);
 }
=20
+struct bpf_link *
+bpf_program__attach_sockmap(const struct bpf_program *prog, int map_fd)
+{
+	return bpf_program_attach_fd(prog, map_fd, "sockmap", NULL);
+}
+
 struct bpf_link *bpf_program__attach_xdp(const struct bpf_program *prog,=
 int ifindex)
 {
 	/* target_fd/target_ifindex use the same field in LINK_CREATE */
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index f88ab50c0229..4c7ada03bf4f 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -795,6 +795,8 @@ bpf_program__attach_cgroup(const struct bpf_program *=
prog, int cgroup_fd);
 LIBBPF_API struct bpf_link *
 bpf_program__attach_netns(const struct bpf_program *prog, int netns_fd);
 LIBBPF_API struct bpf_link *
+bpf_program__attach_sockmap(const struct bpf_program *prog, int map_fd);
+LIBBPF_API struct bpf_link *
 bpf_program__attach_xdp(const struct bpf_program *prog, int ifindex);
 LIBBPF_API struct bpf_link *
 bpf_program__attach_freplace(const struct bpf_program *prog,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 51732ecb1385..015737439007 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -411,8 +411,14 @@ LIBBPF_1.3.0 {
 LIBBPF_1.4.0 {
 	global:
 		bpf_program__attach_raw_tracepoint_opts;
+		bpf_program__attach_sockmap;
 		bpf_raw_tracepoint_open_opts;
 		bpf_token_create;
 		btf__new_split;
 		btf_ext__raw_data;
 } LIBBPF_1.3.0;
+
+LIBBPF_1.5.0 {
+	global:
+		bpf_program__attach_sockmap;
+} LIBBPF_1.4.0;
diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_versio=
n.h
index e783a47da815..d6e5eff967cb 100644
--- a/tools/lib/bpf/libbpf_version.h
+++ b/tools/lib/bpf/libbpf_version.h
@@ -4,6 +4,6 @@
 #define __LIBBPF_VERSION_H
=20
 #define LIBBPF_MAJOR_VERSION 1
-#define LIBBPF_MINOR_VERSION 4
+#define LIBBPF_MINOR_VERSION 5
=20
 #endif /* __LIBBPF_VERSION_H */
--=20
2.43.0

