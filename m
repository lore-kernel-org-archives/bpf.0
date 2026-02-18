Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE5630B533
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 06:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771395449; cv=pass; b=jzOncY/PuJxXIm5o0M5lHWFP1UCFR/gAAgc2Hem6COtnCUBtLeGEa8Gw14MzLerCjRJ+8NlVceQRMwAGtizky4CNIjcEMZY2TvB5sB7vLliYoRtpn/hCxSGWoHksJWriEdZkzBGr8UR6SU90Kq1A9zBV8QCDsYJTyMEKLFZcQNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771395449; c=relaxed/simple;
	bh=K26xy6UK86TRjo/lLzaA7N0VhGh8ikpsVYPWkfJ/THg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsINB+JBKZ2ADGdTGKZTtpfntsSiq1O3y3yIjsaJEfbJ/vFlHrZLC5F2DX3b1bKRiHYc8UNzgZ3N0rWdKBWXBiraE7lv97Jiz6YHRiTBOQvs87gfs4OWzydLedHcqndAkOCdMyNhtzb8A4KbI/1YfwMNGMkx+FTbQCCk5dz5Ukg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iL7RHtnD; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL7RHtnD"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5673fd077b4so2185669e0c.0
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 22:17:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771395446; cv=none;
        d=google.com; s=arc-20240605;
        b=bAWrf0ImmfIX9+pI3+ltu+O0Lr0vQKyVNG1tHINh9UUc0Ouipjcxp8YM8Ri/eyFZLJ
         HqvF0k0O+vFe0CfcwCGz8+u30pYI0aqnVH9qrz8YciMReR1oNZC3amdsWr6LdRwOBlEw
         0YpoeRoxr252GDqAk+8xs4GmvIeaN0CdFH3OnkUVVlE1NkuuWfPW4SXKDLj+HiG1sSPf
         n8eQJRG6vixzWVlEjDEUHEzVi7BIQn5ic9zMBxWcKUxvKatqSr10H/U12uMWIRAFUzo0
         TeZ1TGf1KcubPgkWaUO0vUvIkZkSXll48A3BTfts/1ojG2fZrKVLVtwZ/izTcNAvjY7I
         ewTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=K26xy6UK86TRjo/lLzaA7N0VhGh8ikpsVYPWkfJ/THg=;
        fh=Z5O2W4KopKd7y0e3ruTj3zZ1fswuqzAtVDfLK65ahrI=;
        b=MXTB2+bHYsTiTrkrHpMmbaS4mGwGtezEpmnrmeRybG3P5/hKPZsYfAjbSWP6RrtBPI
         O7tJyqdjwE9KxTxBaa+86jTcTb+RNILQdSpqpQQzTPgEGfhi2bMgfogBsXSsRfNDflTF
         4CYvWd/dgd4epUxlZBLvB8aVhDzsQMS9qGrek6CB5AjzbpVte+h4xgURx5IdTDB7vM7x
         aM71pUlgecSfa/SjTCprO7/HY84mFzYowCKCO/sgRaa8MVa+EMQ87LGXMgAZIwfz4N0x
         fOGN36ubkJR3umrk+YzMXruPVWzR4cAt+cjLfaHwgMDbhbBIfuedTpEibtbS/RM1MKKd
         0hIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771395445; x=1772000245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K26xy6UK86TRjo/lLzaA7N0VhGh8ikpsVYPWkfJ/THg=;
        b=iL7RHtnDAOHjYkSNPUlGH53p53OhPcnIfeS6zEkL/2xqlvoZ8T6UOb2lOKu5D2YDmP
         W4BqJLO3IVrBX7DdS0gA6EOJ9djgq5VGrwj4XIJjWdZJl9zYJAGy5HoDNVMb67HF3jIg
         8D7AoID3KyxPAx1ujQ7yXcBzilVrvxkGCF1NwDZtCrEpZdhMpj+RIPxtAkvi9eYsBX6f
         ENGfybVDHWgBqRMXPX7scwPrcgxwbQ0lZiJk1Pck800CLRcmVg4XXP+XUSNoPh0+KvGd
         7qQVMwNy7pW1QRpkAGGJnC43f5sNu++QZKwVFxlQvQeG7r6ok7kIEH+Z0681VqJw7zo1
         B1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771395446; x=1772000246;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K26xy6UK86TRjo/lLzaA7N0VhGh8ikpsVYPWkfJ/THg=;
        b=ZcCdQvzolHtwoD0kQAqo1O77iO+40HxlOBvvLrzvm3A353U3iOhywXUyM/Xt0KjdNR
         83K6YAOdqAikngMiOule/pQPD0KEz+CfiLT5IfAvru7jZpt5qNpI5X+uwAY9AhMaP0nN
         kcAHRh28IVJ3kWQCULraGxv4uewLo7JhpT8VX1/FTdND739LodQJtNkq+MgomvCw4iHk
         R2eUkhgUhcyu/xkc5K6wqnQ1uFtDfP9tlpzezw9GsHr3BSTu3nNGyIS7piefZ6z2ziAu
         4lXE47YO16DrlW4TbZvgzNFxFHb9CP64bMss9IFG+Cyz33HHk4uIqTOkSHilTTGCkcEy
         bleQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG2OONfdTnQX0KPtnHPUons3xghE4GsPDl4VajxYV2D47nYIN184VAmv7WXsRpVIU6Mnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC1Sc9TgbZ7JD0iQVRy0uyZ2TnyIV9OMLFV8Cnq5WF8ahSJHDY
	1m3ghu4tFWaGA1x85FSFD5vbZnFAyj5ksotwT/kKExX/cnNJVfD0YcbpAjyXSMCQrEyk0Zs6GVt
	gsAyMEOaBiXtnHWInj240O3FBdvdDJzo=
