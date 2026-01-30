Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DF921ABB9
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769799313; cv=pass; b=TJK6f0/8rmelnydX3HPqIgqZW0LdkffzG/d6SwzGrVhStJ1w01J+05YL+q/QdFktm2JySRbP6bU74WinRn64wxU5r5lpZXOzYvfd7G3wXSPdkHop5KJ1d1Xg72esY2gOjAACj1ZPASO90AF+j0Lt2oRaE7fio5dFf9elRwqLNTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769799313; c=relaxed/simple;
	bh=ABEZfxsW2syqPlu6/K4Mc72DV+nXVeyyt3BSfY8vI3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/fxH5yd66RxVWvm9IlVmyqbdOiGvKLhesfnIkizrLY+E3NPJo2LcU03Em/FSNTB5UzrK6QeFIlZOrrPSoWlPYz/QbH0mL2rU/cqMjW2f9RBXOVzkZRmVT6Er4T5nshmb+0YoSNMX15Ou+qjMvvDPBEg+3dmMlwqInPo1eg9IDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QroVKV0S; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QroVKV0S"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-505a1789a27so9229491cf.3
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 10:55:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769799311; cv=none;
        d=google.com; s=arc-20240605;
        b=Sc92VRmfdcEMv5gmt6RraIA6yOZZk9Apvlf1/ofuS+2yNXZ9UWw8FjgWEivhpFWKiJ
         dWBj5b1y7a7VgtNn+38wt3d31yY3gVfl2GOxH8C4GhiPrk0FyOKh5m0tOpLIfIkbnyh3
         K2G4uCOSVJeD5XfZM3WMR9WgLGVez2zQUozH8FNvrkfoj4zf9ymRQu2kEoPBUe2Is1gF
         CRPc1QlkfBhZb/3JrUhOA8O/EfGHD6S8Pk2VGyG7XAICpO1CJRfVSj0zQJC2djWdbuEe
         7g04AfYLBnb+SmPhciuwfWv1fx7xySngPpJGJ7ZeRcRnQoHojBaidDjZqG5xWouCtacn
         xohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ABEZfxsW2syqPlu6/K4Mc72DV+nXVeyyt3BSfY8vI3Q=;
        fh=h6cv6cSsjiaxqPMZ9QU2imURC5vRUOfmhHdhyS6wt7U=;
        b=benpBKYBRwa+dCCZF4sg1iKiQw6aY2ax6BO3N5m12g/so84Hytx4iXLsvMK84tf0le
         bzez/K4jb/tSIhrb1vTA/yuEfJp/uya2ppsC3knd0sTnO+hz/efuH70lwlEDCQoXZRO5
         pJ7D8AuFcDiGIWEOrf0M6MxEzhI+YDJjJMKJbI1sCvjb3dQ8t/3/z5NPag2TuJoW0WO7
         mZQmDIq30+oA87E2tloA3yEt6yGf2h7LvMcUr0RXlAUhvp0MXAcld0Tb1IyktmrJ21QX
         46ouU84kTxJbzwybf6dlXfomt2Cq7ezkL6juj0DUi5MrCR400EN2JJX6Lga4Du/Tl8pd
         r3wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769799311; x=1770404111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABEZfxsW2syqPlu6/K4Mc72DV+nXVeyyt3BSfY8vI3Q=;
        b=QroVKV0SobjZ4s/B+ILCE0TPeNkL8N4u/RlfMtYG6/eIaJynacUGbPzM+afrGvpCt0
         U/HrYlr2Gf8cC9TpZiTldf9a3fIoUDjPcYOpPIzECz3SQJUWCJfBJsLnZy60SFOE67h5
         iftl1df5FU+Mw6+17Bing4EH3IFITJW1BianS8zKDrp5rP5yYC49M4ONKFDiUXWD5Lnq
         x/grGLVdufOJOHGCl74WGCiD6gssUgi0wbGdKb1i8H+yUck8Ge84NpeN3Eevvg+dQfX9
         yzzOP2oVg5M2PgCJim3O0VRPYcjQ3TIlsywIsw9WQBxIZOr35AFCUcMKCTN4r66tn9g0
         /xnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769799311; x=1770404111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ABEZfxsW2syqPlu6/K4Mc72DV+nXVeyyt3BSfY8vI3Q=;
        b=GGiXoQbyzQNT9zCiaVre7r8LmkROHl/rq+rNhbe/t6shLU3v/0fYZB7zZHT0KrB2rJ
         zwp5UFDv+HC8+W9+djXwH5tUWu9/yOOuazRXJpnjS2ViSqBcVP4XMZYUkiAtAY+0Tqx9
         /rOh5XnxBeM5FiZ2qkKohboBJuaYux2ANR/JEDDYnUwnml7GG4wUWzWkj3VYRzqp7UFA
         NvG0jzBiX64hIHBSWF19RNrmkZ8+cy2foJzfTvt+mV+VmnNu2PlbOAlUhk9h7zqqdtY2
         3xVPD2ZWhmSHj30jCBNAcbuqiZeJrHGGCcp7J59/ErzbXWbEo7IqFD59bt7e80kspi0y
         iiCg==
