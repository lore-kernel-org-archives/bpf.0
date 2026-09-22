Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DFF3B0597
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 02:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045795; cv=none; b=P8MTGMb1QFZUEK+/7pBILU7gl9zAKaojuddzW3EqMCWQiWIqaPvkdt6KLsr1+uEVwRHS0K4BLPUsVXOyb0iYBZ7jTqSAKIhpLmf36t8i90MQ0E0ud8sbYvxzNrab0RP0C5Jl4yPHIJTZgR47QIb4Nws02sRWtpAQoDQZmtIZnP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045795; c=relaxed/simple;
	bh=V10nE095iAxhND586WVi3ydp655144IJcV/JwU3ZZSQ=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:MIME-Version; b=o3BZs370dfDCgxuVU/WFY/wMgM6TPgwALSQvg7YYK4SFwfObvRXCwkOknmdRgoaBisXQg1W9XSMi4zPIeTCCDY8jTl5jbEvGQAr2PmmhyPQ7wDF0y1zy3R0wj4cjtcxcUqbeMTJCEG3tXNA2CpnJxxhbwiGMtn5dSwxI0LrwHm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUGik1By; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUGik1By"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d91ede8035so44328545ad.3
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 19:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790045792; x=1790650592; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qWn74aSe9vHqqWyJdcxw2M0E5GLGlq6lTeD93Rg+rNw=;
        b=GUGik1ByXFtUqtEX49wCZiYOdwSbf3Uuw6IDoNM3PmN24bYmtkSZ27aRizBpLoqY8Y
         sJstmzvU9QGfFfcQhgiTczZD9z5AaQ+/YZBQ88EEauQqC9Wgg7m7BiBmoK+VNhofMVLe
         gh0eGDYRUpcxboZ7piVeP+z3PANZrtpvwc2OSLODPbfDwcqxJxv7Bk7HonwA0XXyPv2W
         cnjjvzFlL+6h1P1o08EoVNhQHZlLBlZh5SM99UqhfCK/O5JziaQ2hI44KhMuI15FeQJU
         FYLx+x+V9hJJK/AtYrl6l92J/4B/7fXRvH+/8hftYcp9bucRyG6XBfzyk6S3UtX8iFbv
         wakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790045792; x=1790650592;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qWn74aSe9vHqqWyJdcxw2M0E5GLGlq6lTeD93Rg+rNw=;
        b=umG6Dw5MEa2UEoQRdZq8zVWLCihMfz/FnFHqUbhqS25fZQ6VjMkZk/OOazY3z9F720
         GjKskwDPLeV0q/Ud5KbprMjZN9n7PucRGpHY5u+Hr0Bhis+tKEIOMBo4f2C/SD8yd1I5
         ozyS3zVEU2H2n8zhnWrDPOexMu8QrNNBUspt7xDVx8+OfHjkMYzpCbEiQpwxpD20A5Gf
         rRgEw4J9BFHGn6t964h7KCBgyo5yIdjVmmR70IPrKrEPn3mwTvlHHzPzLSrE2v/VM6Hl
         UnSTaTQUPFYgWrHvecZHoOEZ3BAcoozILxG6bR4SEQHy2V5AyLHk95A/dQXN1tGxcoDD
         ntlA==
X-Forwarded-Encrypted: i=1; AKwUvBz3oGG3Zez6iBkTMPDe9lKFkKWrJzHzGSQpCXCcUU6gXr3AsCO98jGHWl6j/yERRCCyLMc=@vger.kernel.org
X-Gm-Message-State: AFuF++kcR3Sc/EL2SzxfYG1LlaweeXE+kwya0DsFXFyY63DaETNNfH4O
	sOdgoVVi8yV0FetfTozQ3V5yI4USLpFrwTSynK9vBv0KRYF9unZ5V6rE
X-Gm-Gg: AYBFou3l97S2tmZu1cxWpk+aMx8XenqghdjlJmNIbu9Sl0dbUw4C6qPcc+Ff7Gy4HEh
	d40u6/Xhz2qe1OiCMLopPm2jvaJtPf6H8t9EV9rNbTh0k0IluXUdkIDflLm/AtZYUHprHX/nNGV
	Qjn+ZCgDuOxzHs9QWCHbWcxLHsOnf5NJ7d+9rSnyVgUNRPJOu3V2/fHb+zEKeC42JSpj+hEp9Fv
	A9I8C6fGCvG26qplCTsrxwbYo8DDnOFt3VwTrTvw2BFNSAwDpD0CN09KLIImOmiLcPNGtkxXYdt
	uNPeCWE4iZ4YQtxw/K5ZrXYiCnBAuKEEFkxGn3aZYpGwlwufwJhKPEAk3Y3SjNck8tvggv785le
	oEMl6IjC0CSO7G9Go8VIeEpY439Zi3jbbbRoKbjidKMEPYk+YKjJv08YFVhupqS/ab1PqX2hRGr
	NSG1ZVz5Lr3lEyAXcS0SODUwpDky5uUfe6qNAz7TAFtJQ0FaXSo/O90A840vW1/lAWp4tk3eS1a
	qUCiImqUxbbhlPhd2Buk+lYJaAC8Lbd5PgIhxMB/S+hAlJxkCJ78dzxKR3i3nkTJOgaI7P7bb4d
	KbQ=
X-Received: by 2002:a17:902:d490:b0:2df:425b:308a with SMTP id d9443c01a7336-2df425b32c5mr75269455ad.42.1790045792325;
        Mon, 21 Sep 2026 19:56:32 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d019fb1sm1733865ad.17.2026.09.21.19.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 19:56:32 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 02:56:31 +0000
Message-Id: <DLLI9W7O2V5G.1PNFXWYX854FU@gmail.com>
Subject: Re: [PATCH bpf-next 01/17] bpf: Fix infinite loop in
 check_max_stack_depth()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <a.s.protopopov@gmail.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
In-Reply-To: <58bd021020f98b1ae36acbf611049344613d50ea0c768de4430c6923d3544e2f@mail.kernel.org>
References: <20260922011323.1298619-2-alexei.starovoitov@gmail.com> <58bd021020f98b1ae36acbf611049344613d50ea0c768de4430c6923d3544e2f@mail.kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Sep 22, 2026 at 02:01 AM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
> This looks like a bug fix for async callback support. Should this include:
>
>   Fixes: 7ddc80a476c2 ("bpf: Teach stack depth check about async callbacks.")

Nope.
No fixes tags was deliberate.

