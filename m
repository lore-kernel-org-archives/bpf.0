Return-Path: <SRS0=789D=TW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8701C072A4
	for <bpf@archiver.kernel.org>; Wed, 22 May 2019 05:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D3721019
	for <bpf@archiver.kernel.org>; Wed, 22 May 2019 05:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Urse73Ij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfEVFyZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 22 May 2019 01:54:25 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42017 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfEVFyY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 May 2019 01:54:24 -0400
Received: by mail-qt1-f193.google.com with SMTP id j53so951395qta.9;
        Tue, 21 May 2019 22:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DqGZmH5U35Dv5bwyTyiCYAuusP/EQsaROTmJmPCQsKs=;
        b=Urse73IjNLmstfQV9wFT1opPjk6RlFiBHx2ITzhNWYfnyisCW9qdKJZfgjMt3r0Fdw
         huo+z7g4nn70opDL0sSFrAr2HcwJUW4VhYuLcaGgaoURYUnpXDP0S3Qygq3b6gGaUmoc
         KG782LvfePPINOb3rYPb69ZTDHbpm1tGjotBM0K3BWHn1LtrUVDtI07xNaDTGedYbE6a
         d1U31GgmW1VbgE/PgLnjahJ7ajI26STRHToREp5YqzatKBXEPjLseN4dpCD+DzZarAPf
         ONAvR8SIoWQlI2cLVkEdZUF/TNXTAnlkYO3XEhFMRBpahCVXl6I0H0V9988dNDcaiWM8
         FUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DqGZmH5U35Dv5bwyTyiCYAuusP/EQsaROTmJmPCQsKs=;
        b=V3reosd8rJeb4zNcQjEDK+WwOm3xqUzLVshiQ66I6KWbYpSB0eSfBa8/KPwzMB0186
         tDEyx7DdhSfP/YPIiFn2/OQoYIyWFMWVggA0EHImNNOJxKYawnWPMtWr6Pb6YHJR0Oqy
         kxSCHYfiGUh0ddhqtqvOTej3Y/Y/XG0pe+duh1Ige632K16+jMPipD8CDd3MnUlFbbaS
         j0IOM8Z8ANJYIU2+cxT7XSX5gduwJVvPWC2lNpR73v72+cXVXes6iIiw56QB5F8C9m92
         HbRhEMmlZYqu485W5c8Lt5HvAWCOZ7KUzsLrigZnL5gbnGALujf5c65jZSlZwXzRlj43
         UjMA==
X-Gm-Message-State: APjAAAUaU4Kzhl5YJlxx5/XlvKP+VN/1pl6TmUB0M5CC4olcVfIP8SNA
        sqY4is6P2hshdJ5KynsLbsGUKPII56LOFh1uy+Q=
X-Google-Smtp-Source: APXvYqwB80FGeP6lOXlASL4MJihH/f7ozAdrki+ynOFPAVXrdBxuOzvhQNpAm6cxrNUWMS9p80pE+iQOsZYDpG3DX7Y=
X-Received: by 2002:ac8:668d:: with SMTP id d13mr71539302qtp.59.1558504463755;
 Tue, 21 May 2019 22:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190522031707.2834254-1-ast@kernel.org>
In-Reply-To: <20190522031707.2834254-1-ast@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 May 2019 22:54:12 -0700
Message-ID: <CAEf4BzbZyTiF8KZBdPS0pxfCHfTEZSjgDLFDywR7yi5=M_86wQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/3] bpf: optimize explored_states
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     davem@davemloft.net, Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 21, 2019 at 8:17 PM Alexei Starovoitov <ast@kernel.org> wrote:
>
> Convert explored_states array into hash table and use simple hash to
> reduce verifier peak memory consumption for programs with bpf2bpf calls.
> More details in patch 3.
>
> v1->v2: fixed Jakub's small nit in patch 1
>
> Alexei Starovoitov (3):
>   bpf: cleanup explored_states
>   bpf: split explored_states
>   bpf: convert explored_states to hash table
>
>  include/linux/bpf_verifier.h |  2 +
>  kernel/bpf/verifier.c        | 77 ++++++++++++++++++++++--------------
>  2 files changed, 50 insertions(+), 29 deletions(-)
>
> --
> 2.20.0
>

For the series:

Acked-by: Andrii Nakryiko <andriin@fb.com>
