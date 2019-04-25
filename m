Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D650C43218
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 19:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF57206BA
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 19:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="RvFbqvFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfDYTVM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:21:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39693 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfDYTVM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 15:21:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id a9so923093wrp.6
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 12:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8+yXTIgdSbDmJCEuOcmq+CWwS5sw4fIomBYcrR+NVR0=;
        b=RvFbqvFv+dQsLsBGSHYRCqWCEQkmHJU8K5Rtt3xVwjTXx3CAkR4B+VBTZ7MER3dG6x
         goVgPATPNGLub3ZZ2d1jJll6FFdJXqMJtEnG8Om1e2+bSuKRCm0gsGO+lC2OMCxluUsV
         sxagcGxndZMnKhMtwDSVDoU+31OP+AV6kloJN2LG9zF6Kf+GZsj6kebI7YzwQbWRyBOp
         yTihssP201bQ5cc4UAPfFP/dyvXlXskontRzZ7hy4EQtZZ1FM0PowfgIKzA6gtn6NdJ7
         WWr/iigPauz8UZY/X+uRjcz4LeLq6E6csDbcetjnSw+pBG+BGIAC7bAjPMqJVRupAXHr
         HNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8+yXTIgdSbDmJCEuOcmq+CWwS5sw4fIomBYcrR+NVR0=;
        b=Z5Tobzetf76jSlMKJvJTk8GnxTGxWIyCnkRG+z/0sRQlp3n/zqjC3D9NCDg6KlXHFO
         +5l17t8AJpuyL6N+UM36tg3NhvnZIYY8XzI7EQ7goW6MwfxrzAyDlt6DAKCz38zKyANA
         J/NiDWib97uN8JLvpqk4UPi2EzuaN6wS0yCSTvhToNvBcH6uYv4NF1NaCGthzkQu4w+g
         wQYdzUTexfbgjFV+o7X9x+nIF8QwZfsdsJBrLGUxn4rzbkg3s2LysXAfLK4XyCPEl2z1
         8igoquotBc1FN5OQPoAhEyhZNDcX+8tpjGesAItHJbciVhRRdezQ3CIEmKKCBHIGFkZR
         N6Zw==
X-Gm-Message-State: APjAAAXLLNpi9MnOhkxco1B/0ACFp5M9zDw+b6nzMlsdqbv9R2whzqcq
        q8dyTX3iaiZLDmboDqxuImeP3g==
X-Google-Smtp-Source: APXvYqwYtJhRrYu4t2KHQEW//DHw4KRHoSu2KzFegRsqcChehnRSm2mhlk7j0BKVn2yid3rG9HS90w==
X-Received: by 2002:adf:fc47:: with SMTP id e7mr28631323wrs.100.1556220070660;
        Thu, 25 Apr 2019 12:21:10 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.213])
        by smtp.gmail.com with ESMTPSA id u14sm21857732wrr.1.2019.04.25.12.21.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:21:10 -0700 (PDT)
Subject: Re: [PATCH v3 bpf-next 4/4] bpftool: fix indendation in
 bash-completion/bpftool
To:     Andrii Nakryiko <andriin@fb.com>, andrii.nakryiko@gmail.com,
        kernel-team@fb.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        ast@fb.com, daniel@iogearbox.net, yhs@fb.com,
        songliubraving@fb.com, kafai@fb.com, acme@kernel.org
References: <20190425165539.3317350-1-andriin@fb.com>
 <20190425165539.3317350-5-andriin@fb.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <74389a6e-2a72-2ee1-b5c9-c94ece3a7581@netronome.com>
Date:   Thu, 25 Apr 2019 20:21:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425165539.3317350-5-andriin@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-04-25 09:55 UTC-0700 ~ Andrii Nakryiko <andriin@fb.com>
> Fix misaligned default case branch for `prog dump` sub-command.
> 
> Reported-by: Quentin Monnet <quentin.monnet@netronome.com>
> Cc: Yonghong Song <yhs@fb.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>   tools/bpf/bpftool/bash-completion/bpftool | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index bca91d04ed35..50e402a5a9c8 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -273,17 +273,17 @@ _bpftool()
>                                   "$cur" ) )
>                               return 0
>                               ;;
> -                    *)
> -                        _bpftool_once_attr 'file'
> -                        if _bpftool_search_list 'xlated'; then
> -                            COMPREPLY+=( $( compgen -W 'opcodes visual linum' -- \
> -                                "$cur" ) )
> -                        else
> -                            COMPREPLY+=( $( compgen -W 'opcodes linum' -- \
> -                                "$cur" ) )
> -                        fi
> -                        return 0
> -                        ;;
> +                        *)
> +                            _bpftool_once_attr 'file'
> +                            if _bpftool_search_list 'xlated'; then
> +                                COMPREPLY+=( $( compgen -W 'opcodes visual linum' -- \
> +                                    "$cur" ) )
> +                            else
> +                                COMPREPLY+=( $( compgen -W 'opcodes linum' -- \
> +                                    "$cur" ) )
> +                            fi
> +                            return 0
> +                            ;;
>                       esac
>                       ;;
>                   pin)
> 

Thanks for that!
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
