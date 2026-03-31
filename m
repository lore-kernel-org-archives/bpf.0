Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E6E1EF39E
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 00:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774916845; cv=pass; b=p0J7dwy0ucfIe96e3nGgQexq+GSJt6yYlamYAmpbWH/1u19ycgQW2h9JYRZW5mG77Jo1uWbpBUjP+eY78K2JB0jLanaNrdmgaWP30103nwROi/kgGTV7FUgE+d7eUaVoO4YV+AP3lFLRk6oO/9odafAp6ohosr+b8Il486X0s/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774916845; c=relaxed/simple;
	bh=kERPygWEL1qjRvqeyRoGHSpL4fntejX6/X2jBKv+Fmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iIkupCsFJJsELFxoNuUT6ZyfNs9uP27N4f+1S+m/jwMx6822kMWfRQCKAvKgOI7I6ZWuhOLn7TWKp5sJfhhLiHaPjhuIyw8+B3IbGDRZiEyXE2qW5PthCYqMAMO4RBbqYG7Cj/ltZgaDa6cgT7beqMofrIrr1vt5DfIgH0XO/FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjNRXlhS; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjNRXlhS"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so1382025a91.2
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 17:27:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774916842; cv=none;
        d=google.com; s=arc-20240605;
        b=fMhmIovb0G6GrPPD1jHj7BuTwwI1TQtHR9U9C3GVTNXVhtv4Zg2cfnOu2kys7zkIjY
         TAKnhr2gZ1SU62my2TNaH40Ol2ZP9/lFdKtyze5Z6LpvuKyZtT3ekX8A8OwI2YnUSx7P
         EyOVsyTUERpgJyP6ipvHVMcViVEoMh9wcvl5YLxXIb8M5DqOi0TQxyY9EiRaHfwiDaZs
         0LsuXaeMJ565sYAfn18pGbRJWprH8gxijP4tQ7+FAxEAp0HNfo06URbchsauUySQ9yAE
         aBjxUbqalueDdZGhaJwTMBBNG4tWg5a5uNgbyttxTHPyZpf/ct98p1bfJsKTxp8E6IMz
         X3mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bV1zvTVBJDQetKKLG1KF3LWsr2q7a35/B6YeMOV7Iz8=;
        fh=KueUw+c6/ETXCMzR119We9q2ik+weYZsXcfcTODf8pk=;
        b=UCW5Fy6o7i8QpkuSzPNJv7kPqcdm6SQy0dj8z6QnGcATcI8SpczvVP5qmmRmAGEBY7
         huf8jT/cW8hWpBN79C8gDXhzJE6oikQc2g2P2lKQzO1Pv8cEBp1AZ7BNtnItXbWDVpWZ
         +0jguI6s8iQ9E+ftlsqD5cdYn5O3uiu0f9gzrxHM/gb5zC9VMpBpO2a962l8sy0vagHD
         htoIfAKtpyy1emZ8mFGrlvMELWZIIps9KmjWn3TsIOmkuaGokoiLy80QOQjKgwv0U45O
         qbFE0mfsg5iKkbO5E8qgwHPMjz/pxmwaJg7bbmITHOqLAk8HJAhsCth+8m+JOMgPo7tl
         WNjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774916842; x=1775521642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bV1zvTVBJDQetKKLG1KF3LWsr2q7a35/B6YeMOV7Iz8=;
        b=NjNRXlhSSnibmUp8rx8DJ6gp9priLCH4K+a5JiK0cXK9oxWxU+Y+6WWVFyLl/zsEpL
         xTF3SMw6UFN0rMhjF3+1sOhQdf4CImyvgvsa6AOegjNU311ufamZAePcUSQN3mWiGz7N
         AURkReunoCh/98AhSMQRS7nDctsDxkh8c1T9oEERet2KkE6DW3/iCTfNkXr9vAf9pqgC
         K0P/oHV057cezSArZJyht1/FDY0Te8rhgNLAKe7IogBF8X7kVeYDIYttofdiTRULokI6
         ncyA9fNZ4Tqy0DIiH+Y40nSNkp2aLUsfK1iaI99bM1ZKcTvErExQ55z0PbTeXLXB268L
         iyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774916842; x=1775521642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bV1zvTVBJDQetKKLG1KF3LWsr2q7a35/B6YeMOV7Iz8=;
        b=ekFi3HG8p39Hv3UsdIi/nxkqCC3Qi+5zrusIfEDBNZfYkDKq7JrLZjLacFHDBu3m4Z
         maRWBsCJSQuUi1NrJ5wy7ArhcILBjimLsJyrRz8Bo6Y3mMZ7TpdtN1qYyhp10n7kIAxG
         NVat2AwAZ5SFOZIz1a3Omwve1WNIuWviZ2rKLaOq1t0uzrmbNFVl38jAgdgku9LH5z+b
         6779AnNO1BBwi7sGq0AOzz67DWqbEA/A9K0MyeEEy+IqNSy18XXYkRdeKE8nq57ucjyd
         BVQ8X77wxKHuHjoD9F/gY/jlw71NRuaY/RQzDL2+CcQxyUb6x/4w0KxU52fJYBflWegd
         AAng==
X-Forwarded-Encrypted: i=1; AJvYcCUN8qYY7Cf99K2FvC5MR3ugJXQZffT79L3qOOngG1zywrB9hheqFmGhIgiUWCF7+gEQ96M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyudYPXDX/Xfj1SdN98aEpyfEgXtIh4WwCoCbtgHFpeCB53cuk
	IieYU/zs+J5b2gft3/yM4o0kPxDrjzPFzxLFJqIQIcrm1dgBrKg7zHzvIvD0Ez1NTZrLPYlSSql
	1IHo0kMSAZ3wxW1qKitO+v6YoGe/0Ot8=
