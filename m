Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141181364
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 01:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710899955; cv=none; b=ke+tZgdNm/3X2ZHMAXydMywMxwfir9NtsiHzS1iUOojYpmjnqAjIzJ496CeI1BkCPzDPDhDn+e5CPbPFQyKzTWJjfzbk4VNtNMo80NX48bnx483PGSMVMDb0vy+g+Xo6+hMACeCYOKWPB+ac/xh/1+ux1XCW16RKTbah5Bhdt8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710899955; c=relaxed/simple;
	bh=JuXcXYBR9nr16CjwKKjTP7TprArnVEEBIfgHn4nqKBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KC4UtEazzmMXou4VL7eWeDbsTdG+PQJSqUwaKJbY3vq+Pz2IqAXuesJEoJwl/4lzY2dPWYPpTR/hgEUvaosdiZZY59CNioMohZTZvuJ9lpKpTvaArgQU2XKLZofHiuYghs9wMPgtoHmzyVwhhC1CVsI7YwQ8e80O4+xXjs6S0+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g4dyr7VH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g4dyr7VH"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42K1Ma7s010934;
	Wed, 20 Mar 2024 01:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=MM5UX4HSKlHWhog/B5uTPyRpaYSc1z8GzuZGrpnltzc=;
 b=g4dyr7VHcL4wZj9iMnpPUX2e+yWkrnKp06oBUKvXFazHCXaVwZBUl31ehAcTFkXa6XmQ
 JsHJ7/UnyOQSGT9NWZIZgbrsFo9jN81/dBhGiFcWBWY2U2Yw5IBSaSl87OuGlxuAhzib
 rLpoksQHvXiCrEj0lbLkCja0m5rx8LvUXRqmL214TwjmsWgT/rnsgilUSJRR398R2E9n
 svbK5eGV0s1jfB+Txy/snadPAUPpn+6Tyj1zBRKFD91ZSPWovZU04nmvXfXaZkTq89Od
 GNQA/qgJat0H0GtjazQ4TG3qELwUDn68tfAppov+bFODgSUn/2Ya23pbrrKs7/pmPGoL 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyp2u01m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 01:59:08 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42K1x8in005707;
	Wed, 20 Mar 2024 01:59:08 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyp2u01m2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 01:59:08 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42K0r2Ct017218;
	Wed, 20 Mar 2024 01:59:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwnrtbp1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 01:59:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42K1x2Z826739264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 01:59:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17EB72004D;
	Wed, 20 Mar 2024 01:59:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A24120040;
	Wed, 20 Mar 2024 01:59:01 +0000 (GMT)
