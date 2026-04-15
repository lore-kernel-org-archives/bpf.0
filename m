Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7B53242CF
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 04:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776228064; cv=pass; b=gxYhzxs5Y6wevfuxRX+E6/IJLikvsidhGFRTemPI4iF9e9HHw6WonZX7hnhna5bI6eOkx6Ph413sH36AYi0T60vVyffzdamIDwA48pOmPHQHtiyWf2Xg8okykPyc+kUwqE5y/4nXCSDVV5F9xU31tQkHKYJR4LcyfifDBsV4ujg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776228064; c=relaxed/simple;
	bh=IMc08/7kTx/Qbu2jU23QMO24mjlRBTqQKiHCfUGbQuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnbujZF5CYA1FJ10axoqkFMI7KzOOOM/xjgkwzzPUfU4ZAaKo4MR1V7e6pYbExJvDrVj2fHFU5n3xI2FJmDPGEym4B6NuZyWha8mV4TwCYXd9Z+e/XDC/Qg4EOeDZRXyOcp0J8d5Xn6BwtALUBPs5l+ReZbBtuZ2anW8WfppNpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYaipUB9; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYaipUB9"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cf8fe9c2aso3909424f8f.2
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 21:41:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776228062; cv=none;
        d=google.com; s=arc-20240605;
        b=Vw44jmy9+H8MXe392m4LbRFKKxYnHKBCyqlIzY1MSkfXY3znBxSVeqH4232VQ5odx+
         649iwLbCKVoMbzWlypOTKshMAQ4d56Ks/Z9Qay/mAahAeDz3FEikrGBa1BUjBLYfdr0z
         rvie59vQOBWGHfcgAlTlPJklCgjUnxzCFZimR1laGwVWZFuM/a5LESqI8t/jlyQxFcq4
         oJ06bQMq3AshJw47LMert1He8EykkH2ijKPz5QQuJe/G9V7E4pBlgjynIdoU+aLiHMXn
         ZuTi2mCj4qg8ejEUMm+LbR323J7VjGAdSuNx7whNdjo7mWk/5m80pZUPfFqsaVE8aDdl
         JQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lVooydAntdYOlQBFHXvaAAcCJVbhF6A8tmJ+xV5KLZY=;
        fh=pOIEmOiYbXjGqrRFhLagr5T+09Dk3IIyuM9KpIpuEuk=;
        b=HeZDRMtKIedsOrqyecv/67RJc8vnD5zXMLY2ehcyptjbyPzoLMev7hSG6Z585b0lCR
         M+dI7YeOymHnMiHh2tmWyxPHIALhVhM4MjWlnxleYP9DlGZ2sWtoJXhxI9lnLXRfm1la
         m5QreEWOb+Fb5boqdRtmxhxrBjJkYjNqnjTz2g79Is7FrJi1S9PzbzK1d4lyVRGaQq56
         UxquvJHIhwSNNVvEtiFKrc5i+r2PT61sFUqTMm9tKKn6ceEZA5cmHeuAQd4CsFZrT+v7
         upswmK8xQbP8vHPYaS05YgDytfYHEY6n2qLMj0mNaYN1jP5ac7wqO+1W34LwiCAtGEJI
         K5FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776228062; x=1776832862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVooydAntdYOlQBFHXvaAAcCJVbhF6A8tmJ+xV5KLZY=;
        b=AYaipUB9QVfhKLUyvXypYC23kvfruDRm8BcGCDGPaJsXW5bGqjNdMnTK853ISZ+wR4
         eFF/hco5UGDN6yoW/TAdtuVbkCIo2lr6MBzF+yzyHmTrtudwQ6MhcN1DCHOnkBfD4FXf
         dKzR215FqgI3+Dcz51kpUVBhvMcjnPrtu9NSa0VpAA3JT2xMt6acqdJLWbh5FwjiuYWp
         2fBYvuW6rZOKfc27pIOdkKXs/JpoigIthgBgB+q5Rdej0TeY0lWr2aZ39KwSno7eXLTr
         dddS24pMqv2R3rn50DYP+108IuJREKycFe8ueZjraE88rtcqkiiRbsDLmVdVHNJ0+GkV
         t2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776228062; x=1776832862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lVooydAntdYOlQBFHXvaAAcCJVbhF6A8tmJ+xV5KLZY=;
        b=omf7/tjFDuLT8zMbDitDIIsO9o44Wk3deKG5yQfdQNfUzmNodvdSKj0V71SyOkG1eC
         0StmmEsveVfkLmBGhv0iuV6GvpLvvO6PA0+ULwE/YVm4eO60t8bkw0tRlSOFlEhB0qgI
         qjxCO9Cn9TZSSalFY4ceGZPDn3m9pU2dfD6IX0Or1PEHCLWt22S8sAJeVoO6PfDLQiTF
         m24S1LkDntEU917bIeC1p9pa8Xt44EjsbQYkScKZ/s4tLBy/s/fkhZvFMQdEDoth538/
         0Ud3Jw+Bn0t6j3WYaoPOpA77955WzjCe5tTPu2C9s+8hQetSD1MntFG/ItxudgRiMfVK
         p3XA==
