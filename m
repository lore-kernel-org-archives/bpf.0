Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C9A2FFDD5
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 03:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781665839; cv=pass; b=gE0AeP5GCljo+MQ1Wzg8PZl/0hWJZICSQlZZFmcjoeWSzT+a+m4//y7Qw9XPS4QQq3GCa/1WX+o2++WmCG+FwXM0X8DwTbwWQyMt60So8OnZnEqknc1WVPW8k+SHFgrh7wLyOqya36g1+f/N/1RxJf3T/fAoZhbkut0yQ1t1rjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781665839; c=relaxed/simple;
	bh=qW3BsbQGsGgKULV+hbJJQuiSOz+Kn3lDvAFF1WmVP9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQIXqkj8sVVDalSNw/1bifXtRKgzJwoMQSBCmXfwo3BNMyreImX9/XIgJExk64rNQBWlAJyssqxLnd9rOYyThJx7ySAJ+smM1/1FPq87s4nYcvmBgete+3hOEf2dTtmk6YyA3uEtx18EvlAALdndAKc2iCOL+5352bzL8zC4OCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oQwMjOJQ; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQwMjOJQ"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so2325931a12.3
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 20:10:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781665838; cv=none;
        d=google.com; s=arc-20240605;
        b=MR3AO3QSbjkhFeRLvRPQyxvpJItUPrgoeWb/fr/0SaxWWP9jnY1gR1aT3DifY88OPW
         bpmj8+vpeg4Q2LElYT0sfr9BX45IaueAub5P3P/9Go23V37l5aoXV1wwU+BwBJZRGLRV
         pAqLHEVTmKeM9uNTZc+UHyQ/JyBJXHE7/t58xQa8z2zR9Ioy1BS894+Vth1MY4DIgECP
         macsdF0SAFzYTV31Lu+EglGzIYMxQcKnr7ZbShau+jA7hjosss1VJxuDcg7gF5zzpSoP
         4UVqlUyjvJMwGP4ZcHEqpw6FHFc7GUVHet4XD0MiA4iy4i1ZcAgKV1PBA7fCWT3uZYvD
         tCdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B9qnaTblXj/mC0G2wqpgdmlyR0jIb0R2Ou22Kr79vAs=;
        fh=o+DsUVZyo+L+fhRXP5dQXgQK+NqiON7HNgeCLFtwjPg=;
        b=eAvuL/0+3HCC9QJDq4tFZnOGXVfJH61sOLmGwD/J0DAq1wAxV1Ebq7gJNQc+tEDh47
         FADZhBuU7U0MV3aiSGnyIvzquQWY/cjNSv3jTUDvw9CoOkDEQYNCumfmTpCjTDcvdeak
         uhq5RNKCUxwZHuuIP9fMGvq/fdyRPUCSQpnCArNkZoUzOg1pZmORM2q5GQq7bz6PcmQp
         PzBpZcrAuagTPmcsCC57otZ9BiVdkn0UGWyWWLqWvQA5ctuyg5NhqaceWS3iY3411u9B
         TibO8EsEDHSPOX7yO1ioAe5Zer+bwaahQ5YWpodzR/u8ZVloZlIsSVsmoraLtMgfU16W
         iBCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781665838; x=1782270638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9qnaTblXj/mC0G2wqpgdmlyR0jIb0R2Ou22Kr79vAs=;
        b=oQwMjOJQuFjD7/KrNVYg9punGeV+QqkYjFVulASJdV1qtHzQb8Fxb628Mt0xyoEPiU
         Rga3/zakCQsdCPZf60O3QvicpNj6lAkkm/FxXulF6+hknx7W4WhArDQ/x0QxL0WIAh74
         uaRiZ/caakdHS1LRyhhQYjxFbQl4ShA1jwzXhOnMhScH76lRyshGhy0PjhS3bPAvhZ9C
         y7lOwn90iBA6w9aH0dBS1wGB9sbXUQcw6KfpFv2O9kaNASI2lHk1iZA9Qmhud7lmGRpR
         xF8GWH7MzNpbE248cjjxBnvgRw0EaGH//5Lo6n9NmB45iPMXzTQdAE+3idDrTtkT33TU
         FYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781665838; x=1782270638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B9qnaTblXj/mC0G2wqpgdmlyR0jIb0R2Ou22Kr79vAs=;
        b=V+YQ2k9nV2JGcNl8gdmqJNjGihiHSr/EYc4qXIrgoC4Z9FuEEHSdfCv5wRzAozfby+
         r1hOV5as/N1TEflrjZFf1c+FeNMsTlwt6wc04fAjGkwpSUi9lit3eDRLp3Nx6HfHpHuJ
         vptymQY0gDA1uDuYzIQr1otBGZ5rnnVwrn1oXvbuosO/a+IC7Byuk56ciBO9yriifmig
         yVEF/eYo6LHWo1JI7Zmx6Xl02ICpj0xF/VlH2EPuAnepOKNHxWrhZOcKIzVuJCkH7cQa
         k//XglkkZMTP/0h4FvWWKt9deuWDFQKxQhFVkVVLMun+Ux/w7xqycsyK82ls1IVSI9Iw
         OIcQ==
