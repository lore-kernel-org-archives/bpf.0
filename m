Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793398946;
	b=BaDdj+fTwlBnYDt+6+qGu9aIRocmygog525LkUbSvGvdEl6obn+APM252mHcopJlvEt7
	 jeBcd9JmBVSYDWO/NeS9F0QemJF8j+0NsnDWMAM+xaJ0CjCncviZjSfXRnlpjFH3ZjjE8
	 18plWf+IKF1e45u4gtNH7j1FAcrIWklie3Yth94+BFggojbWukmGSb/JVDYkh62v56bvM
	 rDAixapWkdldbCNtv2AJblxYrgZRtFH65iZjdljx7SqVVtWX10vfc8qRgCHKar2y4qHUC
	 RHFW7Tp1m9PnUZFOsCYrvhGNgD49FuXDy2Nu0bsCtsBG4fwySQ75TiGChjn8WJFX6PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793398946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=dOhv0H0wKDT8tH3E7ShVIFIuKTH7HC8Fm0b689izP2c=;
	b=y4HQ7horPy57s7e43SrOYnmEeXl8IOmtfzDJw0vk1iASP1K1Wd3pfFNfmRAnn5fqSm4E
	 V9jDkUxb3Ex0aHgN5U9geZIMjmDbkthxACnjnX1UkcIUQatcVd4s/qNInAWx/b8/0cvpz
	 mnNyDifm10lv3WEEtD8B17W2NXn1ajicerZw/JisXqPWpuWGw8VHlHJNTHuxUOmaT0ydp
	 6s2YfW71O3UpMv4DiRi7zlwpa3O7zeTaCpctM10HryOtTgz9OG7Ok3pGCU11lsNE2Nfmf
	 xTY9sJfLqK5Nneu8LFpeBftew1+wJJUZT4Np0M4dHaF8ctQlNBOLQOGKn87BQRgcIhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0iaGytAP;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1697D606A331
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 22:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1697D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0iaGytAP
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-89f85edd210so484501b3a.2
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 15:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793398945; x=1794003745; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dOhv0H0wKDT8tH3E7ShVIFIuKTH7HC8Fm0b689izP2c=;
        b=0iaGytAPbeI5fAusmFtYFGoODd2Pg5dBYv6EA4h8rGqis1I/kVpxyMNfJE85eCvMEX
         jSBtbOpj6Ft5byoDf7xB829YoTOwazmdit0EgiNdTYE2eSsaQotwIiYsG2ABsmbQOWPI
         eRKmiSgmGzKK7uj4DAK0XM5YkUSuZySm92VWCWxGIwJpkp3g1H344tmn1VBQj2sQWjrn
         L9NuDrjqW2aF7b8RSRyxWkLJwYE5mx/Pclewy4n5MS/dFx4jgUp1n03gA1qXgWvkC2Fa
         8aXoo+o+6Nc4Z/6fX66d3Qujo2ZJiJNbayS5WvqSxiBSCA1RrVGZv3sGEfBnWPESZd3L
         VrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793398945; x=1794003745;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dOhv0H0wKDT8tH3E7ShVIFIuKTH7HC8Fm0b689izP2c=;
        b=YI7sI6iQUTcy3WLiqLQ0qM2r43wNaMCX5UiOYRyVNXgN2V2xAM9M64W0Ko0MBFnj4e
         1EkDhADYyOC6BQpEcViV1MI7yJNkL41/6dEMv3mUxAp+CjMPMU0rkZHKVbEJxh1JOKiP
         X8h2hytmg0vezkOGxRO3qonOUXvpAW5osW/tR4ldrPJoC0fhOFaWpp11JmXaaSgUETnH
         0/cCwkMduTvs8PmlGYxnzvkpHE08m4KTK/15qHApEr8FL6xtssjEzX49B38d2dTzNA1+
         ydzbAUIfB5IO2nH3+b5OTetTeyaE2WwVNc/smhS3ty9S2F1E3sqyO3YqKyc4Pw1RNCeX
         +TfQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMC9D72za9IdgwUgXKUwNzS+wdv9ozeJefQV1c2/1UUevYlsWwRfi3bykTUR6sZqVwPKk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7iJXcRbuLoDqiKeDgcpNqAJwtv0hVZwL+ST+98JwXl+lQZny0
	zdBD1SR56XLBW5BA0GsbHuUygqkmHyC08yeDAHTYNT+76R66ueBXeest
X-Gm-Gg: AYBFou0nfETGYD8CLSzbv6QT+KxLhpLmJy+RiyQ4HaFZ9jHGh+q5bf5lAc72leixTJY
	ToVWtNQTsZzsYudTZb3/8DbUc5b7IehF8YX+l5IVdQBx2hkSandeE66Q5lqE6sxFJE5JuEQT2Yv
	h936JsbIrnTmy3ZJg6+MbHnpZkMA7MYQ+RnHNhVcu7AGrlImt2SjbmI3GYurXbxVmtQDmhqD763
	3D5Rf4ertid6BaMrl4Ye/vhA7KdiAphmpfFfAUyahO0kMzSbtoQqV5HlY+KLfDXgzisDvcvrQis
	Xt8EZqK8polfewZRttcCQQK+ebKOGJdFHX3mcuoNavAGXQ0vG/uNAI6wFRvSvJZ4bz7pUI0fRnO
	0FabV4FfjW9oITbUrO4xs8dejsQGFCeEHE7dvDDItnCNTGjT9ES7I2T+FjcDxPv1eiwegFDOcbr
	j4Vo5BtCDX3b1Eek8qJ2OVWu+9USc+QNFjrZq7BMUPGWICN+q+qUj2GXUpRy1W6gdhN1/2PCDcf
	agQ5A7IpBL49tfDinHFygDzoQ0AF3ppgONV5rF0SbHneQDgJjW0Z3UeD5uDT4V6usPfcVgsIQFy
	+rA4q47HaRdoFmsoJGZJ2yLFBKEP7+4GiRTqay1F/KartB4X6WJ8UXU6nmScrFPO9R7rrgG14LU
	wXvCkHn1sKcoIUss9xmkjtNUB/20ee182BQ==
X-Received: by 2002:a05:6a20:c98d:b0:3e2:86b6:9be9 with SMTP id adf61e73a8af0-3e928d4687fmr3155562637.28.1793398945278;
        Fri, 30 Oct 2026 15:22:25 -0700 (PDT)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d38eesm414805b3a.40.2026.10.30.15.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 15:22:24 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 22:22:24 +0000
Message-Id: <DMIIV9CE0PN4.309YUGIXQUZNF@gmail.com>
To: <mikeba@sentinelone.com>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Shuah Khan" <shuah@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC bpf-next 0/2] bpf: Do not let preemption cause false
 recursion drops in trampoline progs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261025-b4-bpf-trampoline-preempt-v1-0-198dcdc0c6ac@sentinelone.com>
References: <20261025-b4-bpf-trampoline-preempt-v1-0-198dcdc0c6ac@sentinelone.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Oct 25, 2026 at 04:02 AM Mike Bazov via B4 Relay <devnull+mikeba.sentinelone.com@kernel.org> wrote:

> Is disabling preemption in __bpf_prog_enter_recur() on !PREEMPT_RT the
> preferred fix for fentry/fexit, or would you prefer a different
> mechanism for reconciling preemptible execution with prog->active and
> the per-CPU private stack?

No.
We cannot disable preemption, since progs are not short
with may_goto they can take 1/4 sec.

Sounds like private stack is the culprit.
Should we disable it?

pw-bot: cr
