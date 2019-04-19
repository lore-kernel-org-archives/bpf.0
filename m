Return-Path: <SRS0=ErZJ=SV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B913C282E0
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 23:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCC32171F
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 23:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMIL9WG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbfDSX3F (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 19 Apr 2019 19:29:05 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41800 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfDSX3F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Apr 2019 19:29:05 -0400
Received: by mail-lf1-f65.google.com with SMTP id t30so4966494lfd.8;
        Fri, 19 Apr 2019 16:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t54IZXW6FX7Vmvdhi2o3PAmy19tW/3jG94t5kif9Ltg=;
        b=JMIL9WG+X5yPRmljJKOqMjWjGS5bLvoQiGrtJ0YjKexsGVUMk0IMaA6JOzqKZwX61X
         H8UI3hKRfVjbq0c8VYxpSrNCY/YP01Hcsvs5IBu6Zs+q29OgnbValGTMRUmzGjP2b+Sw
         /dwfXVa9KEXDY2tzyXFp3om+s1nIZ9yfkauEO5WCMIc7W8XYMTLR6kGTggvZ4oqVx2JX
         sB3zasZLrYkwH8HTFCDGrO22verWJkSx9pwII7KwhbfadCsE1K5VF+o3du/ArEORKe0p
         PU6fQ9520F6RupykqfaaqEGcFqnobnEnd2GK4IybfzPNcv7BnHE11RilVZfKFR4fy3PX
         8AUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t54IZXW6FX7Vmvdhi2o3PAmy19tW/3jG94t5kif9Ltg=;
        b=PhRhoWXF2gxvoIp32EV8pKP0ZtFUvokv8OQmBmYTl3aa2CUWua+xd095iwZ98Wf7DD
         dM0M/thHDhNOrztcIDEQ3V2Y5xQchNtW5je911iq67HGscoYCwWIXd/mZihhFdtAMPA7
         rJvI9VJUFFAo73zXVwRA9m9479uTCe16DJXHEEUdgcSzCT9cs6yuNIMTpqzkzb6Q2szI
         axQZF/uj6cYP/o8kKTnLWgKag5UBvEM7wVBsB463LDA3AdZUzUNFwYN9OGREFghbYCXZ
         kL9dplUOwXVKk60sLtB6LEFqm0SOCU337OLYKMdl54Mp4GGMSzdyOKemyPSSEzrOWGRM
         pz6w==
X-Gm-Message-State: APjAAAV5m1G4X94cO86/sZKHC74khnXT7unPp13yyW4kUYswO/PX4QKE
        a4x/2xhwfPAN4S1duNQRsZbp/p7visrOa5kHQXiDqg==
X-Google-Smtp-Source: APXvYqygXPWJ0DIUWQuGLa9lrdbh2oKoYmP7p6nei/5YbRCvhKABKn9twh6yEGFWwdtSHTHdtch7QunF71IoNfeayU0=
X-Received: by 2002:ac2:52a8:: with SMTP id r8mr3560163lfm.160.1555716543429;
 Fri, 19 Apr 2019 16:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
 <1555349185-12508-3-git-send-email-jiong.wang@netronome.com>
 <20190418235747.jv4yocuf6fgwahli@ast-mbp.dhcp.thefacebook.com>
 <20190419134051.71eeea08@cakuba.netronome.com> <20190419211403.6iovh26bu6cg2x36@ast-mbp.dhcp.thefacebook.com>
 <20190419143310.6c749160@cakuba.netronome.com> <20190419214121.2rbmmms6qozmiuke@ast-mbp.dhcp.thefacebook.com>
 <ly8sw5bmpi.fsf@netronome.com>
In-Reply-To: <ly8sw5bmpi.fsf@netronome.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 19 Apr 2019 16:28:51 -0700
Message-ID: <CAADnVQJWqUy6==Kg_3t37-J5JFjmfRH-Fc85yz52mkgLnM2jxw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 02/15] bpf: mark lo32 writes that should be
 zero extended into hi32
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        oss-drivers@netronome.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 19, 2019 at 4:27 PM Jiong Wang <jiong.wang@netronome.com> wrote:
>
> OK, will split REG_LIVE_READ into REG_LIVE_READ64 and REG_LIVE_READ32, and
> will let the prior override the latter early inside mark_reg_read. I feel
> renaming parameter for propagate_liveness (the "parent" etc) could be a
> following up patch? Let me know if you want it included in this set.

of course. renaming should be separate.
