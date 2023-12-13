Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE6BEA
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 14:23:54 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDLiFUG008103
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 14:23:54 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uy9e14xx1-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 14:23:53 -0800
Received: from twshared44805.48.prn1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 13 Dec 2023 14:23:50 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 6685F3D1AF7EC; Wed, 13 Dec 2023 14:23:40 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 0/2] BPF FS mount options parsing follow ups
Date: Wed, 13 Dec 2023 14:23:25 -0800
Message-ID: <20231213222327.934981-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: dZb8AkGMU7DqhFqC-ZRR-MxXTursI_oT
X-Proofpoint-ORIG-GUID: dZb8AkGMU7DqhFqC-ZRR-MxXTursI_oT
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_14,2023-12-13_01,2023-05-22_02

Original BPF token patch set ([0]) added delegate_xxx mount options which
supported only special "any" value and hexadecimal bitmask. This patch set
attempts to make specifying and inspecting these mount options more
human-friendly by supporting string constants matching corresponding bpf_cm=
d,
bpf_map_type, bpf_prog_type, and bpf_attach_type enumerators.

This implementation relies on BTF information to find all supported symbolic
names. If kernel wasn't built with BTF, BPF FS will still support "any" and
hex-based mask.

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D805707&=
state=3D*

Andrii Nakryiko (2):
  bpf: support symbolic BPF FS delegation mount options
  selftests/bpf: utilize string values for delegate_xxx mount options

 kernel/bpf/inode.c                            | 231 +++++++++++++++---
 .../testing/selftests/bpf/prog_tests/token.c  |  52 ++--
 2 files changed, 225 insertions(+), 58 deletions(-)

--=20
2.34.1

