Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A021C10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 05:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF2D20874
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 05:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1Qg7Zmu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbfDOF7V (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 01:59:21 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36264 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfDOF7U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 01:59:20 -0400
Received: by mail-qk1-f196.google.com with SMTP id k130so9159047qke.3;
        Sun, 14 Apr 2019 22:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d0YCiaK1n9JusruGFdQ84tr6jUY9diMWGa+Y3Qfwwx8=;
        b=c1Qg7ZmuNH0QSpIcgQIxuMJ0c7D+3prATDa1qv+MqDO2RKHE02jEM96qb/Xh4Ge7J+
         ZGXv2KMMSDb7UA+mBgLyCas+3gFXeccQcAQ3PfS5qeaUmuxQSer4ZInhWXMuVJUshBeB
         3BvAqYB1kjKzjnyjc3dWXkgVjc+/G9bvgE1HOJn36qxo35CewpAxAk+tZo9ynJo41J6K
         bBXRxuJcZvHW6EESt7qktatc4Zhno7qdotz0EG37nZmxcUexpa2ty+eKjc40mtyiI+BI
         8mD3eHQvx+xVvTbnb/SrfbiWeU+dMXaSMw2EQqz69Eem9NjmYtEJyXnyv1En5wq71orh
         l9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d0YCiaK1n9JusruGFdQ84tr6jUY9diMWGa+Y3Qfwwx8=;
        b=fxCcKESM9CdNG8Kk+fji6vp7evDjYN8FDBkcCijCM9+U5KwVxGz/JGdvB2lkdBSv8Y
         xFXPVm4UiJ8xczA+N0b6VuR/30RjUmhmzf8HOWax94jub/h+J2gCwnbY5HXm9gWOYxcz
         lUsHy0iUMNWhBsN07lM3zcnWSeJwTMG4+7SV5E2VY9/RgwdkducZgmMIXg6zbNwSrhYP
         U4q3z9uf4C4PgL4XsIOC3uryAQ63vrQhqlJy6pEO/nwwzLEJQBwiHGvMrADCXnmkAyZm
         VRbJPjUO6pzXjdNSb7VZgd29Pk001EMjd8EvQ5DcbdEDGju7wRfideIYJhwi6dkuLWeW
         tQNA==
X-Gm-Message-State: APjAAAUxM3hV/SJerIW7z36SrCdeC412Z6y0jtgKsRlYPRn0PtGfKXW+
        10sOh6du+ciwKqwDrIROcx9JPPk3tSvVgDNqhcSrAA==
X-Google-Smtp-Source: APXvYqy/rScPYX9xmqKSJpTxZFIEz9r5qmxcskckBJLph00lJJLYnCS+UDMw6PIARpes/9m8GzVPrsoaVHSS1GOd+/g=
X-Received: by 2002:a37:a841:: with SMTP id r62mr55481564qke.16.1555307959666;
 Sun, 14 Apr 2019 22:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190412214132.2726285-1-ast@kernel.org> <CAPhsuW7qxRywrDQ8PLWiFwHtfSsc+24LD1dPBnsO+jpQf8adfA@mail.gmail.com>
 <20190412233248.iik56fgcnmyk3pm7@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190412233248.iik56fgcnmyk3pm7@ast-mbp.dhcp.thefacebook.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Sun, 14 Apr 2019 22:59:08 -0700
Message-ID: <CAPhsuW5kh_rQxBncvtknRRDKZgUkayNCQDej+3EF_7WggC4UVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: two scale tests
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 12, 2019 at 4:32 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Apr 12, 2019 at 04:24:51PM -0700, Song Liu wrote:
> > On Fri, Apr 12, 2019 at 2:41 PM Alexei Starovoitov <ast@kernel.org> wrote:
> > >
> > > Add two tests to check that sequence of 1024 jumps is verifiable.
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >
> > Acked-by: Song Liu <songliubraving@fb.com>
> >
> > Shall we add a test that go beyond the 1M limit?
>
> 1m is not uapi limit. I'm working on the doc patch to stress that point.
> Adding a test to check that it fails at 1m would kinda imply
> that it is uapi and I very much want to avoid that.
>
> The purpose of these tests is to stress the verifier to its
> internal limits, but not more.
> In particular in these two tests 1024, 8, 512, and another 1M
> are limits too.
>

Yeah, this makes sense. Thanks for the explanation.

Song
