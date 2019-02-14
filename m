Return-Path: <SRS0=Lh3l=QV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A95C43381
	for <bpf@archiver.kernel.org>; Thu, 14 Feb 2019 05:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F71B222A4
	for <bpf@archiver.kernel.org>; Thu, 14 Feb 2019 05:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXVUscCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfBNFny (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Feb 2019 00:43:54 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:33593 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfBNFny (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Feb 2019 00:43:54 -0500
Received: by mail-ot1-f45.google.com with SMTP id i20so8636070otl.0;
        Wed, 13 Feb 2019 21:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BY96wzl1hEExBYdOquZB/d2/m4oE/PB1GDw5HdwiVXI=;
        b=NXVUscCwc7HTmXlSvmWS1Qk1pIFHtCg3VTzmj8LKZNwJxBNuVX8Pe8YMBWf2TBDCQ3
         hG1z8ZYpUYxqASKpCYxKIRNYMQ3XlXPCd/A40vw12gI+raVRVdLe62+ENgKO5uu++a5N
         5w8L+mlUfVILHHDT95SIuotCzEYUTb6NiACAXEBQ6sEuXZsmmqnftzGktOYDQ/fdhpzZ
         adza6+giIGQ7c+Ldz+CYVNoszQZXDWgB4IUYcX9Ms/qVEI5zInj54o17RdNKQ1AX6NvN
         OE2HGXn1zcfB0ERocPnLMmnyCK8Aq9+wPnucvThpTiEVllrYnLchuzfLUe6MaaYvaNVu
         VAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BY96wzl1hEExBYdOquZB/d2/m4oE/PB1GDw5HdwiVXI=;
        b=JQrFQJSBdQ/tYSibqk2m7faJJlQzUsofy8+9X93BogCpp/49bDVZA/exPqMMZhRY2E
         RH99FHjtwRwDhN3cz/5dSRTNwqzs8ECO+WXGo/OI+8i2AK0CHHQf8dIL/7IaGm60tIVQ
         073CknDiVixjFuBJLTJ1k6N62bpIxDzmNJriXTCWH4KMGpDyU6OnPti3kG0Y90SC6Fk7
         olUspYxZisTM/eLmZ5ZamM0zN+ZxEFCEKBH1JvJN6oLc0Obds+Ss0I+7rHoHh9BAM/EU
         18XvLy4itPT+62hFAi/H4WaQDjbZiWco1A56QpwIh+sebqv6YGjwbSFfUqzXqznCOgb5
         v34w==
X-Gm-Message-State: AHQUAubtbjFCE5cFcftLRto6XoUkheZXdcNr49PX2EUp/dEg0+dR4xS5
        ZSo3VRwZm+zDVvtUQ9CC77s8daIZwMJLVt9RI1I49A==
X-Google-Smtp-Source: AHgI3IYCJBhrEs7axbxcppjwry27Y+8gRcWytgZf8bhEh4vTXWyOkHRvDFy1oZVkkTk7dN4TPgrOBRinYPldTeayeYg=
X-Received: by 2002:aca:d6cc:: with SMTP id n195mr1266022oig.27.1550123033690;
 Wed, 13 Feb 2019 21:43:53 -0800 (PST)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 13 Feb 2019 21:43:43 -0800
Message-ID: <CAEf4BzYH25Qi=H7woMf-ZHCu=tML=m+atDh+PO=wdNzeNZ2o3w@mail.gmail.com>
Subject: pahole: soliciting naming suggestion for struct btf rename
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin Lau <kafai@fb.com>, bpf@vger.kernel.org,
        dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi folks,

I'm working on adding btf__dedup() support to pahole when doing DWARF
to BTF conversion, which requires usage of libbpf from pahole. I've
already added libbpf as a submodule and pahole now reuses btf.h header
with all the btf struct definitions. Next step is actually using
btf__dedup().

The problem with that is that both libbpf and pahole define their own
incompatible versions of struct btf, which causes a lot of naming
conflicts when I'm trying to use libbpf along those structs. Pahole
has it's own internal library centered around struct btf with lots of
useful methods to manipulate BTF data. My intent is to migrate most of
that functionality (e.g., pretty-printing and BTF types construction)
into libbpf, so maybe in the future pahole won't need it's own struct
btf, but for now I'd like to avoid blocking on that.

So to make progress I'll need to rename pahole's struct btf into
something else. And I've been struggling to come up with good succinct
name. The best I've got so far is btf_info, but I can't say I'm too
happy with it. So consider this email a solicitation for naming
suggestion. Keep in mind, that all the pahole's functions of the form
btf__xxx will be renamed as well for consistency. If you like
btf_info, let me know as well, I'll just stick with it.


-- Andrii
