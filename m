Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A643382E1
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238486; cv=none; b=NsnJCzx7+m5Hoy3Vg3HiubvM5BJOKxsCSy6/TENVkCNMSxwQ6xp+GdZNw4nl7yfIb7AoB9jKAosAKAiVb3d8vzibmrZ6VdKL2RxNJ78f3XqIcwMRt7e3VnDO7YfDL8OcQyqd88o3lxzUbt6dY7J5epvCxI4jd1ZP+0lc+eoJ7vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238486; c=relaxed/simple;
	bh=POUJjzeRhBIXfPGojdZfC417KH92loTKx1KmDpRcfoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEUM6j9pVZzOg649HVrdBab+Xd0cXRuXpcX+MIgipZtuF2tRn2WNUPHOmeEccqDmN8jM4gkjQSoLw/up4XZBOuEDTCNps8LTajwCEmgO9PWneK+vvwH39tlBmMe4EQAWK1rt78kcuhJI/gbA60A47lVJQNo32uNrTZ5iPrs16bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-660ea6ceb5aso1643686a12.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 07:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238483; x=1773843283;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIz9Fr5w5J45ZN4rxwvT/0kjXMGfLP1VpB2aKPOax7k=;
        b=v9Oap7t8VmzREObBU3TIMLioqg9czQNCCvxxdMN4giCGtnRPDZpui/P7nk+T6vzG8u
         x1hw3SuA/F/z/eiXX/aQ9KkESTwDgwGk7KwXBWLvK7C1ucPgQ9Z2SchgpK9lfZmuZtGv
         ePZXbabOFvDqKaI27gYLwcPGlp00YGcFNoELpiUVDQNo2aIuNq6LkxYu5XNHgOGDhInG
         DLCHa6sFkVKiWlrtPydCtZc+MCx/Dxkz+YvbiIV4hMb2I68fVuMa9yS1LXvTOA2Is0WN
         efKFEYFV6yp5ar+aObQIbAGZUhwyvMFF6i7mQC3vFFTTb0If4fxBCgNKeXPBJEOnD/0Z
         KAdg==
X-Forwarded-Encrypted: i=1; AJvYcCVSZTuINhdvudtzKS1iu94uiOrAefDIbVyM6bOzOTul+muoQgtUSy3LWLzkBtVg79lEPYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaxLxYPVi0Ra5kTxXr9PSDS/ZpHlp4UzO6hOt7vkjaVZuJpL1d
	EmMMbxzRC2P4A6+uLsICPAgk1rRuBeMYgRB8CCup7nj4Bz3fsmAxnnoaAmjU6vKq1oDVIg==
X-Gm-Gg: ATEYQzwMyecu31+AQqsgb5VuVrAbAgBqX0S/a8+Q+79yD/kyyBkMx+gLRTbbSQRd4KX
	5rkHNY2M1uneC6o0YLnEzEMcW7AACHzn+1Am96uuELVWkcQowUCPnMLYunmvAkxptwtceA6NWui
	FbtS0GqAZztlfQDDa6t8z1olqar8dQF9R6uJQwuRu5NraWZ+57r/Qa2VLQ7hOSWqdmPfIJdU7YN
	MFrOWATlkI66RM+o3DiVi/TgAhgFAmm4vEZH84cv/mgSYePvfV5A8bYCjltwAZyxAb/l1U/Ghu0
	9buyqQUEqKVwFLwz5/lQ5W+tQItCdVKAbGk+nOCZJCz73W8zOfVT2FJmj6hmHkyF7LjAdQocFhn
	QrDQT1aRiX7CkdUXghnO/BdQ03n4VT+OxhBo71SpSoftgpiuBpZECEqqC6nyLrqzYV7qWzjhLBm
	opJthClttJZ6oCVy7FqGjYeXRomDCLLWB6pwA1r2FkG5fkTGj9VcDhvw2DVvni
X-Received: by 2002:a17:907:6d17:b0:b90:4838:46ff with SMTP id a640c23a62f3a-b972d817bb9mr157487466b.21.1773238482993;
        Wed, 11 Mar 2026 07:14:42 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972e14dc3asm62633166b.39.2026.03.11.07.14.42
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:14:42 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66174cf4549so2119005a12.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 07:14:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQCkE6yhnammDyFh6+uCNUO+JvXTL20/LQgz1J9mijyKAIYUbH8MOrgfDoMV6JYIgqmRk=@vger.kernel.org
X-Received: by 2002:a17:907:6d16:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b97113ff0b9mr462021166b.0.1773237981235; Wed, 11 Mar 2026
 07:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de> <20260310100750.303af303@gandalf.local.home>
 <20260311141332.b611237d36b61b2409e66cb3@kernel.org> <20260311100332.6a2ce4b1@gandalf.local.home>
In-Reply-To: <20260311100332.6a2ce4b1@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 15:06:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
X-Gm-Features: AaiRm53WEGMMLW4z34e7P-lM1qFvsCJGZ_o4JNL5NPWbhJPKmcqz6k9bJcyL--8
Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL check
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org, 
	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

Hi Steven,

On Wed, 11 Mar 2026 at 15:03, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 11 Mar 2026 14:13:32 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
> > But if you want to use IS_ERR_OR_NULL() here, it will be better something like
> >
> > node = rhashtable_walk_next(&iter);
> > while (!IS_ERR_OR_NULL(node)) {
> >       fprobe_remove_node_in_module(mod, node, &alist);
> >       node = rhashtable_walk_next(&iter);
> > }
>
> But now you need to have a duplicate code in order to acquire "node"
>
> I think the patch just makes the code worse.

Obviously we need a new for_each_*() helper hiding all the gory internals?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
