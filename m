Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D3AC10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 09:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF9C2073F
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 09:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbfDOJ76 convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Mon, 15 Apr 2019 05:59:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52544 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725779AbfDOJ76 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Apr 2019 05:59:58 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3F9xseK065715
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 05:59:57 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rvq0k2fff-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 05:59:56 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Mon, 15 Apr 2019 10:59:42 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Apr 2019 10:59:39 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3F9xcgu53608698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 09:59:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14A1311C050;
        Mon, 15 Apr 2019 09:59:38 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B618311C04C;
        Mon, 15 Apr 2019 09:59:37 +0000 (GMT)
Received: from localhost (unknown [9.124.35.82])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Apr 2019 09:59:37 +0000 (GMT)
Date:   Mon, 15 Apr 2019 15:29:35 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 bpf-next 08/19] bpf: insert explicit zero extension
 insn when hardware doesn't do it implicitly
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        Jiong Wang <jiong.wang@netronome.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
References: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
        <1555106392-20117-9-git-send-email-jiong.wang@netronome.com>
In-Reply-To: <1555106392-20117-9-git-send-email-jiong.wang@netronome.com>
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19041509-0020-0000-0000-0000032FEA2A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041509-0021-0000-0000-000021822889
Message-Id: <1555321893.44its0xa9r.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=873 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904150071
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jiong,

Jiong Wang wrote:
> After previous patches, verifier has marked those instructions that really
> need zero extension on dst_reg.

Thanks for implementing this -- this is very helpful on architectures 
without sub-register instructions, especially in comparison with legacy 
BPF, since the move to eBPF resulted in lot more instructions being 
generated.

I have a small nit below on the overall approach...

> 
> It is then for all back-ends to decide how to use such information to
> eliminate unnecessary zero extension code-gen during JIT compilation.
> 
> One approach is:
>   1. Verifier insert explicit zero extension for those instructions that
>      need zero extension.
>   2. All JIT back-ends do NOT generate zero extension for sub-register
>      write any more.

Is it possible to instead give a hint to the JIT back-ends on the 
instructions needing zero-extension? That would help in case of 
architectures that have single/more-optimal instruction for zero 
extension, compared to having to emit 2 instructions with the current 
approach.

- Naveen


