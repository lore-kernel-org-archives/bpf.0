Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78C649E15E
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474170; cv=pass; b=WZOa80niBo2GRnG1s4v6YwxBm1oMXy5h/NLOju1kkFIynTchJ1+jm+Daw+ZOZGykWGBhu0UKizfrcud1myRj2RhMV5tkqMTui6UWenJGgYcG+iNCGbaLf5yh49u8lB2NLdfPCq+yOKwWejqo+h1IZZohEi6aWAVtFF+x9ZFQhrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474170; c=relaxed/simple;
	bh=ypAz52v+DlxP5pSf3Vg/BgjrF4BPORw3LjQw7BsEmco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptQ/oUIwN5H3MC6R485uPpDhQRMsH3gAT2KQ+LiEY/W4Rfb1nXDsLYWMn34EaP/3oHPWB8AFq66vV90gfykQud4Q8JE7FDMHNaZMqoFgigEQE8q6RP0HZ3N/+KSaB95Y04O7tK7GWltiS40nvtEOcwCmdz2cGNggQMvSma8rmfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1vpNKvo; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1vpNKvo"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa65080so28806266b.3
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 05:09:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789474167; cv=none;
        d=google.com; s=arc-20260327;
        b=fB3Y1zB4x4iFT96ILBvZ7bNza3XRqO2fqe38AIxfLWdy8ybSUoAN5PUc15AofYvVqC
         boNVoYk5lLiE1BofYhhv4MA5ApWtgiN3KzEy4biY4BUdjZpkEQgxNJlQNXuaffgvx7sA
         H9pvUi4q298fWI5cDkWEv9bZ/pD4dd3CzZYTqmuTz+iek3n4xQL/olmketQNtIO3Qaal
         9fvnjJGzjCzpmIJrei4gOZMaHBIOHTagnjztqHPn9LEh2yBnXZg88187Q8kxMku0DMoQ
         XgMt95if9mFL1J/MWCFC77x4EMJNdjeJFNfHUDFsUWRtH5w37FXsHn292/NXCHosMW2N
         I28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GFhmdtp0y8oWGpHMp4iKKgSXGEeI4Ce+whtx2PLrXEo=;
        fh=MArLjIlGpP6+poJYC5Z3wM9/Q6mzIaVEzIRFI+A2VgI=;
        b=mcJNPQ5Ktn0z0HBUNlWQAxdWHTvbEp4BX6Wyc9EJrKi1HXqFA2DcvNvgKDa1woM7Gl
         MmHz/kW79q9MaAg1y3wH+OeogaVtpkGkoYIb83Ift7bEkto3Wnwj2OfvQpb7HvoB+go2
         //B9v2N0yKaY8XR/FMipUUZYn+6MX7WsctBzyF/2iUX4zsm3Yxhs1cAH0GB13y0wl7B7
         pxJrYjwQMB8zMARaWNEFCiyCUo+KtzLUs25ZyWcA2dT25DINlOS9nNb9BtLC2EKdIHPP
         hz9eFq+k/FvhUov7ZDrzuGVEu7BaRgWGeHaOrud1QN8OoO39gdkVaP382cI3Mzdx8Kew
         IRFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789474167; x=1790078967; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GFhmdtp0y8oWGpHMp4iKKgSXGEeI4Ce+whtx2PLrXEo=;
        b=Z1vpNKvopybZ3AB/rKwP57+1ZAdifwQndZR6Shr4InOrv5X9Rnl5LTpfvvm/+XYyxA
         Wt6yw9gEBErm2J3AYUHoi1hrzTj/Qw29NdRTSijSbcI1dxeLyFkfLZjLk0SfKKAMNhZJ
         5xN6aWXaT/ZwYPWdaYufdURmeNFI/1SE20AwuBbBsaFwmsKdXs4rkthryOFXASmPJN+p
         XXuAYrSIFXS9gnl6W2wl6PYfr3rDd4LAWAF3mab/6YpwH3dnbD9Ib5fl16xEEFWTUuM5
         d1ey2NZtVKru9+VdGYEeQDiEB0QAwn0DmDVRmHR+l7uycqB9S+2AP0ej4JT3lXcvRyDz
         JXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789474167; x=1790078967;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GFhmdtp0y8oWGpHMp4iKKgSXGEeI4Ce+whtx2PLrXEo=;
        b=PwPhFpAWE9RWQTieDW7uCK2Puf/vEx2z1sqAmaQ/z1kGYij+XIuDjMdX6YqsZjjtJx
         SziYaU4tJRELAC3Fovf53ddMOYY4xnm5YWYDFgeN9WKksrM7ZEiw1sIgrjLMgX+vHkOS
         xvrlqvHyeha+rl92dPT+KlEkFYWUhM29mcsI6NTcftB7I2WFnhbJo66+J52rcEWjelOS
         FuNK0c1NRiQtJ6oEOQQyVp5s+IqkS8unPeqFMlti3timKEu1uI1r8WaIjIO+CSUKSOOT
         eOwoadA3jH98F+CkMbcslxGzjb5LGHzMM/a++J8RJysmXDrPh+vFvBDV7h9oeveIEkpk
         CZLg==
