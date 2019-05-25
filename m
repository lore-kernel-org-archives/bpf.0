Return-Path: <SRS0=9soK=TZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE05C282CE
	for <bpf@archiver.kernel.org>; Sat, 25 May 2019 11:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CF02085A
	for <bpf@archiver.kernel.org>; Sat, 25 May 2019 11:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="D5FdVLiw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfEYLzT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 25 May 2019 07:55:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34483 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfEYLzT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 May 2019 07:55:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id f8so12434025wrt.1
        for <bpf@vger.kernel.org>; Sat, 25 May 2019 04:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=CsIarrO2L5WOB1SMV5+alsBx9LCjTDuPLbeAGtbhW7Q=;
        b=D5FdVLiwCcZS1Lkl0Mb15BfbPGqf9qivdqrKsWL5OYV7Y1qWfmFFZWPoqqa6i+IyAK
         z8/x3qEgA4fSQsL0AEOawi674itLRS9VS+IemoOs7Wpj+6K1Bk7yIC5mMpsUvwCKy8F0
         3ow5byTCGiukQ9EQfReM7VW8jVK67BOpoE+vRPSkhteGn+HhrLhNsEpuVQVFlC3MlCi5
         wmOO6X4m8Ppj0/wlnCP5xrtVyPRYKEfXQp0pik1ObmrwFjyhNjJHhpB0JRESTseMMoQ0
         +MlQ9p5l/D7MPlI1vBFbD/DXjOIoSNkP91k2xsglyqyoL0KaXIzbwQdpLv9dJ7ByDfOr
         JJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CsIarrO2L5WOB1SMV5+alsBx9LCjTDuPLbeAGtbhW7Q=;
        b=lF1vFHiylmJRCao3mKA1S3yJqq+vIjgzVTpJ4CZCqZjahBK0MoP5fr1Bq4X/RniC5V
         v3huf4w8y2h6zJiMx5LsLF/LMPv6+SqYSPnX39et4l3+IIicdHcE7vD1+x4bUVnwaspG
         A5m8H68lSKX16ewqx8zHSv+pm0Wh6PfjC+6ySVGVKq2oy6TvvFXpL6zOVhUle2VBEHHQ
         Cx2iimuONhbvkt0xUbPimTYFTWrCRGkQj9V2Uhqt4Pou1/jbzzubN86TMrNRQ3caYGcI
         vFA/dTV9PtD9KtvkENTYGjYjta2i7DjT5PpwFcXXYXAfX/z5tX5HIW428+jb/c3cffgm
         WliA==
X-Gm-Message-State: APjAAAVuQKS74fbG3VQy86dIHPi3NrN6TB76xnb7e+3GUCLYOUXGE9hD
        2UjVxFDuBmKnjYjctKZZhFLf/Q==
X-Google-Smtp-Source: APXvYqwkHNvD4zZ7FtIyBqKk4F+kYfrYOK5TZYZ09Nr2NSSmHgsLgAhSCW4q/8whTVypntU59myCpg==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr59322659wrj.182.1558785317332;
        Sat, 25 May 2019 04:55:17 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.20])
        by smtp.gmail.com with ESMTPSA id x1sm7977487wrp.35.2019.05.25.04.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 04:55:16 -0700 (PDT)
Subject: Re: [PATCH bpf-next] bpftool: auto-complete BTF IDs for btf dump
To:     Andrii Nakryiko <andriin@fb.com>, andrii.nakryiko@gmail.com,
        kernel-team@fb.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        ast@fb.com, daniel@iogearbox.net
References: <20190525053809.1207929-1-andriin@fb.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <3543ed02-97f5-8d55-58d7-29f66220bacc@netronome.com>
Date:   Sat, 25 May 2019 12:55:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190525053809.1207929-1-andriin@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-05-24 22:38 UTC-0700 ~ Andrii Nakryiko <andriin@fb.com>
> Auto-complete BTF IDs for `btf dump id` sub-command. List of possible BTF
> IDs is scavenged from loaded BPF programs that have associated BTFs, as
> there is currently no API in libbpf to fetch list of all BTFs in the
> system.
> 
> Suggested-by: Quentin Monnet <quentin.monnet@netronome.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  tools/bpf/bpftool/bash-completion/bpftool | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 75c01eafd3a1..9fbc33e93689 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -71,6 +71,13 @@ _bpftool_get_prog_tags()
>          command sed -n 's/.*"tag": "\(.*\)",$/\1/p' )" -- "$cur" ) )
>  }
>  
> +_bpftool_get_btf_ids()
> +{
> +    COMPREPLY+=( $( compgen -W "$( bpftool -jp prog 2>&1 | \
> +        command sed -n 's/.*"btf_id": \(.*\),\?$/\1/p' | \
> +        command sort -nu )" -- "$cur" ) )
> +}

Thanks! It works well. It looks like the "sort -nu" is not required,
however? Bash completion on my system seems to run the equivalent of
"sort -u" on the results anyway, ignoring the ordering you made just
before. As I understand this is what completion always does, unless we
pass "-o nosort" to "complete".

E.g. I get the same following output:

	1     1234  191   222   25

When completing with this function:

	_bpftool()
	{
		COMPREPLY+=( $( compgen -W "$( \
			command echo '1 1 1 191 1234 25 222')"))
	}
	complete -F _bpftool bpftool

or with that one:

	_bpftool()
	{
		COMPREPLY+=( $( compgen -W "$( \
			command echo '1 1 1 191 1234 25 222' | \
			command sort -nu )" ) )
	}
	complete -F _bpftool bpftool

Could you double check you have the same thing on your setup, please? If
so we can just remove the "sort -nu".

Quentin
