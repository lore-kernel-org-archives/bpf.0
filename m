Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E845933B6FB
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169416; cv=pass; b=t9EWHhGEL89cehHSJy6o61Y3pCzg7/mfa5nBREeg+v6NM3KWRWLkdxrjYBhOcu057EW7gdrez6kRMf6/L8IwvYW8mzyRQ92DcdsTX/gWJQQNU9R3bVTDWW1sn3EmQgJl8tHvGResnl9RHRIlVl+MJRB5LVV8cSEnfSjwkHAsWPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169416; c=relaxed/simple;
	bh=n7ic3gYfhL1TuSGA3Cag90WAfIT6HgPxkZpOEcch0MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Si44awOT6xolUGxsd6CwtjElC4lc9nA6lBp7LuhFuwxmGO44bJ6TgUBXO6wvGqfn8WfJlYyGP/A/Zu9Eb4RfAzylYcnwA1gvj289wAITpSHxAW0htDAmtWGJ2NeSXyD5C5jsjfXamkKD+mGYpwqGZ0KJeRsGhvVAjNffbVX5+qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLzozGAd; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLzozGAd"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439c944bb62so4860217f8f.3
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 12:03:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773169413; cv=none;
        d=google.com; s=arc-20240605;
        b=kDKY3xLhHqyzNG/S3tUkuMilDvXuGz1/IWWxgVvPx1cLJrVXdXq5pVWHVD9Bsr77RJ
         esvygjbwJU0Eg6W2U+3obuwFPfJ4hPgzgOu8nWEsGBsc3+MaIG+ESD3WygVzuB0rodvF
         dMEn/dmPm+fpnv53WmKLxHhPJXpRy+NA42bw/z8lWcsLWEbSC7nABmzM2w1fklCQI25w
         AkTrs0pk6zMYbJBQoCM1/xu22giOG35wn/261sTdpilzXjJb7DXpTHlJzXQoOYe2UFHc
         nJrBitV3yQuJVv8qxmeJTCmSsMW+cR53Kd3RrzLOyXdhM7PThE+/HB0B76Gb5zwh9zOS
         3r/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HQtvqwK2M/MyTCPCbVjvACRiEE5Eom6iCF3Yl0jrDes=;
        fh=vCFZXLHZ91xto/SWU7YNkQvjT84FuwTSDkucUDHMrBE=;
        b=drBoypakkfAbuodxDbI0UYT59/ku17JNjKa68Myn1y0SQLrFhkhQBXhGCNPMLTo+2w
         ftC/FqxH/o1zopwOKW6k3gpCo9Cm6s3kcq7AR4NrvMp8tQgMaUdmCGyatFj21ajkwLKu
         nupIbV37IJiYcO0fUaEIhmqI1/5G/otJqOVj3WAn64JpiBQleuBkizkES/F38iCLhyW8
         HExJZ72+ELrhGUoXhWYBKF0VC0T94Gw9938NjBv0lW4vL4dGZ2vEkOcyIIHn+W1q8faH
         892KfOX5FXDGpi6XQU9U1eKP4NLRMRUt88Ixuns4BiiG3hlmfN8YX3ezatuHR79RcByz
         vXtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773169413; x=1773774213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQtvqwK2M/MyTCPCbVjvACRiEE5Eom6iCF3Yl0jrDes=;
        b=lLzozGAdwEjbvyfciJd1gnDsApiy+7Y55xcubJYhaLZW1mliIUwWayaNIz4SyfN1kG
         qZmOzkkh+J9/4Xoj2V70VYci0GobrJyJElibUM6SHSvwgjqpZQNUOtGIEE+Zu6URsG7Y
         g1XIM/nYdaNUNmcQr/dIysBrwcaQv6LrFZlK/NHdofU48vqDxxpvtF59Pakfdw+rt7NC
         xwiaDrXQrX6dMRVNSkR6TndU7scNZLp+A6BKEFsooVl/iNn+lM9RdJkiVw5ckVOgITay
         MIjl1AlmEQTaR6Eg/v2MBPPm/tOBGWvPK1goXHECh/Tvb+H0YStk0LPN4F7QrmLi93P6
         gnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773169413; x=1773774213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HQtvqwK2M/MyTCPCbVjvACRiEE5Eom6iCF3Yl0jrDes=;
        b=dKxHKLhMFmJtaJSpYipxBoQXdXAvc3kySa2pkgSZ4EvP+4pMd0cCZsI+1pTDc6lCR2
         dwm653wIWBTtMRjhy3BZnGtxVTRw1tz6Bw2f1Sl5hYn1Tv/sTnjgLTU27Owon1vAEZ4F
         jOCPhJX5fcIFLwpPWKScoOi+K8z9D3FkSet6qLUBzyeYhssMkzkq8Pk4qcQ6bXAhA+R1
         En9zqzvDGZSg3GOaSlZMh/U3QUdebiQgzRlbt0uBYrLgj0NbeMxG82D7tFVYiLdY2UXI
         AT2Rem7Jc4mJ+JhmeLSJP2waNc6cf7T55Fuon11C663sR9wmX1W0e9U86OSQG5Pl0XSa
         qWGA==
