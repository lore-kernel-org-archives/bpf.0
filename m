Return-Path: <SRS0=A/va=RL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF68C43381
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 19:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C457A206DF
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 19:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5x5K7PZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfCHTm1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:42:27 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34266 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfCHTm1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Mar 2019 14:42:27 -0500
Received: by mail-ot1-f65.google.com with SMTP id 98so18396844oty.1;
        Fri, 08 Mar 2019 11:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Akar6VYy2ofGYetYqTfHmysGU8aDE88e1GVR6Bx+XJ8=;
        b=O5x5K7PZxEN9FVMzI2eJk23OLC6g74AoAnGaqHNPWk0OqvnSvs5I7ZSH5tspZqEQsA
         D3s12vj3OIzfy6Ou7thn/a7fueB5jqtLp8BVDcpR+uQaJhVmqwD3jvAFNN3W0QFuw2U2
         0ccYzhhcwPdxbvK42ED/YxO6D77bvaZBqpGAbtvDUWZ3dXofWHfE77WK4ocXPlM3ZjcW
         3FHWeMGkTvkMLbE/87MxuERqeDnjKZxKVCDPxpEU5F/2MRJ1CVu3bDRfWf6aRzq/dlCI
         2IOk6/pOZ7XgqQmcOV85ghWCkTwNyK3TbEzDxZUrS2UHaB2Fn8HIVr00sYFwiSQSYgWs
         +TrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Akar6VYy2ofGYetYqTfHmysGU8aDE88e1GVR6Bx+XJ8=;
        b=Dg26lQWHbYhh1S8/PEseA/My4peHtsOeYzICC6UwxRB1iYjeKENagZJn1ZQHwAz0GN
         3G2jGe4q7TPwMNqDv32MOC+legol41SeCfidKhvd4tK+jztEEt4aRV/tnxWTReiIvijA
         SLFKmlWYitaplstmrwxUrcSiDSMhgck/5rkrvWNpGIJwmDopnd9fRZzaaoIjlgo+cgIf
         kaUIkejuOqkoRxMgonUwu3uHIILj0Xqll0q0XT8tHM/BZcCQpXoQzFjlOxtgilvPVH/M
         9gqn0XJWjwqd/zRfoYJlGTuEhlDHZWdknq6Kr3B9/lbsmv5G2vr8MXMRrN8KLJ4xIDaV
         NkZg==
X-Gm-Message-State: APjAAAU+PsWBzgNMtiGwLjmUqXNe6Hqy+5vfudMfdkunWLdteyrtX6dZ
        P+69kDHhtUTuF5xyJRsU42Td8kc9LFQrOyVlu+4=
X-Google-Smtp-Source: APXvYqwLEQ0ZI9/SEA7v2kQiSPWyn3B0hkBPUMhbYf8i3cNYWkhQy27oCMid2MJLrtJhbb+m61eaoMm64NsuVokzR64=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr12597577otk.206.1552074146367;
 Fri, 08 Mar 2019 11:42:26 -0800 (PST)
MIME-Version: 1.0
References: <20190307002321.4071708-1-andriin@fb.com> <20190307140247.GV13100@kernel.org>
 <20190308002637.GF32240@kernel.org> <20190308184517.GI10690@kernel.org>
In-Reply-To: <20190308184517.GI10690@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Mar 2019 11:42:14 -0800
Message-ID: <CAEf4Bzb__EgBCV4HRPTmgY2WwTmq=C+hdG0wDQOOJpZmMeeQ9A@mail.gmail.com>
Subject: Re: [PATCH pahole] pahole: use 32-bit integers for iterations within CU
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, Alexei Starovoitov <ast@fb.com>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        Martin Lau <kafai@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 8, 2019 at 10:45 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Mar 07, 2019 at 09:26:37PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Several looks similar and the low hanging fruit to investigate, seems to
> > be enum bitfields, and the others may as well end up being the same, in
> > miscalculated stats for structs embedded in other structs:
>
> I had little time to further look into this, but from what I've seen the
> good news is that it seems the problem is with the DWARF loader, the BTF
> one producing the right results 8-) I'll take a look at a fix you made
> for packed enums and probably use the same thing on the DWARF loader.

Yeah, I suspected it might be related to base_type__name_to_size()
logic I removed for btf_loader. Ideally we should take the size from
DWARF data itself (assuming it's there) and remove
base_type__name_to_size() and related parts.

>
> - Arnaldo
>
> > $ btfdiff examples/vmlinux-aarch64
> > --- /tmp/btfdiff.dwarf.81KCPb 2019-03-07 18:20:13.153319625 -0300
> > +++ /tmp/btfdiff.btf.g1QkcZ   2019-03-07 18:20:13.928328675 -0300

<snip>
