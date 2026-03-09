Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BC03E8C4F
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074937; cv=pass; b=S9L8aMcNX83jE1JUEG46WH9UHyVnyc8sV8zrIDtFkU+7RYI1yVhz3FtnYq9Qi1SSUlvI7rkCZl80SzUqwKLGRUQXfnKQG1w74mXs9A+8I7pzmatsocBfQJFnx4lqJ9Dtkz+9m1SHBatPRcXGPgNzz2j/mC6TVJ2wz1dODO9U/Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074937; c=relaxed/simple;
	bh=ndiI+5e2qokbpwl5Npe2qra9pfrRd3RkLXwlNs1Hgvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s930FfKf75W/xcFKgHBW8X3bmz0D5jjIFraN0nBiQIu/0JQHcu+eaT7sS3bjKEhvalkHMhszlMw783vGV62+CKWblV+l3L/r0lm1IZFmpkYgRpG2MDiPa+OeIZNzGm3tGAaZzrm32imLAv3qUS7JlKTsItQumQEEMzAL/pdFL6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElLygvww; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElLygvww"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439afc58ac7so9213677f8f.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 09:48:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773074934; cv=none;
        d=google.com; s=arc-20240605;
        b=ZXKVzFLfKa+EAJD36h6ylf2kW+HaHD2AqBgMHjRGvCjGMEXshCmIM427H0T0SH8k2f
         lsJuJIamGhzVeQNjJschnCTjCmG3GijT+7EmwAI/EVJqG1lhL61fc4wOM3x9EvQ2aoZN
         V2LiSz+iz1kb4hWK+U3hZiaPXC25sMwJx475pHpCGP4INk7rw1ZdKNdJIyn8+pSiIS3I
         p2+wF8LbxDBt1Sd68qQkMALNkckJu//y2ix+lTmpjMMwKOO8YGSE618N1EGkN3BUfca4
         L9FwDcQdy4UAL06ialK3ZqHQFVfZ4ShvuJHrm8Vq2qMkfChYOeMxQOD3CHAV+PgF6gKz
         4kww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L6LHMn7Yd4K7bjqzuN31F2K3jppZLazeBRFvGS1MQ2E=;
        fh=QWPamShyA1J/8s5doFWE3PWqLapUJDuSRevdrJZqM+c=;
        b=GS7GRe3ZvAbxp9UtTN9pfHnHDreB86VsE9z3laA5MgOkczW4EQxX2dyWDcUTOy/wlB
         GeRq9TiNyLVJW3VC+YZWftcOm86/5eaS9s8WTB5oFPZ5qx6K0VY0YS8/xrUOI/p7T7dM
         2uLtZwRaOTZbqhULvl+PQ99Nr9fctl8hdpROD66HtEhdIHKjtl/3jH7sNAyCB7lBmDzH
         Vx8im1TZNTvwm1uXsPs4Yn515bVYfBKWawh/xVXNhy9an4vhP4oFvnao2cM+lw/UeVH/
         yCGijkjxCr24IkWbwYAqp3Q6gZfkVcXh792BQMUakNMufn4RhI6g8AJg13569vYGJL4Z
         TtiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773074934; x=1773679734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6LHMn7Yd4K7bjqzuN31F2K3jppZLazeBRFvGS1MQ2E=;
        b=ElLygvwwv8gsjmWOi02swK5NU671ppElqkDCGdqCjDYkWsufyol9EJNF8V+bNtvjSg
         UWA3GbWqBwE/XE0TpFEb40TIHrlIczC0kMpeNn03tJep1pW0EioCwGXpo5o5gcmxmDmV
         y5/tACG8bs1PzzAc9ZuQnHHAp4lOyY1A8P2yGibV2L5ciAHHsnQdY43shn7fKp4nHKwc
         nJvcEf1odLjrOW6PAJPHWQhZp4vKERFYmpEOb+nC59uV8ZaMWq62e4t5pe+g17TmAKhI
         6kCDzt6CJXz6WVuR/seo5sSr4QHL35OqMB9gH7Dk/jf00Bh4REHtkeORyEgf8ybM7k8z
         RyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773074934; x=1773679734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L6LHMn7Yd4K7bjqzuN31F2K3jppZLazeBRFvGS1MQ2E=;
        b=OY/IGDtVXAw5Gc59/xqJvjekPKTZ1boSIn+VrLpikTiYe47RiC8SZgDs8Zz4lLL4Iv
         HaUyZ5HH73X7VtJCweLpjC3mU3U4sktASguOMQUP1hDxW5rgBUePfJJCbbYGTeiYG6Po
         QRTnO3C54e/xU82qOUVoXvtLKw8MMZkmgj3i0KZ7LMld0B0EMK4WPnnuuglTzENVeMjk
         Jml/T1EnHtCBRR1nixwooyP7de8qst25EcZB98Ykj59wMkmsbnlLuQCOGsjc6BP9zcCE
         6vgp9MnZpVqyXTHvR+MtcrIGvJ/SiYwcPAH+O8LpwJxkyK+IWcx0LrOcDc1ozdzcNGeH
         eJDQ==
