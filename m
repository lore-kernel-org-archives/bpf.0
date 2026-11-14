Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794690793;
	b=hihvWktvBbpmOl92KxS33ZdTmT5V4BSQ+RU+RKmkq2/w4ZfiW7j02yq6E9OueB6Gpsb0
	 WeJqf+ru9RBMb2I3sfOqHAtkZaff1paweNj+MTFOx96O4PhVX4YTq+rqiQLNznai83JtM
	 GLBoqDhnKJEqZeskUKsLRoNdyHZaLKPI7wOPhTYZEd/4Lbern8hKym759LotTtWBmUCBy
	 dLfhltP3BqXXPKpXr1E3TVGytib67xiJMoTr0fb4YgwARvNi28hDWSnintuBv3yRqocDo
	 GsJ5e3cmHqJ1cZpCE5yL3QS6hOWeA2ih15C2zBYSvqa9vl2HBSTqb3W28uOdxNfcm7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794690793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=PpB05K4skC1emLlG9OtX+GYG1IloZObFX3r9ftCARAU=;
	b=aDSqQSDn+i1Hqz0Ye2Wiw5gbRz6877kRCs0v7I9zfTe65ISSpDmJsQOKvRv1BmQhrFl3
	 /+0z1BCdOzTFMJFsJR2hSlGKstvLDB+cwrOuiROFhQO2kV3lWhdtPaXPIEYsbHw3OOb7y
	 shUh4veFx8UF045tx9fbe4D5hStULIu7i8iYsWJNsHakBouBu4dilqqxqAUCPRQKBG4GS
	 7mNdEsvyQN5Fi1KBOHusbvaZKUyZR0yV1eQxJfQGn0+clZiDfJjiq7213qlNfXHdhKma6
	 JePTbp2ytk0pV0gFLKK4ip0ptny134aMcQMG7qeE2VHlgZdm99rtQ9gDuJSSXNb66Bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="P/Z0LGsj";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F16F606A327
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 21:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F16F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P/Z0LGsj
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91ecdaf14beso32254656d6.3
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 13:13:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794690792; cv=none;
        d=google.com; s=arc-20260327;
        b=IOaXkgMLaXzazMkxReFU4rmBM5ZtisZrBH/OTjZEM4hAq6XxKNhHRk6N1KBrcLKM18
         33hQujHbb1Td8xtcHw2bsxHp1Iv5lOumsmtM5TDKpUXRFD+ASvnKMHBWs0c8yLcXDVmp
         OesiK/sf/dIJyXTvQ9W2yCqX7hTUbQgiUW1Ft25wQZJWp/UoIakz9BgFhz2tlAqSZJXZ
         VwIBHnEU8HGTKhc7lndQtVvS7wLZk++9hnw3b5Na4KjAQOdPS2TjgXUKXK17OinZHl/v
         Nqbgkj0kM3rKAty3ibZRcPLgy4uFytK8AkBUZZdmOI8+26A6XngXnvOCSGj81U9jl+vF
         Qidg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PpB05K4skC1emLlG9OtX+GYG1IloZObFX3r9ftCARAU=;
        fh=GheExqJTH7N6zcLIqNH/G2Vw6y/RVk0i0QD0zEdvWA0=;
        b=gntvA8CBP1BKi0cEYNkcru7ieHDxJSJRv2vLjAvSu7s60YXk0DNf4vLtPc6DsMVbuk
         i0coF0qGbmG88p+KFssGWUTpv5OL5Emnvy31wUEbmQPMcTKSEDtztyfjpE189Rcsgu9W
         G0ApdMWyY9CbfHff42f705OqglLQ4bytXdceeaigLw3FCMlkbUYwY7aTfO2XSd4upW5+
         RjPE990Cgyhwcggfd37xZiPq1ezLgKgDk5ddwbdRHfsyaJdCor+dUWAVDN6DyK1613bO
         LP0W9KqwPUdRfDPqELeAwIyw/+FF1KgsujnyoeLf0Hzgz5U/k5UYmvS+mhvCAtpuNwSP
         fagA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794690792; x=1795295592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PpB05K4skC1emLlG9OtX+GYG1IloZObFX3r9ftCARAU=;
        b=P/Z0LGsjFNdHcMO09zvHksR+bfpb5dGIg/o4DRYNynNmRf8eHXzLIfk1mIUlajyjrh
         lqV6wLaEwxDKbS2YcQO3b0Z58oNEJwVu6C0sgV7APzCevpWKdKvKBEuvr3mHM6J1cndL
         uUXwrwNyXuCr1IeFvGxoi6+lUhdZcBctppx61Juc0PZeNnARo97vUfbEqe1EagFpSKIX
         1w8EvjZPBsBAKf7nfClRCNKwYG49bV33ErvbW5xQr0wPiEtVwJ26vhsiEpZ4s8Ic5oc+
         WzFj8BOLAWU+ZfsKHG9skG/sdTYID5zS+fJprJdAb/3WwCbSWFoWtRUW2VxRgevGeDt8
         ERPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794690792; x=1795295592;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PpB05K4skC1emLlG9OtX+GYG1IloZObFX3r9ftCARAU=;
        b=PMGCaICd5jz3nRjN6zbkaymcchuFLBMRxDHhvj1O7k4TXU6fbNmtPDfaOsrEpM9CC7
         K975q2TKNU1A4QFSV7q+TY8OzBrTuCwisNzeGv1550a/8SdftK27aSzD1UZEmQDF0BH9
         5cBlK4zb4Iz0++512cMUjXkMzyC+pRm0nzzzEdIIf8AfkAe5h+1nzfknEI0gNHq8FCYv
         0KufP8/PWXPlHl/5SiupOru3EZ/WihsXc2xXdpB9zfpORNFNaPJU8mGEXLda+JDvlZge
         UqWGdD0Extk1pQy0AxZVIJMK5fIkTbwgj4FTivoplWugr6hhJfTYTSignv5YGgvDZ1wo
         Nmiw==
