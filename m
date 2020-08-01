Return-Path: <SRS0=+7Cc=BL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C74EC433DF
	for <bpf@archiver.kernel.org>; Sat,  1 Aug 2020 03:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 585042076A
	for <bpf@archiver.kernel.org>; Sat,  1 Aug 2020 03:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJR2drAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgHADeD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 31 Jul 2020 23:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbgHADeD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Jul 2020 23:34:03 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7213BC06174A
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2020 20:34:03 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id 133so17248026ybu.7
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2020 20:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LP9aWd8ANIRJ334AMfd3BQ+PoGF1KaY0D50ioS68Yk0=;
        b=dJR2drAtIqLOjoDIAyBqRff5VKxje+SKgES+jYB1kHXa3wio6WBrXx07IWN4XfXm0w
         P4G0EvMcT2yMKCgnMiZg7wv5TD1TKSmfFJg7wZaqp7HkOkk3MrZMPL2DcoIFjn/OD+zy
         JUUieicBe/uidHaHLCN5kCmvZP4p9ucyFBMifB9Fj5kacM6NfZFG0jpHmGJQ7u4azY5k
         zCss3eSkMaP1fWROt1ma3MApeWJLdLM21DeOdgefxopRlVzzZ2auyHH+gc1vFyqqO8Pn
         AbUhchbh7EWfabfa3emgulrANnrpd6uC+p7VYAL5dfqGqhI+sQep9ukKTx3+3U1qxZhJ
         jQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LP9aWd8ANIRJ334AMfd3BQ+PoGF1KaY0D50ioS68Yk0=;
        b=VbI/8Dlwb8pgv1/Lxn2P4/ZO04mgjxm0t7M97wF4DfJqTtq424FMhxd6tYy6hr7LJW
         yp8pCrPYnb8eM+lXNqrAVQF6oNrDvCMmGtOP4ekE36Jmpmm3KGTnTpGzSvP7rG6okAvS
         8iLcA9Agml3eqLKCHiv/DOngDotW7MM7ycw6iIF3mK5NYzTx843zgRF61H7kLeTTnh2D
         jjwvbd+aavwrZkQCkyOX0b76llcB1ZDutAWsPzpU5lFaRcEqcn68XDvbADVt/Y7DT0SL
         T7Dr1oqk2zxtcMsV0Yp5qntKN+lxyFf/R+H4lBXPQMEDkuEG6iuTIwihhWgkTuWjmPN0
         h1KA==
X-Gm-Message-State: AOAM533NN4uXczxzvf/AidduWqtjM4mRt3jcQj6+IzFwZEM2f3L0XSQT
        2VJaNdY+y2vPxAqUyZ7knNEVCzbzxxJ0HR4suQq99Q==
X-Google-Smtp-Source: ABdhPJwqM1ZoTII0lD5HhTEEfXJcwcQqMfAD7zFXY8JGVMzYBqe1PQ8/dt+d+O6WQiEJKja28SMui5oYeSk6hRqKZuo=
X-Received: by 2002:a25:37c8:: with SMTP id e191mr10089416yba.230.1596252842612;
 Fri, 31 Jul 2020 20:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <159623300854.30208.15981610185239932416.stgit@john-XPS-13-9370> <159623335418.30208.15807461815525100199.stgit@john-XPS-13-9370>
In-Reply-To: <159623335418.30208.15807461815525100199.stgit@john-XPS-13-9370>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 31 Jul 2020 20:33:51 -0700
Message-ID: <CAEf4BzaXsve_=CfEzipd=wRLfDYSUdF6u5Myrd5E=F4qt=hGeg@mail.gmail.com>
Subject: Re: [bpf-next PATCH] bpf, selftests: Use single cgroup helpers for
 both test_sockmap/progs
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 31, 2020 at 3:09 PM John Fastabend <john.fastabend@gmail.com> wrote:
>
> Nearly every user of cgroup helpers does the same sequence of API calls. So
> push these into a single helper cgroup_setup_and_join. The cases that do
> a bit of extra logic are test_progs which currently uses an env variable
> to decide if it needs to setup the cgroup environment or can use an
> existingi environment. And then tests that are doing cgroup tests
> themselves. We skip these cases for now.
>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

makes total sense, thanks for the clean up!

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/testing/selftests/bpf/cgroup_helpers.c       |   23 ++++++++++++++++++++
>  tools/testing/selftests/bpf/cgroup_helpers.h       |    1 +
>  tools/testing/selftests/bpf/get_cgroup_id_user.c   |   14 ++----------
>  tools/testing/selftests/bpf/test_cgroup_storage.c  |   17 +--------------
>  tools/testing/selftests/bpf/test_dev_cgroup.c      |   15 ++-----------
>  tools/testing/selftests/bpf/test_netcnt.c          |   17 ++-------------
>  .../selftests/bpf/test_skb_cgroup_id_user.c        |    8 +------
>  tools/testing/selftests/bpf/test_sock.c            |    8 +------
>  tools/testing/selftests/bpf/test_sock_addr.c       |    8 +------
>  tools/testing/selftests/bpf/test_sock_fields.c     |   14 +++---------
>  tools/testing/selftests/bpf/test_socket_cookie.c   |    8 +------
>  tools/testing/selftests/bpf/test_sockmap.c         |   18 ++--------------
>  tools/testing/selftests/bpf/test_sysctl.c          |    8 +------
>  tools/testing/selftests/bpf/test_tcpbpf_user.c     |    8 +------
>  tools/testing/selftests/bpf/test_tcpnotify_user.c  |    8 +------
>  15 files changed, 43 insertions(+), 132 deletions(-)
>

[...]
