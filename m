Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E454BC43381
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 20:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B093A20657
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 20:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lh0L4Vj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbfCZUWO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:22:14 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45031 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731824AbfCZUWN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 16:22:13 -0400
Received: by mail-oi1-f196.google.com with SMTP id i21so11020577oib.11
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 13:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w92UwdUrtGAw+2OsUwNua324V+pAOOEY+nDOxOJnqo4=;
        b=lh0L4Vj6fyxuDDxGJTkgmCIbn+Uy0dlSprLKcRFsCh6PQKSbMW4g6bk7x3KmOVpSUc
         84Y2ib9q14N/NV48mpPPaIs7LFjTzL/aijObM9qztfmdKMVBbhEVf+/7yz9gu78G4gQK
         PD2dB2gCCkeWHWHSGpOneNE0qfCKdugb8CHXbzHUhzBgnemvldHmwCCr1YNVdo966Nb0
         F5nq9/g+eDW1ByyfDVUXxteYDScV6NtklJE6qa96lGmLwVAz4/LaE4Wb/x/WKRTM/Is+
         HMcRwKKdwSYDYqC9xVVeqfDYkfUzVlbMocwU4jh+prrZlPKUL8pCrBH4SWoWVRfVDXj7
         ghYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w92UwdUrtGAw+2OsUwNua324V+pAOOEY+nDOxOJnqo4=;
        b=FEQ3y5g7ryVeNh2+1Yx4FdRYOe+a8Wkr/06/xxXxUQiPGsiEU6TvMV/8W5P3D7Qbsq
         Me+SupmcWTLZazGAX0jzdkzy2FxpcN0nxx1ICNttf+RfRDjosWrl466C51nIYnY9yr6s
         r2q/4zkFjV4NMgI/JfIcIBUIp+uOPN4QxX7gE9s1l17ey1TJuHnKYP7IoyrxSQG8ZY3P
         40XDDZKeYdtIpPNshqnpDE3UoGdkLrLSYlq4hKmWPdmk/p7/Slv0lMLT8j1huZNfqXcf
         AUeDLf46sdt5f8t5RBhNqwdWPJ1sRnkKCB68zwpVCmFA1p8Rf4kFH3mUdHIzrqQjhnSl
         5j+g==
X-Gm-Message-State: APjAAAXQO+mhfkN8qe6kigudnIWbWVq2q7X/kOXLBMYqUa1NbAg6pFR4
        x0bvDWSFqX2dJuXUtTa/DgNMWsbn01k/o3NCTPfBaT6RAn8=
X-Google-Smtp-Source: APXvYqzmcW/PV3wfStENKmK0w5PgcKtFCww5GXulNa5UKylQuYuy/eKXxlMq/c1tICi5jSHYAQa9PRz6Ex97B/p0aSA=
X-Received: by 2002:aca:3806:: with SMTP id f6mr15864738oia.47.1553631732928;
 Tue, 26 Mar 2019 13:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com> <1553623539-15474-4-git-send-email-jiong.wang@netronome.com>
In-Reply-To: <1553623539-15474-4-git-send-email-jiong.wang@netronome.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 26 Mar 2019 21:21:46 +0100
Message-ID: <CAG48ez0inUUF3wZw5P6o35T3CKQ=CEue1vo-H-dSLDKKo2OHow@mail.gmail.com>
Subject: Re: [PATCH/RFC bpf-next 03/16] bpf: split read liveness into
 REG_LIVE_READ64 and REG_LIVE_READ32
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        oss-drivers@netronome.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 26, 2019 at 7:06 PM Jiong Wang <jiong.wang@netronome.com> wrote:
>
> In previous patch, we have split register arg type for sub-register read,
> but haven't touch read liveness.
>
> This patch further split read liveness into REG_LIVE_READ64 and
> REG_LIVE_READ32. Liveness propagation code are updated accordingly.
>
> After this split, customized actions could be defined when propagating full
> register read (REG_LIVE_READ64) or sub-register read (REG_LIVE_READ32).
>
> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
[...]
> @@ -1374,7 +1374,8 @@ static int check_stack_read(struct bpf_verifier_env *env,
>                         return -EACCES;
>                 }
>                 mark_reg_read(env, &reg_state->stack[spi].spilled_ptr,
> -                             reg_state->stack[spi].spilled_ptr.parent);
> +                             reg_state->stack[spi].spilled_ptr.parent,
> +                             size == BPF_REG_SIZE);

Isn't it possible to use a 4-byte read on the upper half of an 8-byte
stack slot?

>                 if (value_regno >= 0) {
>                         if (zeros == size) {
>                                 /* any size read into register is zero extended,
> @@ -2220,7 +2221,8 @@ static int check_stack_boundary(struct bpf_verifier_env *env, int regno,
>                  * the whole slot to be marked as 'read'
>                  */
>                 mark_reg_read(env, &state->stack[spi].spilled_ptr,
> -                             state->stack[spi].spilled_ptr.parent);
> +                             state->stack[spi].spilled_ptr.parent,
> +                             access_size == BPF_REG_SIZE);

Same thing as above.

>         }
>         return update_stack_depth(env, state, off);
>  }
[...]
