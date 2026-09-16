Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7E737E2FE;
	Wed, 16 Sep 2026 23:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789600129; cv=none; b=Cl8Qrgry1FdSXReFAG85gr5tD068j78fRqOsFJY/7A9DFh8uPm8L6Qev1FDi9bo13qwK2YTIhlVdjnF1V/dFDqnIF3IH/ybLidmdHs6E0/bmIi93XTu3c3ArFNYidwBhKNbkj5VH5S/gQyhjlZzSeaoDLpPgXOL9d4AFdC5KEp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789600129; c=relaxed/simple;
	bh=EwbYJfiKIoMQ1VZqQ8Wd8xwpCu+6toH1NKTDnaaDuxs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9Tiq3ZvX2lIQ/F5kl4sk5xBeXs/fAPIxjx2upaQiejLPUUokds5T7mWw1hr2yipfXehklNuFNgrpVhfUWZT8te1Aa/mQCEENDaqVKR6Vy7WXyc27ymq4K9qA1yK8SgksPd+rMkGWEYgdGUs7dz+Rx05myVsyLbeyDiJ6MECs78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7TtdVyq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7TtdVyq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9F31F000FF;
	Wed, 16 Sep 2026 23:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789600128;
	bh=hxIHCoGFjWtiCIZjfwBRNd2LSH7c4QQeRN0/wLzxWgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k7TtdVyqi5Ahivrl5dUCRCcnnyAPWnzWn7uitsq47MffoXIpd7DdvJqy5COVsDd7H
	 e60lvth5P3rM/bXGbM1CsWskgMAKFgwx8fI2Y5z/NpPqjHJYaK0qJOeD5MzHUKuWjk
	 KvJ6yv9YwP6CDjP97dqJiyimgHd8kgHD8g8FEY17kCmwi8rsMRrMohr7FLN8lFUjj/
	 cJUSbivVRiRnzI6ZdevvAmEG5qabMVudzzFsr89HAIjKEJWnZKFucdhtd2nFAXuIx6
	 5WXIVFfqyzmSUJokSsOzb7Mcov0jm1hoBOyKPs+R5iM9jASAWaSJvuZfElNw7jyKKx
	 BuuyyeB4UTk8g==
Date: Wed, 16 Sep 2026 16:08:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, daniel@iogearbox.net,
 netdev@vger.kernel.org, Nicholas Carlini <nicholas@carlini.com>
Subject: Re: [PATCH bpf 01/11] bpf: Fix bounds check for skb-backed dynptrs
Message-ID: <20260916160846.557e2ee9@kernel.org>
In-Reply-To: <20260916050830.8774-2-emil@etsalapatis.com>
References: <20260916050830.8774-1-emil@etsalapatis.com>
	<20260916050830.8774-2-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 05:08:19 +0000 Emil Tsalapatis wrote:
> -	if (likely(skb_headlen(skb) - offset >= len))
> +	if (likely((u64)offset <= skb_headlen(skb) && 
> +			(u64)len <= skb_headlen(skb) - (u64)offset))

I don't think the 64b arithmetic is needed since the max value
(headlen) itself is 32b. You can cast to unsigned int.

Also the continuation line is mis-aligned 
