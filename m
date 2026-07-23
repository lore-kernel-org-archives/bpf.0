Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D3E35200F
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 03:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778758; cv=none; b=e3Q42VNcRiSTgjJVkW2eNY93pRI9SshBLRiegRBiui9EzL8MUiTe/LFrR7WjirbV02t/sBlsdoTOQ1EoZr/kdJ7tSLoVCaKy0rNfh2yE0tbnuS6vVLRCf4hrijhor291yC7lFJXoeh0tC1z2S1hSuP8XIZGwICGbr1RUd5qvGzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778758; c=relaxed/simple;
	bh=NKvkGTWYoQ3fUb02HysZILwOh4I+xZMIhC2asBbKTK0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=AoPvJ+LWA0/2BZWsL/Dr2Iv8u2qYu7hUgPh5+y62O/QXNtI3ngQZN27GkHHcSFjlT65Mj+MXKcGW/WyDZ4gToJlFNJs/EJRa7OsjH+J/4lD4lHkRLPpR17WM6eZWGooCUwoso+AwJXpT+znkrrjUDC189E8IpN+OEte6s3Cgsvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4FC3s1Z; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4FC3s1Z"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cea3004256so2411445ad.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 20:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784778756; x=1785383556; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+KjB9ERoiyCT7CFBhmVdB5j9kcQH+fYHM1d2cSu2txU=;
        b=P4FC3s1ZC/EsaU22+X9az+UchsWpEs5sQlxUpjjqaYrkceFEjGHoAXSeWFYExp1DD1
         gZsmcCLBdkPJWl19Exz0qwMS+DB4+QC3YIWEZ+d6/r1c5OhOtDPNHBpQZlsVwZ8o66e5
         nH3SRUd2Eg+EzcbRC9GGQE6iw+qh1h481wKddMBJQlFIJdW3wORM7GCuYOdQ3IL+//gG
         t5l9fjjf9Fjogz7/Uy3QqsMyAtspPA4dtTgCvdog/dKbVgNOWvUWlL1jzafdgqLYIKBb
         Q9Wou6MDIxAefNWk7ktmmOx8zoBunig7KIKBv+s/GRw8Eau1hNSpDeRMNw5FNQnfsswf
         bXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784778756; x=1785383556;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+KjB9ERoiyCT7CFBhmVdB5j9kcQH+fYHM1d2cSu2txU=;
        b=FBSR7PCxjQ6cT2+jLN5ROdJvZ/OCPd4kG8cEuTEEAJu/yB9/4VKHJuPL/uPpgjWsvL
         3aLM3neb0dl3T0UbcLTnWjuxdyKvIWnd9DxAq5RcXZi4zS6FzFtzxJprgIxf/YWu9HTD
         vaDz7QtPwBphYyR6W7JcRBfg3IaJeoKvxOU6+BU9Cepj15vuv7UYe5DlHGuDHb4LnSAR
         OX53Q7wXyg08jOWcKuwVBrVT4zH2ub2w8mHr0+E+CKb+jwnT9dWXaqij68fLsRBDUrAk
         F+6qxOoqFmr30qeaqC6/s9bEwtZIYgnX3T2mU6+VBWjNxeCkjQjP+m8kUq02sa3nmGwY
         Aibw==
X-Forwarded-Encrypted: i=1; AHgh+RqHfst4RPaTrApmD8tTNGX5pGdLCsDjV0EwXYwleOnInZLjjlEsfNhJAHgAN7vVeE7XMGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVn3CyhAajK2YqS4ACVRfd47lZUSCU1i3rupyeJx6v1Mb4gi2l
	zuyL6WI70El/cNFg8MVWtzYdTuqE/HyOiSCEflNkBPxg6NXJoV7XXdoM
X-Gm-Gg: AR+sD13dZNoZyRoYU4kKOkrNH7MV5BZfE4LtFRstHLYmXC9s4N0TbGg3Wy1fiPDtkw3
	k7HCvrLAh4Kl+B1Fd+8oQ4Cs4FCgmVtJXb6j3Of2XvWfWj611l/WA5um1MNWehjp0ZwuLjLAl8m
	Xa4nzrclgr6IaLQeKnPa3mqTTlXM/Y6X87o399jt6gmTRYMr6UonV9cypCAoKUkaJhQIAGninDk
	DQZ6LvyM/z49Z6605kDoOVUZr6trrfQhPc13lTKjqIEaBHzTOnIHX0wGpi4+6odM9RvDN6IouBO
	6nmriZ8QT7Tv4emn9q5qzhqE4FqbgxBGUdIpr8w4zsNy9nWTpdedzh4EMlN090XeGhmZo5HITwh
	uD1VyQf9T26eZaqt9+rxkKUk1ynY0Z1cpTrQyVyU7D9oI2a1ks5e1gJXCtPq4qT4vg3008+ENgq
	k968/mtA==
X-Received: by 2002:a05:6a20:c784:b0:3c3:ac9c:9a66 with SMTP id adf61e73a8af0-3c44b25089bmr1370190637.69.1784778756493;
        Wed, 22 Jul 2026 20:52:36 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d12f267fdsm11497359c88.0.2026.07.22.20.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 20:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 02/21] docs, binfmt_misc: keep general usage out of
 the handler sections
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <20260721-work-bpf-binfmt_misc-ptinterp-v2-2-e57866e4ae0f@kernel.org>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
 <20260721-work-bpf-binfmt_misc-ptinterp-v2-2-e57866e4ae0f@kernel.org>
Date: Wed, 22 Jul 2026 20:52:07 -0700
Message-Id: <178477872730.254289.4208397694401695848.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 21 Jul 2026 16:13:44 +0200, Christian Brauner <brauner@kernel.org> wrote:
> The general usage trails the bpf-backed handlers section and therefore
> reads as part of it. It predates that section and applies to binfmt_misc
> as a whole.
> 
> Move it back up so the handler section ends where the file does.
> Upcoming sections describing the transparent and loader dispatch modes
> append after it without swallowing the general prose again.
> 
> [...]

Reviewed-by: Farid Zakaria <farid.m.zakaria@gmail.com>

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
