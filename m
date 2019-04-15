Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F11C10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 18:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA04205F4
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 18:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfDOSVn convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Mon, 15 Apr 2019 14:21:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726600AbfDOSVn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Apr 2019 14:21:43 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3FI8oKi137899
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 14:21:42 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rvw9fd1b3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 14:21:41 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Mon, 15 Apr 2019 19:21:40 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Apr 2019 19:21:37 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3FILbsM58130438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 18:21:37 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC08B4C04E;
        Mon, 15 Apr 2019 18:21:36 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D9724C040;
        Mon, 15 Apr 2019 18:21:36 +0000 (GMT)
Received: from localhost (unknown [9.84.231.216])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Apr 2019 18:21:36 +0000 (GMT)
Date:   Mon, 15 Apr 2019 23:51:35 +0530
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
In-Reply-To: <874l6zfr4f.fsf@netronome.com>
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19041518-0016-0000-0000-0000026F18E9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041518-0017-0000-0000-000032CB5F92
Message-Id: <1555352013.198bf870q9.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904150126
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jiong Wang wrote:
> 
> It will be great if you could test the latest set on PowerPC to see if
> there is any regression for example for those under test_progs and
> test_verifier.

With test_bpf, I am seeing a few failures with this patchset.

> 
> And it will be even greater if you also use latest llvm snapshot for the
> testing, which then will enable test_progs_32 etc.

Is a newer llvm a dependency? Or, is this also expected to work with 
older llvm levels?

The set of tests that are failing are listed further below. I looked 
into MUL_X2 and it looks like zero extension for the two initial ALU32 
loads (-1) are being removed, resulting in the failure.

I didn't get to look into this in detail -- am I missing something?


- Naveen


---
$ cat ~/jit_fail.out | grep -v "JIT code" | grep -B4 FAIL
test_bpf: #38 INT: MUL_X2 Pass 1: shrink = 0, seen = 0x0
Pass 2: shrink = 0, seen = 0x0
flen=9 proglen=64 pass=3 image=d000000006bfca9c from=insmod pid=8923
jited:1 ret -1 != 1 FAIL (1 times)
test_bpf: #39 INT: MUL32_X 
Pass 1: shrink = 0, seen = 0x0
Pass 2: shrink = 0, seen = 0x0
flen=9 proglen=64 pass=3 image=d000000006c335fc from=insmod pid=8923
jited:1 ret -1 != 1 FAIL (1 times)

test_bpf: #49 INT: shifts by register 
Pass 1: shrink = 0, seen = 0x0
Pass 2: shrink = 0, seen = 0x0
flen=30 proglen=192 pass=3 image=d000000006eb80e4 from=insmod pid=8923
jited:1 ret -1234 != -1 FAIL (1 times)

test_bpf: #68 ALU_MOV_K: 0x0000ffffffff0000 = 0x00000000ffffffff 
Pass 1: shrink = 0, seen = 0x0
Pass 2: shrink = 0, seen = 0x0
flen=10 proglen=76 pass=3 image=d000000007290e48 from=insmod pid=8923
jited:1 ret 2 != 1 FAIL (1 times)

test_bpf: #75 ALU_ADD_X: 2 + 4294967294 = 0 
Pass 1: shrink = 0, seen = 0x0
Pass 2: shrink = 0, seen = 0x0
flen=10 proglen=64 pass=3 image=d0000000074537b0 from=insmod pid=8923
jited:1 ret 0 != 1 FAIL (1 times)

test_bpf: #82 ALU_ADD_K: 4294967294 + 2 = 0 
Pass 1: shrink = 0, seen = 0x0
Pass 2: shrink = 0, seen = 0x0
flen=8 proglen=60 pass=3 image=d00000000761af8c from=insmod pid=8923
jited:1 ret 0 != 1 FAIL (1 times)
test_bpf: #83 ALU_ADD_K: 0 + (-1) = 0x00000000ffffffff 
Pass 1: shrink = 0, seen = 0x0
Pass 2: shrink = 0, seen = 0x0
flen=10 proglen=64 pass=3 image=d0000000076579dc from=insmod pid=8923
jited:1 ret 2 != 1 FAIL (1 times)

test_bpf: #86 ALU_ADD_K: 0 + 0x80000000 = 0x80000000 
Pass 1: shrink = 0, seen = 0x0
Pass 2: shrink = 0, seen = 0x0
flen=10 proglen=64 pass=3 image=d000000007719958 from=insmod pid=8923
jited:1 ret 2 != 1 FAIL (1 times)
test_bpf: #87 ALU_ADD_K: 0 + 0x80008000 = 0x80008000 
Pass 1: shrink = 0, seen = 0x0
Pass 2: shrink = 0, seen = 0x0
flen=10 proglen=72 pass=3 image=d000000007752510 from=insmod pid=8923
jited:1 ret 2 != 1 FAIL (1 times)

test_bpf: #118 ALU_MUL_K: 1 * (-1) = 0x00000000ffffffff 
Pass 1: shrink = 0, seen = 0x0
Pass 2: shrink = 0, seen = 0x0
flen=10 proglen=64 pass=3 image=d000000007f184f8 from=insmod pid=8923
jited:1 ret 2 != 1 FAIL (1 times)

test_bpf: #371 JNE signed compare, test 1 
Pass 1: shrink = 0, seen = 0x0
Pass 2: shrink = 0, seen = 0x0
flen=8 proglen=60 pass=3 image=d000000002394ab8 from=insmod pid=8923
jited:1 ret 2 != 1 FAIL (1 times)
test_bpf: #372 JNE signed compare, test 2 
Pass 1: shrink = 0, seen = 0x0
Pass 2: shrink = 0, seen = 0x0
flen=8 proglen=60 pass=3 image=d0000000023d98b4 from=insmod pid=8923
jited:1 ret 2 != 1 FAIL (1 times)

Pass 1: shrink = 0, seen = 0x18
Pass 2: shrink = 0, seen = 0x18
flen=13 proglen=92 pass=3 image=d0000000025105f8 from=insmod pid=8923
jited:1 12 PASS
test_bpf: Summary: 366 PASSED, 12 FAILED, [366/366 JIT'ed]



