Return-Path: <SRS0=NOCw=DA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1A8C2D0A8
	for <bpf@archiver.kernel.org>; Wed, 23 Sep 2020 20:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FCAD206F7
	for <bpf@archiver.kernel.org>; Wed, 23 Sep 2020 20:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhcGU5l1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIWUFr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 23 Sep 2020 16:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWUFr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Sep 2020 16:05:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C16AC0613CE;
        Wed, 23 Sep 2020 13:05:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t7so289902pjd.3;
        Wed, 23 Sep 2020 13:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r50CUWizV47cosiiFrIGu6a1Fqqd+ON8/SIk8oh2K5I=;
        b=fhcGU5l13PMCRQA8etVGCNh6HA21SmngN3DQeBQx4U8JTgybBnbI3Z9VyRFb0eOq+x
         G7rFwR9qJveSEQykdeVygmYaYCS40X7w107U42N4k8M194rIi6cKgryQEDeIE7qqEksf
         gN8Cd/HpQxzm/hF+a/GexsrTTBsvZhaR2hMgzcDbTRZJ84G78wklxjjqeTY5UcwHshfn
         t4Dk/rpMPdwEgz71+/7zAfMTOuRAORH7BPibRUIJV1ddpJ+BzhXd4cdUA9IfYAWozQ+V
         V7CDnQgGpNg9R5ID2p+vTbq+1WK4i5uwRjJSq8JPC/4GTDhmY/7+R99uXWWvNi29vkTk
         wciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r50CUWizV47cosiiFrIGu6a1Fqqd+ON8/SIk8oh2K5I=;
        b=pYL84L+xveJPUj6+BAFQkXUYObA905gdW9Mw3UTv6mnBWtrQX0Vhjdhfqktu3N/rTZ
         6NAKIRq+IrU9JsMKgHYyHFt6ULHV1wqR7JcDu/Y7LP8DxmkyizEG6uhco/Io+YPU+gcn
         bPHVRKz1Y1kZ34AMgiVSej5r8b6CiORx9SJLsJPa9qk9HDFtRaa/xM7pfK5nwFfRe3rw
         QJBSf6vhxGIckMU4Dko+PfLCSErnXtY0dpVhswgDJcRQa8vuM8r9iHg623K7xPIRKZCi
         ErL2h5lrroPR7rQbsq+lRRSeKSa61FXUNw00xyvfPhMRoNT7wOEyNN2tpxENzHNuUS37
         MxkQ==
X-Gm-Message-State: AOAM531jpERHgkjQXhSdmSOAAnObmQ9ZLh9+g9CLykRl3+ELopQwER42
        azw3xScxuiJAcVCfIWOehxo=
X-Google-Smtp-Source: ABdhPJyC5dbbuCQNH3EBU93Oyrp5mtKwMTiTJyC+eplLWK4lUpmV7CVThIwsvJHpkb6e3gIS3o8Jug==
X-Received: by 2002:a17:90a:ab8f:: with SMTP id n15mr865091pjq.139.1600891546456;
        Wed, 23 Sep 2020 13:05:46 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:1807])
        by smtp.gmail.com with ESMTPSA id 75sm639909pgg.22.2020.09.23.13.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 13:05:45 -0700 (PDT)
Date:   Wed, 23 Sep 2020 13:05:41 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCHv3 bpf-next 1/2] bpf: Check CONFIG_BPF option for
 resolve_btfids
Message-ID: <20200923200541.gencqbw6k7xw33uc@ast-mbp.dhcp.thefacebook.com>
References: <20200923185735.3048198-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923185735.3048198-1-jolsa@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 23, 2020 at 08:57:34PM +0200, Jiri Olsa wrote:
> Currently all the resolve_btfids 'users' are under CONFIG_BPF
> code, so if we have CONFIG_BPF disabled, resolve_btfids will
> fail, because there's no data to resolve.
> 
> Disabling resolve_btfids if there's CONFIG_BPF disabled,
> so we won't fail such builds.
> 
> Suggested-by: Andrii Nakryiko <andriin@fb.com>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
> v3 changes:
>   - updated subject, added ack

Applied. Thanks
