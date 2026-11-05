Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901199;
	b=r2lo2+/w9ZShpI1xu/AuC6AOe+0RIKjrXNy3uEFj7OQz9DnwlBqCLhRf4ZA5hJHNsO1x
	 0cCgFu+uWqhm0xE7ZisgYPVYZ1jk2e23KtqtKtRnhJL+MwBZa5d4OntIyZea4X2EE+jGh
	 mSFXURv0Sw1ExePtNrVKk6n3u93y7FIsdUKR7I3zwZ+EFF5X737vLRg0QiOQvpz0vmd6T
	 Fg8ZjABoZb5wUHht9zjrVAd+rWZCk1yAQ0VGlPDD64OALnodDndf9smrubUFg/yfXnLtN
	 Q+grA1HrZuvaxT18x6a54lqvhOVJw9gzWUSf1Wun9lX7oO+8FZ04L2fvp63huQLDNAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=od5bQglY7/GGBrEmPf29Qqq2rBzZfNZGV89tObGuQzQ=;
	b=rkdU6p1bdNP+sscdA5m3XOtkvq2DsJY84JSNigvrW/KOALhVqb7d7FIhI8v9SY0yRYtW
	 iS5rXnjeTLZMrAl+YwTPvA7Nm99SKN4BI1PC2abvlE+AqGTjwzcrerS9WqH5+rnB39j/Q
	 O2dYTtlnHiRCVhC8Jl65L7chJ8wQmEP5042xprretNaT9I8xUx9MCdc9CJp1FguTV2qy3
	 28ooQokXxLiRf/0dmzhJT7uLB5V6M2E8GCjPkl6IQrR96d41kmewKhYrXhBUSyui2sEkd
	 fAIPkXOJHK8eHcYjw2i/qx7Ems+XGA0PjjcXoqyV8r1T9RY38J0jmv0z/wxvRZh3rMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L0ewaDC0;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A7D606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 17:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29A7D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L0ewaDC0
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso23745575e9.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 09:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793901197; x=1794505997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=od5bQglY7/GGBrEmPf29Qqq2rBzZfNZGV89tObGuQzQ=;
        b=L0ewaDC0DdnIVizcuLN/6bUZotvexkC4yS4uKLIfK+dEjVuKgDOa6MjMssv6x8deKS
         //ogv9UNKq2j92xv7SynG5IuLzA6xrSpHTtiOtzlfQR9zV+oalxFVMoqyd1iIAIT5QDV
         8gWPwt8WdHfXCz7hznMz2j7vLVmh4KITMBo3KFJ8XRx83PcJv6mk2mr0qtlnPP7uz8rr
         mBCiZDl0z33uHoQ80VTUQMwl5zStIolPNbnAvGrC6nsCgi7Be2SoiC6L+wpTgVkndBJT
         83zvZGpAVXD/Qw9alacNL4DAvOwQNTZhrwLkzgrk6UpdOUkP7rt7FfbOurYx3wJJGuS7
         0Ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793901197; x=1794505997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=od5bQglY7/GGBrEmPf29Qqq2rBzZfNZGV89tObGuQzQ=;
        b=M/+25IhguW/vyc/0blkfAJFz/tsiuWpBAXg1yds95ig7JzZuwOjCQcSNmB79Y6srkM
         LBq7a7dy/dY2KlJVkztoXYtTaVnH33VVC/ihaqOgbY/FCSb1Y5R6/AXj6hrPxzJx4j3z
         jJ3C30fgLaDU+M5Z9FmpT4ewJWKklXMnq8CB7NFSkPN9IgFUXoldiwA/0THeY9ymJVDC
         s85rUc4GxaCm41DeOFhCuGHaEdwSlY4Oe6+jWyKHii7u8r85RpDLHz0idyG/4n84axRJ
         eqS27+W9gcheffSjYiclY95L2X9LAIEdfZAy6WYYHBDWYkLw/y0Pyxd537Jq4VHpT0Xz
         j64w==
X-Forwarded-Encrypted: i=1; AKwUvBzXulrUeldG34y05RhhsRGqqkddeH/3716rqGftNuuCSyFW9G9x22H8iFaTWbeemQ1Whqo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8mnuyBakQU4p1jylJC8E+upGqeSGIvYpzJp4QYpfs7aKNO4kll
	ng37qM5aubfmXHvwjYr7fe7XaMYLRAkOAQZ3rn5MWNYhl1Vi2b/Rc2id
X-Gm-Gg: AYBFou0LleUxiP86M8lpn/4qBcvW6WAiaWhMQYZSZiT7jQn360KaCdU3sFnq6bJJ9E8
	rJVruGs8t2ffegsY+x8HOjuR28zYQcfH9Tkx8mdjEO77/cMLDs2TYtuqxctNr4xrOxatEp9ylvn
	2k0OCucQztpjP90+avTTjqfdzSPmrGDB0DsneQ7DuOPvO9W2yGrgG5wvsXWdf/Js6OoITmiK/7V
	/xyHNb87P1RPnM4TbRSorHr7nOISG19UOM8HndmODLkxLmMOQyf5asnrvK3JKXMe8Ypp4/TpfNY
	rj9/CsvGeMjC6RCuG2jR7AsqyyHW7o4BBKaMuWDy/m5N4oI43inbkIIxOM86tw1buvxQmsi1ElH
	sb1VwWUwSxra64ypNvNweacwgPpSsA26qsrVn9II8E2C5BAWAUV0b47C96G11x7MjolphHjI2LC
	ENDz4mTRjCSydfeWPZWwFiugzfJX/JK4OfiJqCOe3tXr4ZwX047i1q+AXCwxO9SSicwL4tAfG1P
	H82BIznmH+0+3Ms/4AOtfQZuzsE8Xq9KHenZWk8ZB5izLjzrPTlp7mGJmIK5yAAO+e4QkptB0zW
	nXuAq9/sYq+t/5nut2leZ+/GILcTa+OhHOOparn/4900yMDWRUbT3pReYVJb4Ts62XgxYz6D1T5
	Mi3IczsY=
X-Received: by 2002:a05:600c:354c:b0:4a2:8c5:5e5 with SMTP id 5b1f17b1804b1-4ac17d16b1fmr442399235e9.7.1793901197485;
        Thu, 05 Nov 2026 09:53:17 -0800 (PST)
Received: from andreayoga.localdomain ([151.43.242.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4527fed5bsm200647785e9.3.2026.11.05.09.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:53:17 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: Tycho Andersen <tycho@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Sargun Dhillon <sargun@sargun.me>,
	Hui Peng <benquike@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	Cong Wang <cwang@multikernel.io>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 1/4] seccomp: wake poll waiters after failed addfd send
Date: Thu,  5 Nov 2026 18:53:08 +0100
Message-ID: <20261105175309.2995-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <auy_NtEpqMU-g913@tycho.pizza>
References: <20261104103736.71956-1-parri.andrea@gmail.com> <20261104103736.71956-2-parri.andrea@gmail.com> <autZ5kL0S5MkX_8l@tycho.pizza> <20261105153735.5368-1-parri.andrea@gmail.com> <auysN9YTg8Ih8QLZ@tycho.pizza> <20261105173530.39081-1-parri.andrea@gmail.com> <auy_NtEpqMU-g913@tycho.pizza>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Nov 05, 2026 at 10:42:07AM -0700, Tycho Andersen wrote:
> But what would it reply with other than EMFILE as you note or SIGKILL,
> both of which it would do inline with the ioctl?

Right, those actions can be handled inline with the ioctl.  That is why
I'm dropping the wakeup changes and helper from v2.

Thanks,
  Andrea
