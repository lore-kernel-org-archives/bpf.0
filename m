Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477F5C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB6F218C3
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smoMBa6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbfB1S3R (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:29:17 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36913 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbfB1S3P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 13:29:15 -0500
Received: by mail-qt1-f195.google.com with SMTP id a48so24696523qtb.4;
        Thu, 28 Feb 2019 10:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2769MrlSYRQ2hjc9KyoqVuaefIPI8H3RxcoN0DvdY2I=;
        b=smoMBa6sI2wjmVckgMM6W5r5tIfKAqz8RBusPknomgn7bOfDMxpQVE7bNiDFLDVkDq
         eNeYEgks+ZehHSP+NCU1JUdaFz7ahCplsvz/jsuoc/JM83SjTGBZF+SbnChnQ+Eg6RqZ
         Z2/xtE6gPhnfk6O6aWgye/LoXaBB9U4Tqi3lQEWepd2m+lFa6kiVyEUWM1iMRkl4uz7w
         YO8NV+eHPgD8BYjdh3h21t35HUMPTnRkn67fxjjHhND/aAlRUaQ8Wg3Qtv0IBSrVaItQ
         0Qer+DtktUdTY+Zv+WDnzzItS6+lnDJOZ2RO5tMl76xRApOWSd98xcckED9VnA3N+oYa
         QBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2769MrlSYRQ2hjc9KyoqVuaefIPI8H3RxcoN0DvdY2I=;
        b=ZxhoQo81ksGoxedutFE5wsHzoMWHS4noKaKyfJZYbCqlIS+m4Hof19PTVSdgtych0I
         bahj8gxmRxQ1RsEZMEWqPYfUCpne5v8KkxkYDUYAdpoIcsU2uvhuReGx97KksECFStyL
         bV+OVD+NT3yr+wv4GBd4gQegVIDJMWCT/pviGKpu889glukQVLYRzkWSLFREj0s684lU
         pFUb717l3NH8viIMEvRd8n+/Ar+LASBQRWIEvayvt5Tqgw6HlMnol9szAkS5mh//ALKm
         29Vwx1keltMlbkHL+S4CedxttrkVrd30EQB3Hc1nt87IlglDYUPkLCRnl3Zmii4iW0N2
         OSpg==
X-Gm-Message-State: APjAAAXxTfv3AU/qsDtXg6u5TAc3w4BFgF6HS/ZFpHXeBngRUDcTY5y9
        SdYy6ya9yYzGDKL2Q7JHhwrV46gG8GF01iUajFACO1SA
X-Google-Smtp-Source: APXvYqwHsDDsQNZnqloxjCp2HH3eR1do3aZ0Nxds5xMNgq69tQYNqWUxbFEYsBju+8kF2XWVdFXsmB1Cb5GGzTfhZFg=
X-Received: by 2002:ac8:3011:: with SMTP id f17mr556404qte.268.1551378553519;
 Thu, 28 Feb 2019 10:29:13 -0800 (PST)
MIME-Version: 1.0
References: <20190227224642.1069138-1-andriin@fb.com> <20190227224642.1069138-5-andriin@fb.com>
In-Reply-To: <20190227224642.1069138-5-andriin@fb.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 28 Feb 2019 10:29:02 -0800
Message-ID: <CAPhsuW4ZBiEDqWfRooJoMt7eKhSYguOoeGpuT3DDM+PdNeKKvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] btf: fix bug with resolving STRUCT/UNION
 into corresponding FWD
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>, kernel-team@fb.com,
        ast@fb.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 27, 2019 at 2:48 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> When checking available canonical candidates for struct/union algorithm
> utilizes btf_dedup_is_equiv to determine if candidate is suitable. This
> check is not enough when candidate is corresponding FWD for that
> struct/union, because according to equivalence logic they are
> equivalent. When it so happens that FWD and STRUCT/UNION end in hashing
> to the same bucket, it's possible to create remapping loop from FWD to
> STRUCT and STRUCT to same FWD, which will cause btf_dedup() to loop
> forever.
>
> This patch fixes the issue by additionally checking that type and
> canonical candidate are strictly equal (utilizing btf_equal_struct).
>
> Fixes: d5caef5b5655 ("btf: add BTF types deduplication algorithm")
> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  tools/lib/bpf/btf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 6bbb710216e6..53db26d158c9 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -2255,7 +2255,7 @@ static void btf_dedup_merge_hypot_map(struct btf_dedup *d)
>  static int btf_dedup_struct_type(struct btf_dedup *d, __u32 type_id)
>  {
>         struct btf_dedup_node *cand_node;
> -       struct btf_type *t;
> +       struct btf_type *cand_type, *t;
>         /* if we don't find equivalent type, then we are canonical */
>         __u32 new_id = type_id;
>         __u16 kind;
> @@ -2275,6 +2275,10 @@ static int btf_dedup_struct_type(struct btf_dedup *d, __u32 type_id)
>         for_each_dedup_cand(d, h, cand_node) {
>                 int eq;
>
> +               cand_type = d->btf->types[cand_node->type_id];
> +               if (!btf_equal_struct(t, cand_type))
> +                       continue;
> +
>                 btf_dedup_clear_hypot_map(d);
>                 eq = btf_dedup_is_equiv(d, type_id, cand_node->type_id);
>                 if (eq < 0)
> --
> 2.17.1
>
