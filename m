Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429333CD8A3;
	Wed,  4 Mar 2026 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772646428; cv=none; b=HWQlqavgkW9odR/PfdX408XlPQpafg4BjQBKLiJC2wc0pdFrdogteE+FRvXEYJddS0H+LHvi5KwdYGN/hPqJoZUydPWSiFUfHbrgkDbF+SvKqHp8UjQo+3bK+hx/7NRBrXFAXmVRg09Agwp/u46W1FbkN0jWvl9WxQbTiy4n/Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772646428; c=relaxed/simple;
	bh=e1h0174GTM/+x4aq3PSRfcBme/rg+4UKuKBELx3ateU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4GADmvy81VnO3QzAspFHz6n7bVMy2Y7R+PND2vschTIRkZGyP0z+a95XjPQIyxth/sM/58261FYoQIm8+aWpjzGyXe7QR2efrNqVqXPqSYeXHCo8EMngVpvy+psJ/HQdXotHjEkOwbQk5g2CwZLJSUoePA+NIarbVU4WTzyihc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oc3uRbNi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oc3uRbNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD0DC4CEF7;
	Wed,  4 Mar 2026 17:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772646427;
	bh=e1h0174GTM/+x4aq3PSRfcBme/rg+4UKuKBELx3ateU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Oc3uRbNiwGh6sAPE7nYJEWS5vryQ6V55FGMWcOX7xD/p2UhHT6+mmOpcylp140nd/
	 itZRB49KuW3hWB/4NMQNnANxdurC0kqrSX2J1ruZJYgLwHhjP4uSKaPgXyBWKQt3HO
	 fVcFIzwHB2hfRl2g/cjL3igqzNVmajPaL8lEpWB34+L/WJ4aAfv+bn4OFa1p1EZUPb
	 i+VJwYktz/8MC2n0ROA+TTvrv19EjT91y2jicKeHznZ0XgazVHZpIrTuq2xqJ5wvej
	 h8fG2reD54caCq6MtQHRGXkaXQt7GHWvHJ/+J3tWkO0UNXPRVv6r8RUeGkCF0pT4BS
	 MoCr8/KPyejEA==
Date: Wed, 04 Mar 2026 07:47:06 -1000
Message-ID: <ca0bf101ffd9ea806fc987d48fd8376f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: zhidao su <soolaugust@gmail.com>
Cc: linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev,
 bpf@vger.kernel.org,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] sched_ext: Use WRITE_ONCE() for the write side of
 dsq->seq update
In-Reply-To: <20260304053730.557800-1-suzhidao@xiaomi.com>
References: <20260304053730.557800-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

Applied to sched_ext/for-7.0-fixes.

Thanks.

--
tejun
