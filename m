Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C045AC43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 19:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E643218D0
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 19:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJa7Rjxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfB1THP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:07:15 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39556 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfB1THP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 14:07:15 -0500
Received: by mail-ot1-f67.google.com with SMTP id e15so9108413otk.6;
        Thu, 28 Feb 2019 11:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ftI7Awl9DWqb9oRc2Hn65ubXpl9HCAQy3BCJGVx32nI=;
        b=QJa7RjxiK8oFOFfoAJYyhXJTQyC5CjebhPMHMtqu9llCtQ6PmsL2kb0IaLXOFaUJGn
         c85qlxnEy150/tT8EA1zNGrk7Qz0nli7bzAdmwTKdXQ6cM6W9MmxjcFgwLH/KIn9cKBX
         kxOF8pjM1CZ0Cj1ytzt5ViK8sD6pX5PgooxC4PjsNXLecF0c8kV71bBJOErkuToMqvfs
         1WOreTR8KDXSpcsLpvoXdqr/3wPXH9n/I3z3M1t109UxFZdeADgkeuKoQYTooi0gu1Sc
         DFyOAf7D6TWq0kyUjOZkNaQMIzMo47nRt8JfgJP/PhRwPsJJ9JMNbOngnIdKux7dZRUF
         F8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftI7Awl9DWqb9oRc2Hn65ubXpl9HCAQy3BCJGVx32nI=;
        b=KBwpZRTz6tNczlcD/gI8JyDkjmxaqvnYDID1h14une+NUjlhEHDHDGc1VsKVKhu+pr
         gbUsyg8ygw8VE/AzxKN+JDj5250lRUmYXtwpMRLbN2ABrFf27x8J3ZJtlMtOr8Gimx0H
         +T6/nUu//yReApy1qsAOCRxbVJGO0v1Q87xMYWBeSG/y5/giMj3xXU7NgCRHLSMVA2UT
         J0CtaSjisCAtwI8DT27iEJ2uqWBaKHY1OOis/G540Zw+n4RNBQG5agKxz6RJ7oVaVpaf
         wkiUC5oX7yCR+QXUIoF9bEwQ3mzz+xJYu5H8q3FsCWZeOnbh0IPlpg5tcVnXmDcKNqMt
         2ihg==
X-Gm-Message-State: APjAAAWThTVFKCM7G9f55U99dvIOzlEZmTETtWjQmyXFBtFpa8/TS+J2
        +iGpuXOZnwFtngdTuyDf/un3giP8ibfR/d7Oqjg=
X-Google-Smtp-Source: APXvYqyMwqlN1s5i8Sul9gU0FcEoXguaQkhE2WmR9/bK9EiDBGJlfZ9JFqdwfEZ1jl8s78NJf5WwRRewJkC+rUFCUcc=
X-Received: by 2002:a05:6830:1193:: with SMTP id u19mr761218otq.221.1551380833902;
 Thu, 28 Feb 2019 11:07:13 -0800 (PST)
MIME-Version: 1.0
References: <20190227224642.1069138-1-andriin@fb.com> <20190227224642.1069138-5-andriin@fb.com>
 <797b56c0-2178-a0b1-3070-721c2fd4d38c@fb.com>
In-Reply-To: <797b56c0-2178-a0b1-3070-721c2fd4d38c@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 Feb 2019 11:07:02 -0800
Message-ID: <CAEf4BzZRHJQEC7Z8JReDeoa1w3DV9dtq-pajOA_RFGYucaRU=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] btf: fix bug with resolving STRUCT/UNION
 into corresponding FWD
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 28, 2019 at 10:19 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/27/19 2:46 PM, Andrii Nakryiko wrote:
> > When checking available canonical candidates for struct/union algorithm
> > utilizes btf_dedup_is_equiv to determine if candidate is suitable. This
> > check is not enough when candidate is corresponding FWD for that
> > struct/union, because according to equivalence logic they are
> > equivalent. When it so happens that FWD and STRUCT/UNION end in hashing
> > to the same bucket, it's possible to create remapping loop from FWD to
> > STRUCT and STRUCT to same FWD, which will cause btf_dedup() to loop
> > forever.
> >
> > This patch fixes the issue by additionally checking that type and
> > canonical candidate are strictly equal (utilizing btf_equal_struct).
>
> It looks like btf_equal_struct() checking equality except
> member type id's. Maybe calling it btf_almost_equal_struct() or
> something like that?

