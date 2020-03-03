Return-Path: <SRS0=fWzt=4U=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB40FC3F2C6
	for <bpf@archiver.kernel.org>; Tue,  3 Mar 2020 04:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B72222B48
	for <bpf@archiver.kernel.org>; Tue,  3 Mar 2020 04:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJlVFGNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCCEKa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 2 Mar 2020 23:10:30 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44401 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgCCEKa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Mar 2020 23:10:30 -0500
Received: by mail-qk1-f193.google.com with SMTP id f198so2083834qke.11;
        Mon, 02 Mar 2020 20:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZUPzltpb1MhPGYawcxqf6E3vIzmzD/aySyYRsUpF78=;
        b=iJlVFGNJrfzqntN1RFQBgHyiOoSnFEqdY7K4SmfS59jcqIUtQcJbUV77Zmm4WRdGZe
         aF/3jdZ4HygLWCNi+zpATNnDIIkY4b3ET077Qm0nbzQPGGRGPyj/zAX0Gvk85VFFdVXQ
         Oq4zrdRpt7amYl5m9u6/KmrUc5zYi7ccCL9oOLIBeN6HzvB3uS1Q4VT2NipOm1zDzCeG
         DYom1QwrZFmLvMpiUydX914kL2H0hOed0fQO3ZnMgG+LkFGQ+dfQatTAIsEoUjtRYuWp
         oMB7JxQZQssSY6MBpZVSOv7Qi7NhquCXiRSU/ZrtvZoENLvk/5OgiZFjW9xrJzMXjfTN
         D1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZUPzltpb1MhPGYawcxqf6E3vIzmzD/aySyYRsUpF78=;
        b=hvviDyhBua+JCvP6mL8rBigsADg+aWssNDTTfXqR3u1ZdtviLh1SeDhwDNrOVdw36j
         OcYDyt6TI50YpCvDMKBqhGd5EcOqpFDABP/E4yRzIg+HJYlyHt+jhDNW423HA453UEr5
         VTFypZW0VrEnDqN21AnJJEigtcnTt75F689Ej3EL61xGPv4bIkZvucJrtmWGqRdgSA7H
         ajam+VG+OWZ77/ob7H0+mZ0WN6yaw/kxgcE55GJML9ReiLf6qERnoF1Yzpn7AK6UVpnl
         fFKkuqyBXz5wvJwLvJKVcTjSjJ3oShzc8N1msc75SRfwIm6ONjy0fkuRiSqPioCwO3jv
         lRcQ==
X-Gm-Message-State: ANhLgQ0+PErvEURxu8soRtbmEBCbf/a00Bs2NJoSXc9GmxUuexZXY0Fh
        S25PGyWNQsUP5mgo0cbre46BR5prhPW5O3vdkTA=
X-Google-Smtp-Source: ADFU+vuDfOkAv1glNnndguGb3d6zO3nERyaQqVyAFqD7BCVmsaKIrsF+DpwmPXSEXIPbJvu8FGPdpwr9w0t/0o5BQ9s=
X-Received: by 2002:a37:a2d6:: with SMTP id l205mr2419825qke.92.1583208628905;
 Mon, 02 Mar 2020 20:10:28 -0800 (PST)
MIME-Version: 1.0
References: <20200301081045.3491005-1-andriin@fb.com> <20200303005951.72szj5sb5rveh4xp@ast-mbp>
In-Reply-To: <20200303005951.72szj5sb5rveh4xp@ast-mbp>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 2 Mar 2020 20:10:17 -0800
Message-ID: <CAEf4BzYsC-5j_+je1pZ_JNsyuPV9_JrLSzpp6tfUvm=3KBNL-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Improve raw tracepoint BTF types preservation
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Wenbo Zhang <ethercflow@gmail.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 2, 2020 at 4:59 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Mar 01, 2020 at 12:10:42AM -0800, Andrii Nakryiko wrote:
> > Fix issue with not preserving btf_trace_##call structs when compiled under
> > Clang. Additionally, capture raw tracepoint arguments in raw_tp_##call
> > structs, directly usable from BPF programs. Convert runqslower to use those
> > for proof of concept and to simplify code further.
>
> Not only folks compile kernel with clang they use the latest BPF/BTF features
> with it. This is very nice to see!
> I've applied 1st patch to make clang compiled kernel emit proper BTF.
>
> As far as patch 2 I'm not sure about 'raw_tp_' prefix. tp_btf type of progs can
> use the same structs. So I think there could be a better name. Also bpftool can
> generate them as well while emitting vmlinux.h. I think that will avoid adding
> few kilobytes to vmlinux BTF that kernel isn't going to use atm.

Fair enough, I'll follow up with bpftool changes to generate such
structs. I'm thinking to use tp_args_xxx name pattern, unless someone
has a better idea :)
