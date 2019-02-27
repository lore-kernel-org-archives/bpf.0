Return-Path: <SRS0=P9GS=RC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ADEC43381
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 23:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0F9218A4
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 23:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNy5+nE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfB0XsI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:48:08 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38383 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbfB0XsI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 18:48:08 -0500
Received: by mail-ot1-f68.google.com with SMTP id m1so16081928otf.5;
        Wed, 27 Feb 2019 15:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PqZxVagqKv7WucsnCLsOlMNYWesChfWhkLgrRlbMGOw=;
        b=dNy5+nE1fTxlCAT0EmSfO/YK99seYhpscPPR2SzyVOlWNFvTRcDKYd6nxwuyLWQcdb
         xcu5/32APkRC7CFz/5whrZXtQMp9vXCCeq2vfzOpJvXO37P0xZ2C+NljYxaNl+0HbnnM
         zBeUOYU5pIWqft4loV5RM1pwemEkdrbjvdZrG/MVR7kysTmKvIo9NLjrr463UO/wgaVn
         ej406QlZpoia+TP0tbM5YZSU7q66l2005qldPCChSihXzcBaYrozuWHrbtPkTA/uPbjW
         w5YwF4yv2+lnzb45MHfkE8stlzBNdaeqWbAebZnlxVadZZHInPFAuSpKDa5/Sd1VEA3O
         KFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PqZxVagqKv7WucsnCLsOlMNYWesChfWhkLgrRlbMGOw=;
        b=e+Lwp+Tu4f+B0crqthWK2vJX68D+ZZRQnyxcAvS+hOpAqMO0E5nNl2ZFVhR5ydO912
         paUv9a02q/A2zaofTdlTlXO40Gh+15pbNF5jSJbg5AwJx6V+xbj1LcenG5IK6z0lXv9d
         Dk3NG7IcaPEfFm6lvi6I1aDOkvb+S/fHOi/zlmdDDsWWhL/o5MHpicQ5I2Bzujf1NQEy
         T4f/TQ5WzsSYpRgJ8ibY0n0liW0t0wI7GmYuwzTcuIbGTNQMij4YU8dkZwOd8brV0wDG
         /H0iUjuHfcxILle3S9gDiHBZsCjcqEV2J41djIaHKW3n9tEUqedisvKuNwc5KZ8kdCu9
         eIDA==
X-Gm-Message-State: AHQUAuYmTATF9od8yCmHXxiJuuGg1EcLE+g+ZLzXYdksAtTbrcgHU9Z2
        0v+0DL9LS04vqNzmN6ATP5AHe7L2VNwu7R+zlnE=
X-Google-Smtp-Source: AHgI3IZSbm4dx7rZ1Vnt28rthIA4FB4Z/0NTSMgs5YGRbAH3FT1syb0DyQnfikxZYGCyzjvBqAI5OhhlCUW4UCyxQDA=
X-Received: by 2002:a9d:6a08:: with SMTP id g8mr4166621otn.191.1551311287184;
 Wed, 27 Feb 2019 15:48:07 -0800 (PST)
MIME-Version: 1.0
References: <20190227233046.11718-1-jakub.kicinski@netronome.com> <20190227233046.11718-4-jakub.kicinski@netronome.com>
In-Reply-To: <20190227233046.11718-4-jakub.kicinski@netronome.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Feb 2019 15:47:56 -0800
Message-ID: <CAEf4BzZR+7R9TjXSMHiYzbHCvuwL+Z_LBD=Pk+rRW+X+pgdg4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] tools: libbpf: add a correctly named define
 for map iteration
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, oss-drivers@netronome.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 27, 2019 at 3:31 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> For historical reasons the helper to loop over maps in an object
> is called bpf_map__for_each while it really should be called
> bpf_object__for_each_map.  Rename and add a correctly named
> define for backward compatibility.

Seems like there are at least 3 more functions that are not named correctly:
- __bpf_map__iter (__bpf_object__iter_map?)
- bpf_map__next (=> bpf_object__next_map?)
- bpf_map__prev (=> bpf_object__prev_map?)

Let's rename them as well?


