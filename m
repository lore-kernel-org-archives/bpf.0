Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05A43EF65D
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817318; cv=pass; b=J2iumwuhlUC4R3kqZaIXLs02I53che+w+r86ptH6PbsuHJnbFIruc6dIWzzwvhIOSwMGuY8IcIstx7N/hOgayQdoq9R6lfFZ03YI2/BpkNjdcT5zJ2gXcwDBr0oqkMObEeBLiyTV2t4pVi9TGVlbhll1opd6W0anYpDv7t6NUrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817318; c=relaxed/simple;
	bh=XVMnZazNe6ueinmZJ6D34+lB49c1hHJgeNSRfW04Low=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f79FBm3oVFEpabHBh4IGj/0vgaTvySr23xGvykc+5bxP2XpqThlPmuEiRn4EvyZaNx2RIEXgtja2VpfYIQEyjzVS7McOFTEZYsLkrPEkhQO41KmHc+nXkchCwf5AWUzpi8v3HhvtxHU3GC5sKiT4foWOd/yS88rLu2YYCV5whv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vh/cOEk4; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh/cOEk4"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69857dc1c75so2624323a12.1
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 04:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782817315; cv=none;
        d=google.com; s=arc-20260327;
        b=Z/OhzlTIBXUi6e0BHTEWy0bt7j7YVqzYMyCMCxG5e19A2GCd856Xt4vABh0eaUmYrG
         TEkbvvXuTW6tPWEAEXYhpP+ntPZ9CERwvsq38apvzNe9yblJJ/HO2iCAxshxybrVccn9
         80clfxEa6vopj2DL2xu/AeuO5+hHnKdpNv/wxZkF5xwzv9cLa756QWeFJ40Y1x1nXNDG
         8i+Eo00KNIxQiQP7vq9xvSKFWjEyflIbZSHPGL+U+ZLRl1/Z+R5P85w+tigyApB5mRAH
         0vksFWoA6JpHsFNGvEEPxuNeVFgABtVP6sr8LWL3RXY0qgrHoGcQJbGpwqvl2blgwCHQ
         m4uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XVMnZazNe6ueinmZJ6D34+lB49c1hHJgeNSRfW04Low=;
        fh=EFTCZfq9qfBIrTH98EbhrGxP0Q+/lAf7mhjLGZL2+/0=;
        b=dhMFS9ifGorf1nnk8/0ga7oRGY1gUOUNdO5qCmVJeNoVxWTPzcIMCitU+EKzCE/JY9
         mRN0UwJVLKCNrC+czkx9L88v4UaqJPCIipF51GBC2PtG8+pkxx1m8GYNrEpbjXgwcrui
         arDGIm6/bhkUMBKDHbp81eZywxWRQM5t2Kbf+Ug3WXSJKd25jzHtXQKG0nu5Svczvle+
         E9xal2NtKgVyrmAJuAgApqSy9E5YJVx/8ftFKDQelgaN94Q+XXmuBfcaBEnP5kt3uLBR
         OrdlYDlc2QD7Zx/h4FYEEVhfDgTc0dUKRztK2KIFTWkVIEXCHXLyRxs4b7546J5O7YBh
         jELA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782817315; x=1783422115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVMnZazNe6ueinmZJ6D34+lB49c1hHJgeNSRfW04Low=;
        b=Vh/cOEk41rYPNWUDRzL9fV6pGiGys+jgYv56yyVM5YLQG+CQ6HAz8bjg+2yhOi6Z0R
         HX5dq5MjKkDCK0F0V42AmSr9XYvoGMwSY8++X6KpGHvfsB59EyMe/afP90eBPd6RVRuU
         L7n25ctS5VPtXZFXOSehyvn8hizxq6TuElNJX8Iqm3lyuU2vWeZaWZSlzFn+po0im++h
         6dXOnUDzBwgqXpKdQxQeR6rYoXT3d9Jo00Fe2t0MpjfrJ99DhicDwTRG2/Uz1zEh9e4R
         eR7AWSSH51CU2MO3xvGY9EF+7aN4NbA4bV/dCilNCPOg4BUfkwmVFQbMOtZGFMCByYKP
         R3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782817315; x=1783422115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XVMnZazNe6ueinmZJ6D34+lB49c1hHJgeNSRfW04Low=;
        b=exy23KldbrYpQlzrd/OaE9tmXqUuFH3Gv1b57INgGSYY0CPSzjULi1sf9c49ZZmrrW
         mKofYCmJuXtlFqWPnCO1V6IUNOHA60nZJiu1IHhmbwwsKWDIBoUNFot3CqVzm01JZV3a
         2I81QNd+tZWvna6DSOPcUneilYaZy5HsyLsB1rDO0PKbK0iHXnWrQ7yw8qlCIv7f81Hw
         pWc+3U0Dj5KMtb7/8X+67T57KFPoy9GlbEGaK2HhMezdRyTkNmgD5bsHzK2/n3XRBxsW
         8YgNrC3+04ojnAiEu9E24PmOf4BxWlqCiAvo0zRO+/K7YkUt/Ow6+B+iAbaz82RpGfeA
         u/JA==
