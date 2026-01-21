Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DE1213E89
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 00:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768956397; cv=pass; b=Gm+z8cOde0iBvBEG84IqO/FBjAIULYGZF4Do1f9GVSVGjjSpJ58hFfIe5oKihfVbQ1vxF1BUazyl604vb6iEYvhVaLkN2o7Cq9Ms9wLIoSS9yEplNPnn4O+0I7d7MROboxmu64eafsZsh8Q3sBN/5PQVvfRxwbmTXUSiBgz5MbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768956397; c=relaxed/simple;
	bh=9YxTE+qpImx1TkMhz3pu4xHruQRHvk9dZqeyw1HCRa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHUYm1nyWqTniAuACv22Oeswobmdgd+NypRcaJfcLSt8hS77ChxHM5/9KPg8AOhQJHu986LviJGNUIY50XiKMIToOKV90vJfw+0SbTPi2zQr9OqDdHaDw5xjIoo9lYLF+dKhSMdWUEXEQZjsHOLmKuSP/NpK5FmfWAXOgMNciQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8ufp0TE; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8ufp0TE"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee301a06aso56470605e9.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 16:46:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768956394; cv=none;
        d=google.com; s=arc-20240605;
        b=XzfFU25clK9vnqvgE5L1KIH3wZP2wS371vChmBsEo1hWsmwU52+R6rupBIMy1HtOAc
         NvOUFXGyJERkfKeKbyNeiWjobIkpxmRn3axtKM0M7u4YNn/Icl5gDtARHeEY4kX0tioU
         nTeY28L+Wuidh/AiAxPb0LOYz4SBlDrrgAgNhed5+nXzYhdQ4V6P2GA1UfFJTTI2gA9u
         Y5oJSnzTRIp64QZvwRMXyiKjCGacSRAIvR8wVqrvwwLDDEmzuos+zBw99Z7KO5xdcuQd
         NLH75kJt8hd9vPNUJnstSPAEmHRVqFZLcMNAR1UYai4CP6pDm5s1fZ7k+ImRk5aWvQUV
         CqnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fsE3tc4+LXN/nWMFR0IHJ4kZoSjYJGt313l2jtEuqHI=;
        fh=WraqeYViXjLmeOppzytlORi9mGSvsU388X/tJc+DSYE=;
        b=lpmy84vt6mBTMFzKJ4SBIfkk2A7nSdMOAbpVjqeLIsE0f6URfWoxu4CAZzzQXECeb5
         /D7QptX1EV0YPt6W/wEd2CaRJe1gOybx77RBek4m9DW//dR44uwKrJPl43N4azqw4CMU
         SDNcdckAmVUMGWD5TCYxn5OuCGxHkABMap4wy99hej4bjbyd8uDJEfoI2akIS5soQz+4
         c5JLz31JvYLXCJGxJejNa346IxxoIUjmHFwAl1WtpCfq/bV3hQj1cUE/mpLuR2qTKAhz
         FxlawG4wtNY70QrLRJyz2FkavzoPkrfm7dGcs7AacNgoaf2yiUwuXg/Bqb/ngiAuPrZz
         uR6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768956394; x=1769561194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsE3tc4+LXN/nWMFR0IHJ4kZoSjYJGt313l2jtEuqHI=;
        b=S8ufp0TEQOU2D/sdIAbIUONup9Vcq1ugY70pYOrPmwQfoRjikPWTGdogqPUIMSTeOO
         Fs/XeNa9Do1GrsoKQ2jiFetnJGvoWWwFoorRlS58MdbrdlgduFqLwAYof9o7J5KT7BOq
         V3u8rVni1sdstgOXA/S8odhMXrQy+E1yULgjRchTew/mgPDfsNaEkIgNNGuMQa/ji8fe
         Kbeq07hMkk6vkhmx/ErrWF0QZskbv8O3ZPnb7dBLMoa5BWt9Fs+EBzpuGUnOF1593X4W
         /kiGtWTvqfSkr9+o4o3oR4z/MKvr6AOYPHxeZBHHJvwQ3tFvjPDRIhhNOG1f0OpYZlum
         l8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768956394; x=1769561194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fsE3tc4+LXN/nWMFR0IHJ4kZoSjYJGt313l2jtEuqHI=;
        b=qG+4Qu3Q9KCb46MT2JHgtZ8t4QWx6VQMJhGE8XEVGpVc/BMUhRw0zTTaA61QWwbvuO
         wmBA0lsCernZ3fF1dhGYLrs6bnrs18q2GjDx9jB63wa0ADUHtgeWCDqkL2/uL9KkEgWA
         jlLHm5hHumuOxrUrrACWJPK1nJw1ec3iWZzn7S2CiyScP7SRdoGCWM52T2lr1jn6vjQ8
         OsjDYSNVtTtcrOJujMB5+RtKv21Fmg2RoAJYrCQ3M++SMUmKvzRSOQqhh0Rf4NIpvcKn
         fcqFy8ziySYt1PtyzZ9jUaFwrrsCr7fplPmY0KCo1d9i+16cee/J/vUjEB2IEYEcF5KP
         m5bQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0vDrTQutbNkBEyA4CNE8/RheAII+PuTqpbryqhF5EHew4kfg6w4gLXArJIHFTqTFycnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJuWTBzJNY/z0zGd9yV3fxSLIvYBvqypxj1PW/zh33ijJMn/QC
	NctEdmDrjUaizXmmupjFfRaTt8bxwLfxeaBHUnQHzMkcutL6k73p7C7dx+KySLWs9IdCCAWMYMr
	Cc7ITJXjT+a5XSRCjpyt4cXvGChYA35U=
