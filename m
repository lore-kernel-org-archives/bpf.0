Return-Path: <SRS0=s4C/=BH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15B6C433EA
	for <bpf@archiver.kernel.org>; Tue, 28 Jul 2020 09:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD94C20775
	for <bpf@archiver.kernel.org>; Tue, 28 Jul 2020 09:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cySS2YTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgG1JgF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:36:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54909 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728310AbgG1JgF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jul 2020 05:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595928963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eMM7PXLH24iHxEeDB9QrnPUV5VWaT5NSVjax0bO+Ch8=;
        b=cySS2YTm2jh3QGRNAhnTemcZFKLzTOzXdxZkkpSwFKr1W9n46rboGEGYi+/hS0StbYhNih
        rCZKdiMMmpyXsO54pbrmBVELlO4MwGg6csVfwAHE3BENQ0G4VUksQlz/iMEfNahKxTZJEL
        qngA0swYGlXGrI65Td1QbggzXdBAv4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-vfAOGmL1OOWArdr7_zjvEg-1; Tue, 28 Jul 2020 05:36:00 -0400
X-MC-Unique: vfAOGmL1OOWArdr7_zjvEg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B48781030C20;
        Tue, 28 Jul 2020 09:35:57 +0000 (UTC)
Received: from krava (unknown [10.40.194.74])
        by smtp.corp.redhat.com (Postfix) with SMTP id 057C890E68;
        Tue, 28 Jul 2020 09:35:53 +0000 (UTC)
Date:   Tue, 28 Jul 2020 11:35:53 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Florent Revest <revest@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v8 bpf-next 02/13] tools resolve_btfids: Add support for
 set symbols
Message-ID: <20200728093553.GC1243191@krava>
References: <20200722211223.1055107-1-jolsa@kernel.org>
 <20200722211223.1055107-3-jolsa@kernel.org>
 <CAEf4BzYgnEybzj2_O5FCwO1CgcfBrKoZVR9jFr43KPRqyD_=OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYgnEybzj2_O5FCwO1CgcfBrKoZVR9jFr43KPRqyD_=OQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 27, 2020 at 05:53:01PM -0700, Andrii Nakryiko wrote:
> On Wed, Jul 22, 2020 at 2:13 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > The set symbol does not have the unique number suffix,
> > so we need to give it a special parsing function.
> >
> > This was omitted in the first batch, because there was
> > no set support yet, so it slipped in the testing.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/bpf/resolve_btfids/main.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> > index 6956b6350cad..c28ab0401818 100644
> > --- a/tools/bpf/resolve_btfids/main.c
> > +++ b/tools/bpf/resolve_btfids/main.c
> > @@ -220,6 +220,19 @@ static char *get_id(const char *prefix_end)
> >         return id;
> >  }
> >
> > +static struct btf_id *add_set(struct object *obj, char *name)
> > +{
> > +       char *id;
> > +
> > +       id = strdup(name + sizeof(BTF_SET) + sizeof("__") - 2);
> 
> why strdup? you are not really managing memory carefully anyway,
> letting OS clean everything up, so why bother strduping here?

it copies the get_id logic, where we cut the unique ID part,
but we don't cut the string in here, so no reason for strdup
I'll remove it

> 
> Also if get invalid identifier, you can easily go past the string and
> its ending zero byte. So check strlen first?

right.. it's also missing in get_id funciton, will add

thanks,
jirka

> 
> > +       if (!id) {
> > +               pr_err("FAILED to parse cnt name: %s\n", name);
> > +               return NULL;
> > +       }
> > +
> > +       return btf_id__add(&obj->sets, id, true);
> > +}
> > +

SNIP

