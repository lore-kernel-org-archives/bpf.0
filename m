Return-Path: <SRS0=XC6e=X4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE7CC32792
	for <bpf@archiver.kernel.org>; Thu,  3 Oct 2019 17:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FD120865
	for <bpf@archiver.kernel.org>; Thu,  3 Oct 2019 17:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VP7zgidO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390051AbfJCQVF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:21:05 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36346 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389165AbfJCQVE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Oct 2019 12:21:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id o12so4424924qtf.3;
        Thu, 03 Oct 2019 09:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L8uaoUxkg7xe/1EpnjdT7Xr52hz0DEAO0O+7yKSomuo=;
        b=VP7zgidO4mTP2WiGXYPhczG93UXJFB/690NiH/d4Q0vefu3n3JZc5fqZZ/vuD3XSUS
         InG1p8jBEcRU0jQK4MqyG6mFqfw5bDvbcMhbdU6oQ93Q+DJF4BL7JVzwsiKrYsEdmOCh
         UtBsa4PClL2VzjBKIB66YR0RSD+AgFKvJM29sJbcGzoWfm051nb8I+mVeyDcS8gHE5G9
         oPteSwBTJj6kOjng1uYD6CkgnkW964lseUj9L0YsxcdQdtOsG8HOEzD3THu+cDxjmsrc
         0Silh8ne6/nFi46r8Zx+kJ9PdGmdg205vYkLFVTFkMmEtVX1mlFNsladqt1w6X/ejOGb
         W0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L8uaoUxkg7xe/1EpnjdT7Xr52hz0DEAO0O+7yKSomuo=;
        b=rogp/L8ZDekNrQ7N03zK5/fBtb362kIdMhUnAd2h8iYZycC7Dbw2aPwL0NepWiRGQR
         cJzxVCgG8hUuEHbl7B3k3IVxQN6mahqqpQ4w0p6bQpCng8Zv/mYLE+fepCAR15hqG/ms
         EYY+qGVdzmNdlgS3jyoKE2xMRnH+BqiHXAMuGFJB2sK1jIkiUg5vB3bE2e2JJSPW10oK
         BDsD0SJAXvfsxO8M9RosMKPqddF0gfiQsS+iESCkYpeZyWXvc4d1jpd18yJfxliH64PR
         2QcR3rgNQVRD4iKmzm6RYHbuYC7xGl1ralD8MkIVMlNfD29TCac0gCwg25SL7DbYBHzv
         4XkA==
X-Gm-Message-State: APjAAAXkRnfSL0z11zCS2FKzUlnubjxa2NU6IBzwbyW8EPyLdm7ZYmJC
        eEUmG0Zv+81lS4IgwTfjp1wFgXBIF8E2A0oqKFE=
X-Google-Smtp-Source: APXvYqyMu4evmiurBqWhYUqXevuplcKqbPpPHl46pkiX+b9l36z+KXTl/Vfs6nhZA3hnQkK06kmjCamxBjm136G4J/o=
X-Received: by 2002:ac8:c01:: with SMTP id k1mr10569962qti.59.1570119662929;
 Thu, 03 Oct 2019 09:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191002215041.1083058-1-andriin@fb.com> <20191002215041.1083058-3-andriin@fb.com>
 <87k19mqo1z.fsf@toke.dk>
In-Reply-To: <87k19mqo1z.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 3 Oct 2019 09:20:51 -0700
Message-ID: <CAEf4Bzb7ikPkrxCVMtHK5rS2kdoF_mo5_Bn5U78zKBiYYHS8ig@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/7] selftests/bpf: samples/bpf: split off
 legacy stuff from bpf_helpers.h
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 3, 2019 at 12:35 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Andrii Nakryiko <andriin@fb.com> writes:
>
> > diff --git a/samples/bpf/map_perf_test_kern.c b/samples/bpf/map_perf_te=
st_kern.c
> > index 2b2ffb97018b..f47ee513cb7c 100644
> > --- a/samples/bpf/map_perf_test_kern.c
> > +++ b/samples/bpf/map_perf_test_kern.c
> > @@ -9,25 +9,26 @@
> >  #include <linux/version.h>
> >  #include <uapi/linux/bpf.h>
> >  #include "bpf_helpers.h"
> > +#include "bpf_legacy.h"
> >
> >  #define MAX_ENTRIES 1000
> >  #define MAX_NR_CPUS 1024
> >
> > -struct bpf_map_def SEC("maps") hash_map =3D {
> > +struct bpf_map_def_legacy SEC("maps") hash_map =3D {
> >       .type =3D BPF_MAP_TYPE_HASH,
> >       .key_size =3D sizeof(u32),
> >       .value_size =3D sizeof(long),
> >       .max_entries =3D MAX_ENTRIES,
> >  };
>
> Why switch these when they're not actually using any of the extra fields
> in map_def_legacy?

See below, they have to be uniform-sized.

> >
> > -struct bpf_map_def SEC("maps") lru_hash_map =3D {
> > +struct bpf_map_def_legacy SEC("maps") lru_hash_map =3D {
> >       .type =3D BPF_MAP_TYPE_LRU_HASH,
> >       .key_size =3D sizeof(u32),
> >       .value_size =3D sizeof(long),
> >       .max_entries =3D 10000,
> >  };
> >
> > -struct bpf_map_def SEC("maps") nocommon_lru_hash_map =3D {
> > +struct bpf_map_def_legacy SEC("maps") nocommon_lru_hash_map =3D {
> >       .type =3D BPF_MAP_TYPE_LRU_HASH,
> >       .key_size =3D sizeof(u32),
> >       .value_size =3D sizeof(long),
> > @@ -35,7 +36,7 @@ struct bpf_map_def SEC("maps") nocommon_lru_hash_map =
=3D {
> >       .map_flags =3D BPF_F_NO_COMMON_LRU,
> >  };
> >
> > -struct bpf_map_def SEC("maps") inner_lru_hash_map =3D {
> > +struct bpf_map_def_legacy SEC("maps") inner_lru_hash_map =3D {
> >       .type =3D BPF_MAP_TYPE_LRU_HASH,
> >       .key_size =3D sizeof(u32),
> >       .value_size =3D sizeof(long),
> > @@ -44,20 +45,20 @@ struct bpf_map_def SEC("maps") inner_lru_hash_map =
=3D {
> >       .numa_node =3D 0,
> >  };
>
> Or are you just switching everything because of this one?

Exactly. Another way would be to switch all but this to BTF-based one,
but I didn't want to make this patch set even bigger, we can always do
that later
.
>
>
> -Toke
>
