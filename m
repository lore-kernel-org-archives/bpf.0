Return-Path: <SRS0=GkhW=CL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A6DC433E2
	for <bpf@archiver.kernel.org>; Wed,  2 Sep 2020 23:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 841B420758
	for <bpf@archiver.kernel.org>; Wed,  2 Sep 2020 23:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fVxSCs9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgIBXmb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 2 Sep 2020 19:42:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44794 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIBXmb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Sep 2020 19:42:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082Ndvx6065867;
        Wed, 2 Sep 2020 23:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=9S3DOg9tyQiFTHK6wGQMGdK+8WlNTTQMmP5/STXPFSk=;
 b=fVxSCs9bovFYqBQI88986wd383E3G0JsXZicDUoN873M892S42SYMX2qTrJzL1CA84+H
 8mWHY+hEiTdA0TbpxaBThe0tDaUnvvBd+b/nq1DUUvp8hoRFcR7N5p++vv+sVwS4zTJm
 vOum4QSzAp3hBNPOvfaoGSpHBeY4mRMoT8n2K469LGYenQsPCtJ95R9DhEGBdL3viPGe
 h4pQnKjnunuTuXiPXultFdcwoTGgLtF3OwhuxCuB+pRwxm3vx+/KxszpTnDD05S8n/yU
 Z/p3JINsg05jRoW4Bxn11iaB7sbs6ZFGWyq0xPn52LE1xuUB09ItgL/k5kAyZnTkzXoy rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 339dmn45nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Sep 2020 23:42:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082NdkiO075709;
        Wed, 2 Sep 2020 23:40:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 3380y0phrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Sep 2020 23:40:16 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 082NeF5K020202;
        Wed, 2 Sep 2020 23:40:15 GMT
Received: from termi.oracle.com (/10.175.48.72)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 16:40:14 -0700
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     David Miller <davem@davemloft.net>
Cc:     daniel@iogearbox.net, alexei.starovoitov@gmail.com,
        bpf@vger.kernel.org
Subject: Re: EF_BPF_GNU_XBPF
References: <87o8mn281a.fsf@oracle.com>
        <d0a6eb38-76a4-b335-878b-647fe68f937a@iogearbox.net>
        <87k0xb25kw.fsf@oracle.com>
        <20200902.162222.1706338150182336333.davem@davemloft.net>
Date:   Thu, 03 Sep 2020 01:40:10 +0200
In-Reply-To: <20200902.162222.1706338150182336333.davem@davemloft.net> (David
        Miller's message of "Wed, 02 Sep 2020 16:22:22 -0700 (PDT)")
Message-ID: <87blin21et.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=723 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020222
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=725 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020222
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


>> 1) Due to BPF being so restrictive, many hundreds of GCC tests won't
>>    even build, because they use functions having more than 5 arguments,
>>    or functions with too big stack frames, or indirect calls, etc.  We
>>    want to be able to test our backend properly, so we added the -mxbpf
>>    option in order to relax some of these restrictions.
>> 
>> 2) We are working on a BPF simulator that works with GDB.  For that to
>>    work, we needed to add a "breakpoint" instruction that GDB can patch
>>    in the program.  Having a simulator also allows us to run more GCC
>>    tests.
>> 
>> 3) With some extensions, it becomes possible to support DWARF call frame
>>    information, and therefore to debug BPF programs in GDB with
>>    unwinding support.  You can build with -mxbpf, debug, then build
>>    again without -mxbpf.
>
> All sounds like features to propose for BPF itself, rather than throw
> into some weird extension.
>
> Why not come to the bpf community and discuss the need for these
> features?

Well, as I said these features are mainly intended for the benefit of
the tooling side.  But of course if some of them are deemed useful
enough (and feasible) to be added to BPF proper, then great!

As for discussion, here I am, as I was in LPC :)
