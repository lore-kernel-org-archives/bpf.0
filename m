Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.152.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313246;
	b=AV1abKBbBEtz/coQ2hiZ50zmxGmUtLuGCT42h1sS7ZcGF8irqqHXvW8UKAI97mfUrtNW
	 FJmf9qHuE1hs4U0KJc7TUDQONOZApAjTdiP5nJkxryFkYl1sT9FiY2VF+ZxXkxSXASlHF
	 M/5hOQ9EU53366zSlao11M2DTNUXl8OJ50nE3ich+ltHntXEgvGcpdVbLlW/CalbiGbeG
	 j8i4t7zXBPrpevnVpwMtyVieSSLk7gIQvIITEU0IHjR89oYnwaZu5KjEtGt7aOrYBVBMs
	 WvU8SELzT74EYvHIKLoHlHM9GciP93lJjRE1WPm+LfowNRr9hkVWFBZKbf+M0rxrUxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313246;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=UJWPwNKtGiCZj1X2hJ2nZgMG1fzERRtv7qWYjsCeSYU=;
	b=zSEibTmev4unJGV0WJpJ4z7J3SQsd8DERwVsW0Ec5z8QeNpz4jxhRNP1O+rGbvXcWYtO
	 nnhQ+mzn3qF9FQtIsW5jQzSRgL4dgUnHqF0kDbMXgo4NsD6VgCpP5miUQOV3bnUPEYpX1
	 Ndc4bpzfr+QWp3tkJfGK0KTqtlE9ZbNikaSw/oJ04oLi9bvF0s5KoGBDOJehS1NMwb2Mt
	 /4M7okBefgfTLVLiWyGG6joq8KmIohZeZV//6Qmc8ac7iASikf3x0qcJqjWuLg7zWXgeK
	 DJsek3lQeXvZb+6HC3aGnPwFq+3rDOoz4scK9leNCEv6CIEc/JA4Wpc9lepZYcQVa7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=XXIMdjtz;
	arc=none smtp.remote-ip=148.163.152.16
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A0C606A326
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 22:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1A0C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=XXIMdjtz
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TLXeLt2716451;
	Thu, 29 Oct 2026 22:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=UJWPwNKtGiCZj1X2hJ2nZgMG1fzERRtv7qWYjsCeSYU=; b=XXIM
	djtztOuHxmmT8ZELkUK8lN5s2ilJ8bNJGE+BNO45RoXcQAdRa92ncEybCXVWTN8e
	VvaujEAsh5ukAwdrBMAOzCrXTbvZIPMyQo+ZG/BoPpp8g4fb4U0tmQdrlck+qwxA
	BzexNpbz340lzh4892r3Mtxobm2mv/+3BH2ZCh8yjHBGsn4alQJa+P4SuozH3oKv
	RxO9cZRqUjsemFXmrS44djADbURg3N1AVFtXC86I49BESAqkEleu9rFx+yEtqFS9
	u1LtfKckumEJJhNnttkhHvdd4Dn4rCpZ7zkyTRrV9xOGgeb1+REgjCVheutwmrz0
	UzipoUv7gdf7i8Pozw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hme5n85h2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 22:33:52 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 29 Oct 2026 22:33:50 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v9 1/7] libbpf: Reject gen_loader set after PREPARE step.
Date: Thu, 29 Oct 2026 18:33:42 -0400
Message-ID: <20261029223348.3730738-2-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029223348.3730738-1-andrey.grodzovsky@crowdstrike.com>
References: <20261029223348.3730738-1-andrey.grodzovsky@crowdstrike.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH012.crowdstrike.sys (10.100.11.82) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-GUID: QLxmN_r6j3UyySoh0BRJqUtE6lsLc0HN
X-Authority-Analysis: v=2.4 cv=F4zC5ahN c=1 sm=1 tr=0 ts=6ae3c9d0 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=JR1emnCqaZKiK-aq2YQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA4OCBTYWx0ZWRfX+n8fUIab11Vf
 3jgyWl75AKT9mfNId28dk+3e192JaZLlEDiHX/d2O5zrV3ZgYsB8JMUCd59SBMjwCg9WCz0FwDP
 itMEKnm8doNss3bSh7PvxssAW1+sycFmkw0vp+waERff3LeHXKGeLCfb2tAK8qWFAHAGdGjwuQp
 dzehHPzMw+KHm6idzinjR+5Wxn0WmXiwUsD1N6F6RNDYv6lg5lg+iFtRBT4icg5PmofAQoKEHfw
 xm2ZuU+fdiCNOEeF0DbqgBKK8g5fJMh4BSwEUJ0IvIaMtauzeqSRkrQOPYyCwdAEucD/jT8BBt5
 0lZHiz1y/AFBi0oeNJXi8lO3h1+n5VHypEae+U9smY4hFr7Y3wrUlIEvB8BO1ZhKwiP6bDl/yBq
 QVkBvd+1M1BkntFFNGn40btNtRNC9OGZY931hTK5cwoDqYA6JgKM+JrazhGQdnZ7765XwF0T2a/
 L0pHYWccJQ7VisSa24Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA4OCBTYWx0ZWRfX28GS0vAfdiKX
 pYudAhTBep5Qg7yyEoiq1snFBj3W6H6ro5Mt5eZqeOyELCFS+BgG8MYBh1pnm1iyAhX8yxb5zDZ
 jF9RKQzr8s93AcsLu6LXLQZCsZDYb4jNX6BOox3V7RALu4GzKseG
X-Proofpoint-ORIG-GUID: QLxmN_r6j3UyySoh0BRJqUtE6lsLc0HN
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11950
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290088

It's wrong running the loader post prepare because
gen_loader records the BTF load, map creation and extern/CO-RE
relocation steps while the object is being prepared. If it is enabled
after bpf_object__prepare(), those steps are never recorded.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8fcb8cf39cc0..6bb5887090cd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10698,6 +10698,9 @@ int bpf_object__gen_loader(struct bpf_object *obj, struct gen_loader_opts *opts)
 		return libbpf_err(-EFAULT);
 	if (!OPTS_VALID(opts, gen_loader_opts))
 		return libbpf_err(-EINVAL);
+	if (obj->state >= OBJ_PREPARED)
+		return libbpf_err(-EINVAL);
+
 	gen = calloc(1, sizeof(*gen));
 	if (!gen)
 		return libbpf_err(-ENOMEM);
-- 
2.34.1

