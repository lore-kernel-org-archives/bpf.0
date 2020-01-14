Return-Path: <SRS0=Nq9f=3D=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198C6C33C9E
	for <bpf@archiver.kernel.org>; Tue, 14 Jan 2020 18:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5DB2084D
	for <bpf@archiver.kernel.org>; Tue, 14 Jan 2020 18:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sWhN4A1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgANSyG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:54:06 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46660 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbgANSyB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jan 2020 13:54:01 -0500
Received: by mail-qk1-f194.google.com with SMTP id r14so13118189qke.13
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 10:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FR9lhCYEbw12H0zeobUybUOQGm2CoSvzvFRxTVTYgPU=;
        b=sWhN4A1jJF4zgCnuuE5MvnlwpdRSGb5ico9T3aDZ5KVbTDha/ZNXBr4OzGPVv1W4u4
         tPz+4LZCRuC6dGCMw/qdT5wxChox1sGnbGmwwTuiFG3KCWEf+YaHUwD/1PI5a3HlFCeK
         dvl/mvQmsKoIpfv803qf8biN8MP72s0uuFWGQzKc1cIo/52Mi1EhgtZjOSY0IqwtVETi
         Z0HU5wvFqcUxXEaOHTQoqOU9fZis1x2p3ayPvgs4iN8elUrp9k7n8eCn4BpmRnA/z7wb
         0vXLk0ZbZwDBTr4NrkKE83d4lE1ythYkAgjmMIw17D/rAwUOk26JkBQL+c0+czvy79Xw
         1FNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FR9lhCYEbw12H0zeobUybUOQGm2CoSvzvFRxTVTYgPU=;
        b=tAYvBSHV0aDMLaJEXkYikcstPCWxpD2SxJFz8Ro7oLcH7OC0sZSYKccEetR9VL1XQz
         BExSP3twt1tdf45IIGG1fGleVxv6agdACyDqkl/tDEuCmRE7/PyrwH+l6P/tGjC1Db4I
         eearGUGLkC09upxi2Ozr9jQWwj9cdYRK4sTemMPGQYfYDtOlCqPGful4rfq6Qi0NU5v/
         2AqWpC+XOuEvlPVj5PPwQUbrRQkpTPVYe7EfDWdoS9MVawfcSdGZ21mSCVtJN00axpP5
         Bzt4R2/yDb0fRkXa1jj7tV/df2/+15CKONpKLOYKhPLphsIQeR7uAGz6B8uZlgRpPBvr
         hsrw==
X-Gm-Message-State: APjAAAXWvGP1J1E52YxpUWETGuFEE+3mPBlwhk4majYvlaZy2xHQRQAs
        j5euiZWgJTQhVJsfcvBU8mifQL7KsJtcM7FC1tV8UA==
X-Google-Smtp-Source: APXvYqx/CCE+s/Di7ck1wYwWrImCMzsEIMAjT6dwMMAl1rCV2+iOYzwsERCylc5qObPwRLK5zC8zX+ClZqlVCoWu7os=
X-Received: by 2002:a05:620a:997:: with SMTP id x23mr18899493qkx.143.1579028040132;
 Tue, 14 Jan 2020 10:54:00 -0800 (PST)
MIME-Version: 1.0
References: <20200114164614.47029-1-brianvv@google.com> <20200114164614.47029-9-brianvv@google.com>
 <CAEf4BzYEGv-q7p0rK-d94Ng0fyQLuTEvsy1ZSzTdk0xZcyibQA@mail.gmail.com>
In-Reply-To: <CAEf4BzYEGv-q7p0rK-d94Ng0fyQLuTEvsy1ZSzTdk0xZcyibQA@mail.gmail.com>
From:   Brian Vazquez <brianvv@google.com>
Date:   Tue, 14 Jan 2020 10:53:48 -0800
Message-ID: <CAMzD94ScYuQfvx2FLY7RAzgZ8xO-E31L79dGEJH-tNDKJzrmOg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 7/9] libbpf: add libbpf support to batch ops
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Yonghong Song <yhs@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 14, 2020 at 10:36 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jan 14, 2020 at 8:46 AM Brian Vazquez <brianvv@google.com> wrote:
> >
> > From: Yonghong Song <yhs@fb.com>
> >
> > Added four libbpf API functions to support map batch operations:
> >   . int bpf_map_delete_batch( ... )
> >   . int bpf_map_lookup_batch( ... )
> >   . int bpf_map_lookup_and_delete_batch( ... )
> >   . int bpf_map_update_batch( ... )
> >
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
> >  tools/lib/bpf/bpf.c      | 60 ++++++++++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/bpf.h      | 22 +++++++++++++++
> >  tools/lib/bpf/libbpf.map |  4 +++
> >  3 files changed, 86 insertions(+)
> >
> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > index 500afe478e94a..12ce8d275f7dc 100644
> > --- a/tools/lib/bpf/bpf.c
> > +++ b/tools/lib/bpf/bpf.c
> > @@ -452,6 +452,66 @@ int bpf_map_freeze(int fd)
> >         return sys_bpf(BPF_MAP_FREEZE, &attr, sizeof(attr));
> >  }
> >
> > +static int bpf_map_batch_common(int cmd, int fd, void  *in_batch,
> > +                               void *out_batch, void *keys, void *values,
> > +                               __u32 *count,
> > +                               const struct bpf_map_batch_opts *opts)
> > +{
> > +       union bpf_attr attr = {};
> > +       int ret;
> > +
> > +       if (!OPTS_VALID(opts, bpf_map_batch_opts))
> > +               return -EINVAL;
> > +
> > +       memset(&attr, 0, sizeof(attr));
> > +       attr.batch.map_fd = fd;
> > +       attr.batch.in_batch = ptr_to_u64(in_batch);
> > +       attr.batch.out_batch = ptr_to_u64(out_batch);
> > +       attr.batch.keys = ptr_to_u64(keys);
> > +       attr.batch.values = ptr_to_u64(values);
> > +       if (count)
> > +               attr.batch.count = *count;
> > +       attr.batch.elem_flags  = OPTS_GET(opts, elem_flags, 0);
> > +       attr.batch.flags = OPTS_GET(opts, flags, 0);
> > +
> > +       ret = sys_bpf(cmd, &attr, sizeof(attr));
> > +       if (count)
> > +               *count = attr.batch.count;
>
> what if syscall failed, do you still want to assign *count then?

Hi Andrii, thanks for taking a look.

attr.batch.count should report the number of entries correctly
processed before finding and error, an example could be when you
provided a buffer for 3 entries and the map only has 1, ret is going
to be -ENOENT meaning that you traversed the map and you still want to
assign *count.

That being said, the condition 'if (count)' is wrong and I think it
should be removed.

>
> > +
> > +       return ret;
> > +}
> > +
>
> [...]
