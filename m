Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD5137C0EB
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042271; cv=pass; b=K8fBM2noNV80rztbMC9X9/G1X8mH7Ven+rb80laRIzeJw00vzCvcWrSjuoxcLjdcU6NetDsBO5aJmVH7tsTkZsGgKJo7TxGGnokwkt+HY2u1uuErom38TYM3Msji2JXSCDZuadc9YLEVhrzucCBhUzN7azD2RDsmCCE9nlplLns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042271; c=relaxed/simple;
	bh=uXGvn3KBFm5aQw0K51fWIaJ8eD3Gwqir/PJYnJkOATQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1CD/tMjSbsLtrzViJ+MFYQOyW8GKNTQ9jUDr1wIPx6m+0to66m1y/FRqUvoGTlfdTJcBpiQjE9EVnQsZAaThZYK9A/YIz+bpk2rvUnwVMGsE1EfZp5WRimxjTDr7+lBv+1mpAJeDyKNzymuDbMMiWOerMyKh39Nhgtof8HisT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGI0BITP; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGI0BITP"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9984f9a59so5262217a12.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:57:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790042268; cv=none;
        d=google.com; s=arc-20260327;
        b=Z5vVXD0Afyvb+SKW2gXpaHifeKYQbnpdcFnToL2BruAZXV3cvfDQifvcGPxkSn9wsV
         VKJ52Yz7jM98AV+wCqnJLpeYd72ZTbJTczKEY8/RmaO4koshm6bbssrGKQ6BOLi3NGJm
         KQrw+hbsFdfNIEdfpfxm/fxFKxeBYHOMIWHlA08rDhT935JcDBUhc0wkXWX4W5hI0Umu
         EImbs2PLs7iW39S5c8QX5D2AMyyJboX7RrxMDRltkGaaMyAiLd8Z7hNFNVW5cyMxyjjp
         1U9eq6X2jI/gLgsJC3ZvqTPvqlN5UEgm5iA0TTE8HOEn/V/eA7h4mGUU6ntMyemFvMgV
         qQHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uXGvn3KBFm5aQw0K51fWIaJ8eD3Gwqir/PJYnJkOATQ=;
        fh=O0iQjAeA9mPceEP08ExqKjEzWzPVsuPcrb1XiG1CJzI=;
        b=qAEvcPi4mpZPWHvKnkPxeQswvzTjlZkwexNVxHf+LHmeE0FcJcreH352z0zDWKN92x
         /EmlHbqizdrAwylzM8EXPPRT7e6EXez6TiU3/y8MOXZZDXQ7/q6JLVRFEPeD11MPCco5
         lnc69I0ytgh6SbJSDAnaapiVIbVTiTPQo4IGJlZ8rCRpudTFo7em8gkt5dvLdhsxImsu
         xEeJzivXhKHIiYK66AH6u4KNy6AGIEteBv/15y0OHOAybpBnP3945u0vCgcpKKgVuUJf
         I991NQ5KKfRdiTHY7t93xSaoeSGeUd2FjDMLvnqGStDKPsolYOLHmhOfqOxPyuY1wDKu
         EVJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790042268; x=1790647068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uXGvn3KBFm5aQw0K51fWIaJ8eD3Gwqir/PJYnJkOATQ=;
        b=NGI0BITP8L/a/qC0xbm7HZrUB1FhX5qvt3/58DbVkDoNSmQslwggSrJ4B6WAIuRrHq
         +fb/Oj+HxVeJ57uqvBgbbtCcTcE9YqLjHg8GWfhsAxh6rc1lxPvF+gJQZtPSNPPT1rU+
         eXlYrkqEScXOMJmDneUFwHwXyI1J8OY/8TFwyBCGeRaPiB22GPtqnCxLr6jbwiiBANCo
         atOrATWzy6hJfHRvLfzoxwCa1AX/WXodQiKsJVfXljILq3zvMqVPqmHHfS8fX5hyLmBv
         vfFGv7QiRc3FpXVjQJ63L0EEKHh0dzPYPhTsvpgbIg+dkKkZTogq5Z+ybRovjQWj/6gg
         XWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790042268; x=1790647068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uXGvn3KBFm5aQw0K51fWIaJ8eD3Gwqir/PJYnJkOATQ=;
        b=OP9ro+dOulFQ9XtL1qi3K6C35cvRspFYAke6sth6l+vp0m8jYwlDf23431pCfibyIE
         OG86ZYOKV8ZiNeb9wKAg6AUamDbVYpVxhDktDOlJ8kNxlU8eCg4rJGcWw3SJ8zRO0R3w
         GuxxwuD/s9o7I/DOeE3GyrmDzr7j0VjYUR5LFoMpIYe4GMo1B0EUgcKtXmnWVmLZcCWG
         AKIzxvtQ3o+IobM3IEzEjZ5glk/8/iqI0hMYg18p+UuUNzYh/rhZYeEvrMrZVA3wgyto
         vB0M/D2s6hqizb7/Ydp3HSGeCMYadXV2MmyhDuXHr3muZ5FMqm8vCRB8BdCTCl3sB6pL
         1Lsg==
