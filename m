Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F653E7633;
	Wed, 12 Aug 2026 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523515; cv=none; b=TDjvq+fMwo2ftZUSiaExbHRX8xL2xMZMrBg5TXgg0kVI/HWjZLbjFm0ED81CjsKNs0l8AEmM6ZmYCidX7OVu4xLuyh3MGMIIwCZOCTpAe0X7e1dbaRrq8viubeOlX0Wv26IEDfjZ4ksXNDYVbCRGj/QK2YJ1sI9u/SYc1hYCqYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523515; c=relaxed/simple;
	bh=PsfhrFDLY9xwoWfUdxuAhyLzmbDTm66vmPfuG23iXuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W+pSBWjUtjW9JlhWFU404ix6PJ7wf41Go/9NIch1H/kGP4TRlcUK6g/v1NgLYSPZYNIn1yRBxjyF7z6guihTlVqkbfz+pcunuJbxBz4OePXNeUyvbV/PIqIyI+8K5hJ/I92KlIuFbMPsWBfBruXM/KC2cQ0oG6qxhB88/plTRJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=eDCzdobk; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="eDCzdobk"
Received: from pps.filterd (m0409408.ppops.net [127.0.0.1])
	by m0409408.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 67C63Y1A1517117;
	Wed, 12 Aug 2026 09:31:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=apr2026.eng; bh=O8Lfb5vjd
	auA/ufKBxdAkqZqNcMbJVqP8KK2nMEoyTc=; b=eDCzdobkVDHVP6h40T58t2XMR
	v6V8lVRynZYTfgAjOQTgukvgi2DepmUpwldFQAzFirFI6V2pikXa8rTisrfT0CwE
	eeQXU6T7GdbDL8d6E3WJjmChdIZudosGFDfbJsDZ/sluWDVi770jB3bfKMg65NYo
	/+IrJYmew0SrICk94n2ouz4ZYxu/SRUuW5vWBFGq3EWtIlnxmhazFfbgdi4SZfC3
	zofeHH8V/Gyd/8t4dirG1VEPs1GD0YvJcVwZk0jokOy/qbVs4pY+rkZ0XJG1/BX2
	OBR40fJwlxm/1q1W/opBouH/BM5WImUHCfEtRc51hYhEiyRAYYt10VLElvYfg==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
	by m0409408.ppops.net-00190b01. (PPS) with ESMTPS id 4fxfc80v18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 09:31:25 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 67C8KFVN032028;
	Wed, 12 Aug 2026 04:31:24 -0400
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 4fwysw70fq-1;
	Wed, 12 Aug 2026 04:31:24 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay01.akamai.com (Postfix) with ESMTP id 216A584;
	Wed, 12 Aug 2026 08:31:23 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, Max Tottenham <mtottenh@akamai.com>,
        Anna Glasgall <aglasgal@akamai.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v7 1/6] bpf: name the enum for BPF_FUNC_skb_adjust_room flags
Date: Wed, 12 Aug 2026 09:31:10 +0100
Message-Id: <20260812083115.73100-2-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812083115.73100-1-nhudson@akamai.com>
References: <20260812083115.73100-1-nhudson@akamai.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2608120066
X-Authority-Analysis: v=2.4 cv=U4Ciy+ru c=1 sm=1 tr=0 ts=6a7c2f5e cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=BYUV7c42er6_Rx9bq0XK:22 a=X7Ea-ya5AAAA:8 a=1XWaLZrsAAAA:8
 a=TMHggaePV_XZxh6C_gsA:9
X-Proofpoint-ORIG-GUID: 3Gq3of29eKVNhulM0U9geq8OG40DFdgX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfX2HyntjKOsJVe
 oWRD9ZPRqid8QfgKCJQKy0Pjdwol6gF+mxzLB1JByhC2Pp7JDOBWgkORcniRdMhCS47fsnA8XGR
 mbOPV0tR9aQaLW5a6hsPwLCdooOGorE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfXxvSkEbRQ0kEq
 UHjI1qz3P9sqW6SgzbVKq5zDA7Jx9Gt7RjFFoO71s8Qb8oJ2gZpSSyFIUXpKJ+6HzWB3v/uUHhN
 vzRfedjzreq/1E+59nXl71j3mRm4TPbWi+NFmP7Lfj532+dAAeyKLldcZp+vw/sEr2gEdEXW5j0
 yhq9u0TMVRBdWlVkmYabkCrru04ubv+cvztKTrrVZiPdBIry8VTeqqR/EASW7GzTq646H5bbzRB
 HH9pvccdYZg586LhLM09gmYfr4qx1XT0wot63Qn7KbPLA2t0DFpsfGacTiPGSTTN+MN+jBjwqGh
 HUmAGMAzhWB9NVJrxyZfIKBrPfTMd1cqjxiktdx/hKj2c2N5QO/buPqBssVF9Z4iaZJS/vMfL5M
 nCqTiUyjpgBSzK1UjCtoIomrs2sSXyPJDYBIBnZD6zJsfX1JeWGHinp0S2brTuUsC0SOTDce3+S
 RBpRf9QX2oWKSK/bPqA==
X-Proofpoint-GUID: 3Gq3of29eKVNhulM0U9geq8OG40DFdgX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606160001 definitions=main-2608120067

The existing anonymous enum for BPF_FUNC_skb_adjust_room flags is
named to enum bpf_adj_room_flags to enable CO-RE (Compile Once -
Run Everywhere) lookups in BPF programs.

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/uapi/linux/bpf.h       | 2 +-
 tools/include/uapi/linux/bpf.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ffd96e8b920b..f6c9dc856858 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6283,7 +6283,7 @@ enum {
 };
 
 /* BPF_FUNC_skb_adjust_room flags. */
-enum {
+enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_FIXED_GSO	= (1ULL << 0),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV4	= (1ULL << 1),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	= (1ULL << 2),
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ffd96e8b920b..f6c9dc856858 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6283,7 +6283,7 @@ enum {
 };
 
 /* BPF_FUNC_skb_adjust_room flags. */
-enum {
+enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_FIXED_GSO	= (1ULL << 0),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV4	= (1ULL << 1),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	= (1ULL << 2),
-- 
2.34.1

