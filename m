Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE04481238
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 23:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781653188; cv=pass; b=S1RWIDV0bwcX9YRZ9H7w2hzcbGBjaipB38taSM+NUIYsM+H1YgDRJeLfXWw7WzK75Jz/5BHMF3RxMDdoE3N1WwYnMqoOYKuy18vetcqAwAt6yFzdPfHr/mUQ3+fXJbxln61zsjOtlWl9jtovCAIYuIy8BG1TdGWvdh8quWnk9MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781653188; c=relaxed/simple;
	bh=XmOobbcIx0izCgE120HJyOufL1h/F+Iy+jEL3VrEc8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cc/oYjydqA/UptMwltFhoqf2m9uuQST6appfgux7j92TOZaG/KpLcrZyNifqQf2xE8A8U5kHWvwSW7K1tNacthu/Rl4a78464YRoXxjoov6qj4DaibvISqQGApszrteHG82+Z93RaXfqQcuRXfMX02bbW9Z8XGEtBMl6UVxwAGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJNWet8P; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJNWet8P"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa68cd8dd3so4733766e87.0
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 16:39:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781653185; cv=none;
        d=google.com; s=arc-20240605;
        b=hNZjShkoZYKo8t3vjwXZup9BkGT2klIMMEkZQSSPGCjk1SyhHiOo+VPPXAfbbBjKVC
         X15DkYk7w9aEJNysgVJHEU4n4DYDtcQdbnL60A01Y0zs5P/FX9n7DXH0cPBvIh/MHIjM
         k97Y51Xrxhocu0i0ctEpJcVDi9rIXDC4I/Ptkqs+XTAVcdMvBUdOPGiTU192ZdZPQ2T9
         Sk/l02cO0qQmXDA0tAEDvzgnA83KT0PlK85wm/S/vGUuUgNW2qlr1cGgq6DmqJExkqsv
         PSOGeJlXlJYXVAP+mOCVdHS8Sa1q2b0RMtFSADgDk1P5OzyCg6qpnHZX61Fq85/LzRTf
         yndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mddNddDaIG0ZR96uwWDwfEtHxSh587LC2kp77pM2O+Y=;
        fh=VgbTv1hXY5DQTLydI+NGg4b+FQQu/Xm06m54azm4NXQ=;
        b=RntiitsONSmPpYdoo4LR48PD2DLsRz+mMqXIlyeyg9jgjMvD8/mPwqxwx8iHnWEOS8
         ZjkJkmB4YvhcyPiNd1yLg6fi79WCrOSjsjPVWuMRutB6YrxlthzFSk78+28CnKJbGVxU
         cnoVb2aFbX/X+z/sKWc1oM1dgmUjMnxGdZf6MWc0zVzASC0ZRF0wIV8W8KZZJOM800VE
         Iq8iMW/2ACN0qV+djgvSZsPSE1FeOaC6GA8hqACL+CkskFYkJWKbdWiPURQPXaGX2boF
         9KRZNgAQx7vW6QhXUOedp4mMZUX052+GyH/4Mx8A5AIK0//u0jBceBKOQlV53QAu/b2i
         YC8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781653185; x=1782257985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mddNddDaIG0ZR96uwWDwfEtHxSh587LC2kp77pM2O+Y=;
        b=EJNWet8PORn0GbjICOzZGTwvvWz00W9suPQmMQFcysTSY402Zaq3BlbI4NSAKTDeyo
         DjWoelX012UeWVKg2VVHKGXc8tPL3GwL3c+VEIYA0ptg31Wy2fstEJLG/PctnjmVJIw+
         Nnk5/cWsVNQ5dYpGEInUjNkWooAWGUE+L7IaP8w77+G5FfTuPiw7QLfeLTq4oWqvU2MB
         pAi/mv61jyjWGB5vO0mgwNtMHu7pZ+KNvkKinOSDSPJzPqDqFMxj9vSRrz32HXMbPmFC
         knMFNvrxsNcgRrWINdb4Jkj2iVP93Vj591AjfyFpoHn4DhXg7uuuedhSzhpWmwLWt10C
         s/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781653185; x=1782257985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mddNddDaIG0ZR96uwWDwfEtHxSh587LC2kp77pM2O+Y=;
        b=QGNOzMh3V2jJg5rIf9ypisVMqwIvlqF1dqgd5zUDFdbtquUG0QEd55fTLgUKrn3BMm
         +UaOInaFIvSv8IeKEQse/rJ++4rVSiRC7r3cjt9oLVRy98y5n/JLyQ3wn+vyjs4IJuF0
         mn//sbbpuzyiOciB5d15wiC4I5+/0F+DPYeDEbp/zA4n3LSCkMBlmdCxqWW4wvsxfQbn
         S8qvyeEMmUhsNNHDCjOrrfLcNkfOeRXuJ7TJ1wXv8E/sL2J/0XIetyzHZxWAAJD6iVZb
         5DONJyDHbakl4PSxMd56oovqUEu59wOlBhEZFQkDK0TfJwxvAHG3DGTV881hAlglaLws
         i3+g==
