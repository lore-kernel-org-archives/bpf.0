Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA094A2E00;
	Thu, 24 Sep 2026 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271194; cv=none; b=Hoxsfdhx4x2PjaQV9TgGevRxZGB3b5Af73NUnkx7rfJXuUfPBonCw2EsP8HCeFQyLViaf8dKIRw78d2oW4HOYLU/2ItVj6dJJkHdR9nEvQhS5896RP9943UgnVmSafSb2eY1YM7hu3TII28PSe/9zQoO24cmMIRSVeHZEKgsaws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271194; c=relaxed/simple;
	bh=obbJKP/A+7IPNb418as8NRAGQ4lw7cpNNtgP+Jlxpvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtRgbHt/GPcMYhZGOKn3CERqe3b7nw6bkXm9nQZja1dxE/eV4KoP8lMjwBZSsYtPgttJVD2ENXa7o8kZx/pTOvmx6YYDCJu7peFoZq4D4hgy7yGOEHJlutkn+4eK+V70nHxCE/qVQknjqb6DW2A5cMwMf6g8Lzb/NzA1/dD4PmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bzdjiYnU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ABkkPgKM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bzdjiYnU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ABkkPgKM"
Date: Thu, 24 Sep 2026 19:33:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790271189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CppBDAJ4f/mYAuFO/9BiWz8GeSlq5uEp3U+JHtkF4No=;
	b=bzdjiYnU422dbBO17UvO3Sy9Mse+Fz4j6qtQga0TvFu3RJe81DDpC6cAtYL+jXoVEHRpWt
	8/uBibsO1Ybx8msaKY6jcjrEZJcsk5l98NoGcNFYBJrCeQ8ES6WWYtvU8rjWif6lRSMYHr
	Mrmec37ubCTiI5qvMErR4SqDtMLmTmdI17+TG+9ey9NuLUT8WVE3fAhtkiJCbaLi3OXcE+
	ICrecUaANatg0rWL27dQzli4+ISAL0quAocBmyQ+wAA5xnSkwE6xGvT3yI5p4yBUZBAv1s
	13Za0sxqlQLJSSir6JxirwK8XQiRFUqZSiV1NcSKH+vpdjULtMAIJ4gXhB5cyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790271189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CppBDAJ4f/mYAuFO/9BiWz8GeSlq5uEp3U+JHtkF4No=;
	b=ABkkPgKMmdnwTQxPHsLI9A1VPdTLc51R5aLbDd5gVKmoy4/d+Whx3AqgWbhmXaMfbq9tTC
	fckMpMaJREdfmwAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: Replace %pK output with 0
Message-ID: <20260924173307.FQgZQfVP@linutronix.de>
References: <20260924153153.tlErkAb5@linutronix.de>
 <DLNO7GO4QMNE.23673O3BC9B7@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DLNO7GO4QMNE.23673O3BC9B7@gmail.com>

On 2026-09-24 16:00:47 [+0000], Alexei Starovoitov wrote:
> On Thu, Sep 24, 2026 at 05:31 PM Sebastian Andrzej Siewior <bigeasy@linut=
ronix.de> wrote:
> > v2=E2=80=A6v3: https://lore.kernel.org/all/20260918102610.gxA3km8_@linu=
tronix.de/
> >   - correct the subject line
> >   - correct grammar error in the commit description
> >   - Pickup a reviewed-by tag from Emil which was sent for v1
>=20
> v2 was applied to bpf-next two days ago.
> See commit 79dc258c9392 ("selftests/bpf: Replace %pK output with 0").
> The code in v3 is the same. Nothing to apply.

Oh, thank you. I haven't seen a mail from the bot and the patch tracker
said had "changes requested".

Sebastian
