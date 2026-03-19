Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1548D21423C
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 03:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773890427; cv=pass; b=d9T/KQ6IEIqSUHdhf5Szg6wFwygnweSCUmmRebGX1jK5j0usmA81EBgGsJLl+MWcq3qk10h2RfSK5VkAGZ4JBbKkguN9pQplSNWTdszmzsZ9ZrwFv9bhxcg658S2wJCZvL3y+ppvl/xb55qyFWTpO+j95fX9yA9s3yPRdkjTzHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773890427; c=relaxed/simple;
	bh=eVJLvT+5ephmWR1V78qznZwja6HuJ8EckS1O1Y5N/4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILYGIdko1XrEJZ6aNYHy62+7dmldbi/DCyhGC2rRnF2OguMI3cYnLedk/EIYxHdMplv8LLxxygtCD+YqLqtBM4o2luWY6yqIAY+7hRaYBb+940JLdrh77HFPQfrcK6mUwU6GqSnPsjyykkMsFE1Qn5d9dye4ajnKG6IPHZgvfa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnInCLV5; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnInCLV5"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b4121c40aso277448f8f.0
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 20:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773890424; cv=none;
        d=google.com; s=arc-20240605;
        b=FNO4RfkL7ZkKmvu8XgYbKd656wAp4Dbj9ASkmnJWlw5x67BKeWjAN0TVTXnu43Y6Zb
         KqQuPH+qZImPyvGASvnhJK9qtXCobpISMMvsS8Ab6Qs0NYRpXFS6bYNRofNlbuwSD0d6
         oh2Fe5w5ZJVOrFQJ1MaIm16uOusebjkgCOps18EqKx3RTO6jUWR9FVZzrNDgeadi438f
         y/rEomWu13/QHREbwJcGVvx6/M3TtsLa91P1u1m0Fp0HIZjCfcuAlByKljuxDobhRSqZ
         XsYowAu3SFXdWwtgbm9FTcPLjiw+HEvSnQTzgyj7PFUhKbEyJhSPPzFD0b7PvYCiNHBF
         19uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eVJLvT+5ephmWR1V78qznZwja6HuJ8EckS1O1Y5N/4s=;
        fh=XBN21XxFXC2zFp1NGEbBkDEg8ifa6PEH9nk39ktThus=;
        b=BH8I1nZhijsjYQ9uW1Cy+S7/IsvE4s++/QaAgypVGn5P64/8IlBvq9q7yJw+MbelE7
         A0oQFKgSNZIYHmjY7fCltJbFYkgRzYcetc3SROg37CKQ3zpEHJM42rNTlP+fX2y+pms2
         8MVIfMxEtCUqPAVQukTI63W4aR5ntitLkezEDFzE+MbKOo+s1p2EbXc/iKuTQebrCa4J
         SUB/MKEqvaeMUIHcQuh+Vkd/CUWx45zJJJE46xWRza+YCxSHNccj47UcWx6vwRvKWDe9
         22vUc1oywuXPfKi5Mg7DhETA6iZjCBwYNq79Ta+fQt+/lQG6hQuWh4+DY9IeRzpX6aPW
         egbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773890424; x=1774495224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVJLvT+5ephmWR1V78qznZwja6HuJ8EckS1O1Y5N/4s=;
        b=HnInCLV5rwiH+iXHD2kgwRwftlvj1JhN4FzX471a9FeOTMiEqPun4v7i2Z1nu5Thmq
         0V+6ABFjEcOOn02ALTrEcSwPUKa5y+LiIeAC6x1epaHY6VhnmP1YbfTwt3PHbXqOoWAo
         zHUdoprM02TxlkCavKk3nqj93c7uKgowd2n7krtcfHrTI3mgpVcCuCjBkbKnK2AdQw+O
         Sd/Jsqcdnfvt3HnldR5MSBeJ17dcKKw2qV7k/qiw9OQY+71UnUB5wv8CPDnS5tJsJli+
         D7S5s43GT6qC13dVa4LAaj7267ZmqQ5HH9ehsdx9CUQxjVvJ8QQ1LxHBurtRS/ac4kwX
         X50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773890424; x=1774495224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eVJLvT+5ephmWR1V78qznZwja6HuJ8EckS1O1Y5N/4s=;
        b=QQHGIpmYNzu4co4HxqnQsLdR54mq0IErtwOIs154/JOK9Js9D9rjHjrp5+BTwUWbzT
         D/wujcOFk6HHU9y7wACsfJrX9Fyuo+rFT9uZVKUHAXzKykt43FvKvMiNQN3u5ICsIiVS
         PMvox0iCBQYfIUhYVGqvWmshuVUCCXsZhoJgM5Fm3OGQUFHXWjpZNt5OqYJ2cl6xkfJr
         Nz4J57Gvu6S6LH3WEs7UnEDnbnWkzglddeXeyiexFNKnDXZVB14BtShJyaAApNwW5hAQ
         U3ZW9kmlwPQhq9e9huBiZWqI9jnUEN30GaOrnYsrIBCnAgloqO8GIBug5kE2ihy8zG7q
         wOAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj3zq0hHw3r/dFS5lDpBnpZvXjLZl9A3E65/ChplQCSnDmYHbGecw7oFO1xWsXtpuSxr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV5r2d+j1qqucXeKckFZHd5FZS+5nDEC03z+/PYvvGbyIKR29i
	xICwryzQmYfIotnKBEqgQqdpW66KVl8Ns/h+UJJI2T0FQPqHQhZv+L6XTv86dII3+uNLp4Pxv0b
	bT43admDU/yGrqNuIgoXU/eu5PcXLV0Y=
