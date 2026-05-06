Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAA13F7861;
	Wed,  6 May 2026 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076813; cv=none; b=X5ad+7rKKwv2P0EGsnNTEZrgAxlJFG3nn/zdAZj4VKXrGkbp5qVcf+4DBZ70vivsLm9Ywt96OdK7bMddS4hPWoQye1it7jsPf74vM4vI5hTLr1dp6oPCxjchM6ovOExZTVFQTzUv34doXTiNxctngt2VQA1aY6qBmKljlK4bcUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076813; c=relaxed/simple;
	bh=lU6FXG3n/Xv4yIuXCPWQgDXaWtitBTmJQrODXegMxM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVyc/DBPDXOUAeMkrfxAuDybsErNV2uM8y1xpyfmiJzZ4xzNDaB9eadVl9h0R9Dg6y0RjLo3COXkcKOrIMoC+0kIoYqyhp2eCzMORElFaiWi2waqDzK0jjDU2IgEfxVHTjWsjYVgU61iRDaegkEe+IQaMyEthzi76/0cJbKk8Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g//rLicW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g//rLicW"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6465P6Dm1010395;
	Wed, 6 May 2026 14:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZvnlJ8
	rf1zoU7sgBzQ2aNqwky9VSaAMLSREtRp8TzKU=; b=g//rLicWXGdQ0Q/rZ+ku2X
	Gcz7y1ilAE8h96WlccaOGxBSwiSsJQG3qJ9dFnoLy+DRAL7+hub788X7y2ZVItyV
	pBD+LON3M9K90NBRYY/NXyojMVb7cEH7UTny0feru/ERJa0g1VqaRNee1YMvZGtX
	KrhErqlEdCfrx1vv29dFFtT/WB3kisvvS5itTgRxpBvDBm8um0ufh4dH12Xrse/j
	wtA95lJUaKEeTRvNAvEtPn7OHzzfuhil6fOt0oBBX0CVLQts4u451T/pBkRhIGhM
	kcoCElo+uWropTc60Is2O6mJMHSUx7avWm4TfWWC/qdBRwl+MrVcRTEBoR1Hdp8Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4rdpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 14:13:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646E9bkY025470;
	Wed, 6 May 2026 14:13:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9ye9ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 14:13:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646EDPbV55116268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 14:13:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C68122004D;
	Wed,  6 May 2026 14:13:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A44F820043;
	Wed,  6 May 2026 14:13:25 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 14:13:25 +0000 (GMT)
Message-ID: <2946bcda-321d-4a17-88f2-02c5137676cf@linux.ibm.com>
Date: Wed, 6 May 2026 16:13:25 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 04/19] x86/uaccess: Add unsafe_copy_from_user()
 implementation
To: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev,
        Indu Bhagat <ibhagatgnu@gmail.com>
References: <20260505121718.3572346-5-jremus@linux.ibm.com>
 <20260505182244.0A151C2BCB4@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260505182244.0A151C2BCB4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzOSBTYWx0ZWRfX+6qrWa6fNU6q
 V6riBsdnt/4L/gRjAPoVmOYV7VP1+UxqZW80pK3QtlEXmov4zmHQhfxiTOkWaZdz047modZebu6
 FK7iRwvS8ln8msobA7bktqUCt/BHoKF7mniFdjejK1D6Jy+cnNcU/H23AhwLn+Yadft0zXjda6x
 Tax2sOFDrYUyhpPP3g0ErE3HbmfUTuQhO58WatVUo6USU9K4NNg3xPBqNfqxXvPc2Uppp6CJhOc
 Qc1Ybt26mPUlVSlrDY8cwCLd9RYvVrt2j+T/sRHTAMLSREuaTNuJhXHruRVgaQ1jAUJAyZuDudG
 vBqhkUS1LxsF3NQ1bQXmjd/cFjyX2p02zc1XJ0fAEkujUvFOWY1Pk6ADUybFp19gv4rEWQ83pcn
 ocRuiladW+ZdQCWs+l6IJRYHB+e6gW1fYeUK2WOYeiECJGuLNw0j2OYUqIkRvvLZaFSflKL8yuD
 KmFXsmuwQ2udCzK2fkA==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fb4c88 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=LFt20mCCc4CE-LtB3JUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: yBBzXVAkvyL2H-hiaKZAo-74MXd8j0K3
X-Proofpoint-ORIG-GUID: J2UJhCTx5GhGmBRJZ7iO2sWgHRpKQJkV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060139

On 5/5/2026 8:22 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Variable shadowing hazard in unsafe_copy_to_user and unsafe_copy_from_user macros.
> - [Low] Missing const qualifier on the source pointer in unsafe_copy_from_user.
> --
> 
> Note: The format of this report is altered due to recitation restrictions.
> The original patch code is not quoted directly, and a free-form summary
> of the review findings is provided instead.
> 
> commit b652061f302d029392e67f46699e5a2db0abfaca
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> x86/uaccess: Add unsafe_copy_from_user() implementation
> 
> This commit introduces the unsafe_copy_from_user() macro for x86 architectures.
> It also refactors the existing unsafe_copy_to_user() macro to use updated
> internal variable names.
> 
> Regarding the variable naming in the updated unsafe_copy_to_user() and the
> new unsafe_copy_from_user() macros, is there a risk of variable shadowing?
> 
> The macros declare local variables with very common names, specifically __dst,
> __src, and __len. If a caller passes an argument that happens to share one of
> these names, the local variable declaration will shadow the caller's argument.
> For instance, if a caller passes __len, the initialization size_t __len =
> (_len); will evaluate the right-hand side as the newly declared uninitialized
> local variable itself. Could this lead to the loop copying a random length of
> memory based on stack garbage instead of the intended length? The previous
> implementation seemed to avoid this by using uniquely prefixed names like
> __ucu_len.

Please advise.

> Additionally, looking at the unsafe_copy_from_user() macro, the user-space
> source pointer is initialized as a void pointer without a const qualifier.
> 
> Since memory read operations typically expect the source buffer to be
> read-only, callers might pass a const void pointer. Does this implicit
> dropping of the const qualifier trigger a discarded-qualifiers compiler
> warning? Could the source pointer be declared as a const void pointer
> to prevent potential build failures when warnings are treated as errors?

Makes sense.
Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

