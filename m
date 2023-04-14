Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9DCC77B71
	for <bpf@archiver.kernel.org>; Fri, 14 Apr 2023 17:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDNRtr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 14 Apr 2023 13:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDNRtr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 13:49:47 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4AA189;
        Fri, 14 Apr 2023 10:49:44 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id BCF7410006C; Fri, 14 Apr 2023 18:49:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1681494582; bh=xefM+LwubfKwyQKkIthRzIj6Q0OUiAoa5UzF8ib1bBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BaE+0Fr4dYlowT/Y81TvGEbu5mh+HMkkVvkQAwu0Xtdp3v10Bv+R1NKOvIGSkcfsn
         yETh4LfPVp6zjlBqCMQXHsGtM7TRFS8Bxqv6zZu7VuZ035vbuPSKT7wVMSpkclD/ds
         6epZTqIx09qrHgOBfsgMWMBtcW47OgWgiOES9m2K0ZxrMntSnCyr+Q5V/+mIzfAA3J
         mV27zRCVnw55bTLwiCGGnBsHwLRSJRFnQZ/OACku46wBkVir0O4eTm3AzENFYZrBl4
         qjgBp/zzbwV8UnaYbfLTPqDx2EeDxvoFoW01gWQ0Wa6tbPKcNoD0TikeMTXp28TkI6
         u5oP0PAIkeH/g==
Date:   Fri, 14 Apr 2023 18:49:42 +0100
From:   Sean Young <sean@mess.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] bpf: lirc program type should not require SYS_CAP_ADMIN
Message-ID: <ZDmSNjEQrTY9GG7f@gofer.mess.org>
References: <ZDWAcN6wfeXzipHz@gofer.mess.org>
 <CAADnVQJ-zzzTxDj8_7WKW-o3BDsU=DNAnvSEZGNHswbhGA8xhA@mail.gmail.com>
 <ZDe9ND/M4I9ll1xV@gofer.mess.org>
 <CAADnVQLOmDEQsHX4XfgETXUte9mJ+-qphR_E7dcjXB2PMDaZnA@mail.gmail.com>
 <ZDkx6WAWmwHpBJ6m@gofer.mess.org>
 <CAADnVQJnw1Jdu+oD5_+ci+RxoaZCDwjgHZQo16bSgmnr2DDCOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJnw1Jdu+oD5_+ci+RxoaZCDwjgHZQo16bSgmnr2DDCOQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 14, 2023 at 08:39:13AM -0700, Alexei Starovoitov wrote:
> Yeah. Agree. Could you respin with all these additional details
> explaining the motivation and driver permission model?

Thanks, will do. The commit message was way too short.


Sean
