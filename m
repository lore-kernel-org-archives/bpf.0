Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921984279FC
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545418; cv=none; b=YHrnb1bJpmIKgU9qzYp27ImzJyoYx/rEOEfYHsybvqOKKiu3NMsOzJeGdh/GGXevY+qw6mYQ7x4U2aPdFbaeksOTxfb6H2IZg239L6r/NLa25mZlYZDPAVBMalICEO9H5+dN/AVZeiXTfQq/d20S2u5Lz61QhL6s8K+rNS2s34g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545418; c=relaxed/simple;
	bh=23qdAFPsdWwVZZw6p6VeCfNYaCjSPtGlUouZvi1h/Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVepM9+7IkgmyGMCtXZpia3Q8o0oEYD/9F9ZgVOpOSBEOPKGCze70ohnQ95Glj6BjWzXVjmbydVYqEelI5ege0XU8F7vPRlliy0cfErRx/kSlTmJ7JsXOt3FnRpq0yTD6amkhwj5aeC4b74vmtOvOs/xORph1TkNdgKQLye4C4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cgGl4+iU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cgGl4+iU"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6236pX0R1943382;
	Tue, 3 Mar 2026 13:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iI9XLs
	BxKF1pU4sam6F9+GLKbEwO8agz8U2CA2J372o=; b=cgGl4+iUIGIcRyPSr5C/rC
	nw7DYJ2svGWb7MjyHtNLwN605Fk2nqADv0YvEqJv346Lt1/bV8ryOkFX+MV7NYLQ
	PscPOCEArYgx53y+tGNWXlj2kT3Bo8rmHVmAJFHTWmOpc/AlYCD+UuD9GhXFWge0
	XHrfolTDRo+3ANVA8oHHxaXfoF8nQnch2Pg0Tc1PA8V8VrPPWSI/eXvzoeQhaWQZ
	efGGseEhkEMRZTwlA3X1OUxjyNSZuocJtu0XXd8MJbExcwu87lnwhray6JlFbRUt
	Zp9nFAVSy3odsyC+Hgiz6OiZjAWaczE3ll4PHOWwspOvmMxJrBX/BMH6W4puPltQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskcu5mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 13:43:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623APDXI016384;
	Tue, 3 Mar 2026 13:43:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmbpn2fc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 13:43:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 623DhFIF55443728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 13:43:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 872F220043;
	Tue,  3 Mar 2026 13:43:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A6BE20040;
	Tue,  3 Mar 2026 13:43:14 +0000 (GMT)
Received: from [9.78.106.17] (unknown [9.78.106.17])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Mar 2026 13:43:13 +0000 (GMT)
Message-ID: <30d026c1-5d0d-4679-95e3-cd39b670d353@linux.ibm.com>
Date: Tue, 3 Mar 2026 19:13:13 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] powerpc64/bpf: use consistent tailcall offset in
 trampoline
To: adubey <adubey@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <20260220063933.196141-1-hbathini@linux.ibm.com>
 <20260220063933.196141-4-hbathini@linux.ibm.com>
 <2f33ecbbe8272184111c5406d167b6b0@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <2f33ecbbe8272184111c5406d167b6b0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l8VTyG3UgxY0iVvA9BQnq-bN8x8KDGvE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDEwOCBTYWx0ZWRfX1ACPhmQcCAiT
 oboLBiA+Cq5tWxASWZaqkePBcKKpJ2UaQ7A9ZblPQmdqCKMY6yeBSK40mIEBT4qp+Ysk9Ojsw4c
 aMId/5GOGkZ8nErDbqMVoy6NUt6wrfM4jZBoydYdWb+fa3FAQ1C6hdln+PuKi2vr7vuqiP42Fvq
 +d/BpneEi3NUJlBMhSLm8MlE86hUNSKpGLWmnqVuSWsOFMKNujoqM5iYZbJD/NwjcDjblKEryLV
 Fnc69W3ZpSzQ+VUcuf7nUN4ZxEe1tvfaSz9o3/5AisE3r3mmc8xZZhrDRRQrLAD22Is+SJq1ORK
 QbyPRnsp+J8+if+/2+pCbEOJUOAcx6EWI8+UbrRKFD/PuCyjstohZCwOCQVnRrOVEm2j/D7mxto
 vmaV4Zhm/EOPqPiTP40jJ3jWwflPuCvC1d8uzAT+r/SRXxCAKPURPpl8oG7PyuHIo/o+/5P+9W+
 0SnCjGlt2rk8EKuuL3g==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69a6e578 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=hklsHozHma9wGV9YwB4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: l8VTyG3UgxY0iVvA9BQnq-bN8x8KDGvE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030108



On 22/02/26 6:37 pm, adubey wrote:
> On 2026-02-20 12:09, Hari Bathini wrote:
>> Ideally, the offset used to load the tail call info field and to find
>> the pass by reference address for tail call field should be the same.
>> But while setting up the tail call info in the trampoline, this was
>> not followed. This can be misleading and can lead to unpredictable
>> results if and when bpf_has_stack_frame() ends up returning true
>> for trampoline frame. Since commit 15513beeb673 ("powerpc64/bpf:
>> Moving tail_call_cnt to bottom of frame") and commit 2ed2d8f6fb38
>> ("powerpc64/bpf: Support tailcalls with subprogs") ensured tail call
>> field is at the bottom of the stack frame for BPF programs as well as
>> BPF trampoline, avoid relying on bpf_jit_stack_tailcallinfo_offset()
>> and bpf_has_stack_frame() for trampoline frame and always calculate
>> tail call field offset with reference to older frame.
> 

> It's good to add comment about padding field placed after tailcall_info
> in the trampoline stack layout. Visibly padding is following tailcall_info
> but tailcall_info is bottom-most field. Clear comment around this
> will be really helpful.

"Generated stack layout:" does capture that clearly. Don't find it
relevant to explain it again in this context..

- Hari