Received: from heavy (unknown [9.171.51.201])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 20 Mar 2024 01:59:01 +0000 (GMT)
Date: Wed, 20 Mar 2024 02:59:00 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kui-Feng Lee <sinquersw@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: Crash caused by 778666df60f0 ("s390: compile relocatable kernel
 without -fPIE")
Message-ID: <zltoaje3ekq44nvwkqc4aouoi5v2t4ayyd7hyyt5zgdoicrvuo@2ax4s7qlfont>
References: <c9923c1d-971d-4022-8dc8-1364e929d34c@gmail.com>
 <ig5bw37zznqrokjeyloobncubiy6bqxh6drszewjkby56y55by@o64a2x4zqo5v>
 <CAADnVQJS=YkUVfLgGxVe7kH8x4i560Z1Zx7+cv1AiwMvspXWJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQJS=YkUVfLgGxVe7kH8x4i560Z1Zx7+cv1AiwMvspXWJQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mkDYGqnEg9UWxsQ5boBkPXyMaLSzE_hl
X-Proofpoint-ORIG-GUID: DhSbzRBrHpPr4TpE2mhdmcx2M3FiazOa
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200013

On Mon, Mar 18, 2024 at 04:31:00PM -0700, Alexei Starovoitov wrote:
> On Mon, Mar 18, 2024 at 1:38 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >
> > On Fri, Mar 15, 2024 at 09:59:52AM -0700, Kui-Feng Lee wrote:
> > > Hi Josh, Sumath, and Heiko,
> > >
> > > Recently, all patches submitted to bpf have been failing the selftest
> > > "dummy_st_ops/dummy_init_ptr_arg" on the s390x platform. Upon
> > > investigation, it was determined that a specific patch, 778666df60f0
> > > ("s390: compile relocatable kernel without -fPIE"), is causing the problem.
> > > It is the first bad after bisecting. Please take a look.
> > > Thank you!
> > >
> > > You can reproduce it by running the command
> > >
> > >     ./test_progs -a dummy_st_ops/dummy_init_ptr_arg
> > >
> > > in the tools/testing/selftests/bpf directory in the Linux source tree.
> > > This command causes a kernel crash with the following messages. It
> > > appears to be related to attaching a trace program at the fentry of a
> > > struct_ops operator. The same operator works fine without the trace
> > > program. For more details about the test case, please check
> > > dummy_st_ops.c in tools/testing/selftests/bpf/prog_tests/.
> > >
> > > illegal operation: 0001 ilc:1 [#1] SMP
> > > Modules linked in:
> > > CPU: 0 PID: 82 Comm: test_progs Tainted: G           OE
> > > 6.8.0-rc3-g778666df60f0 #34
> > > Hardware name: QEMU 3906 QEMU (KVM/Linux)
> > > Krnl PSW : 0704d00180000000 0000000000000002 (0x2)
> > >            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
> > > Krnl GPRS: 000003ff800a4956 0000000000000000 0000038000a73d20
> > > 0000000082a08b58
> > >            0000000000000000 000000007083ede2 0000000000000000
> > > 0000000000000001
> > >            00000000009d580e 000000008286bc00 0000037f000000d8
> > > 000003ff800b2000
> > >            0000000081a43c00 00000000011bfe20 000003ff800b208e
> > > 0000038000a73c68
> > > Krnl Code:#0000000000000000: 0000               illegal
> > >           >0000000000000002: 0000               illegal
> > >            0000000000000004: 0000               illegal
> > >            0000000000000006: 0000               illegal
> > >            0000000000000008: 0000               illegal
> > >            000000000000000a: 0000               illegal
> > >            000000000000000c: 0000               illegal
> > >            000000000000000e: 0000               illegal
> > > Call Trace:
> > >  [<0000000000000002>] 0x2
> > >  [<00000000009d5cde>] bpf_struct_ops_test_run+0x156/0x250
> > >  [<000000000033145a>] __sys_bpf+0xa1a/0xd00
> > >  [<00000000003319dc>] __s390x_sys_bpf+0x44/0x50
> > >  [<0000000000c4382c>] __do_syscall+0x244/0x300
> > >  [<0000000000c59a40>] system_call+0x70/0x98
> > > INFO: lockdep is turned off.
> > > Last Breaking-Event-Address:
> > >  [<000003ff800a49ac>] bpf_prog_83ebf4e90b071f2b_test_1+0x5c/0x70
> > > Kernel panic - not syncing: Fatal exception: panic_on_oops
> > >
> > >
> > > [1]
> > > https://github.com/kernel-patches/bpf/actions/runs/8297891630/job/22710267571
> >
> > Hi,
> >
> > thanks for the report, I'm currently looking into it.
> >
> > The problem is that the following:
> >
> > static void bpf_jit_plt(void *plt, void *ret, void *target)
> > {
> >         memcpy(plt, bpf_plt, BPF_PLT_SIZE);
> >         *(void **)((char *)plt + (bpf_plt_ret - bpf_plt)) = ret;
> >         *(void **)((char *)plt + (bpf_plt_target - bpf_plt)) = target ?: ret;
> > }
> >
> > is (mis)compiled to the following:
> >
> >    0x000000000017a26e <+238>:   stg     %r4,232(%r3,%r15)
> >    0x000000000017a274 <+244>:   ltgr    %r11,%r11
> >    0x000000000017a278 <+248>:   locgrne %r4,%r11
> >    0x000000000017a27c <+252>:   stg     %r4,232(%r1,%r15)
> >    0x000000000017a282 <+258>:   la      %r3,232(%r1,%r15)
> >    0x000000000017a286 <+262>:   lghi    %r4,8
> >    0x000000000017a28a <+266>:   mvc     232(16,%r15),0(%r2)
> >    0x000000000017a290 <+272>:   mvc     248(16,%r15),16(%r2)
> >
> > Note that memcpy() and assignments are reordered, and this is causing
> > the crash. The C code violates the strict aliasing rules, but this
> > should be irrelevant for the kernel.
> >
> > The problem does not occur with the latest GCC. Bisect says that the
> > following commit fixed it:
> >
> > commit 2e96b5f14e4025691b57d2301d71aa6092ed44bc
> > Author: Aldy Hernandez <aldyh@redhat.com>
> > Date:   Tue Jun 15 12:32:51 2021 +0200
> >
> >     Backwards jump threader rewrite with ranger.
> >
> > but I think that's accidental. The reordering is done by the sched1
> > pass. I plan to find out why it thinks it's okay to reorder these
> > memory accesses.
> 
> Wow. What a discovery.
> Does this bug affect other architectures ?
> Probably yes, since it's sched1 pass ?
> Should we apply some workaround for now?

I think it's because bpf_jit_plt() violates the C pointer subtraction
rules (bpf_plt_ret and bpf_plt are different objects from the C
perspective), so it should not affect the other architectures, unless
they use the same pattern elsewhere.

So I posted a patch fixing this in bpf_jit_plt().
