Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794846736;
	b=Zv95OvxbnezgXgmct4nVybPxKJWWKWYYTK5RKsEoUh7twmmrWhnojE4mj9Z3J9a3q8Ow
	 toim2HgGA3wyCkB4qV42tUVwntaSKzKzGbIZxJHancdeGDd6eoD6nKY4HG75CS/PbF7rB
	 dk5Dexf0/3SNc8n+dkQQj3Iw0r4cOuxd4n9erb9ld2UccRnarjGu51X/aaGfyn/nRoRjt
	 Q1fEmcbdI6v/zmzcpQf6h7YVnjR/MOxrcqIkoaxv97rlP2tF5UqB8yPY9p1eHB66DBBp9
	 XNX+lYWps/V38D9RVa+iJ1QCwqQe+XrOfca+5vFtgUsiRWsjWLCvMcI8Z7X4y1gbm6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794846736;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	b=03qNMI3MmD/2DUVBaRFXhEdZQHQZ/x8kxq5KJXv33Jci8d4gUz0xLzmYIih+xbmvZlkO
	 msz1w3h1k49y/u3m7NSCoOssL6UPaNylSpVqLucqHffrTu+YWcWXMhF3GqZrSAMEiPm+G
	 oUlu5dEkzIP+k5AHiG+efTOFVEWphA3C0PY5geGFoihUWvD80iJ9K4jfeGkhJ5zU0kppW
	 Wenk3fFZJHn4BwYIDfiP5KjEdy2pmXo2ti1da3c88e0HIeVBAS9zR5taGm7dLALB+ziRA
	 wFnII+TkO1RNY45hZQJ5Q1UOuxyE1a7ZKsc8b73WZGeSCyuqT+aY76noB4HhBzhWTew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpmCXKTV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFE7606A322;
	Mon, 16 Nov 2026 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpmCXKTV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E741F000C4;
	Mon, 16 Nov 2026 16:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794846736;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kpmCXKTVb2U/UCmQyM0jyQIiFiyBUtWa/rolPgC27x/6er/TMekcYO/bpqCJpbHjt
	 BkarG5dim3+kqiPiQ0w7t+rinkAI4DkyphgVziWl+F4TCHPgwFCY9tFJUudJ/7JciD
	 8s4zEhkG/2Imevh9Nep7OmbPGl3wITP18uNzVRq3TPIH6noxApXA3CTyhp1ORZtsJp
	 CS36YoGl03ZWuFbI5R9Vd5iQvxebvOphOB+UxHjpQtjKvNvHEdiswiKt0Lff4owoVB
	 c3UjF07b4DVsuGQBFusFmMCTCgzQkljYgQtxhWWvDZLa5MvPRw6pM6m1IsoXsVlQGi
	 yj3uZDrouu1uQ==
From: netdev-bot+sinfo@kernel.org
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, yoong.siang.song@intel.com,
 kerneljasonxing@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com, tianyi.gao@linux.dev,
 Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net] xsk: reject TX checksum requests that overflow
 skb->csum_start
Date: Mon, 16 Nov 2026 16:32:14 +0000
Message-ID: <179484673444.3291.12899618485319674206@kernel.org>
In-Reply-To: <20261116162834.30087-1-tianyi@cloudflare.com>
References: <20261116162834.30087-1-tianyi@cloudflare.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