X-Gm-Gg: AY/fxX6fKrmi92axZvJFK/XqCe3AQNCErksf+Y5/cf+QHnaM+uM0MTvBE63PqfVjRgM
	GJlXXQMMdEVjuX8AraT8LLfHamzDfMrhlWhyBMLvKgPF2TC0fZyxeeNolVqBuJRDgkv84YNw7vd
	1vsafzn+dgzjeG6XXs2u4UJL44ViYhMIcqIir1xKI37QSDGjRV7e+OFp/MRAkYujMqjcY0jwhXw
	q+N5bR4wTVTIZCnT+k5iwtEc8+eSrjNBkMZX5JeMjATW0P9aH4N3+lxmybENkKacFjgE7z+P6x0
	CHYeNALs2Is5iTxI0qEfmKSzGBvOTlZmuhFpS/cGDSvK73JS1OVr+AGB2XLcBPt7YLAGIbCS/dV
	tcEeK9NYg0utTOA==
X-Received: by 2002:a05:600c:a411:b0:480:41ff:4446 with SMTP id
 5b1f17b1804b1-48041ff4449mr23126885e9.36.1768956394290; Tue, 20 Jan 2026
 16:46:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107203941.1063754-1-puranjay@kernel.org> <20260107203941.1063754-3-puranjay@kernel.org>
 <18201538f7dd8166dc0171b0970f15d4ab638f51.camel@gmail.com>
In-Reply-To: <18201538f7dd8166dc0171b0970f15d4ab638f51.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Jan 2026 16:46:23 -0800
X-Gm-Features: AZwV_QhuF-NleVCBPNh_sjGtWSnnifMY00X3ZdUsUBFxMfiLbNM5GTrghKkmSvo
Message-ID: <CAADnVQ+Bpd1HubKCP5Aui5Q_ukk-nMHAvmC2QSeUdX_cXg2H3w@mail.gmail.com>
Subject: __description(). Was: [PATCH bpf-next 2/3] selftests/bpf: Add tests
 for linked register tracking with negative offsets
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 6:11=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2026-01-07 at 12:39 -0800, Puranjay Mohan wrote:
> > Add tests for linked register tracking with negative offsets and BPF_SU=
B:
> >
> > Success cases (64-bit ALU, tracking works):
> > - scalars_neg: r1 +=3D -4 with signed comparison
> > - scalars_neg_sub: r1 -=3D 4 with signed comparison
> > - scalars_pos: r1 +=3D 4 with unsigned comparison
> > - scalars_sub_neg_imm: r1 -=3D -4 (equivalent to r1 +=3D 4)
> >
> > Failure cases (tracking disabled, documents limitations):
> > - scalars_neg_alu32_add: 32-bit ADD not tracked
> > - scalars_neg_alu32_sub: 32-bit SUB not tracked
> > - scalars_double_add: Double ADD clears ID
> >
> > Large delta tests (verifies 64-bit arithmetic in sync_linked_regs):
> > - scalars_sync_delta_overflow: S32_MIN offset
> > - scalars_sync_delta_overflow_large_range: S32_MAX offset
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  .../bpf/progs/verifier_linked_scalars.c       | 213 ++++++++++++++++++
> >  1 file changed, 213 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.=
c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> > index 8f755d2464cf..2e1ef0f96717 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> > @@ -31,4 +31,217 @@ l1:                                               \
> >  "    ::: __clobber_all);
> >  }
> >
> > +SEC("socket")
> > +__description("scalars: linked scalars with negative offset")
>
> Nit: I think that __description tag should be avoided in the new code.
>      w/o this tag the test case could be executed as follows:
>
>        ./test_progs -t verifier_linked_scalars/scalars_reg
>
>      with this tag the test case should be executed as:
>
>        ./test_progs -t "verifier_linked_scalars/scalars: linked scalars w=
ith negative offset"
>
>      and I'm not sure test_progs handles spaces properly (even if it does=
, the invocation is inconvenient).
>      So, I'd just put the description in the comments.

Going back to this. I think 'description' tag is useful and
it makes test_progs output more human readable,
but we should do something about test_loader.c
        if (!description)
                description =3D spec->prog_name;

since specifying a full description is indeed inconvenient.

Maybe test_progs should print both: prog_name and description.
