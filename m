Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A172441A6
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771350954; cv=none; b=JuXstyeWSgYR9PuEWNAZuxyZ5Rg0BxuR38ARpWJ2T0jAeIM9ts5/IXtW0N+9kyMSnBnzvwvr6o6/8sjpSvubCqqsxMbS4DY6muI1abcPkSDiSDbOFWBepYOaced1FCJnL0wbO+VbGw+Z2G681vWEaNgpJA3Z34T+qo+wGmFsF1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771350954; c=relaxed/simple;
	bh=G5b+t5CeFs3zzW2zof6tht5o8UKmTUhNEVrl5bMKf6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3p1xSI7IYVnOPuWkQJ5DrT91ajPwGqeL9SxIMasl1IgnoTl9t+Cw5bOts2+3bkxJSPdY7qf4dzy0O5UL4efYVAyBmOhA/IGxRlKXEgWBL+g3NtRaSOn2mhakmo2Rd8IV8Mj1a5gBNjplAEZhoDf581ygEwXfkeW3ddtimYrsmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tklOEtqj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tklOEtqj"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HFEGO52375140;
	Tue, 17 Feb 2026 17:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=/CVK2ps5Z2r2uVs23PbNii9gQRUkkK
	xlGIShMiMh7zE=; b=tklOEtqj7ppn4+ZBPBjJM84j9FLTQvmjT9QKpD2MfL1L6N
	3GCZ16EDXUm1dPuLAovvzyWw/VORhA98ge8n9iymZ6qn60OC0DX+ZY1kEObkBIF/
	0LREdObkN1kj75opKk0QILBr+HfgyU8aoRyLPIVaja6iE1JnJGPeIz8vQQLU/2Ry
	CtkGcbbRsHJwKLPRyT57NcEJFoOvwXbGY4IwB2eltEftnFWRD8pWSRofHVg2PzPH
	94PLmUfQsgljrZpChEp+vx4phO6iwZryxICSeka+ytoyE35mWNxXE7JaSQT47gGv
	iRi064Mmm4K0ZzTghPnd3PR+CQM7J/Yjt/XQK5sw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj644m2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 17:55:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61HFlXQl024327;
	Tue, 17 Feb 2026 17:55:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb4540f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 17:55:39 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61HHtadR32702782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 17:55:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB0A420043;
	Tue, 17 Feb 2026 17:55:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7249420040;
	Tue, 17 Feb 2026 17:55:35 +0000 (GMT)
Received: from localhost (unknown [9.111.8.151])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Feb 2026 17:55:35 +0000 (GMT)
Date: Tue, 17 Feb 2026 18:55:33 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 0/2] bpf/s390: Implement get_preempt_count()
Message-ID: <your-ad-here.call-01771350933-ext-9929@work.hours>
References: <20260217160813.100855-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260217160813.100855-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5OQuzaSSsBYGO5iM3bloQAigBMQwi-fK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE0MCBTYWx0ZWRfX9scJJqiLAkL5
 IiDaVyFafCgpe0uiBSQax49klD5qqFcTSI6DTrSxiJuuQNwAJw+sfC4IugQefGLWmgCbeiPQ39Y
 V9TLWFTWlNHqbC9yBsaHaewdx//y3QWAKcknqYIhfVs5PKbyI4wHKNwm2BlXAltfZR9Hj494hSP
 WbmX14cs5vDjPEBzkFnSKWYUiox06awKq2FMTKGvkgQViGQOiVXL6jG0EWTtUpad3fuaSbw6fdm
 JU4IYnZ1OG3b1peo6MKhQjOVlVa15GXsstrasxNCud02hfUOyev8OEU461YffVOjKyqF27sBYLn
 cP7B9yqd5YfDpy3DZxfPMelHVQjHks0IHVXxNrOBgKv07UtO5ZYVcEtLQx2yt0otvxIk20CtQjC
 SFJr2S2y35HLml5V7IW0AKv6clsoGn6uaZVuUTrvvHMiK6CpSQLM22E3EI4DU62yyMJCONFjjwq
 7BPqGgeDM7nA31EB8Ow==
X-Proofpoint-GUID: 5OQuzaSSsBYGO5iM3bloQAigBMQwi-fK
X-Authority-Analysis: v=2.4 cv=U+mfzOru c=1 sm=1 tr=0 ts=6994ab9c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=AR81Q5XkXRJwvMNjkIMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_02,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170140

On Tue, Feb 17, 2026 at 05:05:07PM +0100, Ilya Leoshkevich wrote:
> Hi,
> 
> This series adds get_preempt_count() BPF implementation for s390.
> On s390 preempt_count lives in lowcore: a per-cpu data structure
> mapped at virtual address 0 or 0x70000 depending on the kernel
> command line.
> 
> Patch 1 adds a kfunc to obtain lowcore address.
> Patch 2 is the implementation that delegates to it.

Hi Ilya,

do we really want to expose bpf_get_lowcore() (full lowcore) to BPF just
to implement get_preempt_count()?

Could we instead provide a narrow kfunc/helper that returns preempt_count
and keep lowcore details internal?

Thanks
