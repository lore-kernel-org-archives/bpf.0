Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98914C43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 00:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6FE2087E
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 00:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732553AbfCAA2u (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 19:28:50 -0500
Received: from www62.your-server.de ([213.133.104.62]:60448 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfCAA2t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 19:28:49 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzW2h-00021r-1P; Fri, 01 Mar 2019 01:28:47 +0100
Received: from [178.197.248.21] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzW2g-000DlR-Q7; Fri, 01 Mar 2019 01:28:46 +0100
Subject: Re: [PATCH bpf-next 3/4] bpf: fix formatting, typos, reflow comments
 in syscall.c, verifier.c
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Song Liu <liu.song.a23@gmail.com>, Andrii Nakryiko <andriin@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@fb.com,
        yhs@fb.com, Networking <netdev@vger.kernel.org>,
        bpf@vger.kernel.org
References: <20190228184512.198075-1-andriin@fb.com>
 <20190228184512.198075-4-andriin@fb.com>
 <CAPhsuW6tDGhi3ROVsLU4j37_Xp7xbV=jnEQ5ce-fV=vdCaJ-BQ@mail.gmail.com>
 <23253537-2a33-9546-7ed2-0abb6e7de420@iogearbox.net>
Message-ID: <831958de-985b-d150-d0d0-296e6c6cbec4@iogearbox.net>
Date:   Fri, 1 Mar 2019 01:28:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <23253537-2a33-9546-7ed2-0abb6e7de420@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/01/2019 01:27 AM, Daniel Borkmann wrote:
> On 02/28/2019 11:40 PM, Song Liu wrote:
>> On Thu, Feb 28, 2019 at 10:59 AM Andrii Nakryiko <andriin@fb.com> wrote:
>>>
>>> Fix few formatting errors. Fix few typos and reflow long descriptive
>>> comments for more even text fill.
>>>
>>> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
>>
>> I think we should not change the code for formatting, as these changes make
>> git-blame more difficult. How about we only make changes to comments?
> 
> Kind of true, though git blame is imho not too useful (unless I'm missing
> some git magic :)); git log -p has much more historical context to search
> through. I think these cleanups below are okay, though my worry is that
> for someone doing backports changes that are scattered like this mainly
> cause conflicts which then gets painful to resolve. I think we could make
> it work if they are split and more isolated, e.g. syscall ones could be
> one commit, another one only touching the big contiguous verifier comment,
> and so on.

(Ideally also separate from the doc-only patches which is the rest of your
 series.)
