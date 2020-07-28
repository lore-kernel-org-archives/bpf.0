Return-Path: <SRS0=s4C/=BH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B705C433DF
	for <bpf@archiver.kernel.org>; Tue, 28 Jul 2020 05:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09317207E8
	for <bpf@archiver.kernel.org>; Tue, 28 Jul 2020 05:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPu4exfP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgG1F6v (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 Jul 2020 01:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgG1F6v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jul 2020 01:58:51 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7573C061794;
        Mon, 27 Jul 2020 22:58:50 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id m9so8637646qvx.5;
        Mon, 27 Jul 2020 22:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ssMryeMJVP9T50kWPf+kILZA0B0gaRxnc+V0vfhJqmE=;
        b=WPu4exfP0hJwJ01RuaoTISqQHtYweUT1uR7yRPh4C0Nvh5Vkb0dumm3C6rWycOzyvq
         B9zfKILgBZQZSnAGvdOmB4tB73zYayjmJbfDixD0aUySMwetn+lDgJl/ANEVo7HrrTF3
         kRoQUSgzkoGgSPn2AKdLz+wUktDQ1Cs0tJrIiWX2baT9J5hfsX7Z3+ECCFdBeC1WvAHV
         X/iqw6Nyje4gHJQzqWsDadOOu6DYRa37WoLPTMHkfSUuUFLDnhlZHgXs9JDWwa3Yptwl
         qXRCcka+zoLyhkwp1Tbos39gjf7XmiWgbQFzWCalZ5HkIA5TK/eL5Mfy44On2Ys+sc8R
         aVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ssMryeMJVP9T50kWPf+kILZA0B0gaRxnc+V0vfhJqmE=;
        b=LiJiNZaGC/vP+YEx5jW07Omjtd7gsuB75fzI3L23Y2mAy1lsz9jDrR5O/MIn0nTAG5
         UrhLFyVv3xuB2DBS+OMMGU7VfC3d4A3YXfC2zAXg16GY/lWL2vSVwmJVIHskny0Uc4dR
         BYWLryo2jMoWKS4hK7KvlcB1llN/VhY4rM3Mk2+fXKNV/z6Lgyk0H37K0C7V0njElRI8
         UwM7KiIAgwSEnll8tBSVaLbYi38CiYgM0PsqpuFwHfLZHVlb7BNhFT33qrPhdpaAQmhr
         VkNmv5YuxplwqE688Gl5r8hhvGuRfYawg8CHH6t/2FJOUWFMno414e0WS7CpvraHWJVI
         K8/g==
X-Gm-Message-State: AOAM5327icRL8qcURc8xz/tkTByUKEj+/Yu4/MvP9+A4kbwuKIMH1d5p
        Xd9L2Scj2twgIsa/hEWRxSA5bYEXTE2Gn1ZRJKw=
X-Google-Smtp-Source: ABdhPJwbTC5eo5pRL/Ir7RRmvDjTFNhJqAk6oxnOY4Z0sDdtyr3P+VAt+d5kMwooF67UrPK3UjvIm3EZzkPqqI5CDFg=
X-Received: by 2002:a0c:9ae2:: with SMTP id k34mr25134238qvf.247.1595915930082;
 Mon, 27 Jul 2020 22:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200727184506.2279656-1-guro@fb.com> <20200727184506.2279656-28-guro@fb.com>
 <CAPhsuW7jWztOVeeiRNBRK4JC_MS41qUSxzEDMywb-6=Don-ndA@mail.gmail.com>
In-Reply-To: <CAPhsuW7jWztOVeeiRNBRK4JC_MS41qUSxzEDMywb-6=Don-ndA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Jul 2020 22:58:39 -0700
Message-ID: <CAEf4BzaOX_gc8F20xrHxiKFxYbwULK130m1A49rnMoT7T74T3Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 27/35] bpf: eliminate rlimit-based memory
 accounting infra for bpf maps
To:     Song Liu <song@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 27, 2020 at 10:47 PM Song Liu <song@kernel.org> wrote:
>
> On Mon, Jul 27, 2020 at 12:26 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > Remove rlimit-based accounting infrastructure code, which is not used
> > anymore.
> >
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> [...]
> >
> >  static void bpf_map_put_uref(struct bpf_map *map)
> > @@ -541,7 +484,7 @@ static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
> >                    "value_size:\t%u\n"
> >                    "max_entries:\t%u\n"
> >                    "map_flags:\t%#x\n"
> > -                  "memlock:\t%llu\n"
> > +                  "memlock:\t%llu\n" /* deprecated */
>
> I am not sure whether we can deprecate this one.. How difficult is it
> to keep this statistics?
>

It's factually correct now, that BPF map doesn't use any memlock memory, no?

This is actually one way to detect whether RLIMIT_MEMLOCK is necessary
or not: create a small map, check if it's fdinfo has memlock: 0 or not
:)

> Thanks,
> Song
