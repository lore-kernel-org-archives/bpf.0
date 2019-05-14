Return-Path: <SRS0=CEAn=TO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C58FC04AB4
	for <bpf@archiver.kernel.org>; Tue, 14 May 2019 04:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3F22086A
	for <bpf@archiver.kernel.org>; Tue, 14 May 2019 04:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NucVh6BB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfENEt5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 14 May 2019 00:49:57 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34814 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfENEt4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 May 2019 00:49:56 -0400
Received: by mail-qt1-f193.google.com with SMTP id h1so9718839qtp.1
        for <bpf@vger.kernel.org>; Mon, 13 May 2019 21:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YVZJsxUBOtf/Kj8PRqrKFyOSjbhNcrN5i1SaRCbqsIc=;
        b=NucVh6BBsupblMjT+MitypyI+EfY715v4oB2NFKrNST553vkACO7w0011D5aXE3plg
         sYA1Dgb8znRLAxMTr1mEWdYu4Y3vzatV5Co2snPOysqRlgfZTHML65JML8irbqA+jvEF
         1NsthKz4dRVS9EMaQh1RlRYh06SWN24dJAExDbLOA1OUgCPOZ11WtN+e6XnKAHR3B4NX
         kaBCVII9IaOHS94epD1YSdATTP1XoE7wm2E838vxgFHs8RQil9L9SVdWlchzjJpV8+J7
         XcW+m9MN9e+zpdZFYAR14q4ymj6Skwq5vE8IYrD1HV6X1HDeGcKGfE/FDNnyMA0DdR7h
         hcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVZJsxUBOtf/Kj8PRqrKFyOSjbhNcrN5i1SaRCbqsIc=;
        b=FuAAXXZCSjN1o0WUHylyJDOhMb41YyM8tTPW35gH9VrrCRFGq6UkwKlUhccqt/sFR5
         ufvwHBVfIW8p1wtlBFNijsPXemyLo2XiaHNDMqmyJWXIYku8qkbplzMdDJeMOggHFaqb
         lU/d/n+WjW35Wj/A7Km1ziEMk9VItQPbmaU7PJ5KuCZtI82fDjrwebiXi7o6Z65NpO6I
         eeKhSLF5dynBL8W1sgeJMk75S3t4RVld70WfJPFPXL45ioLtcE0lx6bHdF7FkbQ0ke1h
         PYk+Hd4L3qk1jUVNGijINtY0HRyBNOmuFmyGyaJHHGAgR/8JEJczk6qr2BwMbpKd4fxg
         G+jQ==
X-Gm-Message-State: APjAAAVZSAAFIPQHJDBWqOz2fn36bhkLwwiVWWk16Wd80LIDt+gv+7K0
        ErkUPUi+XRovGZvu2znHehWm4IfMP8ITg3JltCA=
X-Google-Smtp-Source: APXvYqy8W+bFGz8+PqW8Qmo2HGt1izbamvulGShZajAAjh/n4NjpJrxYSB7AHvtWhizXby0p4mxeBWe7r5nvDETJ7n8=
X-Received: by 2002:aed:3b24:: with SMTP id p33mr9522985qte.226.1557809395954;
 Mon, 13 May 2019 21:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190514031550.11446-1-glin@suse.com>
In-Reply-To: <20190514031550.11446-1-glin@suse.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 May 2019 21:49:44 -0700
Message-ID: <CAEf4BzbCbzdtgYODYf+Fr4+OWYRNmOq2QFC3UJJgd6DO1mxzVw@mail.gmail.com>
Subject: Re: [PATCH] tools/bpf: Sync kernel btf.h header
To:     Gary Lin <glin@suse.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 13, 2019 at 8:16 PM Gary Lin <glin@suse.com> wrote:
>
> For the fix of BTF_INT_OFFSET()
>
> Signed-off-by: Gary Lin <glin@suse.com>

Thanks!

Acked-by: Andrii Nakryiko <andriin@fb.com>

> ---
>  tools/include/uapi/linux/btf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
> index 9310652ca4f9..63ae4a39e58b 100644
> --- a/tools/include/uapi/linux/btf.h
> +++ b/tools/include/uapi/linux/btf.h
> @@ -83,7 +83,7 @@ struct btf_type {
>   * is the 32 bits arrangement:
>   */
>  #define BTF_INT_ENCODING(VAL)  (((VAL) & 0x0f000000) >> 24)
> -#define BTF_INT_OFFSET(VAL)    (((VAL  & 0x00ff0000)) >> 16)
> +#define BTF_INT_OFFSET(VAL)    (((VAL) & 0x00ff0000) >> 16)
>  #define BTF_INT_BITS(VAL)      ((VAL)  & 0x000000ff)
>
>  /* Attributes stored in the BTF_INT_ENCODING */
> --
> 2.21.0
>
