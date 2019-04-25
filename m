Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8A5C43219
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 16:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855D020717
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 16:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="PR3wSiM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfDYQdz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:33:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34850 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfDYQdz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 12:33:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so160270wmd.0
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 09:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bLi8o3fPHcXQIaJ2bBJgYmTsfAow0XH2xtfYGG8GAZE=;
        b=PR3wSiM1u+dMk/IEX2yeOH0lxq3Lgk1WjjTMZz4jLutdG5PrdLp5ZjJ3C6EvhyhwcK
         ly9C1npVJy9T5+URKsm3bjURI1YnWdDUeeZoxujoH0jFNkmxZKmBK89sxKUALhKeI0eq
         gWN9lKAM87gJ4MZnoUl2yoU7T/kFRrRTueHc4y0rkvahIG57S4doojJRGFNi6hThi7gb
         kbsxHvmMg3lEc6Um7ghW+gV2TUraoEEFfRBsQbHDOl7iDSMkYMKhMoAht/dFxXU5VqPC
         /U2jfXm//yqbiQ2U4gaNjS/9DaZ+e4mLLlGgROHRqFWkdmYjuV5r61iT1KNS6xAW/xtA
         ELww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bLi8o3fPHcXQIaJ2bBJgYmTsfAow0XH2xtfYGG8GAZE=;
        b=ZI1h4yNlHf90O1jCg21Y1rxk3fHeVI1SKsTseUSITsdix0LVNmPtT5Xc3FMBqv6Umu
         /Y8Ulm7urinQKaVALpGHqjJsgCEJ1P2YZ0exsxPsPHK1oKKF6YGVqYNwL1xc3B/kV2fz
         lhRf3+TRwYO0tiRlXxEdzt3i6C6aPgfdhVFurOUkpgHL1hHYt+Bl9O7GvBUsqmcjqzkf
         CzHZdd7bUlchi15Atk0aa/TRhqVHcPMkabs3mlSCvjka9NoSMvwW48Ss6tzQh+O314Fl
         f6Qi90z44ClZSR08J1U2Ex8zJ+vo/Z3Y5dLpdOKr8VLDlbnezzr3qxjn21/Qu6avWPLb
         5USw==
X-Gm-Message-State: APjAAAXlhaCFZD7iTxQ3ZEc0t6v1w/5O/M9++r5+LzsV2Tsvz+9A8ef2
        LWqSPdJ6V0BWqT9nG2+qbX8mQw==
X-Google-Smtp-Source: APXvYqxtf+GHACgxK6yIX7wO9GI3aLx0cdS+A8fNZNCtoJAhjOfsjR2C1Z9peSZ4521kAYQlWpWpAA==
X-Received: by 2002:a1c:f70e:: with SMTP id v14mr4424167wmh.74.1556210033261;
        Thu, 25 Apr 2019 09:33:53 -0700 (PDT)
Received: from [172.20.1.250] ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id d18sm5895172wrx.56.2019.04.25.09.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 09:33:52 -0700 (PDT)
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kernel Team <kernel-team@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        Martin Lau <kafai@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
References: <20190425050355.1359736-1-andrii.nakryiko@gmail.com>
 <20190425050355.1359736-4-andrii.nakryiko@gmail.com>
 <b2eda1ce-4362-4b2a-0c60-7815dd8bb8d4@netronome.com>
 <CAEf4BzZF7zWGP24H7YJzCD3LLy4HVmsyKL-f2+1_N1+wq=ejQw@mail.gmail.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quentin.monnet@netronome.com; prefer-encrypt=mutual; keydata=
 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
 RHhSHGnKaQ6MfrTge5Q0h5A=
Subject: Re: [PATCH v2 bpf-next 3/3] bpftool: add bash completions for btf
 command
