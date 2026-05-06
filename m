Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3733F7893
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075427; cv=pass; b=iW70WvqFduuYr0UwM0coYAe/0Dut3sO242UCdC2h9Ir09nYetBWoP+N6OI4c9Cq4mX76D2c03y7zZnZX3210cZdgXmySyJzeku4ZVlJlpqjLRxhBZBS8qNf7zmPH7gfDTK6v6YTuR9uFo1BFWjkEdd7WU1l+VJTr4HxZe6IUnbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075427; c=relaxed/simple;
	bh=3iDhx7/6fjvE83MU1N0QRbCRMeag6Iq5n9268QDDSUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNKyHOxHVd6JOMi9dgBnz0lGxMd3XXttHnfdrClJLNWieJTh1WnrZTE25NKvRRlabuOJM1mwdJEYfHi2yERzbnW/b6FRAqp/feCTBoM7evVRhyIn5kGpo9Ws5uzefyLTcbtmirgwh8S91NzYk4Q3oja1iPEnepaYOS/cJX595cE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzAlBK+A; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzAlBK+A"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39397d63804so36853321fa.2
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 06:50:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778075424; cv=none;
        d=google.com; s=arc-20240605;
        b=Jx2RESg1s2FSZjUNU5+KWWNFlf1avizlW7L5gQNHEDxWydUPZBcstGnr52tq0SKOEt
         I3vV1pJqrVWgPCDLhVPM8BvjCbVsWxW2UT3bad4MluLN3Fi7iw+BTA62sWAAlePcPn9D
         ql/P7QJqoAu/kdNYL1+GksLaEk+Vr+zuBcJhnRcbaET9H7+rCM713xeGn3NqMAwKYdgp
         4z/Ik0HLHaJLCLXVEg80d/HiHUMati09KZW1Y78zzZM17jN08jJ7w1sdf3AjLyoYHwhp
         0bNAXJLn7aRmPD99gXLWfaOpIoDvhsz9JUxCvH6gTmpNfsXgwWnCfncYgcywOEBLadkU
         0bYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6uvRH5NWwaeNa0HniCOROnjhGHZN7wgOdieTGzloLRI=;
        fh=TehjY1t5eGpLR12A70uh3MyGVP6T186N9ByKaUcxf4Q=;
        b=GQdra2kmm6ljSSjsdSMcBJzSheuLJ7w+2vKFHSPOl0L83R5XOj9zN2JpFXUd4xjSi4
         edwR+Q1KAdUI8J0rbx2Co0lDykgsH2qi3Lm4I5p+xevBJN0wEV95HSoF8Q8QIUfzlLNB
         S70XUNE6iFOwhmFSRxJHnvTa8Q87BBRlbjsBu63ySd1VBHmfe3oLjqyEYiZWYUxKWDTd
         L2EUBWhd3dsP7/lQf5XSyJMqoGpYMg8KDi3JDwB09HiPudIA57Pvvr7koK/a7SE/4z9D
         iF8MnetoqOX+4rN2dAPRnsrSDfmJ4QJZfQ+zAbRuz1i9FJ8LJCOu2DXFKb+mtquAyqBI
         LY5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778075424; x=1778680224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uvRH5NWwaeNa0HniCOROnjhGHZN7wgOdieTGzloLRI=;
        b=AzAlBK+Avy1Yh6BGX+YJpDl/MP1xmAuS5s9Mg+I4e4x1j6jH8chd9OXXztp/TYdovL
         Q6/v/6C6SzzYVg7qDxXwxiehWxHFCEYku67rmNegU/CjeGJE8W0mjJvxsCED3Jf6tI1H
         6dRQNi0zifQ3BIW1Snrhqn+i8lpJNIxyO3ul8qGoR7ERy84OCx84nfCjFR7UJknJ+H8J
         kDvC1nynogcDB6UDaeQ9c/6sGYhzAOzTM94Ij9ggiLGzD5SP+MV6hFGEIHs7u+v1g8A9
         ajLIPU/9bQAPqncU2XxnBulpkRB3OpIYIe3MKsZTdmQVXFwg9pyGGwnZDnLo0MaaRYWR
         rXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778075424; x=1778680224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6uvRH5NWwaeNa0HniCOROnjhGHZN7wgOdieTGzloLRI=;
        b=d7LJAg3p5MIg3wEDUFuqL4z6OrMmI4YVka5vvKaqW2IgzXB9g0xFEvLq1qx52gjtND
         RvVExHDR9LMsVzVnTQ3HnoRj8BOk7j8bKyc5Uu7EB23B/NRzjNxoNalJEtW+xPAQep1d
         crbEYMD5sgdA9SK6PVWYdS1AdXl23TWkKnKRjoOhVYPtHwfnV6nLLbPinEb8toiK1Sfd
         nuGCP+RV5mAbVIqk6XN1AJdFdXrTnO75yOXovKwvQtZDeOBE/5zdHpLBIe4Iurq0zUoL
         PXdrtAipRw3qXdQ0mLNotO54CLsaIgFz2OxC9pdCGlvZ6KDOENk/UPTCGpZMWB8SAcM0
         LnzQ==
