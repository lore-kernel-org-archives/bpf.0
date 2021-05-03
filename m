Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CE5C433B4
	for <bpf@archiver.kernel.org>; Mon,  3 May 2021 12:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B87B61186
	for <bpf@archiver.kernel.org>; Mon,  3 May 2021 12:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbhECMCt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 3 May 2021 08:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbhECMCI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 May 2021 08:02:08 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A120FC061346
        for <bpf@vger.kernel.org>; Mon,  3 May 2021 05:01:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l4so7412682ejc.10
        for <bpf@vger.kernel.org>; Mon, 03 May 2021 05:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s+RwNQE6LklMpMlC7/iRT4MHt+ceTv7XUchB/czKmcE=;
        b=VUYtUdRS35j5f7KzTo1RJ4Uj7c+3dSMRjwbG0AyH7ZkM50sTSaPdvp2+bzZiOyPSWl
         rhRxFlXD4HoWhP4hwvWgIcpNl9fkZtcIZKNxp1p0N1tj5/rNScaPUGLYE0SYHIyyxUQu
         pUv3QTuK8u7vm+sK5lByW77ACS8NFZMorBtWJs/EfMybCyAbSkxHpQmdpvm0jSXf/I/t
         zINpVQp9Zj5ObKftx7UObzdLfobOt11rhBp/0EZN0mhnEJVYKF9EskaKFmDtdkyvPO1+
         +YSMiISVQ78aZsas9vVSaf95PUK8nB+7md4miDj/doZhveTda3AZZTDCgkCI7zn78DQl
         OAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s+RwNQE6LklMpMlC7/iRT4MHt+ceTv7XUchB/czKmcE=;
        b=heVgVBOZQqkF9ChXLN1zgK+WUzMzEPClqPVAqdpmliVsTESZiArisJ8qXjv7O61JI2
         iVW9wBKRUv+jlPmO+UwfRnrw5KZHIhoa0clyWsyoln6myVvVJem1KiS+UlefYFvWALlN
         O7teAJR/q39tt7z4yCMQpl0yFrvWp9ye1G9bK3yi353PYdgRbV+gg0XuPa619788vADt
         4/SuWpX4N+KvARfS9U3Va0BD41A4VFsBs9HnwJWdW3NTRB8W/2zY/QALfZoBxXMtk6TU
         RrkUhmI4whWEMzUPHGeRyZuBjZu8xeGt51zX65mC6qBLgoMbXC8uF4vsh71TqC0REqIg
         9ImA==
X-Gm-Message-State: AOAM533y5m6mVDq4ZCbSYais0a4tNjUJfWfUlBLPQIv3BsEeNoaYuGWQ
        iggLw7QTR7bLVMmi6Lqla5cXhJtUgUdp5+/PujBQXm6z6wg=
X-Google-Smtp-Source: ABdhPJyfsrx1lO1Gmcy3xzc4ZJCS3yemIFD7d45fFN/YI+6TzJm6tvqq28FAOl1vfN35ZesI1bNKxs/D1Ifc2evZ7/Y=
X-Received: by 2002:a17:906:168d:: with SMTP id s13mr15971516ejd.81.1620043272065;
 Mon, 03 May 2021 05:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210429130510.1621665-1-jackmanb@google.com> <CAEf4BzY7sx0gW=o5rM8WDzW1J0U_Yep3MMuJScoMg-hBAeBPCg@mail.gmail.com>
In-Reply-To: <CAEf4BzY7sx0gW=o5rM8WDzW1J0U_Yep3MMuJScoMg-hBAeBPCg@mail.gmail.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Mon, 3 May 2021 14:01:00 +0200
Message-ID: <CA+i-1C2+Lt7kmwsZOEw6D8B_Lc+aJdZoUmPDh08+7y_uMNW+kA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: Fix signed overflow in ringbuf_process_ring
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 30 Apr 2021 at 18:31, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 29, 2021 at 6:05 AM Brendan Jackman <jackmanb@google.com> wrote:

> > Note: I feel a bit guilty about the fact that this makes the reader
> > think about implicit conversions. Nobody likes thinking about that.
> >
> > But explicit casts don't really help with clarity:
> >
> >   return (int)min(cnt, (int64_t)INT_MAX); // ugh
> >
>
> I'd go with
>
> if (cnt > INT_MAX)
>     return INT_MAX;
>
> return cnt;

Sure, it has all the same implicit casts/promotions but I guess it's
clearer anyway.

> If you don't mind, I can patch it up while applying?

Yes please do, thanks!
