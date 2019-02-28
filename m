Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C45C10F00
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 20:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E4E218CD
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 20:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a82MeMYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbfB1UIa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:08:30 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39728 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfB1UIa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 15:08:30 -0500
Received: by mail-oi1-f194.google.com with SMTP id b4so17576733oif.6;
        Thu, 28 Feb 2019 12:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llc7Lf3yQJc4aqS3jY9XdXqXsYTGzU41xCIozmua4fc=;
        b=a82MeMYKuPRVt2yxP4kbLodSee/h2pmRSC+l4mJZiWENSrwDCM0ivzsX74qLwKO7wQ
         tGwKD8oxgfu0M45eKMmtX8tl12bFpoGAVCUqw2qEAwnQu2YiW+CnKsdvXVegfJjJc2Z1
         YkjcQy4SwP8eow4SEuULJg/LkvgwxLdI9xZSzbrGFQwVZ1fH9R/oSipX1aVLKL5pDKlr
         +JS8LYtAT2pQKYR5gwrau/oGjqM2tQeZK4X+hmnUCCdggQ44g3eCBewWtAX2Tl4JK6w4
         yaUD8vsMGwn/AthOaICl7QgAA6jBZLwRuWKSfArsUKRRM20mlVzKj0biU4zmAMHN2jmX
         1+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llc7Lf3yQJc4aqS3jY9XdXqXsYTGzU41xCIozmua4fc=;
        b=odg2qk6q7Yu4cEjriuR9cpu6ML7Oh1z+pGl3UmfCgsrKrU0Gnh/O76EZe56fMJ43u/
         /AnyWTCA83q6xDYsc/DWKiUdAbGcHANBlywPxTnWOpI6N5LGUJ3HCXkPRSHJN5JhPNzX
         uD/bixOHsoVwuLyJlE8sn+HeJJb+UH6QA+8YTAU5Q6K3zwxtuS42NfNKpVZ6cGDe++ru
         iE4euKO/dR7or2G56NPFM4/HaE6DrswBmGiAbQ5qWf7tudIUZYisIBUxB4kuVKbOlFzF
         Kgl2MsY/2xbd3YJJ76FhewHGA8Q/uTamoWbQg9KpiHXbq/NYbJJ1x0v/K7cigpO1Vc1A
         l/fg==
X-Gm-Message-State: AHQUAuY2Npc9Lnq3bIEBDf8oxTUfx2c2Mj+8WV0nDfW/yncBa1a10rvy
        e7sCTPDY2i+9uozVFl+YMIOMg5QiXx4pPTb7zZM=
X-Google-Smtp-Source: AHgI3IZwSbCn/Y/Su+3HY/kwF8AqEab4K+CMlbQkLp74yIOXq8qsriyXCzPgfVGuWh63oSYIHhbgLs/EqLjXUFoU1BY=
X-Received: by 2002:aca:3bd5:: with SMTP id i204mr992926oia.167.1551384508926;
 Thu, 28 Feb 2019 12:08:28 -0800 (PST)
MIME-Version: 1.0
References: <20190227224642.1069138-1-andriin@fb.com> <20190227224642.1069138-4-andriin@fb.com>
 <20190228185749.GJ9508@kernel.org>
In-Reply-To: <20190228185749.GJ9508@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 Feb 2019 12:08:17 -0800
Message-ID: <CAEf4Bza48298-6qE7NOqZb=wKvjwR0NdVgXA1Te7Hj9gH7r6EQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] btf: allow to customize dedup hash table size
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, Kernel Team <kernel-team@fb.com>,
        Alexei Starovoitov <ast@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 28, 2019 at 10:57 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Feb 27, 2019 at 02:46:39PM -0800, Andrii Nakryiko escreveu:
