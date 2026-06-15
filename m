Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2219409632
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544669; cv=pass; b=NN88NhiKRRtgjZNso73+zLGqdWtFZbNH7WZy1TYpoelvFSvioYVuWt4urdfVYbatY6wXuMbgAufYmLMY8qLekHe0qzMHY0/DrE9rudAYO2tVaLqT4ESv1BpRl79W7Zom78Epf4Ckk2JBRdlsnSrGvunu+WydRQEqKHZR4ChPXUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544669; c=relaxed/simple;
	bh=ctVpq5sTwVZL2rCaoYy4Pgvqt7gs6cBr12JV8vrMxZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVcvmlwmg+B7F4MQE9ZFpHIIUIeL/SR3rlPOIrqG9bRh2TiPAdZm+fFIoAnDMltCQnF17pIHTr5ypBg+hAqZT9vhbRGLp3jlvcpMxK798aaUByQAVTUQftJGxfscGfgqzAJLcLWvjlLzwAez4XKiqjAMaLIs3H/M9uEJKIeSWAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGwaSvDz; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGwaSvDz"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36bba9a1089so2180316a91.3
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 10:31:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781544668; cv=none;
        d=google.com; s=arc-20240605;
        b=FFilnVhuXdZwyx8gRb5y+/XgoOJ6rU/e73LNdzVwoYPeidTb/npEzNUlf8NizHEP3/
         dmpfDxLdZC9wJgqlQjOR7l03tTR9+BcUG8u455SqhzFa6lNlcJJ3keXSMnT8ZznPtKUW
         WJolnhfZaWUr8CbdV+pOGCs5JSa62ZOcKd+S9plgGdJ+40EOOnVRNsed4xLJ2Dfi79Dn
         PuBGLyHjWIFsLAVi6wZfjxCmtflsUlDd2yhSim/kaCgFdiRIiov9F/RPSVOqDAWSz373
         6mUel/U7sex0w4yHSpZhMBaUIf0DU0M5T0i1Mg/0WZskYItQ9dhsHlm44OhIEgEra4ko
         Zvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ctVpq5sTwVZL2rCaoYy4Pgvqt7gs6cBr12JV8vrMxZs=;
        fh=+2N2GnFkx6OwCBd3Etg2jQ7eNylwRAwWdKCTjTCs3hQ=;
        b=VbIshqlZzRm1nCmzDrQLudqXvJAT1W96ykMHrgwAsLqW10BKXFwAwYjtWnwUcZaL7x
         c7LPiBP+TvFKMOw3FIjVe3mkUYgKg4AqrCPttLzj0n3J/7Gx3aWCR+kB3nEtKnp0qOpw
         RvcgXckPp9qkC9R6CdpVdTVhIEQGJ15GsI9Tvfvs+Bo/gKKq2UVWmeSDf8VHS3NwtvC4
         wv8jVHbZa7mM6bC8Iy64Jfe/i6aMBNGMh+N1+tSowrLQeyBh5TrmMXnUg47i3k2fn8Js
         ZKL8k7Lu0Jel7rTm5RxIcUYoLk3luIBKfHL+YfZT4nU0oAV+fbnrxe6USEcLI4X6oYdA
         yNWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781544668; x=1782149468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctVpq5sTwVZL2rCaoYy4Pgvqt7gs6cBr12JV8vrMxZs=;
        b=KGwaSvDz8wfv+TpL1jXgEflU3iCJQ9Mv+Lqgz0ShoaZhfRfcjgDg+90veUHTBkJth5
         pCBtYGiSpryFanNHWW8gQPvRKoqCQjCgS5kGqZP5UsQSIN7x9D5csSl14GzaKVFci4jj
         nDPo+t4rHSdEIsL5hcI3qb1a2/9etPGiiiCbwmfv5Rzl6+T+ATh8OperAF4hokJPyci+
         0kZFWX+MURw5yZawWUHDatGtU9kpLcuEDhKRFlE/Ucv9u8GvOLcw2ojJuJYHDdOhzwtP
         +EWa26hqkfUvb5IgMX9xHC3fgKXrnKHN/zffrChOwMX4x7xF5IjY7RFzep/rTVPulxwG
         KX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544668; x=1782149468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ctVpq5sTwVZL2rCaoYy4Pgvqt7gs6cBr12JV8vrMxZs=;
        b=V+nXfeY+brKTw9TRfVXcydLKaYNN5dGmYopiBC60j4jLetCpYnH9Gsu11wfDe+nxVh
         ULMuWgygOiFnMHN/WI4eNGwCG6bBOryTMt0XZAwU3SlzJ1ylQPPu+Wp3Kz8CTpEPAwQv
         /IFvVihDKtr1V6TSeOvJSDO8s+GJgaIa6IX5dF/cMjLvj19GVCxETDWhZOREgdf5ku0c
         lMhM/nJeM28F39tdouLIseKbcgQZC3kTXfh6uWYxM2pXmRgXlwNCtFgS79iqBsKBskPY
         bU/YMAZ2fZ8ZVpQsRwrF0RkMiOSG1TJUih5GTs+s5FYfijDdbfIUEl5EZYXeHSDyVs9v
         wQlA==
