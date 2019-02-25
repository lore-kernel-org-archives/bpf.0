Return-Path: <SRS0=zbR4=RA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08D9C43381
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 11:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850F52147C
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 11:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfBYLHx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 06:07:53 -0500
Received: from www62.your-server.de ([213.133.104.62]:41180 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfBYLHx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Feb 2019 06:07:53 -0500
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gyE6w-0008Ol-3t; Mon, 25 Feb 2019 12:07:50 +0100
Received: from [2a02:1205:34ea:9e0:5681:e3d2:fbd:7e53] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gyE6v-000UsT-Sq; Mon, 25 Feb 2019 12:07:49 +0100
Subject: Re: [PATCH bpf] bpf: properly check TCP_CONGESTION optlen
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        netdev <netdev@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>, Lawrence Brakmo <brakmo@fb.com>
References: <20190223190709.61558-1-edumazet@google.com>
 <20190223203808.f2r54xz2z7j2gecg@ast-mbp.dhcp.thefacebook.com>
 <73905026-571a-867d-43eb-3d9b36f6c39c@gmail.com>
 <20190223231112.7dzt7ws472k6ajb5@ast-mbp.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <739fbe32-d019-4d97-c902-2155a15c58b5@iogearbox.net>
Date:   Mon, 25 Feb 2019 12:07:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190223231112.7dzt7ws472k6ajb5@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25370/Sun Feb 24 14:23:00 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/24/2019 12:11 AM, Alexei Starovoitov wrote:
> On Sat, Feb 23, 2019 at 12:48:53PM -0800, Eric Dumazet wrote:
>> On 02/23/2019 12:38 PM, Alexei Starovoitov wrote:
>>> On Sat, Feb 23, 2019 at 11:07:09AM -0800, Eric Dumazet wrote:
>>>> If caller of bpf_setsockopt() is silly passing a negative optlen
>>>> bad things happen.
>>>>
>>>> Fixes: 91b5b21c7c16 ("bpf: Add support for changing congestion control")
>>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>>> Cc: Lawrence Brakmo <brakmo@fb.com>
>>>> ---
>>>>  net/core/filter.c | 5 +++--
>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>>> index f7d0004fc16096eb42ece3a6acf645540ee2326b..6a5d89464168f2f35f43986c1dbc0446c9390a3c 100644
>>>> --- a/net/core/filter.c
>>>> +++ b/net/core/filter.c
>>>> @@ -4194,8 +4194,9 @@ BPF_CALL_5(bpf_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
>>>>  			char name[TCP_CA_NAME_MAX];
>>>>  			bool reinit = bpf_sock->op > BPF_SOCK_OPS_NEEDS_ECN;
>>>>  
>>>> -			strncpy(name, optval, min_t(long, optlen,
>>>> -						    TCP_CA_NAME_MAX-1));
>>>> +			if (optlen < 0)
>>>> +				return -EINVAL;
>>>> +			strncpy(name, optval, min(optlen, TCP_CA_NAME_MAX - 1));
>>>
>>> Unnecessary.
>>> The verifier guarantees that optlen > 0 because
>>> static const struct bpf_func_proto bpf_setsockopt_proto = {
>>>         .func           = bpf_setsockopt,
>>> ...
>>>         .arg5_type      = ARG_CONST_SIZE,
>>> };
>>
>> Even on 32bit kernel ?
>>
>> The suspect thing to me is the min_t(long, ....)
>>
>> optlen is an integer, why do we need to promote to a long ?
> 
> I think the code is actually fine as-is.
> I bet it was copy pasted from do_tcp_setsockopt
> where similar min_t(long) is used to match strncpy_from_user() declaration.
> Here min_t(long) or min_t(int) or min() doesn't matter.
> I would keep it as-is to avoid noisy patches.

Max allowed input from verifier should be BPF_MAX_VAR_SIZ which is 1 << 29,
but I totally agree that the bpf_setsockopt() and bpf_getsockopt() signature
should change into u32 optlen as it's just confusing otherwise, same with the
long in strncpy(). Agree with Alexei that this might have been a copy-paste
kind of thing. Lawrence can probably clarify best?

The same wrong assumption is in commit 1e215300f138 ("bpf: add TCP_SAVE_SYN/
TCP_SAVED_SYN options for bpf_(set|get)sockopt") which tests for optlen <= 0.
Neither can it be negative nor zero here due to ARG_CONST_SIZE. Given it's
also confusing others, cleanup might still be worth considering. Maybe Lawrence
can spin this into one of his next patches, if noone else gets to it first.

Thanks,
Daniel
