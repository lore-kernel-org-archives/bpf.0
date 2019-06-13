Return-Path: <SRS0=LLXA=UM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A691FC31E4B
	for <bpf@archiver.kernel.org>; Thu, 13 Jun 2019 16:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6AF20673
	for <bpf@archiver.kernel.org>; Thu, 13 Jun 2019 16:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqYGjkzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbfFMQnY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:43:24 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39312 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730480AbfFMGoq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Jun 2019 02:44:46 -0400
Received: by mail-qk1-f193.google.com with SMTP id i125so12032070qkd.6;
        Wed, 12 Jun 2019 23:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4UwaShlwFf8E7o47Cxxyp2AHTX/XcUe3tfKPCZybJ/8=;
        b=kqYGjkzxruCOrvkWv1gUnpabuLv0kryzi9+wQUayDkWdoHrHEV4ajFzXnz7Qz5T2bA
         42eM6n9mKFaoEfS44rCPjEVWl4tPKQSH60MhwDiAW3j1e50dDAMZyM/V4cvDvfOTNcln
         EIysJc+vqYNaBiq/Ln4W1zgSMDouL5FjTjvtpzLoAtGSPtK2jFKnRh+tB1dJCYlDF5f1
         fkmBo9ZgbjvoYUKxr734P5ePEcRRk+II0LqT5JqjbDLl8uULJF++/OwQM6/zk6QK8iWh
         dsOYbT8BXg50pnvdkhyG3j4MyyY+JaQNpL6kNii+IfmeCPwa6HY1AMM7wh5QtyUhEsga
         8dCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4UwaShlwFf8E7o47Cxxyp2AHTX/XcUe3tfKPCZybJ/8=;
        b=A78dYo579GOvGFGYUrE9rCBeShOTOUlhUFxpLvOCP5l0wbPiTSnhP6A4pxZk7L3c1Q
         L5M7hBlRkK5ktWiUxjXPYgRRzAShZpRU4zpwjqJuIHjJR0mNpvnAl28fJ9bu6Oj0OwTZ
         ezlACJj5pk8257+bo+0EMoApdIID4Mkt1TzILGytFCMeI8pAvJOqBuBYswZvxRHSGJOO
         kvCnUBKJTRWjXKiXK40U8+36q6ztXaN7mixNJj8GEFNmPAT8uHZMo8KvynFw1jvnMq8T
         AHGIy+ZxnAM52zhbkgbMJW6FnDQZDW4XtiVcZ7NmCbiIdCuJQ964c1KFV3KppSaB/IsT
         oHVA==
X-Gm-Message-State: APjAAAVoh3K19/MZqh9pw6HbtNPpCyw9QKIxNeZ/rlBNTH7jnCDElWra
        Bob3+y5jBmTnCk49Yyo5O+9a+ztP7cuHf/+NUO0=
X-Google-Smtp-Source: APXvYqzx75Otp0t0gN3dFi71tk+ckYLfNAXk3MF+MpENvR/aVLc2tRuQzzNjUVM0v6vi7Oh3SqbG/wvxDkknpJ0EuvQ=
X-Received: by 2002:a05:620a:147:: with SMTP id e7mr68819041qkn.247.1560408285593;
 Wed, 12 Jun 2019 23:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190612160541.2550-1-m@lambda.lt> <20190612160541.2550-2-m@lambda.lt>
In-Reply-To: <20190612160541.2550-2-m@lambda.lt>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 12 Jun 2019 23:44:34 -0700
Message-ID: <CAEf4Bzb2jfwB+uuzibED86RbR8NrnxTZyZhtvAWMdM_7z8SQUw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: sync BPF_FIB_LOOKUP flag changes with BPF uapi
To:     Martynas Pumputis <m@lambda.lt>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 12, 2019 at 11:06 AM Martynas Pumputis <m@lambda.lt> wrote:
>
> Sync the changes to the flags made in "bpf: simplify definition of
> BPF_FIB_LOOKUP related flags" with the BPF uapi headers.
>
> Doing in a separate commit to ease syncing of github/libbpf.
>
> Signed-off-by: Martynas Pumputis <m@lambda.lt>

Acked-by: Andrii Nakryiko <andriin@fb.com>

> ---
>  tools/include/uapi/linux/bpf.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 63e0cf66f01a..a8f17bc86732 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -3376,8 +3376,8 @@ struct bpf_raw_tracepoint_args {
>  /* DIRECT:  Skip the FIB rules and go to FIB table associated with device
>   * OUTPUT:  Do lookup from egress perspective; default is ingress
>   */
> -#define BPF_FIB_LOOKUP_DIRECT  BIT(0)
> -#define BPF_FIB_LOOKUP_OUTPUT  BIT(1)
> +#define BPF_FIB_LOOKUP_DIRECT  (1U << 0)
> +#define BPF_FIB_LOOKUP_OUTPUT  (1U << 1)
>
>  enum {
>         BPF_FIB_LKUP_RET_SUCCESS,      /* lookup successful */
> --
> 2.21.0
>
