Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E7D3D301E
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083437; cv=none; b=BpvEmi2p6ZyS3r124zDpwWsRW52O5Sa62EiAeWoY3ePKHY96XYZ/aNEBSLZe/TiFf2V0FMEUSVo2Vfy3TcU7mX7mFAW3jj52hrODYeA5qlWbO56682r/wp4xr24VER4LNfDEeSdiXctqd+ps3fOj9Qufwxp6ZO3E/PHTbpOSCb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083437; c=relaxed/simple;
	bh=GpTwx44bnp/GS0QV1RDhG+3J34Ly4rJ87t9Avk8LOIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iCOClO8BHdivNWIogFwqsr94zMSd3iQcoCaBJQsu+NNFIR56LlMNrYTEr6COvy+7dbxP4eBoesu7yfytat28pQ3lxc2vky8wPc0vWKO3CTzE5o4q35H50pmH9fUkKwUsu9ZttO3tsF/7QTCCfLgDgEgUih76hsG9o5vCcKU3UE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p3ZdnqlA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p3ZdnqlA"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636IBYl2062750;
	Fri, 3 Jul 2026 12:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=rLZxc+dkPTe3xe+eZJ3bgpfKnR8yGhLKhzzPP7vAm
	og=; b=p3ZdnqlAgL1pYwNMcEF27ApenuAGZ036QEYXr9Qr5I19UpBwwHfa0mk+D
	s0DDAg9ccZCuaaa8PyIBhrmUV9oVQ7XQh3/0CHm4OUCySEX4Zi+UDWo71jBinrGs
	LN7oXlXdJSfbK27FSpB5GVZpxBJ4yRVi2up5DxOo9IgYa14LP+jFhTMK72TfYY74
	Y4hWIt+Datvyp/EHxNHwU20Ri/cHzRgOBayyHvpo793TU+Zk9BmPMXMIiJN6Nmks
	jV+1ui3EXtl49NVdBFMOJoJQyrHXshfyqbQYfXPW9xqIg93oJrK4QbpbnDPoWusk
	5blqG81KZv7ozYV7wvA4xJe3v7rxg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qgfaew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 12:57:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663CYZsw013662;
	Fri, 3 Jul 2026 12:57:00 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2grs0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 12:57:00 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 663Cuxvu26346076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 12:57:00 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 979C258059;
	Fri,  3 Jul 2026 12:56:59 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5838458043;
	Fri,  3 Jul 2026 12:56:57 +0000 (GMT)
Received: from thinkpad-p1.ibmuc.com (unknown [9.111.50.198])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 12:56:57 +0000 (GMT)
From: Maxim Khmelevskii <max@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH bpf-next 0/2] s390/bpf: Replace ly instruction with llgf
Date: Fri,  3 Jul 2026 14:51:34 +0200
Message-ID: <20260703125648.919196-4-max@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a47b19d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8
 a=34I9uxCqxmYQNM_E3G8A:9 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEyNiBTYWx0ZWRfX0l3Tuc0cILIi
 vD9IwliPoMR0sWpgjKIma/MjTFDCUqZta/e5vNo7J0kPq9Ssi5gzDzN81SEmXooLUAiEDzJiyXn
 0gghwoqGLJGMND+r6TciJ1p/pzY58No=
X-Proofpoint-GUID: Ki4XL5u4V33xaZhIYz1uVJG3K2xOW0k1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEyNiBTYWx0ZWRfX4zR2vxwEMq2R
 BMkU4Pu0/si23bDF93Ic+ri0uavRk33IJ0MRUMNO1sYwk2ZVFxpfTQWnNRxt0+o/wTZ0k5nWhQA
 YvzN4ZhpziHynxcRfm2J8ayDspUxDcXrE1kCHs6o3atfQJJvdhgeoBcHEWpSdqtzUcMGN4j41bv
 PHSrE+T5YrcT+OK0LEh1UWMsSSTTmQYJoiQP8hVh+cj1micOwjpdoR9IH4dAke7QdmPMYS4rVDv
 u1JuNM/39+SwVXo8CojagkXGOvSBr8NvHGzDPss8nOdR2tdyUcC8yFNcZ4/nAJjbUE9vTIscm9N
 +d2gYoJcT7vf/gkkrpN8gPU0kz3gDBtnZlQnG4OGPuplsYNHA/XZRJkLtk7L0peuClkte3V0+7q
 EnbmYai7JRrIAtQVJovn840KclKx/Ebg/FGrZOJ6VKl2m7oB6emLRT1y+takZD+luC6TL90yC8i
 cbedcfIv5+gWBeCkR3Q==
X-Proofpoint-ORIG-GUID: Ki4XL5u4V33xaZhIYz1uVJG3K2xOW0k1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030126

Sashiko found a bug [1] in 9012cf2491e3, where upper bits of a 64-bit
register are not zero-extended after ly instruction in used.

Tested:
  ./test_progs -v -t get_smp_processor_id

[1] https://sashiko.dev/#/patchset/20260414142930.528751-1-max%40linux.ibm.com

Maxim Khmelevskii (2):
  s390/bpf: Replace ly instruction with llgf
  selftests/bpf: Add test for bpf_get_smp_processor_id

 arch/s390/net/bpf_jit_comp.c                  |  4 +-
 .../bpf/prog_tests/get_smp_processor_id.c     | 45 +++++++++++++++++++
 .../bpf/progs/get_smp_processor_id.c          | 20 +++++++++
 3 files changed, 67 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_smp_processor_id.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_smp_processor_id.c

-- 
2.54.0