X-Forwarded-Encrypted: i=1; AFNElJ+KXvPeWLv6RytyJ35f7iM8rIoO81X1ImqCuc5Kmrmd96OZZdMOzB7tbG8Cy+8t4c2CCmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyejOBA0BejVB9QdBmZycU2NbodBWzQQvdMGCr6/aj3L3gBvGlD
	wbPKcNl51u/ml09UZpKFO6Kgp+Lc94k/sB5u6It0CxZJ8XCTRqTZH2eZnemVfo4x7RzntO/+CkV
	0sxV78WQwpDUI7VGpBmeZH0blPj2FSnc=
X-Gm-Gg: Acq92OE1BBZrs2LFRlEz8H0eGIGttbpWN38GrgWTI+g4DxSQT/59M8DkoP/hGBJKlX6
	cJ2yfk89DsjubXI56NW/AurZBJfNLZ8QlHmotN4hK1ReERLufhJqY70mRYwDz9om4labc6u/Sz6
	IYjkOWcVI8+6F6eXbr3pEB/GVzuYUEwPsXmffeMmpvoEuqMJXk0cS5/PyRbirVeFBU9TwqWIBXh
	DUehQvBhrsiEej+63MRc6mzOO3T09pKNFu8xJ8bPFakqe790FwSN70bAdaC+rnCU0OSZ+k8o/jR
	fiPR9oPvQ5yKoNYcIqjr1saijGKzdiP355jUqqUBMMKGqLpFNRPsliABkjkoFsLMM1jM1pkRWqu
	nuwq7Y8ChTaFNcqug43Ag
X-Received: by 2002:a05:6512:2346:b0:5ad:484a:7862 with SMTP id
 2adb3069b0e04-5ad484a7a4fmr118116e87.40.1781653185179; Tue, 16 Jun 2026
 16:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
In-Reply-To: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 17 Jun 2026 07:39:06 +0800
X-Gm-Features: AVVi8CdpYLkUL8a06nTZS6Iw4aJCy3VW8vs9Sfl2Gzs2tGm4_uuSjPvxJq5RF90
Message-ID: <CAL+tcoDr0gtCPeGi1yOUtg+ZD2YxEbjAy41LBgG63b8-=CStcw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] selftests/xsk: stabilize timeout test behavior
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, stfomichev@gmail.com, kernelxing@tencent.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, tirthendu.sarkar@intel.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tushar,

On Tue, Jun 16, 2026 at 11:50=E2=80=AFPM Tushar Vyavahare
<tushar.vyavahare@intel.com> wrote:
>
> This series improves AF_XDP selftests by making timeout handling
> explicit and fixing sources of non-determinism in xsk timeout tests.
>
> Patch 1 introduces test_spec::poll_tmout and removes implicit
> dependence on RX UMEM setup state for timeout behavior.
>
> Patch 2 fixes thread harness sequencing by attaching XDP programs
> before worker startup, removing signal-based termination, and using
> barrier synchronization only for dual-thread runs.
>
> Patch 3 restores shared_umem after POLL_TXQ_FULL so test-local
> configuration does not leak into subsequent cases on shared-netdev
> runs.
>
> Together these changes make timeout handling easier to follow and
> improve selftest stability, especially on real NIC runs.

net-next is closed, but in the meantime I'll review the series ASAP.

BTW, another thing about selftests I had in my mind is that are you
planning to work on this [1]?

[1]: https://lore.kernel.org/all/20260520004244.55663-1-kerneljasonxing@gma=
il.com/

Thanks,
Jason

>
> Tushar Vyavahare (3):
>   selftests/xsk: make poll timeout mode explicit
>   selftests/xsk: fix timeout thread harness sequencing
>   selftests/xsk: restore shared_umem after POLL_TXQ_FULL
>
>  .../selftests/bpf/prog_tests/test_xsk.c       | 96 +++++++++++--------
>  .../selftests/bpf/prog_tests/test_xsk.h       |  2 +
>  2 files changed, 56 insertions(+), 42 deletions(-)
>
> --
> 2.43.0
>
>
