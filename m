Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860D3C43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 23:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FF5206B8
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 23:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSYaF9IN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfCAXmV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 18:42:21 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38877 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfCAXmU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 18:42:20 -0500
Received: by mail-qt1-f194.google.com with SMTP id s1so29886194qte.5;
        Fri, 01 Mar 2019 15:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OdWcgi/jU9S15KymE9XYWUGRO/BslT+7/UbABIF3Uv0=;
        b=BSYaF9INJHj0g3G3HiXZeWvw6ZPWqzw84mbwKqB1FX+NpZHdOyd+UeAaasdwE6tswn
         BQe5cgLZ0HJ2s07tlbDiQULurGwkJGHLhpyYcgmslCxbi7c0xmEsGk/l42EAIKjYmSY+
         v7FujnfMMFS9F0+tYYcqlFSafIXqLagxaxcf78ENEXplSoA7A1oxvh3mbY3ukVut6dzo
         mryj9GxwcYjkWfkqaUL2T/w+sFehoPuy01zsUdcdc0S2iQcRj1n7UQmvQczR0D8O5F5F
         p8z/GmOf8fVqguniquwePtvx3IDj7dY5AKfrWN+CUSaCmWORtaTMDkPlwi7ghv1QwoCk
         A4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OdWcgi/jU9S15KymE9XYWUGRO/BslT+7/UbABIF3Uv0=;
        b=AMZ0mTs5YfgStbAeSw2R1vgk31vw//P+ocW3+uuByAtairtoI7dRa1065j87iwhQ6n
         HKHVq0XxIyZFKBS+Ag6JYjPnmtyutQuv4fCVCxgJE8ZqwL3CstA5DhSZKz9LkE14OoKn
         NY8JED4L3vtNaHaBVaQt9Ku0LSZz0cfVeO/88TEZcGMf8Am67SfJs0EYmCuIcJbWUdLl
         zA+UGnFXLSGLTIgH+r0q/fRx4X3xk6tUoTIVQOW4qFMDsR1Et3HRHMjfaezJgBxLWyLr
         e47Gp6bN1W9EAiqkBY0UKkT8Bk1EycG5pVqa5fTFBDkmOl/hBy2emEiTmWxeSOmSZj2F
         ZwDQ==
X-Gm-Message-State: APjAAAVoIPsjL5JxnZBihSxJQ+KB50sCgcejkiZNe4kuh8wVqnrfGKLK
        xijsw7ZRfPiLbfKvmwiwGYqFPdno7catu16hxe8=
X-Google-Smtp-Source: APXvYqxXTshBL9+J/BK7lmaKETgWaRDGcH0s1hcdjwSA3ewth+bc8mRDoL4ZxnIG2IA5Tgqy8N20nCNeX7WIw17fSJw=
X-Received: by 2002:aed:3904:: with SMTP id l4mr5998492qte.194.1551483739847;
 Fri, 01 Mar 2019 15:42:19 -0800 (PST)
MIME-Version: 1.0
References: <20190301210529.8218-1-daniel@iogearbox.net> <CAPhsuW4J52-hiYTb5X=-qYH-rRChiao26DFTjghf8x6N1xuNeg@mail.gmail.com>
 <e1250fdc-96f7-e020-eaff-7e0b67be9ead@iogearbox.net>
In-Reply-To: <e1250fdc-96f7-e020-eaff-7e0b67be9ead@iogearbox.net>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 1 Mar 2019 15:42:08 -0800
Message-ID: <CAPhsuW6DEUtLMGNgYCOjLOBWQGqiPQ=0XWC4i-QnWRxfBu=CRA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix sanitation rewrite in case of non-pointers
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@fb.com>, afabre@cloudflare.com,
        Marek Majkowski <marek@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 1, 2019 at 3:23 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 03/02/2019 12:18 AM, Song Liu wrote:
> > On Fri, Mar 1, 2019 at 1:06 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >>
> >> Marek reported that he saw an issue with the below snippet in that
> >> timing measurements where off when loaded as unpriv while results
> >> were reasonable when loaded as privileged:
> >>
> >>     [...]
> >>     uint64_t a = bpf_ktime_get_ns();
> >>     uint64_t b = bpf_ktime_get_ns();
> >>     uint64_t delta = b - a;
> >>     if ((int64_t)delta > 0) {
> >>     [...]
> >>
> >> Turns out there is a bug where a corner case is missing in the fix
> >> d3bd7413e0ca ("bpf: fix sanitation of alu op with pointer / scalar
> >> type from different paths"), namely fixup_bpf_calls() only checks
> >> whether aux has a non-zero alu_state, but it also needs to test for
> >> the case of BPF_ALU_NON_POINTER since in both occasions we need to
> >> skip the masking rewrite (as there is nothing to mask).
> >>
> >> Fixes: d3bd7413e0ca ("bpf: fix sanitation of alu op with pointer / scalar type from different paths")
> >> Reported-by: Marek Majkowski <marek@cloudflare.com>
> >> Reported-by: Arthur Fabre <afabre@cloudflare.com>
> >> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> >> Link: https://lore.kernel.org/netdev/CAJPywTJqP34cK20iLM5YmUMz9KXQOdu1-+BZrGMAGgLuBWz7fg@mail.gmail.com/T/
> >> ---
> >>  [ Test case will be routed via bpf-next to avoid useless merge churn
> >>    due to test_verifier rework in bpf-next. ]
> >>
> >>  kernel/bpf/verifier.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 8f295b790297..5fcce2f4209d 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -6920,7 +6920,8 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
> >>                         u32 off_reg;
> >>
> >>                         aux = &env->insn_aux_data[i + delta];
> >> -                       if (!aux->alu_state)
> >> +                       if (!aux->alu_state ||
> >> +                           aux->alu_state == BPF_ALU_NON_POINTER)
> >
> > alu_state is a bitmap. Shall we check "aux->alu_state &
> > BPF_ALU_NON_POINTER" here?
>
> The state in this case can only ever be BPF_ALU_NON_POINTER, any other
> setting from sanitize_val_alu() would be a violation.

I see. Thanks for the explanation.

Acked-by: Song Liu <songliubraving@fb.com>
