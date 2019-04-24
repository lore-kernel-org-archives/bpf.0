Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6323AC10F11
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 22:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AC4208E4
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 22:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="r/m+h8I2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfDXWkm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:40:42 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38641 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfDXWkl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 18:40:41 -0400
Received: by mail-qk1-f196.google.com with SMTP id g1so11914308qki.5
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2019 15:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=e9cNcrD2huzs9j2v/4G7w/qaAsw2mz5pCmmQCOx3aeM=;
        b=r/m+h8I2itG1JdOgBxW14pv5MM4HXTBTz1zTSzUW/bYV26NExHvDYZb04wJFKoYgHB
         ontaPzAMq+lmD4EcRRIQr8Wyypfks616Yjww3oUywq+9idKjam18Lp9cropzygNgbpEE
         CdzwjhRCFJdIfVh/mvIC+ZRBq+MrDy5xBsmUBP72J3R1OgqkgS2pgBX1xxJOxfFkqs3T
         Ympe447jjSpqdFgvfgG3i9KbQzwgwu2ApEUkJy5uRcQBRUu/Zrs6IF/8toRkJGiXaxFu
         upukcF/QZtUBtpViPaQeZShSyAPBMMUFRWhouNRlBeDPedIM5RQzeFySvw8c8zIz6acg
         hg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=e9cNcrD2huzs9j2v/4G7w/qaAsw2mz5pCmmQCOx3aeM=;
        b=t6vahpX8QVKtZxdlB12Jlky7obGSzwqxF29L5dHKGf54uBxfK6+iRQwsDJvkgfF9FG
         QpMX+ErKYmehllX2RsX3ZL6jCWG8hJQ0fJ/Z3zHQz3eoDz/wpulNLw7aN1v25pBIP5Zj
         sKcbX68bIiJZuTyIqvBIEZ04tGa3vEHDn8ugwpXsjoVaE/usa024kY483TpSoOD4URRw
         wTrqRNEgiMf/o3U7j++e4cbjX3KyIyxxhdXlm3ZPPXbFVP7O1CepXz+7Uz4dSDVeBSJc
         7+cJtRY/OAHP8PEvtHR5IPhdnKy+3mRMN9glFqVWguPqu3lDwgM7HGTtJv1BhTcuDeid
         OQgA==
X-Gm-Message-State: APjAAAWI3wz3xWmq80paBR2uAn2dXKVp4HCuwLLqiCgMSyTPQg3Pqq/S
        L0SH6LwYCodUBkxexrrOiFgCJg==
X-Google-Smtp-Source: APXvYqyZ9Q/NO3Fck8z+t7IGKwuJ4yqG9MP51RyunKxhpwk9Qd0VdkiwkxSB6TP8bbwaU9TAk/ZmFQ==
X-Received: by 2002:ae9:e012:: with SMTP id m18mr28005796qkk.267.1556145640841;
        Wed, 24 Apr 2019 15:40:40 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id s193sm3136086qke.4.2019.04.24.15.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 15:40:40 -0700 (PDT)
Date:   Wed, 24 Apr 2019 15:40:36 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [bpf PATCH 1/3] bpf: tls, implement unhash to avoid transition
 out of ESTABLISHED
Message-ID: <20190424154036.3928bb59@cakuba.netronome.com>
In-Reply-To: <155613366350.20131.18131808324848803588.stgit@john-XPS-13-9360>
References: <155613361373.20131.9399480750962676899.stgit@john-XPS-13-9360>
        <155613366350.20131.18131808324848803588.stgit@john-XPS-13-9360>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 24 Apr 2019 12:21:03 -0700, John Fastabend wrote:
> It is possible (via shutdown()) for TCP socks to go through TCP_CLOSE
> state via tcp_disconnect() without calling into close callback. This
> would allow a kTLS enabled socket to exist outside of ESTABLISHED
> state which is not supported.
> 
> Solve this the same way we solved the sock{map|hash} case by adding
> an unhash hook to remove tear down the TLS state.
> 
> In the process we also make the close hook more robust. We add a put
> call into the close path, also in the unhash path, to remove the
> reference to ulp data after free. Its no longer valid and may confuse
> things later if the socket (re)enters kTLS code paths. Second we add
> an 'if(ctx)' check to ensure the ctx is still valid and not released
> from a previous unhash/close path.
> 
> Fixes: d91c3e17f75f2 ("net/tls: Only attach to sockets in ESTABLISHED state")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>

Nice, I think we were running into this!