> > Default size of dedup table (16k) is good enough for most binaries, even
> > typical vmlinux images. But there are cases of binaries with huge amount
> > of BTF types (e.g., allyesconfig variants of kernel), which benefit from
> > having bigger dedup table size to lower amount of unnecessary hash
> > collisions. Tools like pahole, thus, can tune this parameter to reach
> > optimal performance.
> >
> > This change also serves double purpose of allowing tests to force hash
> > collisions to test some corner cases, used in follow up patch.
> >
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> > ---
> >  tools/lib/bpf/btf.c | 43 ++++++++++++++++++++++++++-----------------
> >  tools/lib/bpf/btf.h |  1 +
> >  2 files changed, 27 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 68b50e9bbde1..6bbb710216e6 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -1070,8 +1070,7 @@ int btf__dedup(struct btf *btf, struct btf_ext *btf_ext,
> >       return err;
> >  }
> >
> > -#define BTF_DEDUP_TABLE_SIZE_LOG 14
> > -#define BTF_DEDUP_TABLE_MOD ((1 << BTF_DEDUP_TABLE_SIZE_LOG) - 1)
> > +#define BTF_DEDUP_TABLE_DEFAULT_SIZE (1 << 14)
> >  #define BTF_UNPROCESSED_ID ((__u32)-1)
> >  #define BTF_IN_PROGRESS_ID ((__u32)-2)
> >
> > @@ -1128,18 +1127,21 @@ static inline __u32 hash_combine(__u32 h, __u32 value)
> >  #undef GOLDEN_RATIO_PRIME
> >  }
> >
> > -#define for_each_hash_node(table, hash, node) \
> > -     for (node = table[hash & BTF_DEDUP_TABLE_MOD]; node; node = node->next)
> > +#define for_each_dedup_cand(d, hash, node) \
> > +     for (node = d->dedup_table[hash & (d->opts.dedup_table_size - 1)]; \
> > +          node;                                                         \
> > +          node = node->next)
> >
> >  static int btf_dedup_table_add(struct btf_dedup *d, __u32 hash, __u32 type_id)
> >  {
> >       struct btf_dedup_node *node = malloc(sizeof(struct btf_dedup_node));
> > +     int bucket = hash & (d->opts.dedup_table_size - 1);
> >
> >       if (!node)
> >               return -ENOMEM;
> >       node->type_id = type_id;
> > -     node->next = d->dedup_table[hash & BTF_DEDUP_TABLE_MOD];
> > -     d->dedup_table[hash & BTF_DEDUP_TABLE_MOD] = node;
> > +     node->next = d->dedup_table[bucket];
> > +     d->dedup_table[bucket] = node;
> >       return 0;
> >  }
> >
> > @@ -1177,7 +1179,7 @@ static void btf_dedup_table_free(struct btf_dedup *d)
> >       if (!d->dedup_table)
> >               return;
> >
> > -     for (i = 0; i < (1 << BTF_DEDUP_TABLE_SIZE_LOG); i++) {
> > +     for (i = 0; i < d->opts.dedup_table_size; i++) {
> >               while (d->dedup_table[i]) {
> >                       tmp = d->dedup_table[i];
> >                       d->dedup_table[i] = tmp->next;
> > @@ -1221,10 +1223,19 @@ static struct btf_dedup *btf_dedup_new(struct btf *btf, struct btf_ext *btf_ext,
> >       if (!d)
> >               return ERR_PTR(-ENOMEM);
> >
> > +     d->opts.dont_resolve_fwds = opts && opts->dont_resolve_fwds;
>
> Is the above line a leftover from some other patch? Doesn't seem related
> to this patch.
>
> The rest seems ok.

No, I added another option and moved options processing to the top of
btf_dedup_new() (it used to be at the end, but it makes sense to first
process options, because they can be required during construction of
btf__dedup, as is the case for dedup_table_size).

>
> > +     /* ensure table size is power of two and limit to 2G */
> > +     d->opts.dedup_table_size = opts && opts->dedup_table_size
> > +             ? opts->dedup_table_size
> > +             : BTF_DEDUP_TABLE_DEFAULT_SIZE;
> > +     for (i = 0; i < 31 && (1 << i) < d->opts.dedup_table_size;  i++)
> > +             ;
> > +     d->opts.dedup_table_size = 1 << i;
> > +
> >       d->btf = btf;
> >       d->btf_ext = btf_ext;
> >
> > -     d->dedup_table = calloc(1 << BTF_DEDUP_TABLE_SIZE_LOG,
> > +     d->dedup_table = calloc(d->opts.dedup_table_size,
> >                               sizeof(struct btf_dedup_node *));
> >       if (!d->dedup_table) {
> >               err = -ENOMEM;
> > @@ -1249,8 +1260,6 @@ static struct btf_dedup *btf_dedup_new(struct btf *btf, struct btf_ext *btf_ext,
> >       for (i = 0; i <= btf->nr_types; i++)
> >               d->hypot_map[i] = BTF_UNPROCESSED_ID;
> >
> > -     d->opts.dont_resolve_fwds = opts && opts->dont_resolve_fwds;
> > -
> >  done:
> >       if (err) {
> >               btf_dedup_free(d);
> > @@ -1824,7 +1833,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
> >
> >       case BTF_KIND_INT:
> >               h = btf_hash_int(t);
> > -             for_each_hash_node(d->dedup_table, h, cand_node) {
> > +             for_each_dedup_cand(d, h, cand_node) {
> >                       cand = d->btf->types[cand_node->type_id];
> >                       if (btf_equal_int(t, cand)) {
> >                               new_id = cand_node->type_id;
> > @@ -1835,7 +1844,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
> >
> >       case BTF_KIND_ENUM:
> >               h = btf_hash_enum(t);
> > -             for_each_hash_node(d->dedup_table, h, cand_node) {
> > +             for_each_dedup_cand(d, h, cand_node) {
> >                       cand = d->btf->types[cand_node->type_id];
> >                       if (btf_equal_enum(t, cand)) {
> >                               new_id = cand_node->type_id;
> > @@ -1846,7 +1855,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
> >
> >       case BTF_KIND_FWD:
> >               h = btf_hash_common(t);
> > -             for_each_hash_node(d->dedup_table, h, cand_node) {
> > +             for_each_dedup_cand(d, h, cand_node) {
> >                       cand = d->btf->types[cand_node->type_id];
> >                       if (btf_equal_common(t, cand)) {
> >                               new_id = cand_node->type_id;
> > @@ -2263,7 +2272,7 @@ static int btf_dedup_struct_type(struct btf_dedup *d, __u32 type_id)
> >               return 0;
> >
> >       h = btf_hash_struct(t);
> > -     for_each_hash_node(d->dedup_table, h, cand_node) {
> > +     for_each_dedup_cand(d, h, cand_node) {
> >               int eq;
> >
> >               btf_dedup_clear_hypot_map(d);
> > @@ -2349,7 +2358,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
> >               t->type = ref_type_id;
> >
> >               h = btf_hash_common(t);
> > -             for_each_hash_node(d->dedup_table, h, cand_node) {
> > +             for_each_dedup_cand(d, h, cand_node) {
> >                       cand = d->btf->types[cand_node->type_id];
> >                       if (btf_equal_common(t, cand)) {
> >                               new_id = cand_node->type_id;
> > @@ -2372,7 +2381,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
> >               info->index_type = ref_type_id;
> >
> >               h = btf_hash_array(t);
> > -             for_each_hash_node(d->dedup_table, h, cand_node) {
> > +             for_each_dedup_cand(d, h, cand_node) {
> >                       cand = d->btf->types[cand_node->type_id];
> >                       if (btf_equal_array(t, cand)) {
> >                               new_id = cand_node->type_id;
> > @@ -2403,7 +2412,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
> >               }
> >
> >               h = btf_hash_fnproto(t);
> > -             for_each_hash_node(d->dedup_table, h, cand_node) {
> > +             for_each_dedup_cand(d, h, cand_node) {
> >                       cand = d->btf->types[cand_node->type_id];
> >                       if (btf_equal_fnproto(t, cand)) {
> >                               new_id = cand_node->type_id;
> > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > index b60bb7cf5fff..28a1e1e59861 100644
> > --- a/tools/lib/bpf/btf.h
> > +++ b/tools/lib/bpf/btf.h
> > @@ -90,6 +90,7 @@ LIBBPF_API __u32 btf_ext__func_info_rec_size(const struct btf_ext *btf_ext);
> >  LIBBPF_API __u32 btf_ext__line_info_rec_size(const struct btf_ext *btf_ext);
> >
> >  struct btf_dedup_opts {
> > +     unsigned int dedup_table_size;
> >       bool dont_resolve_fwds;
> >  };
> >
> > --
> > 2.17.1
>
> --
>
> - Arnaldo
