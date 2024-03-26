Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E2184D30
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 02:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711419739; cv=none; b=CGjutDjjBzBKJ890VrDVG5YIvi+ihGK5FVEgtrZAUo9yri3Zln+CpLmsDDh7EOMAowgLApSOthjEZwEKIc/JRxbk5J/fRGOVTZYHFm6s9RXdtubicWOBXEU/zINHtRQGQ7z9KC9e3POWKoKCBKn0waGwPikJTkbs5+OGb0PKX8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711419739; c=relaxed/simple;
	bh=7jm3KKQm1TZQoWeLWWNtkaKtkF9vdGTme2MHd45tV+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2jGs9QwrVstPqIPU3K8nuUJZxkvHVoiUMn7bhW29YRD6NNxCHgtc4b1koj/yEFwEBaq/ss365PxflNjIXY0SGlhSvfSrPglIbEOuq+uMn4rM1G8QBDN+rnUik1vwDCiLBiuo6In8lIfPfpOXvvj8M+/U+Ccc8kUFCn+CPkdN1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id DF2DF24DD226; Mon, 25 Mar 2024 19:22:03 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 2/5] libbpf: Add bpf_link support for BPF_PROG_TYPE_SOCKMAP
Date: Mon, 25 Mar 2024 19:22:03 -0700
Message-ID: <20240326022203.656793-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326022153.656006-1-yonghong.song@linux.dev>
References: <20240326022153.656006-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Introduce a libbpf API function bpf_program__attach_sockmap()
which allow user to get a bpf_link for their corresponding programs.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/libbpf.c   | 7 +++++++
 tools/lib/bpf/libbpf.h   | 2 ++
 tools/lib/bpf/libbpf.map | 1 +
 3 files changed, 10 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8eb2cd4ef288..e1bb9ba3d1a5 100644
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
@@ -12507,6 +12508,12 @@ bpf_program__attach_netns(const struct bpf_progr=
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
index 51732ecb1385..2e5c3429b974 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -411,6 +411,7 @@ LIBBPF_1.3.0 {
 LIBBPF_1.4.0 {
 	global:
 		bpf_program__attach_raw_tracepoint_opts;
+		bpf_program__attach_sockmap;
 		bpf_raw_tracepoint_open_opts;
 		bpf_token_create;
 		btf__new_split;
--=20
2.43.0

