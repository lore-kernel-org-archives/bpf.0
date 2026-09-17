Received: from mail-pz2-f7.google.com (mail-pz2-f7.google.com [74.125.228.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0865372E2
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789666340; cv=none; b=Uy3pZ0FQ4rLKxMZRv3fW+7/d/iYSxpeq2iWty8Py7TghgmIkm7UxeHUszo2EA9vYd45KUi1E76mqK1PLpZh/yCa0pFNwVCATFf4I0XYVfwTHDzapnJsv8uPf7611xPIcktJ4rlJfzl5j97NZzlO0TbiBihe236F5/iMZyNMiwDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789666340; c=relaxed/simple;
	bh=AUxsR9+Q30j7A8KTn2nOOxy8tNIwmuhqtluI/wLUA40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0hcGabheMM5U/iyZ6a1tnbqujRIn14Ghhz/aVkjBFu3LXd7O/Vyw7r31PzUaN9tNX3zdqFLI4FQ6MNNRb52g1/S1bTEb4GNTh7yJM9l42i7tmR4UMxvFuX+HRtY+iwO4NWSZN5qTpKIDM6SqHLE/Kutx0yZS4+KP92zZtUNiKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVTxc9QB; arc=none smtp.client-ip=74.125.228.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVTxc9QB"
Received: by mail-pz2-f7.google.com with SMTP id 41be03b00d2f7-cc1ddb3ba3eso631342a12.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789666338; x=1790271138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tmSH5NHQUw7amQNSN6+eO65bUS5munkLsHOJPnnYVio=;
        b=eVTxc9QBFvzIBl1WVawBp1hTceELY3djkOUpapBgbtgPZ79XXg8KD+Hi3OZNmlvbJS
         zNsf3Pb9p+AfpGOpr6uouP0B7XIUqiElT7GKsbSM2uO67uFFvkbCJvojEr/7IHZqAiyY
         gm6Do/ar2M7bZKYXNVB41soyHo+0ITpoXaC7nszymrOHf+uHWNCBjsyMhrZmrxDY+7eZ
         rmSe8znEJSIhH5N1tj6hWUAP3Dg309a/DiTkOxAyjHIK30tSwYEJ74Xv8zYduFzeW90L
         VzvmSP34mpwbxGerQkJbR/OMgyD04ATluZXA/z1d5AjiWj5pqxEgx9hKO1rNxlB1A6Xo
         Tryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789666338; x=1790271138;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tmSH5NHQUw7amQNSN6+eO65bUS5munkLsHOJPnnYVio=;
        b=NCARNPKeuGU9K84Qr+CKXZb+tlt+2BXqaSxE1mEgWc8Gl1sXyiGrxIy129cE2fL0pQ
         XOm06P1Z3pqpeyb4mRfoQV0VQgHzMgQao7ub54yTnWZNgoQNUEmJ9ESRf/p1H0OiWg+C
         RlJ29ZWfyDACM3JV7eFfkfo5/A1bmZXLg2gu2Hihmn99TDjJYlzUIgW6sOF5sR4wD6a+
         LsPWs9X6jzAneYsps9L7tEQ05r5iUGDZd6U9ml+4zBBNB7HAZ03jINGJyWwjOV5AZoCV
         rixXNtzvMR+0mYplCSBmeh8hzk1Zn6zfnGDGjkIb3Kto8TyhKc1JHJCH9WSq5rFiTexi
         aaZg==
X-Forwarded-Encrypted: i=1; AKwUvBzRB4UqBm0LUXTueaiwKQUQvnJluJ4iJBZ0gdV8392HAM/RIDF3Fz9zLUT7Hydal6ELYQk=@vger.kernel.org
X-Gm-Message-State: AFuF++nnQGuTsEA31Mdo18WZewVJJeofyMsXC75r/GpM42QEFK7nmNNZ
	yRYoZN0o622S0LnW+C6q0mnFyP1Rv7ILsI1KhOZH190dVm3EB65URqS6
X-Gm-Gg: AYBFou1gp76UpwP+nVv07a1NNqjFLFDWUn+vTR1vOfU3LUJZA9/5DKpiYdz11RZuSNx
	ENHC/OYMpNPhS3dx8Ap4Oh8skxm/lDpqg0ivPBAWDnrX7JKC/IVdvT5ltImhynpLYOUZaPfCwut
	HU30iUFX72RL8PlMyEiAa7fbojrl8B53tABQ+et2ucaJ9VcwjVlroNSr3FMeX4PD9Gu5nywXSVg
	x+7yeO2gzm99OtHUyw5T2rwsGZR1xDz3AJ96jsA2CmIdNze1qHsgzKXA33zFJe+0A4LRu735yzk
	GA2jAHHooJDFwBsQuE2OCWYTD3LKAEwYOTyr+sK3NBTwtKVBuS0a6W4JQxcAoGso8VQs0lBuDAl
	N5NIRiZwQZIgTsGDbHh17yFOHMskOkhhAqjUh6t6EqTCPLvnRBnXH25+qfg4SXL5XPq7scQMNZU
	4/NHtFBVwSdGgDeR2v4nYAGsTPP8Woa+88fYtoAM88Cm3L59NB+y7UvsXP7SKx3tId
X-Received: by 2002:a05:6a00:66da:b0:873:1d5b:278c with SMTP id d2e1a72fcca58-8731d5b421fmr8838431b3a.23.1789666337605;
        Thu, 17 Sep 2026 10:32:17 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-872025db965sm3240288b3a.59.2026.09.17.10.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:32:17 -0700 (PDT)
Date: Thu, 17 Sep 2026 10:32:10 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: bestswngs@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, ihor.solodrai@linux.dev, davem@davemloft.net, kuba@kernel.org, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, xmei5@asu.edu, 
	stable@vger.kernel.org, co+ac0a8c41de69121d@bugs.sh
Subject: Re: [PATCH bpf] bpf: reject dev-bound-only programs on other devices
Message-ID: <aqwjutKiee-W4k1T@devvm7509.cco0.facebook.com>
References: <20260917161335.1020405-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917161335.1020405-2-bestswngs@gmail.com>

On 09/18, bestswngs@gmail.com wrote:
> From: Weiming Shi <bestswngs@gmail.com>
> 
> __bpf_offload_dev_match() falls back to comparing offdev pointers after an
> exact netdev mismatch.  Bound-only programs normally have NULL offdevs, so
> unrelated netdevs compare equal; one loaded on an offload-registered netdev
> can instead inherit a real offdev and match a sibling port.  An attacker
> can use bpf(BPF_LINK_CREATE) with a different target ifindex to run
> metadata kfuncs specialized for the bound driver on the target driver's
> xdp_buff.  Running a veth-bound program on tun reads beyond tun's bare
> stack xdp_buff as a veth_xdp_buff.
> 
>   Oops: general protection fault, probably for non-canonical address
>   KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
>   RIP: 0010:veth_xdp_rx_timestamp (drivers/net/veth.c:1673)
>   Call Trace:
>    ...
>    tun_build_skb (drivers/net/tun.c:1739)
>    tun_get_user (drivers/net/tun.c:1856)
>    tun_chr_write_iter (drivers/net/tun.c:2091)
>    vfs_write (fs/read_write.c:595 fs/read_write.c:687)
>    ksys_write (fs/read_write.c:739)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:84)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>   Kernel panic - not syncing: Fatal exception in interrupt
> 
> Restrict non-offloaded programs to exact netdev matches and retain the
> shared-offdev fallback only for genuinely offloaded multi-port programs.

Any chance you can also add a testcase for this under
tools/testing/selftests/net/bpf_offload.py?

> Cc: stable@vger.kernel.org
> Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
> Reported-by: <co+ac0a8c41de69121d@bugs.sh>
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  kernel/bpf/offload.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> index 0d6f55695..8c91d00d4 100644
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@ -698,11 +698,14 @@ static bool __bpf_offload_dev_match(struct bpf_prog *prog,
>  		return false;
>  	if (offload->netdev == netdev)
>  		return true;
> +	if (!bpf_prog_is_offloaded(prog->aux))
> +		return false;
>  
>  	ondev1 = bpf_offload_find_netdev(offload->netdev);
>  	ondev2 = bpf_offload_find_netdev(netdev);

[..]
 
> -	return ondev1 && ondev2 && ondev1->offdev == ondev2->offdev;
> +	return ondev1 && ondev2 && ondev1->offdev &&
> +	       ondev1->offdev == ondev2->offdev;
>  }
>  
>  bool bpf_offload_dev_match(struct bpf_prog *prog, struct net_device *netdev)

Why also have a null check here? Why doing !bpf_prog_is_offloaded above is not
enough?