X-Gm-Message-State: AOJu0Yws8ICC+hKNeMDvAsBFr2QpOKj1cFEovoCPZ7SrSzsecbXmMRPN
	Nv8g8Zn327Vto7SYuqu3aRwpvh6s0TzOmsf1hrwQEN/8EbUvrfUyORkbF0Z3v7k+1h6ruBnOI0/
	kvVHy/03BA5SITI2uhZcqyTFK/fMQ2ts=
X-Gm-Gg: AeBDiev4g6KWkO377Zt/vSVG74S/+gGwzc4WA/iWgPr0dUWsCM6aYLcntRgKImqRqnX
	z1MAr8hW2/4fdNQNMU0FGPGjk0c5lKvckuQK8PnNVOe/ufLUs292a/9FcEgNiJeQkB2TyoWKCVV
	Sl4s0Ci2LPRihlQImplcpOUawlVJ/uLwa33lxP9wLfJSokJ645nK5nyBy+X+OKURhwHnlX4bKYo
	Goiv/szYuGUClL4pDIjcDW8X3ywwamSpQdh9iJwE079UUgKqStjJWAyqFS5MeKjDh312Uaephmb
	fx1JoaI7eb4s+sPim3Y5
X-Received: by 2002:a05:651c:984:b0:38c:594e:ffd4 with SMTP id
 38308e7fff4ca-393c421098fmr14049071fa.25.1778075423200; Wed, 06 May 2026
 06:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503165024.1526680-5-vernon2gm@gmail.com> <20260503175737.6190AC2BCB4@smtp.kernel.org>
In-Reply-To: <20260503175737.6190AC2BCB4@smtp.kernel.org>
From: Vernon Yang <vernon2gm@gmail.com>
Date: Wed, 6 May 2026 21:50:08 +0800
X-Gm-Features: AVHnY4L5VjeFMFFAf0OJw7QnVXEiQ4TczmASiolBkquu7suKzugMa7qGCYoWr-g
Message-ID: <CACZaFFPb+W7VzRXGKvhMOwLm+T62dytC+zYUKa3-TopLOVO=9w@mail.gmail.com>
Subject: Re: [PATCH 4/4] samples: bpf: add mthp_ext
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, inwardvessel@gmail.com, 
	Shakeel Butt <shakeel.butt@linux.dev>, ast@kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, baohua@kernel.org, Lance Yang <lance.yang@linux.dev>, 
	Dev Jain <dev.jain@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Forwarding sashiko review

On Mon, May 4, 2026 at 1:57=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
> - [High] Infinite loop in `trigger_scan()` when `read()` returns an error
> - [Medium] Integer overflow in `FROM_MB()` macro disables fallback logic =
for values >=3D 4096
> - [Medium] Spurious mTHP fallback during initial cgroup scan due to zero-=
initialized baseline
> - [Medium] Failure in `setup_psi_trigger()` masks the error code and exit=
s successfully
> --
>
> commit d30597e7a4d6ca7d5532535074e0c66c2c92f486
> Author: Vernon Yang <yanglincheng@kylinos.cn>
>
> samples: bpf: add mthp_ext
>
> This commit adds a new BPF sample program, mthp_ext, to adjust mTHP sizes
> based on cgroup memory pressure and usage. It monitors the cgroup directo=
ry
> and automatically falls back to 4KB sizes during high memory pressure or
> low usage.
>
> > diff --git a/samples/bpf/mthp_ext.h b/samples/bpf/mthp_ext.h
> > new file mode 100644
> > index 000000000000..33dc01bcebd3
> > --- /dev/null
> > +++ b/samples/bpf/mthp_ext.h
> > @@ -0,0 +1,30 @@
> [ ... ]
> > +#define min(a, b)    ((a) < (b) ? a : b)
> > +#define FROM_MB(s)   (s * 1024 * 1024)
>
> Does this macro suffer from a 32-bit integer overflow if s is 4096 or
> larger?
>
> If s is an unsigned int like configs.min_mem, 4096 * 1048576 would wrap t=
o 0,
> which could silently disable the fallback logic.

Good catch, I will fix that in the next version. Thanks!

