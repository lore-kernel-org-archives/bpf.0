Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930C534DCE0;
	Wed,  8 Apr 2026 04:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775623934; cv=none; b=ulbMz+NjIIsTstd/y3+D65mmDNqmvGl1loAVkFbabSETtbffqmvPVraKgXzrrjI6PiXYdyCPa80YwvBZYnuSEWjAFYEycYAup4Hr4ZkaA58YT3VL5hWHFaDb7WlahutQkDmSqEfurPGaTfH3FXOBSx7gGA6dvnxFD5M7EkheNYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775623934; c=relaxed/simple;
	bh=X5h/xLTb1845Lra6ReWS/ZxjpdKl+DXhqHElu54zeWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZ9zn5evJ9dq9SVancaPEJ31cB6O/fw0oOFLiMQNOz/RJixQKGIovv4523WkeL5Cn/wYd2INh7TWfNEVBUOOOZBuVAvYaATnMpqgUrw9T1n+wq3+PGSNuYLjqcv7rMqr7ub7jm52WdiBX8Kn9whC8fcoaOTv8HciLj0+PKU8q4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GZobKJls; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GZobKJls"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637Df0i72326654;
	Wed, 8 Apr 2026 04:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4uX9lT
	4+5ouAhDI/5zmvB0saieArA06hYmrzCLeSKeo=; b=GZobKJlsiocF2+vHcY+yJR
	dl6l0GDq5aQO0CmNGYo3h3/LBA2EgzXxTrwi1rayk1PEGVt9lXopVGScc2JEo9CU
	ppzPjPXVxvkCGNHD5QiBsNbZdxd9Il/07LcvJDIl6e3Caz1URYw5xJ1bcptA8Ny+
	Ay2oJmiF0lNSBrasl4yqBExIzIbDs+VlwqXgqHIvizYZ24q/FU6w4sA+w6e+BD7k
	HbtPjjv/K40Ym8tvATlOMNPpBP6RRbiMZpa8EFlbomhEXbQKhw03yCWDv5jeBMFQ
	Pe3I0hJxXVco1lTHbRPjks/Kqk3F09Dy1s2NC9Pqs7QBy3G1N2xMUbRmcF3e31iQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kdt1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:51:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6380149H007881;
	Wed, 8 Apr 2026 04:51:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2e1k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:51:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384prwn45875524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:51:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9617E2004B;
	Wed,  8 Apr 2026 04:51:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 205B520040;
	Wed,  8 Apr 2026 04:51:50 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.22.74])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Apr 2026 04:51:49 +0000 (GMT)
Date: Wed, 8 Apr 2026 10:21:46 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Abhishek Dubey <adubey@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: bpf/selftests: test_access_variable_array breaks due to
 sched_domain::span removal
Message-ID: <adXe4gNBihTOyIjQ@linux.ibm.com>
References: <3e129be5-d61e-4bc4-b691-8d69e2f58de6@linux.ibm.com>
 <CAADnVQ+wZgucXKf5ZFNeSMcgARQVsQ7knVctf5R2GOGDRSEagA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+wZgucXKf5ZFNeSMcgARQVsQ7knVctf5R2GOGDRSEagA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA0MSBTYWx0ZWRfX8nvCheWy2YLc
 UXGr87rQYVMANOb7cjZJcDUCmjBYwaaLrNAXFNDRHZGL08H0W171EQrdMyb90+cTur2SL81NzEk
 gvzqPYVo2JOBSnnoXa2wPQ/ssuf6LJxaPRyOaNOJj0W180nQHB+/RF7+Gfcsn31pJIko0d0PVbj
 PAjD1k8DNr8BmadCw5pr3RTHcgWiG0dS7+IFSWkCvglDTJvLkV4N+tSiOEbvWjus9Gc4rm+PREi
 dgnDXoIC1pdOnse633afZo+5eqYS9jp9dL8AfVz2cEVt9b3gZ/AIxWDOV9+YtT1eYz2Wh4V5HGb
 /rB4rF5N1lFUHEBF2cGylKCACIBoHi5W6BQYPQikxc4l93xFEwORMdL7ox3A7uVL4s3uUwdcPVB
 fmMXq0DxMHGk+bfXlSxk+07tEMIyMY3AfOvn+zBy+vUZ3t1aXTT4DsrWVOKkNqz2YGqGDNtI97W
 owjTLHrQw7MQRW/3Vmw==
