Return-Path: <SRS0=/C52=4N=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABABC35DF5
	for <bpf@archiver.kernel.org>; Tue, 25 Feb 2020 05:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F43B24684
	for <bpf@archiver.kernel.org>; Tue, 25 Feb 2020 05:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582608203;
	bh=OUys935WafGU+9wqEFaMaYLSN4lzU4q6H5B6BJNWGLE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=crE6SJhWAFdl2Iu31IrJQB4s5STY299BbOOeYZthsbBbbHapXtH8SUZ+y4FF9XCRg
	 abB7EgDT12nwL2gLbcIVbJu4ma12MRolraxOVmCYb25YgouRGl0aS96/7oMILjfrWg
	 CvqpG5jJjilth401PPkdR1gR3ipFuDWrnjlqssjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgBYFXX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 25 Feb 2020 00:23:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:32994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgBYFXW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Feb 2020 00:23:22 -0500
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A838C24684;
        Tue, 25 Feb 2020 05:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582608202;
        bh=OUys935WafGU+9wqEFaMaYLSN4lzU4q6H5B6BJNWGLE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PRORRqwLDKy/QR20Wy5mxEaQ01R0pnsCTk10FUTAhyb+lIf9OgDwniPDNlN+477US
         KW4x9kKZVMYwevwBjPZT/J2hNTyzrz0F4W60cYoUISfZdHXGB2DLfxHjJcUjpBC/LO
         beGPEKuoDAuS8hZmTpAscZTNx71diQ86GI1K1jWI=
Received: by mail-lf1-f50.google.com with SMTP id n25so8706514lfl.0;
        Mon, 24 Feb 2020 21:23:21 -0800 (PST)
X-Gm-Message-State: APjAAAUasZiPz4RZ7e1lrSSSNxkE3CpI3bITEPs36lI0oIPA+RY6tVk7
        gFrrQgkXTy8L64G0fN/jqwxcUkw6B3SSviWdNio=
X-Google-Smtp-Source: APXvYqxRTwf2EAeNtL4qtSThRVznmUiIUd2IZhMFfzJRa9PJ2Mh/PHXJQPHyi68U0ZBMDI+XswLkEpWiNvt87le9Ddo=
X-Received: by 2002:a19:9155:: with SMTP id y21mr15294839lfj.28.1582608199686;
 Mon, 24 Feb 2020 21:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20200221184650.21920-1-kafai@fb.com> <20200221184709.23890-1-kafai@fb.com>
In-Reply-To: <20200221184709.23890-1-kafai@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 24 Feb 2020 21:23:08 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6avDmaAnzVFE2J=22TRxcwrLSor-RzHgTnkmG9BniB3w@mail.gmail.com>
Message-ID: <CAPhsuW6avDmaAnzVFE2J=22TRxcwrLSor-RzHgTnkmG9BniB3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: INET_DIAG support in bpf_sk_storage
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Kernel Team <kernel-team@fb.com>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 21, 2020 at 10:47 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> This patch adds INET_DIAG support to bpf_sk_storage.
>
> 1. Although this series adds bpf_sk_storage diag capability to inet sk,
>    bpf_sk_storage is in general applicable to all fullsock.  Hence, the
>    bpf_sk_storage logic will operate on SK_DIAG_* nlattr.  The caller
>    will pass in its specific nesting nlattr (e.g. INET_DIAG_*) as
>    the argument.
>
> 2. The request will be like:
>         INET_DIAG_REQ_SK_BPF_STORAGES (nla_nest) (defined in latter patch)
>                 SK_DIAG_BPF_STORAGE_REQ_MAP_FD (nla_put_u32)
>                 SK_DIAG_BPF_STORAGE_REQ_MAP_FD (nla_put_u32)
>                 ......
>
>    Considering there could have multiple bpf_sk_storages in a sk,
>    instead of reusing INET_DIAG_INFO ("ss -i"),  the user can select
>    some specific bpf_sk_storage to dump by specifying an array of
>    SK_DIAG_BPF_STORAGE_REQ_MAP_FD.
>
>    If no SK_DIAG_BPF_STORAGE_REQ_MAP_FD is specified (i.e. an empty
>    INET_DIAG_REQ_SK_BPF_STORAGES), it will dump all bpf_sk_storages
>    of a sk.
>
> 3. The reply will be like:
>         INET_DIAG_BPF_SK_STORAGES (nla_nest) (defined in latter patch)
>                 SK_DIAG_BPF_STORAGE (nla_nest)
>                         SK_DIAG_BPF_STORAGE_MAP_ID (nla_put_u32)
>                         SK_DIAG_BPF_STORAGE_MAP_VALUE (nla_reserve_64bit)
>                 SK_DIAG_BPF_STORAGE (nla_nest)
>                         SK_DIAG_BPF_STORAGE_MAP_ID (nla_put_u32)
>                         SK_DIAG_BPF_STORAGE_MAP_VALUE (nla_reserve_64bit)
>                 ......
>
> 4. Unlike other INET_DIAG info of a sk which is pretty static, the size
>    required to dump the bpf_sk_storage(s) of a sk is dynamic as the
>    system adding more bpf_sk_storage_map.  It is hard to set a static
>    min_dump_alloc size.
>
>    Hence, this series learns it at the runtime and adjust the
>    cb->min_dump_alloc as it iterates all sk(s) of a system.  The
>    "unsigned int *res_diag_size" in bpf_sk_storage_diag_put()
>    is for this purpose.
>
>    The next patch will update the cb->min_dump_alloc as it
>    iterates the sk(s).
>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>
