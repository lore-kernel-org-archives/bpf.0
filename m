Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96AC30E0F2;
	Wed,  5 Aug 2026 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785959416; cv=none; b=KThl+dy7aSdP/tCvcWJPc9ct4NafVuMfBF1wXFcBvB8iCMLG29rNa6wDVM76HJM7X/nOW1mmb5mTe3J30EvFCLSy2VcM6fUU6SmdohoEggyh+GQwz0jK2+ReSWsgtJM+2TtPn+5HTATg4HBxrPLCaqvCeeSGg8oOTlVWZJVt1Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785959416; c=relaxed/simple;
	bh=SUzdIfltaZnp81hE5BTYS5eq407PAxTnHKactKOL08Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbky2lmutsVaCqD8V20nUClGmWUldNddexreGPiksyuFRnNzD0cuCM0rrr73t0g8HgiANnJ1r2H9kQ8RoyIcQV8IhezuScl8jma9BEc79c019tNkGmp7TTARq8xwKEFEMrAMyKUWdmJJFwpIARjtu2H6ebM/2LmvuqCWuDlQvgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdECOoTj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdECOoTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF7F1F000E9;
	Wed,  5 Aug 2026 19:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785959415;
	bh=LOB7CGvwPO6II+JzZWWzxZpjszqxqHOFx6HH3gibj8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fdECOoTjIvwqJVE79xr+McfzwmNQI0g4i+mqop6WoFZZACwlXxtNhXu7cQFQKr2BY
	 V6wjXyPblCyrUQVIFf+BwhPcH0MfDwSKaNyuurJ7mx6NaTAbC7/JSv/Vv+5NetDryY
	 dPUXt3fyzJuGQAr1w+ql8SCgkMTRMAgmxqS5Rwx/CTFOtiCh3TTJuZzhm78gASXApL
	 N3Vdhlbx+uqGZn5yt/xbXnUHUMtCbc9JN06oYDM7B/EiUQDbmYqnKBSBCMpI5c3Hxu
	 gJl9a2RZJKLgEGRIog4GRpiaAye5hivazXSX5dq+n9xD+FuCKYtnpngKhhHOvJkCAF
	 Dhfgn0c/4Sg0w==
Date: Wed, 5 Aug 2026 12:50:13 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: tytso@mit.edu, ast@kernel.org, song@kernel.org,
	fsverity@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsverity: reject short BPF digest buffers
Message-ID: <20260805195013.GD3438@quark>
References: <20260805075655.950308-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805075655.950308-1-chenyichong@uniontech.com>

On Wed, Aug 05, 2026 at 03:56:55PM +0800, Yichong Chen wrote:
> bpf_get_fsverity_digest() reports the digest size as the full hash digest
> size.  However, when the provided dynptr only has room for part of the
> digest, the helper currently copies the truncated digest and still returns
> success.
> 
> Returning success with a digest_size that is larger than the actual copied
> digest is misleading for integrity policy code.  Match the ioctl
> measurement path and reject too-small output buffers with -EOVERFLOW.
> 
> Fixes: 67814c00de31 ("bpf, fsverity: Add kfunc bpf_get_fsverity_digest")
> Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
> ---
>  fs/verity/measure.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Already handled by https://lore.kernel.org/bpf/20260803181232.14743-1-ebiggers@kernel.org/

- Eric
