Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603F82FE056
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262428; cv=none; b=pQa030B6TkofhKi8ODwGQTsWTpCt92gHVudr2xMcX/IMLx/nfWSelyRsGPHNeAc1GBkBYOm3W1PVUuDhETIdKLFgpfWy+KDKYI/HiSatRaYyh6ndcBkBjeTy7dkH89WBV8pSNH8WyayuXzMOfEWJnY1EEdrxbxLBCuy6XIWrBUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262428; c=relaxed/simple;
	bh=7sQpMd6cWDtHl3KE2xX+Gv2NpKwFh5uJ6r1XDA4NJHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B4sqRiZH6BikZmKrJlLPFAQEmeLh0GX3XYve34DYdcYjVqfjlG1PkcTxLo4iSeK87cNO+KgcpgVCJvOzsD5vxI3kFKyIJtxqBCX6L54nPP1VG17F6kEAGalUCf7bky/DfjFgJGf9+C98aMq5pQLioOsRt+RdlO9JuIR2qrx1aS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yfuusypf; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yfuusypf"
Message-ID: <a97a0392-bf2a-4b8d-8e0a-10388de6d408@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774262421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sQpMd6cWDtHl3KE2xX+Gv2NpKwFh5uJ6r1XDA4NJHo=;
	b=YfuusypfF2Hpq73eWNaSK0VJ0fyQYB/T5wXF3HVN4aw2t7XAYQy+7ht+x2xCrgJBTODOXZ
	537LhyxaUvnPTTFCY2+RjKHq1rfU2UeS9UVVcUNH1nDy4xU/uDMTfX3Kc7UemlGlHHF+pm
	OOVvYin2ZDHxNLhO+KjPSljyZLL16Sc=
Date: Mon, 23 Mar 2026 18:40:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Improve connect_force_port
 test reliability
To: Varun R Mallya <varunrmallya@gmail.com>, jiayuan.chen@linux.dev,
 yonghong.song@linux.dev, bpf@vger.kernel.org, sun.jian.kdev@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
References: <20260323081131.65604-1-varunrmallya@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260323081131.65604-1-varunrmallya@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/23/26 4:11 PM, Varun R Mallya wrote:
> The connect_force_port test fails intermittently in CI because the
> hardcoded server ports (60123/60124) may already be in use by other
> tests or processes [1].
>
> Fix this by passing port 0 to start_server(), letting the kernel assign
> a free port dynamically. The actual assigned port is then propagated to
> the BPF programs by writing it into the .bss map's initial value (via
> bpf_map__initial_value()) before loading, so the BPF programs use the
> correct backend port at runtime.
>
> [1] https://github.com/kernel-patches/bpf/actions/runs/22697676317/job/65808536038
>
> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
> This patch implements the approach suggested by Yonghong Song in his
> review of Jiayuan's v1 patch [2]: fix only the hardcoded port issue
> while keeping the existing bpf_object__*() loading model, skipping
> the optional skeleton refactor.
>
> [2] https://lore.kernel.org/bpf/6555dc32-b651-4c45-adaf-e3aecb013904@linux.dev/
Thanks for picking this up.

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
