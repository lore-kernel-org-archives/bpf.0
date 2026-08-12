Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E936CDF8;
	Wed, 12 Aug 2026 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786562415; cv=none; b=U2CsdtUebAlMro+xk/1seXrHzUfLsx5aljn+vuaR2myuCFByW25+j6PeYAsstZxXqZ6m9IIuJppnFn1hfg1V6TpjAmUlDkEV9oJ4T5jaqXyj5UzJHhs4hyjE/lonzxLGME8K2fgsGV2iang8Aiuzdf6RCGgPedZgzUDOkCPcuZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786562415; c=relaxed/simple;
	bh=vFAH7yCZclFABAYPwWIBfUKSn7+itTPvgJG+BaOM3C4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=YB6ZN5Y/tV9jDaF0msuEFuC1CH1yfhfixy+dnkwnZVL2ird625DPr1sLUx9SHB+kQ5UukEZv+5ViCqE57wablsy/dp4QN++9ix1YeKtCggkLdr+dcMncb9rUSxb8WiomMY+M0x1SPOQfRyfNIcqrGSM7kOWzUUtguc94p+FxqXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=km1mLnpt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="km1mLnpt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9E91F000E9;
	Wed, 12 Aug 2026 19:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786562413;
	bh=vFAH7yCZclFABAYPwWIBfUKSn7+itTPvgJG+BaOM3C4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=km1mLnptJlgOMKmKU/dTcTkVXTGy3wYmv7Z0tR21HLmjpWtTUFd8UnUEaI68onVXJ
	 Klk9rlaub8cH4NxqZSo1nl5uWKR3k1J+IhxtPNWB6nWuNTqm27g51/X4VTUz7njeFh
	 0ubwS25B5ia0xx5nf+iVMSJLMevR99Smpa7gzRA8/fAtMvWLezON8wstdW0z1zm3Q0
	 9ILIX7/YzhVwu2XVaWVQlVbpIZR0hjftECzFzq4jk25vTkqs0WTkXXBUq/oLWE955w
	 WjTUIxRlui8e+o3qSsHzf+Z000MSOHXl0gfCsRTWbwE2JDYQPBbOHBKDE4y+1nMDBa
	 EHxJVrI1Vm5Vw==
Date: Wed, 12 Aug 2026 09:20:12 -1000
Message-ID: <bbb4893ffbdcb6996d4ed5e29e72ce1d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Qiurong Fang <fangqiurong@kylinos.cn>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] sched_ext: Gate cid kfuncs behind the SCX struct_ops check
In-Reply-To: <20260812061116.2691443-1-fangqiurong@kylinos.cn>
References: <20260812061116.2691443-1-fangqiurong@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hello,

On Wed, Aug 12, 2026 at 02:11:16PM +0800, Qiurong Fang wrote:
> scx_bpf_cid_to_cpu(), scx_bpf_cpu_to_cid() and scx_bpf_cid_topo() live in
> the scx_kfunc_ids_cid set, but scx_kfunc_context_filter() doesn't check
> that set. The filter's first test treats any kfunc outside its known sets
> as non-SCX and allows it, so these three kfuncs can be called from any
> struct_ops program - e.g. a TCP congestion control program.

Applied to sched_ext/for-7.3.

Thanks.

--
tejun
