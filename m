Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795479473;
	b=32Lii6Lnfse4COJp1KSkXdBk/ayjZzHWk8uo6vWni1+OA/12lQNAQdWOXzhPB3VyHx7v
	 qHbcgQ1hmFKjr+/eUrEQzXNOVsuZDoJgoW/Gw93F9PRaKhOyNK3HigTFJRlNolhlXPXkH
	 xkl2w6wfjbfDK3l7xIaYgrVeAI6r5zLXnhbOqbE+zhRs4wGFDXq/fT9MnvkWH7eevuGsY
	 ObZpAnvWKNvYabrur3OG646SLYKKd+ojrPJggQ/EmKjNwXLKbAttidaPIdt7tGZjWmSEN
	 xSwAdqCjKjF/++hMsk8KiEEoTYowEIHEqn2+o8+potH77rotM2Xkqq0L3fRNVMYHA7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+f8XxVCKUeDTBInFaSnUJudwLzQYi3S7MYVKIfTz7Oc=;
	b=fzSc7feBjq8yTwDOmnHhfse+yCUE5UUY4Gw+n/VkPw3CQLGh8TO9op6gimJ2WJG0ITea
	 EVJ5t2s+/S7nWtIG0gqynz2hfa9BWwvZGShX4PWuXiQVee7vpOF80qzJvHdzDJlrnUZdY
	 MZiXnJyibm/DUn0Ho5W7qpLmXE11LcqwKwKpou7PKETL54Hc2bcSzLrArVX3Pj9We1+LC
	 tRfNrG4nDH5Onm/S7g5ZILeOhhLUvrmtHekn0S7d75DCll6nzv0Sy21LKzAXJB9+C8MJk
	 QbqyLW13vHPrIScnRXwCeel7vjzba0jPXiephUOgfsUyRcI7I8X82/F8y5ES1kYAYlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PxhniXz5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3695B606A322
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 00:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3695B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PxhniXz5
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso43764525e9.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 16:17:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795479471; cv=none;
        d=google.com; s=arc-20260327;
        b=QbDWpGMdkeF07AW92AVKa15+TDIqNRn0L8mmgJcwOgk+CwbXL6hY+NALDEPbRMo5gK
         LbGGkL4XBV8LeZAFOQT99ugNkVM7Y0nqob6ELR1w5tC1ovMG7Xh0rZB9G3TkUqCbEiWZ
         urYwF1xwSqevG3VHrcJh26rz2ynad+xvapqNtDcL7c1eomCU9oidvvqlyULYJHLqTvsE
         AuXDLRxhFXxjMdUIqHJrWS1LAuwf8H4D4kvg2s0AwCezlaRxESfHs8b1WiKTZYQBqNSF
         +XQiueNQqV8j5BUXrAFjnS33jJF3KR1FJnwkfEEuu8q9QqULPhU1CJrDIaAz3fghj+Rl
         LprQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+f8XxVCKUeDTBInFaSnUJudwLzQYi3S7MYVKIfTz7Oc=;
        fh=Vcm9C0oxHigm4jT5I8ZgLB8JxajdpGkvZl6WXCN4cdA=;
        b=BkIaZTsUhExJBhCxjA+O2OP6ng7dOHamXbmP1s7zmcoUknUkX4I64aerYm00DViUoz
         JrAtraF0HbcFsUjOLoTMdm72PnjybI1KRFmEOHMq3myYiBfzgT4Ho1kVbi5YHk+I7Wu7
         ESB+O/zut1oN/iZnV1XOLqyWHKZrzKQV6Pr6kdrW50UFb87FJhosQOqQ0bncd7U4+Axm
         1kQEr2wAdBFd+i51b9v8Z/yL2brGHKgtINdJZTkcgqqg+JlAmxCc5xAMmmyhb8gPv9/C
         l9rx1Tm+QH+kV1bEdS0SgySkqTmN+/ylo2I7h8/DSYjad75uCqEd8Npcr95t42XkaLgf
         CUdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795479471; x=1796084271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+f8XxVCKUeDTBInFaSnUJudwLzQYi3S7MYVKIfTz7Oc=;
        b=PxhniXz5jQF4hgCrFr92HbnEexVxKmoD9VBYCGU0mXGRGi4PgEwMOSmeomKaqluo6p
         k1Ko+X/GxvUaQdfcc8nxrEvq2JRw+wV21E07uPULK2bS3YC9qumSaYGuQtm+HTYW8Zco
         iCB5lVjpDpdzwfX8bR/giXmI94ok0iNU3IjoHBXmQkLvSLCrinmDwYVmOFMUIqKK8k6Y
         0ueoukijZeOXNyEQ01eSB3QMOMFz2s9HFNBpuOU151FgGxivNhFNObjU32f/t9xPRAKW
         dZTWPLl0jYP06RPZ1XNm8igIeMmSY/Mfpd2v3F9bzzGZ3DCg0GieqPdWzy8tSGexAO8F
         ikhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795479471; x=1796084271;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+f8XxVCKUeDTBInFaSnUJudwLzQYi3S7MYVKIfTz7Oc=;
        b=cXPZQVJV3Vv6IkzKF9qqExgUbkfhkjKL9kSF5b68NJ9VDu9P4sVXrhRgkk0ee85iAz
         8zC52+k3rKZYH9q41FvRBRBGFG0UbTtyxcwkkd/eVvIK5TUZEqWA/3L2xAW494EKmxcw
         Y6fXP/+62thIpEvR2hjs1+etNeKJc+9M7Ox9KVD00Zjhmo05NMntemWbkuY817/dB3ii
         GDqsRTyQArKx5iyQAAeOq17Gx5Cp3BRwnYCPLwwya6DBSl6fMVAuW0h5gZOVGpUSC3Jv
         SvFeYp3SQ3a6p60FFYKSPRPZtW6N8XtPVvB7/6j8q4hfEdZyKjts1wedLaSwMz5ItwqG
         PxCw==
