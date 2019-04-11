Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C61CC282CE
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 22:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1152184B
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 22:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PHx0n3YZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfDKWZ7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:25:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41670 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfDKWZ6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 18:25:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id k8so7000849lja.8
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2019 15:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mLPKjn8BQfaK59DjTSl/PYkQ6vhd1km9Kry4eExEeuk=;
        b=PHx0n3YZLKIf0SEemfRmQE5t1xJSYsXhRHLaFy44lwFlOMshML7TIRTCOVKNSZJo7r
         vaPEbL9w2PWMgh/DlB6/iqzPjI/mIVyFIZu4dXlLQDffvgcuYi95sACRapvuZv7it7y+
         Htu+lBpUx5LLFwjedIB5S6mBn49l0GVhBacR8bKFqS8Hk8cCQ5EsiM9BLXQKe1VTyvmP
         hzK/1pDKDplQ34567gUIDbSgY/oofo7zSvlj9bNvUdDhLybj5vbkY+mLqoRZeWsgzeFL
         bYjrACxWC2T+HxNCLfKWA9jTS9BHkTau+BEShamX+MELGUD95xub2pRJwzmfV9FxEQjF
         JbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLPKjn8BQfaK59DjTSl/PYkQ6vhd1km9Kry4eExEeuk=;
        b=VXqz77LPfxYRsEH9sNRUtkIebnvzLqXS3lJfqJCLTL9eVB7wcVGJ76Dsc+e0feAVd1
         kdgVjqDnfcPhRPIJMjNWP8Ss3DXWc64owzFCoLyMT3KkCJBPjd2zbvCHIzMrHkd/t7+t
         34PSSRZ3CqPZ4MGlO+1g2H3hubS5U3g9D7776aX/Ldio5jU9rSMJkRi2h6bxYrvkq2UW
         PUHEnSrpf4WbV642PJbK1eHSq88egDkTLhHCtDQMP+30l9ZRcCBNkVziKZaGG4AHM6pe
         mejtg5asC9+MZpRio2OSkJnU18I6vIkoGnuN8ibdzFCFGXpeTj0HWgDrkTeY7t7552Ai
         lHuQ==
X-Gm-Message-State: APjAAAXXgy2JA9K1njS02u19Oo5RGjq7HanTk6qTPLu6dqTzE9SrBRKX
        qWxgD8HohdQ1/oTMdORwV6HC0ZwyRFF+Nn5tCMf9voJeIQM=
X-Google-Smtp-Source: APXvYqxxxWEcfMfjjf07IdXCuDa8xoyFsfgUOGfZPiyx0uhe27URlzMRQ8cKFXyY9pHXXJuTlwON3tGXPKJTzB75Jc0=
X-Received: by 2002:a2e:b058:: with SMTP id d24mr396685ljl.42.1555021555961;
 Thu, 11 Apr 2019 15:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190409184911.97485-1-sdf@google.com> <3e26d75a-da10-9ae2-12f8-893f334fa1e9@iogearbox.net>
In-Reply-To: <3e26d75a-da10-9ae2-12f8-893f334fa1e9@iogearbox.net>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 11 Apr 2019 15:25:44 -0700
Message-ID: <CAKH8qBsx2F-PY8NJ0Yh3rdNBNGGPnVd+EPiHSRhsLa5cRoA9Rw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] bpf: support input __sk_buff context in BPF_PROG_TEST_RUN
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>, Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 11, 2019 at 3:23 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> Hey Stanislav,
>
> On 04/09/2019 08:49 PM, Stanislav Fomichev wrote:
> > Add new set of arguments to bpf_attr for BPF_PROG_TEST_RUN:
> > * ctx_in/ctx_size_in - input context
> > * ctx_out/ctx_size_out - output context
> >
> > The intended use case is to pass some meta data to the test runs that
> > operate on skb (this has being brought up on recent LPC).
> >
> > For programs that use bpf_prog_test_run_skb, support __sk_buff input and
> > output. Initially, from input __sk_buff, copy _only_ cb and priority into
> > skb, all other non-zero fields are prohibited (with EINVAL).
> > If the user has set ctx_out/ctx_size_out, copy the potentially modified
> > __sk_buff back to the userspace.
> >
> > We require all fields of input __sk_buff except the ones we explicitly
> > support to be set to zero. The expectation is that in the future we might
> > add support for more fields and we want to fail explicitly if the user
> > runs the program on the kernel where we don't yet support them.
> >
> > The API is intentionally vague (i.e. we don't explicitly add __sk_buff
> > to bpf_attr, but ctx_in) to potentially let other test_run types use
> > this interface in the future (this can be xdp_md for xdp types for
> > example).
> >
> > v4:
> >   * don't copy more than allowed in bpf_ctx_init [Martin]
> >
> > v3:
> >   * handle case where ctx_in is NULL, but ctx_out is not [Martin]
> >   * convert size==0 checks to ptr==NULL checks and add some extra ptr
> >     checks [Martin]
> >
> > v2:
> >   * Addressed comments from Martin Lau
> >
> > Cc: Martin Lau <kafai@fb.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
>
> This still has a bug in that we need to reject !bpf_prog_test_run_skb() cases,
> since they are not handled by your set. So for e.g. XDP, flow dissector progs,
> we need to error out if ctx is set such that it can be safely extended in future.
> Please follow up.
Good point, sure, will follow up on that!

> Thanks,
> Daniel
