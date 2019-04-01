Return-Path: <SRS0=vda1=SD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E04DC43381
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 17:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566A420830
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 17:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUi6Donz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387618AbfDARrr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:47:47 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42211 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732940AbfDARrr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Apr 2019 13:47:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id x61so9028456edc.9;
        Mon, 01 Apr 2019 10:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SRCbJYkYOUImHK/8r4ri4MRxn2jv2EmGcopiw5P6DL4=;
        b=YUi6DonzTx4pTtF8O40YP0c1oHeWs1ORlWbG7FiHvTcL00zlLmRBWtLntwZiaTMC2Z
         HiInwy5Qj/BNtnGLkTBF8kDqPDNdKLjL+dfDYDo4o0KNGmH9n1uN9udjsoai37Vg2vMr
         2VbdobMUkLyA4zCZtoR1Wh/hoQAQVyIas1yKoEWe1sBSqnnGe/Egn45vMjQlW7/cRfIf
         XxXA/LBYLx2+EuXSKt+R6QyrnEsxfs8ryRooocXMY2+KMwmBYjiq5Yhlx5Rmo2PEMu5Y
         wDkpkTWHhBgq/Yo7CGRC0Mrv6BsVCHaWz7V3qWusiuW9A2zjgibXVy+SV35Y8NSNAcDB
         +sEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SRCbJYkYOUImHK/8r4ri4MRxn2jv2EmGcopiw5P6DL4=;
        b=OdpoZxztt7l5t/5WH31e3DuhsTn2vlT/jxenxMq0YWB1RPVh8n5mHZI+/ZJ7MWrTOm
         z5lKYSEmgCfwu/UUe93miXYUVOfQEihq9bnMBKBcRMuhl5qI2R5KAOD8pXzomKVt6+Zz
         A8Who0G6pR6f8iQawcVePDNDejYvy/n+oPrVJdxP2yumqVSBZIiLf74tgmMixrXs+SCq
         Rxu0XttcsiN7razZbZ4sYrgw6yZoCtnEDNh4sSmf9qlrXG7odNW+pvsAGHEVxsXGS9xp
         9gD7U0erh/F/3nHlh6F64QmNuSe37qBkGGb3PB/ZaotbUQfDB5nGLNCOy/mFXU80URhT
         sqpQ==
X-Gm-Message-State: APjAAAWAuBVfXZxpK8E4BB7Mih5DRcD6vCCQ2gZaNO5PxrhN5Sgx1wUx
        /qJL+0gNuNHkmcN4RHwy0nXcwPqtWq1zgBwsi7M=
X-Google-Smtp-Source: APXvYqymRnN4oEC5qAaOX/IMmXbpxbbWvcV6heFcqUOwONdOQgRryaiQ2jtvMqwlsjN1n1No8Q7HjLj7liRkI2L2LG8=
X-Received: by 2002:a17:906:c14f:: with SMTP id bp15mr15415680ejb.211.1554140865544;
 Mon, 01 Apr 2019 10:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <1554132731-3095-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1554132731-3095-1-git-send-email-alan.maguire@oracle.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 1 Apr 2019 13:47:09 -0400
Message-ID: <CAF=yD-+KaTO7Ljw2VMeEMzXnGLtFmG3LFvuHgA24_+oOTi3mpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] L2 encap support for bpf_skb_adjust_room
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Willem de Bruijn <willemb@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        songliubraving@fb.com, yhs@fb.com, quentin.monnet@netronome.com,
        John Fastabend <john.fastabend@gmail.com>, rdna@fb.com,
        linux-kselftest@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 1, 2019 at 11:33 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> Extend bpf_skb_adjust_room growth to mark inner MAC header so that
> L2 encapsulation can be used for tc tunnels.

Perhaps superfluously, but I forgot to mention earlier during review:
super useful extension! Thanks for working on this Alan.
