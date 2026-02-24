Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D30271464
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771969585; cv=pass; b=s+8xkxPNLnPqJBDuQB6uo5hft68uV312CyLhlxGvHhbtAF2YNqPU8+l5YE/9MyQxPAQEfENKxxDZ5fYKdXa6ci14uHRdIO37aUWH2BQGX6kubbWtQecCcQ0OW+8F8p5k7gh48I0NHda1rJWEbbMnhi2/ad1U2/G2iBtm1Qtzu0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771969585; c=relaxed/simple;
	bh=PVOj3o8hTSd9krm191kSZ4lxTW8YNJ4NqIl8XqoBMeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwmVB3pv4oOBrQa66IMRsjiBakTGHfvW+9ArVrLhp+ugeE9h6GdJ6xI4MnYgRbj3XoUX0YCldG1rIzFz7cWTaWlEk3EHYka0nxr+wzwLTHEvzNNAlk3dccEy4JXx2MBJR0gAkGCUw/Pz8QRTK86dT9XUTGJb3tfe5BVPuuhdFS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwC3g26R; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwC3g26R"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43945763558so3801868f8f.3
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 13:46:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771969583; cv=none;
        d=google.com; s=arc-20240605;
        b=NNhK6U3WwQhZH2zy/de41sH9iHCiuktkj2yUwuainu9ecKgL1HCKHs/aDLcNnH/Mo+
         S8JwkkVoHBKS6zEeTZ09bayE+Az3fNw23ePF8WjLQwLSjexcesVSnoTryKVENlf0pLL1
         sV2LUMm77hEXqwH2ArcU8xNBwqXq38Ct+WI8cgYcOEa2eGpw5ZSVwGKkJ5cbaGcWmJI1
         0LvTlAEEI9EYR9iDO6eimDMNkCzroO12zs/4bacdDNathb3+uPnoqEHOD8uwlw/gVaaK
         /8Op6jaj6hbvwYmEK+YhJCMHcU2pDBrr7Pz0ju+ON0IfyKxlISGf+tbXSBqcMIlb/7iJ
         24lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PVOj3o8hTSd9krm191kSZ4lxTW8YNJ4NqIl8XqoBMeY=;
        fh=QWPamShyA1J/8s5doFWE3PWqLapUJDuSRevdrJZqM+c=;
        b=VJ0X914SaH88SXMgIXJo4iNQNze5YzrYDXJYGyWIr2rk+MIYwhkh5HaUn3mjX7LOHw
         4cNB5g5psWEFIBrp+VXhEotSuWW1wioFtDdKHzd4cPGlZ+OHSUtLCt/y+BpPS6y/esYI
         lkbcfy5dHo0QvCmkvMOimXoXwro2HsCV6MSh5YpKeWOYPukhT2y3ZwDHSbH172hSFPZb
         P7C8jH+TUAZyzw+Jv7cD5/B0mocMGDn1gLEJobWFhGqIzP/J4PWECVugnxls3p1MZKkH
         N/rLcWsLWF0FziQpxor21aJUJx1IErrGCXrCxLSSTKI5dj0x9Um9ViMra5kQCHuxtdRr
         Zjzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771969583; x=1772574383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVOj3o8hTSd9krm191kSZ4lxTW8YNJ4NqIl8XqoBMeY=;
        b=lwC3g26ROdYAmwnsmSGQWZVVc8p4e9b6P9iw0LyPP73KpdPwwDbezgoILy9iszjk2U
         u26Om8ZqLgPriCLNzeZB9Xq+SLpFwjY995mB0nnK6KJFFkzcNpJupi601nqIVpewF9Sz
         47KIn1RFtehHTn8VoDu1wgbAbXsXmPdzig/hcGL6U2HROqLoA6YnE9W1BSO1oH5MhL1j
         5FvyAGfs5BNJQdlORlR6cF+D7xegQ4TmBH9Kk5Tx+0OsnAcvUZ8Ik+CCro64gRTeMm83
         MCzJKlZCeY7OBL2lsayN679B0CitkeEWlFoEOJsifDisEp7l7QAq7lCrxC88fY7DrB+f
         3euQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771969583; x=1772574383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PVOj3o8hTSd9krm191kSZ4lxTW8YNJ4NqIl8XqoBMeY=;
        b=eymi4MTDLfnO1XV0jKBJU8y+033/WzS7BTMJPMD3Khib6hbeM6xhaXvr+0Lw1sW1qf
         PV74HW+dPmWX1ZymCGi3OYa4sIwIRGXS/BJOMLt17BpFBnGvF0AtEZEekVlV0wumDvkI
         jq1IsWnMGwKOmed7xInwMDs2JGvUALJnumXXGPWmHJBqwei4sal/+RlGHhRCj8UEnHt4
         4t5V0rHNkofpLGqNjabsCMr/eYqhU4EoK4iLoz+DRNnuLXCmlkYCRh9oQWyC5b5g9dJD
         bzXJgKvv5HiOySvi1SVlgiL8646Tj2URCRclyi3uz8f7VSfnFKQZAY2dw/sm9TIfjti4
         xBMw==
X-Gm-Message-State: AOJu0Yz+V6LKAprFIRjSu6BX3ZJB3oeNuUERJlIqY+sd06PXVSZQvrXA
	vycD1sbxIAaYFNtnKubpMeGmy9U+gnb8yWApnl6p+FCUKzh7Qf2TsIwF58XVm9hoH4NX+YgisB9
	IB/nQ8Js8mpaMfkRkGsrocvyy8hI6Vp0=
X-Gm-Gg: ATEYQzw9ny2wYEF95559TQwfR9GrBErXrU/NI7/sh3wCXpszFRjJZrrlZoZx2BdVmON
	NgKbVMUxjrnW19cPfLkOADZtFA84+EzxUcOYhpp1N6JSD2NLC71buvtoUFD7V35NXQBn4C+EeFO
	5b4ef+Q4lBx67aqvgsaJ+e0Y3H9KvLqb8TEf/ton3xBnQEIETtoY9OSFL+Xb7QZO0r0HlEjmWoc
	gPbLaJ4SQ2juHDeF6x7mgyFEtQ5er/oJgJPfIVLdiBcrEwr1lt0dj0sADIoGBpfNnEAT0o7vAUc
	LjRSh66MxsZWoq74n7VkWqPswIdHb7tuz5jRey7PV+bMXdLuix3raKWCMmQ5+ZOBajlpjjx2pT7
	7/7/DB+E6
X-Received: by 2002:a05:6000:2901:b0:435:b068:d3da with SMTP id
 ffacd0b85a97d-4396f16e32fmr24640989f8f.4.1771969582627; Tue, 24 Feb 2026
 13:46:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224212535.1165151-1-puranjay@kernel.org>
In-Reply-To: <20260224212535.1165151-1-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Feb 2026 13:46:11 -0800
X-Gm-Features: AaiRm50gTAmzemHp9Jp45rNbK27fg6IJC6X6VZyi-yYOD9AxE02RcnnCQPefbSQ
Message-ID: <CAADnVQKO01A+PjwYCu9+HB8PK0Kb4+HGM0ZseUzY3eDMvSPqDw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/7] Introduce KF_FORBID_SLEEP modifier for
 acquire/release kfuncs
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 1:25=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
>
> This series adds KF_FORBID_SLEEP, a new kfunc flag that can be combined
> with KF_ACQUIRE. When a kfunc annotated with KF_ACQUIRE | KF_FORBID_SLEEP

I don't want to introduce this new flag now only to be
replaced with KF_ACQUIRE_LOCK.

the follow up we discussed in the other email is different.

pw-bot: cr
