Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A0437F015
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 18:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561056; cv=pass; b=t7Kyz5eYPD6Xr+IpfRehaN5tH4AV8tLAARMJOXfDNodFMCHYwBKuPn+GIEucPd+nublTsGLIiAYktzBSTe9+xK9V9p9NyPJGbRLWmmnH5sajArRzqZJzrx/wLRN7appsp5NiDlvwup1W0+b0e23i4kBttc4OiLuACSZaVGPvuyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561056; c=relaxed/simple;
	bh=P79XhlC3GX4qHx0bXOPH3ERSGM1UCTLkmoefo/ycbuQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ysa0JKgAnOxvdgZ9Ff9qcydU3YMYzX9qitDP8ZnKr2r1S92Jm5DlLs2t6dG8mCniFImeWTNuPVIsSNzN4zZsVIgl3yxRORgoJ++wWLvMlXBclewUJIaOSzDSxN3bqdytZleN3w7skqqPYBiVp85byr+wwQ9WEZPR3FByFCdHQiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smartanalyticspro.com; spf=pass smtp.mailfrom=smartanalyticspro.com; dkim=pass (2048-bit key) header.d=smartanalyticspro-com.20230601.gappssmtp.com header.i=@smartanalyticspro-com.20230601.gappssmtp.com header.b=v6Xe9Knu; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smartanalyticspro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartanalyticspro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartanalyticspro-com.20230601.gappssmtp.com header.i=@smartanalyticspro-com.20230601.gappssmtp.com header.b="v6Xe9Knu"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ad9fabd08so4936656d50.2
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 10:04:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772561053; cv=none;
        d=google.com; s=arc-20240605;
        b=gSRWNVO/D8NS81CytTQe7dZBfLqyMFvzangmZPoSabjwedOSfytil15Nud5zFUEJ7m
         FHxh4tyKXDk7WkZLN3NSHs4a3H6mXRribRyEKWHuMiZynACxxcPTMu0UxR85qH3HriKE
         al6MQujsi09Wft3wboSil5/j7P6jeT06sC6EdIPbNIktd1+qwTRcim+hlvHuwIlWaHIu
         Y1nPwrArEaPVaUk1N1jxuJTNwgkuLtqKRMtz4WC3A7J2gugcx6CU0cx7D3xzj38dHcNQ
         4InKzBGLu+Ed6fupwLowFofs5YgkqdS9lXtOOYflUdOSSDSun+/bDqsZJT9n75u//gjs
         1r+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=P79XhlC3GX4qHx0bXOPH3ERSGM1UCTLkmoefo/ycbuQ=;
        fh=NPVFJnkplS0XBaxDJfGZcLOa8RPQHO8kfhXKRMGAFb4=;
        b=S9i+tqkHM+7Ygh6VWb4xPMbY8QoYT7XMDDs3Atz7RUIbWoR9LaL4Ez3B3bt2bXmKlh
         Cvt0BoOBqSB+coUT7nPNDeYBdOcMJtdAQrX7bZ0xj2gKEw78x+buwsOhINAt7T3oO28Z
         8XnDUXzImFMidCCUah3XwCEoJAdewdcNq7gL0qBiWs94PRp9ry/5gc7lkxC59tpUeoCg
         MIaR34nVfCxPJKH9jFbpbigofqBMAuAyxRQg2zuVWPd0xHdaPsWvUwzmjSwyFcaz08j/
         dDkwzv/E4OgHo8xtDrAhP/Ng+XVqtsW05mbQ8UqLYWEasDruz4eJvgkL7ljHvtc0eXm2
         9kAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartanalyticspro-com.20230601.gappssmtp.com; s=20230601; t=1772561053; x=1773165853; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P79XhlC3GX4qHx0bXOPH3ERSGM1UCTLkmoefo/ycbuQ=;
        b=v6Xe9KnulX0L5BkZFe85CEQBJ7AG4bI4yQOJ66m6b1LwgOFfmtQna0oJdUWgrNv6f7
         86WR1WaqFMNvW7YrO3kTz/vk4eVZ2jJg4oBUKrxxCxCrrxsz+lyv46nBPEAUWYuWDGin
         CQh62mliqTKHjg2woBLqKGzyFnhIdH0Ty4ctiWBMDdTse8T+x9n4GVIwRKgaSdlvALdY
         lpxB3f7LN39yDg8L16qUXWQsrm1fiIdiSqxNNVTtN9JyNjJZS4WF7BVa3sJ3KEldtJ2H
         20Zr69TinwFn2qMpBbglCXXnuHSm0CNPX3ENYc5drzqA+apToBSnE0zmD2Em4TXatEHm
         5H2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772561053; x=1773165853;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P79XhlC3GX4qHx0bXOPH3ERSGM1UCTLkmoefo/ycbuQ=;
        b=Ygks1rjz3jX6coBF7J7V8lT9zlOaGqPtks61SkqpjxsbzcQ1KNv14w92p2EFx5N16t
         4y0OJwOHOjqrMiHI/B6iN6lPYmAM0LQhqIsf8ZFS4vVowxb3GUZX5FJRLMDSrruwOf7w
         NlsfZFoIJtdwZPBMz5p1qNqIJLd7Ze9QJ5jqmV1Px8dI+dLHmyXUqOB+DPlFYb+Ct9Rq
         mDVB85BDPBK8xI8aTTYnUIwXQoT9mNsyWPHlE+33SAsw22aQZ5z4eJIXl05NY5G/J5EN
         6SACHPizW+SSxLLKcUNJL4NRKALCTctpGbkx4CJEMLJTxzuOA+92hyq62Y//ZMOjetig
         JapQ==
