Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C55A1B86C7
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 02:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769912954; cv=pass; b=ZSii/w7DWLaeEUezC1dDyLgfLdEnXvO/4mtaTQVrmOXvBFn0L9e35w9Yu7xZ0pJry2jOvgXeniFBTZYFkjMqUDwy4eWBlZsqLnjNbUbPK5uM4v2k3txtBDz+1yCj+DKauml/o8Pw9zLyGTsU2S26Jx8sp4jVbBZZIfQwaktXzRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769912954; c=relaxed/simple;
	bh=KXycpc357A6wBueFM3htQx3+sDwMFSwA0igwjNoKuZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDWaRmsh5VjcTrkVFGCVkZI5xCd84r0Z28DQL12cq01nW4iZ2l1MWNShWsT7AauBpvq1MxB11qUFbs+5c06cOBJBfpTeYhi7bDcJG2QfePIIqImVWnRimkytSu5vUwruXcLTzOfuzAShFxZI3DWYHaKj4xcvG9KrFdB6GkJWGnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2+Yagw4; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2+Yagw4"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so3287271f8f.2
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 18:29:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769912951; cv=none;
        d=google.com; s=arc-20240605;
        b=iz6BUYfmMzMI50WxqkDB1Hg0Z8xKxsGYFxirCJuLhXS2muoUowI2A5kvqAr+alhIlM
         eg4KqXkyHELtdjDT/hGLKqPzZFaJP00VNkVeH7sq4EMx8vbJyY2BKxUJgPCTYzuTf2AH
         jPUHhkaDzI168+U4EBqX6zHY4FHQe6K6VpKeily2X+oObmBgIh8DuZ5SDyCPqxYNE5SI
         tQr/vkDNGwuWgGK73PPR7GClS0Bsr4prhZlPKYKpNMwuOJ7axjks8t1J6/Mlf94Iarc7
         PNhehROQa3k/V6ZdXeuEFRKyE01TA8oVpgk8USdVzFEsYfUvM0r7iW54ewAlYQbiOILZ
         VXUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KXycpc357A6wBueFM3htQx3+sDwMFSwA0igwjNoKuZw=;
        fh=teKnXWkoKSRTR1rJRL9NU9uTTkuKJXyNGYDkjw407U4=;
        b=SblL9qilcUDV1XbKdyOVSeVXoV3NA0rXmFSUzJ4Hsi9zNASnh50dQNJwMO/7WMOXpn
         AJ1BC38kEJw4itg+l2Y+n+2UTvLzbq2rea9YQBTeu5k7XndgE6s0JwlPRSts9HLf1xJs
         vUdKHJPA3hfottmtlZjK37CmznQ/mR/chKrtnWrKfe69iYIbXEUvGpWC1Z2Soc9hMbQl
         VOm4qFCogtcB9u0bYB6G7tLW3j2x+7S2EgtT3M7/J+6Q9FF7ttTtW3fww1/VrOGjGLFm
         oFwmA/pQpg5guwsr5DUq4RdPBE/F8ptaR8GmCELN0k0WZUQa64yioEhM31RtjS4miTkx
         RIdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769912951; x=1770517751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXycpc357A6wBueFM3htQx3+sDwMFSwA0igwjNoKuZw=;
        b=X2+Yagw4C1o2ocC0dTB2wRqAkofYlk2V01DxyaPMm978cmCGAwMpNQLM1vqZaO/ERl
         l9eae2W8Bn6/1uFE1PEDk76oGqwH6GEfS6UieJ/GGrR+BUJKOR0a+EHahOGIEHL87T1F
         Ro1fOotR7mGpixL5POuMGlbKt+GAK7hFEtitbwjziXaza6IKvHcvCJke2/PH6CMzHHRp
         RlP1p0cQUYaLNjIy3xfoVLk56g+3djF7LAWaFJyyvyMEEf33T5yVoJ7kc+HH/waYqy2d
         +Oulg/dcXqmYNRIdz5kX4sM216vikH0a5F0hd4/9XiT5/cwKl5S5FsEhnBK8qoQR64ZK
         i1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769912951; x=1770517751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KXycpc357A6wBueFM3htQx3+sDwMFSwA0igwjNoKuZw=;
        b=Pzos8z41eIHomGc+Ax9K3+DaNg+Q1z+SAVYnMd5usVfspwNqa/IObf+/BfOxTHe57c
         fyEloquY2VtD7unh/9vQVbCN3zWL3+lbrJRisGyUYDPZS5d1E3DFComfPGB70pzCHFU+
         B8z0tgei5Zvf48edc1zEk3vGMl+pMjtPYI5ZqK6Eu1jVWwQLWlfLxIK1Gtsp2RLGEh4a
         7Mm2TQ3bcldSOze1ZbUx72KJ9taPL39+ikJXutRYPr00GYIjBQuI0pj9ujFEAne5hl67
         y+EE/2XvmeQOZvSN63mRXxgAG79exGPkHjSFc2Ejgq4mofWW2NSAsJ9pDTLCZxUUEQ6t
         r2rg==
