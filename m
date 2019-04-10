Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63F2C10F0E
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 00:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8273821741
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 00:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0QbR3TV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfDJAKr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:10:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35645 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfDJAKr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 20:10:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id t4so408728ljc.2;
        Tue, 09 Apr 2019 17:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lLVdpZt0xs5Tq6oUvQQqIz5leWcf5Bpd6abDo8EfAQE=;
        b=M0QbR3TV5X47c3/0xlG3d3W/5PbRKM4uIHL48fxqxm424kwEPZht9W8YDfoMHTETGJ
         Lxk7dORDbNIjd/7GRViofTT+4szJy+/FYJFiODrZZ+JzvUy1bAnET1yBp/bKQQTVMmff
         hvBLPVKZQD/2MAwG10iUWTLnR4tYNfB+oSWQq6UK9yQiyxA4hkZwqOHIIYdUYAybMZ5w
         lAtjcOzXinWJX6nUnkVOCZiPx50XFbCs0VlhUecChjQ67BS8kNzm+w0xE4TDnyHlxLlR
         6HsDh91V37ogzJeuhZHrbVLD6dB57WBFxF1zB2xWju37SHt+B8uy/zQ0zFO3acW8MseR
         nlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lLVdpZt0xs5Tq6oUvQQqIz5leWcf5Bpd6abDo8EfAQE=;
        b=bluzhb1c4fdaco+0Gg9lzdHSpK6r4BRapXKpBWBvHY1quDQbUAvdle1PvzobgH7Tjp
         IxfinwIJ6puzLmOuK7huHQaR2AqN+2Cajbj0bm/E2Ped2RgVa4MWU+ibFOhejgvjljn2
         koQN3NiGy5STgv0jcEiGQxTb8PU4Em4XgPd6OsMWoOeZX3sreLTVJcJo44hZrv/NyS5j
         GTNcEHtYSzAoQKY2IkcELihxaoPvtpb75aFKbgaEH4kSwtjmBgdZdixqA+XnEr7QkPzr
         1VxCPRzYr5I4C82H5t4W2wS0bRTBz55oD8GYXA7T6//LUask1vxq6+cGlnPjUJgOKj/H
         SIfA==
X-Gm-Message-State: APjAAAU5qYbjgKe3XsK23zHlR4A9NduySqUyGF2zl0uSFR3c5bP+XA1S
        lkYq35pzTPi0y89zNgQlyVNxloin5uTo8RS0l/g=
X-Google-Smtp-Source: APXvYqyNj+4iesEpQxspGNqhYnRK+IbC1HZsAhG/M9DOkbQEDjEX7YNauJKudc68izB9gjFzLiOY4WdpOa0eWvaQrnU=
X-Received: by 2002:a2e:864f:: with SMTP id i15mr22697451ljj.99.1554855044897;
 Tue, 09 Apr 2019 17:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190409210910.32048-1-daniel@iogearbox.net>
In-Reply-To: <20190409210910.32048-1-daniel@iogearbox.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 9 Apr 2019 17:10:33 -0700
Message-ID: <CAADnVQKaPEi5-vjG_fvt0o8e9b9wAC665++3s48sD2h0qLhoiQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 00/16] BPF support for global data
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Joe Stringer <joe@wand.net.nz>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 9, 2019 at 2:09 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> This series is a major rework of previously submitted libbpf
> patches [0] in order to add global data support for BPF. The
> kernel has been extended to add proper infrastructure that allows
> for full .bss/.data/.rodata sections on BPF loader side based
> upon feedback from LPC discussions [1]. Latter support is then
> also added into libbpf in this series which allows for more
> natural C-like programming of BPF programs. For more information
> on loader, please refer to 'bpf, libbpf: support global data/bss/
> rodata sections' patch in this series.
>
> Thanks a lot!
>
>   v5 -> v6:
>    - Removed synchronize_rcu() from map freeze (Jann)
>    - Rest as-is
>   v4 -> v5:
>    - Removed index selection again for ldimm64 (Alexei)
>    - Adapted related test cases and added new ones to test
>      rejection of off != 0
>   v3 -> v4:
>    - Various fixes in BTF verification e.g. to disallow
>      Var and DataSec to be an intermediate type during resolve (Martin)
>    - More BTF test cases added
>    - Few cleanups in key-less BTF commit (Martin)
>    - Bump libbpf minor version from 2 to 3
>    - Renamed and simplified read-only locking
>    - Various minor improvements all over the place
>   v2 -> v3:
>    - Implement BTF support in kernel, libbpf, bpftool, add tests
>    - Fix idx + off conversion (Andrii)
>    - Document lower / higher bits for direct value access (Andrii)
>    - Add tests with small value size (Andrii)
>    - Add index selection into ldimm64 (Andrii)
>    - Fix missing fdput() (Jann)
>    - Reject invalid flags in BPF_F_*_PROG (Jakub)
>    - Complete rework of libbpf support, includes:
>     - Add objname to map name (Stanislav)
>     - Make .rodata map full read-only after setup (Andrii)
>     - Merge relocation handling into single one (Andrii)
>     - Store global maps into obj->maps array (Andrii, Alexei)
>     - Debug message when skipping section (Andrii)
>     - Reject non-static global data till we have
>       semantics for sharing them (Yonghong, Andrii, Alexei)
>     - More test cases and completely reworked prog test (Alexei)
>    - Fixes, cleanups, etc all over the set
>    - Not yet addressed:
>     - Make BTF mandatory for these maps (Alexei)
>     -> Waiting till BTF support for these lands first
>   v1 -> v2:
>     - Instead of 32-bit static data, implement full global
>       data support (Alexei)
>
>   [0] https://patchwork.ozlabs.org/cover/1040290/
>   [1] http://vger.kernel.org/lpc-bpf2018.html#session-3

Applied to bpf-next. Thanks!
