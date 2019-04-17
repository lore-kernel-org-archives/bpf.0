Return-Path: <SRS0=eni5=ST=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C393C10F14
	for <bpf@archiver.kernel.org>; Wed, 17 Apr 2019 02:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40EE20872
	for <bpf@archiver.kernel.org>; Wed, 17 Apr 2019 02:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUUA4E5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfDQC1V (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:27:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41840 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfDQC1V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 22:27:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id k8so20947876lja.8;
        Tue, 16 Apr 2019 19:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6imz376tDzZkcuRQS9ychoKDCt5Xwq1b90WpLetd+z4=;
        b=mUUA4E5EUqBN+3/mrVU+b+X5n+wnaxHmFbaUtOZwDWSa1yWlSwLzpZpiC7uxZKQJBZ
         dooQgKlpMfEzPM1UPsca8UWuOoxPxKPYMCg7ziaL1Q9DxfZ+UNb4zIF4y+kW/B1dcFp9
         4c/DALQZ+iGr3LBlfEHY6dyy9ApuRVt+KyzlNwIKLq/Syp+H3lnmhA7umL5PWaYmCsT3
         qnukWZKWdmukw6oWAPB2xxpblZgowjj61UGrHoLXbqEOwWUbP0Kcyo72k6zL0YkBy05d
         AU/ip4CzMHCEDpRXA/7qGxDq2XB7NZQQ6K4nM2TcwY0XhKa2ayseTqH7fKqUR4e58A/0
         ssEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6imz376tDzZkcuRQS9ychoKDCt5Xwq1b90WpLetd+z4=;
        b=IJteNBB2gusy9kBIx9OzMMkeVk+ztJ3rI0y4TQC1W3/ETzc3EpXwRHpfTxXis/22rD
         kw2X+X1vnVhFBHCxfiOtxbDz0KcDzIqDCBIUxqNXiH2yGsbHHHgK4zp9bFACgBXLqyy9
         5vFaYdzY2aSSivFlBKj4xmoIB3uRR05bRGbAkRhIjFe1Cw/tiGS3Vwj451iSAKqv2p4b
         ysQYAh3r3C99QhYGdcYZ0+JmbHH6WC5kq2nhTAy1oJw8XU6XST0F8GKWJJaJ5xVcpWgt
         +quLjM/ITCa6Wq6iqgUreZ19akQ6pRzNi7zN9SwQEAfKC5f2Ps8U07nVjcvarnFIlJ6u
         g6Gg==
X-Gm-Message-State: APjAAAV7ahlKx3XSTRgD1Gyfgpo+8QhqAVEmeQtpNqHas6NPmFLx8TqG
        OURSp39o1hncR+Eic6JXh/RTvVCYV9/xoP3Pd5Xe2g==
X-Google-Smtp-Source: APXvYqxrjI6aC7F0SP6xQespPDGD0spjx3A+yz6UdfSRBJ9Bpmy/EDCG6tkHQUVvdIw8GZokvChrwC9XzrtVhpTM8g4=
X-Received: by 2002:a2e:9655:: with SMTP id z21mr21146661ljh.60.1555468039383;
 Tue, 16 Apr 2019 19:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190415131042.1111-1-hoang.tran@uclouvain.be>
In-Reply-To: <20190415131042.1111-1-hoang.tran@uclouvain.be>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 16 Apr 2019 19:27:07 -0700
Message-ID: <CAADnVQJFXEe3mtdVg-7thR0MTM=GdBDSDOtkcfaF48zhDHK41A@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: allow clearing all sock_ops callback flags
To:     Viet Hoang Tran <hoang.tran@uclouvain.be>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Lawrence Brakmo <brakmo@fb.com>, Martin Lau <kafai@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "tranviethoang.vn@gmail.com" <tranviethoang.vn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 15, 2019 at 2:55 AM Viet Hoang Tran <hoang.tran@uclouvain.be> wrote:
>
> The helper function bpf_sock_ops_cb_flags_set() can be used to both
> set and clear the sock_ops callback flags. However, its current
> behavior is not consistent. BPF program may clear a flag if more than
> one were set, or replace a flag with another one, but cannot clear all
> flags.
>
> This patch also updates the documentation to clarify the ability to
> clear flags of this helper function.
>
> Signed-off-by: Hoang Tran <hoang.tran@uclouvain.be>

Applied. Thanks
