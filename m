Return-Path: <SRS0=zbR4=RA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CB0C43381
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 19:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77212084D
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 19:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNKxxr0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfBYTrb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:47:31 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43322 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfBYTrb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Feb 2019 14:47:31 -0500
Received: by mail-ot1-f68.google.com with SMTP id n71so8923956ota.10;
        Mon, 25 Feb 2019 11:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQMFIwRPfc0CkisY7Z66kLsRDgtv2IpyvT7mH+eLYUo=;
        b=SNKxxr0NGGmSi2MILfNo1PH+lacUj47UR3OF3Nr9VQF6tzzZU2jXn9sxuSMmGEiTpI
         /0qsAvwuwk5BsVFWfRX9VX9i1Pmv5gfH7x31hQVKVt9SjCIbYobrxTxAmWzF55y2oE+f
         oIEhVfMXllbR9IpO/eFdL5E84EHhSYcyRVhWg7u3m8fqHSl+GE5hHVk2ZXoBJGRQpswJ
         DKZ3dpXQKMOLLDfVDlgLn0iQo8/bLQ8N7aiUn71vaWcYgjkobqbd0qECQ3xiMI3QjPRw
         TUlZQ5fTmO+ebb/kZccKzqEHSV4oU2y1QlDifj1pKBvkb3NA5A3feNxAdgpMA+4Q4Zwh
         /kUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQMFIwRPfc0CkisY7Z66kLsRDgtv2IpyvT7mH+eLYUo=;
        b=maqVZ8nk11/BUo4KnB/j4GecuAmfOPGhXXkMnAaIMv8jfpNVbPGs9I2z9oKYG9U/Go
         PfVOzWwQuyPG/EpI6cdBkmX7RWB+VtjPK8gkX7ohExQeKuhVwwkoAuFxStoqBjRynO+V
         7AUPnkOGwBjGdcTcFMjDHZ0lIC/C76vm8z0ZpYW0XjpzDQxiGyYt/AemzMB4pMbPBOdB
         bO7VwI/S8K034XV1WtoQTqKGbMjt/4fEsZbkDwfTkLLQCOn1+90QDKjuOVLoKriciLC9
         VBu+vRzqGKZ4ih4fD9qwuldN27pNTDgQWhAXY514+vXVBT7Y/zYmX01rV/A07wJLXNuT
         8BeQ==
X-Gm-Message-State: AHQUAua2C6oE9f2pI5zSndBG8Bf5rOVp9MPizvnMtpa8lk2zGJRgK58A
        TZmyMGlSUov/rMDTq29kbzt8bQFgFmnzs1nixCqkNZzo
X-Google-Smtp-Source: AHgI3IY0yo6y2JbVS8vjVXVoTJYkXoAWrpoU21MoaXuQlxZI3wf0h9/GZCnWwxcEVse0O0wc7Jyls9y0T4JjbeQhyCs=
X-Received: by 2002:a9d:6a08:: with SMTP id g8mr13700373otn.191.1551124050256;
 Mon, 25 Feb 2019 11:47:30 -0800 (PST)
MIME-Version: 1.0
References: <20190223174422.663270-1-ast@kernel.org> <20190223174422.663270-3-ast@kernel.org>
In-Reply-To: <20190223174422.663270-3-ast@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Feb 2019 11:47:19 -0800
Message-ID: <CAEf4BzZTdk=XhipybR3-y2G6OCLdn2diiwcricO2wcXTcwu6HQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: expose program stats via bpf_prog_info
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     davem@davemloft.net, Daniel Borkmann <daniel@iogearbox.net>,
        edumazet@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 23, 2019 at 9:44 AM Alexei Starovoitov <ast@kernel.org> wrote:
>
> Return bpf program runtime and runcnt via bpf_prog_info
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/uapi/linux/bpf.h | 2 ++
>  kernel/bpf/syscall.c     | 5 +++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index bcdd2474eee7..d2cb85d85b39 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2813,6 +2813,8 @@ struct bpf_prog_info {
>         __u32 jited_line_info_rec_size;
>         __u32 nr_prog_tags;
>         __aligned_u64 prog_tags;
> +       __u64 runtime;
> +       __u64 runcnt;
>  } __attribute__((aligned(8)));
>
>  struct bpf_map_info {
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 9a8c990c5df4..3405e0a4cf77 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2152,6 +2152,7 @@ static int bpf_prog_get_info_by_fd(struct bpf_prog *prog,
>         struct bpf_prog_info __user *uinfo = u64_to_user_ptr(attr->info.info);
>         struct bpf_prog_info info = {};
>         u32 info_len = attr->info.info_len;
> +       struct bpf_prog_stats stats;
>         char __user *uinsns;
>         u32 ulen;
>         int err;
> @@ -2191,6 +2192,10 @@ static int bpf_prog_get_info_by_fd(struct bpf_prog *prog,
>         if (err)
>                 return err;
>
> +       bpf_prog_get_stats(prog, &stats);
> +       info.runtime = stats.nsecs;
> +       info.runcnt = stats.cnt;
> +

lgtm, but see naming discussion in other thread.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>         if (!capable(CAP_SYS_ADMIN)) {
>                 info.jited_prog_len = 0;
>                 info.xlated_prog_len = 0;
> --
> 2.20.0
>
