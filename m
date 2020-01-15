Return-Path: <SRS0=xBUo=3E=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4719DC32771
	for <bpf@archiver.kernel.org>; Wed, 15 Jan 2020 20:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2952064C
	for <bpf@archiver.kernel.org>; Wed, 15 Jan 2020 20:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXvNNSN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgAOUVF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:21:05 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44524 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAOUVE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jan 2020 15:21:04 -0500
Received: by mail-qt1-f195.google.com with SMTP id w8so2528452qts.11;
        Wed, 15 Jan 2020 12:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gQDIp0O9QnAxX4WU+TXGscN8NS1YVLXeb9VJm6V5OoY=;
        b=lXvNNSN9x27eKkpEf42K5E/i5sPyZRkW3eo3LqB4FkqRL2DhMZDY/WSoEBtIzsiIFO
         6hTeNRtROe0iU6UQnNsb3TtKEAH1mMcRnHXMLyL97Jbd+QORixgkcbrPsQzGsw+E6G4a
         9S2+ztvLWxDhaAW9qLhFHdkT10B8r0eqytUvsi1g0rAGTqXJK5NkmMnMcW+Jii3vrKhO
         QQoRSyT9nKrjDX8A/nLJ9V6K5K3GaGSANPXsfn2cVCR+qxVOBPDq0ryBazMq/JbgFueH
         mHF6bEYqdyfW5gSH385AJ//uXNwc192o4gekyY38rOcPNZRRpQy0XJOSxA3Vx0AdLWCD
         1f2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gQDIp0O9QnAxX4WU+TXGscN8NS1YVLXeb9VJm6V5OoY=;
        b=P3YuTSfG4YvtFJxf2O7zi3zcjvEk4rxY8GC/0vZsMfqMjAyJOtl3O+3NvkaKIfrk9n
         kYJ+DtcfEs5cVQ0nxqpU7wgEO1r1g0qmXtxMs9jAoqtbpp70GWZp+ZKJwZUxkzWSWUny
         JdBq4cAWbt+LbRoaKlFwRcJA1SaV8zpctT8f5hlabxQHk3auMiX0NPihSkRJBtUdvSNx
         a2/22KlxdP9lXPv296Vjbe8mdCAa4sOcOjnusHe9o3bAAQBuLJfQLCBC6R20yfo67ZS/
         3f4ryh+M4riAtXql7alZW1h8SJpXXm5UNh1Da/qVxWRW+oQnCNio9jY5k5S159frSimg
         O4nA==
X-Gm-Message-State: APjAAAWfEf/AJG6GHR42QR/sseAQl3suvh0KxO0JdFRaJT6usJUGFjgy
        gubfTmEILb21nkX5EBgjKfsBeJZRWoFPD8tu3Mw=
X-Google-Smtp-Source: APXvYqxUasebTmpN/r6CnD4d6Jf+zUxCLRbdtypRZ2A9uy6ktTsnq+Z2WBqBWo3XYSTfOFxSuYL1Ydf+yDse6G5xqBI=
X-Received: by 2002:ac8:4050:: with SMTP id j16mr367798qtl.171.1579119663256;
 Wed, 15 Jan 2020 12:21:03 -0800 (PST)
MIME-Version: 1.0
References: <20200115184308.162644-1-brianvv@google.com> <20200115184308.162644-8-brianvv@google.com>
In-Reply-To: <20200115184308.162644-8-brianvv@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 15 Jan 2020 12:20:52 -0800
Message-ID: <CAEf4BzYR2cNC_O6c8Fu4HtAny-XJaGafpDCMGhuj4-ubQ14vRw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 7/9] libbpf: add libbpf support to batch ops
To:     Brian Vazquez <brianvv@google.com>
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

On Wed, Jan 15, 2020 at 10:43 AM Brian Vazquez <brianvv@google.com> wrote:
>
> From: Yonghong Song <yhs@fb.com>
>
> Added four libbpf API functions to support map batch operations:
>   . int bpf_map_delete_batch( ... )
>   . int bpf_map_lookup_batch( ... )
>   . int bpf_map_lookup_and_delete_batch( ... )
>   . int bpf_map_update_batch( ... )
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/lib/bpf/bpf.c      | 58 ++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/bpf.h      | 22 +++++++++++++++
>  tools/lib/bpf/libbpf.map |  4 +++
>  3 files changed, 84 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 500afe478e94a..317727d612149 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -452,6 +452,64 @@ int bpf_map_freeze(int fd)
>         return sys_bpf(BPF_MAP_FREEZE, &attr, sizeof(attr));
>  }
>
> +static int bpf_map_batch_common(int cmd, int fd, void  *in_batch,
> +                               void *out_batch, void *keys, void *values,
> +                               __u32 *count,
> +                               const struct bpf_map_batch_opts *opts)
> +{
> +       union bpf_attr attr = {};


this is not a big issue and I don't want to delay landing your
patches, so maybe you can follow up with another patch. But this '=
{}' part is a complete waste because you do memset below.

> +       int ret;
> +
> +       if (!OPTS_VALID(opts, bpf_map_batch_opts))
> +               return -EINVAL;
> +
> +       memset(&attr, 0, sizeof(attr));
> +       attr.batch.map_fd = fd;
> +       attr.batch.in_batch = ptr_to_u64(in_batch);
> +       attr.batch.out_batch = ptr_to_u64(out_batch);
> +       attr.batch.keys = ptr_to_u64(keys);
> +       attr.batch.values = ptr_to_u64(values);
> +       attr.batch.count = *count;
> +       attr.batch.elem_flags  = OPTS_GET(opts, elem_flags, 0);
> +       attr.batch.flags = OPTS_GET(opts, flags, 0);
> +
> +       ret = sys_bpf(cmd, &attr, sizeof(attr));
> +       *count = attr.batch.count;
> +
> +       return ret;
> +}
> +

[...]