X-Gm-Message-State: AFuF++kOI8TLplqXfhI/KD83MWcgrSQ7zCgE7x/d32RVDKp9egklAzrk
	Vyeue4sIBK2CF1cFpaLft9k+IH929LJt1ZNLPxv+lSzw25nhP7ovAqQRoIECmkWaMVhY4DWzWwH
	jOJeuY3OugLlPqrppEDLgPev4q1Z+PfXQUyXawnmkMA==
X-Gm-Gg: AYBFou1vGvkJP+l2aEZO324mord9QgglBQU7Vx2NTXwBuptXZGqTh2F5ANKyA9cFIEA
	ogk2W3op3A3wpcnJeCp+fipmHLn7UriOqBm2lYkNkqpuvp4WupxeLGHrybcCvfC0tW9qfPbE0M3
	BJ5PBfL3BKrRz1fc1I8vd9hu0+in4WC4N7cA+uoqyAJGhd+mrH8p+5tOVv/BudrzCkal1UJcnAN
	lidAvdr8XrU12I8WFb1dfWDyOte/uUxW3Xug/kfhhlspwbtMUB+lIaJBNCU785vtr5oVoeGOd8o
	6uLDxSgMMna2tYo0yrJTNsX19HvNYeKVqOvgYLX5wgZz5XBv3+nIwCVcRuIk7RVGprFlJRKEgo0
	f1iAM9A==
X-Received: by 2002:a17:907:9702:b0:c26:19e3:e982 with SMTP id
 a640c23a62f3a-c29d7940434mr70757666b.34.1789474166688; Tue, 15 Sep 2026
 05:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915114240.3269184-1-puranjay@kernel.org>
In-Reply-To: <20260915114240.3269184-1-puranjay@kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 15 Sep 2026 13:09:12 +0100
X-Gm-Features: AcwNN1WBijSOB0Z6HKZtv67-TIpiQyVOtvn_TsLwI0T__Qd2bkJzgy3c0fwrmaU
Message-ID: <CANk7y0hMd7ja7SK9Lqaq2S4_DM-GTResT_B0KV7WYy3pryvJZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/4] bpf: Add bpf_call_rcu() and bpf_call_rcu_tasks_trace()
To: bpf@vger.kernel.org, rcu@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please ignore this version, it has build failures. WIll send an
updated v3 patchset.

On Tue, Sep 15, 2026 at 12:43=E2=80=AFPM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
>
> Changelog:
> v1: https://lore.kernel.org/all/20260907134552.1772405-1-puranjay@kernel.=
org/
> Changes in v2:
> - Rebase on bpf-next/master
> - Use rcu_read_lock_dont_migrate() over open coding (Alexei)
> - Improve re-arming selftest to detect failure (Sashiko)
>
> BPF programs that manage their own objects have no way to run their own
> logic once an RCU grace period has elapsed.  bpf_obj_drop() defers a
> free, but returning an index to an allocator or unpinning a resource
> once readers are done has no equivalent.  sched_ext's BPF library works
> around this today by pushing freed nodes onto a list and having a
> userspace thread call membarrier(MEMBARRIER_CMD_GLOBAL) and then run a
> BPF program to reclaim them; it is the first intended user.
>
> Add:
>
>         int bpf_call_rcu(struct bpf_rcu_head *rh, void *map,
>                          int (*callback)(struct bpf_map *map, void *key,
>                                          void *value));
>
> and bpf_call_rcu_tasks_trace(), same signature, which also waits for
> sleepable programs.
>
> @rh is a struct bpf_rcu_head embedded in a value of @map, so the
> callback runs as callback(map, key, value) for the element it lives in
> and needs no cookie.  The field is only accepted in BPF_MAP_TYPE_ARRAY,
> and arming holds a reference on the calling program until the callback
> has run.  Patch 1 covers the lifetime rules.
>
> This needs
>
>   https://lore.kernel.org/all/20260810122758.183765-1-puranjay@kernel.org=
/
>
> for call_rcu() and call_srcu() to be safe from the contexts a BPF
> program can be called in.
>
> Puranjay Mohan (4):
>   bpf: Add bpf_call_rcu() kfunc
>   selftests/bpf: Add tests for bpf_call_rcu()
>   bpf: Add bpf_call_rcu_tasks_trace() kfunc
>   selftests/bpf: Add a test for bpf_call_rcu_tasks_trace()
>
>  include/linux/bpf.h                           |  10 +
>  include/uapi/linux/bpf.h                      |   4 +
>  kernel/bpf/btf.c                              |   7 +
>  kernel/bpf/helpers.c                          | 102 +++++++++
>  kernel/bpf/map_in_map.c                       |   4 +
>  kernel/bpf/map_iter.c                         |   6 +
>  kernel/bpf/syscall.c                          |  11 +-
>  kernel/bpf/verifier.c                         |  84 ++++++-
>  tools/include/uapi/linux/bpf.h                |   4 +
>  .../selftests/bpf/prog_tests/call_rcu.c       | 216 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/call_rcu.c  |  89 ++++++++
>  .../selftests/bpf/progs/call_rcu_fail.c       | 114 +++++++++
>  12 files changed, 648 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/call_rcu.c
>  create mode 100644 tools/testing/selftests/bpf/progs/call_rcu.c
>  create mode 100644 tools/testing/selftests/bpf/progs/call_rcu_fail.c
>
>
> base-commit: 5ef40d69b38a93bc9951dadb1a15c85c597e1a40
> --
> 2.53.0-Meta
>
