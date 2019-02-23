Return-Path: <SRS0=Kw1S=Q6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE344C43381
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 04:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703522084F
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 04:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0IYNu33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfBWERz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Feb 2019 23:17:55 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34124 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBWERy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Feb 2019 23:17:54 -0500
Received: by mail-oi1-f195.google.com with SMTP id g16so3414289oib.1;
        Fri, 22 Feb 2019 20:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fRrz7WhgZc9YVhlSYU+Q4jmFicuC/jB3kpRuv61ouzw=;
        b=K0IYNu334rhRJw5ugMJPrKW3WseLBoBAHJNKS3L4KHFo3agS+FMfVKnnljVv7CgeXQ
         jtFmJJuuNA59kAQ3NO8X6/JDh6YDc7KEvC1+3aYNPAGZEcfULd9+11RWAyByZRWWzHAc
         OGyypfiZg/w0S0qrbM6sMhivPd8hjO2w6csqRIkZmidTOGGS6aCkwpn3GENE68je2lW3
         +NkShBzlvFvvf+VaTqTgE+2TIFuyfmtw3dVjhA2b82FF2oC4EJA3Dy70aF3jiIjBhyjU
         JCB+FQ9XsDRgVwsumhFUo1wgMEwVre4j0noFzDDKY1D1fLS/g0iSNPJzggX9PB9780JI
         de7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fRrz7WhgZc9YVhlSYU+Q4jmFicuC/jB3kpRuv61ouzw=;
        b=SqgKyjsl9ewFEhlN+Gl8E34uFO1N6cRk5zKyrPjgSzW6zaV48QkUhppxt6a+teNI+N
         v1LBX3jq6YkjRyELlie8+BQ2h+9eJ+lZsxXNdxFmMz/tL9pkMlpO/xKDY9EK9hlectbB
         en8kgT/ERLzx9IqbYfSz5uxDF4QoIwI0qHfbw+anXNvviiTDL10iVWeER13sKVZZru2i
         yPA+1jESZq/x17sHbTV9gkjlbgUX/vPyPICq5+vXfOI/P9OFHbRWORSpEUjYXM9qgSxW
         o5anKwuVUNsZGR56XMweD9fDHKjFMyd05L/NNN6HwvQRnZw51BWOCZTujLeLY+Ya0sry
         MPeA==
X-Gm-Message-State: AHQUAuZPOOVQuV3WmhzlRONApADn+1Y/txlnF3BctZ+JrLhzfzjIdtqr
        8VtTW4yEfd1kqa9ix5aunvXv140iYp9UuxTceLU=
X-Google-Smtp-Source: AHgI3IZ7GTKtV6tocU6TIF7QXEWiQW4BbtnTvqAVoNkAsJNi5UFHfF3ICE2ev0oLS5SXhN3NsYLsMHcCanrrAF2FP7I=
X-Received: by 2002:aca:3ed4:: with SMTP id l203mr89881oia.88.1550895473029;
 Fri, 22 Feb 2019 20:17:53 -0800 (PST)
MIME-Version: 1.0
References: <20190222233644.1487087-1-ast@kernel.org> <20190222233644.1487087-5-ast@kernel.org>
In-Reply-To: <20190222233644.1487087-5-ast@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 22 Feb 2019 20:17:40 -0800
Message-ID: <CAEf4BzbO-RcpvZZf1=dEbY_Tb4yo7hFUrE=sHPPZzC-d0GnO6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] tools/bpftool: recognize bpf_prog_info
 runtime and runcnt
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     davem@davemloft.net, Daniel Borkmann <daniel@iogearbox.net>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 22, 2019 at 3:37 PM Alexei Starovoitov <ast@kernel.org> wrote:
>
> $ bpftool p s
> 1: kprobe  tag a56587d488d216c9  gpl runtime 79786 runcnt 8
>         loaded_at 2019-02-22T12:22:51-0800  uid 0
>         xlated 352B  not jited  memlock 4096B
>
> $ bpftool --json --pretty p s
> [{
>         "id": 1,
>         "type": "kprobe",
>         "tag": "a56587d488d216c9",
>         "gpl_compatible": true,
>         "runtime": 79786,
>         "runcnt": 8,
>         "loaded_at": 1550866971,
>         "uid": 0,
>         "bytes_xlated": 352,
>         "jited": false,
>         "bytes_memlock": 4096
>     }
> ]
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/bpf/bpftool/Documentation/bpftool-prog.rst | 4 +++-
>  tools/bpf/bpftool/prog.c                         | 7 +++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> index 12bc1e2d4b46..102b180d3add 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> @@ -171,7 +171,7 @@ EXAMPLES
>
>  ::
>
> -    10: xdp  name some_prog  tag 005a3d2123620c8b  gpl
> +    10: xdp  name some_prog  tag 005a3d2123620c8b  gpl runtime 81632 runcnt 10
>              loaded_at 2017-09-29T20:11:00+0000  uid 0
>              xlated 528B  jited 370B  memlock 4096B  map_ids 10
>
> @@ -184,6 +184,8 @@ EXAMPLES
>              "type": "xdp",
>              "tag": "005a3d2123620c8b",
>              "gpl_compatible": true,
> +            "runtime": 81632,
> +            "runcnt": 10,

Should these fields be called "run_time" and "run_cnt" for consistency
with other fields? I'd even suggest "run_time_ns" so that there is no
question about time units.

>              "loaded_at": 1506715860,
>              "uid": 0,
>              "bytes_xlated": 528,
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index db978c8d76a8..8065ba11b9d5 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -214,6 +214,10 @@ static void print_prog_json(struct bpf_prog_info *info, int fd)
>                      info->tag[4], info->tag[5], info->tag[6], info->tag[7]);
>
>         jsonw_bool_field(json_wtr, "gpl_compatible", info->gpl_compatible);
> +       if (info->runtime) {
> +               jsonw_uint_field(json_wtr, "runtime", info->runtime);
> +               jsonw_uint_field(json_wtr, "runcnt", info->runcnt);
> +       }
>
>         print_dev_json(info->ifindex, info->netns_dev, info->netns_ino);
>
> @@ -277,6 +281,9 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
>         fprint_hex(stdout, info->tag, BPF_TAG_SIZE, "");
>         print_dev_plain(info->ifindex, info->netns_dev, info->netns_ino);
>         printf("%s", info->gpl_compatible ? "  gpl" : "");
> +       if (info->runtime)
> +               printf(" runtime %lld runcnt %lld",
> +                      info->runtime, info->runcnt);
>         printf("\n");
>
>         if (info->load_time) {
> --
> 2.20.0
>