X-Forwarded-Encrypted: i=1; AJvYcCV/wCmi27dODD4PU8o0GmC/q3I3Nxjsobob2tevCesXgostHZMady7U4uL19/riwzMTkAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL5MCElOl5tcSCEkG4d21Oh+l1cF6pzWxAg3icUqxY4iqoRe4C
	R+AiZG5kak95JEA3iRdlZi2qgwZgY5HCG6JjycsedSt+YlzGRe80BsoegMc11wvV/cJOEInuHJh
	JDZe4lvL8SXUJd1rmvIcm37sprtU29dijn2yej4v3
X-Gm-Gg: AZuq6aLKY6uviaCJYYCyen9TA+IFikYP8KToK40RrI3XDIFX8mBrgzeYy26hHnjweuc
	aGVIW3jJpke5ac0eJ4ZWKfkOdozwUT0dBKSG4VeubntFcsKA/Y0L0Eigm+y+W0gu5HZloL2U4yX
	BvsnMbCY/EgFJomOO4XcIeDneqoaK4kwH7sAKNpmymzcQ39ICtidVl1XbDXqOWRWzCPCqvUGhd8
	7JhkXDPG7l+QpwK8CF399dB9SqStwQqisfNklY+COBqNxQw5zJF/UW+XWeLTSL7wcKw1YI=
X-Received: by 2002:a05:622a:15cb:b0:4ec:f6d5:ee46 with SMTP id
 d75a77b69052e-505d22d7693mr56735801cf.78.1769799310745; Fri, 30 Jan 2026
 10:55:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130033827.698841-1-kuba@kernel.org>
In-Reply-To: <20260130033827.698841-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 30 Jan 2026 19:54:59 +0100
X-Gm-Features: AZwV_QgbhWvtqr9ETLsH8j_z1CK4iiFOMmiskyq0Uy4hQm7Iol3qY5ksj5H6xk0
Message-ID: <CANn89i+ak=qy89AW22MzJFoTnqXSehGLy+uCgp24a=5K46mt9Q@mail.gmail.com>
Subject: Re: [PATCH net v2] net: don't touch dev->stats in BPF redirect paths
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, 
	Martin KaFai Lau <martin.lau@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Gal Pressman <gal@nvidia.com>, ast@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, dsahern@gmail.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 4:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Gal reports that BPF redirect increments dev->stats.tx_errors
> on failure. This is not correct, most modern drivers completely
> ignore dev->stats so these drops will be invisible to the user.
> Core code should use the dedicated core stats which are folded
> into device stats in dev_get_stats().
>
> Note that we're switching from tx_errors to tx_dropped.
> Core only has tx_dropped, hence presumably users already expect
> that counter to increment for "stack" Tx issues.

Reviewed-by: Eric Dumazet <edumazet@google.com>
