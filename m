Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA04430304
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784892173; cv=none; b=fOl4nNvbpUQv+h3ScGLTiK9+hwZmBBRrpjfx52mBjSuxqTLhzGIXy/EH9PB3DBWYYhog+dc4/5kqzDUZXqS/1H52W6AOXQt/hwRnCyFzzg2EX4kLqDiyXrnwF5ZZqHVMM2nheZpBYiv3pSMrCBmSQVLAJDUpD85n5a8AL80cZeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784892173; c=relaxed/simple;
	bh=WiZdMFhFBAYTnw3f4M3BhcU0ktVDWLr3gI0ZjUBJ1PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaeTWIr0vgV3i5tkZVYFasVDGCevHbltyN1Be7QXRZPOijrqhXEWdz5fsv4fnpCbnKRoM0MEjL0453kDCH46ZJcwLJvFwahZRHThDqc2xJqBasIE9cAhodfLHnid15F4i/7gxK53WGIonLKGJtRHRNiVSXayX3uQX2gGuMQUdL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K3+vctYt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K3+vctYt"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OADdRE1547287;
	Fri, 24 Jul 2026 11:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=y6G7ZiaqepnMc7NUg3jFk+LTHY9wva
	Lg6hWMr7bsZgg=; b=K3+vctYtvmdaYwMKQUbob97x/L9eZOqv5+R/chmAsPMkRf
	etYP/vDZ8BgBE68RNqu3GESR1DkHBa+ws6KSCsmJNU9jlhAH3K84LzLmr9jsAWu3
	gf4vV+j/WM72X4kAH4+aHhoZk8oMhEOJEYdsf+r+bfFPKJroAINBo2gchSv71hdZ
	eTwWJkynlAbs0/iXkqjbMIsh4bPy7YcZqvIYV9vTMOiythMJMBTQFM6OSAixACMe
	m0zM1My6o5jARppLLaLAXbG0OjcmRCX3sCtwE3j4Vjua+Bg/kMID8OzyXKNmepa3
	s1l23tQF7kW+xDRgAli048pwld8D6pBfYylypLhg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahkqcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 11:22:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OBJmoZ009390;
	Fri, 24 Jul 2026 11:22:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyrcnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 11:22:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OBMTR921234368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 11:22:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A08E12012D;
	Fri, 24 Jul 2026 11:22:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3431920128;
	Fri, 24 Jul 2026 11:22:29 +0000 (GMT)
Received: from osiris (unknown [9.111.14.151])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jul 2026 11:22:29 +0000 (GMT)
Date: Fri, 24 Jul 2026 13:22:21 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
        eddyz87@gmail.com, memxor@gmail.com,
        Mykyta Yatsenko <yatsenko@meta.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Maxim Khmelevskii <max@linux.ibm.com>
Subject: Re: [PATCH bpf-next v8 7/9] bpf: task work scheduling kfuncs
Message-ID: <20260724112221.212464A3f-hca@linux.ibm.com>
References: <20250923112404.668720-1-mykyta.yatsenko5@gmail.com>
 <20250923112404.668720-8-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923112404.668720-8-mykyta.yatsenko5@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: FrpXMGUwJqgCt9vend__STn96omYvrcI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEwMSBTYWx0ZWRfXy59gVhyzii8d
 v5iXFi5l90L3ns43bVZVbUohzt0/xeuntR5wYsGlbRK/oQpbIvs2cmyabxkjI9eCS/dczPI+4Xs
 cBzY0qTggdtNX+d8LgwsGuIMKif+otIHMKd+PV082SMx0khIMWYIMIVdJeNvxDHLXHX/WVDmsvB
 WDGF3EoiI8g+YSTaa+6BI196TGG0wD2UGkg0ffippeMD13YMe56tseLim4lKqjAxqE4gxCh7obQ
 IEs1Xkfjbgjol5yFqCshszPphYN3zBT4nlazYjvlZL6mGG/jCaS2QvhXEVfnEODWNRTG8zrYDzx
 sE4rtGVpb0yhC7x+TOKurODb/C8XSBWHVVUrdbs92S9z/AVVe2ICP7gOVR6agOvwvuX/dqkr9pA
 KckAKEMa+6kxAOvzl50J9Ffv0sOz9OAAcVBfva2IA5MYiey7Q0Fu4mYhlYeHpfF0/Itmv7AiGLx
 KPQHLpgJOLI1MwTjl/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEwMSBTYWx0ZWRfX3ptO0bFgw1mS
 EhoR19WjgKLeX3icJM4nIdlR/VQFKSQ9nJ/xwA0PIc/Ee8UCOhAqESFVCXX6JgfjVme1+V67p+z
 zEUbgvqidm7MzZGVh+wE2FdTDImqjRo=
X-Proofpoint-GUID: _F4Tml2yHJFtBnOTrkqsv8Tmajodn7jf
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a634afa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VabnemYjAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=jLcojVu3d0AK3ev9En8A:9 a=CjuIK1q_8ugA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240101

On Tue, Sep 23, 2025 at 12:24:02PM +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Implementation of the new bpf_task_work_schedule kfuncs, that let a BPF
> program schedule task_work callbacks for a target task:
>  * bpf_task_work_schedule_signal() - schedules with TWA_SIGNAL
>  * bpf_task_work_schedule_resume() - schedules with TWA_RESUME

...

> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/helpers.c | 292 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 290 insertions(+), 2 deletions(-)

...

> +static void bpf_task_work_callback(struct callback_head *cb)
> +{
...
> +	migrate_disable();
> +	ctx->callback_fn(ctx->map, key, ctx->map_val);
> +	migrate_enable();

The above indirect call results in a CFI failure - while trying to make kCFI
work on s390, and running the bpf selftests I stumbled across this, which can
also be reproduced on x86:

[   29.357395] CFI failure at bpf_task_work_callback+0x168/0x280 (target: bpf_prog_8ce783214b8218cc_task_work_callback+0x0/0x50f; expected type: 0x37c2b4a2)
[   29.360146] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[   29.360960] CPU: 0 UID: 0 PID: 124 Comm: test_progs Tainted: G           OE       7.2.0-rc4-00365-g48a5a7ab8d6a-dirty #1 PREEMPT(full) 
[   29.361698] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   29.362027] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
[   29.362625] RIP: 0010:bpf_task_work_callback+0x168/0x280

The problem is that above callback_fn is of type

typedef int (*bpf_task_work_callback_t)(struct bpf_map *map, void *key, void *value);

while in fact the indirectly called bpf subprogram has a function type of

typedef u64 (*bpf_callback_t)(u64, u64, u64, u64, u64);

which doesn't match and which subsequently leads to the above crash when called.
This can be reproduced with the following steps:

cd tools/testing/selftests/bpf/

Change vmtest.sh to make use of clang:

-       local make_command="make ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} \
+       local make_command="make LLVM=1 ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} \

Add CONFIG_CFI=y to config.x86_64 and then run

./vmtest.sh -- ./test_progs -t task_work