X-Forwarded-Encrypted: i=1; AFNElJ8rC66cIzw6GaGw7e5HGMGRtUwOMCOw+a4yWaGlmU35pso1YhcO6nkR3qfPRzws63HDQlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvnFVFG57o+zCzbbbHSN4JI4ZQzeXsVx8S6G9D4sibBd7M1bn1
	2cRNGmcReS0TcYewXzcplYDj0QUhn/9sVy4CF/l3yMqh7cKp43MOa306EjM+fWdcU3SL7eO7j3R
	F/JjN5+6LRDIT3CZ2AivfI+2DmiFTFhc=
X-Gm-Gg: Acq92OEbjqlk4cPyqjnhHKEHm+I0+SUq/e1EsGWZ2HpwCqkAJffU4WrS0GcaCmTnUeO
	t1EKcY51yJQC5RUak8szp+HlRC5NXNH1VoRDs8gn2jN6fboPdsX9lLWfxyB22sfghYZqW95xSyI
	nRYTRwUbzwy1GvSwwYRFxAfDJjv32R7TkCQ5BbJfE/qB4u+20nZOgfIxYY46g1QAvH/Zm7TS1iZ
	YjaKleA0UEaItR2qISK+yXS7w49lKwafF08zp6KhE1pcaHNxuOdF9TylWJWcXa8ouqPQjh1Wnwz
	RcfY3Al30sUOl2+iUfVjcbneXWG3v35z8K5xZuvTFQhBrs1o0L3U/lMEc858GiyZP6gf1LIfq+E
	YdLU0WOG2J9NAPQ==
X-Received: by 2002:a05:6a20:7f92:b0:398:b95c:51ed with SMTP id
 adf61e73a8af0-3b8b7eddd0amr2155474637.35.1781665837570; Tue, 16 Jun 2026
 20:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617011303.3969027-1-clrkwllms@kernel.org> <20260617011303.3969027-2-clrkwllms@kernel.org>
In-Reply-To: <20260617011303.3969027-2-clrkwllms@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Jun 2026 20:10:26 -0700
X-Gm-Features: AVVi8Cfc0CqsWHOwbee6X-rMFuNMy0GR6Pg8FpJSFXk-J0xJ0qCfLErAPY2sjx4
Message-ID: <CAADnVQKniB8TLvQkuVaPb4jrKLR5G894bMEOrT+GxzRxqgPVdA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tools/lib/bpf: fix const-qualifier discard in resolve_full_path
To: Clark Williams <clrkwllms@kernel.org>
Cc: stable <stable@vger.kernel.org>, bpf <bpf@vger.kernel.org>, x86@ekrnel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 6:13=E2=80=AFPM Clark Williams <clrkwllms@kernel.or=
g> wrote:
>
> [ Upstream commit d70f79fef65810faf64dbae1f3a1b5623cdb2345 ]
>
> strchr() now propagates const when passed a const char * argument in
> newer GCC/glibc combinations, causing -Werror=3Ddiscarded-qualifiers to
> fire on the assignment to next_path. Declare next_path as const char *
> since it is only used for pointer arithmetic, never written through.
>
> [ clrkwllms: only the next_path change from the upstream commit applies
>   to 6.1.y ]
>
> Assisted-by: Claude:claude-sonnet-4.6
> Signed-off-by: Clark Williams <clrkwllms@kernel.org>

No. There is no reason to backport this patch.
Distros build and ship libbpf from official github source.
The kernel source tree is the source of truth though.
From there it gets synced into github automatically.
Anything but the latest bpf-next and bpf trees are irrelevant.
Hence, please do NOT backport any tools/lib/bpf/ patches. Ever.
It is just a waste of electrons.
