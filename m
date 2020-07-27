Return-Path: <SRS0=Ijne=BG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2122DC433E5
	for <bpf@archiver.kernel.org>; Mon, 27 Jul 2020 23:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E5520729
	for <bpf@archiver.kernel.org>; Mon, 27 Jul 2020 23:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595891177;
	bh=FPWD3onrUxK2GT6ifmwjjpII4umFRyEUsAB/YSKdseA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MwxJqx35D2V4/vVPRoQ0LCLz43gqZOwL40hy9ESXvn9ALvlw1YPN5YiVYi0nqXhFw
	 DzLKGdqc5vCEHvZdZXdy6uW0aW6nmoBQzwFqQi2qxMWjkoquVGBe/XMjyuKpUkCJFa
	 1T8owjklOG2F6StX6DBD/bn5KN3DUoAUzMrIg/Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgG0XGM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:06:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgG0XGL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jul 2020 19:06:11 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9B9120829;
        Mon, 27 Jul 2020 23:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595891171;
        bh=FPWD3onrUxK2GT6ifmwjjpII4umFRyEUsAB/YSKdseA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P3weFuDuEzGmr/OU7w+ZFbuIvgkqldkuZvyqhBr09Nv2VGwKP3S3LFTB6b63RLxSE
         AoQXU6775AVoPX2kTFDL0dtBmPMuZytpHkqMwFv4l03RURnzaMnfdx/ZFfvoSBNap4
         4Qq28PlC32XziEgOW47hcnxJrWua8CTvBrtsu28s=
Received: by mail-lj1-f169.google.com with SMTP id s16so3852307ljc.8;
        Mon, 27 Jul 2020 16:06:10 -0700 (PDT)
X-Gm-Message-State: AOAM5339oW65IQLnF05UOVoHkJuJkeDxc5DnQNaWIHzLdotkm7pbLkus
        jNSRy3gVRJLQOXuPFp++SlJ9QDMGincLTp6y7l8=
X-Google-Smtp-Source: ABdhPJzr5WBxLO6UgqcVNxi16m6YVNRnhk5yV8AISnFiiIYzfd8fzmYFWapbtq1On1DJdZMmO1OL8DaxNZf7h3HtMZU=
X-Received: by 2002:a05:651c:1349:: with SMTP id j9mr4063441ljb.392.1595891169081;
 Mon, 27 Jul 2020 16:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200727184506.2279656-1-guro@fb.com> <20200727184506.2279656-6-guro@fb.com>
In-Reply-To: <20200727184506.2279656-6-guro@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 27 Jul 2020 16:05:57 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4wSZ2G6h8naYoCi_MgVTi7PMyTnRJZ6PeFFivZD9mTNg@mail.gmail.com>
Message-ID: <CAPhsuW4wSZ2G6h8naYoCi_MgVTi7PMyTnRJZ6PeFFivZD9mTNg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 05/35] bpf: memcg-based memory accounting for
 cgroup storage maps
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

On Mon, Jul 27, 2020 at 12:26 PM Roman Gushchin <guro@fb.com> wrote:
>
> Account memory used by cgroup storage maps including the percpu memory
> for the percpu flavor of cgroup storage and map metadata.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>
