Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9951E2E7648;
	Tue, 17 Feb 2026 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367873; cv=none; b=NGRjCFzxSxLsA7l8CSg/aBUtqsRmGYQP4usU8lma7YMI6XQh1/HVtXU/f2SLiHzvMjDqpMb8CSEYQEJwvdNgamCKHyLnXXfntSNibakyP739Y18AJzMBFlzvaEMsxnM8Pfph7QMZ3pC1beJRYx/0ML+I+xjJVNc2QP43xtGH0Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367873; c=relaxed/simple;
	bh=h9p6QEvCOnQ1bTCxXNQCa4QV3QUVeu0XfstRDDBVvrk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOftmuP/TMN64QeXLuCozPvQV2TFY7xsZiJKLuQNnwRg3/0YLq9X8SOlRVS9iB5o03DSwxaY+e8YSvED3JjiWBFfX5ZoGieis8nZqdfU86cD2lsw9pVdVc64rm/xg3qzdBDcFVkqROIcP9Lqj7lXw6GEXgzUKZAM1lU6e/YhZdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8AouUMc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8AouUMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A41C4CEF7;
	Tue, 17 Feb 2026 22:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771367873;
	bh=h9p6QEvCOnQ1bTCxXNQCa4QV3QUVeu0XfstRDDBVvrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d8AouUMcqBYJM15E/9QUQY52b8wNv8GrJh3p7IZn185B675YhQZFeNy6HRwJicIpM
	 /Q0nevrNbmi3mKiPsW4v6+W2kS5Wn1R+8aFPsuqoY8tA6z/5Ls05t/i9NYFH3OPSuU
	 zUKn+3XUswHEHir3egi+2vH567c8GIrkWWBO/H37ITIc/AEUGqaZ1GLhKkJ9+DaWNO
	 tSN/7dUcdJWa4YZPhS9w3xa7SZr1REO2lxpP+MRqavAF7WxP56hYZTFBhl/vkLRVta
	 BQuVHneh98/thZaYOnc1WAPlLolfO9fQ4buItc7n8nDTauTHTqDsSYpAsal4/hrsP/
	 bBCMJMBxzcgoQ==
Date: Tue, 17 Feb 2026 14:37:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 davem@davemloft.net, sdf@fomichev.me, andrii@kernel.org,
 martin.lau@linux.dev
Subject: Re: [PATCH] bpf: cpumap: add missing XDP_ABORTED handling in xdp
 prog runner
Message-ID: <20260217143751.2e7bdefc@kernel.org>
In-Reply-To: <20260216150601.9454-1-anandkrshawheritage@gmail.com>
References: <20260216150601.9454-1-anandkrshawheritage@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Feb 2026 20:36:01 +0530 Anand Kumar Shaw wrote:
>  		default:
>  			bpf_warn_invalid_xdp_action(NULL, rcpu->prog, act);
>  			fallthrough;
> +		case XDP_ABORTED:
> +			trace_xdp_exception(xdpf->dev_rx, rcpu->prog, act);
> +			fallthrough;

Why are you populating netdev with xdpf->dev_rx when the
bpf_warn_invalid_xdp_action() above did not? Either both or neither should?
