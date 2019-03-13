Return-Path: <SRS0=IWuG=RQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952AFC43381
	for <bpf@archiver.kernel.org>; Wed, 13 Mar 2019 13:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E20B2171F
	for <bpf@archiver.kernel.org>; Wed, 13 Mar 2019 13:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfCMNwK convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Wed, 13 Mar 2019 09:52:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727367AbfCMNwJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 Mar 2019 09:52:09 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2DDorrK026153
        for <bpf@vger.kernel.org>; Wed, 13 Mar 2019 09:52:08 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r70vmq89j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 Mar 2019 09:52:08 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <naveen.n.rao@linux.ibm.com>;
        Wed, 13 Mar 2019 13:52:05 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Mar 2019 13:52:02 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2DDq1Rh26279954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Mar 2019 13:52:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D23852050;
        Wed, 13 Mar 2019 13:52:01 +0000 (GMT)
Received: from localhost (unknown [9.77.212.5])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E0D9A5204F;
        Wed, 13 Mar 2019 13:52:00 +0000 (GMT)
Date:   Wed, 13 Mar 2019 19:21:18 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: bpf jit PPC64 (BE) test_verifier PTR_TO_STACK store/load failure
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
References: <xuny4l87qc2v.fsf@redhat.com>
In-Reply-To: <xuny4l87qc2v.fsf@redhat.com>
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19031313-0016-0000-0000-000002616607
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031313-0017-0000-0000-000032BC1363
Message-Id: <1552484985.k18yl73ww6.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-13_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=688 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903130100
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Yauheni Kaliuta wrote:
> Hi!
> 
> I found a failure:
> 
> ```
> # ./test_verifier 722
> #722/u PTR_TO_STACK store/load FAIL retval -1 != -87117812 
> 0: (bf) r1 = r10
> 1: (07) r1 += -10
> 2: (7a) *(u64 *)(r1 +2) = -87117812
> 3: (79) r0 = *(u64 *)(r1 +2)
> 4: (95) exit
> processed 5 insns (limit 131072), stack depth 8
> #722/p PTR_TO_STACK store/load FAIL retval -1 != -87117812 
> 0: (bf) r1 = r10
> 1: (07) r1 += -10
> 2: (7a) *(u64 *)(r1 +2) = -87117812
> 3: (79) r0 = *(u64 *)(r1 +2)
> 4: (95) exit
> processed 5 insns (limit 131072), stack depth 8
> Summary: 0 PASSED, 0 SKIPPED, 2 FAILED
> ```
> 
> The reason is in the JIT. The code is jitted into:
> 
> [...]
> d00000000580e7f8:       f9 23 00 00     std     r9,0(r3)
> d00000000580e7fc:       e9 03 00 02     lwa     r8,0(r3)
> [...]
> 
> so, it stores DW to the location r3, but loads W, i.e. in BE it is:
> 
> saves
> r3: FF FF FF FF FA CE B0 0C
> loads
> r3: FF FF FF FF
> 
> (in LE it works semicorretly, saves 0C B0 CE FA FF FF FF FF, loads 0C B0 CE FA)
> 
> This is because of the handling of the +2 offset. For stores it is:
> 
> 
> #define PPC_STD(r, base, i)	EMIT(PPC_INST_STD | ___PPC_RS(r) |	      
> \
> 				     ___PPC_RA(base) | ((i) & 0xfffc))
> 
> and for loads
> #define PPC_LD(r, base, i)	EMIT(PPC_INST_LD | ___PPC_RT(r) |	      \
> 				     ___PPC_RA(base) | IMM_L(i))
> #define IMM_L(i)		((uintptr_t)(i) & 0xffff)
> 
> So, in the load case the offset +2 (immediate value) is not
> masked and turns the instruction to lwa instead of ld.

Indeed -- good catch and analysis!

> 
> 
> Would it be correct to & 0xfffc the immediate value as well?

Yes, I think that would be the right fix.

> 
> BTW, the full run on big endian:
> 
> Summary: 1190 PASSED, 125 SKIPPED, 4 FAILED

Thanks for pointing that out, I'll look into these failures.


- Naveen


