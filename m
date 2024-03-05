Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCB812838E
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670143; cv=none; b=LWBOAc6O8RNXjhVjmzhiFIedXjsn5eRGBK6LYfCK6A0xqKxsJOycoumoh3aew2X4VAbtGFJ+akNfwg4Mz9A1PZIaCpKTM9rf9WI9HLfXE4lkefYCZYSI3/Z5CU5h+1KN3rBjO9JPh0NqswUqsaJHlVr6COlJJwtzlaEqlVWXC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670143; c=relaxed/simple;
	bh=3OYu6DOsgPvm8TaUk4VuZVM98CjqgB6mmVivsnS4B2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G01vS46BavrL0CrOa8iDUt1aNJTIpABIgVa89TOw7N0m2s3k8/BG3yQQoFbEEA3WyAkyOdiVg+j1lZ6KQXw8pLfmt8SbEmBLsdTaMChFYiAzLHNaHc7ZSZNpVzkZBqH2oQIYOR/l4dao08dR7+mfj4l38Cbf927STI0/tgsQszE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 4FAD414A9183; Tue,  5 Mar 2024 12:22:16 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [RFC PATCH bpf-next 4/5] bpftool: Add link dump support for BPF_LINK_TYPE_SK_MSG
Date: Tue,  5 Mar 2024 12:22:16 -0800
Message-ID: <20240305202216.3891808-1-yonghong.song@linux.dev>
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

An example output looks like:
  9: sk_msg  prog 108
          map_id 84  attach_type sk_msg_verdict

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/bpf/bpftool/link.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index afde9d0c2ea1..5eb140197d3f 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -526,6 +526,9 @@ static int show_link_close_json(int fd, struct bpf_li=
nk_info *info)
 		show_link_ifindex_json(info->netkit.ifindex, json_wtr);
 		show_link_attach_type_json(info->netkit.attach_type, json_wtr);
 		break;
+	case BPF_LINK_TYPE_SK_MSG:
+		jsonw_uint_field(json_wtr, "map_id", info->skmsg.map_id);
+		show_link_attach_type_json(info->skmsg.attach_type, json_wtr);
 	case BPF_LINK_TYPE_XDP:
 		show_link_ifindex_json(info->xdp.ifindex, json_wtr);
 		break;
@@ -915,6 +918,11 @@ static int show_link_close_plain(int fd, struct bpf_=
link_info *info)
 		show_link_ifindex_plain(info->netkit.ifindex);
 		show_link_attach_type_plain(info->netkit.attach_type);
 		break;
+	case BPF_LINK_TYPE_SK_MSG:
+		printf("\n\t");
+		printf("map_id %u  ", info->skmsg.map_id);
+		show_link_attach_type_plain(info->skmsg.attach_type);
+		break;
 	case BPF_LINK_TYPE_XDP:
 		printf("\n\t");
 		show_link_ifindex_plain(info->xdp.ifindex);
--=20
2.43.0