Yes, for struct/union we can't compare types directly, that's what
btf_dedup_is_equiv is doing. I think btf_equal_struct w/ comment
explaining this particular behavior is good enough. If you insist,
though, I'd rather go to something like btf_shallow_equal_struct or
something along those lines.

>
> >
> > Fixes: d5caef5b5655 ("btf: add BTF types deduplication algorithm")
> > Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> > ---
> >   tools/lib/bpf/btf.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 6bbb710216e6..53db26d158c9 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -2255,7 +2255,7 @@ static void btf_dedup_merge_hypot_map(struct btf_dedup *d)
> >   static int btf_dedup_struct_type(struct btf_dedup *d, __u32 type_id)
> >   {
> >       struct btf_dedup_node *cand_node;
> > -     struct btf_type *t;
> > +     struct btf_type *cand_type, *t;
> >       /* if we don't find equivalent type, then we are canonical */
> >       __u32 new_id = type_id;
> >       __u16 kind;
> > @@ -2275,6 +2275,10 @@ static int btf_dedup_struct_type(struct btf_dedup *d, __u32 type_id)
> >       for_each_dedup_cand(d, h, cand_node) {
> >               int eq;
> >
> > +             cand_type = d->btf->types[cand_node->type_id];
> > +             if (!btf_equal_struct(t, cand_type))
>
> The comment for this btf_equal_struct is not quite right.
> /*
>   * Check structural compatibility of two FUNC_PROTOs, ignoring
> referenced type
>   * IDs. This check is performed during type graph equivalence check and
>   * referenced types equivalence is checked separately.
>   */
> static bool btf_equal_struct(struct btf_type *t1, struct btf_type *t2)
>
> It should be two "struct/union types".

Yep, good catch, will fix!

>
> > +                     continue;
> > +
>
> I did not trace the algorithm how infinite loop happens. But the above

Check the test in follow up patch. It has a minimal example that
triggers this bug. It happens when we have some FWD x, which we
discover that it should be resolved to some STRUCT x (as a result of
equivalence check/resolution of some other struct s, that references
struct x internally). But that struct x might not have been
deduplicated yet, we just record this FWD -> STRUCT mapping so that we
don't lose this connection. Later, once we get to deduplication of
struct x, FWD x will be (in case of hash collision) one possible
candidate to consider for deduplication. At that point,
btf_dedup_is_equiv will consider them equivalent (but they are not
equal (!), that's where the bug is), so we'll try to resolve STRUCT x
-> FWD x, which creates a loop.

In btf_dedup_merge_hypot_map() that is used to record discovered
"equivalences" during struct/union type graph equivalence check, we
have explicit check to never resolve STRUCT/UNION into equivalent FWD,
so such loop shouldn't happen, except I missed the case of having FWD
as a possible dedup candidate due to hash collision.

> change is certainly a correct one, you want to do deduplication only
> after everything else (except member types) are euqal?

Well, if not for special case of FWD == STRUCT/UNION when
deduplicating structs, btf_dedup_is_equiv would be enough, because it
already checks for btf_equal_struct internally, when both types are
struct/union. It's just the special bit at the beginning of is_equiv
check that allows FWD and STRUCT/UNION with the same name to be
declared equivalent, that throws this off.

>
> If the bug is due to circle in struct->fwd and fwd->struct mappings,
> maybe a simple check whether such circle exists or not before update
> the mapping will also work? I am not proposing this fix, but want
> to understand better the issue.

That's essentially what we use btf_equal_struct for here, really. We
could equivalently just check BTF_INFO_KIND(t) == BTF_INFO_KIND(cand)
explicitly, but I btf_equal_struct feels a bit more generic and
obviously correct.

>
>
>
>
> >               btf_dedup_clear_hypot_map(d);
> >               eq = btf_dedup_is_equiv(d, type_id, cand_node->type_id);
> >               if (eq < 0)
> >
