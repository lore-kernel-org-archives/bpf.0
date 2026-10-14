Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63462417BD2;
	Wed, 14 Oct 2026 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792007253; cv=none; b=YWSQGia525AwHC+TMiRmdgBESwwMsgmDRWbFjnHMFIAHX4ncZyzhlWHZgigTcis3JLvSuC6pZ6lNOrty+jtd9nH8AOi5/ULUtL/LhevwDQLlLDzeELqAZviIGnyMFVQotfnHH9I6qXu1EqJvTCRea58mNRd9cVoJ7MlPetrk3X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792007253; c=relaxed/simple;
	bh=yYvRJQWooZPkyh9026YoIQwZ3ItaEUGQX0mfusD29q8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bZdfjwk+ZuS1BxhAVd5V4Tf0sTo8y6Y2Fw9y/HDhUpkWzbCED5VrbRGFgCYA3taaFlwjOQlRhQYJckQhXqDfyhkZ5vxggI1D9Pn2AIAnpHuAvECDXEqKzRVqpxnNEIFc0X14tOOP3x1XVY9z3FW8B7Cbq1AGXU+SJPN92UVcWYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=YSvAytu4; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="YSvAytu4"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EJjIcM1792058;
	Wed, 14 Oct 2026 19:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=V13y94AcoZxdA
	Vvt6ubPxV3JNockmJO2nu+raArkXRo=; b=YSvAytu4sB3JeS4AuJjMlUCNY2wQc
	8FrEVswUslv351PmrW0umrtAAbMBK/SXwm2nNYdnbdfyJn+XDnaPOQM7rGQDthI1
	51pE6efqZ2PiR9GA5A+25mGim67Z71QRJfGsBuEJnkcXW+eN+uyPcbrLa1ymcq89
	2TQ0IPjAv1rYdlre5z3wAlDHmOm7cWXZBPl+r8+PMy5LWwlVm+5Hn4fduXs2YMod
	R54byYRzzrHr9ObV8FaTzbUU+LoccKZf538q0lbSkuikUt3hfjn3uVg9kvbNGQlg
	4LV76C2vVAAGJC3RRcMHVQsK3FVWHi5vBooQXiw3ryWX5O4GXui6yO9sw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4h9ytj3e10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 19:46:39 +0000 (GMT)
Received: from LL-DZB4774.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 14 Oct 2026 19:46:36 +0000
From: Marco Vedovati <marco.vedovati@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song
	<yonghong.song@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        <linux-spdx@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-open-source@crowdstrike.com>,
        Marco Vedovati
	<marco.vedovati@crowdstrike.com>
Subject: [PATCH bpf-next] tools/include: Add Linux-syscall-note to uapi/linux/types.h
Date: Wed, 14 Oct 2026 21:45:16 +0200
Message-ID: <20261014194516.3030362-1-marco.vedovati@crowdstrike.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH014.crowdstrike.sys (10.100.11.87) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-ORIG-GUID: ZE0_nQZ5oiM0X2zxo2-YbHoObRN2WX-b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX5365wyYRk/Ls
 KH3hgpBDFLy/7W4JLD2nfOpE+S8Ll5gBH9TLop6Zh1b14wflRn5QeyS1XZFEGjLoBEiqrmQ9/3/
 5Vdz2u1Tmx7pFmIBuYgICFc5j1ony6QN4bcMURQ0vol5Rj5HrS34e2oVa8k+CLpwMMe5tx0AvFq
 2V2Wb+X2bAJihwb+ZBm7R+cj96MvYL1sWFt51Bdzjd/uWAwiA1uTkQH6xgBXRg9PmVme4sExGZz
 e85/Z27jakSlrzQORvYl7gRwHo+46L3OtKCXZSV2J8lv0AxZmOZ/dCtkA0YQyU97jEOYndgBonr
 0C7cB8daVvDAivB80GSOSEvcErbEK+chmPUlz1h8iM57GW2n01X3mK3rxHyTOHvOmdBQg4NcOVj
 GTBxVcVTMwzSpEH0kenrEenxaF08ZfXviTd9pOH9vO1bAVKAw9/q0gdWXaKRy4xPEfUKmop832n
 oAgmJdvySU8thFDjSCg==
X-Proofpoint-GUID: ZE0_nQZ5oiM0X2zxo2-YbHoObRN2WX-b
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX3STbxRgO937N
 uMrFG1QWbR4Er7urnEWa813YkwWLPzH39xNsu1/07kPxwqHzLVD8lJ5x3B1uxkPk1/z84H63s6P
 iCnFmi8Rc+OqZns4EwFHhWmWb/2Z48i1zy9yYjvyxsGggcyCCWaN
X-Authority-Analysis: v=2.4 cv=U9wHnuru c=1 sm=1 tr=0 ts=6acfdc1f cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=pl6vuDidAAAA:8
 a=LSAfqMpvtffKtK7BL-AA:9
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11935
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 impostorscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140078

tools/include/uapi/linux/types.h is the only header under
tools/include/uapi/linux/ whose SPDX identifier lacks the
Linux-syscall-note exception.

The file was originally added as
tools/testing/selftests/bpf/include/uapi/linux/types.h by
commit 0a5539f66133 ("bpf: Provide a linux/types.h override for bpf
selftests.") without any license header. Then
commit 579f1d926c66 ("selftests/bpf: fix broken build due to types.h")
added type definitions copied from include/uapi/linux/types.h, which
is licensed under GPL-2.0 WITH Linux-syscall-note.

Commit b24413180f56 ("License cleanup: add SPDX GPL-2.0 license
identifier to files with no license") tagged it GPL-2.0, along with
other headers under tools/include/uapi/. Those other headers were
switched to GPL-2.0 WITH Linux-syscall-note shortly after by
commit fb7df12d645c ("tools/headers: Synchronize kernel ABI headers"),
when they were synchronized with their kernel counterparts. This file
is only a partial copy of include/uapi/linux/types.h, not kept in sync
with it, so it kept the GPL-2.0 identifier, also after
commit bcd66b10b5e9 ("tools/bpf: Move linux/types.h for selftests and
bpftool") moved it to its current location.

Use the same identifier as include/uapi/linux/types.h.

Signed-off-by: Marco Vedovati <marco.vedovati@crowdstrike.com>
---
 tools/include/uapi/linux/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/types.h b/tools/include/uapi/linux/types.h
index 85aa327245c6..6acf2059085a 100644
--- a/tools/include/uapi/linux/types.h
+++ b/tools/include/uapi/linux/types.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 #ifndef _UAPI_LINUX_TYPES_H
 #define _UAPI_LINUX_TYPES_H
 
-- 
2.55.0

