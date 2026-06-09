Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42093EB107;
	Tue,  9 Jun 2026 21:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042329; cv=none; b=hOpoY6iDbuUaY2MG1PbuGKjEHHnwGqIwNzzadh/EcILNSeZ2sfIXZ1Q9WULOMYtZ7cmRqRicXzJ4C20fgcwPTW0+giqbwYcalgq92sdkN5q2HEa6pvpztJhCzN7ycH/in0FrS9jTskXNhq1Mzf9wK7Fm5x/lJ+4INuEZ0LqC/E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042329; c=relaxed/simple;
	bh=uYgbcY09GqZtU3jLp2xVFHwFduSa+bi462BtQuxERkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYY9WAJf7+6vb1mwcnJ2Zk8MuYsQrLJMtz0dPtDaYlZ6A/Vu0mUpyPH49G8OpMWqBhd+fjnIAsiYIY4v/o2SqHFJeDDj1uqYymmsj/ISXSwTO3n76QotM47NMahg+8Z8Kw46CNUEHm5MA88zFTrM/0jTYXj+A/VyforGeO1DPCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diWE4W+L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diWE4W+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598661F00893;
	Tue,  9 Jun 2026 21:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781042326;
	bh=79L0Owc0rw+517WX6RX3SV/gc6w/+G6+e4h3Uz7/jbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=diWE4W+LxUCuXT00sq+lPGr79NF3C4wI5JoJtL4NpLZqnER8f1g6AH7VYqJ8eKiwV
	 NJmvRKglJVQ4ncyd5L38EMkvd/sw9qTahaOHRhNHyM8bbucO6mWkigNab2p4bdmoUO
	 QrYwjrN7zbmmKAmFvprO87g7VX7vAPaqiNPabk2FILqXingayYGGRzvYiK7TE/QH1L
	 8ZaHBD0F9kwzBXAXCdyfWKmOOa/7aMqGW3Zii4hVysyM6U2G05wTwb0En29+2BswTU
	 WHYxY5hVoQ01Hm7r8/qCrCpfjpvlmhRWDrJ2/wntyWkG/VdZnWz3SwPtV4BCYhW93S
	 dBV/YTzeDEkEw==
Date: Tue, 9 Jun 2026 14:58:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca
 <sd@queasysnail.net>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>, Alexei
 Starovoitov <ast@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tls: fix use-after-free in tls_sw_sendmsg() cork
 error path
Message-ID: <20260609145845.2ce5517c@kernel.org>
In-Reply-To: <20260605214802.1647008-1-rhkrqnwk98@gmail.com>
References: <20260605214802.1647008-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jun 2026 21:48:00 +0000 Sechang Lim wrote:
> Subject: [PATCH net] tls: fix use-after-free in tls_sw_sendmsg() cork error path

This patch has already been proposed, it's not enough and there's no
clear path to fixing sockmap + TLS so it will likely get de-featured
soon..
-- 
pw-bot: reject