Message-ID: <7bac058b-ca3c-5e20-ed6e-667a6602db7e@netronome.com>
Date:   Thu, 25 Apr 2019 17:33:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZF7zWGP24H7YJzCD3LLy4HVmsyKL-f2+1_N1+wq=ejQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-04-25 09:14 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Thu, Apr 25, 2019 at 4:15 AM Quentin Monnet
> <quentin.monnet@netronome.com> wrote:
>>
>> 2019-04-24 22:03 UTC-0700 ~ <andrii.nakryiko@gmail.com>
>>> From: Andrii Nakryiko <andriin@fb.com>
>>>
>>> Add full support for btf command in bash-completion script.
>>>
>>> Cc: Quentin Monnet <quentin.monnet@netronome.com>
>>> Cc: Yonghong Song <yhs@fb.com>
>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>> Cc: Alexei Starovoitov <ast@fb.com>
>>> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
>>> ---
>>>  tools/bpf/bpftool/bash-completion/bpftool | 46 +++++++++++++++++++++++
>>>  1 file changed, 46 insertions(+)
>>>
>>> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
>>> index 9f3ffe1e26ab..030f81bdec6a 100644
>>> --- a/tools/bpf/bpftool/bash-completion/bpftool
>>> +++ b/tools/bpf/bpftool/bash-completion/bpftool
>>> @@ -217,6 +217,7 @@ _bpftool()
>>>      done
>>>      cur=${words[cword]}
>>>      prev=${words[cword - 1]}
>>> +    pprev=${words[cword - 2]}
>>>
>>>      local object=${words[1]} command=${words[2]}
>>>
>>> @@ -607,6 +608,51 @@ _bpftool()
>>>                      ;;
>>>              esac
>>>              ;;
>>> +        btf)
>>> +            local PROG_TYPE='id pinned tag'
>>> +            local MAP_TYPE='id pinned'
>>> +            case $command in
>>> +                dump)
>>> +                    case $prev in
>>> +                        $command)
>>> +                            COMPREPLY+=( $( compgen -W "id map prog file" -- \
>>> +                                "$cur" ) )
>>> +                            return 0
>>> +                            ;;
>>> +                        prog)
>>> +                            COMPREPLY=( $( compgen -W "$PROG_TYPE" -- "$cur" ) )
>>> +                            return 0
>>> +                            ;;
>>> +                        map)
>>> +                            COMPREPLY=( $( compgen -W "$MAP_TYPE" -- "$cur" ) )
>>> +                            return 0
>>> +                            ;;
>>> +                        id)
>>> +                            case $pprev in
>>> +                                prog)
>>> +                                    _bpftool_get_prog_ids
>>> +                                    ;;
>>> +                                map)
>>> +                                    _bpftool_get_map_ids
>>> +                                    ;;
>>> +                            esac
>>> +                            return 0
>>> +                            ;;
>>> +                    *)
>>> +                        if _bpftool_search_list 'map'; then
>>> +                            COMPREPLY+=( $( compgen -W 'key value kv all' -- \
>>> +                                "$cur" ) )
>>
>> Hi Andrii,
>>
>> This COMPREPLY will suggest completion for "key|value|kv|all", even if
>> one of those words has been used on the command line before already (I
>> do not believe this is expected?). What about the following instead?
>>
>>                             _bpftool_one_of_list 'key value kv all'
> 
> I'll make it more precise and correct. key|value|kv|all should go only
> after `bpftool btf dump map id <id> <here>`, I'll do match based on
> number of workds, similar to how it's done in prog attach/detach
> handling.

I think that bit was mostly correct. What you have is “if we're after
map and it's not prog/map/id, always complete with key/value/kv/all”.

What I'm proposing is “[in the same context], complete just once with
only one of key/value/kv/all”. Like this:

	*)
		if _bpftool_search_list 'map'; then
			_bpftool_one_of_list 'key value kv all'
		fi

With that you probably do not have to change it for word numbers.
Although if you wish to go for them, it's fine too.

> 
> 
>>
>>> +                        fi
>>> +                        return 0
>>> +                        ;;
>>
>> Nit: It seems that the last bloc (the case when $prev matches on "*") is
>> not correctly indented, it should be aligned with $command/prog/map/id?
> 
> Copy/pasted from `prog dump`, I wasn't sure if that was intentional,
> will fix both.
> 
>>
>> Other than this the completion seems good to me.
>>
>> But note that I did not receive all of your patches, only the cover
>> letters (for v1 and v2 of the set) and this one (because I'm directly
>> CC-ed?). It looks like the other patches for both v1 and v2 did not make
>> it to the mailing lists or to patchwork, so you might want to double
>> check and resend if necessary.
> 
> Hm.. yeah, you are right, not sure what happened there. Neither bfp@
> and netdev@ didn't get it, while other recipients did. I'll send out
> v3 and will see if that still happens.

Cool, thanks!
Quentin
