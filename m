Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A97C22F1E
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870861; cv=none; b=Rb/PgoSxmJ7d5vvgMVWTC28PpTTlzut8odGxwMefW0Yb8/DTn8Uz2gbrR16cNjNpNYmHA2lFKvrktvvPmxzUQieq/uYyXXV6KbOa4nDcvlmTfg6rIIQeBeyOnfqjHi6X/RRkmzKog9FrbONV9i4PprLkmkFgWWEvBAlevifw7hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870861; c=relaxed/simple;
	bh=quuBpusKPuwXe1VYvRrLA3b9w/H15j4c6nFz7/2LmNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9QFIgI5qpNAS4YqpQfcDMH9bFIHTZ26pQ4/5uZqHhZF6ECBFELFs/nHwyncbZg07KbEMWcqJSvPtfOztP2tpU45v9v3a+8WLDhvVIc94Mf83zP/7Y2iGkdZtf2bpWCDetEDVT0g4bLfO3Tkm6hIhrXrKbHWmgHQPxDygFNh76Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 0A807206A806; Tue, 19 Mar 2024 10:54:12 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 2/6] libbpf: Add new sec_def "sk_skb/verdict"
Date: Tue, 19 Mar 2024 10:54:12 -0700
Message-ID: <20240319175412.2941149-1-yonghong.song@linux.dev>
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

The new sec_def specifies sk_skb program type with
BPF_SK_SKB_VERDICT attachment type. This way, libbpf
will set expected_attach_type properly for the program.
This will make it easier for later bpf_link based
APIs for sk_skb programs.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3a756d61c120..7d413415d0d5 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9312,6 +9312,7 @@ static const struct bpf_sec_def section_defs[] =3D =
{
 	SEC_DEF("sockops",		SOCK_OPS, BPF_CGROUP_SOCK_OPS, SEC_ATTACHABLE_OPT),
 	SEC_DEF("sk_skb/stream_parser",	SK_SKB, BPF_SK_SKB_STREAM_PARSER, SEC_A=
TTACHABLE_OPT),
 	SEC_DEF("sk_skb/stream_verdict",SK_SKB, BPF_SK_SKB_STREAM_VERDICT, SEC_=
ATTACHABLE_OPT),
+	SEC_DEF("sk_skb/verdict",	SK_SKB, BPF_SK_SKB_VERDICT, SEC_ATTACHABLE_OP=
T),
 	SEC_DEF("sk_skb",		SK_SKB, 0, SEC_NONE),
 	SEC_DEF("sk_msg",		SK_MSG, BPF_SK_MSG_VERDICT, SEC_ATTACHABLE_OPT),
 	SEC_DEF("lirc_mode2",		LIRC_MODE2, BPF_LIRC_MODE2, SEC_ATTACHABLE_OPT),
--=20
2.43.0

