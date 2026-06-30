Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3482F7F06
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782856007; cv=none; b=stb2hewuEux1CvaPizpDMQk+HTqg/DMlf1AdVIB73oBBa/YJ5d4VlYBovpw4N3hMxDt5r2VfbElrOZAYjqEz9bgsdBXa7FYfAfHuQFiS2tNMP0p3y3kHbaKFCdORlH1KH0kLu3zxO8ZOHjkofaH3LuOfpIr6MF9fJ+pIdigTWCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782856007; c=relaxed/simple;
	bh=Ld2WezCpwvfuWsX4PfQDcRaVg2aKWKSXOFJt7vyXQm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3QVhWU0nIgmBGE3y+iQLr+RTTaiSuEBKHGqQ4qXhMjxqfa6L+4zsT2IcVO5aI4mt4YWNWpSym/jRyNpLDk3RLxL2cntbSLNVRXpMHBHF36VrwE3/7GJmT2Mw+hqpfKQ48HbBrFsHEv6+9xKE66VSO2WNERuIYAdbdE0P1Odxx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jGMYacxV; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jGMYacxV"
Message-ID: <a9926def-30f4-47c2-8ce9-569412d1459c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782856003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQVmI1kkK02j6P74eiy2FaPN43U2A0R20FMooI5kWBc=;
	b=jGMYacxVCy1qD8bJUiL1J63Ax7UtzXTrcFv6+BA2g9dU/d7LoE9xuKh+83HDoCknqg7NSq
	BCeYZl/8uCVnN25lYDPhorOhactshH6l7zZyIrLVI5NqIX5NLAdz+m9kElFBNy079sWlo6
	9TpgAa5udxfChrMoNHg1MWc9ZWcnPlQ=
Date: Tue, 30 Jun 2026 14:46:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: libarena: Add bitmap selftets
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, eddyz87@gmail.com, mattbobrowski@google.com,
 song@kernel.org
References: <20260618085626.19633-1-emil@etsalapatis.com>
 <20260618085626.19633-6-emil@etsalapatis.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260618085626.19633-6-emil@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/18/26 1:56 AM, Emil Tsalapatis wrote:
> Add testing for the new arena bitmap data structure.
> 
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

nit: Looks like bmp_copy() is not covered.

> ---
>  .../bpf/libarena/selftests/test_bitmap.bpf.c  | 314 ++++++++++++++++++
>  1 file changed, 314 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_bitmap.bpf.c
> 
> [...]

