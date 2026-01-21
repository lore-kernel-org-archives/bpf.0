Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308CD33C515
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006701; cv=pass; b=fAOtEyV3+ejzPX52GoVTl5qgBmkON9uGdacGGXMHY6j1nO6UjraoYa70C7fJlVJJkmjcQwHNmekbrQbKfoympTSfoUxnDkwgNCGOiugwBGJ+aAxlwGfc4NGp10M4Ri47JilZjoQ8JZMf1GfTUzTkJrAe7x5JFAvmf75dRCYxPCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006701; c=relaxed/simple;
	bh=Xu/hTwMLUvS81y97PgpDx0XsQ5SQXxVaA2e6jtW6itk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ghv8KBtcT6DMZ6JYugxcGl19LanzvmLsVa1IR0dPtqWSkZattSiILcFsC5KptG3Rj1iUEjM4TeIsh3j5Y6xtEg5MR1rcpuHM/qlt0U4TEdLUNDMjLR2BfayamaOHUEkscUzoEooa+DaoFEwoSNZ3nbVsJ7eI0sGh0ByySMAXjHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JuQvBZUM; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JuQvBZUM"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5018ec2ae21so57629571cf.0
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 06:44:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769006698; cv=none;
        d=google.com; s=arc-20240605;
        b=C5XjdDQZZbxuYxmCVDZd9bwc0eHUJMkUZnbm5YNGqilurBrZ9kqSe7xVHZpcyweqw8
         exXra3xcW1cJ90tpBDvq8VT2JQihj0qSxfrYZVgqNznM+KwVl4KOED5aNvDIVZzzbl5N
         dSI7Zjpb6486P7YiU6BDYa1IGX0nlPFZJgTTud68oG5MJpXOwT3OMpu+sfrCg5yQCLd+
         Znji1nH3uKAsh56+dVj3h1z1lAFL2OHUlVOtAa6o9cti1YM+5kU5RNnLKvKmCG9tyAn2
         cKkv3nOrjiOzDI+9sIZbwREfR/DQ6x05oBio1qvMyyGbUkgEqr8Ui3Bl8MXOMfhjiQXn
         9vHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WDknDeeriRuUySYC4BIAbGBmZKe22ziZVXk3IrvrB/Q=;
        fh=1TLH7IMCs3nqxGjRpFl+t25GxejqjT6s8pc+B3RcxkU=;
        b=W3mc37bKnoVaS+DevY1eUA+5WGrqLHTCOkS6My+dpIPzTSEKjoO/NfDAvH/CzJ/cwU
         sfMeopWblqepLMTKftnf1GfugvSQYoTrAk6QyYAN+nliLcD0csQI9uyhKmPXRxYKaCwa
         zsEhxp00j1ZzsVPcRx+WLtJWqGYnKAi4tagdfMzZZEF++Mihs77GZe8uZGSY7Y67ETGM
         Ffu7djsf/g5mvGesMj6awDRUiTSVg6tVQumK3AUUAg3wCCTwwVxCxs4bZDD9D0g2uTE8
         R8zcn1gduHBJokdQn/U8cQbUfPHcPCOfBfmOGy9IpRi5qRsqeVPy77dQDWYT4QFrXVpV
         Tf1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769006698; x=1769611498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDknDeeriRuUySYC4BIAbGBmZKe22ziZVXk3IrvrB/Q=;
        b=JuQvBZUMHV8GkQ3lzJYfdnQSMm4I6zL7A0RLc3DyjQw3Mbcd8OIh5NCJtQw/sjopJA
         9/1MeMk7SYiiaRO5wVZfUZgKWR/AFdT26uMakfQ0NX7Jjm8XoUcW/D6PfDFUpUpnzAiF
         iv1uhgi+bfkm+kII3eD9OBZRyKdTbFNCS4fDS24MWA3SGzdF3WZ0KMul+LF0QO+1fgWP
         cmJ+nrWapmZTKD6jUKI1Ay6LZoW9NuSw/CkzlZw5ha7PynzLodke4JfvzFg018aEI9LS
         Qo0Bigw9jyGM101Q84orsOMJAsgBqHoTZSENBE84WBA37y9XFFZsivmguyV/AsHgneDM
         V4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769006698; x=1769611498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WDknDeeriRuUySYC4BIAbGBmZKe22ziZVXk3IrvrB/Q=;
        b=GQiubtBWLtU7O2Az/rUJXBP0Usx/3nOakFyGrz0fvFWUJ2xNEE/xmiOMDZI5HWa5vw
         PW1ub3M4uREpqqaGBsVsb8BylCOGvD0rgWW/vqBu9cmbOmYDFc/l9tqlJvHejRtFLZTg
         bW3epJv/QoUN6+Xi+cGhs5CqNeUzwvOYCO/95JXnPRAjAYrxZfCZHi4xSFf1tbrA4Z2k
         2yyyu9GTtSDcbW/UdEvFpyXTgYPDNttdnnQkuctS/aG+iDa0B6SiY6hHEkbR5DOmZ7ub
         H0JB9PFHqsWaGq2sndmUVpxgrV9+NeAopClUC/VzL6bp1aZb3e7ipk3pp2MEvafdth/D
         JmBg==
