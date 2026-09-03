Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE33803C5
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451320; cv=pass; b=OYkSVYomePZQ9fQW8P33dKWKr0WfMw58X50s51wfj1day9GxhRQDbbSGL6FmKMorHPVPkToYD7P4kCYYfJEO6uZkX6wADX58f3+JYLTVOrLi6ak3KJBNPukGAB1EnuEAnaWWfn9deVmPIaRiyd/A1W1hGBseGGDxMAuexrII44U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451320; c=relaxed/simple;
	bh=UQJOARb0hjrrxZqoI8tPjCF4BNxBhRids7cJ/ZQHpwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFM+8BqmpTtpz/1YhWc0CFIKWKTpFxsndpSOMWoT+RG2jDhR66h1/uzvgICecFbvcog9Kk0dErijR6wue1+OD1HvF1JiDE/liz0ZVAFihFwCPL3lX8RSme5K7G1sQpVzr8PO+8MB0tE1qwvwNqkAZtooY8d5ev2amkXE0BwlpX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcKO8RvH; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcKO8RvH"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-398e9698a70so2501798a91.0
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 09:01:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788451318; cv=none;
        d=google.com; s=arc-20260327;
        b=XgX6n6QbuuWjrAuMEDnhET4+hoUdsYMEwPP1E4967VqSoORWUmH7uY6zEISu5+znMc
         fHg1wPou3of2kB4k95yw7CboZYC4FMNAn2aMLNphs0DtYpzTAQDMedAYCQkHy9c0xwHV
         bPuGMHTn8fqAbu1z19Vnx1y0EwoTdFlHa5K56ysbCHPzBvWd8sjjLcAGpgeDgw8emmwR
         1plk+SeHzINVNNO+4fUurrLFGHM1GMgb6gasyUoVyTZN9Vh4UFwUsJMvcQ7VEOwUnHgS
         Fvg9XDywFtYPxl+SPUMHpBcpYik/vBPPf54hK5A557BTgczc3VRwk2Y1YHrBhyF8Hhr8
         bQdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ym1m2s7k69osu4j9IQLOfbeC7FHjlBRmEp9KBHwH/xs=;
        fh=H+jiIjMO/mjS/Ttq2l0CmoW2FVxyepJehJU2TdtFoOM=;
        b=celFVRDeDM6ggRQh2Glv8IXwFsJqT2d+5XNM6bEkpdFYrrAMN89y4dKYB5Y2nya2SS
         D+2CIqithYwBJGVRg6+TJ/DmeJf1nLMYMdMntznntG3gM2OrLRp712EbSgIIwFKw8BMe
         +aUM7O3tSejNMZJdLx+1jlMAhO5W/Pf5RJUWlNa9Qwdh0hiuEWguBwhqZbi69pt4kyR2
         H/J27LcF0DbGCau7VBWL2rOvC11URK8wyu6z2YeKcUdJkP29BOkQP9Q5/+/xmZdjZOoj
         sBsZ9MczxF3izqV7YjomU1wreEkcgINH9EorSsKaaRJsb24km4nyOAEmL26Bxy7FzwCB
         6Vqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788451318; x=1789056118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ym1m2s7k69osu4j9IQLOfbeC7FHjlBRmEp9KBHwH/xs=;
        b=QcKO8RvHQGNSBO4XH9NFw14lgD5LLJ9cqH9uZVbdQAsFQmxaI/jCa2U6TmEXrQ17CH
         CzwapOwJkhuwTuM1M3K919HKi+hI2Ji4SjnvUlvnWN3bdanuxVwxMvhPnkkpIFgevkGI
         OxUTMsbBAmM/CkpIFI8A04zMLq6z9VJkUdsq+hCG8V6eHJmwV1zCD3+7atNWI+1SjZgo
         aFTWsavhDTZUXTfUlPNjyFTQ2QXOZ9HYWX30BbfNTgg9mErIw935Sl2ly1aK2DvZKDqv
         8AZe2a7u5J370QeeYwuKLc5YGL71pfeflZtGW76PudJYZdG1vM7ZWOpcSNpDwxip67+W
         hXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788451318; x=1789056118;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ym1m2s7k69osu4j9IQLOfbeC7FHjlBRmEp9KBHwH/xs=;
        b=JbEQtSxBDF1c+txaLCM4p0xo4NTeztjvjXgQYm356e4oRGWvWmt1NrBGkGlFjk3sud
         9Dyiu9IIod3UNOD1ARLSQ+1rNvPeUrkx+y3EAyHieZAenLUIdDLHIGNX5L2dF4jbETbA
         E78UvSV47S9p9Lyzk3F7z0tb8ifwEKkg5gR99GD08wA0cQ1J4/lUXVniDc2g3Bk+shwV
         fI4Jw21I6TUZekBT2QYVpqDZEdy8GrqVLDOyF3Jx+Gwfz7yTD5Jg+spA4Uxp/Ox9KuiV
         bOvJgprODAwdc3ztmKoYQ/DRUFc0MBer6VaE24Wvkx1dluEm7cMi9X5RQ7A1r/F63uWx
         AFqQ==