X-Forwarded-Encrypted: i=1; AHgh+Rrjny57fh8KberPpLZ/5Ow0cn/Pb8jr+pVHDF15hEK6v8Oa1UidbXPGJTfh9MkOcx0nPRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya/H5Kub8fYNGr1OaP3lvINXo8eroNum7Gzf1177cJTdCkhC+M
	OgOFl1ueXd8GrAb0I/OfIJcqim/5g6GT7f378lUBnZ/PjwLUr3A3i0J/6g3LNWUdx8XUMbr59SQ
	/hGbKw8ZMmSUMQraWyJGlABpbtlVmBPc=
X-Gm-Gg: AfdE7cm++XwhvqcnoRgYJjK/ZsRMPg9xYgrHRUCcZlaS5DGJemyXNU76Yyf1MDS8Trm
	ZIWhUX2tYddWUw51ac4gUXaP8q8HizGeDY/M3lZ0v+dovon7Bfs5qYKLXDSF9nNXLSKNLksCrOq
	5714h0K0xZF2GKj2Pa47PbIvPu2UITt8zdHWaTBdRAAWaQSmSPApvo2EIBVNMOnD+LF6bXc8gBz
	6Jp9CTxMHayKdm9Aflj9l+KanAUAHBfrip69i8aLJ6AlezjvYyOlNzcIoj7fSIoOlaaYk9x8koG
	UUEVpAfx4eI71kZ7pUnbdIzq10medqk=
X-Received: by 2002:a05:6402:5248:b0:697:4307:991d with SMTP id
 4fb4d7f45d1cf-6988789244bmr120235a12.19.1782817314715; Tue, 30 Jun 2026
 04:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629070653.580879-1-caixinchen1@huawei.com>
 <CAOQ4uxjcD0-PHqqmrpEvkLRgtKJGe8-n+6DQyBngjN2TorwU+g@mail.gmail.com> <f4c8f5fe-30c3-4e7f-8512-7a2befdd1ed3@huawei.com>
In-Reply-To: <f4c8f5fe-30c3-4e7f-8512-7a2befdd1ed3@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 30 Jun 2026 13:01:43 +0200
X-Gm-Features: AVVi8CeRSS7JXqOJC8_jFJY-F8O-_1zMcUusRfzqJnniatTSJdpzkrHWbWs8ruQ
Message-ID: <CAOQ4uxh4-LYt8VUW5o+0mMrHpnZm3t8k4WD6x2kRqEj=_ZpLOA@mail.gmail.com>
Subject: Re: [PATCH stable/linux-5.10.y 0/7] Backport Fix incorrect overlayfs
 mmap() and mprotect() LSM access controls
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	miklos@szeredi.hu, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	gregkh@linuxfoundation.org, sashal@kernel.org, bboscaccy@linux.microsoft.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org, 
	lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 5:06=E2=80=AFAM Cai Xinchen <caixinchen1@huawei.com=
> wrote:
>
> Thank you for your reply. Regarding the two points of feedback:
>
> First, 6.1 is still in the process of being adapted.

So do not propose for 5.10 please.

>
> Second, this patch set is primarily intended to fix CVE-2026-46054, but
> it seems that for lower versions to implement SELinux checks for overlay
> mmap/mprotect checks, some dependencies are unavoidable. In such cases,
> should we add more tests to reduce the risk and integrate the changes,
> or should we simply not fix this issue? If more tests are needed, are
> there any recommended test suites?

I have concerns.
The burdn of proof is on you.

Thanks,
Amir.
