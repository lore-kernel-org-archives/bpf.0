Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E5D3BA23A;
	Tue, 17 Mar 2026 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749715; cv=none; b=uczZzfA6EedlXvM/zHJszYeV5mIWyv+ktxSf5C8oBAXuhy3m561AoEGlJkQTwHVsLujVuYhwqTZ5riSfgn4YFMR5KY4aQvUoOm5cl0M320vqMB+OWWDyxuZGNhKcEV7saZmYLwbBCrpw2c+yU2SiIgApreZtGsaeWake1WIikDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749715; c=relaxed/simple;
	bh=aQBT0CCxDMOXcpIo5nD/Fq4QKrdvjAhHbTzdjNLMm1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PeW4BC/0WKkLZPyiaNznCQ3n/ptXhD9G4C+UQarkwm/YWg7kxtBlPlwcngyuSo/rHmOM1Wk52NHsTzjXfe8hO9wtKt8H84RwlaCaw5GR79KCA7UCD+4q2RP2u+FltZ7TVxzoWp90GX9laj7A2MVE1sG/RVfRf9nq4oyFlGkGSUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=md0J4D57; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="md0J4D57"
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HAorhs4004981;
	Tue, 17 Mar 2026 12:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=jdZ3KkN9b
	JH1LNJaRWfghhJEw4rB20ARY9d4RT3FKdw=; b=md0J4D578q0fjSAkQ0ZZZnFea
	AAi7lzE0NSfKYf8FAY5MCXfzdsYtBpp7qhTmQfAPMiveo9bu3I5FSUJGRzxfE/Bk
	hg4CWgXu+3LZeDvLUCU8wEcEv1vu1Ex8OTICuNsXxTBPqrkD0Jb6kInmbW9qNjV9
	RG5slUwxAQm7H9mxwEwUhESKNo8R2Sy4ze80C9/UDwKlN4gYaMaV5FOcE+VWkAR8
	0wFWiNHa+vJLR2l6qxazlubQN7MNx4ufVdC/jQDrHOQYNMpTKG6857F3wF7Jx/gv
	w7sdEwJhKB4UPWC0aPZV8R31/Kjd+YvZgdbGTd+EKySQS8CkALf6qhVlXVJTw==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4cw02xghs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 12:14:52 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 62HC435b027977;
	Tue, 17 Mar 2026 08:14:52 -0400
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 4cw30xjvkx-1;
	Tue, 17 Mar 2026 08:14:52 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id E3B6983;
	Tue, 17 Mar 2026 12:14:50 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Nick Hudson <nhudson@akamai.com>, Max Tottenham <mtottenh@akamai.com>,
        Anna Glasgall <aglasgal@akamai.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] bpf: name the enum for BPF_FUNC_skb_adjust_room flags
Date: Tue, 17 Mar 2026 12:14:25 +0000
Message-Id: <20260317121429.2399539-2-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317121429.2399539-1-nhudson@akamai.com>
References: <20260317121429.2399539-1-nhudson@akamai.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=631 lowpriorityscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2603050001 definitions=main-2603170107
X-Proofpoint-GUID: gqFnxodOCUdrMGbNine-A__8ILg0XIm9
X-Proofpoint-ORIG-GUID: gqFnxodOCUdrMGbNine-A__8ILg0XIm9
X-Authority-Analysis: v=2.4 cv=H9/rBeYi c=1 sm=1 tr=0 ts=69b945bd cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=VcQvXEo1OZcA_IiPcy3B:22 a=X7Ea-ya5AAAA:8 a=TMHggaePV_XZxh6C_gsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEwNyBTYWx0ZWRfXxOIYaGs9zkFq
 JA5It3i1/KfY8zSQnSzRbnHkwfo9doVkQNoNyNeEWBHhuBSrwdumGNMTXlFgLQj26sF0Bo+QxFD
 RaTAsDatXbTmp60XLuyjea1pDdYefOM6whJYzmXU8ztgtQlBTHGINSfzp+AUXrFf61b9xHZSAvQ
 Vi3YHonnBlapnn8B19yn/fg5KRg1F5FQ5Su2AH2YNaK7Z3+wDMJgJZRGHuvLGnkZ+kf4PyJSNfM
 +cKdH5TDG8la+sQ23d8cAqrFSm7dLKteDkydl9GKJEMUhANzs2V/rmw7keaVSZPjCbXWbnLeyqZ
 0h4FjnOiZpgg5YbUCbTl/8rxSc+0jNBw2O/NGOav/34PKMm7MAopZrsSoKibZ8UOAJzX5lefQq+
 xOPnJ6EbTYl0rmcv0fnJmznChY22zKRN29XM2R+wt1z1oomHqumKI5FYQ5sMp6x1yMt5Rx34OvQ
 8WILUraW1ht+CknJdAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603130000 definitions=main-2603170107

The existing anonymous enum for BPF_FUNC_skb_adjust_room flags is
named to enum bpf_adj_room_flags to enable CO-RE (Compile Once -
Run Everywhere) lookups in BPF programs.

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>
---
 include/uapi/linux/bpf.h       | 2 +-
 tools/include/uapi/linux/bpf.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c8d400b7680a..bc4b25eb72ce 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6209,7 +6209,7 @@ enum {
 };
 
 /* BPF_FUNC_skb_adjust_room flags. */
-enum {
+enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_FIXED_GSO	= (1ULL << 0),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV4	= (1ULL << 1),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	= (1ULL << 2),
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 5e38b4887de6..db2c520d0e92 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6209,7 +6209,7 @@ enum {
 };
 
 /* BPF_FUNC_skb_adjust_room flags. */
-enum {
+enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_FIXED_GSO	= (1ULL << 0),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV4	= (1ULL << 1),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	= (1ULL << 2),
-- 
2.34.1

