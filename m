Return-Path: <SRS0=xnNa=S5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E9CC43219
	for <bpf@archiver.kernel.org>; Sat, 27 Apr 2019 01:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5792067D
	for <bpf@archiver.kernel.org>; Sat, 27 Apr 2019 01:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/ELxd+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfD0B75 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:59:57 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46521 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfD0B75 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Apr 2019 21:59:57 -0400
Received: by mail-lj1-f195.google.com with SMTP id h21so4505775ljk.13;
        Fri, 26 Apr 2019 18:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QGqOA+xp33hCTVep7fnXw+u/NiaVLXxrgzJr6Ll3hx8=;
        b=h/ELxd+3Z+GhnGatwT/M1RmjO57mqLVjJT79qvlbxTLPpfn9m1ll8LKSRLq0hgFhwm
         oGAqijrfNHle7TeboaMbdhWzmVUX7qVVF1Qxl7FrSxYH++Pdt2nEvxqKK3XNZeUCaZzj
         mt4FxYPooNsKdg3TzCU5jGuh+i/UDPSkoueBOu8ohJuu9HiUjeD4RzCsqQfSyFi9sA6i
         +MfmR4sfaM38ONYNyV7ix1XVwV1JL0KVzZdQPE+JWUCwb82kJQbrD3g7Y2g2Xf7iSs7z
         YHpA1xXwanjuv0EJCI5jOQ7TQr4gtTWnFHog6L9KT7mghnkkna0Kl41Mhu0Q6pd8vE4z
         P9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QGqOA+xp33hCTVep7fnXw+u/NiaVLXxrgzJr6Ll3hx8=;
        b=JeKgq9vfpQ8w6kFY27a3Ho5GZKcAG0Pd8MS/OdS81hCAri7CqAfeSfPwLX7vBOFhO/
         1IWwHSbAd1ovhPDIk5h7ryb9esEj/g+YaHR9/EMbML4uf5yOCxcXkQC46+5aejEoPW0x
         wxQAMSz5mMc2vLhEQVkWje0F3YX44sZJQZFoZqir+mGi7OZEWSq+wXtIDmQNf1MQA3Mq
         zaLqyr2OWy/nr4p+GFZ2h5rOWKB7I0h7gzTBsqHECHzp+W2ySkLavJ+cLXobgoD0A+z/
         5mpODI0PaJwuFiZZX0VgZkWtHVksi/iqT9UZntA1OgXYSZMyfVwWYgTtg9FIti79HZhm
         UQJQ==
X-Gm-Message-State: APjAAAWIdpRdz0+19+okSThQvzrFwLZt0obSW4DgUMMNnGieIDsIZ/PF
        a9PpOihO48f12XL8AoLgYh9g0mm7ifaqfa9Gq0j0Ag==
X-Google-Smtp-Source: APXvYqwlBpxDk9t/rZu0cCkYpF6NQTLT6Evn9k4V8otkG5GqzQRpRtNiPR1+3Haveu0n+N4lGjLnOA3NYUR1PLtPy4U=
X-Received: by 2002:a2e:84ce:: with SMTP id q14mr15282198ljh.80.1556330396127;
 Fri, 26 Apr 2019 18:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190426194822.7328-1-daniel@iogearbox.net>
In-Reply-To: <20190426194822.7328-1-daniel@iogearbox.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 26 Apr 2019 18:59:44 -0700
Message-ID: <CAADnVQJFCy1u8-RyNuqQMsScwpMo1RTox9_t9JO68U=zOeXQ3Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] Two arm64 bpf jit improvements
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        jean-philippe.brucker@arm.com, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 26, 2019 at 12:48 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> This set holds two arm64 bpf jit improvements for xadd. Thanks!

Applied to bpf-next. Thanks
