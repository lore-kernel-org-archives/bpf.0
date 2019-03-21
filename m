Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FB5C10F00
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 16:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A53021874
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 16:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJUNwufz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfCUQBD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:01:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36106 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUQBD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 12:01:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id p10so4590234pff.3;
        Thu, 21 Mar 2019 09:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KL1bQD6rNQvDf/+sKwFsKfsh+pNLBvMkqEvy+oT0gsA=;
        b=CJUNwufzEfR5BRh6mDtRtjDpgxbxkOh03KswZs+klTZm+e22goXdvsGRxLsjlnzJt4
         SPMqGQZin6p1vH2KGrhJcX5R0K7CHeTL69XUQiZoz/Wlc2SmwksUElrGNoSYIPgmNlJK
         Kuz1zAp+DPiNiAjFmJxwx3HnUuCmXb4kULzAv/DEbj+MK3CkpEuilp/R9XcLrLSy/Yrt
         rV4MCJLdhPENvDRJekZutiTPFrpdQhhaA7kLrfPm7NZQ02e7iS6Yxu/b6W85W6IYIwy/
         sksJJQwkgFaJ16ncgxc5Cz6LGRT0xuuumTcc+GQTg6fNBRtKB9Co4ctomrGn+hfjlnR/
         j3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KL1bQD6rNQvDf/+sKwFsKfsh+pNLBvMkqEvy+oT0gsA=;
        b=M0rYhvvW+zaBLUUg98oj5aLzN5p3XV1JMAmolPrBixa5fvFbyM34cUdukF2D5e+OuP
         UOoOS0bGAJK3Ovlt6rx9AIPEIMM8MYoRhCCtzwAAzL75C8E+PDGufaUZX8TXJF2RJAfj
         Tg7A9TTPMuYa4fQJp9Vj7/zc1BlSscqZGVWAXithpY4lwOylPknORmD0cBNF2E0tT+sL
         NEuMQi9eEpgnND6+Mo6F1jNcOLX8pVXKeDan3k80+YnALcM5OsrelErCs0Fdfhgx8QBS
         EIMl7yi9xuazf9jDHGZbVRNzr0hNBocuKLU5B+8VCP6UCKmc9fTw8DDyiNQnFwnyekFE
         JHuQ==
X-Gm-Message-State: APjAAAUoMsiBuK88OrjqRJd5xxAyGrYXYNStxm3a4X4ZzNRPjuGtVqgq
        BTNQQ/BynjLQNPL19Ndb5VlKdJYt
X-Google-Smtp-Source: APXvYqzj355Rg5IGHy7lkSU4ih94LNCUS/6nJaFzDHnELnLIGmMpcSzXDab/TjK9NZrOWpAAHcbvGQ==
X-Received: by 2002:a17:902:9893:: with SMTP id s19mr4317101plp.165.1553184062264;
        Thu, 21 Mar 2019 09:01:02 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::d76d])
        by smtp.gmail.com with ESMTPSA id y16sm6265972pfe.116.2019.03.21.09.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 09:01:01 -0700 (PDT)
Date:   Thu, 21 Mar 2019 09:00:59 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        simon.horman@netronome.com, Willem de Bruijn <willemb@google.com>,
        Petar Penkov <peterpenkov96@gmail.com>
Subject: Re: [RFC bpf-next v2 1/9] net: introduce __init_skb{,_data,_shinfo}
 helpers
Message-ID: <20190321160057.57u7ahijddqwtfdd@ast-mbp.dhcp.thefacebook.com>
References: <20190319221948.170441-1-sdf@google.com>
 <20190319221948.170441-2-sdf@google.com>
 <20190321033941.bygpejl2krltkdmm@ast-mbp.dhcp.thefacebook.com>
 <6406eae2-4633-9b2a-1101-2de48d29f9dd@gmail.com>
 <CAF=yD-KFZ2-p8BWf_EBpqCbpzeqwLbqtZutio5WM6MP62G7wKQ@mail.gmail.com>
 <20190321154433.GS7431@mini-arch.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321154433.GS7431@mini-arch.hsd1.ca.comcast.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 21, 2019 at 08:44:33AM -0700, Stanislav Fomichev wrote:
> 
> If we can agree that we switch everything to xpd-like, do we deprecate the
> skb-one?

This whole discussion that have been going on for long time is an indication
that initial bpf flow dissector concept was not thought through
and I regret on merging it in the first place.
Adding more hacks on top of it with fake skbs is not going to make it any better.
Since it's been in the official release we cannot remove it now.

