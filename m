Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F14311977
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 21:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776548035; cv=none; b=RA17F+qbwKyHWieDONYP/mFvybElPyxWjlMkR+MPSwptWKakL51bURsZMniHdEcnS+uzwiSPDNzsfOHZVHPYZnUU09/FhNnjVhox0PfTTWUtIIuoWChWf8PxZ+PLaJ5Mv8z7FPoPXBn2XTMe5CVLh/gEHCRBglLE4LdNVlARxKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776548035; c=relaxed/simple;
	bh=jTyvOXOCiYvzFnNNvh3qlkrm9hMic4NNsp2eVgQ57JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gcS19WqtL4Bax1RcLh3luic7gDmr1oxVxak+jBM2dxjqLqOEPvtXlm593KbIztJMoCpd0bHyR+uM5LdgJlAph9mYrte9tI9ECiwttJaDKU2azBwm3XJkAwdRYYhwWWK95AkZdZFGWG1YkqZaauSXbTSQ4JcDEtvtFxTUrzhGMdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ErQGw9aO; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ErQGw9aO"
Message-ID: <894455f6-eb66-4625-879b-a20c6c23acef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776548021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D4X4SIOVC+VXLJ7Iz/lQN35olmgueb4Sia9NnFavWMc=;
	b=ErQGw9aOlDGdJCW967n6heS2EKWe1aDT6d0HODK2MYfp4VTNZa3d3Ks0sxB6jiYh3rWFcv
	FJXGkEcsZ70RlDF/pK57g0QYITbArlAzIosci2cboDw36uDmjlvIMRXBiESEL1YC4KkjZ0
	XQEcbHjZt7HX394ehoMwGoGhpKNQB08=
Date: Sat, 18 Apr 2026 22:33:37 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: crypto: reject unterminated type and algorithm names
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260417073128.91029-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260417073128.91029-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 17.04.2026 08:31, Pengpeng Hou wrote:
> bpf_crypto_ctx_create() validates the overall size of
> struct bpf_crypto_params, but it does not verify that the fixed-width
> type[14] and algo[128] fields are NUL-terminated before passing them to
> string consumers.
> 
> A caller can therefore fill either field without a terminator and cause
> bpf_crypto_get_type(), has_algo(), or alloc_tfm() to read past the end
> of the fixed buffer.
How can this happen for static defined type/algo structures?
