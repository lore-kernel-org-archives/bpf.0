Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9707B226CF6
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 00:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769040891; cv=pass; b=d+1qdouaVDT7XUqg5HyU7ZrgIHhJisPM3cyQEIqjl28XCtvedonSs24zSEFdyVXJTGWixq1n7vaXRZz9Dyvzd1oRog+i6P/Qrj4yIRL+dAKfUtGw8XlvRplVieXewigKDc3trfkcKN09bbc6TZ3HrRbhkkXFZ8ruXRG/Bilh3yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769040891; c=relaxed/simple;
	bh=A5RWos469E7OdpHxOy7QWO7HMl+c1GqjTI4t+/0t7I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlCKKjG5KkYdDYnEQsenlniFB1zP16zO0zxC8aNlw9Rlzs4aeQG58euy1zYXkqWCjdsfJ9GJ5Fup1IFsi3Cxd7N2ZMPXwHhHt8mffYi8j0dry6z9iZW8lusg7AH2fgyDvqfx757Iw6aJDlF0YyxIRslzC9+WReuc/RFFTddJ/7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dU/GXHID; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dU/GXHID"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34f2a0c4574so362086a91.1
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 16:14:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769040889; cv=none;
        d=google.com; s=arc-20240605;
        b=SHSYKLkSZEVaVnglf5cMueeFeA/6mXeDifnhw0TtSPfHxIR3jI+WXu6sYhY4WMqrT2
         QqnvubK1BTLFjj5+DdNuiJnbtMSjn/fL6If5K6OThPWMzYqDE8j/z/xgph39CR/+L6z2
         w6oFevO02fUfrjJuSochcqGjuCZw88T8BngJykC04vdTjZos2s1+3MVrctHil4M5b3XR
         ZEy/C4+q1slRhv1LB2qVlMWKFgT635D2xmETYZoNx+dup/WzkWQ9B/viWk6/Xgk631YP
         mFCIzcCY2Ju0f5xOcaE3XrLv94UguvVF/BVPiJjvcCq/lloimXqJv72pj1bm2r6wxqli
         HG5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zXPAFU5JIVtw63vlsc/Q6CXxBcUl3qbYAmmc88ADSD0=;
        fh=sWGVTpHPFXbGErV7ZfNAtvFh1dXpQsoSImcPyhBgjC0=;
        b=BbO/MmQ/MNT4Dyc8pTVZNEuQm9aKVtIPHLV6DD2MBvdItC3lTKYdPN1wWaFsuRYcQD
         ZAjBPpLtT9MUvhSDP9boTVGwcljq+Bit8OKJJ7AF1B0D8UVAzYa6yF1L1wYd6CjXLsDr
         4InFaf/17iZ906hX8FTBL7F18/n1SCkyLg3YBgpzGD1gA+aFsoPQqoEMFm5+p7ARlvxf
         rebCbm+z+XLv3vmEiSU421BkrRuCb16NSPanNMfDhiLboAWJmclO9xY4Aj6Q/pFIKlh9
         1RcdK35O5ucyCqo9kF2Xf6is+OdG7iHcB3s2W5F3RaKDxvpcYzrYbIBh0kmdqrpGupDk
         wU2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769040889; x=1769645689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXPAFU5JIVtw63vlsc/Q6CXxBcUl3qbYAmmc88ADSD0=;
        b=dU/GXHIDEkNX12ZR4K9e0Su2HMD5q4K/1lbCMpzqcqWeYBBxT140w87zXDVx8oP1x8
         qZtqu81XZDb5HvBT+gChEsFOKdsAthJY1/aZkCO23VSX/wI3jCTkPgEdgWYFrSMwZ30Z
         Mu89dNh3Kr8X4v8gaHpNvQwU1bhu4+gS4DQpaJrre26gUSmxWc2rbWubDb04poJV+wro
         2rAgKytmH8rk/k4PxVrB/rZ2miT1Abc4jAiJVToiVx+iuCqadr4KFry2B5L7jEvn1HHp
         2FmqeHkTqVgxmMw/SnEB28gg0I4Cqbh5cMCG9hDLdBCmblR34DTCsikwNqdDpPva9QUb
         1QMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769040889; x=1769645689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zXPAFU5JIVtw63vlsc/Q6CXxBcUl3qbYAmmc88ADSD0=;
        b=aDk1vPD5VOEeD2IOOxhqWLes4+KTD20tFx2gsMxZ0fU4xPdWYezZiRxbAjMLKVFNZv
         lN0yVA5/cCiODAZ6ZXIACyPG/tOIYSmwSrcgroFfQiWkZZx0iV2HwTZ26sJpnyXQKG3t
         gPzoHDJKroir9Kdzd6B8k/iXAkUBSN9D9o8SepcMneTgzvK0W8wCP58kQnknwUDn5VIX
         GP4phlw9x3qVvnUTaeofLdLH1/TO1sGaF2Zmg/Y2T8HAINH5JS3nlXolqHU3Bt0hXgti
         qQTmKbJJNnnaf/5vjtHNMr3jJ3WmALKznywl/oZBR6ztWnhYuhHLS/5mWCbBnNfkb0Tl
         OHeA==
