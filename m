Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A9D2030B
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794317; cv=none; b=ETyflnfufkCSQXdROcCtolQ2KY/b8ZkelCCXsiw3bmwxQZsGpWFIH3p8tc6S/bslo62zjys2uMy8e05VgPHBTUH9nYMbhSegpyF5F+xOQfsS0RsFfdrRXYyuagWzvs7wmSHtra0NHvNkNWKG7oACwHDx0METFIS+0TNDlfho4mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794317; c=relaxed/simple;
	bh=Nkjn0kW03EX9NQ3TjMZ7AFQJxjqx9xaHW8JdILquVlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IqxdRFFC2+Go+qQKBMw3Wyiw3I2rUNVgXQNi5HPJZ0ZMfoCtsaEvgsmKRF+BAd101766/PLPZDZ6voDe7Hh410fO1oqKxzvM+JQIgBSHVLReYxpyaYTTwdRmh/BQLRfigW7MYQblkNYPO29i/xdAmeCN2kVZwj5aZTU/bQUzmag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k+IMhwxE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k+IMhwxE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42IKNAXJ032645;
	Mon, 18 Mar 2024 20:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=wSjgIYOKp2lEYtGH3CVi9Nv9iBSWo8khr4Kv0ATiydc=;
 b=k+IMhwxEgUSyU0MfXGHPgI3wMEM+/OJLrTYoOk9MRzSUJUjoTIYKukWMkj3Utb0Y1hR/
 5/lFAem4aoqAwbp28D7ZYeGlfqcm1a7lomfrsEJ2e3M7wCEmMDKP94++qeavhT5ajdqv
 fuhu+HkFurFoWSsST0iGHKACoMBZ4cIzP0z9DkJIbU3E8FqM3daVd5sr7jn2fwTLHHwF
 n/S/Vtk0LSIZuAygOXeC5DsMz9+KO0L/SHAfomKt/AxnHUH77D5mMb1jliFu+jXZId5K
 rJ3zplycoaJ0Y4Y2AmZGBOTjXzei5USAADcdLetM8xgLwUvo6HI1Wr8cG5NB+HgS4/Ss gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wxvkmg2uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 20:38:30 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42IKcUfH028387;
	Mon, 18 Mar 2024 20:38:30 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wxvkmg2uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 20:38:30 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42IHSZkK017190;
	Mon, 18 Mar 2024 20:38:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwnrt3d9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 20:38:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42IKcOfo37028284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 20:38:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDBF920043;
	Mon, 18 Mar 2024 20:38:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F09420040;
	Mon, 18 Mar 2024 20:38:23 +0000 (GMT)
