Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504875;
	b=aQkKdPneo3mWK4eCsjRFLCTVTAerqWR6Piin4ojflEHVDR4AcJ0fc2R5BaWwSVwbW26X
	 hGt5ll3X8+ZKaOY0t7uUFUS5urLFJVWei3wUXLTTAEiqF1k26wrwS5OisqxTRj2kKbZiO
	 zCrO4Qlii8KHkSPaJCDdu9LALEQTc4dKGUCiYU/ty4zGiWG0CcDlYLy1KnMZhu5JxrL5l
	 7f1MwKFEjA8kFgi2iqBg6wUm4zQzFUvozTnUSyO6OOcaIAd1LSUwQA3DkWwAltHAhCk25
	 bF0pMyF2oaPprcEScnpi8D80wOi8QjAR8oNsSp0PRihRGezuh+oiTpj1W+PXDwQPjXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504875;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=aHf8SvTsvmzrsiNoKF8t5kRLlqX2t6w481FaqMiV8l8=;
	b=G6kBJsgdNlnnV874Jib+006AhkL02lQ3B7vJVvQ8BttAHf1Tg8bGk0kh8Kj+dWyaU8f7
	 N5misxdktzKVW6krTu8Tqdi4XuIDf0sPV3k8Ya7Ph1m90mZ0bAE2TmTMrESG0yiD1RGYe
	 aZdb57J2yHVhWHskGjTU6U2W6PWztMlmiFQBWVeqf+VSEtRZ+kOGvcXXpEp6bD7FpqH1g
	 gEAxGQS62aFvgIUadXjWJ/V9DsDgnohWAevi0cDUAOaVYCpHq48EFFlv5Cs3CCEW3B+qn
	 liufXeFEvIoZLopb3quEJSd7l18nV/XHA5OWnbpN/Sst4b2pc+Zf/MbL5srR8gVJBFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRzwyZVM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DF2606DF2E;
	Thu, 12 Nov 2026 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRzwyZVM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9881F000C4;
	Thu, 12 Nov 2026 17:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504875;
	bh=aHf8SvTsvmzrsiNoKF8t5kRLlqX2t6w481FaqMiV8l8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PRzwyZVMjW0YbLQw5kcg06GPJMKtkdEU39ifUVmU9j9kqwRDxZzXfQJCRvTqAkEd+
	 Tn+J7ZI1uj/djpgGDS8woplc32Z2qjmjg0yfU0Y9aEzdb/xFmjyuRwYi9sChkek3If
	 AkZA/f9nrUg1GVK7hjdVagbniA1XESr0tSA/t784j5A78+H/mm4YLXYrsRo2UBh+Tb
	 xzetUpjVWUgXqitpbP4eI5F39ROFHlsvl/n6fJwN6XbjajWJ90jbT+i6/GXKzxh8HT
	 lpyIEVRYSj8XA6mbNyWJ9rK9vvJRjG/L5SDnMZwDyi+tfGgY3kI2PvNPASZQv+pAnm
	 Ycwl7bjYWk7aA==
Date: Thu, 12 Nov 2026 07:34:34 -1000
Message-ID: <6814cbed2f153dbe75711c624f6e0498@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, liwanwu@kylinos.cn, usama.arif@linux.dev, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 2/6] sched_ext: Make scx_bpf_cid_node() a benign lookup for invalid cids
In-Reply-To: <20261112130934.563321-3-cui.tao@linux.dev>
References: <20261112130934.563321-1-cui.tao@linux.dev> <20261112130934.563321-3-cui.tao@linux.dev>
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

On Thu, Nov 12, 2026 at 09:09:30PM +0800, Tao Cui wrote:
> Bounds-check @cid in the kfunc instead, keeping the documented benign
> return and leaving the aborting validation to the paths whose contracts
> call for it.

If anything, it's the doc that needs updating. The other cid kfuncs trigger
an error on an invalid cid and this one should stay the same. Maybe update
the kerneldoc to say so instead?

Thanks.

--
tejun
