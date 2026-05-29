Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B0132B9A8;
	Fri, 29 May 2026 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062372; cv=none; b=qb0cqkfs8TW3qEIhqN139R/TD8aTJG+8BX8RH6KpogLwxeWpWq+o1X1QpIoZJB6pLPE+IWk0OwavMwN7EqCSWQUGDRtaq2i5399S3KE/vxxg89PKg9ToV4WIVEG0HhAbjNAVWQ+e7Yfw5ADTXm01miL2WSLe59YtXIYKwJVmU5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062372; c=relaxed/simple;
	bh=lT2nvVWAW+jmcHfLSb8VHUm48u54E9R6pcLe+cKiLpM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=k1p6sFBUSC77jDPWkGTZYA0hNgNeKfGDFRMyM1jzv4Imka19iQGp0aqdkX3SoIaFs8JHyyAvacu6LEpyPICFpc2ODzhpzy/oyT00bRHW8o+i62z/QL5ULUF9ub3iZ0+SJysSNpfkMskE+VBtZ/8/TAcxlcX4oTzVKu/XjYJnC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gnSJsILr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gnSJsILr"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TArrCt1467901;
	Fri, 29 May 2026 13:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=lT2nvVWAW+jmcHfLSb8VHUm48u54
	E9R6pcLe+cKiLpM=; b=gnSJsILrbaUM37+CbU4zl3Ik/2dTHQR7sd2nA+g13MHx
	fiC4RHJg4TLfW4kOdozxPIveJXBABOxlbrzxMOR6CJNIut4qytCONL2sjDLX8u+m
	zlKuWQmyaTELgietBveC19g/Yxb3f+Q1TT7oYZz89EUPX1h7uU70aB93Cg/pbzOf
	ROYo8XUNjxQ6FGCNXcrd6WcNAMqJAeUJubEBTNjP61XNeK47X+CXxShUgV0uJUAd
	TH7JGB6XtGbO0xZ161jaJlyFX43QWl6io3ry5JouJTnX0gWIZ1bhiSBqEaGe5xpO
	JfrZD1q77wxatsv58ZU2RrSI7QiygwLWvLawC8CngA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee886gxtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 13:46:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TDd5d6008963;
	Fri, 29 May 2026 13:46:05 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbdsqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 13:46:05 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TDk4Ug22872786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 13:46:04 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E024A58050;
	Fri, 29 May 2026 13:46:03 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B002A58054;
	Fri, 29 May 2026 13:46:00 +0000 (GMT)
Received: from [9.61.247.63] (unknown [9.61.247.63])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 13:46:00 +0000 (GMT)
Message-ID: <b18f42aa-9182-4bcd-8b98-6255dadf7d5a@linux.ibm.com>
Date: Fri, 29 May 2026 19:15:58 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: bpf <bpf@vger.kernel.org>, Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [mainline]selftests/bpf: task_local_data_race test crashes on PowerPC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B2nNU6B8nMxCW5yvfKlamJx6nrcfu_BG
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a19989e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=wbOSOQyIEbtBsbREJHsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEzNiBTYWx0ZWRfX0jktDWc09TsF
 UoJx4pS8NgU9G4iRzZk8Bvyecxg4cq28mGtovWgSlCxBXSbzSiqdI6wHo8EDWxWwiB7wY4xyfRu
 Swupn8VC9KvZUtd5CEjLfWAwV9yzRmMR2Cpvu4a+GMiaTRnbpZDMK2CFDfKzA9rzGRmGgf/1tQt
 WkZZ+psK/+yoeyg5OPPobzzsaAvoqTzpW5/TeSmnvIJ2fz9GGgYEDb4nr1AwdjRH87posms2+iE
 Fy5gkG0PhdIW3YAmEpaE0o07+dK1FZsjtIFaBocIu/DwMXI17eMpb4n1Ni0bmN+OdfXFnmtBmxR
 RSH8UdiHRZFTWWUqBmz0nHf5feflsw4cFl1SN5FwoiYos9kBeoClinik+HPqmsLKIShPXWUltRh
 bUTjGtykEeVlEbvID4obqvwTIiFGWZpmysQ7GwINecChZNaAGM4AUFzUjSA3ZBbia63PBTY34f8
 2BnW+ei0bLTAdUbVwPw==
X-Proofpoint-ORIG-GUID: B2nNU6B8nMxCW5yvfKlamJx6nrcfu_BG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290136

Greetings!!!

The task_local_data_race selftest crashes with segfault on PowerPC 64-bit.

**Test Failure:**

#466/2   task_local_data/task_local_data_race:FAIL
Caught signal #11!
Segmentation fault (core dumped)


**Architecture:** PowerPC 64-bit (ppc64le)
**Kernel:** 7.1.0-rc5-00149-g8fde5d1d47f6


libbpf: map 'test_tas.bss': created successfully, fd=7
test_task_local_data_race:PASS:skel_open_and_load 0 nsec
test_task_local_data_race:PASS:calloc tld_keys 0 nsec
test_task_local_data_race:PASS:TLD_DEFINE_KEY 0 nsec
test_task_local_data_race:FAIL:273
Caught signal #11!
Stack trace:
./test_progs(crash_handler+0x34) [0x106b5874]
linux-vdso64.so.1(__kernel_sigtramp_rt64+0x0) [0x7fffa4660474]
./test_progs() [0x105bed50]
./test_progs(test_task_local_data+0x64) [0x105c0094]
./test_progs() [0x106b6064]
./test_progs(main+0x7ac) [0x106b82ac]
/lib64/libc.so.6(+0x2b224) [0x7fffa3cfb224]
/lib64/libc.so.6(__libc_start_main+0x1bc) [0x7fffa3cfb47c]
Segmentation fault (core dumped)


If you happen to fix this, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.


