Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6078AC61DA4
	for <bpf@archiver.kernel.org>; Thu, 16 Feb 2023 16:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjBPQhY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 16 Feb 2023 11:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBPQhX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 11:37:23 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38DCDC
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 08:37:22 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id n20so5228001edy.0
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 08:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/kcef/IAhMMCSmgxE5hFcfot2fsHq6WOChroHtpQvwA=;
        b=QzWDq6ks6Rwjfmg6pfyoBwJ7j6qr3jRBhGEHvCY0pqh8T6O5KG40CgPvtaOUw9ZC63
         s2pU5A6Ox9CjLmsNG85wtWc79Jk5fofl1Tdz0/8xNXGZ1kn8GTrCKFlpqKRJ75b+wM9Z
         pg+0xXezybdiGPt+AmuX8Q9+A2QS/UV/iP57vXKbqiPmCJ+pyZRf8vVsMPMCXQki+e6o
         mY1Gw6cBwVZNqRwcIR86Km1VpIyMYF/aQS/3N3+G+kfSJkeCeMzsh0oCMpIK3FnbviIE
         q0QoqY9EN5JmCEe2pa97rRfjo8Io8UepcLhUb6vI8kh94jglVOTkC+jJ1Nz52B4kG4jj
         CgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kcef/IAhMMCSmgxE5hFcfot2fsHq6WOChroHtpQvwA=;
        b=cX6vhtv1GJiXnrse5HvPQEKfEWmKMPg8PA87BbfMchQik2casPN9x0mL3p+ipw5Fqi
         pxoqs5J23yCYPzAUrXJfOVdM1yVW5NJazAvflgZTZdcicPTd0mN0UhbPxAj0jvSB3pvs
         NLo4s0HD5CjVNsfm0SmEZ2L3DXuex8n+DVCcr/Jw/GhfaUICyWMFLv8Ge24GKE1xqP/v
         Au1CRrcozvgPOqCFlEsTHr7lJFNonQ2z4pJpUiYcdqBVgu06xBJ77E0yRV8dtEObozBw
         vAS7SisIKqKPwn6NM/31zl/sUKxi/g0uaFMm1nVRsdXCDXMb2xUj8hYZIRxfQ2vTWgha
         m19g==
X-Gm-Message-State: AO0yUKWQbZEVyzyQXbZqaGM8gZsYrlEfpsvBo1VdfXld1PLy+eTVXANt
        ysQG8mDnmCtJPXB9UtNys7s5OyaulXLk+mM0JcY=
X-Google-Smtp-Source: AK7set9+w2h6+SenYPyqcaHUh5w/7CufzjMiWn0hlv89cTcvrlKXa49WSPnkzAfrhps6w7egU+4cK/e/7VA82VROV0A=
X-Received: by 2002:a17:906:a85a:b0:879:b98d:eb08 with SMTP id
 dx26-20020a170906a85a00b00879b98deb08mr3137759ejb.3.1676565441242; Thu, 16
 Feb 2023 08:37:21 -0800 (PST)
MIME-Version: 1.0
References: <20230215235931.380197-1-iii@linux.ibm.com> <20230215235931.380197-2-iii@linux.ibm.com>
In-Reply-To: <20230215235931.380197-2-iii@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 16 Feb 2023 08:37:10 -0800
Message-ID: <CAADnVQK-_MOk=ejM5USFZL9codbzosUqfAs4ppqQuC0y4uBLqw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 1/4] bpf: Introduce BPF_HELPER_CALL
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 15, 2023 at 3:59 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Make the code more readable by introducing a symbolic constant
> instead of using 0.
>
> Suggested-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  include/uapi/linux/bpf.h       |  4 ++++
>  kernel/bpf/disasm.c            |  2 +-
>  kernel/bpf/verifier.c          | 12 +++++++-----
>  tools/include/linux/filter.h   |  2 +-
>  tools/include/uapi/linux/bpf.h |  4 ++++
>  5 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 1503f61336b6..37f7588d5b2f 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1211,6 +1211,10 @@ enum bpf_link_type {
>   */
>  #define BPF_PSEUDO_FUNC                4
>
> +/* when bpf_call->src_reg == BPF_HELPER_CALL, bpf_call->imm == index of a bpf
> + * helper function (see ___BPF_FUNC_MAPPER below for a full list)
> + */
> +#define BPF_HELPER_CALL                0

I don't like this "cleanup".
The code reads fine as-is.