X-Gm-Gg: ATEYQzxeQmlY+qaOIuQgdXbMxHTJb6kyc2Z1lKL3yWBnCqD83SrR3g8aDD2tv9/2RZM
	D3zRlu5zAFuDr1QgJz+mLOTwIW9NKk4YzvwCD6APNpKdr0woSl4z849ZZJkfXwA0f/ZS4uVSMpw
	a60fmpk6WZNc2PjAGvmIXbaQoy4Y05gZwMDAVfZAUBpHiOmTIjgcZoGoHs05LyVD+cKqB+Y3FEW
	sE0UgwXpQYSBBApCxE/1UkLFu2Tp0BC88WNcrTiJR0McLAOmW7eBNOfEMkC9JSVVzDr+mo52jma
	YmEI8NrcyC0O2K0mV/2Hjus=
X-Received: by 2002:a05:6a20:49a5:b0:398:787d:4042 with SMTP id
 adf61e73a8af0-39c87b72f02mr9852496637.50.1774916842327; Mon, 30 Mar 2026
 17:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330121732.1601352-1-eyal.birger@gmail.com>
In-Reply-To: <20260330121732.1601352-1-eyal.birger@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Mar 2026 17:27:10 -0700
X-Gm-Features: AQROBzCUe5f0VP9qqEyp_EyMnNUC64LvIrc2YMlRdEgPe7Q8Ccu6Sqiwr23ebCY
Message-ID: <CAEf4BzbEMuUMZZwhPMEkOpxLxue26EhjUUYNYnDyUzMAMX6GwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: warn against BPF_RB_NO_WAKEUP in bpf_ringbuf_discard()
To: Eyal Birger <eyal.birger@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, paul.chaignon@gmail.com, 
	chen.dylane@linux.dev, kpsingh@kernel.org, a.s.protopopov@gmail.com, 
	yatsenko@meta.com, ameryhung@gmail.com, tklauser@distanz.ch, 
	shmulik.ladkani@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 5:18=E2=80=AFAM Eyal Birger <eyal.birger@gmail.com>=
 wrote:
>
> Document that BPF_RB_NO_WAKEUP is not recommended for
> bpf_ringbuf_discard().
>
> A discard done with BPF_RB_NO_WAKEUP can suppress a later adaptive
> wakeup from a valid record, leaving an epoll-based userspace consumer
> asleep even though data is available in the ring buffer.
>
> Scenario:
>
> epoll_wait(rb_fd);                     // blocks
>
> rec =3D bpf_ringbuf_reserve(&rb, ...);
> bpf_ringbuf_discard(rec, BPF_RB_NO_WAKEUP);
>
> rec =3D bpf_ringbuf_reserve(&rb, ...);
> bpf_ringbuf_submit(rec, 0);           // valid record, but no wakeup
>
> This behavior is surprising in the context of bpf_ringbuf_discard()
> as it seems natural not to want to wake userspace.

why? discarded record still takes space in ringbuf and needs to be
consumed by user-space. So all the same concerns apply here whether
it's discarded or submitted ringbuf record.

>
> Reported-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
> ---
>  include/uapi/linux/bpf.h       | 3 ++-
>  tools/include/uapi/linux/bpf.h | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c8d400b7680a..c46b06d45904 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4645,7 +4645,8 @@ union bpf_attr {
>   *     Description
>   *             Discard reserved ring buffer sample, pointed to by *data*=
.
>   *             If **BPF_RB_NO_WAKEUP** is specified in *flags*, no notif=
ication
> - *             of new data availability is sent.
> + *             of new data availability is sent, which is not recommende=
d as
> + *             it can suppress a later adaptive wakeup from a subsequent=
 submit.

NAK, it's not "not recommended". If you are using NO_WAKEUP you
normally would use it with FORCE_WAKEUP as well. It's not a rule, but
that's the most practical combination. But if you are fancy and know
what you are doing, you are free to combine NO_WAKEUP, FORCE_WAKEUP
and "adaptive wakeup" in any form or shape you want.


If anything, instead, it might maybe help to emphasize that
bpf_ringbuf_discard() does live data in the ringbuf that needs to be
consumed by user-space code (normally transparently in libbpf or other
BPF libraries), and the only distinction between submitted and
discarded record is whether application's user code sees that record
or it's silently skipped.

>   *             If **BPF_RB_FORCE_WAKEUP** is specified in *flags*, notif=
ication
>   *             of new data availability is sent unconditionally.
>   *             If **0** is specified in *flags*, an adaptive notificatio=
n
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 5e38b4887de6..96de37c3b896 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -4645,7 +4645,8 @@ union bpf_attr {
>   *     Description
>   *             Discard reserved ring buffer sample, pointed to by *data*=
.
>   *             If **BPF_RB_NO_WAKEUP** is specified in *flags*, no notif=
ication
> - *             of new data availability is sent.
> + *             of new data availability is sent, which is not recommende=
d as
> + *             it can suppress a later adaptive wakeup from a subsequent=
 submit.
>   *             If **BPF_RB_FORCE_WAKEUP** is specified in *flags*, notif=
ication
>   *             of new data availability is sent unconditionally.
>   *             If **0** is specified in *flags*, an adaptive notificatio=
n
> --
> 2.43.0
>
