Return-Path: <SRS0=CYzr=X5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAE5C4360C
	for <bpf@archiver.kernel.org>; Fri,  4 Oct 2019 05:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C462133F
	for <bpf@archiver.kernel.org>; Fri,  4 Oct 2019 05:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAej/k4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfJDFdq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 4 Oct 2019 01:33:46 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39747 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfJDFdq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Oct 2019 01:33:46 -0400
Received: by mail-qk1-f196.google.com with SMTP id 4so4748212qki.6;
        Thu, 03 Oct 2019 22:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CZLbsNalEDLVCI/uyy17hqZrVOedmz8hzfFbWaNkEoA=;
        b=nAej/k4+z1Dm02vuaLnHSKcMV5iipe+F6PLhJjCKK1mVn1s+CZNaDQxAnf1RShtMXl
         L9Bvu2bQlja1Ky3h80h9PlYjTov6XVmqdGsSRGTGWDOskkcBAxEY4i3LRKa2M+GUAuTj
         JZ6gQ0h/xPN3pkZa6Cu9TuzoJo7JCwz8bLKHzYbd3QZ4FswX1eYGmHdj5CnPq5NcqlVE
         cTtrzNEo22iamXGtEHpBVR8RD8b22Zdx6UUGmGdGZWRMkLIEF5I54ziFYwotKAC2+QO+
         8cOPgSi4BSkxLLFcUap97dr9E7CJ/zIcvKncOmceI5ybtOtQTnrhed3aLMHGGnWxwxUN
         gQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZLbsNalEDLVCI/uyy17hqZrVOedmz8hzfFbWaNkEoA=;
        b=OM6OaJLYXysWLn7TeV9ropUMI1DjL3At0ingNiYMni6+6bOBkQZq5fFMgyNv/IZIbb
         K1YUSokix03hYB+duGiOh2aztJWXGiVYwPG6nGBbOAkv1Z8nis+WQB08NAs842Qzm9H1
         oSUthIKg14ZGkCVm0Tlp+eNwFmnDL+9QUrYa+mZtR00AMtVJ7fp1Vgfsxezjf9JqNV2n
         FunOqM5jN95LSNPO9fZ1Te0POtU+YElV3K5vH1izojg7O2pbVxVt95wvC9huzJXCCD8V
         77l4m0S4bQhPecxWM9GAq8ZUFl6abphU3OqD2hf//fs6JFvYY7d+WlgKsd3naj3oT7Db
         3u7w==
X-Gm-Message-State: APjAAAV5koySArqt5jNxGcDT4ddQL/EvL1EHzvfw0otiGTg0+jPCF0SF
        xUdyCT0i9zH8Bs6FXS5kBDUG4gWlCry70OwBDiA=
X-Google-Smtp-Source: APXvYqzI9QQfZCdw4JMz5OdOIUQqx8h53GM09GvJBjZc8tqHdWJnQ11RnG6jvgDr0Wx9k8K5vYsmRbl09ENLMgQ/whE=
X-Received: by 2002:a37:4e55:: with SMTP id c82mr8474072qkb.437.1570167225468;
 Thu, 03 Oct 2019 22:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191004052922.2701794-1-andriin@fb.com>
In-Reply-To: <20191004052922.2701794-1-andriin@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 3 Oct 2019 22:33:34 -0700
Message-ID: <CAEf4BzZFGv_2gvckoVMO1i5h7BBx74ZqC4qDKyQkyELj5_Kvbw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Add new-style bpf_object__open APIs
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 3, 2019 at 10:29 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> Add bpf_object__open_file() and bpf_object__open_mem() APIs that use a new
> approach to providing future-proof non-ABI-breaking API changes. It relies on
> APIs accepting optional self-describing "opts" struct, containing its own
> size, filled out and provided by potentially outdated (as well as
> newer-than-libbpf) user application. A set of internal helper macros
> (OPTS_VALID, OPTS_HAS, and OPTS_GET) streamline and simplify a graceful
> handling forward and backward compatibility for user applications dynamically
> linked against different versions of libbpf shared library.
>
> Users of libbpf are provided with convenience macro LIBBPF_OPTS that takes
> care of populating correct structure size and zero-initializes options struct,
> which helps avoid obscure issues of unitialized padding. Uninitialized padding
> in a struct might turn into garbage-populated new fields understood by future
> versions of libbpf.
>
> Patch #3 switches two of test_progs' tests to use new APIs as a validation
> that they work as expected.
>
> v1->v2:
> - use better approach for tracking last field in opts struct;
> - convert few tests to new APIs for validation;
> - fix bug with using offsetof(last_field) instead of offsetofend(last_field).
>
> Andrii Nakryiko (3):
>   libbpf: stop enforcing kern_version, populate it for users
>   libbpf: add bpf_object__open_{file,mem} w/ extensible opts
>   selftests/bpf: switch tests to new bpf_object__open_{file,mem}() APIs
>
>  tools/lib/bpf/libbpf.c                        | 128 +++++++++---------
>  tools/lib/bpf/libbpf.h                        |  38 +++++-
>  tools/lib/bpf/libbpf.map                      |   3 +
>  tools/lib/bpf/libbpf_internal.h               |  32 +++++
>  tools/testing/selftests/bpf/Makefile          |   2 +-
>  .../selftests/bpf/prog_tests/attach_probe.c   |  42 +++++-
>  .../bpf/prog_tests/reference_tracking.c       |   7 +-
>  .../selftests/bpf/progs/test_attach_probe.c   |   1 -
>  .../bpf/progs/test_get_stack_rawtp.c          |   1 -
>  .../selftests/bpf/progs/test_perf_buffer.c    |   1 -
>  .../selftests/bpf/progs/test_stacktrace_map.c |   1 -
>  11 files changed, 176 insertions(+), 80 deletions(-)
>
> --
> 2.17.1
>

Sorry for the spam! Forgot to bump to v2 in subject prefix, re-sending
v2 with correct prefix.
