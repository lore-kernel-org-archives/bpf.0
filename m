Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F67C43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 09:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9724120851
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 09:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfCAJE6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 04:04:58 -0500
Received: from www62.your-server.de ([213.133.104.62]:41144 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfCAJE5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 04:04:57 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gze6B-0004d3-Mq; Fri, 01 Mar 2019 10:04:55 +0100
Received: from [2a02:1205:34ea:9e0:5681:e3d2:fbd:7e53] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gze6B-000HDH-EZ; Fri, 01 Mar 2019 10:04:55 +0100
Subject: Re: [PATCH bpf-next v2 3/7] bpf, obj: allow . char as part of the
 name
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>, joe@wand.net.nz,
        john.fastabend@gmail.com, tgraf@suug.ch,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        lmb@cloudflare.com
References: <20190228231829.11993-1-daniel@iogearbox.net>
 <20190228231829.11993-4-daniel@iogearbox.net>
 <CAEf4BzYKj6KtAUN8Zisvvp95429cqGgdo4d54LWDtN85_8W3Rw@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <82f6d64a-efac-07cb-47a6-5c7e238ff0ea@iogearbox.net>
Date:   Fri, 1 Mar 2019 10:04:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzYKj6KtAUN8Zisvvp95429cqGgdo4d54LWDtN85_8W3Rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/01/2019 06:52 AM, Andrii Nakryiko wrote:
> On Thu, Feb 28, 2019 at 3:31 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> Trivial addition to allow '.' aside from '_' as "special" characters
>> in the object name. Used to name maps from loader side as ".bss",
>> ".data", ".rodata".
>>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> 
>>  kernel/bpf/syscall.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index d3ef45e01d7a..90044da3346e 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -440,10 +440,10 @@ static int bpf_obj_name_cpy(char *dst, const char *src)
>>         const char *end = src + BPF_OBJ_NAME_LEN;
>>
>>         memset(dst, 0, BPF_OBJ_NAME_LEN);
>> -
>> -       /* Copy all isalnum() and '_' char */
>> +       /* Copy all isalnum(), '_' and '.' chars. */
> 
> Is there any reason names are so restrictive? Say, why not '-' as
> well? It's perfectly safe even in filenames. Or even '/' and '\'? Is
> this name used by anything else in the system, except for
> introspection?

Could be done, presumably it was more restrictive in case one might
need some reserved names in unforeseeable future, but looks so far
noone run into the need to extend it further than this. :)

>>         while (src < end && *src) {
>> -               if (!isalnum(*src) && *src != '_')
>> +               if (!isalnum(*src) &&
>> +                   *src != '_' && *src != '.')
>>                         return -EINVAL;
>>                 *dst++ = *src++;
>>         }
>> --
>> 2.17.1
>>