> > +#define TO_MB(s)     (s / 1024 / 1024)
> > +
> > +struct config_local {
> > +     unsigned long threshold;
> > +     unsigned long interval;
> > +     unsigned int  init_order;
> > +     unsigned int  min_mem;
> [ ... ]
> > diff --git a/samples/bpf/mthp_ext.bpf.c b/samples/bpf/mthp_ext.bpf.c
> > new file mode 100644
> > index 000000000000..bbee3e9f679c
> > --- /dev/null
> > +++ b/samples/bpf/mthp_ext.bpf.c
> [ ... ]
> > +SEC("iter.s/cgroup")
> > +int cgroup_scan(struct bpf_iter__cgroup *ctx)
> > +{
> > +     struct cgroup *cgrp =3D ctx->cgroup;
> > +     struct mem_cgroup *memcg;
> > +     struct mem_info *info;
> > +     struct alert_event *e;
> > +     unsigned long curr_stall;
> > +     unsigned long curr_mem;
> > +     unsigned long delta;
> > +
> > +     if (!cgrp)
> > +             return 1;
> > +
> > +     if (!cgroup_has_tasks(cgrp))
> > +             return 0;
> > +
> > +     info =3D bpf_cgrp_storage_get(&cgrp_storage, cgrp, 0,
> > +                                 BPF_LOCAL_STORAGE_GET_F_CREATE);
> > +     if (!info)
> > +             return 0;
> > +
> > +     memcg =3D bpf_get_mem_cgroup(&cgrp->self);
> > +     if (!memcg)
> > +             return 0;
> > +
> > +     bpf_cgroup_flush_stats(cgrp);
> > +     curr_stall =3D bpf_cgroup_stall(cgrp, PSI_MEM_FULL);
> > +     delta =3D curr_stall - info->stall;
>
> During the initial scan of a cgroup, info->stall will be zero-initialized=
.
> Since curr_stall represents cumulative stall time, won't delta be a very
> large number?
>
> This seems like it could incorrectly trigger the 4KB fallback during the
> first interval regardless of current memory pressure.

Good catch, This is a Bug exactly. I will fix that in the next version. Tha=
nks!

> Copy from cover-letter:
> When the redis is under no memory pressure, RPS drops by 10.3%
> (from 1.4M to 1.2M, compared to always).

After fixed, when there is no memory pressure on Redis, RPS equal to
1.4M, which means mthp_ext is a positive optimization in all
scenarios.

> > +     bpf_mem_cgroup_flush_stats(memcg);
> > +     curr_mem =3D bpf_mem_cgroup_page_state(memcg, NR_ANON_MAPPED) +
> > +                bpf_mem_cgroup_page_state(memcg, NR_SHMEM);
> > +     if (curr_mem < FROM_MB(configs.min_mem) || delta >=3D configs.thr=
eshold)
> > +             info->order =3D 0;
> > +     else
> > +             info->order =3D PMD_ORDER;
> [ ... ]
> > diff --git a/samples/bpf/mthp_ext.c b/samples/bpf/mthp_ext.c
> > new file mode 100644
> > index 000000000000..0e064bad136f
> > --- /dev/null
> > +++ b/samples/bpf/mthp_ext.c
> [ ... ]
> > +static int trigger_scan(struct bpf_link *iter_link)
> > +{
> > +     char buf[256];
> > +     int fd;
> > +
> > +     fd =3D bpf_iter_create(bpf_link__fd(iter_link));
> > +     if (fd < 0) {
> > +             fprintf(stderr, "ERROR: bpf_iter_create failed: %s\n",
> > +                     strerror(errno));
> > +             return -1;
> > +     }
> > +
> > +     /* Read to trigger the iter program execution */
> > +     while (read(fd, buf, sizeof(buf)))
> > +             ;
>
> If read() returns an error (like -1 for EINTR), will this result in an in=
finite
> busy-wait loop since -1 evaluates to true in C?
>
> Could this be updated to check for > 0 instead?

Yes, I will fix that in the next version. Thanks!

> > +
> > +     close(fd);
> > +     return 0;
> > +}
> [ ... ]
> > +int main(int argc, char **argv)
> > +{
> [ ... ]
> > +     psi_fd =3D setup_psi_trigger(root_path, "some", threshold * 1000,
> > +                                interval * 1000);
> > +     if (psi_fd < 0) {
> > +             fprintf(stderr, "ERROR: PSI trigger setup failed\n");
> > +             goto psi_setup_fail;
> > +     }
> > +
> > +     monitor_thread(psi_fd, &skel->bss->configs, iter_link, rb);
> > +
> > +     close(psi_fd);
> > +psi_setup_fail:
> > +     ring_buffer__free(rb);
> > +rb_fail:
> > +     bpf_link__destroy(iter_link);
> > +exit_fixed:
> > +attach_iter_fail:
> > +     bpf_link__destroy(ops_link);
> > +attach_opts_fail:
> > +load_skel_fail:
> > +     mthp_ext__destroy(skel);
> > +open_skel_fail:
> > +     close(root_fd);
> > +
> > +     printf("\nExiting...\n");
> > +
> > +     return err;
> > +}
>
> If setup_psi_trigger() fails, the code jumps to psi_setup_fail. However, =
err
> was previously set to 0 from a successful BPF operation.
>
> Does this cause the program to log an error but exit with a success statu=
s
> code?

Yes, I will fix that in the next version. Thanks!

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503165024.15=
26680-1-vernon2gm@gmail.com?part=3D4