X-Gm-Gg: AZuq6aLovrPcIa6HBVUnbXicMoPjh88a6g3EC0iJLO8djfwkKbIitlhVheJ0BzZ4iVZ
	fW0hD/dFC36wVvEUGCyQiHTjTHczSgLFxXEev12MTqzddi+A+Nm5tnFVkEeByy42B+o7fKL3vtp
	ERiU5pBq/vsKs1DUY7I6oIAd6cFffo//F9hUW3ziMUlEqRUsgtvWphnk2RU7UPn0TPwyxU5cdho
	Cn+EqBeUEwo8TVbRvq9LPjed3DX/nYzvDxUpfq2Jw7+uLF4/feWt9/Li+bCuM+tKN2Il2AN2HeL
	5tWctFNpqY2bX+Bawg+yTMFwg03VzbPic5YTHbEHxg==
X-Received: by 2002:a05:6102:3f4c:b0:5fe:8b4:19a9 with SMTP id
 ada2fe7eead31-5fe16f68260mr6064301137.37.1771395445625; Tue, 17 Feb 2026
 22:17:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <42397d01c3662e85437ffdfa41f5e0c0799189fb.1771316309.git.paul.chaignon@gmail.com>
 <70e49d1210d1aa77ccf713bb39c5b6a19c0081553a2fad41a581714077663c0e@mail.kernel.org>
 <CAM=Ch05qfhEzxCoKBK6MhQza4vPdCus76gt1=vGqEOzkFJRtOA@mail.gmail.com> <CAADnVQ+wZhriWAcHtXvVL8FRF0E-2iPu+Cdj8KqkDKKeHA+w9A@mail.gmail.com>
In-Reply-To: <CAADnVQ+wZhriWAcHtXvVL8FRF0E-2iPu+Cdj8KqkDKKeHA+w9A@mail.gmail.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Wed, 18 Feb 2026 01:17:14 -0500
X-Gm-Features: AaiRm51hxwlZEIHpuN3ECVc_uNFBEZlHuAgGk5MKdImkYqnF09YaNBUwsNqRKXU
Message-ID: <CAM=Ch06n7=bv71dH_4b+opvbk2KU7LgaGNxM3WwBON2Pem29tw@mail.gmail.com>
Subject: Re: [PATCH bpf 1/4] bpf: Introduce tnum_step to step through tnum's members
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bot+bpf-ci@kernel.org, Paul Chaignon <paul.chaignon@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"

[ ... ]
> Something that you should keep in mind when relying so much on SMT.
> Shift by 64 on x86 is a nop while on arm64 it results in zero.

That is a fair point; a good reminder of the semantic gap between SMT
abstractions
and real hardware.

I missed a standard constraint here: explicitly model the undefined
behavior by adding
an assertion that the shift amount is strictly < width. That would
have forced the solver
to flag any execution with shift amount >= 64 as a verification failure.

Having said that, I will say that SMT was still instrumental in
developing this; it did help
cover cases that would have been difficult to hit with testing or fuzzing.
