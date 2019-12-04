Return-Path: <SRS0=8K48=Z2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3106C2BD09
	for <bpf@archiver.kernel.org>; Wed,  4 Dec 2019 14:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CFB2084F
	for <bpf@archiver.kernel.org>; Wed,  4 Dec 2019 14:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKSzy92Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfLDODG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 4 Dec 2019 09:03:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29378 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727878AbfLDODF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Dec 2019 09:03:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575468184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zWkdTbQVvximuCMjqLKANJFAHsmDcIS35xetl86u4So=;
        b=gKSzy92ZbxEGXF9h0Svwg8T0eUNgO+KAsx85VLE+E2IHnE91r8nYrwaR2HU/N0BItCcXSD
        3OIJBbSfg5cR4fcsdanrevLrsdWjqRYSznZVeFyuIGAh8pNkgy+tVRrAgil+6DxUS0X9IE
        QkdrwBtAlaUeBWo9bm45EqbiCvV5xxY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-gpEjSK9zMFq7Gh8dlbbk9A-1; Wed, 04 Dec 2019 09:03:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05C111005516;
        Wed,  4 Dec 2019 14:02:59 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FAE4600CC;
        Wed,  4 Dec 2019 14:02:53 +0000 (UTC)
Date:   Wed, 4 Dec 2019 15:02:51 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-audit@redhat.com,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Steve Grubb <sgrubb@redhat.com>,
        David Miller <davem@redhat.com>,
        Eric Paris <eparis@redhat.com>, Jiri Benc <jbenc@redhat.com>
Subject: Re: [RFC] bpf: Emit audit messages upon successful prog load and
 unload
Message-ID: <20191204140251.GA11548@krava>
References: <20191128091633.29275-1-jolsa@kernel.org>
 <CAHC9VhQ7zkXdz1V5hQ8PN68-NnCn56TjKA0wCL6ZjHy9Up8fuQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQ7zkXdz1V5hQ8PN68-NnCn56TjKA0wCL6ZjHy9Up8fuQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: gpEjSK9zMFq7Gh8dlbbk9A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 02, 2019 at 06:00:14PM -0500, Paul Moore wrote:

SNIP

> > +
> > +static void bpf_audit_prog(const struct bpf_prog *prog, enum bpf_audit=
 op)
> > +{
> > +       struct audit_buffer *ab;
> > +
> > +       if (audit_enabled =3D=3D AUDIT_OFF)
> > +               return;
>=20
> I think you would probably also want to check the results of
> audit_dummy_context() here as well, see all the various audit_XXX()
> functions in include/linux/audit.h as an example.  You'll see a
> pattern similar to the following:
>=20
> static inline void audit_foo(...)
> {
>   if (unlikely(!audit_dummy_context()))
>     __audit_foo(...)
> }
>=20
> > +       ab =3D audit_log_start(audit_context(), GFP_ATOMIC, AUDIT_BPF);
> > +       if (unlikely(!ab))
> > +               return;
> > +       audit_log_format(ab, "prog-id=3D%u op=3D%s",
> > +                        prog->aux->id, bpf_audit_str[op]);
>=20
> Is it worth putting some checks in here to make sure that you don't
> blow past the end of the bpf_audit_str array?

forgot answer this one..  there are only 2 callers:

  bpf_audit_prog(prog, BPF_AUDIT_UNLOAD);
  bpf_audit_prog(prog, BPF_AUDIT_LOAD);

that's not going to change any time soon,
so I dont think we don't need such check

jirka

