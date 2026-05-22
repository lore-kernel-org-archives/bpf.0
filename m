Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE183AFB0B;
	Fri, 22 May 2026 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441971; cv=none; b=IpU9Upn5yVRPX6uuhZ6r+KN/7VpykOgToFfPtmzD6yYygxC+8QQFQ4eo7k0FDlaQstrrtw6oZ+pFTdtZ1qIy6ymDP52346th1tBX+/flG3zkVxbTQj4/N02MbT9edSc6Ofz0I1FG5jiqnaT6a+/zZqqUZFDNk/ESANbU4M+JENM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441971; c=relaxed/simple;
	bh=LqJxtjHtnNHq9un09wO3+N4KVBH2kA/zlz9GAga8pkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hdI68lZBsXEwxhDUZFlWAn+BC+ipD6Y9OJdTrVM81g/c40rOC7kymfW5Lf+332Twttijk5Q7C61Q3H78k2wloYx6YYG5FaNtHttj82KlaKk27BWZmvRbUpaV5mXDFl29i6UjWk1Ai0wu1w+3qm+0X4pUIBsXqU/czKYtGVpCJ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DzhhvBZD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DzhhvBZD"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LLc6I8220727;
	Fri, 22 May 2026 09:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fK7RVv
	ZZzliwA3n9gqeu4iKchy8+wcnrrG92Mepetqo=; b=DzhhvBZDyLtgRfCEkDXa/S
	E5h4wKVPhaUNcJZ9oZIubtR7w39w2UzhCXulT6NIaZsaPX8ovx3/BuT1I4tOKXjA
	4TTPBnr9C+mt9G0C6yj3wPMoccjoup4oMr1SHFYTmdPAf5a7wrTbueek8nSBJ9JE
	91jWEHj2uacZvRh4d+qzvUujH4cqA/5K0EmXobyYSIMUw+qn+otm26F/9ACqwPtP
	7lEDKED4ylbFFursv2UgrEnpYk+9mXAjsSbzIW780zoUp3qjvruuiMDY7iXSmBHS
	EKxLPzNNslXTur40vEg5oiDPtjOXM814UYkxHwalmwzDIQYblDxOHDFok2G1PEvA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8n37vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 09:26:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64M9O9fS026788;
	Fri, 22 May 2026 09:26:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wqgh3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 09:26:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64M9Q27w53608882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 09:26:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D3BB20040;
	Fri, 22 May 2026 09:26:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E8DB20043;
	Fri, 22 May 2026 09:26:01 +0000 (GMT)
Received: from [9.111.153.207] (unknown [9.111.153.207])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 09:26:01 +0000 (GMT)
Message-ID: <7fa7ea0c-80fb-4a3e-abc9-8f3dbd7968b1@linux.ibm.com>
Date: Fri, 22 May 2026 11:26:00 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 05/20] unwind_user/sframe: Add support for reading
 .sframe contents
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@kernel.org>,
        Dylan Hatch <dylanbhatch@google.com>
Cc: bpf@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        Indu Bhagat <ibhagatgnu@gmail.com>
References: <20260521142546.3908498-6-jremus@linux.ibm.com>
 <20260521151811.23FD61F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260521151811.23FD61F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: tu8GNHy-fuDmVN4Dp5psIyZKlqO5WA_c
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a10212d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=-OPE81b11Tn-cb5jPv8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: J_77Ohv3NfZz7Jg95CBEhW-N3zcHo3-P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5MCBTYWx0ZWRfX0luBpqqi1k7J
 VXeaE2oeU3CphGb/WZczjSJT6OHLVYkxU4oexnfSPAwOuNaBxQ2PHQrj9XlpE7I0c1boopYdpqX
 ciyrsOmJcIdRiOOHvW5w1j5txHSB//kKA7QbhC+V1tOWZnLjXDSn/XMAi6kNK6l8y14QPgj4+aq
 sJKLSgWVmhVvQFCia2WY7PVGNOq5ae7iDcpPsl3/ncs9INSvTfOeH+7qLhfIco41lN7Zc9vlWYS
 pYiu+mtFe48ZjQVsoYVy0cltgQ7ubsf95BkyR4kYQDjXmJPt1eokZj8grQ/kNoepZEHutD9dmMX
 hFyqTpOjuynjJmqk1++cl+vxRMnhquQN37ezkIZ8ApMoVYWbyVmEWeSRCbCxXFUdGMXDnyLBSbx
 SkYq6F/iy/S3OCTtauGVwPsy0UP+WrWtwxJBvw/S2RcyXZ77mYHpKU2mqqqoHF9HHkLL6fWiTSk
 mpsnmN/sYC/G25l7MnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220090

On 5/21/2026 5:18 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Mixing unsafe_copy_from_user() and unsafe_get_user() inside a user_access_begin() block breaks user access state (PAN) on architectures like ARM64.
> - [Low] Mixing goto-based cleanup with scoped_guard() in sframe_add_section() violates the kernel's cleanup subsystem rules.
> --
> 
> Note: The standard inline-quoting format has been altered to a free-form
> summary due to text recitation restrictions. Code snippets from the
> original patch are omitted.
> 
> commit b0f7b5132f15107b2df84ba67a33ced97fd3372a
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> Subject: unwind_user/sframe: Add support for reading .sframe contents
> 
> This commit adds an sframe_find() interface to support unwinding user
> space stacks using sframe information. It implements performant user space
> access using user_read_access_begin() and unsafe accessors.
> 
> Link: https://lore.kernel.org/all/77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.1737511963.git.jpoimboe@kernel.org/
> Link: https://lore.kernel.org/all/b35ca3a3-8de5-4d32-8d30-d4e562f6b0de@linux.ibm.com/
> 
> [Severity: High]
> In sframe_find(), scoped_user_read_access_size() opens a user access block.
> Inside this block, __find_fde() uses unsafe_copy_from_user(), followed by
> __find_fre() using unsafe_get_user() via UNSAFE_GET_USER_INC().

Previously (see v15) the code was using user_read_access_begin() and
user_read_access_end().  IIUC scoped_user_read_access_size() is just
another mean to express the same and it behaves the same.  So if the
issue brought up by Sashiko AI review is valid, then it would also
exist with the previous implementation.

> 
> Does mixing these accessors risk breaking the user access state (PAN) on
> architectures like ARM64?
> 
> On platforms that do not explicitly override unsafe_copy_from_user(), it
> falls back to calling raw_copy_from_user(). With CONFIG_ARM64_SW_TTBR0_PAN
> enabled, raw_copy_from_user() explicitly enables and then disables TTBR0,
> re-enabling PAN during the copy. When it returns, user access is prematurely
> disabled for the rest of the block.
> 
> Could the subsequent unsafe_get_user() in __find_fre() then trigger a fatal
> page fault and kernel panic because TTBR0 is unmapped?

If that would be true, wouldn't then the arm64 raw_copy_from_user() or
the common unsafe_copy_from_user() implementation be broken?

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

