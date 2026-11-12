Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504879;
	b=gCcnXnXy1PnXR7iNMLtlXsIY2K5pW5RRliysvgzg7grQQYEYpBLGn1OBnR+PyzU1N3aX
	 0NHvjzF5a6jAiYJib05yaFE3EmmExG0t/K+fS7hDRoyBx9BTZtEmSvgkNDRy82SuasHOl
	 vZzqayTjwOKijjF6pSBBPQRezCJt8eInFc02lFA6i94mZGjqQ0hztZiDuvTpsNPgC93c7
	 cWTz0ZoHZ2aIiZHYDqcRZc73uUZnwgRRKHiAMYKfGgCvfMubEPh6ce9jJEtORP7CfM+LP
	 7RUn8VnyKkRUTZm57Uhlr3Y0Dfa8hgPIx+MycIS9KfCO9w4ZxH91ouwgCOe3DV2/HXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504879;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wzwyNnKIjrnozPoGZW9Td2OwtKGX1s/ksO11oNcMF2o=;
	b=WqPn9c5Lvex0HfVJKF/4eYXtziiVC8lmGOhxhdLnJAm/GkuoCoMyyNn+KTWRfA40QUFc
	 mNeUwAQyIgUJZ0BvOyKVkLd5Cz+sO0nJbCqUuB7MlTtdHdBeK39rZtl2BJRFlUiPSqCuF
	 RD2CrvojORFSFBeGzT/ZiYBIw/SL8uYT54HaNtEt6/j6p2MByYfdfr0TukdJomVew0chP
	 rEIFNce6fRgvqQuAf+XYio59KZsq+nZ+blhUgEt+z2cki7CgqKkypbUbC+GKqIRMUuogQ
	 DX3YrQWByWy+GakoKuCBY0tSl8XbOSR5RJgYvHhUnI+pd+hEbbqJKEB1fksM25ekJzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9WIuLfC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A1D606F28E;
	Thu, 12 Nov 2026 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9WIuLfC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40D01F000C4;
	Thu, 12 Nov 2026 17:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504879;
	bh=wzwyNnKIjrnozPoGZW9Td2OwtKGX1s/ksO11oNcMF2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e9WIuLfCLY6UYzQC0AA42ciW2KFC9WkpP+EIqHqlwQiFsRytgycgP/EvVDAFeGrC1
	 AQIFXlLOvVVkeLTx/+ccnK3WHMGDieHWouWOHaqvuMKG787t3dDcO+gN3/5oBcNtas
	 8R8UCZ+i+zfitn1xKmbdHKylkhNpjPFrxOSh+j2vS1Plw6cGJgltFKp6OW5GBZibkV
	 niATL4pWrlnqYvDVwog9pZ9RkKxUqClOQM8CsG5AEOLcDumqpivEKpVTukrexY6MYe
	 EhtmDbG8El02VnXXlUSjq3ePoFmm3k5BwxANyWCdWYiBKxhJVNCk3iQPAhGj/9GPpd
	 YiyX5tu1guogw==
Date: Thu, 12 Nov 2026 07:34:38 -1000
Message-ID: <7a17d1d32232abe85b559d61b5d2c536@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, liwanwu@kylinos.cn, usama.arif@linux.dev, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 6/6] sched_ext: Clear the built-in idle masks on CPU hotplug transitions
In-Reply-To: <20261112130934.563321-7-cui.tao@linux.dev>
References: <20261112130934.563321-1-cui.tao@linux.dev> <20261112130934.563321-7-cui.tao@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, Tao.

On Thu, Nov 12, 2026 at 09:09:34PM +0800, Tao Cui wrote:
> offline CPU as an idle candidate, and the built-in select_cpu path may
> claim it once before the guard layers bounce the wakeup, costing a
> failed pick and a bumped SCX_EV_SELECT_CPU_FALLBACK each time. This is
> not the documented racy and self-correcting regime of the idle SMT
> handling: the stale bit is a deterministic leftover, and read-only
> kfunc consumers never trigger the claim-time self-correction.

The failure mode is benign, and the patch doesn't address even what it
describes. With a scheduler which implements the hotplug ops and only reads
the idle mask, the offline CPU stays set in the mask for the whole offline
window with the patch applied, the same as without it.

Thanks.

--
tejun
