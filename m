Return-Path: <SRS0=uiV1=BK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD5CC433DF
	for <bpf@archiver.kernel.org>; Fri, 31 Jul 2020 22:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38978208E4
	for <bpf@archiver.kernel.org>; Fri, 31 Jul 2020 22:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596235749;
	bh=CGZPpSPwU4Ft3nkQSct8Yfba5pnYrv+k1vzWI7Vvo14=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YeG8TB+Fg1dkmEtpn+wBKfXZDdM5jLvf2HaymxaFuApZNOLRam/ZEjSsksmbz/THu
	 Z1Ijoymqhn5Hp8aBxNGOaQuQ3/6hFiP1nXvezKdytK9ntcHe9I2F1J58z+yX3sF791
	 rW7g8tApjnRZMyb2+fDt+CNI3lnKJ2ajMzyaFTqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgGaWtI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 31 Jul 2020 18:49:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgGaWtI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Jul 2020 18:49:08 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DBCA208E4;
        Fri, 31 Jul 2020 22:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596235748;
        bh=CGZPpSPwU4Ft3nkQSct8Yfba5pnYrv+k1vzWI7Vvo14=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V1by968qfs6cOZcU1RGIjbf0/lSp2y69tB7AD7jaJVYjK/s+8Rpc6j+mbnOtl3Ruk
         5XfDh9lJyYT1Z/TPZ3BcjJ6Z5b8MdR5eb6YhNPIVejjJVR3R5PzcvsZEmS1A2N3miE
         Hs7vZ/3sFCu6aySFDws88EpbodvX09gz1GOHmz1M=
Received: by mail-lj1-f182.google.com with SMTP id q7so33978606ljm.1;
        Fri, 31 Jul 2020 15:49:07 -0700 (PDT)
X-Gm-Message-State: AOAM5320jpW8nJbMhexCWq5JJjnWtV4nktQ7LkHJsqbaRobsZpGi//Ax
        ZM3QGhCwCX5qJ4AVUuiL1Ns6TqyU16kAzs1nzIo=
X-Google-Smtp-Source: ABdhPJxzRPwQz1lTk777pWHRA3nE93WDPkgpLtBySMa4XjqNP/eILmq6dAu6ohDnYHZqED3FUVOUjsoU0/sg2yfgUaw=
X-Received: by 2002:a2e:88c6:: with SMTP id a6mr2752812ljk.27.1596235746330;
 Fri, 31 Jul 2020 15:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200730212310.2609108-1-guro@fb.com> <20200730212310.2609108-2-guro@fb.com>
In-Reply-To: <20200730212310.2609108-2-guro@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 31 Jul 2020 15:48:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5X5tWGspKwwtJdsRgE8xu=4TsDF5+=sR7k+yco=9Uz0Q@mail.gmail.com>
Message-ID: <CAPhsuW5X5tWGspKwwtJdsRgE8xu=4TsDF5+=sR7k+yco=9Uz0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 01/29] bpf: memcg-based memory accounting for
 bpf progs
To:     Roman Gushchin <guro@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 30, 2020 at 2:28 PM Roman Gushchin <guro@fb.com> wrote:
>
> Include memory used by bpf programs into the memcg-based accounting.
> This includes the memory used by programs itself, auxiliary data
> and statistics.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>
