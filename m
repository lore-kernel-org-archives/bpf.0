Return-Path: <SRS0=xp9Q=RK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628F9C43381
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 00:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C11E20663
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 00:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djoJqkbC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfCGAvU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:51:20 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52763 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfCGAvU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Mar 2019 19:51:20 -0500
Received: by mail-it1-f195.google.com with SMTP id g17so12661036ita.2;
        Wed, 06 Mar 2019 16:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CQvNh0UfmKDGyJfHMkKEx+iRb4Rg37Cn61IoHqbBWtI=;
        b=djoJqkbCbRCVy/zdY+dtI1qZWCG65GwLkhw4dHYIK3q8jJaOaEivcZdVCscAlNHuxi
         Z660VW0U5fK5+ymGajDQZpqDcH0rxBfbdGN+oIKuz2o1Fy7dEUOvD3RFIRqdbDCBVf6i
         EmkTxY32WpNOjbo/VBdO5cdRh/6VmTqo+PsyFjUjQv5IzrlliP7XgdRLlsNt0AnLNUny
         FLHHXzZ1oxcgtjvKaCg5o20ShzZ23SenSnZUMeCHkEF+u6Kr3l5KrOuA/jbbixvTJu5W
         2SZFlPwTvo7XT9d/27hqkZk3pWYUfxzEOy0/xgPJP7GpvyDDVt1eWjbG0GeqiSbBQg6W
         cmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CQvNh0UfmKDGyJfHMkKEx+iRb4Rg37Cn61IoHqbBWtI=;
        b=ALgmqVHkWFFGM7BUg7NBDcH1O14GZCKL7k2drA9X1PMKNhi6CNFp6s12BoAtBtSdDP
         A0iDWTPo50oFiPhpt0aLgL0h2M5jU0CaKfJA9/Fa0BoHXNP4+c45sWS1ZH/ZmGnFDdds
         NnvYSxjx6pyJP16sDCvtHpjOFn3Pm7HY2QXgReKSrFiV9shnuAD3b0D0CdQ9O+cYWXRM
         IWuHphbAhfFgjQsicXK6+md9liqG0ip5x+Ms+/GeWp+7Ijxig+pcc7JNjg1fL5r1yu7U
         gZ/P70Xkkoco674vcobdjqJ6TGKirg9lmB4NWZplgdt7MM+hM4Zz3ps/4GIJjhZODwP4
         RBHA==
X-Gm-Message-State: APjAAAXxmcsLDl1ouCUwHRvI9COcDVlt0NZFqV/aTKsvCPfz88FdjkZE
        YpgDAE5vszRaNk0EnwrrpV8yN/VJVygC7+/l/a8=
X-Google-Smtp-Source: APXvYqx7uRUpxajUfPvjKszXpSM4Bhh2cxUBBrhif/vKmCxtf5ECNNiRLDTn+FY/TVoucISDQrkl4hNIMi2hxItOdrE=
X-Received: by 2002:a24:1947:: with SMTP id b68mr3371465itb.121.1551919879154;
 Wed, 06 Mar 2019 16:51:19 -0800 (PST)
MIME-Version: 1.0
References: <20190306232526.219483-1-sdf@google.com>
In-Reply-To: <20190306232526.219483-1-sdf@google.com>
From:   Y Song <ys114321@gmail.com>
Date:   Wed, 6 Mar 2019 16:50:43 -0800
Message-ID: <CAH3MdRVu9Fk_NavZn2XJcXKkicwjRC0m0H4zvSRSRokxhdk_jg@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests: bpf: test_progs: initialize duration in
 singal_pending test
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 6, 2019 at 3:25 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> CHECK macro implicitly uses duration. We call CHECK() a couple of times
> before duration is initialized from bpf_prog_test_run().
> Explicitly set duration to 0 to avoid compiler warnings.
>
> Fixes: 740f8a657221 ("selftests/bpf: make sure signal interrupts BPF_PROG_TEST_RUN")
>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
