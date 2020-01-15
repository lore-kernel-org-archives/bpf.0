Return-Path: <SRS0=xBUo=3E=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA92C33C9E
	for <bpf@archiver.kernel.org>; Wed, 15 Jan 2020 01:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BFF24673
	for <bpf@archiver.kernel.org>; Wed, 15 Jan 2020 01:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkuFIT/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgAOBtN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 14 Jan 2020 20:49:13 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43947 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbgAOBtN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jan 2020 20:49:13 -0500
Received: by mail-qk1-f193.google.com with SMTP id t129so14237004qke.10;
        Tue, 14 Jan 2020 17:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z8iSHwfRwUZLER5GWB5rKc2yuLcmLEIWyDrm9+GXcwg=;
        b=jkuFIT/Etjt7Gvp0C7W8Il8yFRyWHIYrSoUjjGUxlXFPG8YrmiVyK3Wzi4rnmMoccn
         2Fda0neXMSVfjSRaLG+Is7eR9OVxss5iHAeDHulMfEHmjpOGQnSPqVmrRSPuFGhengYV
         wW0+1hjlxfQbsArtOWFxXMigwe1zVkIDqEM9A/jC+nFdPVhJFl7HSIB5jngUFXr3zB7f
         3QSVgZ14qIRK8GdFO75je5FholNoxPh5DxoLEpW0VkSXb4dyjrzoIdKbTqkEIaVCdzjK
         oqwu8sGc5Rpp8kdsMOU4QoxJOb4Z67MJtsuMs4gdTXV9AUc65OR4GvzgDX5bx2A/tuaS
         X/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8iSHwfRwUZLER5GWB5rKc2yuLcmLEIWyDrm9+GXcwg=;
        b=kQpJOV0XXIhnNgBsuHYbZxehiwfiayvGJaS0WVv0ZtJOLXHf2ObCRmgs2K270hLxzi
         DY4CDwtZzBB1OJbNQVkd9whvGYPoAWFKh5wYOsvaEPv1gHv7MA0QGrEuK2iVaBlrBONt
         +poFqCrD6AUT/wHoRK0w73iBWY2F5t8JRzTLaiVeOpZgLlbmHMQFtxBIjWsnF+F0OloL
         PBrtxpLUPbObUD4ddm/oQQbgaOAdNEtwpPEO2Dbg6i7BBgtNCpNOWA371/sKTJgmSso7
         9rCS277k6Jf9ks8ef4IoHmGGyiV/zn+d2io9befGX40HJIY2ZSg/3clDy9wD7JZMezrG
         4l/g==
X-Gm-Message-State: APjAAAUIWHeVzavbhdTOduJi/Od9ZGu7ZvmNyR88a9fj6lYVilO4PvW8
        lPwBjKjoFi8rJOEa9fEEenVrYS8ooUA11i5JjR0=
X-Google-Smtp-Source: APXvYqxBBXDQUbpH6fg0xtadD+DnHdYizSk0Dqlx2ocG/JPy1j5SY3t28O4FynD/Ugh41sHPwxkIL+hxOcIVU904eW0=
X-Received: by 2002:a05:620a:5ae:: with SMTP id q14mr20790478qkq.437.1579052951924;
 Tue, 14 Jan 2020 17:49:11 -0800 (PST)
MIME-Version: 1.0
References: <20200114224358.3027079-1-kafai@fb.com> <20200114224426.3028966-1-kafai@fb.com>
In-Reply-To: <20200114224426.3028966-1-kafai@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Jan 2020 17:49:00 -0800
Message-ID: <CAEf4BzYgvq+s09d7eKhf_dd-Goh-V3DRHWmMM+=k0=Ce=zQ2ug@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/5] bpftool: Support dumping a map with btf_vmlinux_value_type_id
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Kernel Team <kernel-team@fb.com>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 14, 2020 at 2:46 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> This patch makes bpftool support dumping a map's value properly
> when the map's value type is a type of the running kernel's btf.
> (i.e. map_info.btf_vmlinux_value_type_id is set instead of
> map_info.btf_value_type_id).  The first usecase is for the
> BPF_MAP_TYPE_STRUCT_OPS.
>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> ---
>  tools/bpf/bpftool/map.c | 43 +++++++++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 10 deletions(-)
>
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 4c5b15d736b6..d25f3b2355ad 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -20,6 +20,7 @@
>  #include "btf.h"
>  #include "json_writer.h"
>  #include "main.h"
> +#include "libbpf_internal.h"
>
>  const char * const map_type_name[] = {
>         [BPF_MAP_TYPE_UNSPEC]                   = "unspec",
> @@ -252,6 +253,7 @@ static int do_dump_btf(const struct btf_dumper *d,
>                        struct bpf_map_info *map_info, void *key,
>                        void *value)
>  {
> +       __u32 value_id;
>         int ret;
>
>         /* start of key-value pair */
> @@ -265,9 +267,12 @@ static int do_dump_btf(const struct btf_dumper *d,
>                         goto err_end_obj;
>         }
>
> +       value_id = map_info->btf_vmlinux_value_type_id ?
> +               : map_info->btf_value_type_id;
> +
>         if (!map_is_per_cpu(map_info->type)) {
>                 jsonw_name(d->jw, "value");
> -               ret = btf_dumper_type(d, map_info->btf_value_type_id, value);
> +               ret = btf_dumper_type(d, value_id, value);
>         } else {
>                 unsigned int i, n, step;
>
> @@ -279,8 +284,7 @@ static int do_dump_btf(const struct btf_dumper *d,
>                         jsonw_start_object(d->jw);
>                         jsonw_int_field(d->jw, "cpu", i);
>                         jsonw_name(d->jw, "value");
> -                       ret = btf_dumper_type(d, map_info->btf_value_type_id,
> -                                             value + i * step);
> +                       ret = btf_dumper_type(d, value_id, value + i * step);
>                         jsonw_end_object(d->jw);
>                         if (ret)
>                                 break;
> @@ -932,6 +936,27 @@ static int maps_have_btf(int *fds, int nb_fds)
>         return 1;
>  }
>
> +static struct btf *get_map_kv_btf(const struct bpf_map_info *info)
> +{
> +       struct btf *btf = NULL;
> +
> +       if (info->btf_vmlinux_value_type_id) {
> +               btf = bpf_find_kernel_btf();

If there are multiple maps we are dumping, it might become quite
costly to re-read and re-parse kernel BTF all the time. Can we lazily
load it, when required, and cache instead?

> +               if (IS_ERR(btf))
> +                       p_err("failed to get kernel btf");
> +       } else if (info->btf_value_type_id) {
> +               int err;
> +
> +               err = btf__get_from_id(info->btf_id, &btf);
> +               if (err || !btf) {
> +                       p_err("failed to get btf");
> +                       btf = err ? ERR_PTR(err) : ERR_PTR(-ESRCH);
> +               }
> +       }
> +
> +       return btf;
> +}
> +
>  static int
>  map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
>          bool show_header)
> @@ -952,13 +977,11 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
>         prev_key = NULL;
>
>         if (wtr) {
> -               if (info->btf_id) {
> -                       err = btf__get_from_id(info->btf_id, &btf);
> -                       if (err || !btf) {
> -                               err = err ? : -ESRCH;
> -                               p_err("failed to get btf");
> -                               goto exit_free;
> -                       }
> +               btf = get_map_kv_btf(info);
> +               if (IS_ERR(btf)) {
> +                       err = PTR_ERR(btf);
> +                       btf = NULL;
> +                       goto exit_free;
>                 }
>
>                 if (show_header) {
> --
> 2.17.1
>
