Return-Path: <SRS0=sz96=2B=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8178CC43603
	for <bpf@archiver.kernel.org>; Wed, 11 Dec 2019 13:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552422464B
	for <bpf@archiver.kernel.org>; Wed, 11 Dec 2019 13:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dE92+E8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfLKNUU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:20:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42736 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727477AbfLKNUT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 11 Dec 2019 08:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576070419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o/u/4ZEqQP0e+uS2+lCszxa5LZBpaQoPz1LVNN7voyg=;
        b=dE92+E8Keo6YqSkUKbQr++CMuiQIjplKbMtXwxLR0fWUD8bB7y+amC3EK6XdBZG3b2yX/K
        lp0cS0lQKTzj4978xYr3d/J15PIhdqDY8iDFyGL5vD2ZYDQDEFAgKHOIPeHZCagY9KIbYS
        SX6HWPIMMFf0vzb0yKQw2XPkUbdr/UM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-034krEu5Niubrm2mscgNhA-1; Wed, 11 Dec 2019 08:20:15 -0500
Received: by mail-lf1-f70.google.com with SMTP id x23so5029387lfc.5
        for <bpf@vger.kernel.org>; Wed, 11 Dec 2019 05:20:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=o/u/4ZEqQP0e+uS2+lCszxa5LZBpaQoPz1LVNN7voyg=;
        b=I7tkE5Il/Jc/lAMM0fwmoK3OVanDbYSMmsq0rbhrWCRHOi5F0gfAxgw3CHWDz7Euls
         9oAF8dKdUJ9P6MLVOlp4Jpror71S2wwfihGYg7U4KqSEmyRTWyryNxVIr6IjSsdP/yxw
         sr+zi2r/UAAiYFENicjOvuwfHIrClAN9fVL4DRwy8F70tlF1AaRCYSqfdWhHGxXjYaLY
         TsyPIYjTQu4xnIaBUMUTuAqgkKXFnulMoZ3lEc84lmbNNpiTsv9/t8JowkCA4yDbTx3B
         UHmk+P0A0n20szJLf0oWJQoJ6EyDr5hymHHyRjkrG7ejF3pIuD9VJJCDdvVuHGHQKw66
         sfEg==
X-Gm-Message-State: APjAAAVT5+MmOJgfvqq6Rovj8xu7WnGGVch8eUkZbq66Q8eaRip7n4g3
        R3jlCVkHGhjKhGewPiXx+kKCfDis9R9VbK4SsATEMCW/uVSk/ve74Rd5ZGq+zChg53OeKa15csT
        47im+vM5fCits
X-Received: by 2002:a2e:9b95:: with SMTP id z21mr1806011lji.112.1576070414502;
        Wed, 11 Dec 2019 05:20:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqxiBoj4+UzNM6MVzGlRn15zbpyF65rItNLpqEE+jZ6WQC2/2JVmPf9if2K7dMUlgg9zx4M+KA==
X-Received: by 2002:a2e:9b95:: with SMTP id z21mr1805990lji.112.1576070414253;
        Wed, 11 Dec 2019 05:20:14 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id c12sm1157656lfp.58.2019.12.11.05.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 05:20:13 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 64AA318033F; Wed, 11 Dec 2019 14:20:11 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin Lau <kafai@fb.com>
Subject: Re: [PATCH bpf v2] bpftool: Don't crash on missing jited insns or ksyms
In-Reply-To: <20191211130857.GB23383@linux.fritz.box>
References: <20191210181412.151226-1-toke@redhat.com> <20191210125457.13f7821a@cakuba.netronome.com> <87eexbhopo.fsf@toke.dk> <20191211130857.GB23383@linux.fritz.box>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 11 Dec 2019 14:20:11 +0100
Message-ID: <87zhfzf184.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 034krEu5Niubrm2mscgNhA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On Tue, Dec 10, 2019 at 10:09:55PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
> [...]
>> Anyhow, I don't suppose it'll hurt to have the Fixes: tag(s) in there;
>> does Patchwork pick these up (or can you guys do that when you apply
>> this?), or should I resend?
>
> Fixes tags should /always/ be present if possible, since they help to pro=
vide
> more context even if the buggy commit was in bpf-next, for example.

ACK, will do. Thank you for picking them up for this patch (did you do
that manually, or is this part of your scripts?)

-Toke

