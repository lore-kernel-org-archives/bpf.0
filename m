Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EC9C10F14
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 20:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7A32075B
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 20:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtS8alTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfDKUgv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:36:51 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34982 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfDKUgu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 16:36:50 -0400
Received: by mail-qt1-f194.google.com with SMTP id h39so8791385qte.2
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2019 13:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZTcVgl85ij88smyro6QfnHZuyCNANN1jr0CMN/LJAdw=;
        b=YtS8alTYUh7+5MA2uluB7qeUU36QLj63SqgwyIgAxgVHNuGbUw0Eqvov7FDA5KzBQV
         vFHAMH57K11KAKhBWLsLc/0FUo/0aKZruoZPWvLSG6MJ2Lc1pYiCJ+T6e6qVupsP6YXe
         2sHrVq0VG+NT4j0UxlNEzbr5mBtRFZlXi2Yuj7+fFJM+yrOQCv1HnB9KrU0HJ96YKUpf
         ypMw34SYYqkyRXF5pmEdILjQbb6T/A8VRmEX3QRyMhsCmc0MIT64Q4MV+Kic5gqo8oh0
         ePogK7QXCP8JeiAGkRMPSUCr8mwwRp41xOi53NPT5WZ4szlxyA4GgxYjC9TVnSM7uYAj
         xhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZTcVgl85ij88smyro6QfnHZuyCNANN1jr0CMN/LJAdw=;
        b=O6lww/ML8luhbZpYFX/wS6tu7pS8Ni2KFu8dULv85zE/XGIpak0W7h3nG57bKjVIOn
         vlqNalHm0HN3IGuNTbEj942tIBwaFuUNFLZdRWKiKz2YaasOxTPiRY1YtK7H52EA7sIG
         B9vYjFmGGXtK73uOBczcVOTCgpuBtmStmU/dltQoTVAfyT7PEZ79cRX8rs9uU+bBrkXB
         ACi6BdiGI3u2hEZ0TLDi61Q6tEL41x9T+cLlrmKfimHMgyqk6vjyqvynJppDMNXccIqT
         MmJj1y2CJu3kH4tI/RTeyJmqqf5xZqKTqqXQT06XEgM1KrD8HHIEkBhgeQs65YJPEwJY
         CQXQ==
X-Gm-Message-State: APjAAAVaVoOZFXMgM8wdnG3DFn5tn8E2V5KbFemRNm97/DUOI1t2u0CG
        mE5SVgRPLnSYiOkFvgnaxveYcp2ojr8QztLAtug=
X-Google-Smtp-Source: APXvYqxrR5QxjfvPWd64+R+GgmhisRi0wOeXb9JxJ1/7JoPuqUeyobwsOFmwRx+3CbffhpMJk/r4EUxCG49njHmfe2c=
X-Received: by 2002:a0c:9624:: with SMTP id 33mr42762836qvx.71.1555015009915;
 Thu, 11 Apr 2019 13:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190410143025.11997-1-bigeasy@linutronix.de> <20190410143025.11997-3-bigeasy@linutronix.de>
In-Reply-To: <20190410143025.11997-3-bigeasy@linutronix.de>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 11 Apr 2019 13:36:38 -0700
Message-ID: <CAPhsuW6qUk1LX5OjFXE-U2gVJnbhnrxik=1p0kYAqyD1xkXHow@mail.gmail.com>
Subject: Re: [PATCH 3/3] bpf: Use spinlock_t in lpm_trie
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On Wed, Apr 10, 2019 at 7:31 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> There is no difference between spinlock_t and raw_spinlock_t for !RT
> kernels. trie_update_elem() will allocate memory while holding ->lock
> which is not possible on RT kernels.

I am new to RT kernel. For !RT kernel, it is OK to hold a lock and call
malloc with GFP_ATOMIC. Is this different for RT kernel?

Thanks,
Song

>
> Make the ->lock a spinlock_t.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/bpf/lpm_trie.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index 93a5cbbde421c..2ceb32452b594 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
> @@ -37,7 +37,7 @@ struct lpm_trie {
>         size_t                          n_entries;
>         size_t                          max_prefixlen;
>         size_t                          data_size;
> -       raw_spinlock_t                  lock;
> +       spinlock_t                      lock;
>  };
>
>  /* This trie implements a longest prefix match algorithm that can be used to
> @@ -318,7 +318,7 @@ static int trie_update_elem(struct bpf_map *map,
>         if (key->prefixlen > trie->max_prefixlen)
>                 return -EINVAL;
>
> -       raw_spin_lock_irqsave(&trie->lock, irq_flags);
> +       spin_lock_irqsave(&trie->lock, irq_flags);
>
>         /* Allocate and fill a new node */
>
> @@ -425,7 +425,7 @@ static int trie_update_elem(struct bpf_map *map,
>                 kfree(im_node);
>         }
>
> -       raw_spin_unlock_irqrestore(&trie->lock, irq_flags);
> +       spin_unlock_irqrestore(&trie->lock, irq_flags);
>
>         return ret;
>  }
> @@ -445,7 +445,7 @@ static int trie_delete_elem(struct bpf_map *map, void *_key)
>         if (key->prefixlen > trie->max_prefixlen)
>                 return -EINVAL;
>
> -       raw_spin_lock_irqsave(&trie->lock, irq_flags);
> +       spin_lock_irqsave(&trie->lock, irq_flags);
>
>         /* Walk the tree looking for an exact key/length match and keeping
>          * track of the path we traverse.  We will need to know the node
> @@ -521,7 +521,7 @@ static int trie_delete_elem(struct bpf_map *map, void *_key)
>         kfree_rcu(node, rcu);
>
>  out:
> -       raw_spin_unlock_irqrestore(&trie->lock, irq_flags);
> +       spin_unlock_irqrestore(&trie->lock, irq_flags);
>
>         return ret;
>  }
> @@ -583,7 +583,7 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
>         if (ret)
>                 goto out_err;
>
> -       raw_spin_lock_init(&trie->lock);
> +       spin_lock_init(&trie->lock);
>
>         return &trie->map;
>  out_err:
> --
> 2.20.1
>
