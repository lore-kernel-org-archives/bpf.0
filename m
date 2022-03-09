Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4393BC433F5
	for <bpf@archiver.kernel.org>; Wed,  9 Mar 2022 19:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiCITci (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237472AbiCITci (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 14:32:38 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E18EE7E
        for <bpf@vger.kernel.org>; Wed,  9 Mar 2022 11:31:39 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id a1so2756154qta.13
        for <bpf@vger.kernel.org>; Wed, 09 Mar 2022 11:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tL/B6B069IWAMWNVEEeQR+UhJNrPN4z3uVYfA7KTi7Q=;
        b=f5lzMnDxQrL1ZacnVXNJ0elgZKAXZcJfjUTX9HIQD4EUY1eMnFJ0OMsLtDtzwUMGEm
         pSJ89G5bxCHtimhAPBt36RztjaOKM1ZtL0cXgpwsiS3PS6OKCD3pa4A8XDS8asQJw0vK
         SUFq2/IZJccF16HGbrLEr+VkAZZTpMr6cXcEsP2feNMyRidQs5vL/blSDOiw/1WYVLTt
         qinOip4EoEujSi2+TrpdbSjBVA5h/4fNmJiJJovBcuCFeaZrn8dkX9MP8KGHTLdZKSKB
         Vp7Ch5hKDeQVxzvTETWmf/U2oeu8DSlRowI9pYsX7RETF0PzZuszyhQryRkCPsrrV2q9
         +UBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tL/B6B069IWAMWNVEEeQR+UhJNrPN4z3uVYfA7KTi7Q=;
        b=mvoQFBq3ht3xBEBP5d2a3U1tsVb+Opkl+2/jeTPIYpoS/+RpmZ8qQInY+3UHs4969f
         znowmUcS6o0z3/9p6H+5bcQG8jzheZA6YhbQvbS7Z4MFDKo/kyNcuLTKt5kGKnwLDWKP
         IdBwECed6UftBBzG83bqi8Yu58S9GtX4yRqQCJJB2lnvWXaXm5K/LycXmy2YOwKzD3Jy
         fkJVAH7QgLiJoodxIC+AFHOSrAqQEN+RnBCAvHfSQrCGj/vxft4vW2rn1FIZnZmGKBNT
         Uk0mljYuRQ/EHQc9EnQXgueU5EVoPIORPXJsFpETVLTm8aZtdq7eEx1Hb//lzBhCG0FC
         Wp4Q==
X-Gm-Message-State: AOAM533IdlbCKXwtv64aG6jKbbpINX3VSVKBzEQp0SlOFoPvHXSrnfQl
        8aoTFi2pDZsr8qTCb0wogUceLpLP38YC1/5YiTJrMw==
X-Google-Smtp-Source: ABdhPJxWlSYgcbhrfMSU34tQhB0cs/f/WhLUBXuivuNSU1+XCBXRyqp12YnxhjoQh/cXtRK6uVzJgkNRFKGUK2x1IjA=
X-Received: by 2002:a05:622a:170f:b0:2de:1b24:dc1f with SMTP id
 h15-20020a05622a170f00b002de1b24dc1fmr1043484qtk.299.1646854298300; Wed, 09
 Mar 2022 11:31:38 -0800 (PST)
MIME-Version: 1.0
References: <20220304191657.981240-1-haoluo@google.com> <20220304191657.981240-3-haoluo@google.com>
 <CAEf4BzadmAQSUHSSDfSeiMvicvdbOKh_r7oCX2=OThbjOS-rMw@mail.gmail.com> <b83b2008-d186-84b0-7669-c0758bf15b9b@fb.com>
In-Reply-To: <b83b2008-d186-84b0-7669-c0758bf15b9b@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 9 Mar 2022 11:31:27 -0800
Message-ID: <CA+khW7hQLosCz0mNyAmkRkvyYBEtdeffVYmH5XQ7O02k-8RPqQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/4] compiler_types: define __percpu as __attribute__((btf_type_tag("percpu")))
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 8, 2022 at 11:08 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 3/7/22 5:44 PM, Andrii Nakryiko wrote:
> > On Fri, Mar 4, 2022 at 11:17 AM Hao Luo <haoluo@google.com> wrote:
> >>
[...]
> >>
> >> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> >> index 3f31ff400432..223abf43679a 100644
> >> --- a/include/linux/compiler_types.h
> >> +++ b/include/linux/compiler_types.h
> >> @@ -38,7 +38,12 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
> >>   #  define __user
> >>   # endif
> >>   # define __iomem
> >> -# define __percpu
> >> +# if defined(CONFIG_DEBUG_INFO_BTF) && defined(CONFIG_PAHOLE_HAS_BTF_TAG) && \
> >> +       __has_attribute(btf_type_tag)
> >> +#  define __percpu     __attribute__((btf_type_tag("percpu")))
> >
> >
> > Maybe let's add
> >
> > #if defined(CONFIG_DEBUG_INFO_BTF) &&
> > defined(CONFIG_PAHOLE_HAS_BTF_TAG) && __has_attribute(btf_type_tag)
> > #define BTF_TYPE_TAG(value) __attribute__((btf_type_tag(#value)))
> > #else
> > #define BTF_TYPE_TAG(value) /* nothing */
> > #endif
> >
> > and use BTF_TYPE_TAG() macro unconditionally everywhere?
>
> Agree that the above suggestion is a good idea, esp. we may
> convert others, e.g., __rcu, with btf_type_tag in the future,
> and a common checking will simplify things a lot.
>
> Hao, could you send a followup patch with Andrii's suggestion?
>

No problem. Will send the patch this afternoon.
