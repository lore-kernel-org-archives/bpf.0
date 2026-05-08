Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F73236D9F6;
	Fri,  8 May 2026 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778233810; cv=none; b=IEuczbP9I5VArezMpbm8DTlI7E48qcgwHCWY8BboD8Hc0Y4EiTFhLQmLZizZ7t60jP3WtQMg0HclthAWN8cm5KbMl7PKMQR5YzgDCnA3W9cvSgGV3nV3u42JmpgXESu0HBpVGxExnETEEI+msvWsZ2l2zTZNrdk63IzHwrdDM6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778233810; c=relaxed/simple;
	bh=4lXGHkoNae75ldpkNyhiF6ThayX9DHKq38BLerD+tiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMgk8DOMwWrcJ0qG9DaAYg5a0fW3y9omTb+NsrRXfKuRUPwRRLPYs41vKggXEky/GHymBWlrsm2BVCftsBt482VfRt8xqBV4Wwx2xY2NDFuuT0/Pz5spwtk2MwNVvdzpUhTBhHY3dJTxMCZQILAjDrjuV3LqbEn+CWkPFb3uo1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q85I4ULI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q85I4ULI"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648052mt144785;
	Fri, 8 May 2026 09:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HEF4FJ
	HCCmuCv/8hH25sOS7/QyfcR0fy008p5SfDaLE=; b=Q85I4ULIhFEiluDozl+K/O
	z8V7rEXfHD+HfRx2szzWAcCzpsbeJqeqOORIJLoG6bIBL0PUY7GtqDcjpz3lrF4+
	9qgBsJntWnEYQfwTK8QPQDcCOE+GAPjDi2PVjIelmyOoNdLc8i2Dpv/Cd8yutIdj
	4BFMfMGJH1bBT4dlYPKMCfUPFGaCNramgtSEDTIN58bB5NZ96T5xwnFa0UGPoaZg
	YQaPLUYhxsYwZmotOsHNQ8bXK+T8WDcNKySR0KmvDwG/X4njZY8QhvK95z9oflMT
	pVeKLvRhGu+H+KABW0EjGuncR72CXudGT4vnAfhH+SgNYRdmGpEOhnw7bJRUwdzQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y51u46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 09:50:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6489dVQg004377;
	Fri, 8 May 2026 09:50:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkk7n1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 09:50:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6489o0ZL56230252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 09:50:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0615F20065;
	Fri,  8 May 2026 09:50:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B442F2006C;
	Fri,  8 May 2026 09:49:59 +0000 (GMT)
Received: from [9.111.146.58] (unknown [9.111.146.58])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 May 2026 09:49:59 +0000 (GMT)
Message-ID: <3158dc1a-26cb-4942-b05e-6c60c092e588@linux.ibm.com>
Date: Fri, 8 May 2026 11:49:59 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 05/19] unwind_user/sframe: Add support for reading
 .sframe contents
To: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Indu Bhagat <ibhagatgnu@gmail.com>, bpf@vger.kernel.org,
        sashiko@lists.linux.dev
References: <20260505121718.3572346-6-jremus@linux.ibm.com>
 <20260505185932.C708CC2BCB4@smtp.kernel.org>
 <4e5d51f0-8f4c-4a07-9141-8b26d2c90fc6@linux.ibm.com>
 <20260506110142.7b2943d7@fedora>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260506110142.7b2943d7@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDA5OCBTYWx0ZWRfX0rCEV1aP+TIk
 +vtbaD5kVxXj1cmwdMzFNyQMfiYl+XZOeR+XyU4mabqjDaOlkDl1Ez7VbF2sedLJ0JMitoIKRG9
 ++C3B/Ha0d/s1t1l+KalI2QpSeeAPB8FS6DEqoAD5UrtvBFWW9waEaUYfSNJjs4p7lRqg2hfOl1
 MryfM+RFl8/ZlTiLS+KBNlSXNLdBnPZ1dR+wD2DO350or+zuSNKmZIxufxyb6PVz/C7aDnseYvu
 xIax6ershH3cgFqU/WffAZDxrj2Z/UPXTZT9lOCyXP/iki7r/ncd/4zUfqE8qYdlCF4tE0arVla
 1/L2EfMRIb0i6p0mMsa3ZzdmlwnaA6RxnsJSYl5RFxgxIrPK/7/V1KWTIvCd63gVUgpltju9O29
 Omqadz9fcHY5zvxdpFKVZQqE6yKfQ1oSttsZJj2WInOXcJhRC74qefqaWcJdqOrmWZVRV4pbpZH
 aGyvOAQj5lQt1wPMmag==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fdb1ca cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=OuseVYRhBCIXfGPqWo0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EdltQbYL5lq8UREIR5SgdBX3HliFUCta
X-Proofpoint-ORIG-GUID: zPzQkwolSqx0DnwyUw1HGGQgPOGb29-s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080098

On 5/6/2026 5:01 PM, Steven Rostedt wrote:
> On Wed, 6 May 2026 16:34:34 +0200
> Jens Remus <jremus@linux.ibm.com> wrote:

>>> If a malicious user provides a large fre_len in the header, fres_end
>>> (calculated as fres_start + shdr.fre_len) could wrap around the 32-bit
>>> address space. This would bypass the bounds check in sframe_read_header(),
>>> allowing fres_start and fdes_start to point into kernel memory. Later, when
>>> __read_fde() and __find_fre() use unsafe_get_user(), this could lead to
>>> arbitrary kernel memory disclosure.  
>>
>> SFrame is currently only supported on 64-bit architectures (i.e. x86-64,
>> arm64, s390 64-bit).  So unsigned long fres_end should always be 64-bit.
>> Do we need to add the following to the header parsing?
>>
>> if (fdes_start >= fdes_end || fres_start >= fres_end) {
>> 	dbg_sec("inconsistent FDE/FRE start/end address\n");
>> 	return -EINVAL;
>> }
> 
> I guess this wouldn't hurt.

Reviewing my suggestion again I realize that this check would be
superfluous.  The existing computation and check already ensures that
the FDE table is within sframe section, the FRE table is within sframe
section, and both tables do not overlap:

	num_fdes   = shdr.num_fdes;
	fdes_start = header_end + shdr.fdes_off;
	fdes_end   = fdes_start + (num_fdes * sizeof(struct sframe_fde_v3));

	fres_start = header_end + shdr.fres_off;
	fres_end   = fres_start + shdr.fre_len;

	if (fres_start < fdes_end || fres_end > sec->sframe_end) {
		dbg_sec("inconsistent FDE/FRE offsets\n");
		return -EINVAL;
	}

- fdes_start and fres_start are computed from header_start and thus must
  be larger sframe_start
- fdes_end and fres_end are computed from their fdes_start and
  fres_start and thus must be larger than sframe_start
- fres_start < fdes_end ensures that the FDE table and FRE table do not
  overlap
- fres_end > sec->sframe_end ensures that fres_end (and fdes_end and both
  fdes_start and fres_start) are smaller or equal sframe_end

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

