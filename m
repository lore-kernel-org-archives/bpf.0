Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633033AB5DA;
	Fri, 29 May 2026 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043387; cv=none; b=ZYL09GOzqelcw6URcD7rNndaKHHwLDS3P5detrdoi9i6bZDtF13bYgO+pgYFPbT8bBasWwpto6NIqj9OUo3HlmCZBSHM3Q56dFudvQwZ/WUub+w5pHyem81/1Fuz9n6cyyJebxG9AUbsCb6UTHpUDz4FSCJJJ859pgQyLJ/5GYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043387; c=relaxed/simple;
	bh=lQ0zbcLil0/HCJ3909LMaKt2HLfj1P9vlCrDawJ0TiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzGjodxTesL5SE/p/P/7Xpv1hzVebONCruyWh039D+4IDfoupqqgf74071p2A52xg58szzpwGnfEwun8Zec2UCywTLP7msLypQi1Wbuz8Rwcqs0kUtH9Xd1oebP7028jZZBDhCQrNqqQ5rqp2FvsbUaTLeOVtBw3h8qihmIZbvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RPxHOxrD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RPxHOxrD"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLllLd2418247;
	Fri, 29 May 2026 08:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ZmCU8JjyW1xv8XSh7pfJC++iM36fsD
	Sne5TVGz99TSo=; b=RPxHOxrDDOKdhImhAgptuWp5UafW7nh6T8LpvzP+xLcWce
	BISoGufG+1TFMzmrmNwRn5HgrlMBtRPPZqGI+vax1IlO5Z2e03VR9J4QLUUvZGqB
	5MT0QoHqzsM2ftNCe2/brGOUMw44UNHvxhFNUq0QWTGRP3Mot/aAWBfvbaBvvCZ1
	T6xbfDQpwRdIe+21CVX8eG5xFlBDSgZR1vmAZcZI4GkxY60q6swdQKNI82HvMrmr
	1K58URXwMVCxZ2f99hzKRviNU3zJNiaPz9KzZzXovOBRrnwcce7DAz4onYJw9Yzg
	c8Ytk0PjZQocAn+ztZQHiJGVY4s1EJcKgKSn7GVw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884qjcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 08:28:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64T8OBnO032654;
	Fri, 29 May 2026 08:28:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbcjw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 08:28:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64T8ShFO37683514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 08:28:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 783E12004B;
	Fri, 29 May 2026 08:28:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47C0920049;
	Fri, 29 May 2026 08:28:42 +0000 (GMT)
Received: from osiris (unknown [9.111.13.205])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 29 May 2026 08:28:42 +0000 (GMT)
Date: Fri, 29 May 2026 10:28:40 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Steven Rostedt <rostedt@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Vasily Gorbik <gor@linux.ibm.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH v2] unwind: Add sframe_(un)register() system calls
Message-ID: <20260529082840.26496A2c-hca@linux.ibm.com>
References: <20260528151023.00f5ec4e@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528151023.00f5ec4e@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a194e41 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=meVymXHHAAAA:8
 a=JHi4FkbiIRko9ia7NpwA:9 a=CjuIK1q_8ugA:10 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: bKpieZLL6prBYOtPU8OUCX4n4xg7100e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA3OCBTYWx0ZWRfX8FSLPHD4t+RR
 mMX3xIpIFspAD6pvmEH64fxuxOFaZebMHBKxC1/NEba/SK4W2tMIvVkUwEMByTwaF5oaO+4Na8t
 LMJzp4vAiADBiov4C4DNfYp5/Y0BBDYPflih8CQzU1xpBDrbeU9ZD4XCJWRYSkvkSan1fL4sN1e
 dfVlMp9Il/c3tulCeQ4ZKoxMKGzshh2GFxFIuxKAG+LBrZPG3Ck4ClldIL9H86+3vSx3Am47KUO
 7xuukOZ6AEvZ9RnFnOdZrFUj4CZkp1hkegxH2XfzDKdem3rrPvdOWoT8Q8Slp0VZGLPAT3dImmt
 /ncvgrRZRWC5l4YOvJRwd+dDp/fw71q8wF967DeC7XsqiyDn9EcPKMAZIl+aJ77SdOIoWDzbJyy
 fkhcM7MEdjpaazm3PokQmLxWwTzI6fNDDrTGJENn/LC7NLP0c4QjwRY4rIf2UuA8xHmpRHyDFPv
 +hxwHP/CLAPMFMvnbtw==
X-Proofpoint-GUID: X9uleG4BCnUStnmV7cUzFy92hiRdtqkl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290078

On Thu, May 28, 2026 at 03:10:23PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Add system calls to register and unregister sframes that can be used by
> dynamic linkers to tell the kernel where the sframe section is in memory
> for libraries it loads.

...

> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index 09a7ef04d979..52519e2acdc8 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -398,3 +398,6 @@
>  469	common	file_setattr			sys_file_setattr
>  470	common	listns				sys_listns
>  471	common	rseq_slice_yield		sys_rseq_slice_yield
> +472	common	stacktrace_setup		sys_stacktrace_setup
> +472	common	sframe_register			sys_sframe_register
> +473	common	sframe_unregister		sys_sframe_unregister

What is stacktrace_setup? And why only for s390? Looks like a leftover.
