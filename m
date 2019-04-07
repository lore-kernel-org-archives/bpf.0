Return-Path: <SRS0=hr/i=SJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE568C10F0E
	for <bpf@archiver.kernel.org>; Sun,  7 Apr 2019 18:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2DC21738
	for <bpf@archiver.kernel.org>; Sun,  7 Apr 2019 18:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfDGSfM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 7 Apr 2019 14:35:12 -0400
Received: from www62.your-server.de ([213.133.104.62]:57932 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfDGSfM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Apr 2019 14:35:12 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hDCdI-0002bu-Uh; Sun, 07 Apr 2019 20:35:09 +0200
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hDCdI-0001QB-Mt; Sun, 07 Apr 2019 20:35:08 +0200
Subject: Re: [PATCH bpf-next v4 01/16] bpf: implement lookup-free direct value
 access for maps
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
        joe@wand.net.nz, yhs@fb.com, andrii.nakryiko@gmail.com,
        kafai@fb.com
References: <cover.1554497408.git.daniel@iogearbox.net>
 <777f5dda5ef99c1a1cb30dec46f64c1bc814552e.1554497408.git.daniel@iogearbox.net>
 <20190406015621.4yrcolqkweg3c2xy@ast-mbp.dhcp.thefacebook.com>
 <2389ce8e-55d4-226d-55f3-29190199bb8d@iogearbox.net>
 <20190406165449.oziv6pr4ylpvmi3b@ast-mbp.dhcp.thefacebook.com>
 <e576da84-4117-3988-25b8-65c32609c929@iogearbox.net>
 <20190407025744.ubfyynousc7rnyou@ast-mbp.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <981056a8-4350-e455-cfed-8fd0c8af58e4@iogearbox.net>
Date:   Sun, 7 Apr 2019 20:35:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190407025744.ubfyynousc7rnyou@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25412/Sun Apr  7 09:51:34 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/07/2019 04:57 AM, Alexei Starovoitov wrote:
[...]
> I don't get this shadow vs normal .data idea.
> The more we talk the more I'm convinced that this is not a good api.
> Say in the future we indeed have these shadow + normal .data
> then just use the same insn->imm field to refer to shadow part.
> Even if there are N such regions. The value_size is known.
> So use 0<=imm<value_size to refer to 'index' 0 and
> value_size<=imm<value_size*2 to refer to 'index' 1.
> There is absolutely no need for offset and index to be separate.
> Address of a byte inside bpf array can be expressed with single integer.

Hmm, fair enough, I guess it also always boils down to the same, that
is, discussing such facility once the need comes up and given neither
of us would have a need right now, I'll just respin on Monday morning
with the index bit removed as I had it originally. Lets extend it only
upon need, probably good we discussed it through. :-)

Thanks,
Daniel
