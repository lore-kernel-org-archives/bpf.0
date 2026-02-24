Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428C42DA75A
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960125; cv=none; b=NRLBVXd4ZzUvW58Kboq7lrbk+ouiQwFPeutA3XtJLY3YkhpmS8mKIoAlNqMAllGqTwH+mE0LaWzOEfmvyyPZxGsQMKVZqXvPGLkedgO5v5juINWAFBmHzH/GoNYojj8NEyvgu2L2/2yFNbxQ79cneqCekQGXVxW0h55zkx9CrUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960125; c=relaxed/simple;
	bh=SHWRkQnfan5j8r8cgIBRNPktZ78VVvCRqus2NRXzkbI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WciwFdSKhdEdti0jdp2rPg7tzFTS01RNgE55C4aguB4iVVoDmGVB04nUSuN+peWkQrL4SCCLQwJSPqq1QY0ikBtOTd/BFGOivKJFZXMz/0onbdnmBKXvQnUMwpta1sFEcIHMh19MNkeaDezKvXvKqJsYU/XglVNgFTeko/dWzzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9zyyGhg; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9zyyGhg"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-126ea4e9694so892168c88.1
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 11:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771960123; x=1772564923; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SHWRkQnfan5j8r8cgIBRNPktZ78VVvCRqus2NRXzkbI=;
        b=V9zyyGhg/ACIbJDtdEfpgME67KMr3i5FGgEPF0EWNwPoxOOoMopCKLLYDO0DNBlst/
         pY9lyd7g/UoJmY9/Kxw3CcyuA1kQr+kFBDtEVsj2VmBt7WOhDjG8iigo4JePUfIEZX3d
         cDOXJ+djjEs5NcGVbyiDf02SSsOj8FPKtRnezIPK5cRYd450S32E9JAc2vBk1gwT1pYB
         fIwFSsFB/1hHoMUNbU/G0cn9a67pZ7vWgouPjt9EDV0s2d8K/YFA3sJnCLirboI6qmXR
         1vPsr5zqxLWRWYUYTdp7hf9SRoifF9wo94FqPcDeyWDxOM4EhSAS0ak9BP1Bc7qquiBx
         HdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771960123; x=1772564923;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHWRkQnfan5j8r8cgIBRNPktZ78VVvCRqus2NRXzkbI=;
        b=G6etaKOlREVfdOMtrL/NbDrzfcVliZqxDj6k5qRBeyZX1OF0kArLKqwpW0HHJUo4bl
         zS+jnUYaJDA91NhQeAJjnYxjlslGEEotQN0jTvbK2tBY33kejjEm3t+yiGdnT9AGMIII
         7D8S8afc7kaaDQcgQvYteSuOVikf3ePIs7wMQKslvX1stQMpx7ondDR1ioCuDdAISrOL
         kX45/o6nV92iU0NDfA5jdgUv9Fipp30F6++5fUiaAVj8sOl81CJwTmzsoyAC7gNSqv48
         AytnKKTcET/J26GI9SitbJlm16Rz4AIZsLgaj+2oYnQPGKhCL7LghBTkiBap93Q5EKFT
         g5cA==
X-Forwarded-Encrypted: i=1; AJvYcCVfLhD5pxyfbJ7rGi/qjW5vR0rn2QHo0Dx2f5xqbPdE417ALlA6eias36nrdlkr5I+rEps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ7qO3Os/qFgHk/gSsLqZha8t4LrzY3cYYQ/8mae8PLCpwyQP9
	RXDHJk/QF895SQrqIA+CWOqtzTn6Qb5hfgKSgYhm7a3/k86YM+j/BWBk
X-Gm-Gg: AZuq6aL9keQQHm5XCsMGOs1I8AS34G2mVTNKKDeuY69XuR1RVYo0qvDofJANYAB2guI
	yzToYmQozBq+V+COTkoYH0V/Xxz4PE/BwQjSTlpvmN3E30q0oEGAR7+cx3/QOUBIyTftMhv/x2n
	iDBU7xsxUTQTqu6M2aGDc80dYK4Kf4vlYw5i/r+0u6GoSzVZ0RnoAsWj6OQ8hq2mFhAPLmddCrj
	Pycv0JCjd+5iELHpf5fnzgl5e4Uh/XJEuwiNBCvlZlfw/j+0k5Lm++etf/cgT9Wfkx806OKBIdF
	AXQgL/dKJzpYxzNAO9TvRCkY8U0shGjhP+tQdeTByF8J8UK84UGonygX2OTCgC/joKr/TAwXCSc
	xWjvgudRUAF1Tl/UbuZcvBe1Vzd71lAJoUVgJDRokFhjs9c+zSDp484Pphq3d2xBzWwX1KXkuBG
	yzXCXinhNY//SKzEQZM7TMWIb/AlrBGy89b5brij7r0XNdvtUXmTXMGRFmVjabzSRV5OaxsYHYO
	VjNrQ==
X-Received: by 2002:a05:7022:e12:b0:119:e56b:9592 with SMTP id a92af1059eb24-1276ad11005mr4610854c88.23.1771960123326;
        Tue, 24 Feb 2026 11:08:43 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:79f3:c942:f01f:96aa? ([2620:10d:c090:500::1f1f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af102d9sm10334499c88.1.2026.02.24.11.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 11:08:42 -0800 (PST)
Message-ID: <37d63e5e33cc9ba0b7e042b982207de2146d07ad.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Use bpf_program__clone()
 in veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Tue, 24 Feb 2026 11:08:41 -0800
In-Reply-To: <474b3520-f5cf-45b3-be01-d14708cc9a14@gmail.com>
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
	 <20260220-veristat_prepare-v2-2-15bff49022a7@meta.com>
	 <927e23c543aee236c8f9513930ba6f1791bc5933.camel@gmail.com>
	 <474b3520-f5cf-45b3-be01-d14708cc9a14@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-24 at 12:20 +0000, Mykyta Yatsenko wrote:

[...]

> > I run selftests binaries through old and new veristat versions and see
> > some discrepancies. csv files attached.
> > It looks like there are some failures that are now not logged.
> > There is also at-least one success -> failure transition and
> > a bunch of failure -> success transitions.
> > I see no such differences for sched_ext programs.
> > Is this an expected behavior?
> yes, the regressions are explained in the cover letter:
> """
> Known regression:
> - Program-containing maps (PROG_ARRAY, DEVMAP, CPUMAP) track
> owner program type. Programs with incompatible attributes
> loaded against a shared map will be rejected. This is
> expected kernel behavior.
> """
> in the previous version of this series, there were no regressions,
> but to achieve that we had to be a little bit creative with maps
> loading, have a look:
> https://lore.kernel.org/all/20260212-veristat_prepare-v1-1-c351023fb0db@m=
eta.com/
> clone_prog_maps()
>=20
> The improvements are explained in the sibling thread with Alexei
> (again because of PROG_ARRAY type of maps)

Are you sure that's what happens?
Looking at 'failure -> N/A' transitions, it appears that this is
caused by the early exit from process_obj() if bpf_object__prepare() fails.
Previously each program in the object failing the __prepare() was
reported as 'failed', now these are skipped entirely.
I think it would be nice to have an additional logic in process_obj()
marking programs as failed if __prepare() fails.
