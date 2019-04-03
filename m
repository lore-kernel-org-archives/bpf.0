Return-Path: <SRS0=5VBK=SF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13104C4360F
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 22:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8AA206BA
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 22:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfDCWlh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:41:37 -0400
Received: from www62.your-server.de ([213.133.104.62]:44534 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCWlh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Apr 2019 18:41:37 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hBoZZ-0002pV-4n; Thu, 04 Apr 2019 00:41:33 +0200
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hBoZY-000QYU-UR; Thu, 04 Apr 2019 00:41:32 +0200
Subject: Re: [PATCH bpf] bpf: report verifier bugs as warnings
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Edward Cree <ecree@solarflare.com>
Cc:     Paul Chaignon <paul.chaignon@orange.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Xiao Han <xiao.han@orange.com>,
        paul.chaignon@gmail.com, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
References: <20190402115811.GA6303@Nover>
 <a79d7f5e-637e-df0a-e99c-beea05eca1d7@iogearbox.net>
 <9d809442-b652-f68f-70e7-8be703c97244@solarflare.com>
 <20190403173029.lfwhblklss62yone@ast-mbp.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4c5e5a55-5d53-f8cc-3628-9e20eb4137b0@iogearbox.net>
Date:   Thu, 4 Apr 2019 00:41:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190403173029.lfwhblklss62yone@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25408/Wed Apr  3 09:53:31 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/03/2019 07:30 PM, Alexei Starovoitov wrote:
> On Wed, Apr 03, 2019 at 04:52:40PM +0100, Edward Cree wrote:
>> On 02/04/2019 15:37, Daniel Borkmann wrote:
>>> If we really want to have a kernel warn, then lets add a
>>> helper macro verbose_and_warn(...) which will trigger a one-time warning, but keeps
>>> the verbose log intact as well.
>> +1
>>
>> Any time the verifier detects that its internal invariants have been broken,
>>  logging a warning is the right thing to do, just like any other part of the
>>  kernel.
> 
> It's not black and white.
> As I said I don't think verbose_and_warn() is necessary.
> 
> Messages like:
> verbose(env, "bpf verifier is misconfigured\n");
> are technically 'broken internal invariant', but it shouldn't be a warn.
> 
> Whereas this:
>         if (WARN_ON(regno >= MAX_BPF_REG)) {
>                 verbose(env, "mark_reg_known_zero(regs, %u)\n", regno);
>                 /* Something bad happened, let's kill all regs */
>                 for (regno = 0; regno < MAX_BPF_REG; regno++)
>                         __mark_reg_not_init(regs + regno);
>                 return;
>         }
> should stay as-is.
> It's a warn, and verbose message, and clean of regs.
> Similarly:
>         if (WARN_ON_ONCE(ptr_reg)) {
>                 print_verifier_state(env, state);
>                 verbose(env, "verifier internal error: unexpected ptr_reg\n");
>                 return -EINVAL;
>         }
> is a warn and more than just a verbose message.
> 
> verbose_and_warn() doesn't fit these two practical cases of warn + verbose.
> Hence I see no reason to combine warn and verbose into single helper.
> They're perfectly fine being separate.

Sure, I think that's okay as well; was mainly thinking to keep some of these
WARN wrt broken internal invariant such that tools like syzkaller will actually
generate a report w/ reproducer if it ever hits these (as opposed to just ignore
them due to ignoring such logs in general).
