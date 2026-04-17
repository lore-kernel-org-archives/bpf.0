Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6BD329C66
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 16:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776441985; cv=none; b=K5xm2rD3iSbd49n3SROVOjP/D2Am6VEHFcl2AthxHE9Ij+gpwSjYUDAC/je31+oZmJ7AMnkX+AWbFPWLw6rL8T8RCqW5Rl4xICP/8UdBZF7b28xXz7Y+NF0T4Jix3NvEPXSZ+ssciYYW4JO9PTlcl10TwdVIsOPC2O9RQai8rCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776441985; c=relaxed/simple;
	bh=iO/PuuBvDnT/Cyonvy5Ktl2J22hg5/7wSVp7Gdxl8zI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eKf+Uyan/XdYDHSQYIo5m8N9JaXiA8qokJdASXxYickvBX6OdWKW73Fgwba1MwsxACeKuIM9TIoR+mJ2giCYqOn3n/GdWATDqjL6BXreSe2js3VeNjL0+hpxtD3in9kmJd9xyQ/49C1KRwQMg5/TrPp3B6ED+CR3UPiXTVCdlmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=TCd0JdGW; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="TCd0JdGW"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2dbb4ad19a5so1386867eec.0
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 09:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776441982; x=1777046782; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iO/PuuBvDnT/Cyonvy5Ktl2J22hg5/7wSVp7Gdxl8zI=;
        b=TCd0JdGW3UbpTWEg0hQEaPRYB3wAiZWTSC8/xLFaDc4xOpA/X+1UnYQJcjKZPt5G4N
         NXefYkfuSewhP9gAQyq67r4hf6niatSk9n3y9fa3BBjPDOXDAnflPH42WX4N7GqzS/vQ
         typrxFn5ZhwWdG1y7fcls5nVcQ3utvVDKhi2Js2Ir0ZWOJo2h9eDEP5sh2ZrvxF5POi6
         UhIxA7/EhK7Lx8hkfwh19dUO8WtqJU26NvSQDv97aD6lR4ncb62FJC3Drzf1stGmhaCd
         kr4JYNYoZ+vMs8kyy2Y7lqPKejkrfK8/FT29Q5mbK8RCI0W2cIygQFLnf3yNoswOr+Ur
         0Q6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776441982; x=1777046782;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iO/PuuBvDnT/Cyonvy5Ktl2J22hg5/7wSVp7Gdxl8zI=;
        b=mWlhpUtpugtICMFm9y93xrsSoY/GHpWcat250cACQqhgPVg2pTDv/sgX4C3ExuA2IE
         F7KPvAGcNUUeC6ICIpvxo4j2/vv98qSu+RmGeZdjJeAazM/W1YZ7Dq7hPvSNhBDDabK2
         qIB08Oe7iHU6CLcoiD04H90+GonQAhz6roTHp1E/OjSq4aZwAGiANlk30y/3Mr+4RJ3/
         LYgZQY6rkHfShhp2BxeiNAdEazkt2nT4mV55tqt3tw+geicNR7leiHohGp1vrGlQksgp
         hDrVFTh3/vtZ0XChj+HNWShlbFF2uMnigiSq4xILPuIPTJmrepKbeL63U+DLyaeSvuBf
         6oGg==
X-Gm-Message-State: AOJu0YwOp7vzyigz4llmUAvLeYqV5evH4XgRSn0nNO6cLcsstOHdbib+
	eqT/Zqfz/88eBgk48qUyF7nq90S4mmEhda6iVhw1uVmimFh7+i4A+ntRiNoB9ryb+AI=
X-Gm-Gg: AeBDiet8KKZxAF+K4jkke9eYisZuC0RNeVyvhcdv27g6ehqWDV87hEc7m323P7xCPCM
	WzgJsWVIeL7w9191RxhSy7f7RmJmxV2IgaR2asw+ZY+E1MrZtjnI4vbqrqPzHrKqB2nKYd7br1l
	WwWCp4vTKofaA3mkKMYTC3mDVn8dc/qGpZ3Lx8sXJN//oZEjKK5cXkDsIK6iiCQsdKLwC5FJ8tW
	xgFvdp9zAHo2T/gYKIpWFin3CLzs4mhMOI/u0rBZdm5CLVg2lDJDaz2zub0D8m2hPM1j79dz/Cj
	HHp7PmQqAkHFAwUjap8fRHcUixkA/1SaoJMBjr83zO+dCsiWC0owF3zS4OvPnm3Z136KvVXjol8
	7nJpJkeq/RcEdIk3bbPF1b0DT+sj5OuSxYkIY43bkuMC3l7n/gWh+qzekPbViAuAuDZ+YTN9uw6
	SBGFu/UduQfqAf4Zk=
X-Received: by 2002:a05:7300:7fa5:b0:2d9:ad46:4a92 with SMTP id 5a478bee46e88-2e478a2f27amr1787214eec.13.1776441981436;
        Fri, 17 Apr 2026 09:06:21 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::5d38])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce426sm2766334eec.16.2026.04.17.09.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 09:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 12:06:19 -0400
Message-Id: <DHVK4J4P2XO7.3SXVTFDJ27CVQ@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <song@kernel.org>
Subject: Re: [PATCH bpf-next v7 4/9] selftests/bpf: Move
 READ_ONCE/WRITE_ONCE macros to bpf_experimental.h
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260412174546.18684-1-emil@etsalapatis.com>
 <20260412174546.18684-5-emil@etsalapatis.com>
 <CAP01T75e3XeJ_wmET8Ht-0h6EtAw6TJkTD48ggwOcsrADr22+Q@mail.gmail.com>
In-Reply-To: <CAP01T75e3XeJ_wmET8Ht-0h6EtAw6TJkTD48ggwOcsrADr22+Q@mail.gmail.com>

On Sun Apr 12, 2026 at 3:33 PM EDT, Kumar Kartikeya Dwivedi wrote:
> On Sun, 12 Apr 2026 at 19:45, Emil Tsalapatis <emil@etsalapatis.com> wrot=
e:
>>
>> The WRITE_ONCE macro is identically defined both in bpf_atomic.h
>> and in bpf_arena_common.h. Deduplicate the definitions by moving
>> the macro to the commonly used bpf_experimental.h header. Also
>> move the READ_ONCE macro to the same file for uniformity.
>>
>
> The right header for these is bpf_atomic.h, not bpf_experimental.h. We
> want volatile loads to be shipped with bpf_atomic.h and all other
> atomic primitives.
> https://lore.kernel.org/bpf/CAP01T754eOs2DCjMmkK=3DCppEwfk5EX84tc70ZqS0_O=
xTfgxE=3Dw@mail.gmail.com

bpf_experimental.h is included in bpf_atomic.h, so there's no possible
breakage there. A bunch of arena-related code like bpf_arena_list.h
also uses WRITE_ONCE but doesn't include bpf_atomic.h, so we'd have to
manually add an extra headers for no reason. Even if we do that,
bpf_atomic.h includes vmlinux.h and so any header like bpf_arena_list.h
I mentioned that requires WRITE_ONCE won't be importable by userspace.

Besides, WRITE_ONCE/READ_ONCE are ultimately compiler shorthands even if
they are used most heavily in atomics and don't stick out in
bpf_experimental.h.=20


>
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> Acked-by: Song Liu <song@kernel.org>
>> ---
>> [...]

