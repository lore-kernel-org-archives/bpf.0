Return-Path: <SRS0=sdV5=6J=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CDBC2BA1A
	for <bpf@archiver.kernel.org>; Sat, 25 Apr 2020 00:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3A920748
	for <bpf@archiver.kernel.org>; Sat, 25 Apr 2020 00:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVtMIio7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgDYAbE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 24 Apr 2020 20:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgDYAbE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Apr 2020 20:31:04 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BF3C09B049;
        Fri, 24 Apr 2020 17:31:03 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x23so9205298lfq.1;
        Fri, 24 Apr 2020 17:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=86kOY5gb/BNU+BmmkodsZhezseJjOT9rMGSuGTKEj6c=;
        b=DVtMIio7iwcZDF34fkWQcJ7MHWDCh/6+cdmQQi+TzGVKLGgqH9KsmV6ZBnI7spZKKL
         F7pAfsM/Dc168BHL2IPuTz2wqSV8RQTUgvXdB4F+9xDJcq5/RQoin8b79SPPdVNcgR8w
         icwl816H5Ir8NIXJQviZuw2Vy1KaRhF8NcKx+fYcc2xLb2XLQ2v/ScHIIsUWyd8RcbxS
         sGN5UBFjnHvLsoL9tmJ8bNel2jdpqWae01MzicgDdE5ZSwt5Cm4jF1m2+7B0vvXiBrs+
         oK4dBhVe1rB9gKMn3+ZzM4Bc+yynX7bmbzR/CeBO/ZPh3yRenwwo/qc/+KYfT3/3iEiO
         KRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=86kOY5gb/BNU+BmmkodsZhezseJjOT9rMGSuGTKEj6c=;
        b=OIA5RTDtcF/tDdd1LVRwwY4R/oC/rZ11/hYjZ19sEYKDks5PQ3ZOkrb67SUO870oIm
         LX8nqDeRaToAJdqv3svVCBqMwoQ2PJGwm15H2UjywWLodo0KGPxbecsEyH0L40VWoyx2
         /j1mjP8aFB1JVFyawYfVt786VhVKk0buyqQXsVlYVhb1iHkgv9M/cz1I7tvy9o5dSvpp
         W38ckhkb1SYhQd7ArRRPq+N2XbNx66fzZMDoEtSYS3y5e729PYc0eK5GlgmyWLqXo9h4
         eWbnIP3qzt/IJKKAq/c67IIH7EsS5EYCAKYiTsdLntC9GvdIBUIes2ZikeS1PEmmYvOD
         vI9Q==
X-Gm-Message-State: AGi0PuY1cwj+fbU6gNeVS1vEcQHRRoXkTvBaSPk8k7a398utkGAZ9jtd
        9KDxjPinxb+owk/CAs9jKrB657EIM8asJKRyLoy8LQ==
X-Google-Smtp-Source: APiQypJ918bwgwkKGwZI1HTuzADhTjWPqGktKIZNIXsWCjvpH0r8+INEV+t9eAbGz/LFsPZsPXh/36gF4WIeiS8m4Vw=
X-Received: by 2002:a05:6512:304e:: with SMTP id b14mr7519964lfb.119.1587774662389;
 Fri, 24 Apr 2020 17:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200424052045.4002963-1-andriin@fb.com>
In-Reply-To: <20200424052045.4002963-1-andriin@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 24 Apr 2020 17:30:51 -0700
Message-ID: <CAADnVQJSG1NxydbgM9-YXfhSeKeawwDnfKBemZ_HOL+c7tJGDw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] bpf: fix leak in LINK_UPDATE and enforce empty old_prog_fd
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 23, 2020 at 10:21 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> Fix bug of not putting bpf_link in LINK_UPDATE command.
> Also enforce zeroed old_prog_fd if no BPF_F_REPLACE flag is specified.
>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Applied. Thanks