X-Gm-Message-State: AOJu0Yz8UW3seeDURP4i/k1Ym2SsDN/B7f9Os6dcrujlNUp7/K7QW6KB
	n4yyYl2uf1zCl/ex5HOjPG19tkdZN6yFjfvIYNbIp5dLoLtnguAc+m8t2Ml0S3HX1KSQliy8ZmG
	gp+FNcjoyZUvK/qZHga72PU+h2l+y3Lg=
X-Gm-Gg: ATEYQzwXABuF4nyOYTtHFkIQdysathOH9jVTUezYPTPEfNS9njT2A5SQt4BRUiZeS3S
	VdEGMCvIOA5gSp3mqXRztZ5b1Au3iWFcCpeHmvMKhlNivxlytW66i3zdmZ/2Ov75JxizMPm06Go
	lCaG8t9Ge7nMhh51hekfKgtncgwp7xF3La8hpeaEleSDUyukfh/zt9Gzb0lmmu3wRje1A17dcBJ
	T1jfTi7ihmUfjR+BwYcFpGszgzwLHI85a8SqDh30pcPyU3TkPVcfFynnaEKGRoFWLz9f4ypVL9R
	5yx5EbvpdpaWp+vI9IgT7N71GyzCDJlYMME7qYzctZi9coh7hYLgxURVBWksPNIEKg5zOhlPsLP
	IwBe+68DY+Q0MSR4aVuxs/rH1aeCaT94p9uLc
X-Received: by 2002:a05:600c:3b82:b0:485:3bb0:194 with SMTP id
 5b1f17b1804b1-4853bb00605mr133884905e9.35.1773169412888; Tue, 10 Mar 2026
 12:03:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309215910.4131143-1-qguanni@gmail.com> <20260309215910.4131143-2-qguanni@gmail.com>
In-Reply-To: <20260309215910.4131143-2-qguanni@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Mar 2026 12:03:21 -0700
X-Gm-Features: AaiRm505R5iTeQeb5NdncYVMDI_9KPkXTd0YT2yNPF25xD0YveARsQx4DHiTHKM
Message-ID: <CAADnVQK9+=rD92VHNSZGWzCaF9e=xwkgdw9agjh24ZUR9_B-9w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] bpf: Fix undefined behavior in interpreter
 sdiv/smod for INT_MIN
To: Jenny Guanni Qu <qguanni@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 2:59=E2=80=AFPM Jenny Guanni Qu <qguanni@gmail.com> =
wrote:
>
> The BPF interpreter's signed 32-bit division and modulo handlers use
> the kernel abs() macro on s32 operands. The abs() macro documentation
> (include/linux/math.h) explicitly states the result is undefined when
> the input is the type minimum. When DST contains S32_MIN (0x80000000),
> abs((s32)DST) triggers undefined behavior and returns S32_MIN unchanged
> on arm64/x86. This value is then sign-extended to u64 as
> 0xFFFFFFFF80000000, causing do_div() to compute the wrong result.
>
> The verifier's abstract interpretation (scalar32_min_max_sdiv) computes
> the mathematically correct result for range tracking, creating a
> verifier/interpreter mismatch that can be exploited for out-of-bounds
> map value access.
>
> Introduce __safe_abs32() which handles S32_MIN correctly by casting
> to u32 before negating, avoiding signed overflow entirely. Replace
> all 8 abs((s32)...) call sites in the interpreter's sdiv32/smod32
> handlers.
>
> Fixes: ec0e2da95f72 ("bpf: Support new signed div/mod instructions.")
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
> ---
>  kernel/bpf/core.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 3ece2da55625..a620d4d6f567 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1736,6 +1736,12 @@ bool bpf_opcode_in_insntable(u8 code)
>  }
>
>  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
> +/* Safe absolute value for s32 to prevent undefined behavior for abs(S32=
_MIN) */
> +static inline u32 __safe_abs32(s32 x)

Double underscore is used for helpers when there is a similar
helper without double underscore.
So pls rename this one to abs32() or abs_s32() and drop 'inline'.

s32 is the only case or there are more?

pw-bot: cr