X-Gm-Gg: ATEYQzxI8oErg380uOpw1Zv4KJXoGmQGfhG8Jrn5lwfUmNkhqp1yrP8rgbHBJWO+zvu
	JmM1gGzR5Y38cYbM+uXn6ymH2C+MaJg9+Z6XzYMvwZZn1KA7pyIdCIQTRnICFyB3FgUsFXoxf40
	5CtHesLsNGYf85BLjpF2xjhQr0kxuPZiTx0TIY+yh40VU1gcWkT7Fm2ExhGyED8EkQjr6eIGgDl
	G4EpXlsxvSUDoEwVWsdbYg+MFZU1iqqlq7+UvzoOkY9E4+nLTIE+XfjhbVe2dyq8OJD/rrVGjud
	MKx2/wCtJwKan4Br5riSitOMDkh7uPlCFHbxL5wveSS3z0At5FvJfQiI6VQIeNc65zW+VmoEY+d
	PpG5qxCDRWyxlknG5IZOPXUIP7w==
X-Received: by 2002:adf:ee0a:0:b0:43b:54c9:7d21 with SMTP id
 ffacd0b85a97d-43b54c98692mr5708727f8f.37.1773890424196; Wed, 18 Mar 2026
 20:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319031227.330505-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260319031227.330505-1-sun.jian.kdev@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Mar 2026 20:20:13 -0700
X-Gm-Features: AaiRm504ZciZxfGF11hAaZLepYZDZjU66z9V1QF3ra7zGtXmLjPnWzMrrxY0dzY
Message-ID: <CAADnVQJ9HZTHKCzwmqUwhePbCQ5qPQrSd=yejUS17eHbMm0fuQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: trampoline_count: use dedicated
 bpf_testmod target
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Paul Chaignon <paul.chaignon@gmail.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 8:12=E2=80=AFPM Sun Jian <sun.jian.kdev@gmail.com> =
wrote:
>
> trampoline_count fills all trampoline attachment slots for a single
> target function and verifies that one extra attach fails with -E2BIG.

selftests/bpf: trampoline_count:

don't invent new subjects.
Use
selftests/bpf: ...

and explain what it does.
'trampoline_count:' is not a generic prefix.

pw-bot: cr
