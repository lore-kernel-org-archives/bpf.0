Return-Path: <SRS0=hBvA=VV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E898C76186
	for <bpf@archiver.kernel.org>; Wed, 24 Jul 2019 23:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5964C21911
	for <bpf@archiver.kernel.org>; Wed, 24 Jul 2019 23:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nP5udgef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfGXX2Y (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Jul 2019 19:28:24 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34022 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfGXX2X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jul 2019 19:28:23 -0400
Received: by mail-qk1-f193.google.com with SMTP id t8so35103585qkt.1;
        Wed, 24 Jul 2019 16:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mU992a7oYOVxYKcfZHbO2WVkVRJ5DTWW16uCv49KPxA=;
        b=nP5udgefiRbfyC6nPhQR7pWCC+Hz1JaMnnrbxg3nuAv5s+qz6mlkUcoben2msx5MIf
         JkxS+xG5WR4wzWLW5UblOPOhz9OzEmbx3VFm3dvesybGeG3agM9WI4ocr70vvBcsT5U5
         GcvFnc+MR3mISPFHfUY8HD4CUkMW4GhXTGxqGC3xAq8MgWVSNq4F8EGSA71JCvuQ2WM7
         C+MeqP2sewkopTANxWyfzRaoVTGXGXDy+fwlZjKmOVQ2Fo0GTeslXgnvlhQR+s21NYoC
         7XxapXcDg6YC0VPSNMADGUSrtCylJ/u9BTjS0JO+dvbqwSQMhVx34L5Fc87xeC3iMa3F
         ofVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mU992a7oYOVxYKcfZHbO2WVkVRJ5DTWW16uCv49KPxA=;
        b=Lv6xN1CFomyrcclrs8e5yULwVF+HF4S+B2v6VkUm8iwKFhhHMPbNFO0nqxwDlstmOw
         +wfYwgMzRb3N7MC2kUvkPt/gPgAknsOURn5/qtDwzTLYm7sY/Ovzw2pmUbF7tx0SWmf1
         uyBeS6tsYQXDo8IrVy7VZSqBuzNY3S/YFCkG43M8h9NnI5/sAWL1rW9X7QOtBeFFT/uB
         GRRfEpvCXPuaCFbJEsHffB3tZYEwDPR2MnFh+rMC8llSofcyl6R11JNzP4UnMTDfIWbk
         hvTEXAkKEzph046yvcLWqqmgWWfVk8DMPezRkz096+q2hV5dSt9h0SCmYuIrVMryHRhg
         FV0g==
X-Gm-Message-State: APjAAAV+tqoeWCqIcQ8wlSPRzI1uFubxiKLx/s9MvG0xfc7bdGJRFhhd
        P5eNxpLzdzSOX2TiLhidhowNf+/ZCumPi9aU/qc=
X-Google-Smtp-Source: APXvYqyuiPjE59Ixp8uQrm8EIyphs0w46FXFl1Zo0q5MQnCcgAWTN4YK47vippcwUYqiP7nHSqfpqCN9fLVzKbtYxZw=
X-Received: by 2002:a37:a854:: with SMTP id r81mr56965535qke.378.1564010902704;
 Wed, 24 Jul 2019 16:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190724170018.96659-1-sdf@google.com> <20190724170018.96659-7-sdf@google.com>
In-Reply-To: <20190724170018.96659-7-sdf@google.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 24 Jul 2019 16:28:10 -0700
Message-ID: <CAPhsuW5YGMs8i4k-XCAT6BTN1tERn_R=p1JgK5_KsxOMcVd-qA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] bpf/flow_dissector: support ipv6 flow_label
 and FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 24, 2019 at 10:11 AM Stanislav Fomichev <sdf@google.com> wrote:
>
> Add support for exporting ipv6 flow label via bpf_flow_keys.
> Export flow label from bpf_flow.c and also return early when
> FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL is passed.
>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Petar Penkov <ppenkov@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Song Liu <songliubraving@fb.com>
