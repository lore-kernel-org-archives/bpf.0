Return-Path: <SRS0=rV2l=SZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AF5C10F03
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 16:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D893A217D9
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 16:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dkyqFUnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfDWQAl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:00:41 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45465 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWQAl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Apr 2019 12:00:41 -0400
Received: by mail-yw1-f67.google.com with SMTP id r139so3075274ywe.12
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2019 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A5rh+SEEw+LkNd4PNRM8S/CAKDRg7nP5EXtuSgbjnc8=;
        b=dkyqFUnSPvZ8gmm9hQCp6z38rS9fTeqEpDRnXZ4cunwwm35tktou4SmAz2PwAj6dAJ
         +n9MMc8vnExEaAhXagEuX9pmwdRLTMdiyQyUkAXZMJI7QRuJMgjdbKzSEFs14Goy/st7
         aIjQYXtxLbvUYMIxcfRk0lfarY+BkMwEBOZRGg7SGs9mcqPm9YdnPfqQCD7YqZaQbrfJ
         WTvij3MUuTJbbIxtgXGaFFAtZeh90NK04k9iOe+IngxkKC5BiW7xddtDOUgD/uJCIKhs
         PF2uiq4YHPzODkn+hNmdhhkYSTn06IPU6F9KpxbLapy3tl7Il2oIsFabZdxRCB7FNeg6
         VgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A5rh+SEEw+LkNd4PNRM8S/CAKDRg7nP5EXtuSgbjnc8=;
        b=TDlgyU+B9FrshBFio4w/4as0TuoP+ntgXHyGUjjn9HuxxIQpIvbREB9x+eLuHgOd5W
         dc15l8umXSVgI3O0SdQkRePvrkSTNoeNMrSRs5leGSpPpetaCBYV8WH4sui38rGySvI5
         06VMHhnE18hILm72Mo2vbNqao2//K15PuTGz6mDEQ5lWQsaafkOeZT2SjiYI6juOekU6
         d4iPutEppECb1iTd93msyiANBFH5ez3gDxFCUbBqCTfj0Iu3LPPomOOfKik9J1wySchQ
         XU3eLqeTDnvJuScRnWhaMt+IkzHua3beaKCym9LdT195NwpqMrstYFOblIUF6VEy/LLg
         WEXg==
X-Gm-Message-State: APjAAAWkYESDYitea5HocoECYZ8nsd9P77nFTtMZDqwgZtM9qEEl8yiZ
        vVdjjkV1cmqb9RpKqxh71OddsuDL5/fGBj2PfjhLTg==
X-Google-Smtp-Source: APXvYqw9lDkFxM/Wfva83pbQw0mjsO23I2APY/zdN2ACgabrODgcQbn7NczvthwED+4m9BN4UYV2zh332+ItIDHTzdA=
X-Received: by 2002:a81:993:: with SMTP id 141mr10186491ywj.441.1556035239916;
 Tue, 23 Apr 2019 09:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190422155552.222910-1-sdf@google.com> <20190423041503.np4dlso7c6qw3wfv@ast-mbp>
In-Reply-To: <20190423041503.np4dlso7c6qw3wfv@ast-mbp>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 23 Apr 2019 09:00:28 -0700
Message-ID: <CANn89i+WFCQYxi-efjEBaAHY3rorornJ5dhGgQegBTkgwm1ZOQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/9] net: flow_dissector: trigger BPF hook
 when called from eth_get_headlen
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        simon.horman@netronome.com, Willem de Bruijn <willemb@google.com>,
        Petar Penkov <peterpenkov96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 22, 2019 at 9:15 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:

> Eric and Willem, could you please take a look as well
> and hopefully ack it ?

Sure, I am taking a look.
