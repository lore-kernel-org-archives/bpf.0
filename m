Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193AB57314
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 02:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711419893; cv=none; b=dz7E1O2uRWRuWK6+AshRRuCfG2hmxzHT6+01eCMuCtL6hbyM6w8Pb6hogFdAXR7f0g2cdSZLwXl29BF7wVGRDOSZUCq/8V80T1JJNw4XAzSIqt5K7ndycUHkHTF8UEs9et5Pk7Iz+3mEX7lIyr5HbmZhbgrHGqSGBRzE3c8NAxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711419893; c=relaxed/simple;
	bh=tnRczj7EvVdSwNMfrKlHyO4f62e/514K94XDvTGijwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBoHi3wIJ6xDqC94ijOS8sQPPOG5YDachuRnlXZ6A+/0fb8WAR3RYXD5QTercHJLf/soTpFhCM2Np01kLGFJI8YbvXEHoPrr7lb2WBOrhHvQ3gi/QjShRWG21a2KPxM5mlsLMR2rOU8tXQecKXwjfCVNoTSrVm5PxTd1R7cOpAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 3457024DD246; Mon, 25 Mar 2024 19:22:09 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 3/5] bpftool: Add link dump support for BPF_LINK_TYPE_SOCKMAP
Date: Mon, 25 Mar 2024 19:22:08 -0700
Message-ID: <20240326022209.656999-1-yonghong.song@linux.dev>
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

An example output looks like:
  $ bpftool link
    1776: sk_skb  prog 49730
            map_id 0  attach_type sk_skb_verdict
            pids test_progs(8424)
    1777: sk_skb  prog 49755
            map_id 0  attach_type sk_skb_stream_verdict
            pids test_progs(8424)
    1778: sk_msg  prog 49770
            map_id 8208  attach_type sk_msg_verdict
            pids test_progs(8424)

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/bpf/bpftool/link.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index afde9d0c2ea1..5cd503b763d7 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -526,6 +526,10 @@ static int show_link_close_json(int fd, struct bpf_l=
ink_info *info)
 		show_link_ifindex_json(info->netkit.ifindex, json_wtr);
 		show_link_attach_type_json(info->netkit.attach_type, json_wtr);
 		break;
+	case BPF_LINK_TYPE_SOCKMAP:
+		jsonw_uint_field(json_wtr, "map_id", info->sockmap.map_id);
+		show_link_attach_type_json(info->sockmap.attach_type, json_wtr);
+		break;
 	case BPF_LINK_TYPE_XDP:
 		show_link_ifindex_json(info->xdp.ifindex, json_wtr);
 		break;
@@ -915,6 +919,11 @@ static int show_link_close_plain(int fd, struct bpf_=
link_info *info)
 		show_link_ifindex_plain(info->netkit.ifindex);
 		show_link_attach_type_plain(info->netkit.attach_type);
 		break;
+	case BPF_LINK_TYPE_SOCKMAP:
+		printf("\n\t");
+		printf("map_id %u  ", info->sockmap.map_id);
+		show_link_attach_type_plain(info->sockmap.attach_type);
+		break;
 	case BPF_LINK_TYPE_XDP:
 		printf("\n\t");
 		show_link_ifindex_plain(info->xdp.ifindex);
--=20
2.43.0

