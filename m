Return-Path: <SRS0=rM0N=7W=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE07C433E1
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 18:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12FA62067B
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 18:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDD1uqsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388910AbgFISU1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388905AbgFISUZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Jun 2020 14:20:25 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F676C03E97C;
        Tue,  9 Jun 2020 11:20:25 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y11so24674329ljm.9;
        Tue, 09 Jun 2020 11:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1UmqHndylAKxGJX7FYv1MgzV7Bb9W4RKBrBw18IkLFg=;
        b=FDD1uqsA6nGoNGcc9tXnygpq7Kf7mg40KZ7mc25jUhB54DGdhNz6WsiVhBcv+NCZ+i
         2QQqQlKsZEYDpPLjO0QzLAueaZrLsZ3A/pmJu6ZJafLamgIBAkoiPDiHr5qqekuhBkjr
         kyo8x194qZFkZ8k1jUySaWfqGUIsYw5DfvtziZkYjbDn/kwA+BfO8C8SNn1f4zxfH8X+
         J6pio//pdxm0672Lz1/HhT6IH4IivFRf+AFzAKwzN9YgW1D2EHfgQr5miSQeqWir3PO6
         TvnG5MUzXpSl2+QVzNMyjPQh2FIwM8hZXoKks0ZYukTQ8R6mSQovRZHjBoGoR62699Vy
         dvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1UmqHndylAKxGJX7FYv1MgzV7Bb9W4RKBrBw18IkLFg=;
        b=mC3gZu38Ky80dTCkD7pgQl+twyMBwARqDKIVKUpiLDknGzpzMt6uZIxowS9kZdJway
         GkZye5xaYpIu9OKGXJYHDeSCMp1xNe99DwifusspfnmN65YxQTx0EGxbjiIfJuNDt9xh
         FZcZv4LfaHYW1lALI5vv+KMYXYCYIYDx8eVbxsy0V3t8QkEgwiHKodwtQOP7Wh0nCTfX
         svPPuYAHOnWbmeBX+Y/HSZrHiNRclLdQsfSN9X8x7xzH5LB3K9YAW5WrsALKtzM0vB4+
         z2c6I1zHPtfOwvKYE+pZ1x8tLeTTVNVJeHi7EA7bUofKXCAB0QUire9oMtttcYBMjm/C
         oUIg==
X-Gm-Message-State: AOAM531e6gUyRrYh5sG0HFZ61SoErfDyvM/k4EXTuh66voop24uLtlrK
        wNK787wm4EMuoWq1m3Ng0FY/FaBJna/SGuy6e70=
X-Google-Smtp-Source: ABdhPJwCOogO12BY91rGPFd7kLaNaATnfS9GcFhbjFtTs3Nh+FQ5t0kzxprNkjO43NSOdxYaYGv7VCgLKyJl6rw/wzw=
X-Received: by 2002:a05:651c:1193:: with SMTP id w19mr14848384ljo.121.1591726823712;
 Tue, 09 Jun 2020 11:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200608151723.9539-1-dsahern@kernel.org>
In-Reply-To: <20200608151723.9539-1-dsahern@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 9 Jun 2020 11:20:12 -0700
Message-ID: <CAADnVQLJiNKxdAsC7OUuiTG4Z2csdpG6ctff8j1f6BgicpvE_g@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Reset data_meta before running programs attached
 to devmap entry
To:     David Ahern <dsahern@kernel.org>
Cc:     Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 8, 2020 at 8:17 AM David Ahern <dsahern@kernel.org> wrote:
>
> This is a new context that does not handle metadata at the moment, so
> mark data_meta invalid.
>
> Fixes: fbee97feed9b ("bpf: Add support to attach bpf program to a devmap entry")
> Signed-off-by: David Ahern <dsahern@kernel.org>

Applied. Thanks
