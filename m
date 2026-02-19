Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2FA33D4F4
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771498851; cv=none; b=PArU37P/Md7LTHsbH7uTa+KHv9+w+23yVH8kemVy9qRcZOnJ3VAnhcyWaFYbcBFR5DSpQ76weYybynhbA/Iuy5SMJGkgG1Dc3q+UJQwQBfi6shPBCLiU81UEb7+LGjt6L1UeA3uPywa8hupSWWj+Cteo91ihEFMbbRCfTgpeHGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771498851; c=relaxed/simple;
	bh=6TkhN5NqATbiLN/OPtxZbdwqQZ07po+yoP8hH+YHXnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aMbWyHDGAmVOVmYi2RIlJ8DUHSyGTD+/qibdWWYEgkjRg2xPqjv5o2i66oDla0GpL+sJQYhqOeO3TsklLBfgcy1kcCod92nPwIJQ0pjmYsgmZmRCkX0G6KcU8p0rGgN1I6/pJC4EU+zbFsYR8Yhxvg543P13PIYkhbjGNu0l8v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=cqRIlsoL; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="cqRIlsoL"
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J3fFbl2889599
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 10:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=jan2016.eng; bh=2M/EV4v7N6rZb5KoktU+kgXwWRdlv9UCf
	KJPGqhQuM8=; b=cqRIlsoLQ0L2C+erax2mrU/45ALXLjSX0WiZ+7+XAO6oxMvwt
	B3bK1GHYZrQinJyMttYBMWPolaCt4flXaxpQtNmWW81wupdQqk6jhWVq4rIOt5RU
	vHK6CgVIGoHvOxfJRkM5C5DMvovyS6XNh87EHjMK7j2Lm5Mt3fQzLTFkj+V8/lMb
	Zf2grWunllRznODdh6iPIw68YaH3qY4153Wn4BvXkjNtFSEwz2ZJbkweUePK1PN1
	zHSpqqIcflJQxlbfJ54nef8v2kHgKn2pJNnClgd94HlTNDXA4UvWgM05nU7FTuy6
	PoKRt4akwb0fb5zyERYu6qJE8QAekjqPAKN2g==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4cddy4xkg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 10:47:14 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 61JAXqWV007049
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 02:47:13 -0800
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 4cdx0vgq9e-1
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 02:47:13 -0800 (PST)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id B8E7583;
	Thu, 19 Feb 2026 10:47:12 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: 
Cc: Nick Hudson <nhudson@akamai.com>, bpf@vger.kernel.org
Subject: [RFC PATCH 0/1] bpf: Add tunnel decapsulation and GSO state updates per new flags
Date: Thu, 19 Feb 2026 10:47:08 +0000
Message-Id: <20260219104710.1490304-1-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=482
 malwarescore=0 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2602130000 definitions=main-2602190097
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA5OSBTYWx0ZWRfX88wihQEv95oF
 /cLYKFO5TY1X14anargSrbz3jhwkAWLdSYWY68cXC098z2RaFQxGGkvEnj7TkijxN1UFbHeerrZ
 xgw/m1V1ZI99dY2UqxQhm+uT3L7gO3Vbf8HKiBgqsygXCXtbq5Bl+RIYcEcmwopMMzWxbj07myv
 HzrAnXScRYXtOycrbYEEGMQKczOxmjFhHNTqpfsIKlOHlXIbdQ20aVwlxcKZm/1X1hlu4E+dMCA
 TKeGr+nFGZUqS3UagZR6RkwvXkYQ/eZxF0MhiTE9YXG6k5KXxjYNZctLIgbzEysCUuGDsfmSEen
 W8OOYzUxI0aOAE7GTu6JbttrCr/5Eg1sPAU4Sgcd0XYzMEBU7rdB34ldHf0BQ1uUh1WYRyRWlYe
 hF0HOJE8bd1KYpGSWhATR4bUcXSf0gT2MMkFMWoHNCIQh6ZaloI1KhKHTsPVRICXUukqfVb0urB
 6DpTAHlYL9/75aQdayg==
X-Proofpoint-GUID: mxkRG6Xwb6JdDLjQEc0qbw3qvuK1EYeJ
X-Authority-Analysis: v=2.4 cv=Jf+xbEKV c=1 sm=1 tr=0 ts=6996ea32 cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=ZpFju03vS2hPCBZZSwIA:9
X-Proofpoint-ORIG-GUID: mxkRG6Xwb6JdDLjQEc0qbw3qvuK1EYeJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190099

Our use case involves a BPF program that removes VXLAN headers from
packets that are subsequently forwarded via a tap interface. The new
flags allow the BPF program to strip the tunnel header and selectively
clear the tunnel-specific GSO state. This allows larget packets to be
forwarded without segmentation through the (non-robust) tap interface
for the decapsulated packets.

Nick Hudson (1):
  bpf: Add tunnel decapsulation and GSO state updates per new flags

 include/uapi/linux/bpf.h       | 45 +++++++++++++++++++--
 net/core/filter.c              | 73 ++++++++++++++++++++++++++++------
 tools/include/uapi/linux/bpf.h | 45 +++++++++++++++++++--
 3 files changed, 145 insertions(+), 18 deletions(-)

-- 
2.34.1

