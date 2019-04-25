Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165FEC43219
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 19:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DA1206BA
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 19:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="PJxdgVm9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfDYTVH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:21:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37494 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfDYTVH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 15:21:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so805229wmf.2
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 12:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=easKimaiZJEK+MN5+Syz0H3+YCDjX/xb2pm0aNM+Pak=;
        b=PJxdgVm9aXhgS0v5ig5aP2W1IhsKLNE/VDfpRi+6NDMTzpwf0Fwa4sri0rJ9Q9TU8I
         Fy+deOyDuUXxOl96gxiWv277ogMTa3aTo1jeHL6RuDhwMJFJyCkrfWU3xWaWxlpw2wLV
         OXkvCLCglAwCCSUUYDqPmdQpr+eHQN+7ATR44z9yHU2RQxSRDs9mFuvWj/sROvY1oDln
         YhLTwZo4Z2YQirgd8K6pgB6FljLDsnCGgTNmPBiCakeki5LzRcjcayBfzD+vE4Fq+gbE
         4GwM/bi7TRXtaiQqcFVP5iWvfW3jH0vcagAlBe2Xqmqhyk+YlT/KjuTLkav9ZLULwBYn
         voCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=easKimaiZJEK+MN5+Syz0H3+YCDjX/xb2pm0aNM+Pak=;
        b=JU06mU5yN2ENqtOLqoqCKLKIGtxpTOIZD+y57zkWdFLWjQwOLBiqW514q10Lb4HLKt
         o50lIrb1b84e8CJo8IFTPXiAr5GIrrHD9+Q73s58tlQOZzPNjK2Qc7oQW9c++rNQDXRG
         ICMHQSDsDaXGBdUMQufucYIeeAAOQo1GoswuYqbhtiU01yjHbmUpY+Lfqoy9eeezizxh
         f9fAR01jUELiLo/W/BppQ6NU9lehpb+OknsCWI/0KxO6yKRffoyqdebVJnUgtYo9DL28
         +yD5jpDSDOiYYubh/AD1NRgy8XPvt4OySznyGPYtPxMpyf9YpoxbcoaqKLJAPSvcde28
         niPA==
X-Gm-Message-State: APjAAAXVC14GB/xuSFqTSmssrt/p43vUiHJqPNBlua738AunG0JDSQ/0
        0G/+VMXTj41NRV6kuIIT+8e7fQ==
X-Google-Smtp-Source: APXvYqxW/0OO0RlJ4yAl31GZMWsmssDfkIcwj/gJTlIhZyLLhD4GALkfcDwxObXgvwl2E4bJO7WvpA==
X-Received: by 2002:a1c:35c3:: with SMTP id c186mr5040974wma.135.1556220065678;
        Thu, 25 Apr 2019 12:21:05 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.213])
        by smtp.gmail.com with ESMTPSA id s10sm23968298wmh.0.2019.04.25.12.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:21:05 -0700 (PDT)
Subject: Re: [PATCH v3 bpf-next 3/4] bpftool: add bash completions for btf
 command
To:     Andrii Nakryiko <andriin@fb.com>, andrii.nakryiko@gmail.com,
        kernel-team@fb.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        ast@fb.com, daniel@iogearbox.net, yhs@fb.com,
        songliubraving@fb.com, kafai@fb.com, acme@kernel.org
References: <20190425165539.3317350-1-andriin@fb.com>
 <20190425165539.3317350-4-andriin@fb.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <dcf044ba-232e-d486-3e19-c84b169ced00@netronome.com>
Date:   Thu, 25 Apr 2019 20:21:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425165539.3317350-4-andriin@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-04-25 09:55 UTC-0700 ~ Andrii Nakryiko <andriin@fb.com>
> Add full support for btf command in bash-completion script.
> 
> Cc: Quentin Monnet <quentin.monnet@netronome.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Alexei Starovoitov <ast@fb.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>   tools/bpf/bpftool/bash-completion/bpftool | 46 +++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 9f3ffe1e26ab..bca91d04ed35 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -217,6 +217,7 @@ _bpftool()
>       done
>       cur=${words[cword]}
>       prev=${words[cword - 1]}
> +    pprev=${words[cword - 2]}
>   
>       local object=${words[1]} command=${words[2]}
>   
> @@ -607,6 +608,51 @@ _bpftool()
>                       ;;
>               esac
>               ;;
> +        btf)
> +            local PROG_TYPE='id pinned tag'
> +            local MAP_TYPE='id pinned'
> +            case $command in
> +                dump)
> +                    case $prev in
> +                        $command)
> +                            COMPREPLY+=( $( compgen -W "id map prog file" -- \
> +                                "$cur" ) )
> +                            return 0
> +                            ;;
> +                        prog)
> +                            COMPREPLY=( $( compgen -W "$PROG_TYPE" -- "$cur" ) )
> +                            return 0
> +                            ;;
> +                        map)
> +                            COMPREPLY=( $( compgen -W "$MAP_TYPE" -- "$cur" ) )
> +                            return 0
> +                            ;;
> +                        id)
> +                            case $pprev in
> +                                prog)
> +                                    _bpftool_get_prog_ids
> +                                    ;;
> +                                map)
> +                                    _bpftool_get_map_ids
> +                                    ;;
> +                            esac
> +                            return 0
> +                            ;;
> +                        *)
> +                            if [[ $cword == 6 ]] && [[ ${words[3]} == "map" ]]; then
> +                                 COMPREPLY+=( $( compgen -W 'key value kv all' -- \
> +                                     "$cur" ) )
> +                            fi
> +                            return 0
> +                            ;;
> +                    esac
> +                    ;;
> +                *)
> +                    [[ $prev == $object ]] && \
> +                        COMPREPLY=( $( compgen -W 'dump help' -- "$cur" ) )
> +                    ;;
> +            esac
> +            ;;
>           cgroup)
>               case $command in
>                   show|list)
> 

I haven't tried with the latest change, but the code looks good to me. 
Thanks!

Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