X-Forwarded-Encrypted: i=1; AKwUvBybZEErpsLWyh3w8WrmVJANVnVhxQFDxX7WQwcUQDKihmGrf68WsU+NSa7Gtk7TEeZELgY=@vger.kernel.org
X-Gm-Message-State: AFuF++ki5qMiWBZgAAHcnzM5Z1+fb/LFcKeqm6xoAOBCUKMjz9BSPauz
	6TmlljDwkGijGGFPkiWpC5cv5pV6uaWiX567NY2t+Q30KqmfSYXJDrhWIsku7KQhrFYGLjFPnYM
	Gf2pjpfU7kI6fbs3HUWOqPgmHY1WiQ/4=
X-Gm-Gg: AYBFou1KYvCfVxBnrNqlItZSS4skPBebFH/z6wiVbKHPYjd8S5RrV/GMxuyK16p9QnJ
	GF9Zo+A3OO/NDyGTu1zbDLEMJCnImIu93Iq8hQx7djzSTRCkFQq6LimK7uK+uWOh5qGFMPbc5J7
	idGNSH7C/q2cYvH7rP5gBkJfScq1mO+QwNUve3odg8gw2QVwHFgGMRkbIlteWxjbKlunODAG4aQ
	U/vp+XeqzPKx5AgxjCU7WaKiZDvNjo4+HKBCDy0DQnqd4uFXiG+YEzNcdgy5G0ebszFyjlSrHV6
	/xM5M8ZCy+7U2qzJjMTakjqbKjbMPeh/t+eLiNerbeThDxDhvYLZQ9s9LyCghbLJ2kWiF9e6yKd
	H/zOB6Z/2sit5
X-Received: by 2002:a05:6402:1942:b0:6aa:a133:cfd1 with SMTP id
 4fb4d7f45d1cf-6aaa133d1e9mr802399a12.20.1790042267824; Mon, 21 Sep 2026
 18:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917153923.904124-3-bestswngs@gmail.com> <20260921154147.4e1e092d@kernel.org>
 <20260921155826.5970f028@kicinski-fedora-PF5CM1Y0>
In-Reply-To: <20260921155826.5970f028@kicinski-fedora-PF5CM1Y0>
From: Weiming Shi <bestswngs@gmail.com>
Date: Tue, 22 Sep 2026 09:57:10 +0800
X-Gm-Features: AcwNN1XB1q8PoR7CFScqBTcECMNzsAWeNJ-yjmOWlW5xdCHggLWmz-bfJMhZfLc
Message-ID: <CANgPUi2JeO9psd1gL8Ym0k4DMmkzww0fjocvGN_yDi_9wttKPA@mail.gmail.com>
Subject: Re: [PATCH net] veth: manage XDP program pointers during channel resize
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, co+65e5c76b187f08b2@bugs.sh, Xiang Mei <xmei5@asu.edu>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8822=E6=97=
=A5=E5=91=A8=E4=BA=8C 06:58=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 21 Sep 2026 15:41:47 -0700 Jakub Kicinski wrote:
> > This is pure slop, cramming loops into functions which have none.
> > Shameful, really.
> >
> > Please test this and submit it if it passes the tests:
>
> You know what, I'll just post it myself.

Hi Jakub,

Sorry about the poor implementation.
Thank you for pointing out the issue and taking over the fix.
Best,
Weiming Shi
