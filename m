Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311BF34DCE0;
	Wed,  8 Apr 2026 04:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775622520; cv=none; b=D95fmTc78GhZS+Q0rD7bJsQOceyca8ImxV/RdY43ZrXP4JvGoQCE1/WUBZYJ9aKa8wn2aZ4BDurwp3rJ80JZmODTTe5567HAks6iXnf5RoAFnNUPJlhoFCCDWp9tKbx0yNCEMFDl/aWZ0QgT47ypkzTPrCVCy8WSSLseina/Kf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775622520; c=relaxed/simple;
	bh=iyQopdPCNdHCZKJPXOUMoExKjslCMyuA+ZQssIf4Oyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBsDThwlckt9cgbKi5PSAURo8TNdLcNxgaNvuoU1eV2tuURYAWfwW1JLlk5SCLiBDZOjc52MkOHi/itOX02IBlNj9YiNfvVgRCV2YvO1O/EyUhTQqx//V+6fBxXf9nS2rC5Y2YDlh7ogu1cKuDkX475P7KBK/+fRV/wo2MKH7RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IK9JjESG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IK9JjESG"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6384419A2297727;
	Wed, 8 Apr 2026 04:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=o8rHui
	c0PhX8hjUGEtYE9ZcgUfT+BN1KSsR4UDkv5rk=; b=IK9JjESGiuUV6NWZrN79l0
	dGubO1zgudhr+8yZS56GiVEi56EmQpcDSOgn78KZfEcOQLjweNWA1WXprC+xYFWk
	lzNCkEAX6olItHh/4oZ831tdYFPnBfdEj4n4e5nNan6Tri6YHJcG5BcVlnH/mUHD
	VuW338MQfY/pEgcfMfdRC/TE4Yn0kuOLgAKlp65dUanfjtxEmSQegZszYxGStI+p
	bGCG3/ok2+QanGKpO9JWkUjdeYD4wS1+OxUv8jAWQHFlKaIK1EpADiHwFIhrgqSQ
	SXLACHMro4SGvJu7TbLONAi7qD52zZ22h/W8NLmOY6wABQciRgIz53WwhGiNatXw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fwrre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6380MXsb026661;
	Wed, 8 Apr 2026 04:28:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg7wy0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384SHZ745089264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:28:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A66320043;
	Wed,  8 Apr 2026 04:28:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0E5B20040;
	Wed,  8 Apr 2026 04:28:14 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:28:14 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, adubey@linux.ibm.com
Cc: hbathini@linux.ibm.com, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH v7 1/2] powerpc64/bpf: Implement JIT support for private stack
Date: Wed,  8 Apr 2026 09:58:13 +0530
Message-ID: <177562236435.1381144.14761242301174081744.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401103215.104438-1-adubey@linux.ibm.com>
References: <20260401103215.104438-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d5d965 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=c4pk_TAjE7_yaBmCtEEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FVHN14Ku_mOeP_4FgGT6mPb5d7fNqbnx
X-Proofpoint-GUID: FVHN14Ku_mOeP_4FgGT6mPb5d7fNqbnx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX78ucmViPT1i4
 zl7C/iYJnuR7fKbz2HmDnyObajcLWfbrVe8hoadygD6xGougKOMv0BcRs3mfsW1QXw8QlcE1ETm
 fGw417V/fzMsqRs6bfX8s0dQAtX+pDE6e7qH6THjwjHmJIzqWg9eX90qxN4muAVzNr3swPx1gR+
 LjVYzLE9Ywm3lHsFfO1Q9yOBWKzRluxBGIl0iX2kYfO86QASf0koEeO0NZH6SkcfKKScdbI3HbD
 pk6GYpXcbvH5Nz4mqE9dyIY6fx4h+Jez6Okb9YJKPyiosGQkBlBYb7J8mXBNYHJ4VbAdNT7HcDP
 xjJMyvcCFd4rrVtZj3PGVLBHP+4SGj+ltpb6pLBsuiuVxEeKf7UEJZ2tRtopS+WEZQT8FWdyuS1
 iSaV+oNx7xHdrQ07ql0dHA1LMj2cFcqSffRr9EnolwSCwYRg4EhrYwO1W+BxP5K5iPTJc2ongqT
 2WyRrvLiAhWXlajcN0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Wed, 01 Apr 2026 06:32:14 -0400, adubey@linux.ibm.com wrote:
> Provision the private stack as a per-CPU allocation during
> bpf_int_jit_compile(). Align the stack to 16 bytes and place guard
> regions at both ends to detect runtime stack overflow and underflow.
> 
> Round the private stack size up to the nearest 16-byte boundary.
> Make each guard region 16 bytes to preserve the required overall
> 16-byte alignment. When private stack is set, skip bpf stack size
> accounting in kernel stack.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc64/bpf: Implement JIT support for private stack
      https://git.kernel.org/powerpc/c/156d985123b6d6e5189cfd0286b93c12167ae798
[2/2] selftests/bpf: Enable private stack tests for powerpc64
      https://git.kernel.org/powerpc/c/e640bcd1bf83dbdaa967b20cd98a782d52ec89cf

cheers
