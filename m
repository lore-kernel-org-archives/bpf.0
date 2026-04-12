Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D8D2253FC
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776033574; cv=pass; b=TNOJ7/Y9zlzsGgnMRPcDJqmoWmm6FFSTShwkLkKzXH+murQzts0sqviAsbRXLGAs/QDFZrHNoM/D7xlZz0mFJimwzWAOCToVeXbaCPTdEx6gFN2/7AnT0536nKit4QR5V9KzibSBDYpAODHK5j752hO/gZAQzZqydyd2oRIIhkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776033574; c=relaxed/simple;
	bh=cjb7H3ckcwuFEtXtGWZ/guWnwvZYB3tLC9zM1p1agn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNPDIm5cPU5C1SpO/1/96Q73VEHE9bRCsQCvyLN45DrEBCv5blBhpG0orw0msbAUCCyZ2d0ZfIdf11+04jPjbgom4I1sluREvPK9OyXW1BOTgCpyY4k9fXEIFVCNHelM2gNQgiOzOfa/z54VhAA7bydEGdPJe2OuCifbd8PlHb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEPkbNzW; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEPkbNzW"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d70b3e159so272482f8f.0
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 15:39:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776033571; cv=none;
        d=google.com; s=arc-20240605;
        b=PhFQGuwu4tEyYwGfd+FFJNVtfEqY81f4Fv9FqYQTboh59CAR02BpU8DLyW/EthmrYu
         cgBROnSalyJdOiqGujxmuZVELo0hgGuF9YO/bxDQSyM4f95FIcZhaqZrSW2lFnUiJ28U
         GXdTCHq4oksJ1+zhk/FstSpVnWY6s1QYTrNo9QAIJ7Sct1bM1IhJvC97CS5UjHGNDyU2
         s1dUERJXqtVxr0D/XSBoqpiBFhXuEuz0ceg7OsvUSrsLGYHNukrvQZ6HQC6KX8H3tt0E
         Rclp4Ht2ybTzkowloRbuX7QpfO4I2oD9y8mOi2svimEe2J7A/KoyDx9ygsPyFYhC/Y/6
         0/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jDBAEEoQBuKDltRw41SmsNmQUUOb1HI8tJvTVBEOIqs=;
        fh=eaxf7JtI/RroZtVj1uGO8/wMYU0awWyEBcCk+fXpeO4=;
        b=VNU2O5lPXxag6X7//7Obju01WGBHaSJLyOERxQOK9LBR+mief0OkEohkPWrbzhIVON
         KgjpZ9xjT5hxB4G8Kd0hXEO5bTch0eeLKoT4XHjz3E/t1g3aq0YDHq9EPKuFmxQpSjL0
         Kk5q4YonB8QAbSOA4hf+LFXHzbv6vpdTKyZP1kfAAhU+O+ER4fvsR/R4zfgT4mZHcGd+
         YtWjQzl5UGJT0mRx0MSRSBcalMFdQRo7j4AWUNloKnTjCNnX7eCW5kez6EGmfWx5plQ4
         jMMmX6yyqJ7AwYgswFEihhXNBcA+0nkGxLTHYryeWjmDh1HD5ahl2eWy1jQt9WeBsMfd
         sVMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776033571; x=1776638371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDBAEEoQBuKDltRw41SmsNmQUUOb1HI8tJvTVBEOIqs=;
        b=ZEPkbNzWNCLEUDpgCjM+6BbDbnaHLjUwnQY1OoS8LUPpOqXZRcgGUbkj4/uA7qsaHO
         X9/p39yWQ86RNTu6zXAmToyHAhxvvA02yl5bfDVXYg0idzwdcuWkEiujw0UKU+Qn2a7e
         2doWUjAQt2UUk8Kg2LeXO3uSSXByb4YUaQJ/zZSbir6n0lg69HZTBO2RhgbO67I96tLH
         lUvJszAGYX6L9+WjN9Tr/pRvDsfgUqlZ5r3W4y+KOn3ULX+GXaRk6KO/tP6h+19qFkEQ
         iHiym8TvbOKZdQjjrTmRl4uqJBpDgdipIp9LNaWBmgSb7jsNk8wKjt1SOIl0xeYWjr3J
         gbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776033571; x=1776638371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jDBAEEoQBuKDltRw41SmsNmQUUOb1HI8tJvTVBEOIqs=;
        b=kXfAuvbOrDqGeRiPBWmwT3pZVi369B1IaI5nfvZctEIWfM1z3xioNLm6EWjpeX3JCB
         N6hyv3Hn9On7wQ4BPjxMyKUWgD8qQBTTrQxNyoPLJ7ELAUkr9abthK2BrBVx6we4H7E8
         CW6lMFlOTK62VYpIPYs3PYdlU0PPn86kSuPYe7tdQ1Ok74p5rWsUdiduQsOMJq9wuMP2
         qs7dU/HgsZd3XKlkQHG5SiQHbDUGkKaoy43BtQSat+AUSkZh4eVuqDMW2ecZ5q+WobzR
         RdEOGdeS5nvBEQbELe4veLkemGFeDNUk95/XYdHTyQ7nk3PF2PRb2s0p6FiUWXGgvYsg
         G+kQ==