X-Gm-Message-State: APuU4Z/Jt8ZRhuM0WWhW5r5xN7fj1OLaIqHflXoaY6m4irtb1FPABH5a
	TA9N3vC9Q5GvLalFcRrxmDRxx3yt9vQJTInnqGyM99eBtV0fRswxDdS3GjroykJlrlhATBHuSgS
	HkUXt5gt9txzIP6VX1ooJC2Ncb5/Uipw=
X-Gm-Gg: AYBFou3S6hm2XATxocu+zcnAcGQrxiSEX4DwiAIufjMp95ZsE5SQ3DIcBBtadTQ9drs
	e9bU5jEz5KDiKPaFOucHldNbi0ESRAXKNZBYwdtEgfRGbA1nkOry75SejQOp2Q0enw1YobL0ImD
	uR/EoB4J8qjAaWvkJFPtoFkhLfJkpwCrhL+GxyOLPOLw+wwSLQvrv9ARJxPU7R/atQn4KabDKqe
	bVTR1Xk7duVO94k1MpNC2EeomYxpHQU9ccqMK/WL2Xr0Gf73X2c7mgKVJ+am+ndDcZA0h6zMJUM
	kyel7wlkmnD6HxCy5HjUiE8u7MTplDdEs3SjdvBWaikBXWr7h0h3APbPg1YO8voN0aQze1uQ447
	ZJYF5TLFDqEKt31zFDYOYsUlcw9WwFH5HmIgzdjfMm4dA2Lj8m4iF4knDfFJsBqJdZ7k=
X-Received: by 2002:a05:6214:428c:b0:91e:9a4e:8d0 with SMTP id
 6a1803df08f44-91f2402589emr105540266d6.6.1794690792477; Sat, 14 Nov 2026
 13:13:12 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114051805.683966-1-alexei.starovoitov@gmail.com>
 <20261114051805.683966-6-alexei.starovoitov@gmail.com> <CAEXv5_i17dJmGp3y_0U_f_xK9-SyC9M4GkLCx=pT=4VoXJ4abg@mail.gmail.com>
 <DMV78SSW0U92.LH9TAXR0MZ5O@gmail.com> <CAEXv5_hR=RNzwqYB=q=X_CiYSq6E2if6YaS1TiVU4LMvzfnmNA@mail.gmail.com>
In-Reply-To: <CAEXv5_hR=RNzwqYB=q=X_CiYSq6E2if6YaS1TiVU4LMvzfnmNA@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Sat, 14 Nov 2026 16:12:59 -0500
X-Gm-Features: AclHuK_EB_8oB9F8X-mCotwDkPHEFlQit783I3l0g-4CEgjIQgITfIqqd2TKXpk
Message-ID: <CAEXv5_hV-D63Modihc5yrkmcfwLEptyR5Oz=aQC+sbgXV-GnQA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 05/11] resolve_btfids: Tag the functions that
 return errors
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, a.s.protopopov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 4:07=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
>
> On Sat, Nov 14, 2026 at 3:00=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, Nov 14, 2026 at 11:37 AM David Windsor <dwindsor@gmail.com> wro=
te:
> > > Do we also need -EBUSY here as an exception? crypto_enqueue_request
> > > uses it to mean the request was queued on the backlog (not that it
> > > failed)
> >
> > Good point. -EBUSY is not a failure there, -ENOSPC is.
> > A prog that returns -EBUSY skips the list_add_tail().
> > crypto_wait_req() then waits for a completion that never comes.
> >
> > In most other functions -EBUSY is a plain failure, so means_failure()
> > can't drop it for all.
> > ccp_enqueue_cmd() and qat_alg_send_message_maybacklog() have such
> > a backlog too. All three also return -EINPROGRESS.
> > So drop -EBUSY only if the function returns -EINPROGRESS too.
> > crypto_enqueue_request() stays a target with -ENOSPC.
> >
> > Here is proposed follow up... other ideas?
> >
>
> Looks good, selftest looks right.
>
> Other interesting edge cases my bot identified:
>
> 1. bit_wait() in kernel/sched/wait_bit.c returns -EINTR to report the
> status of the waiting task, not to indicate failure
> 2. try_mem_charge_cg returns -ENOMEM, but callers might not be set up
> to handle it, it can be masked by __GFP_NOFAIL. Such callers won't
> expect an error there.

Not sure we can disambiguate 2, will try later.
