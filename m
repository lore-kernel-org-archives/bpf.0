Return-Path: <SRS0=zbR4=RA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86097C43381
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 19:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5869A2083D
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 19:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0km0+rw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfBYTYi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:24:38 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43327 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfBYTYi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Feb 2019 14:24:38 -0500
Received: by mail-oi1-f194.google.com with SMTP id i8so8229080oib.10;
        Mon, 25 Feb 2019 11:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GsNAg/8b5zp2oZ08HsTnzdKBT4gtnGkGAOXoednGgGo=;
        b=a0km0+rwvSr+S/FsH2nJQIMU4VFbL+Rb565xyt3ri4HbX9EZlJzzFkDOd68+zXyS/r
         UpGbkXgwRu/80oFGi/d5mNcE9dUqHZLUwXQuyef2Im2rpbicdfuHFnXThxD3EUTFumMp
         uF/df9SxMKh6cbl1YjKIIgB343wxDcpHJhCfwGps/Cwzv8wv/bQaN7y0f1UgU5mb1po7
         sLtuuWCns40r/FcNurE08jCG/CMSB/pp5C2bPGbBc77ll3iH6Ua/3FFd81I46zwsPbkR
         Rf/ZX4dSLS4l8AKIcpU8ZqgRbZpZQvYa8ewypte4F++LOrCaszgzAp4dGTLTQ+7rCquu
         cQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GsNAg/8b5zp2oZ08HsTnzdKBT4gtnGkGAOXoednGgGo=;
        b=ecNslrKDufoEGnfI2EUVPdrfXl9QkVW/JNb4Emu+06TUzFr1BIxOLbpGF3AM8KQe4t
         SEFrXDqpxRhXtmxbKnFVwVsZoRhYr+mD+FxMnLLJC52djSR9GpHHpn0F0c959En85O1T
         ebSY1eh1JWlgyolh+UxGjMQ8+UrPZMHwI/2npbHRdvtQIo8c12PGUGV4ylRpkIASLgGX
         J6hRMBfeNsRbboH9/Ky2lWMagcjiECu7zgOU2pnycnfTJuLQT97bKxiZnrgMtQc4Ucqo
         jiDqOpYZTFsCct9FwUJIp2UDSjtDzVrmt7hk3a73Ua5Zq8yWHjyn2cAwFGurNAT0X7wE
         YHGw==
X-Gm-Message-State: AHQUAubEK6ITXZhlKmCzXEAMrp4n9iHWWF0JLjcPHgnIcSPpqwHKxVF8
        uC8mIrhZP5sql8eax5Fx103HhoQ13som8oGLZtQ=
X-Google-Smtp-Source: AHgI3IZJDiYk0SCG6Rr6zU9KbUvh32ZgSdwPAWUZTgWk1InSQjRkjit5u60LZ8cZ/FGyIthCAw/BOq43KLLuyvhwoOw=
X-Received: by 2002:aca:d6cc:: with SMTP id n195mr12353918oig.27.1551122676656;
 Mon, 25 Feb 2019 11:24:36 -0800 (PST)
MIME-Version: 1.0
References: <20190223174422.663270-1-ast@kernel.org> <20190223174422.663270-5-ast@kernel.org>
 <cf8b7ffc-22f9-a095-7614-2d191ba53522@iogearbox.net>
In-Reply-To: <cf8b7ffc-22f9-a095-7614-2d191ba53522@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Feb 2019 11:24:25 -0800
Message-ID: <CAEf4BzYZ1ML9tncsXVWo1bFSrj1L6vQQKvqHgHANVehGCeBpVA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/4] tools/bpftool: recognize bpf_prog_info
 runtime and runcnt
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net,
        edumazet@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 25, 2019 at 3:17 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 02/23/2019 06:44 PM, Alexei Starovoitov wrote:
> > $ bpftool p s
> > 1: kprobe  tag a56587d488d216c9  gpl runtime 79786 runcnt 8
> >       loaded_at 2019-02-22T12:22:51-0800  uid 0
> >       xlated 352B  not jited  memlock 4096B
> >
> > $ bpftool --json --pretty p s
> > [{
> >         "id": 1,
> >         "type": "kprobe",
> >         "tag": "a56587d488d216c9",
> >         "gpl_compatible": true,
> >         "run_time_ns": 79786,
> >         "run_cnt": 8,
> >         "loaded_at": 1550866971,
> >         "uid": 0,
> >         "bytes_xlated": 352,
> >         "jited": false,
> >         "bytes_memlock": 4096
> >     }
> > ]
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  tools/bpf/bpftool/Documentation/bpftool-prog.rst | 4 +++-
> >  tools/bpf/bpftool/prog.c                         | 7 +++++++
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> > index 12bc1e2d4b46..d8b46a8f17e0 100644
> > --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> > +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> > @@ -171,7 +171,7 @@ EXAMPLES
> >
> >  ::
> >
> > -    10: xdp  name some_prog  tag 005a3d2123620c8b  gpl
> > +    10: xdp  name some_prog  tag 005a3d2123620c8b  gpl runtime 81632 runcnt 10
> >              loaded_at 2017-09-29T20:11:00+0000  uid 0
> >              xlated 528B  jited 370B  memlock 4096B  map_ids 10
> >
> > @@ -184,6 +184,8 @@ EXAMPLES
> >              "type": "xdp",
> >              "tag": "005a3d2123620c8b",
> >              "gpl_compatible": true,
> > +            "run_time_ns": 81632,
> > +            "run_cnt": 10,
> >              "loaded_at": 1506715860,
> >              "uid": 0,
> >              "bytes_xlated": 528,
> > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > index db978c8d76a8..cdb6bd424340 100644
> > --- a/tools/bpf/bpftool/prog.c
> > +++ b/tools/bpf/bpftool/prog.c
> > @@ -214,6 +214,10 @@ static void print_prog_json(struct bpf_prog_info *info, int fd)
> >                    info->tag[4], info->tag[5], info->tag[6], info->tag[7]);
> >
> >       jsonw_bool_field(json_wtr, "gpl_compatible", info->gpl_compatible);
> > +     if (info->runtime) {
> > +             jsonw_uint_field(json_wtr, "run_time_ns", info->runtime);
> > +             jsonw_uint_field(json_wtr, "run_cnt", info->runcnt);
>
> Didn't Andrii mean to generally name these fields run_time_ns and run_cnt, so also
> uapi aside from just changing bpftool output (why keeping these names not the same)?

Yeah, I think consistency is important. This also applies to patch #1
(bpf: enable program stats), which exposes same stats through procfs.
Ideally all those names would be consistent (for obvious reasons). As
for _ns, I realize it's a bit longer and more verbose, but having time
units as part of a name is really great for users and doesn't require
extra documentation (and extra man lookups).


>
> > +     }
> >
> >       print_dev_json(info->ifindex, info->netns_dev, info->netns_ino);
> >
> > @@ -277,6 +281,9 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
> >       fprint_hex(stdout, info->tag, BPF_TAG_SIZE, "");
> >       print_dev_plain(info->ifindex, info->netns_dev, info->netns_ino);
> >       printf("%s", info->gpl_compatible ? "  gpl" : "");
> > +     if (info->runtime)
> > +             printf(" runtime %lld runcnt %lld",
> > +                    info->runtime, info->runcnt);
> >       printf("\n");
> >
> >       if (info->load_time) {
> >
>
