Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C89C433F5
	for <bpf@archiver.kernel.org>; Sun, 12 Sep 2021 23:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEBFE610A6
	for <bpf@archiver.kernel.org>; Sun, 12 Sep 2021 23:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbhILXP1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 12 Sep 2021 19:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58345 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236546AbhILXP1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 12 Sep 2021 19:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631488451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kE+f8eZSnmxip1KphitcMWzsxYEael7Knbp5a1w+0jw=;
        b=INwQQU6HHK4TjME1RJ9ufI59Z+b38md+xB1SsNBd4r2UMNNevlaRV4gRtxWDWzwGFsyXSo
        KF8cS2V1wfMpN4he1ehK1SSAdbXYPDFJWsTupjOjOASoZhm9nP2FmKMyejjsxUQOjRPtzK
        9/2TTeYJNreSsxbIqpigLmXSKrHCaM4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-rjuXTGcRMwmMEF-tNNOU_g-1; Sun, 12 Sep 2021 19:14:10 -0400
X-MC-Unique: rjuXTGcRMwmMEF-tNNOU_g-1
Received: by mail-qv1-f70.google.com with SMTP id v8-20020a0c9c08000000b003784e86dd0eso54543859qve.2
        for <bpf@vger.kernel.org>; Sun, 12 Sep 2021 16:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kE+f8eZSnmxip1KphitcMWzsxYEael7Knbp5a1w+0jw=;
        b=Hucn7Z+jJ/P60iMBcqz9lvreNC7U0rYbnzFm3PvQAHCjF4Ta1sSYyDg0zgOoBgrJPt
         ht1QSWXop/MHuI6gytjruP51SQrPj41VJEcLpeMNOTF6XaudVJ3W6a8+vYfBrl66mdxb
         QQ8eId9luOJ9GEmlMICQMw+A3WtWyZUvCvHS6FVC4OE3EAUOGrWQWxFRKOa6o/9lMuQO
         Ftt3ZluYgYshcZQW+kXSYrN4hsBvOVNacGsAv/W36uRy9vCiCe7lyWCK/R2lyiUyD6DP
         IncOZDdV+zlap+PT3uXdP4v219NVveZO5gQmTW6O+NP5m0IfVg5YXElJ+RWR8dxeSGQC
         ZZjw==
X-Gm-Message-State: AOAM532rOf95vaQ/yICaK3FEjBojtAT1jwuv+cFyKt/XI6ggHxJyAwyp
        Jft+YzBpfpELXS4KWIAtgM36O+kPSL24oE5qYfYf4nCiEsarWabIHMSV7j5MwWkqij3LbXaG/mK
        OlF45O480GoMz
X-Received: by 2002:a05:620a:89b:: with SMTP id b27mr7258498qka.429.1631488450069;
        Sun, 12 Sep 2021 16:14:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdVLlOYUeUXdlomx1acPMw/JaEVviENsKd4hMZAnyh1ZGDxZFLdD/vlSplLFhe2m6Uh8Q2kQ==
X-Received: by 2002:a05:620a:89b:: with SMTP id b27mr7258485qka.429.1631488449893;
        Sun, 12 Sep 2021 16:14:09 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id t26sm3943296qkm.0.2021.09.12.16.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 16:14:09 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/1] x86: change default to
 spec_store_bypass_disable=prctl spectre_v2_user=prctl
To:     Kees Cook <keescook@chromium.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
References: <87eel8lnbe.fsf@nanos.tec.linutronix.de>
 <20201104235054.5678-1-aarcange@redhat.com>
 <202109111411.C3D58A18EC@keescook>
Message-ID: <c0722838-06f7-da6b-138f-e0f26362f16a@redhat.com>
Date:   Sun, 12 Sep 2021 19:14:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202109111411.C3D58A18EC@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/11/21 5:13 PM, Kees Cook wrote:
> On Wed, Nov 04, 2020 at 06:50:54PM -0500, Andrea Arcangeli wrote:
>> Switch the kernel default of SSBD and STIBP to the ones with
>> CONFIG_SECCOMP=n (i.e. spec_store_bypass_disable=prctl
>> spectre_v2_user=prctl) even if CONFIG_SECCOMP=y.
> Hello x86 maintainers!
>
> I'd really like to get this landed, so I'll take this via the
> seccomp-tree unless someone else speaks up. This keeps falling off
> the edge of my TODO list. :)
>
> -Kees
>
You can add my ack too. Thanks!

Acked-by: Waiman Long <longman@redhat.com>

