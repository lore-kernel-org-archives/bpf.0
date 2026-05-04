Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896363446C0;
	Mon,  4 May 2026 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884150; cv=none; b=j3QNMZNWgsWMR9Qw14QfnjL5L29c8ZgTMteGOuSR0NICI/6jqTcVDuAcBVTY/dBcKZUyrYXPJujr5/o9AxWmR2Dqkhl0r7K106cYm3xtc3ZMfcRqpOaslKhp2DNmq9F2Ew1dmKBJw2tUr69Fc/qtmfcCv2ZHjpAOH0u1llRQXYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884150; c=relaxed/simple;
	bh=MxZyxmuXOA5R5x7zMlhVQs1yDcUAcMFxNU48wUisLC0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=CRGkZ8BYmsi651+oicuNbZ0knZp40M9N9I7EX+tEXmJ851uBSmwuZPwo/INlClsIyJCdolX8RUrSdFSm3tmLMchYknZxyxo6kxYydevePjOjsnbbBFRWq42klYHUowT5Fz4MlVbblV4jfb7YtuhImAxk8pVi2gDJnBUeK0GQ45A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FtQ7uXFL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FtQ7uXFL"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6443Qx0D3769724;
	Mon, 4 May 2026 08:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=HcLqKW1LPdShwrJ53be3nTSoauY1
	L/oc83mlWkZIFNA=; b=FtQ7uXFLiAnTrzqWJwML4ufc8KQYP3gftkfR9NBwlVYO
	KrxGkzcw12zyMt0htGK9fHj+I5hOq2uhw9PV910DqHarZsOxqDqN5GmmhowHasNc
	OyhB989Qpjgq3WgBnUen8bJEyg7mkCydn5GDJzZBM0oX5FdJQb9n3SQZJAAoK288
	PHtQWFQs3ZqhQQM7j6QzwJ68SoUiPyEHQjAE97UaSPK2Q+xH6M1e3KKmeU9bCNvq
	2N40ONT+vy2cNTiMr0+LfZSB8HM40PcNttoO+mKoCzsTKKlsUEg06yr+u6E4Dil0
	9wKMIRupUz/0gsEY2Nalmiodis1eEk3lrflHE1w/DA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w660g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 08:42:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6448dQN8006629;
	Mon, 4 May 2026 08:42:22 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtg474y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 08:42:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6448fsKm29098580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2026 08:41:54 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56A885805D;
	Mon,  4 May 2026 08:42:21 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47AE858059;
	Mon,  4 May 2026 08:42:19 +0000 (GMT)
Received: from [9.61.252.117] (unknown [9.61.252.117])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 May 2026 08:42:18 +0000 (GMT)
Message-ID: <362eaba2-54dd-4b59-81f5-65abb916e916@linux.ibm.com>
Date: Mon, 4 May 2026 14:12:17 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [mainline][bpf] build failure: conflicting bpf_arena_* prototypes
 between vmlinux.h and bpf_arena_common.h
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69f85bef cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=NEAV23lmAAAA:8
 a=Twlkf-z8AAAA:8 a=VnNF1IyMAAAA:8 a=YpS5cAcgm0N0_-8T5d8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-74SuR6ZdpOK_LpdRCUo:22
X-Proofpoint-ORIG-GUID: qeXqwpzTW6JxWApumdjaFVfclh9k_hBq
X-Proofpoint-GUID: qeXqwpzTW6JxWApumdjaFVfclh9k_hBq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA5MiBTYWx0ZWRfXwgx6MUuZMipr
 2LHot8qENNDik5eDv75/+yQXETdG9t78RsnkXjnCygW+KNPTmM1W57egnILQ7NbM/U99bMmOMEs
 BjHu2c6XBENHPAk6nuH9XFMD0NmhXqqC3Ll8TBFGTKOoD89s2lL3ik3A4bbRQmiK1G7MbJjuJ7w
 OuUt1Uie8Hk07ZnhYtTyqVl56ItMgCg3JTfbskr5K36WaClosuoR3Jjp19WqWGyz1IOVPbEJjia
 4bMmsfwD7tVeNgsf+3FyLBWKQrAZLSQEInabXVt1zCbgEDhJbFuWtpKZuV8llgOink4qbhYpWla
 5dPhxJJBY/pdRxsSZmjvD0HgZ+gG6a2vJgGRihKHhubZvZ+VQ6mX3C4HBycBs7O9MEE8jTPVAVw
 x2m0JeW9VyMm0EZYANLZ7t9rYlVFUrYNfLFb4mdBxQPmBkG5yvkVakjjFzABPkA9upktbAjvWj8
 0mv+wHVKhKsUP7j++mQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040092

Greetings!!!

I’m seeing a CLANG-BPF build failure in tools/testing/selftests/bpf
related to conflicting prototypes of bpf_arena_* helpers between
vmlinux.h and bpf_arena_common.h, on mainline kernel.


Error log:

   In file included from progs/arena_strsearch.c:12:
   In file included from 
tools/testing/selftests/bpf/bpf_arena_strsearch.h:4:
   tools/testing/selftests/bpf/bpf_arena_common.h:47:15:
     error: conflicting types for 'bpf_arena_alloc_pages'
       void __arena* bpf_arena_alloc_pages(void *map,
                                           void __arena *addr,
                                           __u32 page_cnt,
                                           __u32 node_id,
                                           __u64 flags);

   tools/testing/selftests/bpf/tools/include/vmlinux.h:135295:14:
     note: previous declaration is here
       extern void *bpf_arena_alloc_pages(void *p__map,
                                          void *addr__ign,
                                          u32 page_cnt,
                                          int node_id,
                                          u64 flags) __weak __ksym;

   tools/testing/selftests/bpf/bpf_arena_common.h:49:5:
     error: conflicting types for 'bpf_arena_reserve_pages'
       int bpf_arena_reserve_pages(void *map,
                                   void __arena *addr,
                                   __u32 page_cnt) __ksym __weak;

   tools/testing/selftests/bpf/tools/include/vmlinux.h:135297:12:
     note: previous declaration is here
       extern int bpf_arena_reserve_pages(void *p__map,
                                          void *ptr__ign,
                                          u32 page_cnt) __weak __ksym;

   tools/testing/selftests/bpf/bpf_arena_common.h:50:6:
     error: conflicting types for 'bpf_arena_free_pages'
       void bpf_arena_free_pages(void *map,
                                 void __arena *ptr,
                                 __u32 page_cnt) __ksym __weak;

   tools/testing/selftests/bpf/tools/include/vmlinux.h:135296:13:
     note: previous declaration is here
       extern void bpf_arena_free_pages(void *p__map,
                                        void *ptr__ign,
                                        u32 page_cnt) __weak __ksym;

Tool chain Versions:

gcc (GCC) 14.2.0
# clang --version
clang version 23.0.0git (https://github.com/llvm/llvm-project.git 
bd6bfba3e50343c112a04b639394ab85be17c29b)

# llc --version
LLVM (http://llvm.org/):
   LLVM version 23.0.0git
   Optimized build.
   Default target: powerpc64le-unknown-linux-gnu
   Host CPU: (unknown)

   Registered Targets:
     bpf     - BPF (host endian)
     bpfeb   - BPF (big endian)
     bpfel   - BPF (little endian)
     ppc32   - PowerPC 32
     ppc32le - PowerPC 32 LE
     ppc64   - PowerPC 64
     ppc64le - PowerPC 64 LE

# objcopy --version | head -1
GNU objcopy version 2.35.2-67.el9_7.1
# ld --version | head -1
GNU ld version 2.35.2-67.el9_7.1


If you happen to fix this, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.


