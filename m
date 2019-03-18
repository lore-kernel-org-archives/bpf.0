Return-Path: <SRS0=JidB=RV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CB0C43381
	for <bpf@archiver.kernel.org>; Mon, 18 Mar 2019 19:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BC52133F
	for <bpf@archiver.kernel.org>; Mon, 18 Mar 2019 19:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Flo+udBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfCRT0g (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:26:36 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39990 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfCRT0g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Mar 2019 15:26:36 -0400
Received: by mail-ot1-f65.google.com with SMTP id x8so15484449otg.7;
        Mon, 18 Mar 2019 12:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SD69EsDV/iA/prV2Hn5vb87EVEYPzHwwGfcjzGoLTl0=;
        b=Flo+udBVUIAK8dhlHjX1emE9o6Cnbeg4/71m/t3PCUhZMxh0SIwUOK8G9fQiMyTeZA
         APomqPICij05HhW4jujG7crdgonLA2eWq+qV9q0qpK/Yak15LVtsyXHUEqxi6yZp59fU
         gkJKY9GXdXz2AowFQgoggOPLP1jdxy8a9zW4xCxv6JPdJupacb0wgbElsJZ2S0VcXWXU
         mbd/MGaNyWgj8AKMudljbTL5JrZxa8LHx+LFyH+7HdhFprHccwkNmMjhNNMx+K7gzDVz
         SoVrRTjfPkeXWoQezRs2K+ewJjFGSWqGpvOyKy7bYiW9fOY/aJLuuaU1kY/Gzb4HmGo5
         LPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SD69EsDV/iA/prV2Hn5vb87EVEYPzHwwGfcjzGoLTl0=;
        b=O0OP0tYe/TKvw83luS18Or/mh8RJvGdOPQFYppeWuaKEOZ0pbUUuJ/EHoPNhWlPmES
         6Dp5m05zS01y/ZaO8WiJrshFR+fPPBNgfwE2Vqua2qF+FyD6wGZoWnAGBdaXNRwaTkPA
         VTIk3d1kL1RHpKuloYaDodiwKQKrMCcDEf6kn37IoXuc53lEvyUoDeC/fI7/f1toBtUd
         Eo3S+D4hSeMN3KKdT8c0m2KNLG4PN5VwfU+cDZRiE2ZlsqK5vZYgkgsZpImk33RVICZs
         qnb/0nZYgkyOILuaOyqDvTDwIgf+axs5Q0oAtYDQ3TL9MzzayBTOANrJi/k/UG/LYyJz
         1h7g==
X-Gm-Message-State: APjAAAWVu7kIviR9HeIEQkHvckbwSSzMYtqKvxbIGHiQvMNsEsItS54x
        UOSBjvJd7+CMvkEPOe6EJuAM19vYbh1X0G4EaSA=
X-Google-Smtp-Source: APXvYqzox986heckYfWc1bMW3MBZLjSAl2BH7d7GmhrAihL0W+NERXBjUO+uA9O17dqsI89LiMkDyTxiVjW12IRpNRQ=
X-Received: by 2002:a9d:2921:: with SMTP id d30mr12087951otb.75.1552937195378;
 Mon, 18 Mar 2019 12:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190318173713.1413282-1-kafai@fb.com>
In-Reply-To: <20190318173713.1413282-1-kafai@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 18 Mar 2019 12:26:23 -0700
Message-ID: <CAEf4BzatDZwO+AJ6NUfk3hGptg=9e1N5v0U+T1w2KHaB2NCjAQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Only print ref_obj_id for refcounted reg
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 18, 2019 at 10:37 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> Naresh reported that test_align fails because of the mismatch at the
> verbose printout of the register states.  The reason is due to the newly
> added ref_obj_id.
>
> ref_obj_id is only useful for refcounted reg.  Thus, this patch fixes it
> by only printing ref_obj_id for refcounted reg.  While at it, it also uses
> comma instead of space to separate between "id" and "ref_obj_id".
>
> Fixes: 1b986589680a ("bpf: Fix bpf_tcp_sock and bpf_sk_fullsock issue related to bpf_sk_release")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> ---
>  kernel/bpf/verifier.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 86f9cd5d1c4e..5aa810882583 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -352,6 +352,14 @@ static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
>                 map_value_has_spin_lock(reg->map_ptr);
>  }
>
> +static bool reg_type_may_be_refcounted_or_null(enum bpf_reg_type type)
> +{
> +       return type == PTR_TO_SOCKET ||
> +               type == PTR_TO_SOCKET_OR_NULL ||
> +               type == PTR_TO_TCP_SOCK ||
> +               type == PTR_TO_TCP_SOCK_OR_NULL;
> +}
> +
>  static bool arg_type_may_be_refcounted(enum bpf_arg_type type)
>  {
>         return type == ARG_PTR_TO_SOCK_COMMON;
> @@ -451,8 +459,9 @@ static void print_verifier_state(struct bpf_verifier_env *env,
>                         if (t == PTR_TO_STACK)
>                                 verbose(env, ",call_%d", func(env, reg)->callsite);
>                 } else {
> -                       verbose(env, "(id=%d ref_obj_id=%d", reg->id,
> -                               reg->ref_obj_id);
> +                       verbose(env, "(id=%d", reg->id);
> +                       if (reg_type_may_be_refcounted_or_null(t))
> +                               verbose(env, ",ref_obj_id=%d", reg->ref_obj_id);
>                         if (t != SCALAR_VALUE)
>                                 verbose(env, ",off=%d", reg->off);
>                         if (type_is_pkt_pointer(t))
> --
> 2.17.1
>

lgtm

Acked-by: Andrii Nakryiko <andriin@fb.com>
