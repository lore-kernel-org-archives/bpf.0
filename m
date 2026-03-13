Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAA4301465
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 11:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773401777; cv=none; b=nTO4+bhHXVKvvcdGpaO9AxqLUxww8g86NKg36Kb3px2Afzfo5fxxWEnqvMh/gxIX+Dc9t4XOanETqMeNUy1So1ekKGzqfF7R/YQZo0apqvzbTQ9x+x5fTV/v3o/tpkK0uLWSndEH7RKYEreHLEB8MdLHcNyPnj1oDTrI1Rgg6Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773401777; c=relaxed/simple;
	bh=zbnmbvx3Jk25z3T1bwi++rWqTB4lxa9PeRrwh3KJh+0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oKgl5+nILf6IkjErgmzYQcOUATdPnJZzGMloOzjpJFzPwuwsO0hBpBgFtsOcLt561XL2dSpXYtT7nyS5/4ozuFeZlaODqnoLA7B6qS147m/elUv1b0A7TTpY92ioudsN+NqeJxTxhpuXba8d1c8V10alyh1py0nM3IiN7MSoFng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikRzmEgk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikRzmEgk"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852ff06541so21148795e9.2
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 04:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773401774; x=1774006574; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+IJmKt3wVbaZFfO9gU6h0/558xYI5FTfgcRJD6vcrEM=;
        b=ikRzmEgk0vgRUgQLKu6oFakvbI4wb7QQ3sDPeq3mcKrjGV2bEhlEJSj8QblDy9ObAQ
         HvasG4cgp9i7F/aU9nCadzsYLDpU54wG79IX0X6V251npzheUABotfNd8f58b5sJfYZZ
         z5VwmKbOrQzfBhtUKmI2RgcW/Ja+LtzYuMzlUBV5VViK5aSVuq+RvOwcRCbvR2LGlLB/
         RfjItdULWl2sphsF5kh0ubzeWvFMQ2o+FpP25lvd6dKnbhg1z6R7HOx35vs+gZUSZi7K
         0pf/1JEow1MD8YEY6MVhWSDuu3tCEP80IdB50+rEU1kf+UhjSYhzu2PnpEGvPKQIy4mJ
         VrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773401774; x=1774006574;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+IJmKt3wVbaZFfO9gU6h0/558xYI5FTfgcRJD6vcrEM=;
        b=DS7ubRvnSOGGAR/KzESyBkqyoorwy8qsiLHkuRtFwfUcGKc5ho3CNiqXraiQ4fqUg4
         qJPwqpEUHuKaroHW3l2R31tQpg6yhcFAuk9AnM31E/h1a68sRv42wpLjd0g0tAMK0e/Q
         6EeLxXBKV16j2RpNk12xunzRFbP3hpOxOUXz96PY8gmrxHauaTr9YdBjX+2IHJsNMkr7
         +93vFh43kXG1TX1onhepLQPGij268IwMKLg5O02FytAu9SIrOhv1eXxbILgiIYLOQ/aM
         c/QgEpLSVC7DI50+yKOVRF+J/kq1NZnjKk7BOuJwMtrRW50C0yIYJMtnDy5wN8XuSyCd
         1OoA==
X-Gm-Message-State: AOJu0YxfNEpRhzlTf6GGY+dCPREzhJd3th2TGnFrWjlyxo9vE0aN7IWo
	h00rlz+Q0Oiaxg4qooJNMCUEs0AHEkJHlwJjSxEnLeYLA+ap28x5FtPlB99Oerp7
X-Gm-Gg: ATEYQzz5dYHDAf8mkXp/Hq1ujZHgiFvBKZf+/UI7rhgEKIKxoUPeWAsGE1mKExVix1t
	KYBpyw5D5HMUFHoTDxzbt4Xe4/q1V6WaJnJDJ/kHc6iobu015kPox9tDrlVR0mj5qbODVRLytfL
	0p8Zk4ilJETXuMEOVkOvbOz6O7cOlg9x/sZ7DoKjzrwL/6QeA8mYBbwXGUKjeA1F9XIIL4Yqusy
	1TOSCu92mZ/SXzf9id8Uq9bHciZdy/Doo8q0CPTkiGlitFkmkvQXJjJmCNU9hHX3NjYm7g2al/L
	oka6xRbXHTybzibnX/MOZ5QiBXS57WXhBzQnFRWw2uRXojE10n21vPJ8hcHh+f6K/7M5rciE3pQ
	3K9Bb/9OV1OzAr7kDKRx0wkFYpwbgpFHeaRsLKIKZXGuLrzrG4osIL2InEUDyXGh+d16YU5ZM/B
	U2whGc7ZeqvpTOlmdD5e/+9XqxgEE4g8j4X/R0+SOH8xYdvalCCzeK11dfhv5G5D5i7mV+eJEh8
	JBSsrneo/gjrM8jyqmyqG9E5BnAlRNjFQXJ3F01oa1shlPACfsZwtuMC75Er+AdqnOXAAGP8MBY
	Pz7p4pAL0AQrwA4eYc3yGA==
X-Received: by 2002:a05:600c:64cd:b0:485:4533:9c47 with SMTP id 5b1f17b1804b1-48556705203mr44071635e9.22.1773401773599;
        Fri, 13 Mar 2026 04:36:13 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e001bfc1843b6ac5345.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:1bfc:1843:b6ac:5345])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854e67ea40sm155256095e9.7.2026.03.13.04.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 04:36:13 -0700 (PDT)
Date: Fri, 13 Mar 2026 12:36:11 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v3 0/3] Optimize bounds refinement by reordering
 deductions
Message-ID: <cover.1773401138.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patchset optimizes the bounds refinement (reg_bounds_sync) by
reordering deductions in __reg_deduce_bounds. This reordering allows us
to improve precision slightly while losing one call to
__reg_deduce_bounds.

The first patch from Eduard refactors the __reg_deduce_bounds
subfunctions, the second patch implements the reordering, and the last
one adds a selftest.

Changes in v3:
  - Added first commit from Eduard that significantly helps with
    readability of second commit.
  - Reshuffled a bit more the functions in the second commit to improve
    precision (Eduard).
  - Rebased.
Changes in v2:
  - Updated description to mention potential precision improvement and
    to clarify the sequence of refinements (Shung-Hsi).
  - Added the second patch.
  - Rebased.

Eduard Zingerman (1):
  bpf: better naming for __reg_deduce_bounds() parts

Paul Chaignon (2):
  bpf: Avoid one round of bounds deduction
  selftests/bpf: Test case for refinement improvement using 64b bounds

 kernel/bpf/verifier.c                         | 18 ++++++----
 .../selftests/bpf/progs/verifier_bounds.c     | 33 +++++++++++++++++++
 2 files changed, 44 insertions(+), 7 deletions(-)

-- 
2.43.0