X-Gm-Message-State: AOJu0YwzlLDP90GmtyXRa5s/7vOcSjmxfg0Y8JgVduTVNR5c6m3ZUc8P
	/vn+bIMwt2iJkVEiEKOP69z7JoPZQatG0tAVLIs6uSJpWxHtIF3ID86S/nYffweLrzFvVspw7z/
	gHUBvcFClN/leHHwE1/7Q11KEbOA3/bWvuT571BWPDlQM8RMEJ42H
X-Gm-Gg: ATEYQzwvCwl43ba5Wm87a8Ezi6nkEvVAXJ277/bay2Uv74cIDVshwZdr59HPq7E6ssF
	NCW1QtlfN33WOrhPyHm7F0pymN+qs/HSZNWO+nhQswrqCc3fsRZc0yHE+0Jq31XCdGXeCYgmGUu
	te77Uzbi2hRqh92eShPBua1xI9PGVI1Gcx2hR9Fj8BUpEXsFrd9ujYGUO/hF1Rh9v5YZFz9Tpxl
	xHxyFMza1DphT+EVgfX5elOV/fIInVSLpzpaONwdxvkMBPycc2R7lOY1+RB5YLOs09yYxqtnk1j
	o86jZVr5Zs4dNE532n/R7szSTTOhGnjuZd6kDyk=
X-Received: by 2002:a05:690e:448f:b0:64c:a7d9:e1dc with SMTP id
 956f58d0204a3-64cc2025960mr11781494d50.4.1772561052649; Tue, 03 Mar 2026
 10:04:12 -0800 (PST)
Received: from 346534542174 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Mar 2026 13:04:12 -0500
Received: from 346534542174 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Mar 2026 13:04:12 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amelia Mendoza <ameliamendoza@smartanalyticspro.com>
Date: Tue, 3 Mar 2026 13:04:12 -0500
X-Gm-Features: AaiRm52QNKi99w7SWW6teBlbvr5gVHJzctmFQPhkMH_Nf36FltifOt7kgrpCniQ
Message-ID: <CAJiAOuizo=4JnosWvQ908iNxXB-+WVcgc0Wx=n8Bpe5aRp8bPw@mail.gmail.com>
Subject: Unlocking IT's True Value: Let's Collaborate
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi there,

I wanted to check in and see if you've had a chance to consider the
article I'm preparing. It=E2=80=99s designed to help IT professionals
effectively communicate their invaluable contributions to
non-technical teams.

If this sounds like a good fit for your audience, I'd love to share it with=
 you.

If you already responded, thank you, and sorry for the repeat.

Best regards,
Amelia
