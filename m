Return-Path: <SRS0=qrx8=7S=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FC0C433E0
	for <bpf@archiver.kernel.org>; Fri,  5 Jun 2020 15:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F16FC207D3
	for <bpf@archiver.kernel.org>; Fri,  5 Jun 2020 15:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591369922;
	bh=+HPaAI525PJHGvjdaMMkGCM4cBpf6N5tgPI+2/lwbxQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kZnekg6DwAF0kh1bQFjRIXqxibEKTsv8DyW6VCgE238PWB1gETH3su0cvnwwWZ0Q6
	 4nRiL82qcigXVerxDxFvNk1c5CmA8JH6W1NZDGoyeFGoy7i5Qh7OtGn+3j8+BNVNsZ
	 Pod7/wxU8FH30RZY8nvSF3peS+L2S04m7lYxvRP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgFEPMB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 5 Jun 2020 11:12:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgFEPMB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Jun 2020 11:12:01 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6BC9206DB;
        Fri,  5 Jun 2020 15:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591369920;
        bh=+HPaAI525PJHGvjdaMMkGCM4cBpf6N5tgPI+2/lwbxQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZhoWkrDKEAnMvqSVxeLOzD0DCi7MqD3Ir1QQn+S90aPZPpYINpNZMaL3GBdwanT+Q
         4gyLhTltt/LEPtbzJ1xxXA5YE7A0Al4g/xDEPGxfkYafKxrYs7/x9crC9o7pNUTqll
         jZ6I3fVchJIH7YsZ1RYhay8IkhJUeL0/Xb+1O9Vk=
Received: by mail-ot1-f50.google.com with SMTP id g7so6768677oti.13;
        Fri, 05 Jun 2020 08:12:00 -0700 (PDT)
X-Gm-Message-State: AOAM531t8H2qFvVp+a7g0K3gVJKWeDyvcdkGKY5yjv8vKmVhgX1taBH1
        4yUdZhGwlH/i8pSKG2afYt7pPmT/k/NqEzmtvpM=
X-Google-Smtp-Source: ABdhPJyVHb56ERtLdm3+Oh12CLhRj7Ars9dYcQxVvm9ac95ESqfpaxVaIOCPthNZmoJzdfU1Q7Oks7TK9qEwjrIRYYY=
X-Received: by 2002:a9d:2de4:: with SMTP id g91mr7649445otb.90.1591369920122;
 Fri, 05 Jun 2020 08:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
 <20200518190716.751506-6-nivedita@alum.mit.edu> <20200605003134.GA95743@rdna-mbp.dhcp.thefacebook.com>
 <CAMj1kXGaQGaoiCqQpX4mdN6UQi25=EhqiNZn=sbcgi1YYuJwBA@mail.gmail.com>
 <20200605131419.GA560594@rani.riverdale.lan> <20200605133232.GA616374@rani.riverdale.lan>
 <CAMj1kXG936NeN7+Mf42bL-7V5pRVjoNmCKmVT3EcB5EGh2y5fQ@mail.gmail.com> <20200605151037.GA1011855@rani.riverdale.lan>
In-Reply-To: <20200605151037.GA1011855@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 5 Jun 2020 17:11:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHxWjijEgw9a3=t1jmCuONpBeQEBMEEcNoCyz0aOo-1xQ@mail.gmail.com>
Message-ID: <CAMj1kXHxWjijEgw9a3=t1jmCuONpBeQEBMEEcNoCyz0aOo-1xQ@mail.gmail.com>
Subject: Re: [PATCH 05/24] efi/libstub: Optimize for size instead of speed
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Andrey Ignatov <rdna@fb.com>,
        linux-efi <linux-efi@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 5 Jun 2020 at 17:10, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Fri, Jun 05, 2020 at 04:53:59PM +0200, Ard Biesheuvel wrote:
> > I guess the logic that decides whether -maccumulate-outgoing-args is
> > enabled is somewhat opaque.
> >
> > Could we perhaps back out the -Os change for 4.8 and earlier?
>
> I just sent a patch to add the accumulate-outgoing-args option
> explicitly. That fixes 4.8.5 and doesn't seem to affect at least
> gcc-9.3.0, which presumably already enables it automatically.
>

Fair enough.
