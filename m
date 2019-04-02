Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A646C4360F
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 20:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B3D2070D
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 20:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyhGtGGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbfDBUSH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:18:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45747 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfDBUSG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Apr 2019 16:18:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id m16so12795049edd.12;
        Tue, 02 Apr 2019 13:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xMLPbJ0YQpMk1XM/DcsAsNlvaxdVfjchNh6/2ffq22w=;
        b=QyhGtGGQ8FJMKgezzCaMxxv4GJfAW4NoWGNFii5KpVU9xlrRtvzwO5OGVrw/EewZlb
         i0JtudoLA2ZbJUBKm9OBJuHotl/Qx3sWRjhhgsKC0Sd6BbXP4Qn1vZm5XTLeFeRHEcqk
         /y6YtkALYuKwwMaFsEUF2d8SudEfJ9ZDO0CzJUwyOQTIalbU6XirlFlJxFnIGS77ZUpU
         PYVI/HIbDzZ0yaxfEOSMbe7ave1qpNEa0ezko08+ud9Yq5WnD2TwuNPqigzKQX8l3aBg
         5azQpTONjJfWBn8HKHRh6eGWeXhaaz8rOBZrgTCWD4mf+cCXveYPyV8mv4W/61VbGy/2
         meHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xMLPbJ0YQpMk1XM/DcsAsNlvaxdVfjchNh6/2ffq22w=;
        b=dHMqwcqtQYBy9JxS3RVS/S+Q7uLVPee2xBaS8XdCZzalUP/smN3DMS8Jg461lktBjE
         LqtkhoFHk8F+9Eha5arW82I7/5J6ZDQNx4nupuf4xQm0SlmrL0sZBloDPwvUB66aAVqK
         oUr/FyYTDOhF8CTBZ0i3Zgk4mJ1Jlcf3iBVzhXuHjtJrvv34RvheBwLpquohhFl8+YLO
         b9B994ZMZwtJuMPJo4hDx3diS6mQo6sgRftIiFbaaMogYxNMpQPnK4XB3ZegGHEeB2Tf
         uXQxfbpWkLXciVdXwBgls3t83d14wTdUnJma2QlwCecigCN21vtCVkbFspFH2FiYl/SJ
         vMNw==
X-Gm-Message-State: APjAAAVGo4D00UpRJcrPuBUwa8XS3NXuUvCOZVNqaZQq20ShHYLNBlaH
        MmZJqD3nKlmps6XFTRXuZbXkCDKZhbSAhCGcVtI=
X-Google-Smtp-Source: APXvYqyb5UZxv+fkeUd75A0boKHHYk0oLzLbxPK5/pad8f5x8CiTTssffWJ3IIeFLKNQ9OhvpCghVhIFsSKbF6QSncg=
X-Received: by 2002:aa7:d6cb:: with SMTP id x11mr25688506edr.85.1554236284475;
 Tue, 02 Apr 2019 13:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190401205734.4400-1-sdf@google.com>
In-Reply-To: <20190401205734.4400-1-sdf@google.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 2 Apr 2019 16:17:28 -0400
Message-ID: <CAF=yD-JOZuJ4cg30Gcx-RU2KHZ5iy6gJ=okhVbcNybRkqRY+dw@mail.gmail.com>
Subject: Re: [PATCH bpf 0/5] flow_dissector: lay groundwork for calling BPF
 hook from eth_get_headlen
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Simon Horman <simon.horman@netronome.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <peterpenkov96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 1, 2019 at 4:57 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> This patch series fixes the existing BPF flow dissector API to
> support calling BPF progs from the eth_get_headlen context (the support
> itself will be added in bpf-next tree).
>
> The summary of the changes:
>   * fix VLAN handling in bpf_flow.c, we don't need to peek back and look
>     at skb->vlan_present; add selftests
>   * pass and use flow_keys->n_proto instead of skb->protocol
>   * fix clamping of flow_keys->nhoff for packets with nhoff > 0
>   * prohibit access to most of the __sk_buff fields from BPF flow
>     dissector progs; only data/data_end/flow_keys are allowed (all input
>     is now passed via flow_keys)
>   * finally, document BPF flow dissector program environment
>
> Stanislav Fomichev (5):
>   selftests/bpf: fix vlan handling in flow dissector program
>   net/flow_dissector: pass flow_keys->n_proto to BPF programs
>   flow_dissector: fix clamping of BPF flow_keys for non-zero nhoff
>   flow_dissector: allow access only to a subset of __sk_buff fields
>   flow_dissector: document BPF flow dissector environment

For the series:

Acked-by: Willem de Bruijn <willemb@google.com>

This looks great to me. Thanks, Stan!

>
>  .../networking/bpf_flow_dissector.txt         | 115 ++++++++++++++++++
>  net/core/filter.c                             |  16 +--
>  net/core/flow_dissector.c                     |   4 +-
>  .../selftests/bpf/prog_tests/flow_dissector.c |  68 +++++++++++
>  tools/testing/selftests/bpf/progs/bpf_flow.c  |  19 ++-
>  5 files changed, 196 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/networking/bpf_flow_dissector.txt
>
> --
> 2.21.0.392.gf8f6787159e-goog
