Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B51282E1
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870871; cv=none; b=lW8GistlW1a9Z5yatRKYjElwMudGgdqaAG5ncT3cEQhzikZAF7FS2T5cwWb188gCCSmpuu3za0bp9A9J14mREwQhm2GpCokKnY0qoJQPKbWbOa4X1mxx9kBolXRdJ24kf8Q9VrX2oVV+tvf4z72ez/7N3xzNimKmH1POA341G8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870871; c=relaxed/simple;
	bh=p1YzNB9+hZZe7AVyVoLFmXihF8VIiYz4cAoJcDexBXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2no4YeWoLygIGZ4P/rB4vMr9opb168MA6pXdhjUslZ5OheldNTTgmO7Ugc8cd91MDgaU10c43k5mMq/d5gk1EFWvZPwZBwDLNN7cLowcCqYaDgTvMF2rIpJ/pgGMZhSayO3rVeiKm55NR9hs0V5AUkDxyD2oDSNTm39Mg9Zw18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 23548206A822; Tue, 19 Mar 2024 10:54:17 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 3/6] libbpf: Add bpf_link support for BPF_PROG_TYPE_SK_{MSG,SKB}
Date: Tue, 19 Mar 2024 10:54:17 -0700
Message-ID: <20240319175417.2941417-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240319175401.2940148-1-yonghong.song@linux.dev>
References: <20240319175401.2940148-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Introduce two libbpf API functions bpf_program__attach_sk_msg()
and bpf_program__attach_sk_skb() which allow user to get a bpf_link
for their corresponding programs.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/libbpf.c   | 14 ++++++++++++++
 tools/lib/bpf/libbpf.h   |  4 ++++
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7d413415d0d5..1b8e1f47a5e6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -149,6 +149,8 @@ static const char * const link_type_name[] =3D {
 	[BPF_LINK_TYPE_TCX]			=3D "tcx",
 	[BPF_LINK_TYPE_UPROBE_MULTI]		=3D "uprobe_multi",
 	[BPF_LINK_TYPE_NETKIT]			=3D "netkit",
+	[BPF_LINK_TYPE_SK_MSG]			=3D "sk_msg",
+	[BPF_LINK_TYPE_SK_SKB]			=3D "sk_skb",
 };
=20
 static const char * const map_type_name[] =3D {
@@ -12493,6 +12495,18 @@ bpf_program__attach_netns(const struct bpf_progr=
am *prog, int netns_fd)
 	return bpf_program_attach_fd(prog, netns_fd, "netns", NULL);
 }
=20
+struct bpf_link *
+bpf_program__attach_sk_msg(const struct bpf_program *prog, int map_fd)
+{
+	return bpf_program_attach_fd(prog, map_fd, "sk_msg", NULL);
+}
+
+struct bpf_link *
+bpf_program__attach_sk_skb(const struct bpf_program *prog, int map_fd)
+{
+	return bpf_program_attach_fd(prog, map_fd, "sk_skb", NULL);
+}
+
 struct bpf_link *bpf_program__attach_xdp(const struct bpf_program *prog,=
 int ifindex)
 {
 	/* target_fd/target_ifindex use the same field in LINK_CREATE */
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 7b510761f545..4a2c04a9c6c3 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -784,6 +784,10 @@ bpf_program__attach_cgroup(const struct bpf_program =
*prog, int cgroup_fd);
 LIBBPF_API struct bpf_link *
 bpf_program__attach_netns(const struct bpf_program *prog, int netns_fd);
 LIBBPF_API struct bpf_link *
+bpf_program__attach_sk_msg(const struct bpf_program *prog, int map_fd);
+LIBBPF_API struct bpf_link *
+bpf_program__attach_sk_skb(const struct bpf_program *prog, int map_fd);
+LIBBPF_API struct bpf_link *
 bpf_program__attach_xdp(const struct bpf_program *prog, int ifindex);
 LIBBPF_API struct bpf_link *
 bpf_program__attach_freplace(const struct bpf_program *prog,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 86804fd90dd1..11a1ad798129 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -410,6 +410,8 @@ LIBBPF_1.3.0 {
=20
 LIBBPF_1.4.0 {
 	global:
+		bpf_program__attach_sk_msg;
+		bpf_program__attach_sk_skb;
 		bpf_token_create;
 		btf__new_split;
 		btf_ext__raw_data;
--=20
2.43.0

