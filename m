Return-Path: <SRS0=QYON=7E=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAEAC433E0
	for <bpf@archiver.kernel.org>; Fri, 22 May 2020 00:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B3F207D8
	for <bpf@archiver.kernel.org>; Fri, 22 May 2020 00:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbZiLmbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgEVAtj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 May 2020 20:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgEVAti (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 May 2020 20:49:38 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48392C061A0E;
        Thu, 21 May 2020 17:49:37 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h188so5562430lfd.7;
        Thu, 21 May 2020 17:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dfbw7avi1/v+2GUBR7cQ38zrYckkFuG7Hq440sNID04=;
        b=JbZiLmbIFTyas0mLmtffNTqkytIEJC777+tmPjfnsyi42s4HrDBDr51HOKTr296vmx
         cYvmpvUAC5YeU/otRvMPRkOrkyOBJ+7q1H15wFJ6Xt9XS7IUwv7KL54m4jKKH1wKX5XB
         G5Rr9nkTJLwe3kODJeERgu0ntQqH/ot+rTZVAcPhfEsxPDnv8q0uUukTzdHUK4dHnqJ9
         NM9GaSGp2hWPAIfHvIFXyyjZwJZRFXZ7on1NNeq5tQyLX4trTl+hYxP+IukHrfTTmSb0
         cDmMobshaWnXRHrLsXBNagzzeZS0JoWv7tfdRiNFGfd0xhuUMt2CmjbD6eDA0WdE0cj+
         anxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dfbw7avi1/v+2GUBR7cQ38zrYckkFuG7Hq440sNID04=;
        b=JrKUjrs+VKzxBicSSUuulTdrtkvfazr3546tkIOeV+eINqm1/OOazVGuExrMlMSz78
         5Tdkm78DVq1P2BYQ+4y3lSeJLHsk7YvA9Pztyo+vBlFHhsPNHH+fHF0VnG1ziffDXKjl
         CHUZo4hKh2z+Ok0HByhdAR/Yb7K+VkfS9ZcdyDI2hpdCPS0LBFU1Y6fjwMhqSuJOcvEe
         V36WdPex7G35H/+YQp83nwYwbuTZSJhsWKwRzo02IDEvNO2GH37PQx2HYNUDPLjPrFP3
         SajNJkXS2ztV5v4NirjaLXuPUr2RXCF5Hefcvb41X4LKl5fNfn5L7EbQO/eW6u+dh+Tf
         e8qA==
X-Gm-Message-State: AOAM5309XodksSYaOoCbjlohjZtm/blJqap/0Gk7EwF8zN3XAOiPFVzH
        A6vbmb4I5DMF6Sx8bExHXydMWo2jCiSRgLeIydw=
X-Google-Smtp-Source: ABdhPJwaC8UO4CRHwS3kQ1bKtlOt6aWiU2KE1326VW/e5+gSc381hlQdOz+qpJVsPEjNyWVOsn7KHbF4xeW+Nq+JOUc=
X-Received: by 2002:ac2:53a6:: with SMTP id j6mr6188820lfh.73.1590108575701;
 Thu, 21 May 2020 17:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <159009128301.6313.11384218513010252427.stgit@john-Precision-5820-Tower>
 <CAEf4BzbZmy0A0xmHD64+G3db+4a15yXjhA8SAEebWB3iUqpJLA@mail.gmail.com>
In-Reply-To: <CAEf4BzbZmy0A0xmHD64+G3db+4a15yXjhA8SAEebWB3iUqpJLA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 21 May 2020 17:49:24 -0700
Message-ID: <CAADnVQLtjnp+Rk5Zof5WHQ2Sw-xYxY39OqYgr_DKDgS8M+5HEg@mail.gmail.com>
Subject: Re: [bpf-next PATCH v2 0/4] ] verifier, improve ptr is_branch_taken logic
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 21, 2020 at 3:21 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, May 21, 2020 at 1:07 PM John Fastabend <john.fastabend@gmail.com> wrote:
> >
> > This series adds logic to the verifier to handle the case where a
> > pointer is known to be non-null but then the verifier encountesr a
> > instruction, such as 'if ptr == 0 goto X' or 'if ptr != 0 goto X',
> > where the pointer is compared against 0. Because the verifier tracks
> > if a pointer may be null in many cases we can improve the branch
> > tracking by following the case known to be true.
> >
> > The first patch adds the verifier logic and patches 2-4 add the
> > test cases.
> >
> > v1->v2: fix verifier logic to return -1 indicating both paths must
> > still be walked if value is not zero. Move mark_precision skip for
> > this case into caller of mark_precision to ensure mark_precision can
> > still catch other misuses. And add PTR_TYPE_BTF_ID to our list of
> > supported types. Finally add one more test to catch the value not
> > equal zero case. Thanks to Andrii for original review.
> >
> > Also fixed up commit messages hopefully its better now.
> >
>
> Yeah, much better, thanks! Few typos don't count ;)
>
> For the series:
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Applied. Thanks a lot everyone.