X-Forwarded-Encrypted: i=1; AFNElJ8Ywjh0Y80TPYmpM0ezl9HJcB6UYN1wVS0L4eppSkis4APhLt45MxDl1TvW3ZLLLQbHVOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLFNNCtL4S4mFPhuKm9HjCMKUQ2bcccDtYP/VwiNB3z5C9wWyo
	e7xa7Q2TjZgkTcQQxRAhAZxYtH0kpsaFsLcy36nhTqHOkrjOY6TqA3iQb59CMIdmzAr8HrQmQqy
	Nuexh929hJQGScIE7wzuVXwAW5ODn9UM=
X-Gm-Gg: AeBDieuIdFsqZnDoPv8vCX8H3xdCLNxh5vCWOzbK6XctwdFHM2CfJASxXDW1lEZ3kpi
	iAC8RzK6pCA2/x1mx8OY85lTqra3Ii7LKVF3SOoxzyy0y6orql0ux0KzDgGYUA1vVTe6wOkY31t
	lKw0cPiGdSpQgCmDjU4dnRNEZoMqeokeiOiRc5FuyTXZ8HX55bRsez5NvFH933eq5+TNuAAlUFZ
	uJCq7Y0dk4PXLXG/2qPBkmAfY5ePcLOO95BqlKWpLnarZIcGlOf5OAv9/MUdbG0kcZna0rxc3IM
	MlOULbuEeQOe6ybGTGvlOspqOsyzDeIbZriQw85foOsPo9fnx3zc+rkmpa2Nntb4oEUyXMSGPss
	Nv/f1bEEye+xgdZSDc9/7VJ4UpGoUzjcAmzV4
X-Received: by 2002:a05:6000:4203:b0:43d:9bb5:bda5 with SMTP id
 ffacd0b85a97d-43d9bb5bfccmr9063438f8f.40.1776228061643; Tue, 14 Apr 2026
 21:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177601563477.7932.4081917600853246368.tglx@xen13>
 <177601564263.7932.2238613098642404049.tglx@xen13> <ad8OGZmCVRc1C-Ck@MacBook-Pro-49.local>
 <CAHk-=wj56cA+_m8YL-5HuHeSDsA_pvuH8Lu=K4JG82iw=G6bAA@mail.gmail.com>
In-Reply-To: <CAHk-=wj56cA+_m8YL-5HuHeSDsA_pvuH8Lu=K4JG82iw=G6bAA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Apr 2026 21:40:50 -0700
X-Gm-Features: AQROBzCdqHMTeKtaPc2ZAzEuPVb6ssgUHdawXKeDzgSBzM4Htk6bqQDezrv0o08
Message-ID: <CAADnVQK4MOCe=oJPgUXwZdwTu7ZK_WjmpO0jk87A+j0zJeaCTg@mail.gmail.com>
Subject: Re: [GIT pull] timers/core for v7.1-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 9:38=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 14 Apr 2026 at 21:10, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Looks like it breaks the boot for me.
>
> I can confirm.
>
> Trying to narrow it down now.

Instead of full revert. the following helped:

 config HRTIMER_REARM_DEFERRED
-       def_bool y
-       depends on GENERIC_ENTRY && HAVE_GENERIC_TIF_BITS
-       depends on HIGH_RES_TIMERS && SCHED_HRTICK
+       bool
+       default n
