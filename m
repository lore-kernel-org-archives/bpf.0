Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C7746982A;
	Tue,  1 Sep 2026 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251358; cv=none; b=O/8QTaerOVuX9pXxiBP+swJIZi8t9GROflpQOw85kfoPqOZ4QKkI1Ix+k3pzJ8P86eBod7T/OBO8DcfiSZeAP38J/+EPdkjr3AE+zOIsn9nm+iVi2gzcyDK1bDeWHiAWLLMWmcBDWYROmszAttLOGTkr9wmJk//bZFCTTen7Yf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251358; c=relaxed/simple;
	bh=+wz7X+nGwy6yN49W8530mdNG3yywKtAtrsWlqbFpVRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzRyfvM2kv90NOKwaheRVn5fc0BfSiIssUNrsa3M3/BnoC58f+Iy4rQ/LYAei/5njr+ZTdp4HSEknlhpzziI7CYVIWRLyi8sjk2ml+no/ZheQ/fzwWam5JgwQkBppy/m23pqO0T1BoGxZ6iOW7i4xOCWzc6FKvJN341mSzCmCPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+4reqlG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+4reqlG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255901F000E9;
	Tue,  1 Sep 2026 08:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788251357;
	bh=OQJptYqXaP7yBSHhBlmJaEuEUnH/RFb3w5rg8tQnB/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q+4reqlGibgMNlTMZdMdZYyc5ixOckR5PblEyN8tdoEw08wbK1Di1pkRgjGoT4OFB
	 rOdNeCK/Mce7umrdpRaR6Q4P3O+yDJji7X8kbWA77rrCzIe0+2hS3XdKiPWZMbd+VZ
	 +UOFxnpmOASPdN9xFs8ymMx/CpJY8ABr+65bo+5yeuV2FHFe5DHZP67qsDIbxoAY1c
	 lJTz9+GHzUtuU7MuhlTd/5fTiHIl/aWGmqN00CwdCsSS2p5Klu1Nv2YO5haOTMKA9Z
	 r5755gX/75CNqtoIKJ4LgIBxdxt9H8Qum78aDM/HFvmP78edoRjjzRKJlxxv7CCT/D
	 Al+CjPPcqV4dQ==
Date: Mon, 31 Aug 2026 22:29:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	michalblk@google.com, liwanwu@kylinos.cn, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 1/2] sched_ext: fix vtime priority queue inversion on
 wide vtime spread
Message-ID: <apaM3G2AJmYkGJW-@slm.duckdns.org>
References: <20260901024038.730424-1-cui.tao@linux.dev>
 <20260901024038.730424-2-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901024038.730424-2-cui.tao@linux.dev>

Hello,

On Tue, Sep 01, 2026 at 10:40:37AM +0800, Tao Cui wrote:
...
> than 2^63 apart. Unlike CFS, which enforces that invariant with
> min_vruntime clamping, sched_ext takes dsq_vtime directly from the BPF
> scheduler and cannot bound the spread. A scheduler that inserts tasks

This doesn't make any practical sense. dsq_vtime is by (implicit) definition
a rolling cursor. Please feel free to add documentation if that'd help.

Thanks.

-- 
tejun
