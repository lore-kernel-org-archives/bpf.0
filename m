Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8BF12838E
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670146; cv=none; b=qMv5cWx7zIW/d1xihkK50wO0LN3Pz6MMstPMMEcQZrDZZoc+zIjluErbuzrpH5FkmUsasQjfg40+Y7BcWZt/teGNqFkdPHFIqGyw8+5MMmS2UZKy0FSAbhCtUbf9OzxYKokaPpkJA/NRbwyalf2SD4r1SW0IhJpCVDS+XhYVkRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670146; c=relaxed/simple;
	bh=/b/WAfX0w6X0x6mrBNKtDR4mx7pL2saI12k7jkRBKwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTHOMPvFXw7JG0nOu/467xlaPwUngYYw5rjwnYSUrErVVSdSF4LISHiOd166kvRLBBLTNyK6MF8yRmPtYDMbTmqlyFfcMemybD0PqM8F43/k9yNQy6yrNE4Q5d9LyFD/FI65oWSLjR5ciBeHjVD3p01+EV4YKFgf1HboyZSDqIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 36EFF14A9170; Tue,  5 Mar 2024 12:22:11 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [RFC PATCH bpf-next 3/5] libbpf: Add link support for BPF_PROG_TYPE_SK_MSG
Date: Tue,  5 Mar 2024 12:22:11 -0800
Message-ID: <20240305202211.3891663-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305202155.3890667-1-yonghong.song@linux.dev>
References: <20240305202155.3890667-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Introduce a libbpf API bpf_program__attach_sk_msg() which allows
user to get a bpf_link. The API makes auto-deletion easier and
also allows user space application easier as link based APIs
are used for all programs.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/libbpf.c   | 8 ++++++++
 tools/lib/bpf/libbpf.h   | 3 +++
 tools/lib/bpf/libbpf.map | 1 +
 3 files changed, 12 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 97b573516675..b3982bb3f979 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -149,6 +149,7 @@ static const char * const link_type_name[] =3D {
 	[BPF_LINK_TYPE_TCX]			=3D "tcx",
 	[BPF_LINK_TYPE_UPROBE_MULTI]		=3D "uprobe_multi",
 	[BPF_LINK_TYPE_NETKIT]			=3D "netkit",
+	[BPF_LINK_TYPE_SK_MSG]			=3D "sk_msg",
 };
=20
 static const char * const map_type_name[] =3D {
@@ -12280,6 +12281,13 @@ bpf_program__attach_netkit(const struct bpf_prog=
ram *prog, int ifindex,
 	return bpf_program_attach_fd(prog, ifindex, "netkit", &link_create_opts=
);
 }
=20
+struct bpf_link *
+bpf_program__attach_sk_msg(const struct bpf_program *prog, int map_fd,
+			   enum bpf_attach_type attach_type)
+{
+	return __bpf_program_attach_fd(prog, map_fd, attach_type, "sk_msg", NUL=
L);
+}
+
 struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *=
prog,
 					      int target_fd,
 					      const char *attach_func_name)
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5723cbbfcc41..c8448f05e8d6 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -786,6 +786,9 @@ bpf_program__attach_netns(const struct bpf_program *p=
rog, int netns_fd);
 LIBBPF_API struct bpf_link *
 bpf_program__attach_xdp(const struct bpf_program *prog, int ifindex);
 LIBBPF_API struct bpf_link *
+bpf_program__attach_sk_msg(const struct bpf_program *prog, int map_fd,
+			   enum bpf_attach_type attach_type);
+LIBBPF_API struct bpf_link *
 bpf_program__attach_freplace(const struct bpf_program *prog,
 			     int target_fd, const char *attach_func_name);
=20
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 86804fd90dd1..c59986c6dbc5 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -410,6 +410,7 @@ LIBBPF_1.3.0 {
=20
 LIBBPF_1.4.0 {
 	global:
+		bpf_program__attach_sk_msg;
 		bpf_token_create;
 		btf__new_split;
 		btf_ext__raw_data;
--=20
2.43.0