X-Proofpoint-ORIG-GUID: kwpThi0ex2Ku9hE4BSiOFo0OF6kkWI7t
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d5deee cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=dx792_0i3jrKHWLwZscA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rFkOjVeNGYSJxCENsn5lrUP1G6XJywzG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080041

On Tue, Apr 07, 2026 at 10:33:51AM -0700, Alexei Starovoitov wrote:
> On Tue, Apr 7, 2026 at 9:12 AM Venkat Rao Bagalkote
> <venkat88@linux.ibm.com> wrote:
> >
> > Hi,
> >
> >
> > While running BPF selftests on current linux-next, I noticed that
> > test_access_variable_array fails to build due to reliance on
> > struct sched_domain::span, which is no longer appers to be BTF-visible
> > after recent
> > scheduler refactoring.
> >
> > The Build error I am seeing is:
> >
> > progs/test_access_variable_array.c:14:13: error: no member named 'span'
> > in 'struct sched_domain'  CLNG-BPF [test_progs] test_check_mtu.bpf.o
> >
> >     14 |         span = sd->span[0];
> >        |                ~~  ^
> >
> > Below is a proposed update to the test that switches from
> > sched_domain::span to sched_group::cpumask. This preserves the original
> > intent of validating variable-length array access via BTF while avoiding
> > reliance on removed scheduler internals.
> >
> >
> > diff --git
> > a/tools/testing/selftests/bpf/progs/test_access_variable_array.c
> > b/tools/testing/selftests/bpf/progs/test_access_variable_array.c
> > index 326b7d1f496a..c9f345ccde3c 100644
> > --- a/tools/testing/selftests/bpf/progs/test_access_variable_array.c
> > +++ b/tools/testing/selftests/bpf/progs/test_access_variable_array.c
> > @@ -4,14 +4,18 @@
> >   #include "vmlinux.h"
> >   #include <bpf/bpf_helpers.h>
> >   #include <bpf/bpf_tracing.h>
> > +#include <bpf/bpf_core_read.h>
> >
> > -unsigned long span = 0;
> > +unsigned long cpumask0 = 0;
> >
> > -SEC("fentry/sched_balance_rq")
> > -int BPF_PROG(fentry_fentry, int this_cpu, struct rq *this_rq,
> > -               struct sched_domain *sd)
> > +SEC("fentry/sched_balance_find_dst_group_cpu")
> > +int BPF_PROG(fentry_fentry, struct sched_group *sg, struct task_struct *p,
> > +               int this_cpu)
> >   {
> > -       span = sd->span[0];
> > +       unsigned long *mask;
> > +       /* Read pointer to variable-length CPU mask */
> > +       mask = BPF_CORE_READ(sg, cpumask);
> > +       cpumask0 = mask[0];
> 
> No. That defeats the point of the test.
> It tests [] array in the kernel struct.
> Just make one in testmod.ko and access that.
Hi Alexei,

We do have cpumask as [] array in sched_group:

struct sched_group {
	struct sched_group	*next;			/* Must be a circular list */
	atomic_t		ref;

	unsigned int		group_weight;
	unsigned int		cores;
	struct sched_group_capacity *sgc;
	int			asym_prefer_cpu;	/* CPU of highest priority in group */
	int			flags;

	/*
	 * The CPUs this group covers.
	 *
	 * NOTE: this field is variable length. (Allocated dynamically
	 * by attaching extra space to the end of the structure,
	 * depending on how many CPUs the kernel has booted up with)
	 */
	unsigned long		cpumask[];
};

Wouldn't be good if it is used as:

cpumask0 = sg->cpumask[0];

Also, there is already a selftest that makes [] in testmod.ko
and access that.

Thanks,
Saket
