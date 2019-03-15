Return-Path: <SRS0=GcXc=RS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC38C43381
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 13:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6091921871
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 13:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbfCONQ6 convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 15 Mar 2019 09:16:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726875AbfCONQ6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 Mar 2019 09:16:58 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2FDEKnw145861
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2019 09:16:57 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r8au9pkej-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2019 09:16:57 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <naveen.n.rao@linux.ibm.com>;
        Fri, 15 Mar 2019 13:16:55 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 15 Mar 2019 13:16:50 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2FDGn7M30015550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Mar 2019 13:16:49 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A49F411C054;
        Fri, 15 Mar 2019 13:16:49 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DECA11C064;
        Fri, 15 Mar 2019 13:16:49 +0000 (GMT)
Received: from localhost (unknown [9.78.193.169])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 15 Mar 2019 13:16:49 +0000 (GMT)
Date:   Fri, 15 Mar 2019 18:46:45 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: bpf jit PPC64 (BE) test_verifier PTR_TO_STACK store/load failure
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>, netdev@vger.kernel.org,
        Sandipan Das <sandipan@linux.ibm.com>
References: <xuny4l87qc2v.fsf@redhat.com>
        <20190313221436.GO3969@gate.crashing.org>
In-Reply-To: <20190313221436.GO3969@gate.crashing.org>
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19031513-4275-0000-0000-0000031B6412
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031513-4276-0000-0000-00003829D9E0
Message-Id: <1552655762.yswcan0ziz.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-15_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=687 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903150094
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Segher Boessenkool wrote:
> Hi!
> 
> On Wed, Mar 13, 2019 at 12:54:16PM +0200, Yauheni Kaliuta wrote:
>> This is because of the handling of the +2 offset.
> 
> The low two bits of instructions with primary opcodes 58 and 62 are part
> of the opcode, not the offset.  These instructions can not have offsets
> with the low two bits non-zero.
> 
>> For stores it is:
>> #define PPC_STD(r, base, i)	EMIT(PPC_INST_STD | ___PPC_RS(r) |	      \
>> 				     ___PPC_RA(base) | ((i) & 0xfffc))
>> 
>> and for loads
>> #define PPC_LD(r, base, i)	EMIT(PPC_INST_LD | ___PPC_RT(r) |	      \
>> 				     ___PPC_RA(base) | IMM_L(i))
>> #define IMM_L(i)		((uintptr_t)(i) & 0xffff)
>> 
>> So, in the load case the offset +2 (immediate value) is not
>> masked and turns the instruction to lwa instead of ld.
>> 
>> Would it be correct to & 0xfffc the immediate value as well?
> 
> That is only part of it.  The other thing is you have to make sure those
> low bits are zero *already* (and then you do not need the mask anymore).
> For example, if the low two bits are not zero load the offset into a
> register instead (and then do ldx or lwax).

Thanks for pointing that out, Segher. That is a detail that is easily 
missed.

- Naveen


