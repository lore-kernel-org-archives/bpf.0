Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824709A
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 15:25:57 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCLfbAe001825
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 15:25:57 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uxx3699g0-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 15:25:57 -0800
Received: from twshared10507.42.prn1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 12 Dec 2023 15:25:55 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 080D53D0C8A58; Tue, 12 Dec 2023 15:25:53 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 08/10] libbpf: add __arg_xxx macros for annotating global func args
Date: Tue, 12 Dec 2023 15:25:33 -0800
Message-ID: <20231212232535.1875938-9-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212232535.1875938-1-andrii@kernel.org>
References: <20231212232535.1875938-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 8GLLVwZ3GmTvQ9XQtPG0ePSCbuijN6KL
X-Proofpoint-ORIG-GUID: 8GLLVwZ3GmTvQ9XQtPG0ePSCbuijN6KL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02

Add a set of __arg_xxx macros which can be used to augment BPF global
subprogs/functions with extra information for use by BPF verifier.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 77ceea575dc7..2324cc42b017 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -188,6 +188,9 @@ enum libbpf_tristate {
 	!!sym;											\
 })
=20
+#define __arg_ctx __attribute__((btf_decl_tag("arg:ctx")))
+#define __arg_nonnull __attribute((btf_decl_tag("arg:nonnull")))
+
 #ifndef ___bpf_concat
 #define ___bpf_concat(a, b) a ## b
 #endif
--=20
2.34.1

