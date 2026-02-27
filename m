Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF4A372B3D
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772216303; cv=pass; b=Pnh2lfQbaRVSvGAHSNStIXYqQxwnNV3dgtZmrqaASNr9CWwATUcgH6zH8Y8R0qP9qVt/2uwAJz7hAIVkbJLwvGe2sJ4Tt6Yy8MN8+oRYa2J6wdMPbT2QhXagV+yiHt2S0jWU2bugmnUFj9SKzNK+uO/4+WBrvZSdP6QTU78OECk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772216303; c=relaxed/simple;
	bh=go9pLsoIXwHeWsSg2SF7qlsw3Et1NlKlu6WwpsdWHTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLOuA3WUpnh/ASshmX7mdYtvyuy42m5d4WZy0prjWAhgDBDsSQtUzVZFBx3VWsGlEWSg7vVfjY/3A4VSk7WCeBfHHgAOl96XnUhEi8NZI/BvT/Sy/CRDr2gEIAmGZlFVpmzHw2bxDAD9NAZ1Tungt7VhTIRiN5ULQgWRpvmOQGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbU1E1A2; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbU1E1A2"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48371bb515eso32758235e9.1
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 10:18:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772216301; cv=none;
        d=google.com; s=arc-20240605;
        b=FY+XVdPusg9AokXdy4P0euAddVW65cgrQbJ0bT14z1e55sBuS+hxu66+MU9BhccrDE
         BxPG1m0mlPQn99ZAtFKkh+UZ3AtAP4zQ6v2v69JEExmQ7jZgv7gAFCfDepiSHrFtMHhQ
         krLmTZTgLmDyX3hnLXZcIy/PGNIkZhjedU+B2kG9ni4TVTTdToPGnNYLQlzYcWu7xd7i
         AzZDIzETO9sY0nTW6bpIXeQxKhB53jKUTAyarRUD1Pq9/G1GriZQD3ln9A+JQ2IXy/lB
         azhWYQCkL98fUPxrU7/CONtCAcYhNljnxtwAC78fr5waFTPi3ObmjgqDbQglCCCLnTdc
         byRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NMNuhM7y4Z7hySCCP9bwoDUIKI63MvNsZrVoSU50SCE=;
        fh=BJRO5P/o+s/eyeLQPttoRkycms6Es+9aWJ8pmMPv734=;
        b=G81U1eVakudYssUd7MtsTjOjJOSBR9/pdF1eRdqdfkxGUZ4zsfksomDyRKNQqKQPbl
         mmDCnVdalgwZfmapGBTUz13j7oOMGxI52TTT50KhfFuEZZHSWtHLfGLEkFsQRN8Rbwho
         mlkruEU/h2rVtERW2Pnby9tjPJKu9gTIITXnSwlIkkhsA37u0GHybD6d7Yc+UZesP6lb
         8g4yocpSvms3aY9pxgid5pz9EIB5to36PoG7jNEoF0CSdyJ0nmFXq4wEgzXb2XyOM1VL
         N8Kk0x+qXCvykVe2SdGqrjP0SDMTUQfnb+E8nzI7YwWUXIC+S7syQZPdrRoNc1MEylHQ
         al7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772216301; x=1772821101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMNuhM7y4Z7hySCCP9bwoDUIKI63MvNsZrVoSU50SCE=;
        b=bbU1E1A23P/oST1tC/htWbZ4WoQ+mus/9Gk8oyyXehy5IZm3ouYVjeMM6J7bkZ5xqF
         nrZvddteNx1LlNmd/sNGBaCf/H4cXtLKsXJKCE6kWxphmaYRQxkMreFJYcLlR0PEGFIM
         xfwWzTZDkts1OdCjFT04/OCJUcF5wZJthcsEY11KA/NR+1fdjucAOlwUiNtz64xdOqAj
         KQ6gwatR4fOVwz7IeOPUf81sVVwSuGOg9ZtPSLzFX/bAFkZ+HO6nFbT83A8VgJjbho9o
         n1zfWllg7EqzoE2zngHTn9vp6vBzbSBVx+L111TJl0zgmiPehJqRhkT3IrN9oKfQS6dX
         cIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772216301; x=1772821101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NMNuhM7y4Z7hySCCP9bwoDUIKI63MvNsZrVoSU50SCE=;
        b=GGIFMxdoagXNthbN2bPQlUpWoPDRhJi7n1O7NiDjGN2dIC+8x+WRnyHH9nGV0+WR95
         cwXvMRFDqleYfz3eI/TIUdkJmPYKmAPMCamtEE6mMIjvR+0W6CuM+VYppllj8ZBpvl08
         p65w9KvHWhfVGsmYFzf5G6Oj7jJS3OAWC4QlbzfchpEYOJlOM30qZxixU9fcJyS8Cp/M
         3NVV3qghN7sTF4wlBUQh/cu7ThYL4vqNj8WE9qv7GqogV2d6C3+doCcCIjroX+MNW/+s
         8bqIahg1js/MEBVHlNA2qE3eomuOhJ5w2ZTJqkUQX1ot+i9jfHlrpY5iRH4TJ9z9jzQ0
         MzOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzWSlg3iN9MP57OZVjAvNmkYnOkqyXUuyZwhE7hjLsnG1pQeZleDVIChIqISssRvx3VwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvekW8MbCbWfujKIcbUGLdqCoq/x6lbLu9SmWyvGL3+SoWBzqm
	h+FtKbpSJ3czoU7s6+Jh+qWfHfvhNrthB2huQL20S2IzEqYy+C1AudQdrmdYB5SlzWNipIB5OWF
	mr94o7y2wCszJZfiVwfNjeuy/nFsjsAY=
