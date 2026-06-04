Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1D138F957
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588002; cv=none; b=J3+T4aSEHC52u+0Zw5paFmka2iK5VIVgf4eZkx4rj+4wBa+PsYmOeUWSHK7IylA+uOoLmGesAF2NHuNL8xylt2J4Kp/QbolbnVbeUKCZTNcnP9mtlIfbj4JnZ01qB0fOVfJ4QSu3obYdyYHQ1fZ2j0McwJp6KlQU96NOk3fAkZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588002; c=relaxed/simple;
	bh=xtmzevV8iGYnmYrZE5NtdguMWRoK/e++B5wd01JKR7M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GBuISo3K6DkeYjmIJ3Qylkkhq0QYnLa1dtFzFu1iPOJ6/1R4RZMIJxludOh25r07iH7l+IZvYteiz/UeCzuZlPwUfU/O2r+kTd1qzSeYrS1pLqjymWlf3uneCPUONrNsMl67NWFPx+1E0aSpWCuydU4u9mSo/Hk5H8ynI4UNxKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=w+SeUnhp; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="w+SeUnhp"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c85825bbc4fso544362a12.2
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 08:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780588000; x=1781192800; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtmzevV8iGYnmYrZE5NtdguMWRoK/e++B5wd01JKR7M=;
        b=w+SeUnhp/2a4xYw+8mQf4QFmjijhDAvE2Dv9XPz+Iip7W6pNeQBfYHW8oJaZfbICCk
         MGr5lhvM42KXWdg4vZz6uVrPzX7jp5d9peCb7riCeLKmKtDxBjbyelNFN5kzkZ3aGk6X
         BMLiIurm/JFn3cPBqcPYYnhKgGVQIDrpL8xufcFj+3Iinv5oAGFkF0Cn5Oy3fvIE43Fw
         hleVSpsQoluVlJ+dzag5l+axkFQmNQYJqaC/GqX9jD0qyL91wJaeIlbh1kShIfGdvYih
         oquKjbQguF678s5uU4ENI//q1a6hXgy4mWXdcEnBujOL+OLyxjzr/LlESfR1ZlYCKXwJ
         U0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780588000; x=1781192800;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xtmzevV8iGYnmYrZE5NtdguMWRoK/e++B5wd01JKR7M=;
        b=cvPWs/aUE9wUtovQVDJwTjEsDXUJFVLZHUHVK5taRYtVRGHI09Q3nLoNZ3Tkt3YLQI
         2Tw9G2V6GPlkHx7WCmyrpHe6J2z+hONm7K6j67uQCRhSscne28OKFbygmrEppecUWrTs
         sf4+TyJs8N7qpV/Chy3UR3994uEi7Q3MNuOgNzPIkrvnEV0w2CDiYXDybcAUkG6VhZs1
         BoXdyF1LSk4X7O2h0QLHZKDMQE41VoRQmDzBhR/vek4QmpzhYHB0Dg7ODyUkBfUcLl6K
         O/aRfQK8jpWjFfffz3T5zc6XaOFHAe8lT4EW7hjGslL2pahnrJ20e2P7J3GWj2iFfM0X
         Ji/w==
X-Gm-Message-State: AOJu0Yyfdz6hQsC/wu/j+iyifUNyFTZcCx2G4pTdZAhiq7sBIlmGJSuH
	V4LGbwWtsDX2GxaV5pVQDl+YbqQPrefxDQ7c1uhw3hJyLs7O1eJ3bftPhKvzmeyzfXg=
X-Gm-Gg: Acq92OFEOk43jbdny3pXqyOKu1PgIU7VWXriF/LI/MbOwwFFTeVHu0P9qWd+MKQTlID
	TvhzVU/6MNUribwma0J0gDwiBfCKAaBQeDFqCpJkbIL9B/1+5v+gAPMn++/b/+CkoK4XY/AvZaU
	spNCiyRSaCRKrEyjkpr27SqMJ+Ls45apD6RFYwG7VdQLCUPTQNqeRgtk9RrEeKOscIFhLGFZrBD
	ZYA3EVumttJLDYs/qn3VQYOZhc7hoJvXgaU9gTSFcjMr71sL6bqswTi6Y+HqKy1zET+ImbTWXll
	kP4Afs4+8grey47IW06x4KUOSMAbduUsbq0Q2CruUezsJzmwtV3YPeYgOidqn0uhIxM+bN9wcyx
	TIlV18DSiaEokR2Fow949GfbpqOyPBXaOfPNEJ7/NJFDYJ+IrMfT2TZ2mS/QZ64qQRVTll6hvkv
	x5O56Fopv+zkqZsd+HZwTlX2CPUg5CpsyjgRc=
X-Received: by 2002:a05:6a21:7486:b0:3aa:c99b:aaf4 with SMTP id adf61e73a8af0-3b49763c38dmr10055917637.15.1780588000338;
        Thu, 04 Jun 2026 08:46:40 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df034a2csm5594874a12.3.2026.06.04.08.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 08:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jun 2026 11:46:39 -0400
Message-Id: <DJ0DRM980L8V.3MR51HBLAVAEP@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add arena direct-value
 one-past-end reject test
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Woojin Ji" <random6.xyz@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260603-arena-direct-value-v1-v1-1-7b31cc0a8cac@gmail.com>
 <DIZJ5P33U6YT.14OWBKG3T9LVD@etsalapatis.com>
 <20260604153712.199362-1-random6.xyz@gmail.com>
In-Reply-To: <20260604153712.199362-1-random6.xyz@gmail.com>

On Thu Jun 4, 2026 at 11:37 AM EDT, Woojin Ji wrote:
> Thanks for the review.
>
> I tried moving this into verifier_arena.c, but this test needs to set the
> second BPF_PSEUDO_MAP_VALUE ldimm64 immediate to arena_size exactly. The
> __arena C forms I checked materialize the arena-end offset as a separate =
ALU
> add or memory access offset instead, so they do not exercise
> arena_map_direct_value_addr() with off =3D=3D arena_size.
>
> So v2 keeps the userspace raw-instruction test and expands the commit mes=
sage
> to explain why it is needed.

This sounds like the problem is that we can't really get BPF C to be
compiled down to problematic code. Can't we still use inline assembly
in the BPF C file to do so? I don't see why not.

>
> v2: https://lore.kernel.org/all/20260605-arena-direct-value-v1-v2-1-a92cb=
281e376@gmail.com/

