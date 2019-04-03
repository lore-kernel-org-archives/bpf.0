Return-Path: <SRS0=5VBK=SF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538D2C4360F
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 20:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E6D20882
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 20:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfDCUYd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:24:33 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:36002 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbfDCUYd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Apr 2019 16:24:33 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us2.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 498A71C007A;
        Wed,  3 Apr 2019 20:24:30 +0000 (UTC)
Received: from [10.17.20.203] (10.17.20.203) by ocex03.SolarFlarecom.com
 (10.20.40.36) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 3 Apr
 2019 13:24:25 -0700
Subject: Re: [PATCH bpf] bpf: report verifier bugs as warnings
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Paul Chaignon <paul.chaignon@orange.com>,
        Alexei Starovoitov <ast@kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, Xiao Han <xiao.han@orange.com>,
        <paul.chaignon@gmail.com>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
References: <20190402115811.GA6303@Nover>
 <a79d7f5e-637e-df0a-e99c-beea05eca1d7@iogearbox.net>
 <9d809442-b652-f68f-70e7-8be703c97244@solarflare.com>
 <20190403173029.lfwhblklss62yone@ast-mbp.dhcp.thefacebook.com>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <af569c49-7131-dd06-bd2e-df100a11d4f9@solarflare.com>
Date:   Wed, 3 Apr 2019 21:24:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190403173029.lfwhblklss62yone@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.203]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24528.005
X-TM-AS-Result: No-3.311000-4.000000-10
X-TMASE-MatchedRID: sDm3xtR6Ud8OwH4pD14DsPHkpkyUphL9LAnNohUyMa2Qcp7izK6RGLou
        M63AneY0fVSuQp/lqth+NZ4lfSsps79ZdlL8eona0C1sQRfQzEHEQdG7H66TyMdRT5TQAJnA40G
        T9K1sSmKBGYN/3Ihyvt3x/Ve/8dJh+BcQ8JHNcGDi+fTMx9KaNitss6PUa4/cD6GAt+UbooSj1C
        O4X0Eqed8x3qzoMNxx
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.311000-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24528.005
X-MDID: 1554323072-1N15_s2zPChO
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/04/2019 18:30, Alexei Starovoitov wrote:
> verbose_and_warn() doesn't fit these two practical cases of warn + verbose.
> Hence I see no reason to combine warn and verbose into single helper.
> They're perfectly fine being separate.
Makes sense.

So presumably the right patch would be to add more appropriate (concise
 and less context-dependent) WARN messages alongside the verbose()s that
 Paul's patch changed?
