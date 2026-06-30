Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D46C47AF71
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853009; cv=none; b=DC4B0HQzcsOeo7nFELgt9LgzW86wmBAxU7uNQp6up7bfy/cIZC8MEchBWbhsiFFnlFCwnqhXfLvhihs2T3+lV2gGnTSDEQ9NV+3dISqOdBjqhDG2YxF948IhmHY51RFZNQKM7ztLMuQFmHuR70P8xen9WgU2/V1SvczMi9lggVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853009; c=relaxed/simple;
	bh=ld1EK44F94Iexb0qxSlrHxVHWj3CVMGNVdp/fJue34E=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=t68OuqN6jyIn/WG9ClONe5kPW3CguH7zg8OCzLUedW2yQZKSuG9Jgb+nAankqp25fth7d54JUOdbNXIOvQYPN+m6hsmpf0kx1yfbgsv6fkbl7jtN6Cp5WKFeLZPSTwWVkIVKgNupJK8QcBbsEi5jL6W160YIXnlOUT7YzJz/eho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlWfLUIq; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlWfLUIq"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e9b895ee02so3069380a34.0
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 13:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782853007; x=1783457807; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ld1EK44F94Iexb0qxSlrHxVHWj3CVMGNVdp/fJue34E=;
        b=OlWfLUIqXBJuECnBrubNj70YYTjxV+TG+dFSqAAtRBJ+WttAgJko4w3kPjixO/4AHy
         eG4Jiqp2uT7XYR6GVLJ0B0YXVzci2487DwK4S8DlYgTlRNw3GuqY6Wb7Bf9HciZEQF0n
         JEKElNYXgwxtvqshZ+TKvhE69FIJ6LpY4NX9tdej1vDZJXRt6ejwSS7ITNpJAj68dmXh
         TVE808NwA7fALCWBzNiDUMwjZelsE6aeedTu4uLPTyiKQcQLLDVmgPxkBq+iaKSqhtYN
         dtiNEiWbCrDQYUvI1muy2UPCTCDXGn0KAQ0yICyOGSQ+zcw8RI08W0h4x1f1Yt5XK0nD
         xe1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782853007; x=1783457807;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ld1EK44F94Iexb0qxSlrHxVHWj3CVMGNVdp/fJue34E=;
        b=d8UUGK1QjKrSEyyIXOkMumW4/oyCZgYNO+0iT4lTaQ9GlpZ2hLnrH6vbhMgmp9hOBk
         Iu9RoK48vEWxiJmrLC4EDfwD0Dhy7mn4T5kl6u9s8MNnW5UP0/17deMEvxtSY5BF3jme
         O7Qe1JppwfXXwhfobLNdzTpHIg5FhALtvsqZTXiCvkLdGsIU/xoNlyRgWJTBaTtuBIRS
         SEibrS8dA9E6beJM7cyxv18aX90U3C6jayle4Kf+nYjXGniUyXrW43TXZ7CJlwCkjixx
         uiEBtMmHz0mCpYwUC/endJGf/cBwH1HGiUrdq/ANikmIhtlurdG4Z2PNwPoBHqmzfKHK
         qP4A==
X-Forwarded-Encrypted: i=1; AFNElJ/5RXbCqyy3Th0Ch8u68pdm2gK3Tcc2Zjp9myrkjSrDhbUARQf8hgXojgrfFbbXSrvS7mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLIxplSbgQneqG4MYnqAnV3qZYO3SAVNfwpK9998EfavMN0k/L
	bySvIsnuAnpuMb3VLsFKr5spDvNdHlz3qpRixNeOh1P742ALiOjziynI
X-Gm-Gg: AfdE7cl8x9LgWCVC8Qr3rKVWhv/AYtOjukNRG6XAacpwb6NFRDrXV2gCbO0kReOC1AS
	olb29S6UKXJNa8QWUFzPjVvISxrW3jkmOCxrZ444zcmg7pSGTX7JuD1mg981WUO/FBZ0Ew9AC2z
	M85osbcFdtXFgcC7fjv31+JtxWn0kdZh/HkKAA2wVcCXHcq1ECuUi4AqlrtlYga1gWGU3KEWYNX
	ADzAsVu9BqMwI5khZ0wi04Sgnm9g+93jEAZ3EjEMs9xCrKa/1G35L/7VWMnQm/3GKhFIi2y05Qq
	8BiBr8nLOcI9CN73KBlXE+euGialkxik3Ut74mQ9llD2pYrKuVEuODIXQMCZYuzQJdtvGvMojaV
	EBnYfOFuGOj0yO+Y9hwgKdwf3Pasd6zloQ2nM4JNgO5o0rNEBTVKyMn2KwBywjB6d6OETgzuFu4
	I/54OVGDGBf1HRcZGQukE3eRZpjMOxD8QiXP9ZAs0Bk/ujO6J/pHEr3qXlu1SyKijomIIMnBJ5O
	+Mniw==
X-Received: by 2002:a05:6830:264b:b0:7e9:e860:6ee with SMTP id 46e09a7af769-7e9fc096ea7mr1417099a34.31.1782853007039;
        Tue, 30 Jun 2026 13:56:47 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ec307edesm3163887a34.21.2026.06.30.13.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 13:56:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 13:56:45 -0700
Message-Id: <DJMON7ZNGXAE.1VLWYJBVWKWD3@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Aaron Lewis" <aaronlewis@google.com>, <peterz@infradead.org>,
 <mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>,
 <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
 <jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
 <james.clark@linaro.org>, <seanjc@google.com>, <dmatlack@google.com>
Cc: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH 0/1] Introduce an instrumented profiler using BpfTrace
X-Mailer: aerc
References: <20260630141152.3757722-1-aaronlewis@google.com>
In-Reply-To: <20260630141152.3757722-1-aaronlewis@google.com>

On Tue Jun 30, 2026 at 7:11 AM PDT, Aaron Lewis wrote:
> I am proposing this patch as a simple way of turning BpfTrace into an
> instrumented profiler. This approach has come in handy for me more than
> once, so I felt like it could be useful for others as well.
>
> I am not entirely sure where something like this should live in the
> kernel tree, so I took a chance and put it in
> "tools/bpftrace/instrumented_profiler". I am not attached to this
> location, so please feel free to recommend a better place for it to live
> if this doesn't seem appropriate.

Nice work, but, sorry, this kind of tools don't belong in the kernel tree.
'tools' directory is for things that kernel itself needs to build or debug.
'tools/perf' is the only true exception.