X-Forwarded-Encrypted: i=1; AKwUvByjXfAxLGM5B2dfoIqeeEHyRgBQ0jotFpaWDG65hnc6SbQovJ4BWIn+7GOHpfCWUBkH8io=@vger.kernel.org
X-Gm-Message-State: AFuF++mEUksZ/zF68EVDk7pTHDx/NdbFwqJz+57IitOWDblwndu10zQY
	+gjpRFTG/OV/coXJ3DsHt8VY57uW2S8KFmi/xPF1SEuNoEWWRnEHRJ/lsKPjW4YPVAfv6z5sEX0
	asf6cei0GinAGLQXSIk5cL/TmCIGuLN8+xF+P
X-Gm-Gg: AYBFou3CxaBOsVvNBbCqPBiSAs3fOq69nmBXOcm677as0SS/7ky+wd1w6uNLBkEqOgh
	NjpaKF4DA7c+UxNC5k9tEZ4HFcxoLEGLeQXlvF+lCTWlGo63YrXHPgAOs/BItVHQq1YrVsT1c6c
	0AtDwDcWx9P07jKfLbHpPyAN8hbUtUNQFs3IhKBVC+js57DI92/jItySJ4mM81h/yBJMeeOBu0e
	3MqXlUBnimciYKhlgPZZ04I0k55pLUEG7b/PiN9Kp3tawewgMtE9iy6I/xVRG+6HhQJ184DJ/ar
	U3aDRZowy2RW0eL2dmFp52Us5y0dYNk3sjNkByoloCfgZkkjiY7fSzYir6w4kkabCEzNDw1Bs7v
	dd4780mmSFxKJtjqVSXDJ+cJNTRzC/N/4qxvlkV7WxA==
X-Received: by 2002:a17:90b:2ec8:b0:398:9bd1:3216 with SMTP id
 98e67ed59e1d1-39b22fd5e8amr936066a91.23.1788451316207; Thu, 03 Sep 2026
 09:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901141954.29449-1-suchitkarunakaran@gmail.com>
 <CAEf4Bza6wQb1mSiKA_6U7FovYivcZvf3MCvU9NMdt01w-wAZPQ@mail.gmail.com> <CAO9wTFiA6BHbTtP8Y8GCNnEQqXgsOzecuibK3zsjBKfyN8Nfkw@mail.gmail.com>
In-Reply-To: <CAO9wTFiA6BHbTtP8Y8GCNnEQqXgsOzecuibK3zsjBKfyN8Nfkw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 3 Sep 2026 09:01:41 -0700
X-Gm-Features: AcwNN1X-YqQqjC61b-JrUTGMCYd0EnTSl9FqXJbSPoltToJP7INN2w4pWDyVNgo
Message-ID: <CAEf4BzYUREsJYXw7ZU9twCDcfEJ6cTpR4Ypbvf5JTABK0uGi2g@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix map_lookup_percpu_elem on sparse CPU IDs
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	memxor@gmail.com, shuah@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, jolsa@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, zhoufeng.zf@bytedance.com, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 10:29=E2=80=AFPM Suchit Karunakaran
<suchitkarunakaran@gmail.com> wrote:
>
> On Thu, 3 Sept 2026 at 06:02, Andrii Nakryiko <andrii.nakryiko@gmail.com>=
 wrote:
> >
> > On Tue, Sep 1, 2026 at 7:20=E2=80=AFAM Suchit Karunakaran
> > <suchitkarunakaran@gmail.com> wrote:
> > >
> > > libbpf_num_possible_cpus() returns the number of possible CPUs, which=
 is
> > > appropriate for sizing packed per-CPU map value buffers. It is not th=
e
> > > upper bound for logical CPU IDs.
> > >
> > > For a possible CPU mask such as 0,2-3, the test loops over CPU IDs 0
> > > through 2. This incorrectly visits CPU 1 and misses CPU 3. It also
> > > initializes packed per-CPU slots using their slot indexes rather than
> > > the corresponding logical CPU IDs.
> > >
> > > Parse the possible CPU mask and keep the packed slot count separate
> > > from the logical CPU ID range. Populate each dense per-CPU slot with
> > > its logical CPU ID, calculate the corresponding expected sum, and mak=
e
> > > the BPF program iterate over the full CPU ID range.
> > >
> >
> > Is this the issue you ran into in practice or it's just another of
> > those found by AI reading code?
> >
> >
> > > Fixes: 7aa424e02a04bba5ecc84afe9b58b16e9e0b34f8 ("selftests/bpf: Fix =
some bugs in map_lookup_percpu_elem testcase")
> > >
> > > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > > ---
> > >  .../bpf/prog_tests/map_lookup_percpu_elem.c   | 34 ++++++++++++++---=
--
> > >  .../bpf/progs/test_map_lookup_percpu_elem.c   |  8 ++---
> > >  2 files changed, 30 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu=
_elem.c b/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c
> > > index bfb1bf3fd427..849f33259c00 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c
> > > @@ -2,29 +2,45 @@
> > >  /* Copyright (c) 2022 Bytedance */
> > >
> > >  #include <test_progs.h>
> > > +#include "bpf/libbpf_internal.h"
> > >  #include "test_map_lookup_percpu_elem.skel.h"
> > >
> > >  void test_map_lookup_percpu_elem(void)
> > >  {
> > >         struct test_map_lookup_percpu_elem *skel;
> > > -       __u64 key =3D 0, sum;
> > > -       int ret, i, nr_cpus =3D libbpf_num_possible_cpus();
> > > +       bool *possible =3D NULL;
> > > +       __u64 key =3D 0, sum =3D 0;
> > > +       int cpu, nr_cpu_ids, nr_cpus, ret, slot =3D 0;
> > >         __u64 *buf;
> > >
> > > -       buf =3D malloc(nr_cpus*sizeof(__u64));
> > > -       if (!ASSERT_OK_PTR(buf, "malloc"))
> > > +       ret =3D parse_cpu_mask_file("/sys/devices/system/cpu/possible=
", &possible,
> > > +                                 &nr_cpu_ids);
> > > +       if (!ASSERT_OK(ret, "parse possible CPU mask"))
> > >                 return;
> > >
> > > -       for (i =3D 0; i < nr_cpus; i++)
> > > -               buf[i] =3D i;
> > > -       sum =3D (nr_cpus - 1) * nr_cpus / 2;
> > > +       nr_cpus =3D libbpf_num_possible_cpus();
> > > +       if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
> > > +               goto free_mask;
> > > +
> > > +       buf =3D malloc(nr_cpus * sizeof(*buf));
> > > +       if (!ASSERT_OK_PTR(buf, "malloc"))
> > > +               goto free_mask;
> > > +
> > > +       for (cpu =3D 0; cpu < nr_cpu_ids; cpu++) {
> > > +               if (!possible[cpu])
> > > +                       continue;
> > > +               buf[slot++] =3D cpu;
> > > +               sum +=3D cpu;
> > > +       }
> > > +       if (!ASSERT_EQ(slot, nr_cpus, "possible CPU mask weight"))
> > > +               goto exit;
> > >
> > >         skel =3D test_map_lookup_percpu_elem__open();
> > >         if (!ASSERT_OK_PTR(skel, "test_map_lookup_percpu_elem__open")=
)
> > >                 goto exit;
> > >
> > >         skel->rodata->my_pid =3D getpid();
> > > -       skel->rodata->nr_cpus =3D nr_cpus;
> > > +       skel->rodata->nr_cpu_ids =3D nr_cpu_ids;
> > >
> > >         ret =3D test_map_lookup_percpu_elem__load(skel);
> > >         if (!ASSERT_OK(ret, "test_map_lookup_percpu_elem__load"))
> > > @@ -55,4 +71,6 @@ void test_map_lookup_percpu_elem(void)
> > >         test_map_lookup_percpu_elem__destroy(skel);
> > >  exit:
> > >         free(buf);
> > > +free_mask:
> > > +       free(possible);
> > >  }
> > > diff --git a/tools/testing/selftests/bpf/progs/test_map_lookup_percpu=
_elem.c b/tools/testing/selftests/bpf/progs/test_map_lookup_percpu_elem.c
> > > index ca827b1092da..d8da0696b97c 100644
> > > --- a/tools/testing/selftests/bpf/progs/test_map_lookup_percpu_elem.c
> > > +++ b/tools/testing/selftests/bpf/progs/test_map_lookup_percpu_elem.c
> > > @@ -7,7 +7,7 @@
> > >  __u64 percpu_array_elem_sum =3D 0;
> > >  __u64 percpu_hash_elem_sum =3D 0;
> > >  __u64 percpu_lru_hash_elem_sum =3D 0;
> > > -const volatile int nr_cpus;
> > > +const volatile int nr_cpu_ids;
> > >  const volatile int my_pid;
> > >
> > >  struct {
> > > @@ -57,17 +57,17 @@ int sysenter_getuid(const void *ctx)
> > >
> > >         map_ctx.map =3D &percpu_array_map;
> > >         map_ctx.sum =3D 0;
> > > -       bpf_loop(nr_cpus, read_percpu_elem_callback, &map_ctx, 0);
> > > +       bpf_loop(nr_cpu_ids, read_percpu_elem_callback, &map_ctx, 0);
> > >         percpu_array_elem_sum =3D map_ctx.sum;
> > >
> > >         map_ctx.map =3D &percpu_hash_map;
> > >         map_ctx.sum =3D 0;
> > > -       bpf_loop(nr_cpus, read_percpu_elem_callback, &map_ctx, 0);
> > > +       bpf_loop(nr_cpu_ids, read_percpu_elem_callback, &map_ctx, 0);
> > >         percpu_hash_elem_sum =3D map_ctx.sum;
> > >
> > >         map_ctx.map =3D &percpu_lru_hash_map;
> > >         map_ctx.sum =3D 0;
> > > -       bpf_loop(nr_cpus, read_percpu_elem_callback, &map_ctx, 0);
> > > +       bpf_loop(nr_cpu_ids, read_percpu_elem_callback, &map_ctx, 0);
> > >         percpu_lru_hash_elem_sum =3D map_ctx.sum;
> > >
> > >         return 0;
> > > --
> > > 2.55.0
> > >
>
> Hi Andrii, I did use AI to find this. I often go through recent
> commits and then ask AI to check whether the related selftests have
> been updated and that's how I found this.

in that case I'm inclined to leave selftest as is. This set up where
possible cpu mask is not contiguous seems to be some fancy qemu-based
setups so far, and frankly a bunch of other code is probably broken in
such situations anyways. let's keep things as is for now

pw-bot: cr
