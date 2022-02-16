Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E140C433EF
	for <bpf@archiver.kernel.org>; Wed, 16 Feb 2022 01:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244884AbiBPBxV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 15 Feb 2022 20:53:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiBPBxU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 20:53:20 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BADE6C911;
        Tue, 15 Feb 2022 17:53:09 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id p23so811051pgj.2;
        Tue, 15 Feb 2022 17:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZAMjIvL+hpUmDfVkVf5/qgvDnx4jubeR1ua4o0tFm+k=;
        b=YiiccNK1M6GKCSsNp6AjortQjm97RCI8XtIMX1QklLG1Hj7oFs1a+GUbXvaVh3I3D+
         5YOewmjAZQGVLduNzF2gD4/BkA0VDkxS6HvIvy7mLVR1nuQeuRBv4DLfXvHZ2E69Lwpv
         zXnpoHrsgSKuhsoMngGjlKgEGpCG5mN0ORXGXO/BHCNdk5atRvNJbuaiqGsaghp4XlUY
         wkCcRetzDm5VDbEsAkb2ayDA3FJ/tFWouKDgFm2rYlQoJxqgsxYMWvKxlntnJq7PI+YB
         hjLFngSymngeDzLCo2sQen/hZ0iOCe0lvDrw+kkmvvFZlJpcX3qSC103LrDVIPjomTbm
         4RMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZAMjIvL+hpUmDfVkVf5/qgvDnx4jubeR1ua4o0tFm+k=;
        b=3Im/pzsQ9CMMwy+wKjAxTeFGEtpB9GsmGLbnJb61dIqAwTWp2Rcpy++ucHUL/xjFaC
         g/cjHJY9cNkmL8cKNzj1f1lGHPnTkvynopmxjH9c5YV9fHlxovmmGjg2JzZjkIsUhLy5
         8IjaQDsyDXZAeu3/gqBdiWjYDmimx4YfBPcM0HsZ4OPran+rME+qBNnJCGMUF6XK6HOL
         BEb8JmIhjGd6TLLHinu9D5iCSR9SVjjfNODWnpt7qtZMcYvpKc+/2P3PEZV2yq+wjfgj
         m8539HWGB2QKyXC4Q8iO03pxL4SBw8ukYOIqnWwIXm+QOnRT8UNpk/QAdNJvakyy5OSA
         UzoQ==
X-Gm-Message-State: AOAM531GQmZXOvPFoa+pPPP09i6sRElle3uKsN5777wsXiJgKj4lnLlo
        0538cercrNOE7vOkgmbUk9Db1Zrn4GSUpL4Otd8=
X-Google-Smtp-Source: ABdhPJyc3TN66yTT3pYztxrFtE/4/UY3Q+GuCorhWVGRynD9FJHvsCi3OW8AqyUNw8xE1cTR01m2Vv7tXDblfLpw5GQ=
X-Received: by 2002:a62:754d:0:b0:4c7:f5db:5bd7 with SMTP id
 q74-20020a62754d000000b004c7f5db5bd7mr890456pfc.46.1644976388853; Tue, 15 Feb
 2022 17:53:08 -0800 (PST)
MIME-Version: 1.0
References: <20220215225856.671072-1-mauricio@kinvolk.io> <20220215225856.671072-2-mauricio@kinvolk.io>
In-Reply-To: <20220215225856.671072-2-mauricio@kinvolk.io>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 15 Feb 2022 17:52:57 -0800
Message-ID: <CAADnVQ+WdxFzK9mZVO8tpRy_U=oKKUkX23KBWJWftqhuZRt9vA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 1/7] libbpf: split bpf_core_apply_relo()
To:     =?UTF-8?Q?Mauricio_V=C3=A1squez?= <mauricio@kinvolk.io>
Cc:     Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        Lorenzo Fontana <lorenzo.fontana@elastic.co>,
        Leonardo Di Donato <leonardo.didonato@elastic.co>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 15, 2022 at 2:59 PM Mauricio V=C3=A1squez <mauricio@kinvolk.io>=
 wrote:
>
> BTFGen needs to run the core relocation logic in order to understand
> what are the types involved in a given relocation.
>
> Currently bpf_core_apply_relo() calculates and **applies** a relocation
> to an instruction. Having both operations in the same function makes it
> difficult to only calculate the relocation without patching the
> instruction. This commit splits that logic in two different phases: (1)
> calculate the relocation and (2) patch the instruction.
>
> For the first phase bpf_core_apply_relo() is renamed to
> bpf_core_calc_relo_insn() who is now only on charge of calculating the
> relocation, the second phase uses the already existing
> bpf_core_patch_insn(). bpf_object__relocate_core() uses both of them and
> the BTFGen will use only bpf_core_calc_relo_insn().
>
> Signed-off-by: Mauricio V=C3=A1squez <mauricio@kinvolk.io>
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@aquasec.com>
> Signed-off-by: Lorenzo Fontana <lorenzo.fontana@elastic.co>
> Signed-off-by: Leonardo Di Donato <leonardo.didonato@elastic.co>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Alexei Starovoitov <ast@kernel.org>
