Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8593C33BBA2;
	Thu,  9 Apr 2026 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741982; cv=none; b=T2b1aoJJ6p5nFqHum3vEEwzcLARiyCh5pXEFYgLxzN72hptkr6T+aoB/ZUyu5bdcTxOrGNYI598ItkwSUJP9soF0ahkLO4vOG1+E0cZOnhcRJq90p7nMGo8z0RbLqUu2CTatDUhPPR3V7BNjX/dJEu63L/fpprc+l4JZTKM/0oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741982; c=relaxed/simple;
	bh=DYLjldAdnScOnFQ3m1c1iYIMhoWkA1ikgUOXjvCtsAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uc0zGzpRMxRR6s0hbm15owxTM1P3s4DXtW1dn9jc+7cuLFjo3CUNVKhMjqWr/5giAmyZOh4kbID/b36OynHS/7n/z/bJArttoZ4IIW5s7R9nDyB9pa2SwWzcBnzkOf8705NK0z9Xz3FqERHE8+XQmpFVlhvPL5zrPUdUWuviKMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3AeqFhz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3AeqFhz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964CBC4CEF7;
	Thu,  9 Apr 2026 13:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775741982;
	bh=DYLjldAdnScOnFQ3m1c1iYIMhoWkA1ikgUOXjvCtsAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S3AeqFhz39K5zU4799CepbX1Bw5lVKHZmsNzu83ePyMhGPQSy9FaiWVuhad2AAo0S
	 We4cZVI8db31HcaGvoiw6gVUW1azPU+WpDWJld2kJW38HoN3oDWS5Ujgr9LZbG7cSt
	 PpyU3pSL5X0+7YKZvkK28I/He2ej4pcLS8k+w5OtStkwrQNff2IjtNJ8rpbJdcIteA
	 85I7ZexERvhNlKtIS/3+8EqmOEPo3s44qnPt/YCKFsylq2pjfQIwKsT37X8mWMqt6E
	 p7HJbowjxX1vWXUOfBiINLuTIYhwDVsNI/+mB6vXo3P24ArL1I3CLFPAYVAZvzsfsa
	 01M2lllB3YEZQ==
Message-ID: <389aba68-10b9-4881-a5a8-551dc66f729d@kernel.org>
Date: Thu, 9 Apr 2026 14:39:38 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/3] bpftool: add missing fsession to the
 usage and docs of bpftool
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 emil@etsalapatis.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260408062109.386083-1-dongml2@chinatelecom.cn>
 <20260408062109.386083-4-dongml2@chinatelecom.cn>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260408062109.386083-4-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2026 07:21, Menglong Dong wrote:
> Add the fsession attach type to the usage of bpftool in do_help().
> Meanwhile, add it to the bash-completion and bpftool-prog.rst too.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Acked-by: Leon Hwang <leon.hwang@linux.dev>


Thanks for this.

Acked-by: Quentin Monnet <qmo@kernel.org>
