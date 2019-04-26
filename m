Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5FFC43218
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 04:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35348206BF
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 04:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlI3fsvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbfDZEs0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 00:48:26 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38721 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfDZEs0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Apr 2019 00:48:26 -0400
Received: by mail-lf1-f66.google.com with SMTP id v1so1455302lfg.5;
        Thu, 25 Apr 2019 21:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMpriMfs1JQF4TIyiCv0x6TKf/baxrE/Ukptf+3iB68=;
        b=mlI3fsvIwj/g6fos9OUakZGwawNVNi/ADqWpp/3T54S6rCqieEQZkY0hId2R0XWJ8N
         Y7rS8JFyTLHzeC1eERvHZkfqPhks0fOtf1f34li8l5Tly+Cjx/HPWW5qjQsLo8qNfgKW
         ulYAD7InI8h2F54P0RRoABnMt4A4qpJV8iHBD+WmUIcDmcOn67C3Qd9yqE0pwKTan8wb
         eVOsxHcapodBWUQglkFtEvBViB6jTrcDINNELKwOiibv5FOfhRNY2M58Thoh92kAJVP2
         tLYt0xuE+BBNDYzoVaP57pBt/OOPtHmeE4L+qPSz7OzrHIWEjQ06jK3uU3TxYhI9Doi0
         0UnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMpriMfs1JQF4TIyiCv0x6TKf/baxrE/Ukptf+3iB68=;
        b=bcSbaaxtLT7LnYwcH3kJXB4vU2NmC0Z3M1mDreseVFPedwWY8u6f6ixWkEDUYAcGOr
         7RslzImWZ5OZB9vVnFY9QabbcyCcvt4o4Z0b+umIXo8amlvuTQE3xEfFnJ2uts4r8GkL
         71sRyD0RXQ2DvpOHnoR3oYZ/529IliKDpfvOyKkcIxmaTivBTlHQ1ObSSJgRfYrRLEpR
         kAw566sYS5sxlUCwbb525dsL1RqhDazIBEPNJk8elmU6HpS2+vNmTCUqtDih+ZZz1M/J
         wlxgJ2wQ0q7q9wUsZ2AYxiWIaPFvr4HFBgEvG6w+Fr/KxYpe1wdzaAhCV7yudWm6kLnh
         Pk5A==
X-Gm-Message-State: APjAAAUUEdtRijLp4v21fmPglq8RNJTYNmEl1vp+G4I8NwAm6YC1KDvz
        na/vFL0ferM/ZAX5h63dFBa2KJM+/VJ2SexjYmA=
X-Google-Smtp-Source: APXvYqzTfy72/njReTegtxsXlwX+x7rLcBg3dTx0qh1KVBbhTvIb6t5+QrRh5/On7sabW2fpJU5GChcQDgeGUw8dNyg=
X-Received: by 2002:a19:c216:: with SMTP id l22mr22563716lfc.112.1556254104316;
 Thu, 25 Apr 2019 21:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190425223011.284686-1-andriin@fb.com>
In-Reply-To: <20190425223011.284686-1-andriin@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 25 Apr 2019 21:48:12 -0700
Message-ID: <CAADnVQLZvrMD__RDtyQfS0bEJ+Q61ax62gMLuEjNyt+XqGzsMQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 0/4] add btf dumping to bpftool
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 25, 2019 at 4:08 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> This patch set adds a new `bpftool btf dump` sub-command, which allows to dump
> BTF contents (only types for now). Currently it only outputs low-level
> content, almost 1:1 with binary BTF format, but follow up patches will add
> ability to dump BTF types as a compilable C header file. JSON output is
> supported as well.
>
> Patch #1 adds `btf` sub-command, dumping BTF types in human-readable format.
> It also implements reading .BTF data from ELF file.
> Patch #2 adds minimal documentation with output format examples and different
> ways to specify source of BTF data.
> Patch #3 adds support for btf command in bash-completion/bpftool script.
> Patch #4 fixes minor indentation issue in bash-completion script.
>
> Output format is mostly following existing format of BPF verifier log, but
> deviates from it in few places. More details are in commit message for patch
> #1.
>
> Example of output for all supported BTF kinds are in patch #2 as part of
> documentation. Some field names are quite verbose and I'd rather shorten them,
> if we don't feel like being very close to BPF verifier names is a necessity,
> but in this patch I left them exactly the same as in verifier log.
>
> v3->v4:
>   - reverse Christmas tree (Quentin)
>   - better docs (Quentin)
>
> v2->v3:
>   - make map's key|value|kv|all suggestion more precise (Quentin)
>   - fix default case indentations (Quentin)
>
> v1->v2:
>   - fix unnecessary trailing whitespaces in bpftool-btf.rst (Yonghong)
>   - add btf in main.c for a list of possible OBJECTs
>   - handle unknown keyword under `bpftool btf dump` (Yonghong)

Applied. Thanks!
