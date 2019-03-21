Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905D4C10F00
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 05:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6244C218D3
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 05:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uI8tNdMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfCUFvK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 01:51:10 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37349 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfCUFvK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 01:51:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id u2so3695732lfd.4;
        Wed, 20 Mar 2019 22:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v9DDQPYRs9CEXdr+NIvFh2fLOhQ616weVJYbihPm7A4=;
        b=uI8tNdMeRzc5jtPoIEKBc3JH+Ls7hKN+sQa8tfsfLJatWktzOwJmCcfkYjwVeBziTc
         cayV2iILGgkFx5W2f068b/i7yH8UDXrkWPOOTbkyhIhvaGQ6u/+SfbqggwWYcq4S8Syo
         +ZiWFjeDrYJ9Nj2j3gJOlcbPfHpjO89astOE8TMIZKTVkIsg5MBR2pMdWHw1KG3X9JxV
         UEEoSKSQnTAoJiFBTKwK51G6W8fgYLwmhEySO9KvtxJlRrNMjQuZb3w1i9KFBo0VN7aF
         OwbAIp1MPqXnf5XKAfD+Mpe8HEumzvHDZgv4yI3oTOZP7tBSt2MYmK94Dsl1CCKySLx2
         +rRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9DDQPYRs9CEXdr+NIvFh2fLOhQ616weVJYbihPm7A4=;
        b=YV6yWRTXcNyx8CjImd4vUeOymoLQDdpnnCM47+p3rbWR4tX+o/1gNq1IW9YMleDorW
         2e3FUTOroYUhxW7RPUGSfwLfDhZERjMQli1B1i/WI6Cf2XnZhk0YavcJfsSCPseuwfBy
         U9Qqm8Q2lc/c7GSrecu4W65pJ/cMO8inA/Yb59ktnIRIdV5KdsRNb8MfHMFt0tG5layB
         GihIoh9YO2gSSGCcVL6MEYf57W4dWG6M7ULtQ3MyZ15X+dCFD+nukmZcwPDrRC+GFGZr
         oWPLoFTaExXtXK+sima6ZgB/87oPaBuEb27yKBQH2EMl0dcKa3xFK9ef7RlmFYUmZ2AH
         QNbQ==
X-Gm-Message-State: APjAAAVqsR1IMeEE89fRZeHj3d5njmQwVo5Sp+lqh3F3PdO4WHd6YaDu
        SV/o570R0KmWh9bqkGgT5SW6PFy0XvcQIks9MxQ=
X-Google-Smtp-Source: APXvYqyNsCOvoThc3TKmUQAGCYBWYQVu8kUdWgWjjL65ppfaZeI5dPGiyQjJ54DK/RO9VosdTE1TVIvdLWY3k7FcQ8o=
X-Received: by 2002:ac2:4ad1:: with SMTP id m17mr807811lfp.129.1553147468541;
 Wed, 20 Mar 2019 22:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190222095057.9442-1-lmb@cloudflare.com> <20190319102103.7380-1-lmb@cloudflare.com>
 <20190319102103.7380-5-lmb@cloudflare.com> <20190319221735.ycueci4ec4rvbkxf@ast-mbp.dhcp.thefacebook.com>
 <CACAyw9_euySi4LWWD-789DdY-XYgMNLaNY+RrhJieoY7r0qcwQ@mail.gmail.com>
 <20190321030339.mr2jlxtyevfuegyf@ast-mbp.dhcp.thefacebook.com> <CACAyw986toY6X3_m=bo-0b8BQXfTJFBvpC+tYrk-iu3F8uf9QQ@mail.gmail.com>
In-Reply-To: <CACAyw986toY6X3_m=bo-0b8BQXfTJFBvpC+tYrk-iu3F8uf9QQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 20 Mar 2019 22:50:56 -0700
Message-ID: <CAADnVQK5ao0zCaKRcEp-UZdf2JUrD48aDKRF9zPWfekSwNVWUQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] bpf: add helper to check for a valid SYN cookie
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 20, 2019 at 9:53 PM Lorenz Bauer <lmb@cloudflare.com> wrote:
> >
> > So please resubmit as-is.
> > It doesn't apply cleanly yet.
>
> Sorry about this. It requires Martin KaFai Lau's fix for the
> bpf_tcp_sock reference
> tracking, since it depends on sk_release on PTR_TO_SOCK_COMMON. How do I fix
> this for bpf-next?

Martin's fix is already in bpf-next.
Just rebase, may be?
