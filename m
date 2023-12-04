Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54E2113
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 15:40:17 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4KGl7U008058
	for <bpf@vger.kernel.org>; Mon, 4 Dec 2023 15:40:17 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3urr81bfe2-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 15:40:17 -0800
Received: from twshared11278.41.prn1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 15:40:14 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 24FFE3C97273E; Mon,  4 Dec 2023 15:39:59 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 12/13] libbpf: add __arg_xxx macros for annotating global func args
Date: Mon, 4 Dec 2023 15:39:30 -0800
Message-ID: <20231204233931.49758-13-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204233931.49758-1-andrii@kernel.org>
References: <20231204233931.49758-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ED6hu61Q2a3i-PhlOaoyJ5aKSEW_4YCu
X-Proofpoint-ORIG-GUID: ED6hu61Q2a3i-PhlOaoyJ5aKSEW_4YCu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_22,2023-12-04_01,2023-05-22_02

Add a set of __arg_xxx macros which can be used to augment BPF global
subprogs/functions with extra information for use by BPF verifier.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 77ceea575dc7..6e3f24f569b7 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -188,6 +188,15 @@ enum libbpf_tristate {
 	!!sym;											\
 })
=20
+#define __arg_nonnull __attribute((btf_decl_tag("arg:nonnull")))
+
+#define __arg_ctx __attribute__((btf_decl_tag("arg:ctx")))
+#define __arg_dynptr __attribute__((btf_decl_tag("arg:dynptr")))
+
+#define __arg_pkt_meta __attribute__((btf_decl_tag("arg:pkt_meta")))
+#define __arg_pkt_data __attribute__((btf_decl_tag("arg:pkt_data")))
+#define __arg_pkt_end __attribute__((btf_decl_tag("arg:pkt_end")))
+
 #ifndef ___bpf_concat
 #define ___bpf_concat(a, b) a ## b
 #endif
--=20
2.34.1

