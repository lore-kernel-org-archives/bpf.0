Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74939C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A43C204FD
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5xvDAjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbfB1SSB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:18:01 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39862 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfB1SSA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 13:18:00 -0500
Received: by mail-qt1-f193.google.com with SMTP id o6so24616160qtk.6;
        Thu, 28 Feb 2019 10:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sCLvg686TK14bQZQPKohbNzEJk3UWeH6gk8/U9rokg8=;
        b=p5xvDAjlICUbY6nxVsWiUNpsYRRqrPfI6iUI7X9W3FbxJFghAV39x0T0WeqxUpfrDQ
         aOxS2RX8ZzfRmVoDn0t65ronuS//ZtnbC2Iy8XROzHMa952xBPHsKAQMEg4ll6ohq7z+
         TlgJzYTxmSqrUZulfRJPB2kn60j+r/BPoIifrjUpmJzsYFEsGNiUL3iwbZNPkYRtb5Bt
         HSZ122cRggfnA+KWZw9AnFce7Jhz0g/nrz/6tkzpuKL2qXUZewTvyPIAhPPlnarXizl+
         qcIgElZXlzS+dfjfVcO8ZpwuM12iToEtGzOR8aQcR/oMwCd+1RcuiI/4Dr6Bqdk7nyBa
         PdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sCLvg686TK14bQZQPKohbNzEJk3UWeH6gk8/U9rokg8=;
        b=QAn/w/DjVwfeFufOWXaZBY1O/zfQPEGQWLA1UlZnEd80leymK3GPT7plXgHLKpVscl
         /diTJQit2nJxZLLza3yq3fUGgHTzkFtKbDyXClbZ2eJdhUacZycjE6XV58DZsHwwunYD
         X2EpImmw7zapF8WqyVo/73ovtbi2I7gDPEWO11+JwaYXPXrRte3PKQKRAATKl/GRtMas
         3K/qGRx5MATPKldDdY8llZaKw5cqcq8Kf23dD3RvtjOoxZZZn+l6HTp6oa5HKKbzxI16
         oRoY0a60bfB9flsG2vyU2oilY8XMVUs3lrFKmOUMLVZjF8JPISMd6qagi9WHh1hHuEIW
         zuMA==
X-Gm-Message-State: APjAAAVVE83Jjvc+CKeE5pKxg5ay52ivjtYzMkzednRuGqptEPcdTBha
        XygkCIYV9ZZpA6jfCyj/04NfEqWDvL2YihdilEV+rQZ+
X-Google-Smtp-Source: APXvYqxmGmFCdiL+jOWdo45ztPMi/DW9lIc0k+x4CpXWdG79544gmUiUExldRFBd5e1gAwgx+4ox3f7+/owxB87/fxM=
X-Received: by 2002:a0c:b0cb:: with SMTP id p11mr379732qvc.239.1551377879923;
 Thu, 28 Feb 2019 10:17:59 -0800 (PST)
MIME-Version: 1.0
References: <20190227224642.1069138-1-andriin@fb.com> <20190227224642.1069138-3-andriin@fb.com>
In-Reply-To: <20190227224642.1069138-3-andriin@fb.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 28 Feb 2019 10:17:48 -0800
Message-ID: <CAPhsuW713kKghMmocWmybKHjjC0N5u56-_gP63HNvOF1pObQPA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] libbpf: fix formatting for btf_ext__get_raw_data
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com, ast@fb.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 27, 2019 at 2:47 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> Fix invalid formatting of pointer arg.
>
> Fixes: ae4ab4b4117d ("btf: expose API to work with raw btf_ext data")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  tools/lib/bpf/btf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 94bbc249b0f1..b60bb7cf5fff 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -76,7 +76,7 @@ LIBBPF_API int btf__get_map_kv_tids(const struct btf *btf, const char *map_name,
>
>  LIBBPF_API struct btf_ext *btf_ext__new(__u8 *data, __u32 size);
>  LIBBPF_API void btf_ext__free(struct btf_ext *btf_ext);
> -LIBBPF_API const void *btf_ext__get_raw_data(const struct btf_ext* btf_ext,
> +LIBBPF_API const void *btf_ext__get_raw_data(const struct btf_ext *btf_ext,
>                                              __u32 *size);
>  LIBBPF_API int btf_ext__reloc_func_info(const struct btf *btf,
>                                         const struct btf_ext *btf_ext,
> --
> 2.17.1
>