>
> Switch all in-tree users to the correct name (Quentin).
>
> Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
> ---
>  tools/bpf/bpftool/prog.c                       | 4 ++--
>  tools/lib/bpf/libbpf.c                         | 8 ++++----
>  tools/lib/bpf/libbpf.h                         | 3 ++-
>  tools/perf/util/bpf-loader.c                   | 4 ++--
>  tools/testing/selftests/bpf/test_libbpf_open.c | 2 +-
>  5 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 0c35dd543d49..8ef80d65a474 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1053,7 +1053,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
>         j = 0;
>         while (j < old_map_fds && map_replace[j].name) {
>                 i = 0;
> -               bpf_map__for_each(map, obj) {
> +               bpf_object__for_each_map(map, obj) {
>                         if (!strcmp(bpf_map__name(map), map_replace[j].name)) {
>                                 map_replace[j].idx = i;
>                                 break;
> @@ -1074,7 +1074,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
>         /* Set ifindex and name reuse */
>         j = 0;
>         idx = 0;
> -       bpf_map__for_each(map, obj) {
> +       bpf_object__for_each_map(map, obj) {
>                 if (!bpf_map__is_offload_neutral(map))
>                         bpf_map__set_ifindex(map, ifindex);
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b38dcbe7460a..f5eb60379c8d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2100,7 +2100,7 @@ int bpf_object__pin_maps(struct bpf_object *obj, const char *path)
>         if (err)
>                 return err;
>
> -       bpf_map__for_each(map, obj) {
> +       bpf_object__for_each_map(map, obj) {
>                 char buf[PATH_MAX];
>                 int len;
>
> @@ -2147,7 +2147,7 @@ int bpf_object__unpin_maps(struct bpf_object *obj, const char *path)
>         if (!obj)
>                 return -ENOENT;
>
> -       bpf_map__for_each(map, obj) {
> +       bpf_object__for_each_map(map, obj) {
>                 char buf[PATH_MAX];
>                 int len;
>
> @@ -2835,7 +2835,7 @@ bpf_object__find_map_by_name(struct bpf_object *obj, const char *name)
>  {
>         struct bpf_map *pos;
>
> -       bpf_map__for_each(pos, obj) {
> +       bpf_object__for_each_map(pos, obj) {
>                 if (pos->name && !strcmp(pos->name, name))
>                         return pos;
>         }
> @@ -2928,7 +2928,7 @@ int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
>                         first_prog = prog;
>         }
>
> -       bpf_map__for_each(map, obj) {
> +       bpf_object__for_each_map(map, obj) {
>                 if (!bpf_map__is_offload_neutral(map))
>                         map->map_ifindex = attr->ifindex;
>         }
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 6c0168f8bba5..b4652aa1a58a 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -278,10 +278,11 @@ bpf_object__find_map_by_offset(struct bpf_object *obj, size_t offset);
>
>  LIBBPF_API struct bpf_map *
>  bpf_map__next(struct bpf_map *map, struct bpf_object *obj);
> -#define bpf_map__for_each(pos, obj)            \
> +#define bpf_object__for_each_map(pos, obj)             \
>         for ((pos) = bpf_map__next(NULL, (obj));        \
>              (pos) != NULL;                             \
>              (pos) = bpf_map__next((pos), (obj)))
> +#define bpf_map__for_each bpf_object__for_each_map

Should we get rid of this as well, instead of accumulating cruft?

>
>  LIBBPF_API struct bpf_map *
>  bpf_map__prev(struct bpf_map *map, struct bpf_object *obj);
> diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> index 037d8ff6a634..31b7e5a1453b 100644
> --- a/tools/perf/util/bpf-loader.c
> +++ b/tools/perf/util/bpf-loader.c
> @@ -1489,7 +1489,7 @@ apply_obj_config_object(struct bpf_object *obj)
>         struct bpf_map *map;
>         int err;
>
> -       bpf_map__for_each(map, obj) {
> +       bpf_object__for_each_map(map, obj) {
>                 err = apply_obj_config_map(map);
>                 if (err)
>                         return err;
> @@ -1513,7 +1513,7 @@ int bpf__apply_obj_config(void)
>
>  #define bpf__for_each_map(pos, obj, objtmp)    \
>         bpf_object__for_each_safe(obj, objtmp)  \
> -               bpf_map__for_each(pos, obj)
> +               bpf_object__for_each_map(pos, obj)
>
>  #define bpf__for_each_map_named(pos, obj, objtmp, name)        \
>         bpf__for_each_map(pos, obj, objtmp)             \
> diff --git a/tools/testing/selftests/bpf/test_libbpf_open.c b/tools/testing/selftests/bpf/test_libbpf_open.c
> index 1909ecf4d999..65cbd30704b5 100644
> --- a/tools/testing/selftests/bpf/test_libbpf_open.c
> +++ b/tools/testing/selftests/bpf/test_libbpf_open.c
> @@ -67,7 +67,7 @@ int test_walk_maps(struct bpf_object *obj, bool verbose)
>         struct bpf_map *map;
>         int cnt = 0;
>
> -       bpf_map__for_each(map, obj) {
> +       bpf_object__for_each_map(map, obj) {
>                 cnt++;
>                 if (verbose)
>                         printf("Map (count:%d) name: %s\n", cnt,
> --
> 2.19.2
>
