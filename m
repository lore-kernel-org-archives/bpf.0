Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80C3C10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 17:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1B22173C
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 17:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CghAGj+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfDKRiW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:38:22 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44880 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKRiV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 13:38:21 -0400
Received: by mail-qt1-f196.google.com with SMTP id w5so8028088qtb.11;
        Thu, 11 Apr 2019 10:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dA+qPfCA0i0TLNhmh1YXXPirAFJ3E2sBCR+Qlrj/wbQ=;
        b=CghAGj+lIrH3BGzTONcto1EqWAHRDVwbaumt55vU4v5PAVtAiP2VGtEhm/WTdNJCth
         RGQqkxKoN80I0EO+7jYsttfOXs6Z9pnf2W+/LIQZ1ERX/IPn5g94YPY6tFRwhccNwQk3
         tbiWLkrfanMrK0QJo27uW8YfWTBFsJTHGv+6VUWLz4RDGXprkDiZdcNtxQRe2AYKopQi
         jMIQCyjBhQ/CUHUOg3ZeUOX+e9XmT1LrRKgOhrJCekVOls/dR3onrqxA9U9c7RvOgVDW
         9KcYdgIM8m/5tpOZl2EtpJnKoPQiTXksv1Rk/b8sq4WggQkF8rqZ8II1Lw1xx5X6b+sf
         sJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dA+qPfCA0i0TLNhmh1YXXPirAFJ3E2sBCR+Qlrj/wbQ=;
        b=Gf6/crLMc9/nV7i4UWhJ4j7KNPSXttVxTqz2gI20onWvKEPvgw7bISX8gOvqxiLRmi
         zU3dOvr0ep0Q+bASHuesDr0AHCUJbhTeA6OuojAMPtosv39s/tzGSFSQsdbTLgi1qw0L
         iEOQ8BNnS3eDxcNjVfdkTVGAf3lJ9CQ97rf1wbPcTf0busrv5se/lC1FTDhaopxbsl4Q
         rE0puULAlYDj0N0hKdAImqBaMf4/l74PJg+fxhsXMGJeYngTPQD4rveu62zuNKkWEy0x
         c05l5CfVALgM0qM0smbfIV73sfkCQ7jpSPB4MKec/6u5hmZDAnGF0eyN0Q3uh1klVrYn
         iRiw==
X-Gm-Message-State: APjAAAWidwkwEI4G+iW8o4J5m/a2ojFFr2GAyn7LZ6cRf3GqBdEuEiJS
        vCdPVrYXFCJwamcK7Wgx2PXEvTqJqIxOXclqbs4=
X-Google-Smtp-Source: APXvYqzK5bkYJUjRXRSqd3DIS7xdMg5FNlV/LW5QtdigE+5av0ID1t45vDzvUT9NzyVe5dqiZpOpMKeylwm5S5jfFdc=
X-Received: by 2002:ac8:30a1:: with SMTP id v30mr42863530qta.176.1555004300928;
 Thu, 11 Apr 2019 10:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <155489659290.20826.1108770347511292618.stgit@firesoul>
 <155489661778.20826.7424374812567038804.stgit@firesoul> <CAPhsuW5FQ_npvmCUSfDKUXFj_vXF4OVk34EKqHJXZtu5eYwF2Q@mail.gmail.com>
 <20190411132339.5427313b@carbon>
In-Reply-To: <20190411132339.5427313b@carbon>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 11 Apr 2019 10:38:09 -0700
Message-ID: <CAPhsuW4+XAyFTh56wy0bUWDYZj5wQ997t2gGegwkuhroFtR9og@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: cpumap use ptr_ring_consume_batched
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        bpf <bpf@vger.kernel.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 11, 2019 at 4:23 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> On Wed, 10 Apr 2019 16:24:37 -0700
> Song Liu <liu.song.a23@gmail.com> wrote:
>
> > >                 /* Feedback loop via tracepoint */
> > > -               trace_xdp_cpumap_kthread(rcpu->map_id, processed, drops, sched);
> > > +               trace_xdp_cpumap_kthread(rcpu->map_id, n, drops, sched);
> >
> > btw: can we do the tracepoint after local_bh_enable()?
>
> I would rather not, as my experience is that this result in strange
> inaccurate readings, because (as comment below says) this is a
> CPU-process-reschedule point.  The test tool reads these values and
> calculate PPS.

Thanks for the explanation!

Song

>
> > >
> > >                 local_bh_enable(); /* resched point, may call do_softirq() */
> > >         }
>
> --
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
