Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDD5C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 00:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219B621850
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 00:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7nbZVKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbfB1AL0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 19:11:26 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40953 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbfB1AL0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 19:11:26 -0500
Received: by mail-ot1-f66.google.com with SMTP id v20so16106325otk.7;
        Wed, 27 Feb 2019 16:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lSZoFunWIr5rgU78RAWordfmKnbDtTRa69HFAWzk2FI=;
        b=A7nbZVKOnf8Iya/20wT1jMgVcLYS8Xr1DHvrpqgP6r9uSr3PX+uqEXLwGAeH9YtkXN
         oHeUXAB6GBLbyQF9SVLHSa8kYFskEzvX0wu77jClt5UWlCVbSdARtMrAcxWCrHUAXY87
         HVDwydavYoXnc0priyHEbHnSw8viR/onbjpqMGt3jvNlUgVqn1//MGzXmk4g07hcZUIn
         dAWmeOl9J6MGK9FG2ZowzUzh7JRgUUIMNA7QN4X1jNedAW/5PrLSxKGfC1t2Or+vZ+Hi
         4f3ld4sh1HyivtslyjSKAdYzaxkE1NlY9kaC/MQmEAHhu+3lOqvR6dTqAiT2qBxT4e1i
         uToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lSZoFunWIr5rgU78RAWordfmKnbDtTRa69HFAWzk2FI=;
        b=BsJm3YIvQQTGYJS3ls3Mb89HEQoRcuACOKBeCOwaYJsSrOgku2toZoMW/ovl3cYeEq
         C/jBDm9nxEcIAnzTbhOIb6+W3CyaOuIchRZMGSL2sKpECPUgKAiM8W3f453KIn9+ZZ/x
         OjPsZXAAqNqDM5IBMsnG7oCPFmPKvirqtyzmwGA+h6AjbkhRkkf5ANq5UhjzXBZL6xJD
         v8im1WaxtA4kLoRW9YRagnWUVG2LAcqhLv5UkC2u45E2YELxUXs8DOJ5K3BcQntqqnu6
         xt1CYH8i0n+FyVhDiMDv4mhgPe7nf5aBK2LLAUx5Ckqwu3RlVaWIWh9X96f+U7fIXeYf
         gZEA==
X-Gm-Message-State: AHQUAuZo1MVBM8gSy0Itr0GuZSdD3Vau0VRtV+jxwn6+cdsanOvyHi3w
        HcowcObEQqdX+f2P56WtmLpXtri0Oepe3Oq8XyrD03xo
X-Google-Smtp-Source: AHgI3IYTdwjzzpEjqHr9pMA8dTcjLe3vly7GBFnYBHkjDFHx4ap09/eFl6luqpozntrdu0wPPa5IhIZE4QvgnMpImKk=
X-Received: by 2002:a05:6830:1193:: with SMTP id u19mr3885727otq.221.1551312686057;
 Wed, 27 Feb 2019 16:11:26 -0800 (PST)
MIME-Version: 1.0
References: <20190227233046.11718-1-jakub.kicinski@netronome.com> <20190227233046.11718-6-jakub.kicinski@netronome.com>
In-Reply-To: <20190227233046.11718-6-jakub.kicinski@netronome.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Feb 2019 16:11:14 -0800
Message-ID: <CAEf4BzayW8X8vqWhuLDYQ1fWOcZpY87m=dWf_LNp1i4k3Rd2wg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/5] tools: libbpf: make sure readelf shows full
 names in build checks
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, oss-drivers@netronome.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 27, 2019 at 3:31 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> readelf truncates its output by default to attempt to make it more
> readable.  This can lead to function names getting aliased if they
> differ late in the string.  Use --wide parameter to avoid
> truncation.
>
> Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
> ---
>  tools/lib/bpf/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 761691bd72ad..a05c43468bd0 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -132,9 +132,9 @@ BPF_IN    := $(OUTPUT)libbpf-in.o
>  LIB_FILE := $(addprefix $(OUTPUT),$(LIB_FILE))
>  VERSION_SCRIPT := libbpf.map
>
> -GLOBAL_SYM_COUNT = $(shell readelf -s $(BPF_IN) | \
> +GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN) | \
>                            awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {s++} END{print s}')
> -VERSIONED_SYM_COUNT = $(shell readelf -s $(OUTPUT)libbpf.so | \
> +VERSIONED_SYM_COUNT = $(shell readelf -s --wide $(OUTPUT)libbpf.so | \
>                               grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
>
>  CMD_TARGETS = $(LIB_FILE)
> --
> 2.19.2
>

Looks good.

Acked-by: Andrii Nakryiko <andriin@fb.com>