Received: from heavy (unknown [9.171.85.188])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 18 Mar 2024 20:38:23 +0000 (GMT)
Date: Mon, 18 Mar 2024 21:38:22 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Kui-Feng Lee <sinquersw@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: Crash caused by 778666df60f0 ("s390: compile relocatable kernel
 without -fPIE")
Message-ID: <ig5bw37zznqrokjeyloobncubiy6bqxh6drszewjkby56y55by@o64a2x4zqo5v>
References: <c9923c1d-971d-4022-8dc8-1364e929d34c@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9923c1d-971d-4022-8dc8-1364e929d34c@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cW9Er-VX4-jw3BNRxRxvOCrPR7Q15W-s
X-Proofpoint-ORIG-GUID: 0JsM_eqtiVcG8dtPG9sHdlFpevqRYs0Z
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180156

On Fri, Mar 15, 2024 at 09:59:52AM -0700, Kui-Feng Lee wrote:
> Hi Josh, Sumath, and Heiko,
> 
> Recently, all patches submitted to bpf have been failing the selftest
> "dummy_st_ops/dummy_init_ptr_arg" on the s390x platform. Upon
> investigation, it was determined that a specific patch, 778666df60f0
> ("s390: compile relocatable kernel without -fPIE"), is causing the problem.
> It is the first bad after bisecting. Please take a look.
> Thank you!
> 
> You can reproduce it by running the command
> 
>     ./test_progs -a dummy_st_ops/dummy_init_ptr_arg
> 
> in the tools/testing/selftests/bpf directory in the Linux source tree.
> This command causes a kernel crash with the following messages. It
> appears to be related to attaching a trace program at the fentry of a
> struct_ops operator. The same operator works fine without the trace
> program. For more details about the test case, please check
> dummy_st_ops.c in tools/testing/selftests/bpf/prog_tests/.
> 
> illegal operation: 0001 ilc:1 [#1] SMP
> Modules linked in:
> CPU: 0 PID: 82 Comm: test_progs Tainted: G           OE
> 6.8.0-rc3-g778666df60f0 #34
> Hardware name: QEMU 3906 QEMU (KVM/Linux)
> Krnl PSW : 0704d00180000000 0000000000000002 (0x2)
>            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
> Krnl GPRS: 000003ff800a4956 0000000000000000 0000038000a73d20
> 0000000082a08b58
>            0000000000000000 000000007083ede2 0000000000000000
> 0000000000000001
>            00000000009d580e 000000008286bc00 0000037f000000d8
> 000003ff800b2000
>            0000000081a43c00 00000000011bfe20 000003ff800b208e
> 0000038000a73c68
> Krnl Code:#0000000000000000: 0000               illegal
>           >0000000000000002: 0000               illegal
>            0000000000000004: 0000               illegal
>            0000000000000006: 0000               illegal
>            0000000000000008: 0000               illegal
>            000000000000000a: 0000               illegal
>            000000000000000c: 0000               illegal
>            000000000000000e: 0000               illegal
> Call Trace:
>  [<0000000000000002>] 0x2
>  [<00000000009d5cde>] bpf_struct_ops_test_run+0x156/0x250
>  [<000000000033145a>] __sys_bpf+0xa1a/0xd00
>  [<00000000003319dc>] __s390x_sys_bpf+0x44/0x50
>  [<0000000000c4382c>] __do_syscall+0x244/0x300
>  [<0000000000c59a40>] system_call+0x70/0x98
> INFO: lockdep is turned off.
> Last Breaking-Event-Address:
>  [<000003ff800a49ac>] bpf_prog_83ebf4e90b071f2b_test_1+0x5c/0x70
> Kernel panic - not syncing: Fatal exception: panic_on_oops
> 
> 
> [1]
> https://github.com/kernel-patches/bpf/actions/runs/8297891630/job/22710267571

Hi,

thanks for the report, I'm currently looking into it.

The problem is that the following:

static void bpf_jit_plt(void *plt, void *ret, void *target)
{
	memcpy(plt, bpf_plt, BPF_PLT_SIZE);
	*(void **)((char *)plt + (bpf_plt_ret - bpf_plt)) = ret;
	*(void **)((char *)plt + (bpf_plt_target - bpf_plt)) = target ?: ret;
}

is (mis)compiled to the following:

   0x000000000017a26e <+238>:   stg     %r4,232(%r3,%r15)
   0x000000000017a274 <+244>:   ltgr    %r11,%r11
   0x000000000017a278 <+248>:   locgrne %r4,%r11
   0x000000000017a27c <+252>:   stg     %r4,232(%r1,%r15)
   0x000000000017a282 <+258>:   la      %r3,232(%r1,%r15)
   0x000000000017a286 <+262>:   lghi    %r4,8
   0x000000000017a28a <+266>:   mvc     232(16,%r15),0(%r2)
   0x000000000017a290 <+272>:   mvc     248(16,%r15),16(%r2)

Note that memcpy() and assignments are reordered, and this is causing
the crash. The C code violates the strict aliasing rules, but this
should be irrelevant for the kernel.

The problem does not occur with the latest GCC. Bisect says that the
following commit fixed it:

commit 2e96b5f14e4025691b57d2301d71aa6092ed44bc                                                          
Author: Aldy Hernandez <aldyh@redhat.com>                                                                
Date:   Tue Jun 15 12:32:51 2021 +0200                                                                   
                                                                                                         
    Backwards jump threader rewrite with ranger.

but I think that's accidental. The reordering is done by the sched1
pass. I plan to find out why it thinks it's okay to reorder these
memory accesses.

Best regards,
Ilya
