Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792456208;
	b=n7B+Ix3/EJ9abfY+tqf1LwewMeGdzAszSAZFIB99847te0QEvPnZb3bpOYTUCidt+jvI
	 cYhmpXNxmcrtrfkVyV4HRUmiORxJ/Q0nLkVQ7RYLYTSd6cHBYB5HCiJyZy1XdV9ACanoZ
	 Ssh14nvplaNvm7fBoGaKUyKzFi0oMcIjdKgorKUI3GFeLnYa0nofUXY2hUK+XocrGJLM4
	 sMz6LabvVvuMeCnXHBi13eZiKVWdyzVViv+gjiwxMKBju4hrS8X3L6ZKwK0q8e5O+ncmh
	 W5vQDThoVrEncQ7oqDLesAf52h8/J+h8pWYmLADXkv9b3NxhcfP2BtWIIcoJP3f5qXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792456208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=v/itqcaZj20oy9iaG1WD7g6OMfZmjMhyPYVdcy9JOJI=;
	b=4hhHuDxw968MlduUZCH6cliF5COohyXB98y7o9oqatiCCr9hYV+1wvkp7ALHH/+FEnbM
	 4reJNxgeDxZOB/Yje7xAEEe6se7NRTfbe9kfqm0X/IlQqbeuIN+GS75eZ+eaI1tkaPRM9
	 JuRqFpFNxT2I34jSxVPo1kpeJrgqPxGBCdB53NZu0rZg7YHsmd8n2xeFOwGnUXTSofpse
	 HppjCCivTQb5FIzeQrepYBF6GkF6/n+ozeLuIfJt5Fc6KbiSkkGIbCH1mRoo1L2xczRU0
	 lWbviSXkioUHzRr+5sxscJCOcDS0zoJ84f6CuTFTF0Sib16rsZhVIY1YgzvtCfXXaHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NTF+2Iyg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1CE606A31E;
	Tue, 20 Oct 2026 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NTF+2Iyg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D2C1F000C5;
	Tue, 20 Oct 2026 00:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792456207;
	bh=v/itqcaZj20oy9iaG1WD7g6OMfZmjMhyPYVdcy9JOJI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NTF+2IygV4JP9HdUSlIVuoCE51dx9rtYvrVTnPGXGGgTgY6nMEgrbuzF4Ha0FPsHK
	 2dNntfyCmX4Bq0dZIXSTViELGb6Dw8PNnDJrAyzwgn7D6AD6BuPz4Ddw89zsWWYTLx
	 gpA8TSPxKU2HNjjt4MXdQuRp3NRh5mbfmI5Pl7V9ceZDu4Fa9WO0EH7DeaNYqyR/YW
	 V/fiLXeBfYh36QUhCaTmhgCT/F45q+XlrA5NkBgIjXYj8qJAeIBNVFZ68c0iMJQWXd
	 rVANTuI2m1fPkoKqXwTP8XgxsE1lXwBLeQ6O9WS6eWlGAnqEoW0HsAiXIZvw565fTl
	 tEKCNdYK4QHDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772FD3924A6F;
	Tue, 20 Oct 2026 00:30:07 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v2] bpf: Annotate data races on bpf_lru_node type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179245620614.3402121.11443505330541884495.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 00:30:06 +0000
References: <20261019-fix-lru-node-type-kcsan-v2-1-c10a410b3565@gmail.com>
In-Reply-To: <20261019-fix-lru-node-type-kcsan-v2-1-c10a410b3565@gmail.com>
To: Nicholas Velten <nicholasfvelten@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+1ea4f564bf6f1f3d1dc4@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 19 Oct 2026 14:38:20 -0300 you wrote:
> From: Nicholas Velten <nicholasfvelten@gmail.com>
> 
> KCSAN reports a data race on bpf_lru_node::type between the LRU list
> rotation and the free path of the common LRU:
> 
>   BUG: KCSAN: data-race in __bpf_lru_list_rotate / bpf_lru_push_free
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Annotate data races on bpf_lru_node type
    https://git.kernel.org/bpf/bpf-next/c/f25f6319e248

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


