Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4C618E2E
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560363; cv=none; b=GZNarddPSK3UoHjfX3lofCH3IAa0WrfBCHH8g4usjb5Qf2nnDQljaM1h/qUH/Qy/scPqkSeXzMOR3S4zN8ttnNpAkt82igGEQbga5S3C+j7qekpire20CxB4wYbrYlG8Ph6BAueOc7XN5UV1gQrbxH/gD3y83Mela0iQihs5TTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560363; c=relaxed/simple;
	bh=VBAGEJ/S1Y0AGLFPvHgNLLNpMhHquDZPCTXhIsJcE58=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sFk6jC68LVW8lRcugpH/z7T5nptRLWH4Tr70kTYcqePnpaw1cT9e5NU3lmyl7PervAnsnwCowxmQAJPWsY5jdHP2dpZB8ay1FhPRnGjflCdH143BFTeQRKUwwG9T17ExzozHkVrcolGuXQDcGNUL3OIfCdGAk6g8v+BtuV1WyBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Xm9tm3a1; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Xm9tm3a1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=qfZt8D3Mw9qyR0wDgIpiWe2Pv/4RhfaKM3IVk35487s=; b=Xm9tm3a1R1GGnaEN/LQ+d8CqpY
	W42bRTduXr9YGhf7CKPRdI94mNOd3Vb8fPZ5o9oq6HXcFelif+8ZJR80nEB0Ha0W4LoEqig20AOLD
	/I/Cnsd++nL0Yz8DWziAjeWEw/xH2OfMlAXK6Yk2RsnKtvW1xKpsopxNdAwQ/Z25vUt2cbUz8tGmu
	4Bhu/F7e9R1aVB53DTuDpQwlrrqdVRKFbX73t83tziNj0dVaNMkQ4PPxAjza1CyRhhcRs/ZEbAcIt
	XPNXmJldGVSsQRIUHmWR13mOqBqp0pXOyi3648sWvZDa53Kofo1K1vM9bRwSRr69Tequd2ChUW2Mh
	VcGwLNJw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rh8k3-00053t-RS; Mon, 04 Mar 2024 14:52:31 +0100
Received: from [178.197.248.27] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rh8k3-0001x4-Fo; Mon, 04 Mar 2024 14:52:31 +0100
Subject: Re: [PATCH bpf-next] selftests/bpf: extend uprobe/uretprobe
 triggering benchmarks
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20240301214551.1686095-1-andrii@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9114c935-8200-3707-1850-609e914ab3dd@iogearbox.net>
Date: Mon, 4 Mar 2024 14:52:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240301214551.1686095-1-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27204/Mon Mar  4 10:25:09 2024)

On 3/1/24 10:45 PM, Andrii Nakryiko wrote:
[...]
> diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> index dbd362771d6a..a8ed8afff0b3 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> @@ -113,12 +113,25 @@ static void trigger_fmodret_setup(void)
>    * GCC doesn't generate stack setup preample for these functions due to them
>    * having no input arguments and doing nothing in the body.
>    */
> -__weak void uprobe_target_with_nop(void)
> +__weak void uprobe_target_nop(void)
>   {
>   	asm volatile ("nop");
>   }
>   
> -__weak void uprobe_target_without_nop(void)
> +__weak void opaque_noop_func()
> +{
> +}

Nice work and super useful to have! I fixed up the void while applying.

Thanks,
Daniel