X-Forwarded-Encrypted: i=1; AL+hErHl1QGyaCk3IAwcyxHP2R9ApzEiVkNRePcWiqALQAKlIrPtMFt7xdEHaWD7L+JPH/J2BRo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/mQBFcjQ68X9ddqsq7JETpjosLaqoBP8XnQF/daBeUZAaXg8oI
	HbxlkmP/dBqU5wBGEXvW88mZfr+UGyarMqez5Ra2T052XJ/q6T+D+2sJahxBitkUDhWVYHkK5O2
	soo6K2xgHCTiO1Icm5Xc7eAKXQ9kXwUI=
X-Gm-Gg: AZFdTZf2T3/NU2qOWXCITh9IrhbnWk2nyx8aYEurvMkpPW6qUnjXIGgoK0/fbKvFEd6
	PEjcCsmwvxsFzbBUZj9cEiaU54WqtG+QHyVbmvKA5GDoIDYpmxq7QKSBFFoZ/6XX+SEvvuNRJOi
	GHVKxGNTaP72OkkFtG/LbXBHBHm1a1FfcoeKtai2Xu53T8p51JEgI79tUJdiwDV8p6Vzihc3Ojw
	IECsHVezaWMh3M21aNocOZgdUOs8rZGJKy0NBfiCG++VtFDv0+5XWSV7MV1Bn/BTnSHQyvd/eZQ
	v0pt6XJr5L//xkXHk/7oaObeyUmobbuE2bwiZapkO9jRq/G0p2WnQL3xKURUUseSAf1AJGzH776
	MeswrmD4OPf+pJvv5kunW0GXbWsOQepT8gHpizRF3lPbLqUeHImUU7yGiy1xNgyvq6O+fOu/lpi
	ye7jBXBi1PvUybw7roIGhs8cNysuV5k6Ko+WYMEa83IgY4LnR3gY8/l8I=
X-Received: by 2002:a05:600c:1d09:b0:4bb:66fd:ad68 with SMTP id
 5b1f17b1804b1-4bb888160cdmr282174825e9.14.1795479471368; Mon, 23 Nov 2026
 16:17:51 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121012402.84848-1-tianyi@cloudflare.com> <3adef4b4d528780bae31f2fb02d0a08bf9c8ebd5.camel@gmail.com>
 <CAG4wq-f18SHytDb39SdJYzRPk-dzECjH_HCSiMGAQ721Zmfomg@mail.gmail.com>
 <CAKgT0UeWWherBt1MDcPF7R7jxt6E_3peo8VuxrgY3JdseM-0rg@mail.gmail.com>
 <CAG4wq-dizUz-6GB8Aj1wRTQBOzbHbT7pX9gom+AhR=5OWSyjzw@mail.gmail.com>
 <CAKgT0UffmbELMsGi8HRfu62MfC9VRYZ+TMNKFjZMWJyrV4t3jw@mail.gmail.com> <CAG4wq-cG1bseTFczZTjashN75J1Jsrv=u1ccuRsY-N1kZ=SXXg@mail.gmail.com>