X-Forwarded-Encrypted: i=1; AFNElJ9S0SWu9yE76BLwez/C66NSG6iDEXTv6qxNOvuHSP7PQljiult946rbKuL6Dh26Y8jkSAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg5yIdoQtHkmUfCL8I9whXdFhwJx67+C4onLoRdgoHagI8xMM1
	mrU+yLXsmOdRGoFqckILCXXulBbpLmmZqBB0UxNh/yWrO+ODtJCqKGn/z9k2/k2/KVgdzwODJUZ
	PpBuXDmkdogH8IZAU9NnFodkGdXjCDTo=
X-Gm-Gg: Acq92OGzeGtfJKucz75QaCSv5kQGgiyY87T9GeH5WIg/tZ/pM+e1xR5REDlE1yiTHGG
	eZKIfTui7SG1RwQ8KkyoWgcv9KsALIMrt5CGmmf7haFuWcX50qYrK0ng0nzsFi24UuVcMgsSsxP
	zVJ7mBNGXN95mB2b/x3WEDq7Uli3HGPSaBl6PPIqvzQ/N3p1upJe+JJy9NpmTOo59g54I7uxJ7I
	j7XzZwlbzy/yqiNZSpHfAVLojEbW1yB57YipljGT0dBx/UR189c6wzbj7Mho5hJvwuBNcvawu9L
	WTsYI6hz0j5qj/KxA9nQ5fLX26BonpGh0mREYh+Y1jC1jV8qovbO1ixGApZftVkv1J8RBFHPlFz
	5EzerLBgMSWYEBTEVOpoH049x
X-Received: by 2002:a17:90b:4fcc:b0:36c:e254:4d5 with SMTP id
 98e67ed59e1d1-37c2bc5d111mr11614247a91.4.1781544668224; Mon, 15 Jun 2026
 10:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DJ9QS5OUJTSG.1DSRYHG6GAG3H@gmail.com> <20260615164610.764567-1-chenyy23@mails.tsinghua.edu.cn>
In-Reply-To: <20260615164610.764567-1-chenyy23@mails.tsinghua.edu.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Jun 2026 10:30:55 -0700
X-Gm-Features: AVVi8CdKR-687xMo5ITzY_tF1_yfrRENYRdsqwBNp2gRQiYZARa3ws8uVTzf-ts
Message-ID: <CAADnVQ+aV-Pom8xDU8Dcnapv=mUWr8xy-r=5pp2Re29xEkiOkA@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Fix packet pointer invalidation for skb
 dynptr writes
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 9:46=E2=80=AFAM Yiyang Chen
<chenyy23@mails.tsinghua.edu.cn> wrote:
>
> Thanks, agreed that the previous version used bpf_is_kfunc_pkt_changing()
> incorrectly. I will rework the fix.

Pls don't. There is nothing to fix.