X-Gm-Message-State: AOJu0Ywp+BqDoboDAI+AYlSUL4jRKITbe8t1CO2m7PoIoukUhg07jZzB
	xcTuHZYp1Z8gkqfnjHHU4jf2gCU6y+VIUZZQVknZQofHEME75kynK/RHhMki2W18fp6eAA3f6OC
	se3KsUxG6qUzfHEdEN00B489PwOBHCcTp4cF6zJoCmlsZnKUFQWgyCg==
X-Gm-Gg: AZuq6aK/Urrz9YCMOV5m01WhQp7h9IEKtI2kz52X/h8Jen9+wMd/vub9z+oRDbWp8bQ
	f02HOaK8d/2zCkwzswTJAAKVWMVhTI3FnXxnOEg6hAGwSdo8kMMRBsTC1qBy2ZLyoMdCqME6KId
	8nhKgfAgCFFfNppZHvmDIwQDFqpEeHXma7wiUTmchikgret+SWiG39y6BJ9h8TKtcahw3NqePnr
	+TQsSHKqyK+b3dMQWCGYTu9o9oMYSJ4iB4Xtuw56oK+tWGhHJ4ohLFO+JN2Q/h9M0JJBkk=
X-Received: by 2002:a17:90a:d00d:b0:33e:2d0f:479b with SMTP id
 98e67ed59e1d1-35272edb23bmr15763365a91.6.1769040888822; Wed, 21 Jan 2026
 16:14:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW4=heDwYEkmRzSnLHDdW=da71qDd1KqUj9sYUOT5uOx3w@mail.gmail.com>
In-Reply-To: <CAPhsuW4=heDwYEkmRzSnLHDdW=da71qDd1KqUj9sYUOT5uOx3w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Jan 2026 19:14:35 -0500
X-Gm-Features: AZwV_Qi4Pxfxx-5TehqNnHnBk2vVum5Naq85Aa55fS3OaaOQkTNm5PTJBxmaI_4
Message-ID: <CAHC9VhRU_vtN4oXHVuT4Tt=WFP=4FrKc=i8t=xDz+bamUG7r6g@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Refactor LSM hooks for VFS mount operations
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	lsf-pc@lists.linux-foundation.org, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 4:18=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Current LSM hooks do not have good coverage for VFS mount operations.
> Specifically, there are the following issues (and maybe more..):

I don't recall LSM folks normally being invited to LSFMMBPF so it
seems like this would be a poor forum to discuss LSM hooks.

> PS: I am not sure whether other folks are already working on it. I will p=
repare
> some RFC patches before the conference if I don't see other proposals.

FWIW, I'm not aware of anyone currently working on revising the mount
hooks, but it's possible.  Posting a patchset, even an early RFC
draft, is always a good way to find out who might be working in the
same space :)

Posting to the mailing list also has the advantage of reaching
everyone who might be interested, whereas discussing this at a
conference, especially one that is invite-only, is limiting.

--=20
paul-moore.com
