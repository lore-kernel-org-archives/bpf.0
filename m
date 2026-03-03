Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1061D4949FD;
	Tue,  3 Mar 2026 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772553708; cv=none; b=SsBKtixJs5BKVunOyPfhd7+WSx79lKg+KRpIrMKt3Lm4vwMMBUXEnXv/CLPj3WJKwo59I84pcKhViMeS9ui9Nw0B3rAIyzpkiACCceEyLVDSMDugJ7L2cyq/kYwwmgcw4bDpXCipKH4IsvxgNreJl7P7zgqu21AA7REd/+J+kzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772553708; c=relaxed/simple;
	bh=gZkQlr5YEVXuW9a0G2wQiLAsUpIgl/yFyoQA91g2dZc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZE1FnFZRKeHRpjJKLaVv+e56T+1I5Dfap175c9AZqsQHtwvBuUU/vz+OI47VkMaGdfpe3RjlIrb93sraN3ACt+4RJc+1fa9sG3i3UK6zAw6/jIA4KmQLA89gJdd0SjTGG+tgVgRU6byYpKeiFC4GAzC15XQVnYArR4vMW6VIWkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shZZJlfE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shZZJlfE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41125C116C6;
	Tue,  3 Mar 2026 16:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772553707;
	bh=gZkQlr5YEVXuW9a0G2wQiLAsUpIgl/yFyoQA91g2dZc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=shZZJlfEb7bNjg6xWR+8o+dCaJm3SfdmOzxgXop+HrvU/BKRUQz1MMFjHJZISiZlX
	 jf4xlOZvvEwT/0FEELuaokgm/d6Er3BPMjweUZXXVEorQBgKv0hLFl6fkEgFzSZkue
	 5knKIzrfFkDQ9Pvi5Vv0UyNCT5qIjqYVBIDQ+/GCIGujV2IM/v/lAWoYfJtyvEwl1F
	 V+kMdJ9Xvjxi8Uf0kp23EF2ecqT2Di6prZXgjgRC8Dp3hwu2EI6pXHo0ojWPSzgNFJ
	 h1vtO6VQcZBt7XOTZGnTcJZt9nW7E74kYbkTfvP4Oz+O2jlgNwlncnhgxdvlabi5z1
	 29A50pbnnD36g==
Content-Type: multipart/mixed; boundary="===============0027368851576621044=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <47fbcb9aa941b07054bfef30b802d488688fafdf6df889e78b38313a614b98c1@mail.kernel.org>
In-Reply-To: <20260303150639.85007-4-leon.hwang@linux.dev>
References: <20260303150639.85007-4-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Disallow !kprobe_write_ctx progs tail-calling kprobe_write_ctx progs
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,yangfeng@kylinos.cn,leon.hwang@linux.dev,menglong8.dong@gmail.com,puranjay@kernel.org,bjorn@kernel.org,pulehui@huawei.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,netdev@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  3 Mar 2026 16:01:47 +0000 (UTC)

--===============0027368851576621044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> +	switch (match) {
> +	case BPF_MAP_OWNER_MATCH_FOR_INIT:
> +		if (owner->kprobe_write_ctx != aux->kprobe_write_ctx)
> +			return false;
> +		break;
> +
> +	case BPF_MAP_OWNER_MATCH_FOR_UPDATE:
> +		if (!owner->kprobe_write_ctx && aux->kprobe_write_ctx)
> +			return false;
> +		break;
> +	}

In the v1 review, Alexei Starovoitov asked for strict conformance
both ways rather than one-directional validation:

    "Don't be fancy. Require strict conformance both ways
    in *all* patches."

https://lore.kernel.org/bpf/CAADnVQ+-V0-1i8_+CYpK7G0CnV-2n8e9Szv43yM3Az197eL_0A@mail.gmail.com/

The BPF_MAP_OWNER_MATCH_FOR_UPDATE case still uses one-directional
matching, rejecting only !owner->kprobe_write_ctx && aux->kprobe_write_ctx
but allowing the reverse.  Was this an intentional design choice, and
if so, should the changelog note the disagreement?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22630000544
--===============0027368851576621044==--
