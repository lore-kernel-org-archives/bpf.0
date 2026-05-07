Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F0E17993;
	Thu,  7 May 2026 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778171028; cv=none; b=ikIV/djIZSCb+Q3mcbkDfTpSxyO5A2dUn55gm0le4z2Ch2UrQ27GBfDg0k7nYSXVDZTJaP2KZLhTqA2aiUmwDn/H45r5WhRpam3F+isuOwUXqbmqBGDkUCNpAI/oW8z3tTO33SqCyGHmkDhFlxiCKl6jSzu5Qk++FugqJ+pZ0Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778171028; c=relaxed/simple;
	bh=6cmMjhip9L3Mzg6DvVPiOH5HEJTFvpTcQdc5x8w4mFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZp/GTRvv1fH+jlomycZCnwIG4wMEvJhx2PUrbCgyAkImRkA62Sf2mgSGu0VlVAkTwqWgGmJNBZ7AfUj+Tl/XhFPEd86zaadUJFv/8pwBS+WMJ73+OWu3BzQdGyjT5hx4NBmvQPETsE1n/uAccREk/r7uex7BCj2TdDo/EdGTI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RW5C3uv+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RW5C3uv+"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647F8eXw1080687;
	Thu, 7 May 2026 16:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=V64+Om
	/5UjYYJCtPD8VOG/OuP/P36hNIzOWiv9SBntg=; b=RW5C3uv+swLobeWuAeCp2/
	D1foUG3WmJoiCEP4eoClNwkITT8yApaHmpsis4oyXDJeVy5L7wu7bApZ34be/MmL
	epylLx1OTdl6neTZb0U90jG515XvVF+GKOBTFm5jGv+MH08+HH6ZHkW1sOmLEiix
	V6YW/YEkawCluwXutWRreg7jYBHw+hZ8LAEVuea0ok8ylzYNB0lWOp0dMoK8qaKf
	X8/bFDUo/vETTfswS5HD5HuhExswBHBxFuXRam+yedM3E79oyiOJFBggh4OAmK/T
	+esmzN3uTpkM7eGI1ChFCh3qErAhXWXakaxREDMfbogaKBq7T8YDk3bDZwk1VV8Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1qkf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 16:23:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647FsTRg032413;
	Thu, 7 May 2026 16:23:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuywch8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 16:23:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647GNf4w16187650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 16:23:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0650520043;
	Thu,  7 May 2026 16:23:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6A8220040;
	Thu,  7 May 2026 16:23:40 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 May 2026 16:23:40 +0000 (GMT)
Message-ID: <232ddaec-2eb5-4210-ad5e-52d98f2449be@linux.ibm.com>
Date: Thu, 7 May 2026 18:23:39 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 10/19] unwind_user/sframe: Remove .sframe section on
 detected corruption
To: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev,
        Indu Bhagat <ibhagatgnu@gmail.com>
References: <20260505121718.3572346-11-jremus@linux.ibm.com>
 <20260505203942.98A3DC2BCB4@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260505203942.98A3DC2BCB4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: vbQS723DTR1vsZEbePWdK4cogKbWiQvC
X-Proofpoint-GUID: U8S3kf0qN4FOxtxcVxoQ6scp4wV2S424
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE2MSBTYWx0ZWRfX/5sNALpWYoug
 sTmBcLPlri4Ii3URThiXv+Mxsiy8/URXLmtU/KSpgT7hFbc6H6bwwSTKhlaa2QZsxYqRcQGAmma
 DKSJ3ya50Fr6ff3qg3k1zM64tcs/OB6ptpFXarhyY3RqlqCNETMHQXoI9Tt41VHQDfXVMZgyVUz
 H8RwbVg4L83KZ1k97eJ0n9s+bBvupuSAq2X8ju3aZYm0SJubC+pNjpVTHWEY7CoH1CKaKQkb6nS
 1ri3A0Tlxqv/8KGc89x4L/DyCbt1Vs1x3a979dDJ1EaDpykW8qfZB3+pvF/IK2trt+T8umcOYdo
 jtwlYihFieFVsfIJoKQG2svx0g2HRpd/I9yjPWsPtb2TrXK5QUO+sWI8iiFfB8iKZpj0XfSuXO/
 Pi02AHHy6yJKuUIGkrTJCf9zZ3yG6IbsmcBMiqbiMgVbtU/TsqOj5U4WKGelwok+LL4OXFKB5cZ
 qn4K7+2KEbesUxgQ/qA==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fcbc90 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=HarvMFBOxm8M9-M_l90A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070161

On 5/5/2026 10:39 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Concurrent stack unwinding on a corrupted `.sframe` section triggers a user-controllable `WARN_ON_ONCE()`, leading to a potential Denial of Service (DoS).
> --
> 
> commit a00e313eeb121415a3ca3fe4ed3b15126f46c76a
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> unwind_user/sframe: Remove .sframe section on detected corruption
> 
> This commit removes the .sframe section on demand when corruption is
> detected during unwinding, to avoid continued attempted use of a bad
> section.
> 
>> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
>> index 9c755965ab837..8eed6a7d96256 100644
>> --- a/kernel/unwind/sframe.c
>> +++ b/kernel/unwind/sframe.c
>> @@ -358,6 +358,10 @@ int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
>>  	ret = __find_fre(sec, &fde, ip, frame);
>>  end:
>>  	user_read_access_end();
>> +
>> +	if (ret == -EFAULT)
>> +		WARN_ON_ONCE(sframe_remove_section(sec->sframe_start));
>> +
>>  	return ret;
>>  }
> 
> Can this WARN_ON_ONCE() be triggered concurrently by userspace?
> 
> If two threads within the same process are being unwound simultaneously,
> they could both encounter the same bad .sframe section and hit the
> -EFAULT path.
> 
> Because sframe_find() is only protected by the sframe_srcu read lock,
> both threads might call sframe_remove_section() at the same time. The first
> thread will successfully remove the section and return 0.
> 
> The second thread will fail to find the section in mm->sframe_mt:
> 
> kernel/unwind/sframe.c:sframe_remove_section() {
>     ...
> 	mt_for_each(&mm->sframe_mt, sec, index, ULONG_MAX) {
> 		if (sec->sframe_start == sframe_start) {
> 			found = true;
> 			ret |= __sframe_remove_section(mm, sec);
> 		}
> 	}
> 
> 	if (!found || ret)
> 		return -EINVAL;
>     ...
> }
> 
> Since found is false, this returns -EINVAL. Because -EINVAL is non-zero,
> WARN_ON_ONCE(-EINVAL) evaluates to true.
> 
> Could this allow an unprivileged user to intentionally trigger kernel
> warnings (and panic the system if panic_on_warn is set) by unmapping a
> registered .sframe section and triggering concurrent unwinds?

Please advise.

Should all WARN_ON_ONCE() in user unwind (sframe) be replaced with e.g.
dbg_once() instead, defining it as follows in sframe_debug.h:

#define dbg_once(fmt, ...)							\
	pr_debug_once("%s (%d): " fmt, current->comm, current->pid, ##__VA_ARGS__)

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

