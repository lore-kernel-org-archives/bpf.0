Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68952C433E0
	for <bpf@archiver.kernel.org>; Tue, 30 Mar 2021 23:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F15AE619D0
	for <bpf@archiver.kernel.org>; Tue, 30 Mar 2021 23:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhC3XQX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 30 Mar 2021 19:16:23 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:27087 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbhC3XPy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Mar 2021 19:15:54 -0400
Date:   Tue, 30 Mar 2021 23:15:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1617146152; bh=zG9SSUw4/Ao2wQS3FMFRGbEb1lFQgDiESXkJ9lxuSsU=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=fUFFSwYfp9SbO1ukq4EIU6vyXzV7ofNWUGi1ivJdCvgJaN8MTAKk9MMt6Kbm24WR2
         BrL50oqRFGoJ4SI2YgefkLgrkrjVIebu1GJ/zmbIUa+YyOgkAQmb1qJbeBeAxt6PBM
         vA7O3zDYWDKIjukMWmELfDWna4c32uffjNIzGFkGiL0cBnRqExcMQrbXxDxeg1Pi2h
         VF0FF6FbFXrFdVnBsx7gKzvo3hDiQFYP5NeqEJ8G2IHhPr4JSUAjxF0cd+WZiak5B9
         i5GBs3zu1vkLUB2uQF8RvTi3VVKo1WOPKUCZsMD5ZLiwv8sOYCj6u2lSVfe4U7DAyl
         HXuRCocOfxmLw==
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?utf-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH bpf-next 0/2] xsk: introduce generic almost-zerocopy xmit
Message-ID: <20210330231528.546284-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series is based on the exceptional generic zerocopy xmit logics
initially introduced by Xuan Zhuo. It extends it the way that it
could cover all the sane drivers, not only the ones that are capable
of xmitting skbs with no linear space.

The first patch is a random while-we-are-here improvement over
full-copy path, and the second is the main course. See the individual
commit messages for the details.

The original (full-zerocopy) path is still here and still generally
faster, but for now it seems like virtio_net will remain the only
user of it, at least for a considerable period of time.

Alexander Lobakin (2):
  xsk: speed-up generic full-copy xmit
  xsk: introduce generic almost-zerocopy xmit

 net/xdp/xsk.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

--
Well, this is untested. I currently don't have an access to my setup
and is bound by moving to another country, but as I don't know for
sure at the moment when I'll get back to work on the kernel next time,
I found it worthy to publish this now -- if any further changes will
be required when I already will be out-of-sight, maybe someone could
carry on to make a another revision and so on (I'm still here for any
questions, comments, reviews and improvements till the end of this
week).
But this *should* work with all the sane drivers. If a particular
one won't handle this, it's likely ill.
--
2.31.1


