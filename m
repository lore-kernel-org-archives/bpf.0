Return-Path: <SRS0=73LO=5Z=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57984C2BA19
	for <bpf@archiver.kernel.org>; Thu,  9 Apr 2020 18:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE512082D
	for <bpf@archiver.kernel.org>; Thu,  9 Apr 2020 18:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bn8RsmLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgDISvJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:51:09 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:42845 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgDISvJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Apr 2020 14:51:09 -0400
Received: by mail-qv1-f66.google.com with SMTP id ca9so6042975qvb.9;
        Thu, 09 Apr 2020 11:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AqENxf3+55rAQuua54i17o4PFt9hrYgalmZkC5wlfUs=;
        b=bn8RsmLF4XGgytaVnSs76AJlmP1BVlgfRHK9atmcvUpCfiEXsTZRRj7NM9l7ukgZKF
         7nb9298W8cu9KfvOimwD88bE1XNpkrmGw3lREXCOPQu+5y3qKe5pFW79L/s69KezRT3d
         VGtyYNFOW2X5uFI+c5zes6TJtTPQpodtSQCX5mDIDRwZ9Ji6WP6wXAIumXMSCMKkSbaG
         Ox+/g0qsTtYaTPubHKnanCXCvaj2U/YCdSl1TPjaX0Ydj+zuiVwYNDvdf8BJU6XN7GdJ
         cUViRN8LKR170/NzsI6NI5EQVuZsbPjSsv/HW7F+HQ9/ULpJKeSDNp6vJNUgpjJFtIWT
         RyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AqENxf3+55rAQuua54i17o4PFt9hrYgalmZkC5wlfUs=;
        b=NlRpSqKbw5TTox5zbYwOJSZfurmUfzjP+nSbLKp3WQi+blmaKpRGRvrHM/5YBC2FxO
         yqHK+DqCaPPluQAue9huxX/R0sUoRpA07xCA5TtoiSJSBUBbBZekXqRjjHplfSq8eiqC
         rQbdbP/SdhKN6uJxGyjLh083sEtnRuHj7bZLJ1VgA24sAaGOs9KUTKuzKN89mQzbPAQO
         RR0Cv3GsSG4UI4CaFsxIopRpwnVivecGsnh2hhoheR0dc5GvzQ5P3OlkQpILyNIGXTKm
         ZxuhoQapijBPzwpaoVHCVZHQBV8vTh554kq3Gd1toFKp0wuChhMr411633ERcMsD5pae
         i4Vg==
X-Gm-Message-State: AGi0Puaja/77DBBUr0seewVl0PjbsIyIBlNzXsANKPQicoWNyf/76OPi
        oZ5VqdEnNR8AdtVQwnDl9LRISGxGD6lz4x9DH2U=
X-Google-Smtp-Source: APiQypJXTUjQLLZducJxiiGIDeKKTfVw4mS8veSceY8vMr83LnB2TD1qTo0ikK5ckl7oEYtPEdtTBEoJWEiN5I+ID2o=
X-Received: by 2002:a05:6214:6a6:: with SMTP id s6mr1468288qvz.247.1586458268467;
 Thu, 09 Apr 2020 11:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200404000948.3980903-1-andriin@fb.com> <20200404000948.3980903-9-andriin@fb.com>
 <1dbaaf27-af89-f6d5-bb09-8e1b967c9582@gmail.com>
In-Reply-To: <1dbaaf27-af89-f6d5-bb09-8e1b967c9582@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 9 Apr 2020 11:50:57 -0700
Message-ID: <CAEf4Bzb5WS1xwk+JZZX01ktAyT=KPpfgNtNdyrtDeNzK5Kzkjg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 8/8] bpftool: add bpf_link show and pin support
To:     David Ahern <dsahern@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 8, 2020 at 4:44 PM David Ahern <dsahern@gmail.com> wrote:
>
> On 4/3/20 6:09 PM, Andrii Nakryiko wrote:
> > diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> > index 466c269eabdd..4b2f74941625 100644
> > --- a/tools/bpf/bpftool/main.c
> > +++ b/tools/bpf/bpftool/main.c
> > @@ -30,6 +30,7 @@ bool verifier_logs;
> >  bool relaxed_maps;
> >  struct pinned_obj_table prog_table;
> >  struct pinned_obj_table map_table;
> > +struct pinned_obj_table link_table;
> >
> >  static void __noreturn clean_and_exit(int i)
> >  {
> > @@ -215,6 +216,7 @@ static const struct cmd cmds[] = {
> >       { "batch",      do_batch },
> >       { "prog",       do_prog },
> >       { "map",        do_map },
> > +     { "link",       do_link },
> >       { "cgroup",     do_cgroup },
> >       { "perf",       do_perf },
> >       { "net",        do_net },
>
> you need to add 'link' to the OBJECT list in do_help.

Yeah, and bash completions and a bunch of other stuff. Bpftool support
is far from being polished.
