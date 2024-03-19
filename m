Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2205374FA
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870875; cv=none; b=AdMOp2Ftc1ZkNn+cEcI+cF3qn1m1fgtkZeQWp3dy85L1shdMmwmDNneE64bWNS8yYsDF3Cr1Q6gen13eVh1Alxn1ZsQk5l53OtFBEhnwUawpoazqcG9TsRJvj7BvYd1L9n5OvQP8U8oUJWyl0SOtSl6b5cD3xWspbpfzqrq32tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870875; c=relaxed/simple;
	bh=9vFLJD5W8Eu6fubwC0q7XOuhq/GgjlxpmBKOtEQt0Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gs63QEN6Tneyb0DNGSl/oC2PnVBYZK2nEANrA7JT/UJMMv9nymHt3omOWAmslw4MhZSSJAYCN6uVtVXw86ZP77CMhYKd2nyonI4VY8GjlOuepktfl+LCjmsd3GEi0s+RZQBi0RzeDBgyctYWSJ2DgQrQgbb439i9qORmSo48fj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 3EB45206A855; Tue, 19 Mar 2024 10:54:22 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 4/6] bpftool: Add link dump support for BPF_LINK_TYPE_SK_{MSG,SKB}
Date: Tue, 19 Mar 2024 10:54:22 -0700
Message-ID: <20240319175422.2942069-1-yonghong.song@linux.dev>
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
 tools/bpf/bpftool/link.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index afde9d0c2ea1..c01d3c38cdf0 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -526,6 +526,14 @@ static int show_link_close_json(int fd, struct bpf_l=
ink_info *info)
 		show_link_ifindex_json(info->netkit.ifindex, json_wtr);
 		show_link_attach_type_json(info->netkit.attach_type, json_wtr);
 		break;
+	case BPF_LINK_TYPE_SK_MSG:
+		jsonw_uint_field(json_wtr, "map_id", info->skmsg.map_id);
+		show_link_attach_type_json(info->skmsg.attach_type, json_wtr);
+		break;
+	case BPF_LINK_TYPE_SK_SKB:
+		jsonw_uint_field(json_wtr, "map_id", info->skskb.map_id);
+		show_link_attach_type_json(info->skskb.attach_type, json_wtr);
+		break;
 	case BPF_LINK_TYPE_XDP:
 		show_link_ifindex_json(info->xdp.ifindex, json_wtr);
 		break;
@@ -915,6 +923,16 @@ static int show_link_close_plain(int fd, struct bpf_=
link_info *info)
 		show_link_ifindex_plain(info->netkit.ifindex);
 		show_link_attach_type_plain(info->netkit.attach_type);
 		break;
+	case BPF_LINK_TYPE_SK_MSG:
+		printf("\n\t");
+		printf("map_id %u  ", info->skmsg.map_id);
+		show_link_attach_type_plain(info->skmsg.attach_type);
+		break;
+	case BPF_LINK_TYPE_SK_SKB:
+		printf("\n\t");
+		printf("map_id %u  ", info->skskb.map_id);
+		show_link_attach_type_plain(info->skskb.attach_type);
+		break;
 	case BPF_LINK_TYPE_XDP:
 		printf("\n\t");
 		show_link_ifindex_plain(info->xdp.ifindex);
--=20
2.43.0

