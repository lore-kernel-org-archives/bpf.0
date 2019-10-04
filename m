Return-Path: <SRS0=CYzr=X5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFDFC4360C
	for <bpf@archiver.kernel.org>; Fri,  4 Oct 2019 22:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D0F222BE
	for <bpf@archiver.kernel.org>; Fri,  4 Oct 2019 22:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNMAp31o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbfJDWWI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 4 Oct 2019 18:22:08 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40733 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfJDWWI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Oct 2019 18:22:08 -0400
Received: by mail-yw1-f66.google.com with SMTP id e205so2882501ywc.7;
        Fri, 04 Oct 2019 15:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vCjiv3b4WL7zIlrmlGB9UhEaVrhlbG+64GDaYrMOVro=;
        b=HNMAp31otHBjxfHeHbaPTpWF4ejiVdNal6lUt8SzHYlY1SevbgTJpcC8PjG9mQq+p7
         UJoy/c7YFOnms3zbm+KIK2fXrJcFdsDVVZ5fYgc6CoL3cmykI7NqghK8gaNp4qZTaXHn
         TadRgCpkyK3Ki395aZsh2EcUIWXgTShDMzOvOWkNNHMkJvr5iBbbG08V1SGkSViosMwu
         oOmqoojc30gDcOuJK67/ENW1OlYSMaF9X5sPglE7iYTGNd7BrIRuWYXFywBycwoUqV4T
         /WReR9dGEy11lVak5xQp66z1fLmljmQfUSjOm1cs3nuFMIZTe+9wR5ljrR4qUodLBh5z
         sfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vCjiv3b4WL7zIlrmlGB9UhEaVrhlbG+64GDaYrMOVro=;
        b=eeGTz9D32Y/cySUkdWpl5pxygk19t7Wk9rKdKRT6RKUx3y6tR3urUPrSU25+SNkHZZ
         x1n3iVwSmbljns9JFOd9g+oA5bhovlzZ31ztouvi93Yj6UoBREH3NliGvNEC8NzJ507p
         mzf1ylqWqEfmk5zgFjcE94o4w1uTydS0VLG2u2giNZdtUTc6Aaw/TShdlj96VQFzEeHD
         8JRIGFUx7EaBZxGV2KfcO4V9S7nWeM7gpDypSbOyzxEmOiyUS1AzUoRicNGzxi7n2Pv0
         WWmMFgC3Y0MDkJnx/iUcGu7Rm/QVFkluh5uPvMPZ6A9Zh4kz2sA6TZZB3yYbLTQT1vLq
         UZvA==
X-Gm-Message-State: APjAAAVlmLl0Sk26Ofbbrfmt2d15RwIgS+gPwi977DkIeBs5CTFsYkX7
        S1KFGkU0s/UDcLu/gtTBKgIrArm4IZyceGtpjw6untwMYQ==
X-Google-Smtp-Source: APXvYqwtga/T/oGm9UJUdesbIR/QWn/MDQohW7YBAVtzDdLFEvIOh+lWlaIn4vnZFe83XXxoxdJJBgCeOTe2fqZz/mA=
X-Received: by 2002:a81:8981:: with SMTP id z123mr13185901ywf.56.1570227726901;
 Fri, 04 Oct 2019 15:22:06 -0700 (PDT)
MIME-Version: 1.0
From:   "Daniel T. Lee" <danieltimlee@gmail.com>
Date:   Sat, 5 Oct 2019 07:21:50 +0900
Message-ID: <CAEKGpzhoYHrE4NTvaWSpy-R6CiLYehGHzLM6v+-9j8iemNyK0g@mail.gmail.com>
Subject: samples/bpf not working?
To:     bpf <bpf@vger.kernel.org>, xdp-newbies@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, building the bpf samples isn't working.
Running make from the directory 'samples/bpf' will just shows following
result without compiling any samples.

$ make
make -C ../../ /git/linux/samples/bpf/ BPF_SAMPLES_PATH=/git/linux/samples/bpf
make[1]: Entering directory '/git/linux'
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
make[1]: Leaving directory '/git/linux'
$ ls *kern.o
ls: cannot access '*kern.o': No such file or directory

By using 'git bisect', found the problem is derived from below commit.
commit 394053f4a4b3 ("kbuild: make single targets work more correctly")

> Currently, the single target build directly descends into the directory
> of the target. For example,
>
>     $ make foo/bar/baz.o
>
> ... directly descends into foo/bar/.
>
> On the other hand, the normal build usually descends one directory at
> a time, i.e. descends into foo/, and then foo/bar/.
>
> This difference causes some problems.
>
> [...]
>
> This commit fixes those problems by making the single target build
> descend in the same way as the normal build does.

Not familiar with kbuild, so I'm not sure why this led to build failure.
My humble guess is, samples/bpf/Makefile tries to run make from current
directory, 'sample/bpf', but somehow upper commit changed the way it works.

samples/bpf/Makefile:232
# Trick to allow make to be run from this directory
all:
        $(MAKE) -C ../../ $(CURDIR)/ BPF_SAMPLES_PATH=$(CURDIR)

I've tried to figure out the problem with 'make --trace', but not sure why
it's not working. Just a hunch with build directory.

Any ideas to fix this problem?