X-Forwarded-Encrypted: i=1; AFNElJ9VMD/0zfIq/5M+3stnhMAQWyCgURYwGtsHQCTXVmdK80Te4XH77dmMWTm1w1bBU3WfWpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws7d6YLe465SRDiGdfHBmZS+1fwpT51Z61uDbQW0UzA5tZW6Xo
	nXYMgdMeBEU8UFL6/Qz/NVlQlRRzmmzwpnyPiWFaYQTiTW8Vt7vZCeEvudt4Wz6AY+WjpN49mCj
	1lij8sDp/uN7Mk8GlVL94hiXCtv7gSrM=
X-Gm-Gg: AeBDietkV1PB14dMfeecaINoUUcKY4qriL1ZSAr+uODNEFgSY2f81//ma0G5eIRJ6Jb
	u6V91zC6iEKkuko9oa8CP5jYlLNk0Y/UNqV1NFHAFurjyakxLlWjID7JZwg1Ty6SoQ7OAZmVPom
	GPJKoJ2kOWnMGF1B7ubxKfMOtXLXKzGat0kXN6dATLU+EBKkhQqmAzHR06MWOBxwwXvax8WE01c
	3ZK9P0TIdd4C3ffkzKn9KwNbYqJdU7QJdY0pEnc7uex4pMFakvQjHbKcCJoy85flRm0pkYLdAI1
	tmBy4tTh8ltc9KuqdCgOR+pvdP6Z9Yx+hjMo3WpdXr4OqvxM3XkfzX1ty8RLz9G7NoPLv0bec7E
	3MZtRMMOfHUViirQCxjrCZnDFiA==
X-Received: by 2002:a05:6000:2407:b0:43d:70de:1c5e with SMTP id
 ffacd0b85a97d-43d70de1f62mr5483007f8f.46.1776033570619; Sun, 12 Apr 2026
 15:39:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408095710.4090495-1-mayamatuszczyk@google.com>
In-Reply-To: <20260408095710.4090495-1-mayamatuszczyk@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 Apr 2026 15:39:19 -0700
X-Gm-Features: AQROBzD7qbDazBS7Fum_ZxU92K_-Pcjnp3Jjue6ttx4Xd1eLMU5IWfBdxDhbOQ4
Message-ID: <CAADnVQLmJ5cPOL39dOubQvix2BhQ0GHs5gMVCeNhdc7r_f-zsw@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Run test_perf_branches more than 1 time
To: Maya Matuszczyk <mayamatuszczyk@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 2:57=E2=80=AFAM Maya Matuszczyk
<mayamatuszczyk@google.com> wrote:
>
> test_perf_branches bpf program was only being ran once, and
> perf_branches test would fail if the only sample that was passed to
> test_perf_branches didn't have branch data.
> Fix those failures by running it a few more times and waiting until a val=
id
> sample shows up, and leave the perf event only enabled for the duration o=
f
> test spins.
>
> Signed-off-by: Maya Matuszczyk <mayamatuszczyk@google.com>
> ---
>  .../selftests/bpf/prog_tests/perf_branches.c  | 57 +++++++++++++------
>  .../selftests/bpf/progs/test_perf_branches.c  | 11 ++--
>  2 files changed, 43 insertions(+), 25 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/too=
ls/testing/selftests/bpf/prog_tests/perf_branches.c
> index 0a7ef770c487..1dcb7c70f545 100644
> --- a/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> +++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> @@ -15,10 +15,6 @@ static void check_good_sample(struct test_perf_branche=
s *skel)
>         int pbe_size =3D sizeof(struct perf_branch_entry);
>         int duration =3D 0;
>
> -       if (CHECK(!skel->bss->run_cnt, "invalid run_cnt",
> -                 "checked sample validity before prog run"))
> -               return;
> -
>         if (CHECK(!skel->bss->valid, "output not valid",
>                  "no valid sample from prog"))
>                 return;
> @@ -49,10 +45,6 @@ static void check_bad_sample(struct test_perf_branches=
 *skel)
>         int written_stack =3D skel->bss->written_stack_out;
>         int duration =3D 0;
>
> -       if (CHECK(!skel->bss->run_cnt, "invalid run_cnt",
> -                 "checked sample validity before prog run"))
> -               return;
> -
>         if (CHECK(!skel->bss->valid, "output not valid",
>                  "no valid sample from prog"))
>                 return;
> @@ -73,7 +65,6 @@ static void test_perf_branches_common(int perf_fd,
>         bool detached =3D false;
>         struct bpf_link *link;
>         volatile int j =3D 0;
> -       cpu_set_t cpu_set;
>
>         skel =3D test_perf_branches__open_and_load();
>         if (CHECK(!skel, "test_perf_branches_load",
> @@ -85,19 +76,35 @@ static void test_perf_branches_common(int perf_fd,
>         if (!ASSERT_OK_PTR(link, "attach_perf_event"))
>                 goto out_destroy_skel;
>
> -       /* generate some branches on cpu 0 */
> -       CPU_ZERO(&cpu_set);
> -       CPU_SET(0, &cpu_set);
> -       err =3D pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &=
cpu_set);
> -       if (CHECK(err, "set_affinity", "cpu #0, err %d\n", err))
> +       err =3D ioctl(perf_fd, PERF_EVENT_IOC_RESET, 0);
> +       if (CHECK(err =3D=3D -1, "perf event reset", "ioctl err %d", errn=
o))
>                 goto out_destroy;

Since you're touching this part, please use ASSERT*() macros,
since CHECK() is deprecated.

sashiko thinks the same.