X-Gm-Gg: ATEYQzxTngRBqAOJR+6jQ0Mn1p3h9SUsbyzLJfVjhdFvgwdUE/iB1Y5EW3N/HVA8j3F
	8MTu3BT9wiG7V8b65qPXuHPl8ePHnBbDocoR+ez+MPL77j/BhNFoeek2w25aZvH6mEzJpykgXWQ
	fQERApqLs101InZB75ECiUWn6I0WYPZTp2QLQCF+uRyBfVZ7JeFYTV/zxnxkpZEC1e6CTgNo9GO
	SJlg5m+BqYU0yPHKTL29NBJH//UA2nhyhPQ1CshUB9dqn4t099Ein+TpRHx/HiCgxZPVcCw6AQ5
	Q8qsjzzmBWvUpu1VsfTs+lEeOLSNBOCIUVkegd3cnVddqgKmiVzgB/fn6CqlWok0c6gVSO44Sbp
	cJ0ZyJA1i91+Kjo3QqgNM+MDt/A==
X-Received: by 2002:a5d:584f:0:b0:437:7268:8e1e with SMTP id
 ffacd0b85a97d-4399de2cba3mr6429787f8f.51.1772216300720; Fri, 27 Feb 2026
 10:18:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227164037.84110-1-sun.jian.kdev@gmail.com> <20260227164037.84110-2-sun.jian.kdev@gmail.com>
In-Reply-To: <20260227164037.84110-2-sun.jian.kdev@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Feb 2026 10:18:09 -0800
X-Gm-Features: AaiRm52de5u7x-J2odVvUITF-GfaCVyn22iVXIPZ6Isfcnmemi_EZqJdoVNJLME
Message-ID: <CAADnVQLT8nEetXYDB1rFOqwgyBvowbafUzuz=7EBWUyVQw5G6Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/bpf: bpf_cookie: skip kprobe_multi tests
 without bpf_testmod
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 8:40=E2=80=AFAM Sun Jian <sun.jian.kdev@gmail.com> =
wrote:
>
> The kprobe_multi subtests rely on bpf_testmod fentry ksyms.
>
> When bpf_testmod isn't available, libbpf fails to resolve
> bpf_testmod_fentry_test* and skeleton load fails with -ESRCH, causing
> false failures.
>
> Skip these subtests when env.has_testmod is false.
>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/bpf_cookie.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_cookie.c
> index 75f4dff7d042..50f5e11e6e65 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> @@ -105,6 +105,11 @@ static void kprobe_multi_link_api_subtest(void)
>         unsigned long long addrs[8];
>         __u64 cookies[8];
>
> +       if (!env.has_testmod) {
> +               test__skip();
> +               return;
> +       }
> +
>         if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
>                 goto cleanup;
>
> @@ -192,6 +197,11 @@ static void kprobe_multi_attach_api_subtest(void)
>         };
>         __u64 cookies[8];
>
> +       if (!env.has_testmod) {
> +               test__skip();
> +               return;
> +       }
> +
>         skel =3D kprobe_multi__open_and_load();
>         if (!ASSERT_OK_PTR(skel, "fentry_raw_skel_load"))
>                 goto cleanup;
> @@ -451,7 +461,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
>         attr.type =3D PERF_TYPE_SOFTWARE;
>         attr.config =3D PERF_COUNT_SW_CPU_CLOCK;
>         attr.sample_period =3D 100000;
> -       pfd =3D syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG=
_FD_CLOEXEC);
> +       pfd =3D syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG=
_FD_CLOEXEC);

This part is not explained in the commit log.

pw-bot: cr
