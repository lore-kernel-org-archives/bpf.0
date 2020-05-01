Return-Path: <SRS0=KuSb=6P=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397A6C47256
	for <bpf@archiver.kernel.org>; Fri,  1 May 2020 23:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06EC92184D
	for <bpf@archiver.kernel.org>; Fri,  1 May 2020 23:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ka22SCta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgEAXws (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 May 2020 19:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgEAXws (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 May 2020 19:52:48 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6247C061A0C;
        Fri,  1 May 2020 16:52:47 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 188so5063215lfa.10;
        Fri, 01 May 2020 16:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fhpUd3KTt89xfWncWQDykv056+ZVfYnLxoCmV5ESyvQ=;
        b=ka22SCtaig9XGQg0FqxN1q0zRmsQdWwrvEWDnkfIR9mkP7APJKkRZGyv64rsXkTgEb
         obcpgedhvvxqBdk2hbtTlA4RTc+esLb3Vue3yeaY4oOmYAY6XE+r0Juew2JJd/0XNCd2
         dQCPL2DGkRvWEMu5rRFA3Nsw9GAW8NPXyaGy/5bBVisVyCp6xFdMfe4Su9m4mE8jyprh
         7yq6/oSdZM8NtTpx3L3yNApR5+36SiUCbOq7D1uTlAAf5rpqC8i4AEweh/soLe9UF2rC
         NWdUxVlCzXfsWz2QJM0qcWrezIbfEk8qNowvvY+YyBIX2DY5ugMkL4+wM0iBZQ6HBBX9
         JA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fhpUd3KTt89xfWncWQDykv056+ZVfYnLxoCmV5ESyvQ=;
        b=X24KbXA/qvExHrVmWjhcjjpUFRA275KpTO1SuPM/0IS01HlU2za2Sqi2YnWZ78Jsiw
         vsY+kbXLqBV0zMjMzAIvE5z1ZjyfHwl2fiVSZjs2mZuydmeJN4eHSomPVaK/W3eIfpDR
         aYJPDxVV1vpD2btWf0DraFcABQptJX61hCXQOJalevR3IyraSnSCf7XINmtcJn7XJE51
         q+YErTQ09tOTZ1tqZZ0F+ituul9xb9OP1d5aaC+52ZxnMRGeDTloqAPW/IJHwzawM6iW
         lUv7vTukwHpOealQGU2JZptj+9UmIOtlFfcxtO/08ioz0voznq+3dO4iHWpeTdo1Qyfw
         3ZkA==
X-Gm-Message-State: AGi0PuYzTla/J15bdMqOR5pmAfDUGhsI3p7JTVugFztEhtJj4ZASGP91
        LWsCCsAkeg6atdUcdic/FgESZKrUehhunwDkXauXUQ==
X-Google-Smtp-Source: APiQypLncqum4n6ln75EI339iN7GETVsUUFDA2Ky+aJdnCOS/HKBje7e20JtBFPFcBhvtJONecb1FnYu+o0SO+4sI6Q=
X-Received: by 2002:ac2:420b:: with SMTP id y11mr3962472lfh.8.1588377166409;
 Fri, 01 May 2020 16:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200501224320.28441-1-sdf@google.com> <20200501225700.j4dukc7t5hxaijer@kafai-mbp>
In-Reply-To: <20200501225700.j4dukc7t5hxaijer@kafai-mbp>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 1 May 2020 16:52:35 -0700
Message-ID: <CAADnVQJfFm7OhHAxKpSddk7toESWvHLuxpF2Fgt6ZBBS0EYMyQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: use reno instead of dctcp
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 1, 2020 at 3:57 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Fri, May 01, 2020 at 03:43:20PM -0700, Stanislav Fomichev wrote:
> > Andrey pointed out that we can use reno instead of dctcp for CC
> > tests and drop CONFIG_TCP_CONG_DCTCP=y requirement.
> Acked-by: Martin KaFai Lau <kafai@fb.com>

Applied. Thanks
