Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659808;
	b=Lh+qc02Jk3uhRruhWvtrho7RvdsQVE5Vx9Tj4kr4oDZviF9NH0c06BKGTKPUbq3nwgTh
	 UR0UqGPZWqtNi44MscGHqIwoZaTeSxx2RB1PgsdUsqByPi4bY0bFNnOjL1m59vd2Wii8g
	 mhN5xgJz+jxrz9TJjHjbNSC3lMpPp+3ktjxF3mXJTooDEKVD08CrUTf9DvPBm8gvM4p85
	 LN32sJtucCfMS4DB6I+BxYPdzeisVNPyc1iqe6FRf9be9KOfBHlVIvaxgtyYL2W/s68Tu
	 +Q6O8hafmJVXtrr4qCsDHV8MdYbybS+MQHyHZEyrjr9ki4E+bUzklXQIyl2W+xQsHKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=m17Yu1B2jUQI4DGSiMT/xm8Y8MYEBVuckcVdOzXURWs=;
	b=lZi8tNf/D0AKcRpkPhV71xpLqVdaNkc+pv63MsGlG18DHYjMSOdeUb6nbztIzQJPxEie
	 ys4O9KA86AJRoAaSOHZbXzRCjZKbCUem2XO54+yg8W/kC0vyfWAqYB8UcPDsjyzL19BlF
	 hd6BD76ey/Q8fRo72SFZhY9UBQfJH0wcvpvAPt8QGdnpNwXUs9UrYMTF9tFS1IFmkDUIT
	 3cx457c15LOrsPUFUGWq7ZfrTo0OSW/+qxDCL1OLKIT4o3CnOCSqbn+m0bV6PhFsoYxkM
	 AUhdL6rvDfhNjuixNFl3XAfiuSGyCS1KCgBO+a2UvIOteqbvJO8vXga3Oj+DXwvMqQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKtmHDzV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED913606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 22:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKtmHDzV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D9D1F00A18;
	Mon,  2 Nov 2026 22:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793659807;
	bh=m17Yu1B2jUQI4DGSiMT/xm8Y8MYEBVuckcVdOzXURWs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HKtmHDzVObrpklhlaRipwaBUVMIOpvrzePzl+FoDF7WC68w2qFEKZmTfxwa1B7jai
	 PMgp2dB/G9JwcS5pKomUBcW11LIgBOCova2rVjYNaEuMmL+UObaFy/ZQU3iW6GOnSu
	 GHLghbtsdts554ml9+3ypDcDF96fsdgNJz0JrXeVuj50ZSJxIAiPPPny29cmxEnx5j
	 NsB+VACZHTmpB++ALExHH53pHgYcjtW8tHHuyDluTzb+HJ+pQNBtO+Bo+I5I9+rnpI
	 FqebxUC7BekRYf89Tn6PqJYrDRzGRyKJizmosBiqUOcqI64OsmvUH8/+mxWZIBBViX
	 WwgUhHrsCKUJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA334380821F;
	Mon,  2 Nov 2026 22:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] libbpf: Fix use-after-free in btf__add_type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179365980656.707305.4291574922121465875.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 22:50:06 +0000
References: <20261102185839.1190122-1-almagui@kernel.org>
In-Reply-To: <20261102185839.1190122-1-almagui@kernel.org>
To: Alan Maguire <almagui@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, bpf@vger.kernel.org, nathan@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  2 Nov 2026 18:58:39 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> For every string btf_rewrite_str() does:
> 
>   off = btf__add_str(p->dst, btf__str_by_offset(p->src, *str_off));
> 
> When the string belongs to the base, the pointer goes into the raw data
> of the base. btf__add_str() looks the string up in the base first,
> btf__find_str() calls btf_ensure_modifiable() on the base, and that
> frees the raw data. Then strset__find_str() reads the freed string.
> 
> [...]

Here is the summary with links:
  - [bpf] libbpf: Fix use-after-free in btf__add_type
    https://git.kernel.org/bpf/bpf/c/9abe2c42ecab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