X-Gm-Message-State: AOJu0YyAeZdcKavQ7yORFn4ZYLP8DxrZ6gHGAw+WM/9IVudHj2Gm6X5P
	12MCv874lrUpOaV8Epk6wZRfOIwx+vcjgnm9y4gAlhDPuIcjPiXv3H+qq7DoifPn9KxmjJgB54W
	WfSJeKJhtsdf/hxE2pHHmU1PcrxQK+jQ=
X-Gm-Gg: AZuq6aId7gH8jfiGwV1G2xVknMXyMn62wmWkPh1oBZm01m8eBMfEG1gbe598pCEUZnx
	M5nVOYhPBAUj3yZxcQyMr0qe8NkQGMagvBb6bjMmYBV6WZvYHIvAKPsQDKT8GCiliXRcRATvYT7
	oXTcar8cZc7eq7uyDEJIL8pN6oCjVWGMS6hQyZmxCBz3dckBt89OXm6L142lJBosianw1b1jbB4
	Suevlzx0BEAKAUKllb7qnPOgyXHRVVq0gaf5K1CiTv5zoXWkeAgcsFvGoPE1gbUUDXg9WDUT+OG
	sU1Yc+ojzOvtyGGK9NOxpWpfXnRZxkJ9PQD6EZwN54Ji/HsDAlzG6VRBX6NaeHzU2OF88XuR1Ql
	SKFR+gpUeNXUzLw==
X-Received: by 2002:a05:6000:184e:b0:42f:f627:3aa3 with SMTP id
 ffacd0b85a97d-435f3ad8530mr11044647f8f.56.1769912951224; Sat, 31 Jan 2026
 18:29:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <754601da.6db2d.19c1704f391.Coremail.kaiyanm@hust.edu.cn>
In-Reply-To: <754601da.6db2d.19c1704f391.Coremail.kaiyanm@hust.edu.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 31 Jan 2026 18:29:00 -0800
X-Gm-Features: AZwV_QiZ03StB9sc7ltmuCk1l4IYhsyqgZWj1ysjjmlEtBAnQFdXPHlL_lGS3GM
Message-ID: <CAADnVQJZGUCVuG16ZmZMNa4B9QLRAsMBWCXu3nh7p8qQjcS_Eg@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in bpf_trace_run2
To: =?UTF-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>
Cc: bpf <bpf@vger.kernel.org>, Yinhao Hu <dddddd@hust.edu.cn>, 
	Dongliang Mu <dzm91@hust.edu.cn>, hust-os-kernel-patches@googlegroups.com, 
	Matt Bobrowski <mattbobrowski@google.com>, KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 31, 2026 at 6:26=E2=80=AFPM =E6=A2=85=E5=BC=80=E5=BD=A6 <kaiyan=
m@hust.edu.cn> wrote:
>
> Our fuzzer discovered a vulnerability in the BPF subsystem. The crash can=
 be trigger on bpf-next(93ce3bee311d6f885bffb4a83843bddbe6b126be).

...

> CPU: 0 UID: 0 PID: 5217 Comm: systemd-udevd Not tainted 6.17.0-g39e9d5f63=
075 #1 PREEMPT(full)

I don't believe it. The splat says 6.17.
Maybe stop trusting AI so much?