X-Forwarded-Encrypted: i=1; AJvYcCVcBOp7jcqUvDjh4YYnbc5wkiY8mKI3y1AtLsQ0dVc/Fl6g7VFtmIdkDk6g8FB07YMgKZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpBV6aaFkQvr/Gg6y9O/0MEhZGRBVV1McvfryJz3SsJwzfK3A+
	wLSBzBhQg4zJC0MOvugbGTAcurpyU0/EIUSC0AjcU9xlj3IzvGehKO0schqpr4M77/JvLyx5kLY
	LFZX0Qy2ya7JPKawREIjR9em5YVLoG11JD1egllTt
X-Gm-Gg: AZuq6aKoySfl+i2szQ/+Pos+a3DL3geiJ1A+GZeSbsxKNsm9mM3GCOyRwwiwEVlW9Jh
	wi7B/l0CZ8PQQ/yAtFcz5Uy7QKhG/f8LMUeM/Gf80i8k8Alo4Axde1w55AmCOBnV3tJB5owYJAX
	UmjnxRYswmieYVksimIefJqgKBeMUl88n0LZfYGOgILG/oMHJJrwPKJqsRA/D2K/9KFzSh+Uys9
	AhqVzxIDdIvYLPpyeGAaHs5K20IEVJU2GmEb7KHszyVy5/1hWHRhYUferDyPVlO9W1vxgE=
X-Received: by 2002:ac8:7f89:0:b0:501:50c4:a9fb with SMTP id
 d75a77b69052e-502d85c766dmr69283611cf.80.1769006697633; Wed, 21 Jan 2026
 06:44:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com> <20260121143215.14717-11-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260121143215.14717-11-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Jan 2026 15:44:46 +0100
X-Gm-Features: AZwV_QglfYe-rR61PYDqNirvWqL5d8wU90xI4swixYbQudivaPcO8KkO1yRJQIE
Message-ID: <CANn89iJz1Au-kfk8Kp001vwvuxdndYX-Y++vB6NK5A_CBXVLHA@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 10/15] tcp: accecn: unset ECT if receive or
 send ACE=0 in AccECN negotiaion
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 3:32=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Based on specification:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
>
> Based on Section 3.1.5 of AccECN spec (RFC9768), a TCP Server in
> AccECN mode MUST NOT set ECT on any packet for the rest of the connection=
,
> if it has received or sent at least one valid SYN or Acceptable SYN/ACK
> with (AE,CWR,ECE) =3D (0,0,0) during the handshake.
>
> In addition, a host in AccECN mode that is feeding back the IP-ECN
> field on a SYN or SYN/ACK MUST feed back the IP-ECN field on the
> latest valid SYN or acceptable SYN/ACK to arrive.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>
