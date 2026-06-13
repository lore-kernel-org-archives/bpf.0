Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A19A331222
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 23:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781391975; cv=none; b=P3etqDGS5S2fBrsykV/yxS9l9Om5qd4x539olDiM8fCACjvUe8aipDZvPkm/gkcBcCeYNKmlEGWreSF256SYU6HbSHV609C9f40wkkePuVzbUhS4GlnaOe1Vpuj67sKR0o3dF/tfzxQHCSDb0srIrs3t6PC3XEdwUMY2LdE2/eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781391975; c=relaxed/simple;
	bh=0r3TOzH5HVsVnfCZy8RUkr0w0agKHhQBV0jj9awm5eM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZO4lvZv4r6U1D7dsav5rEDEVkJq7tPbzPlJwpx3tZEKrYN8oOsGflwQNUTEu9r6uxtka7JSVx9ar1z6zv2InoaC+lLKN6w6vSxLdwUYwAYQdAuC8Dql/VlhWPIM4HWzVm4cOuqokn7alABXjlKUl5AYJ6S9STxX6+Edzew9edE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYjIlJBD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYjIlJBD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135AE1F000E9;
	Sat, 13 Jun 2026 23:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781391974;
	bh=0r3TOzH5HVsVnfCZy8RUkr0w0agKHhQBV0jj9awm5eM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FYjIlJBDxSbZKk4+Z/Gmjs6xX8QaZMXn6Sy9CCitrZBDP35iMmYrLN1AXF6RKTW8v
	 t8hTHaRzKxO6JMrLvX8AE5IpdF/lVEORJiKxBwf80UVwTHpVKrvdlcVxBvEv9Bcuy/
	 NfkZU96HYKTXs1KIPh4vWH3Xo2bHumUDXag9MCciS2liiW+YI502HAl2m1Pa80NkBd
	 LggLlIRMWSoXcS8GZ2ZtJo4vsYEoxGe+7DR+fmzztQb1HBP0ooJRdvoOCxRgER5T6l
	 oUmJU2LQ50/AN176qh/7Q5o6Sv2F/AT7Gj/2L0W0PiPG3ZHh0669J/dXcumn8AD0Ma
	 PaVzv3EmHIzyw==
Date: Sat, 13 Jun 2026 16:06:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Stanislav
 Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, Kuniyuki
 Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 0/4] bpf: Support RX/TX HW timestamp proxy.
Message-ID: <20260613160612.5434942c@kernel.org>
In-Reply-To: <20260613224823.2399535-1-kuniyu@google.com>
References: <20260613224823.2399535-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Jun 2026 22:48:04 +0000 Kuniyuki Iwashima wrote:
> We have some hosts where packets come from special hardware
> and are provided directly to userspace, bypassing the kernel
> networking stack.

Nacked-by: Jakub Kicinski <kuba@kernel.org>

Keep playing.
