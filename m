Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0684386C36;
	Wed,  4 Mar 2026 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772620222; cv=none; b=nBj+vAgNePU5fuhGMdZJGW+dUfHwlh5MKbipqTDQ4puPMeV2QP6bKsKJfJZVeU4KutvNiKiYQWo3JsDKg4aVveMPL1d/XbL68rY/6VrrJBF4gh60/836bC4LC4YDE77MRja8NEYY1q+x6tcsYlJp3qrGvdHpXh7ARkMQxDc79wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772620222; c=relaxed/simple;
	bh=v07LSu7NC2ihIaIjgjrW/HclXgPkr3799pII9Mm0lsU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=e8mL/CkTGUXQLOqXCtfn/lVqiN6ucEDY0+faMPwmCzA+Y5DEcAjJ0LNzEEhjsdG5Vor2QG0fzj1ClkptvJjot1b8o6NiYjFqK1Jzxu3Tvf92o7xA/IdOfqsNdmyMYJqcRvYJCTx3Ho64jlbfx60LO8pL+942BRbrOQiYfigWSPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sxbwk/tb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sxbwk/tb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4088BC19423;
	Wed,  4 Mar 2026 10:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772620221;
	bh=v07LSu7NC2ihIaIjgjrW/HclXgPkr3799pII9Mm0lsU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Sxbwk/tbUITeCZdXLJSGJz3Ywvs4ebG5eiXQ3ZiteaOQqtrg7jzQ7Xmjsd3qgv9WS
	 vKqRCXxrdwU8iuuw0suEwAgOPJ6rNDEdmnFlHCeyJ0LXkjpvfYv5uYF5P6Sw0K4rKU
	 gVH0d3sjk389856+MqfWeJ6aGjxSv7plvIeM0urC5SGn+HkTWQy1yyknupqkmpyPc+
	 +MEIdBefvQLPUpDkNQ3LRaxHh8mkJnkoAK8exyK1YK4D1EhS7g3jGLoH2/7zPL6s+O
	 R7qLvtCmeL8/mumHe38rmLMBxnn2s4uGhjE/tjp4NiWVhYWRl/3ZR1cJ01UTPnWCRo
	 j5+yAxn82nKGA==
Content-Type: multipart/mixed; boundary="===============2676291065332725965=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c0c51f1bfcaba622755b8b6c874180e0daf3ca307e1991ea892ca5f07e705f4c@mail.kernel.org>
In-Reply-To: <20260304094429.168521-2-yangfeng59949@163.com>
References: <20260304094429.168521-2-yangfeng59949@163.com>
Subject: Re: [PATCH v10 bpf-next 1/2] bpf: test_run: Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
From: bot+bpf-ci@kernel.org
To: yangfeng59949@163.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,posk@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com
Cc: bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,yangfeng59949@163.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Mar 2026 10:30:21 +0000 (UTC)

--===============2676291065332725965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 178c4738e63b..565fe8cbcdc9 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1156,6 +1156,20 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,

[ ... ]

> +		} else {
> +			/* For CONFIG_IPV6=n, ipv6_bpf_stub is NULL */
> +			pr_warn_once("Please test this program with the IPv6 module enabled\n");

Martin KaFai Lau's v9 review suggested pr_err_once here instead of
pr_warn_once.  Since the function also returns -EOPNOTSUPP, should this
use pr_err_once to match the error severity?

https://lore.kernel.org/bpf/0e88a3ea-9424-40eb-96ea-2d3d1cccac7d@linux.dev/

> +			ret = -EOPNOTSUPP;
> +			goto out;
> +		}
> +	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22664502452
--===============2676291065332725965==--
