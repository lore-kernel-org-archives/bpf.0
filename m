Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AE5C10F13
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 06:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD352073F
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 06:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfDPGlb convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 16 Apr 2019 02:41:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46896 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727569AbfDPGlb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 16 Apr 2019 02:41:31 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3G6esBo074168
        for <bpf@vger.kernel.org>; Tue, 16 Apr 2019 02:41:30 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rw870m8fw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 16 Apr 2019 02:41:29 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Tue, 16 Apr 2019 07:41:27 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 16 Apr 2019 07:41:25 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3G6fOgs42926098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Apr 2019 06:41:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B7ED52051;
        Tue, 16 Apr 2019 06:41:24 +0000 (GMT)
Received: from localhost (unknown [9.77.127.191])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 37DD25204F;
        Tue, 16 Apr 2019 06:41:24 +0000 (GMT)
Date:   Tue, 16 Apr 2019 12:11:22 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 bpf-next 08/19] bpf: insert explicit zero extension
 insn when hardware doesn't do it implicitly
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     alexei.starovoitov@gmail.com, bpf@vger.kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        oss-drivers@netronome.com
References: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
        <1555106392-20117-9-git-send-email-jiong.wang@netronome.com>
        <1555321893.44its0xa9r.naveen@linux.ibm.com>
        <1555322953.xj35xt2bjs.naveen@linux.ibm.com> <874l6zfr4f.fsf@netronome.com>
        <1555352013.198bf870q9.naveen@linux.ibm.com>
        <51F46782-5453-4A5F-A4E4-F53DBF4712AD@netronome.com>
In-Reply-To: <51F46782-5453-4A5F-A4E4-F53DBF4712AD@netronome.com>
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19041606-0028-0000-0000-000003614283
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041606-0029-0000-0000-000024207866
Message-Id: <1555396526.uk89zrw6ri.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-16_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160047
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jiong Wang wrote:
> 
>> On 15 Apr 2019, at 19:21, Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com> wrote:
>> 
>> Jiong Wang wrote:
>>> It will be great if you could test the latest set on PowerPC to see if
>>> there is any regression for example for those under test_progs and
>>> test_verifier.
>> 
>> With test_bpf, I am seeing a few failures with this patchset.
>> 
>>> And it will be even greater if you also use latest llvm snapshot for the
>>> testing, which then will enable test_progs_32 etc.
>> 
>> Is a newer llvm a dependency? Or, is this also expected to work with older llvm levels?
> 
> There is no newer LLVM dependency. This set should work with older llvm.        
>                                                                                 
> It is just newer LLVM has better sub-register code-gen support that could       
> the generate bpf program contains more elimination opportunities for verifier.

Ok, I will try and get to that by next week (busy with other things 
right now).

> 
>> 
>> The set of tests that are failing are listed further below. I looked into MUL_X2 and it looks like zero extension for the two initial ALU32 loads (-1) are being removed, resulting in the failure.
>> 
>> I didn't get to look into this in detail -- am I missing something?
> 
> Hmm, I guess the issue is:
>                                                                                 
>   1. test_bpf.c is a testsuite running inside kernel space, it is calling some
>      kernel eBPF jit interface directly without calling verifier first, so this
>      set actually hasn’t been triggered.

Ah, indeed.

> 
>   2. However, the elimination information at the moment is passed from verifier
>      to JIT backend through
> 
>        fp->aux->no_verifier_zext
> 
>      “no_verifier_zext” is initially false, and once verifier inserted zero
>      extension, it will be set to true.
> 
>      Now, for test_bpf, because it doesn’t go through verifier at all, so
>      “no_verifier_zext” is left at default value which is false, meaning
>      verifier has inserted zero-extension, so PPC backend then thinks it is
>      safe to eliminate zero-extension by himself.
> 
>      Perhaps should change “no_verifier_zext” to “verifier_zext”, then default
>      is false and will only be true when verifier really has inserted zext.

Yes, that's probably better.

>       
>      Was thinking, this will cause JIT backend writing the check like
>         if (no_verifier_zext)
>           insert_zext_by_JIT
>      
>      is better than:
>         
>         if (!verifier_zext)
>           insert_zext_by_JIT
> 
> BTW, does test_progs and test_verifier has a full pass on PowerPC?
> On arch without hardware zext like PowerPC, verifier will insert zext and test
> mode will still randomisation high 32-bit for those sub-registers not zext,
> this is very stressful test.

test_verfier is throwing up one failure with this patchset:
#569/p ld_abs: vlan + abs, test 1 FAIL
Failed to load prog 'Success'!
insn 2463 cannot be patched due to 16-bit range
verification time 172602 usec
stack depth 0
processed 30728 insns (limit 1000000) max_states_per_insn 1 total_states 1022 peak_states 1022 mark_read 1

This test passes with bpf-next/master. Btw, I tried with your v4 patches 
though I am replying here...

test_progs has no regression, but has 15 failures even without these 
patches that I need to look into.


- Naveen


