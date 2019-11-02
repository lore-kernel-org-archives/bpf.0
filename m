Return-Path: <SRS0=aaSJ=Y2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8366BCA9EC7
	for <bpf@archiver.kernel.org>; Sat,  2 Nov 2019 05:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C50E21906
	for <bpf@archiver.kernel.org>; Sat,  2 Nov 2019 05:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orvWCgHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfKBFKf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 2 Nov 2019 01:10:35 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44452 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfKBFKe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Nov 2019 01:10:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id o11so10805233qtr.11;
        Fri, 01 Nov 2019 22:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3fs59JoV9dztN2Zx9Rs9aliWG79+dEFB6uEUZs8cPwE=;
        b=orvWCgHKIBefdumADNVdq83mtqTuRdADQpotwcK3Ls6MH3p6CC+oINbAiuF3BdFXaf
         J7Z+qwNyiHija05xTxPe+rwM4FbIM5x4ykN2kuqHDWXFYUN12QAhwlXiG+SJ7McU5QT7
         jyLxW8QVPKZWXnMBpPLvMy5qDV3pwCYhnkAY/Ag5Lun6YHbbhPE9bwTrk0v8gdMl3a2K
         I7bGcNxQXB+UzB0y+nbIVAWSlJkRTuWDQjP9H9LDJp9JlJOJv7qE60EmdbIXjpjyw6D9
         EJWKWqbg3MumdGwA0Lqw/BbVKMYHQJmakpdW3tkl+9cUhv+7f2mDjKwljpELI+wWRWBh
         +9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3fs59JoV9dztN2Zx9Rs9aliWG79+dEFB6uEUZs8cPwE=;
        b=jg5ixoFQZcKwCLurdrFU+pr6yMor0sv12SE0/PDolOXkg9fpstx1sQj9wl1w/b8M/d
         eV5dga3ht5rAruiOMbRbzOY4niKidwyeoL9povijGhmMRQhTizkOMyFcYMPyQwB/9EJ1
         5aWzqbDCNteNpr0E4pIdFkFL7rJRZZarGjjI1CkydBgBOOf9JU6VoQ3hYfWeu+wfducE
         5U1AIkt3OluRRsqMswKe4czGBuLQoS3KlajBiQat4FxGTTqBHUy/pkt8Rc/SkJzUUSwq
         Jy+tLEhIm88pAeWxZLkRwca8tg5R2JjmUeL7ffAq1uD2fBcWeU4btDYhMUtisX+5kpu/
         rxVw==
X-Gm-Message-State: APjAAAVf8af6Bvk7MGLdbiDlN0g1S9sSIscvqL+LSEM9S4k/+Sg6DVK1
        debw0Hjaxk4LEQleN12JEjGp1ssHL2s6zYZ8G7w=
X-Google-Smtp-Source: APXvYqxNEPssjx/kTASd1BoeZM349poAPvD5tG9EUJwVYTZm7H/A5UwxMS6u9I5XJ62V2Es2m1K8+xbTyhEpQ8D5cGU=
X-Received: by 2002:ad4:4e4a:: with SMTP id eb10mr13225336qvb.228.1572671433650;
 Fri, 01 Nov 2019 22:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <157260197645.335202.2393286837980792460.stgit@toke.dk> <157260197871.335202.12855636074438881848.stgit@toke.dk>
In-Reply-To: <157260197871.335202.12855636074438881848.stgit@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 1 Nov 2019 22:10:22 -0700
Message-ID: <CAEf4BzZMO7j1LsESEetTJCRpw4HDZ994C5RigFU+uQ1tgQa_PQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/5] libbpf: Store map pin path and status in
 struct bpf_map
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 1, 2019 at 2:53 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> Support storing and setting a pin path in struct bpf_map, which can be us=
ed
> for automatic pinning. Also store the pin status so we can avoid attempts
> to re-pin a map that has already been pinned (or reused from a previous
> pinning).
>
> The behaviour of bpf_object__{un,}pin_maps() is changed so that if it is
> called with a NULL path argument (which was previously illegal), it will
> (un)pin only those maps that have a pin_path set.
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  tools/lib/bpf/libbpf.c   |  164 +++++++++++++++++++++++++++++++++++-----=
------
>  tools/lib/bpf/libbpf.h   |    8 ++
>  tools/lib/bpf/libbpf.map |    3 +
>  3 files changed, 134 insertions(+), 41 deletions(-)
>

[...]

>  LIBBPF_API int bpf_object__pin_maps(struct bpf_object *obj, const char *=
path);
>  LIBBPF_API int bpf_object__unpin_maps(struct bpf_object *obj,
>                                       const char *path);
> @@ -385,6 +390,9 @@ LIBBPF_API int bpf_map__resize(struct bpf_map *map, _=
_u32 max_entries);
>  LIBBPF_API bool bpf_map__is_offload_neutral(const struct bpf_map *map);
>  LIBBPF_API bool bpf_map__is_internal(const struct bpf_map *map);
>  LIBBPF_API void bpf_map__set_ifindex(struct bpf_map *map, __u32 ifindex)=
;
> +LIBBPF_API int bpf_map__set_pin_path(struct bpf_map *map, const char *pa=
th);
> +LIBBPF_API const char *bpf_map__get_pin_path(struct bpf_map *map);
> +LIBBPF_API bool bpf_map__is_pinned(struct bpf_map *map);


Didn't notice this before and wasn't going to force another version
just for this, but given you'll be fixing last patch anyways...
bpf_map__is_pinned and bpf_map__get_pin_path are read-only "getters",
so it would be appropriate for them to accept "const struct bpf_map *"
instead.

>  LIBBPF_API int bpf_map__pin(struct bpf_map *map, const char *path);
>  LIBBPF_API int bpf_map__unpin(struct bpf_map *map, const char *path);
>
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index d1473ea4d7a5..1681a9ce109f 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -193,6 +193,9 @@ LIBBPF_0.0.5 {
>
>  LIBBPF_0.0.6 {
>         global:
> +               bpf_map__get_pin_path;
> +               bpf_map__is_pinned;
> +               bpf_map__set_pin_path;
>                 bpf_object__open_file;
>                 bpf_object__open_mem;
>                 bpf_program__get_expected_attach_type;
>
