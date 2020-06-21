Return-Path: <SRS0=b4Fz=AC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA6AC433DF
	for <bpf@archiver.kernel.org>; Sun, 21 Jun 2020 03:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE34722280
	for <bpf@archiver.kernel.org>; Sun, 21 Jun 2020 03:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592710589;
	bh=v3mzq+YnoOq7srNl44XI8cNdXnliR63fACjCzkUnSWc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MFVe6VgG4hQWihsScZnndt8V5jj2IWf4xacoOEzjZfFWXA2msk+M4CR1VKgjy6MQO
	 Oq/krnWezqRppgVVoIOfOvO2T+RpjIkaIXQgJFvXFDth+TtB0zsMkrokXgV8SOHaH7
	 4cSut6sgK0DxVedvYp5jvQ8pkcPgpxWa9oGIrHXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgFUDg2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 20 Jun 2020 23:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729208AbgFUDg2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Jun 2020 23:36:28 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81A6C223C6;
        Sun, 21 Jun 2020 03:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592710587;
        bh=v3mzq+YnoOq7srNl44XI8cNdXnliR63fACjCzkUnSWc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zYxYVe48l2wymP7evFDJ4Xp5gcAmUWRCsNxkv9C7aWimNfPZTb0xWdEWUeZzGJkbj
         7O8sIosH6z/3WpeUsfGPOmOfpvCTwT66enyLjlZOczHf7gB8onj8kvgv6DRHTLmdJC
         7B2YCVU7x+Zp8KBYxJDNNTHoNNMX+Xnm9KduLxlA=
Received: by mail-lj1-f173.google.com with SMTP id 9so15673280ljc.8;
        Sat, 20 Jun 2020 20:36:27 -0700 (PDT)
X-Gm-Message-State: AOAM532ZJffyFYX662DMZSmqPwMv9mNB+avPeZpVM+PJZ3HGz9I+ktMs
        EDXlVrvzGCwrZO35MCX/UdZq3od/vdT3WooOmF4=
X-Google-Smtp-Source: ABdhPJxFuT+7lDrdFgYN6aI+ICiZBXCAohmVfGdEnCqTKQV0Wy5P3HlJ3eGkxXDCnHVUC8td7pzZlZXxfU0Dijvs9fA=
X-Received: by 2002:a2e:9ac4:: with SMTP id p4mr5864679ljj.446.1592710585728;
 Sat, 20 Jun 2020 20:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200621031159.2279101-1-andriin@fb.com>
In-Reply-To: <20200621031159.2279101-1-andriin@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Sat, 20 Jun 2020 20:36:14 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5Z19E8=F88wphBrQvRioBJBS=-1K8L-HftZGCMf75D=Q@mail.gmail.com>
Message-ID: <CAPhsuW5Z19E8=F88wphBrQvRioBJBS=-1K8L-HftZGCMf75D=Q@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: forward-declare bpf_stats_type for systems
 with outdated UAPI headers
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 20, 2020 at 8:12 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> Systems that doesn't yet have the very latest linux/bpf.h header, enum
> bpf_stats_type will be undefined, causing compilation warnings. Prevents this
> by forward-declaring enum.
>
> Fixes: 0bee106716cf ("libbpf: Add support for command BPF_ENABLE_STATS")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>

Thanks for the fix!