X-Gm-Message-State: AOJu0YwQ1tGUOPiT2R4diRfrr8iHTQh2bwayRm7MRnGsGYg84wOHrRJT
	uSQfLNYnP0kdIYMXUd49EkbY4m/xiSlk8c49jToJ/u9ArIx4jLUDrvGiZtuuMTIBLHLiGmOqZUu
	okdGaLwWXUiCKEznbIFzLWJkexg5OcPE=
X-Gm-Gg: ATEYQzyeTwaxYm1k7e3QY1wWAnsOTcoXyUxH3mji/iNChta+jwZSFQAWk5S5dhUiJc4
	E8V5XWyhMvE+0CSk9jK0mBgKDecnGBEWfm3lG6+1pXCyoXVXmv/UJDU38T+6XykxN3cMIsTQOL8
	Ev8fvVo4T7GYoMJrG7jpzvka/i/MBO3xXBvGePm9Xdv/WqfRWjtP+sQOhA38Ac8iXcaoJIPH9N/
	N5BlVA5ozcA055Kn3oSt4594+iPWNOd0FOqW7IeDhj/cL6KE9j8hVmLjS39/J8Vopry0mPoYj22
	3pgd4WaJOxGQJwNKieKuRLES9u27mc/G3TLS6DO4R8gGuLiFBUlQ/3NLyifkGdAixwdsg1m4yHo
	pDB08/YJFOEx8eqM+nRSKbSz67g==
X-Received: by 2002:a05:6000:2881:b0:437:711c:8754 with SMTP id
 ffacd0b85a97d-439da55541cmr21748704f8f.7.1773074934386; Mon, 09 Mar 2026
 09:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309155506.23490-1-puranjay@kernel.org> <20260309155506.23490-3-puranjay@kernel.org>
In-Reply-To: <20260309155506.23490-3-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Mar 2026 09:48:43 -0700
X-Gm-Features: AaiRm51Kl7ghVP1QfYh8EewJRjWa6NZ9DxX8nb_0pI1IciRpzE87meQOoeeN1AM
Message-ID: <CAADnVQ+2FoGYUapuXQUcCEerjfxqFSSUc8vwg4q8TN0GVwaS=g@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/4] bpf: fix mm lifecycle in open-coded task_vma iterator
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 8:55=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> The open-coded task_vma iterator reads task->mm and acquires
> mmap_read_trylock() but never calls mmget(). The mm can reach
> mm_users =3D=3D 0 if the task exits while the iterator holds the lock.
>
> Add mmget_not_zero() before mmap_read_trylock(). Drop the mm reference
> on error paths via mmput_async(), which is safe from process context.
> From hardirq/NMI context mmput_async() can re-enter __queue_work() and

hardirq can reenter __queue_work() ?
Did _you_ think about it or AI told you?

> +       if (!in_hardirq() && !irqs_disabled()) {
> +               mmput_async(mm);

Don't respin without answering the above.
