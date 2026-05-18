Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40252302756;
	Mon, 18 May 2026 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104783; cv=none; b=R6p5l5h/Du+IvG8pdPd3YHho+niyZNxqzDiPVmqbgIwtKbXhUoqz2BkDDsoXJKCB475eeXo6AEluuE9T4LG0s52ZNcwlN6AkwSHO6x2FFFBrLnsAQJsDAlVy0xEyGEJtc/r0Zz0wQzkCntGVnN1NgcHgCn+m/x6CrPiRvZ3bKcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104783; c=relaxed/simple;
	bh=XqZni0xuqOWv6atxkSxgH5JoYFF8z41zXXsop3zKZfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRPWwGW4bRt2UWtdxZUy3xa2h7TuHSrSS4Bljcizie3MVmq5KU80y0OG5XAdyrE8cS2vYRs5dRny1Bv0mWUay5lA2bUXXa+2a5ytaDPioCUF1/Uy7XMasyM9FgGMSXFRj8UI+s7qA8CyBsn6cCPpyyArTadMwCahjeR+f9cujVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAQsjz5M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAQsjz5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4BBC2BCF6;
	Mon, 18 May 2026 11:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104782;
	bh=XqZni0xuqOWv6atxkSxgH5JoYFF8z41zXXsop3zKZfI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CAQsjz5MR5HfrsRXegE6dNHqFlSV0vf4Te6NzEK3APu/K5S3I8tas2Nm8WVsbtlgl
	 RnEsZ/Wl7AjzlJ75EQ6BBo6WW196SMgCpcvyF0SZNMIcdzyf+V4o3wVMNVjjwoWKz2
	 eMQbqmJTHD/TcD0fXOQfMTNu0g/GhBAiE23pWIT1P/Yrpt8Czl6MsndH6L4cQBDokp
	 lKftBHqW9BgOXoUI3y+cRGovEyQgIBSkDd31Vrwi+uamgQrAlMeJYttBeKFGRo9AYQ
	 Rj4JP1NIPU4c2TdyabqAdaDypocx4oPqjVqvfmuvhr7oFWNHWQ0RIpuUZmdVbNrMhu
	 yBoRF5fNCYW1g==
Message-ID: <928e935a-b7a2-4cab-bb1b-49c88f8dd612@kernel.org>
Date: Mon, 18 May 2026 13:46:15 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/6] bpf-timetamp: support rx side
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, kuniyu@google.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260518082344.96647-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/05/2026 10.23, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 

You have a spelling mistake in the subject/title.

  timetamp -> timestamp

--Jesper
