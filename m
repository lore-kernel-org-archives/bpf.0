Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1725C4321A
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 14:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF792077B
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 14:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfDZOuk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:50:40 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:54712 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbfDZOuk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Apr 2019 10:50:40 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us3.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 31109B40077;
        Fri, 26 Apr 2019 14:50:39 +0000 (UTC)
Received: from [10.17.20.203] (10.17.20.203) by ocex03.SolarFlarecom.com
 (10.20.40.36) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 26 Apr
 2019 07:50:35 -0700
Subject: Re: 32-bit zext time complexity (Was Re: [PATCH bpf-next]
 selftests/bpf: two scale tests)
To:     Jiong Wang <jiong.wang@netronome.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Alexei Starovoitov <ast@kernel.org>, <daniel@iogearbox.net>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "oss-drivers@netronome.com" <oss-drivers@netronome.com>
References: <20190412214132.2726285-1-ast@kernel.org>
 <lyimv3hujp.fsf@netronome.com>
 <20190425043347.pxrz5ln4m7khebt6@ast-mbp.dhcp.thefacebook.com>
 <lylfzyeebr.fsf@netronome.com>
 <20190425221021.ov2jj4piann7wmid@ast-mbp.dhcp.thefacebook.com>
 <lyk1fgrk4m.fsf@netronome.com>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <6757534d-4d0d-6698-7536-118fed7be977@solarflare.com>
Date:   Fri, 26 Apr 2019 15:50:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <lyk1fgrk4m.fsf@netronome.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.203]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24574.005
X-TM-AS-Result: No-1.370600-4.000000-10
X-TMASE-MatchedRID: bPjU8R/NGeGA4OBLF/NjnPHkpkyUphL9x287VGn6yCbJYIv7y0tu9h6X
        t43iYu8Eb6RLDfMw9+3tspKmCJnCgZRDqz2cfczkj56aIafJ4NF+tO36GYDlsvPSh/c6gMpwQQ/
        s9vEJJncMEf4xK99DRBVl0jjUNRIWXiLllvPjd++VSBCoZUyqbCGi0ftsSkQy5/iV6d9/1p2jxY
        yRBa/qJUl4W8WVUOR/9xS3mVzWUuCMx6OO8+QGvoqvfqST1Zg40UpD48vNi5soy4HgqCn1W1dOB
        jGtw2hHsWcpwRLSR86WDgOnccY+zkq+EHpBzzAJb3s5m4S2Z09qylLeBesRhdQ17CngTb9OBKmZ
        VgZCVnezGTWRXUlrxxtsJUxyzWNSVlxr1FJij9s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.370600-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24574.005
X-MDID: 1556290240-WFmkKwsndFO2
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 26/04/2019 14:06, Jiong Wang wrote:
> Alexei Starovoitov writes:
>> Note that bpf_patch_insn_single() is calling bpf_adj_branches() twice too.
>> And dead_code + convert_ctx + fixup_bpf_calls are calling
>> bpf_patch_insn_single() a lot.
>> How about before dead_code pass we convert the program into basic-block
>> format, patch it all, and then convert from bb back to offsets.
>> Patching will become very cheap, since no loop over program will be
>> necessary. A jump from bb-N to bb-M will stay as-is regardless
>> of amount of patching was done inside each bb.
>> The loops inside these patching passes will be converted from:
>> for (i = 0; i < insn_cnt; i++, insn++)
>> into:
>> for each bb
>>   for each insn in bb
> Interesting. If I am understanding correctly, BB then needs to support
> dynamic insn buffer resize. And after all insn patching finished, all BBs
> are finalized, we then linearized BBs (in a best order) to generate the
> final bpf image.
Does any verifier metadata ever take the index of an insn that was added by
 patching?  If not, then we could have, instead of an array of insns, an
 array of list_heads, each of which is a list of insns (plus aux data etc.).
At entry the original program is converted into an array of 1-element lists.
On patching we edit the list, which doesn't change the index of any insn.
Then after all insn patching finishes, we linearise as above.

Just a thought,
-Ed
