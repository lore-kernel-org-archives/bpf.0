Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C8B36E497
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436543; cv=none; b=aNo3nGvw6BnaoHfoWVfCMvikmipa1OGPAUlJN1TexS8cIjg4Xs+fzjV94uECGB57glXz/hl112IInkbyeswTY+BOKmshpheHPsRRGyQr1+6ybUmYtLjhXUQ/ZAiqFoEnn1ycZ2txiyiho+sic4Dslg5fQCGi6XVj+BlmDxGdA2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436543; c=relaxed/simple;
	bh=6NMBOPdnKmfBHXLgTRf5uWAK9hLha/eILz/qnY+Pwhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZlGO6TZ6EBDjwga6XVPC4AeA/VuubgxHaWC5SFx2LDn+PvV2JVFyH5f0RmgTazOvWoLp+Oyxq5df3byh8e5TfEXhbebA2Sg2mMo2WNw8OKTbHCNUecixUjVnAXSCzSh8L0VIeVojSu5+EJrOPyie0vsA4qlrYCgmNW/bC9AmXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tyFNSz2K; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tyFNSz2K"
Message-ID: <b15a4ba8-e6fa-430a-b91a-a32a4bb84c52@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783436539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pKpkvLOBs3T03yECX1ZGbffwPSwv5EOUeHxaLSj/9Go=;
	b=tyFNSz2KpQnjsc0vAYnrdX27ZdsN1VsSZOp1bw1cYZob7zz1Pf2PwGJghxT780lmGTfuL4
	VW3Fwl35zWxz5bAsRciwGEYWrTv4jz8To/Si8fVuKrWOClwu0wXAAbh75LixX9F+eksI/N
	uhltMDYZxywQ/m+K8u3TQvnpWopPF/s=
Date: Tue, 7 Jul 2026 16:02:17 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 30/33] bpf: crypto: Add AES-GCM support
To: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>
References: <20260707053503.209874-1-ebiggers@kernel.org>
 <20260707053503.209874-31-ebiggers@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260707053503.209874-31-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 07/07/2026 06:35, Eric Biggers wrote:
> Add AES-GCM support as requested at
> https://lore.kernel.org/r/CAHAB8Wy1APeCcm7_OfrNYeZFcMXfZ5rUSeDX7-c7WO_rGg2Zig@mail.gmail.com/
> 
> With the library this is straightforward to do.
> 
> The associated data is assumed to be empty.  If control over that is
> needed, support would need to be added for it as well.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

