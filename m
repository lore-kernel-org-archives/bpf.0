Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3941049362B
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787479236; cv=none; b=oyydBVQl6a8m8cHYx4Mx09yMzvt5G80hPJMRSG5B0hHIHedcsHmbDSD1vMLAZmeXO4gpIrNK+1ChPuwP4vqVAXTipcFF2tmsjiaHzoTYpjlOUMoj0WQ2OSH4R+EPQv3kc60nyB7HB9vhY0J7p9UbWlUwvwQy+Z680JoMSgrtQKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787479236; c=relaxed/simple;
	bh=5K8MgwVtgdo0Sj14U8Whu9SZw1tAdmnuZlcIQcnukE4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Vhd9qjgGWNXczSE22cj+y0MhVntjtMqTte8qWD7OWN4g9k63oSHqGxVOvV001ycGxPhur4yQ8nrqp8UmJLszwUZ96EjIa34DXIgWPZRSmtM4LMjlOKmHHdM4FMn+0cXSYr7lEwQ8mzEwAtYYnZpdmNx7p40a4L8oEMjeiZMrGpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npeco7VV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npeco7VV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B0F1F00A3A;
	Sun, 23 Aug 2026 10:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787479234;
	bh=5K8MgwVtgdo0Sj14U8Whu9SZw1tAdmnuZlcIQcnukE4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=npeco7VVAldg7NJpzuoN9XXdT/R8Xmw+o6IO6hu6R3QYrqaWIbOkMMA3zDfvw4kAN
	 wfs+P6Tv9UPs2YkW/2iedX3/GxW8ymO7MtGNK8fjE6LTTT/n18ZTdoA5XqKOe8cjOx
	 rTsTU/V4CYgj8krlcDz3iQfSLEfqWutdTZMudfSITuC0exDLwZvPEbwBzBnth9zUVY
	 +Wh2posOl0qJ9N75mvjEiDZG6D+VmM0ihsB4DqFcTepcZoTReJ0QwnxDNPG6Wkx4b2
	 y8CHkeRZqUV710o43L9F57hE7137vvr842hlmwsoXeMiZllasytIVLkcw8tsOCN2mE
	 eIj46EkrvXclw==
Content-Type: multipart/mixed; boundary="===============6384407726067875673=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a0b91ec136b7425738019b06e21ba49df0e0462a8b43c0ee489cee990e395dcc@mail.kernel.org>
In-Reply-To: <20260823092057.82200-1-tw19881113@gmail.com>
References: <20260823092057.82200-1-tw19881113@gmail.com>
Subject: Re: [PATCH] libbpf: Ignore exception frame section
From: bot+bpf-ci@kernel.org
To: tw19881113@gmail.com,bpf@vger.kernel.org
Cc: tw19881113@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 23 Aug 2026 10:00:34 +0000 (UTC)

--===============6384407726067875673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Ignore exception frame section
>
> Exception handing should not be the interest yet, let's skip it.
> BTW, I found this when building BPF with Zig compiler[1].
>
> [1]: https://github.com/tw4452852/bb
>
> Signed-off-by: Tw <tw19881113@gmail.com>
> Change-Id: I5ee6c05bd8a684261c53effe9c95d9f26a6a6964

This isn't a bug, but should 'Exception handing' be corrected to
'Exception handling' in the first line of the commit message?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32631556401
--===============6384407726067875673==--
