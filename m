Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436ACC43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 18:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1083920842
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 18:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFLBva0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfCASBn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 13:01:43 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35306 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbfCASBn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 13:01:43 -0500
Received: by mail-oi1-f195.google.com with SMTP id u128so20215161oie.2
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2019 10:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+r82PNNK4S55yUQzJgD/fkG0icmVvlFt/MZlHiovndA=;
        b=EFLBva0RLP5a/haLL2eAdJBRkV8FmWosns5nRq2FrWRX9ZnIocGJUttD0sk4Wzb/+w
         zpifjLtI+Ckv6iqtl9oIR/OQ+puNgrBQ79rpvkzxdpuxtOf29ITXFFI/gI7qHVLIibJ/
         997P4LKdXH6E4vIB3/kAQ21UEhHGo5LxznGYtzerDiMgdwg8ULanxxlUmRfF58oS5Ixq
         mQ+KW0p5RfWteF5f0NhGqIsezyR4j/lm6OP7iCAw0FTYAtfOgxwhYOdoyUhQpG2ktvXY
         QTZ1+hb8HO8S+RwvdrGBFBUYWncQ4rQgMiFUQ8B0euMRqaMfNmUTdvmR5RXiVuZZo12i
         RCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+r82PNNK4S55yUQzJgD/fkG0icmVvlFt/MZlHiovndA=;
        b=TUR1JHxvXWPnVFJpjKa+3YSuqYK+RxUJbFaSsPSHDdm3uddowPgU3IkUJooJJhsSdg
         M/TQJiti50kxrD9BK4UQVoD7o+MF1YuBq3jIqj27RTBkHXnytAF1LMIpKUirchgDF9GO
         kWtBnrXtDiS5AgSWaPegWXYKwKJ0QL4bI1AliFZyWae7zloBcu3nIYHgmGVoqywMRNRb
         HAJyyuwwAwrXeGj+D/7lHH7njBRPc4ZSb5pMILkN3pwbs7hpb1IAVv8TnpmsSqzwFqHW
         dOyyV/bvvB3vnwv2rN0Jg/Kaw4GwQkwvTtVlbKoqK/hmfqI6xWoLmP3P3Kv/YrmDJATC
         be0w==
X-Gm-Message-State: APjAAAUyPio+wYSJ6bJIkQ6EQw5YndNPivpCKXHvb3qad7AkVbpMygo+
        +1RBJxiLeCTdLPDwVBQwfLsN6YSIEbS7XE3PrSiwbw==
X-Google-Smtp-Source: APXvYqzcEXRLSZ+gSa9475qH55naz08aI+0sxYVaf8xECQABgXWhNu4dXXbOnWWBFxbUZ6wX/Yugw13re6mDtYdUj04=
X-Received: by 2002:aca:360a:: with SMTP id d10mr2017174oia.68.1551411250705;
 Thu, 28 Feb 2019 19:34:10 -0800 (PST)
MIME-Version: 1.0
References: <20190228231829.11993-1-daniel@iogearbox.net> <20190228231829.11993-2-daniel@iogearbox.net>
In-Reply-To: <20190228231829.11993-2-daniel@iogearbox.net>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 1 Mar 2019 04:33:44 +0100
Message-ID: <CAG48ez1_LiFVJkTXPhgF_aD+c+20iwzduqb7m13TyShUUwMnUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/7] bpf: implement lookup-free direct value access
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@fb.com>, bpf@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>, joe@wand.net.nz,
        john.fastabend@gmail.com, tgraf@suug.ch, yhs@fb.com,
        andriin@fb.com, jakub.kicinski@netronome.com, lmb@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 1, 2019 at 12:19 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> This generic extension to BPF maps allows for directly loading an
> address residing inside a BPF map value as a single BPF ldimm64
> instruction.
[...]
> @@ -6698,16 +6705,44 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
>                                 return err;
>                         }
>
> -                       /* store map pointer inside BPF_LD_IMM64 instruction */
> -                       insn[0].imm = (u32) (unsigned long) map;
> -                       insn[1].imm = ((u64) (unsigned long) map) >> 32;
> +                       aux = &env->insn_aux_data[i];
> +                       if (insn->src_reg == BPF_PSEUDO_MAP_FD) {
> +                               addr = (unsigned long)map;
> +                       } else {
> +                               u32 off = insn[1].imm;
> +
> +                               if (off >= BPF_MAX_VAR_OFF) {
> +                                       verbose(env, "direct value offset of %u is not allowed\n",
> +                                               off);
> +                                       return -EINVAL;
> +                               }
> +                               if (!map->ops->map_direct_value_access) {
> +                                       verbose(env, "no direct value access support for this map type\n");
> +                                       return -EINVAL;
> +                               }
> +
> +                               err = map->ops->map_direct_value_access(map, off, &addr);
> +                               if (err) {
> +                                       verbose(env, "invalid access to map value pointer, value_size=%u off=%u\n",
> +                                               map->value_size, off);
> +                                       return err;
> +                               }

All these error returns need fdput(f), I think.
