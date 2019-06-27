Return-Path: <SRS0=hqV4=U2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7145C4321A
	for <bpf@archiver.kernel.org>; Thu, 27 Jun 2019 22:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D2B2063F
	for <bpf@archiver.kernel.org>; Thu, 27 Jun 2019 22:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ii2Q7Iir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfF0Wbx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:31:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39351 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfF0Wbw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jun 2019 18:31:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id 196so1651110pgc.6;
        Thu, 27 Jun 2019 15:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=I3QCREfdGAs62Jc95riCjzQjlf1m6o9ZcWuthUo1KoU=;
        b=Ii2Q7IirLZGkqJT8ryQO1kzZYg1R8wRKuTJKAkMR/6PdmbZNRNOcpksOAGO4sL8RId
         RHGXttDDhDxMLwR9PrL1INIzYV8E9hugqJ8HzkzCJXBsf1jO9jREcSzpES35QFSytOBD
         gbD1EbNMVy9k4SQsJC7MLsA/Fbl81sdclRY87+rsykUAixbcy5kxL8q3bKWAliVq13w7
         LFzURU9RArLnNl8+5aj/ZS2EzVzBvGK3/0Yr+WIAv5ygKJa2QT7/shFCXo87h3bU06id
         4BHvq6D3fgTxN+9WWa3417bx+zCw629B75tkyj9yw6dNRO+CDxWbNMOLG23qk+dN+ek8
         JvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=I3QCREfdGAs62Jc95riCjzQjlf1m6o9ZcWuthUo1KoU=;
        b=cTrZT9zHh07+ozDXZA8GcZE19qjaZDYerTcUeLHuJrFgrSlLAZI8IZ/rnEuRwWeFko
         w2dytiEh4+OMGlIWnbFxPGrQhiIoQC9x0NSgsYrZEC7J2HoErfIe3rHNxOVdoYo7Emo5
         CHByBgDWl0PoEMoGHpgNo1RmVHP4m1NhhVixd7MZ/POggl1itjrA1oqXuzkUIde9zeOi
         x1+B36mqXqK6+I+CsQz4jXhVoqpEk9ZjOx0rj1kl37aF4LR1RaYBRBQECnWV5i7q6PKs
         K+dfjAJog5X0as7O81Amv4efCjS0xvg3fHZTqS8rUTJtYGcPbp1anSwry0hgk/Z/Wnui
         3yRQ==
X-Gm-Message-State: APjAAAUZQa1qnR8cFn/+gz9CcmB0RM/30ksWtc4mQMunFhr78naVgRea
        /eGC5wmRF5piGVgJ9dddEqg=
X-Google-Smtp-Source: APXvYqzm68U65PRMDN0yXeBdlMEfgLs5VZdfRECMHYSn8eHseUIgTw8jjGQBmFN/eDx+v+9qCblZZg==
X-Received: by 2002:a17:90a:8a15:: with SMTP id w21mr8996902pjn.134.1561674711351;
        Thu, 27 Jun 2019 15:31:51 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::1:305a])
        by smtp.gmail.com with ESMTPSA id e20sm35843pfh.50.2019.06.27.15.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 15:31:50 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:31:49 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH bpf-next v9 0/9] bpf: getsockopt and setsockopt hooks
Message-ID: <20190627223147.vkkmbtdcvjzas2ej@ast-mbp.dhcp.thefacebook.com>
References: <20190627203855.10515-1-sdf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190627203855.10515-1-sdf@google.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 27, 2019 at 01:38:46PM -0700, Stanislav Fomichev wrote:
> This series implements two new per-cgroup hooks: getsockopt and
> setsockopt along with a new sockopt program type. The idea is pretty
> similar to recently introduced cgroup sysctl hooks, but
> implementation is simpler (no need to convert to/from strings).
> 
> What this can be applied to:
> * move business logic of what tos/priority/etc can be set by
>   containers (either pass or reject)
> * handle existing options (or introduce new ones) differently by
>   propagating some information in cgroup/socket local storage
> 
> Compared to a simple syscall/{g,s}etsockopt tracepoint, those
> hooks are context aware. Meaning, they can access underlying socket
> and use cgroup and socket local storage.
> 
> v9:
> * allow overwriting setsocktop arguments (Alexei Starovoitov)
>   (see individual changes for more changelog details)

Applied. Thanks.

There is a build warning though:
test_sockopt_sk.c: In function ‘getsetsockopt’:
test_sockopt_sk.c:115:2: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
  if (*(__u32 *)buf != 0x55AA*2) {
  ^~
test_sockopt_sk.c:116:3: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
   log_err("Unexpected getsockopt(SO_SNDBUF) 0x%x != 0x55AA*2",
   ^~~~~~~

Pls fix it in the follow up.

