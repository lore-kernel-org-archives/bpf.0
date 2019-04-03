Return-Path: <SRS0=5VBK=SF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B16AC4360F
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 15:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E7E206BA
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 15:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfDCPws (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:52:48 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:55190 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726105AbfDCPws (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Apr 2019 11:52:48 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us4.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 06465BC0081;
        Wed,  3 Apr 2019 15:52:46 +0000 (UTC)
Received: from [10.17.20.203] (10.17.20.203) by ocex03.SolarFlarecom.com
 (10.20.40.36) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 3 Apr
 2019 08:52:41 -0700
Subject: Re: [PATCH bpf] bpf: report verifier bugs as warnings
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Paul Chaignon <paul.chaignon@orange.com>,
        Alexei Starovoitov <ast@kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>
CC:     Xiao Han <xiao.han@orange.com>, <paul.chaignon@gmail.com>,
        "Martin KaFai Lau" <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
References: <20190402115811.GA6303@Nover>
 <a79d7f5e-637e-df0a-e99c-beea05eca1d7@iogearbox.net>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <9d809442-b652-f68f-70e7-8be703c97244@solarflare.com>
Date:   Wed, 3 Apr 2019 16:52:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <a79d7f5e-637e-df0a-e99c-beea05eca1d7@iogearbox.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.203]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24528.005
X-TM-AS-Result: No-5.355300-4.000000-10
X-TMASE-MatchedRID: e/tT8EyIjJQOwH4pD14DsPHkpkyUphL9KFFZAe4nyZ5sXGlmkQWwsCzy
        bVqWyY2NFuS+8GNNHS+urdQscOSCTRNj8dEIVpt0ngIgpj8eDcByZ8zcONpAsdmzcdRxL+xwKra
        uXd3MZDVhVjtTUlKR4H1uIBTEpt80HECz++a6QYTtMSE9ffDCoz6ucoe3DU4s
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.355300-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24528.005
X-MDID: 1554306767-1zfpaYD96lLQ
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/04/2019 15:37, Daniel Borkmann wrote:
> If we really want to have a kernel warn, then lets add a
> helper macro verbose_and_warn(...) which will trigger a one-time warning, but keeps
> the verbose log intact as well.
+1

Any time the verifier detects that its internal invariants have been broken,
 logging a warning is the right thing to do, just like any other part of the
 kernel.