In-Reply-To: <CAG4wq-cG1bseTFczZTjashN75J1Jsrv=u1ccuRsY-N1kZ=SXXg@mail.gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 23 Nov 2026 16:17:15 -0800
X-Gm-Features: Aa3M54pXq6mr_CU1bdkLP3MSJC2lLz1GXmfjYby6zsKSTGadaC_FLxjN5Btbots
Message-ID: <CAKgT0UeNyyXKARjKR4nVVxNe3UB16WuXqxSz0cf4ZvCdb9A4_Q@mail.gmail.com>
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Paul Greenwalt <paul.greenwalt@intel.com>, Alice Michael <alice.michael@intel.com>, 
	Eric Joyner <eric.joyner@intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org, kernel-team@cloudflare.com, 
	tianyi.gao@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 3:26=E2=80=AFPM Tianyi Gao <tianyi@cloudflare.com> =
wrote:
>
> Hi Alex,
>
> Thank you for being so responsive, and I really appreciate it.
>
> On Mon, 2026-11-23 at 14:42 -0800, Alexander Duyck wrote:
> > In the mlx5e case they were disabling the feature via the private
> > control flag if it was enabled. In the case of your change you are
> > just disabling it without exposing that it is disabled.
>
> mlx5 does not change the private flag when a program is attached. It
> sets MLX5E_RQ_STATE_NO_CSUM_COMPLETE on the RQ, and
> rx_no_csum_complete keeps its value ("off" by default).
>
> > is it falling through into the CHECKSUM_UNNECESSARY path with all
> > the indications that a tunnel was still there even though you
> > stripped the header?
>
> Yes, the same path as E810, and mlx5 does the same with a program
> attached.
>
> > The issue is that the driver is making a number of assumptions about
> > what is there based on what the hardware parsed for headers and such.
>
> This was discussed in the thread of [1], including the decap problem
> with csum_level. The summary there was that reporting
> CHECKSUM_COMPLETE on the XDP-to-skb path is unsafe, and that the
> safest option for now is CHECKSUM_UNNECESSARY only [3]. The decap
> case with CHECKSUM_UNNECESSARY was left open as a known problem.
>
> I am also working on the long-term design in [2], though there is
> still a long way to go. Please take a look if you are interested.
>
> For this patch, my aim is simple: stop the "hw csum failure", and
> make E830 with XDP report RX checksums the same way as E810, i.e. as
> before GCS was added.
>
> [3] https://lore.kernel.org/all/20260721183256.6f49d6e1@kernel.org/
>
> Thanks,
> Tianyi

Any reason why you couldn't just strip the GCS enable flags from the
rings when you add the XDP program in ndo_bpf instead of having to add
a check for every packet if the XDP program is present? That would be
closer to what they did for the Mellanox NIC and wouldn't be adding
code to the hot path. Then it is just a matter of also adding an info
message that you are disabling this in the log so if somebody does
have to figure out a regression it should be more obvious.

Thinking in terms of what the final fix for this might look like,
currently the drivers are already starting to carry stuff for frags to
determine if they support jumbo frames via frags or not. I suspect we
will likely need to do something similar when the time comes
indicating if the program can avoid corrupting a checksum or not when
it is stripping headers.

I am not super thrilled with the idea of this becoming standardized.
In theory this would be much better if there was some way to pass the
data out that the frame was mangled and what the checksum adjustment
is to the total frame. As it stands we are probably going to be
getting CHECKSUM_UNNECESSARY on everything even if we don't expect it.
For example I don't know what will happen with an ICMP frame sent over
this tunnel. I assume it is likely just discaring the
CHECKSUM_UNECESSARY since it isn't used.
