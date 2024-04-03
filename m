Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D81200D4
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 13:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150103; cv=none; b=hxvf0MvveVOg5dF3gXRFUGLPdOzWyD3rUJ9ml6at1x50rxE/QvniWsSs1basZcgN+W3D4RsTA/qg2vpdXcQ6B/8guXxwdDHItEM8h4bGH1c+oNm+AKZpdid4NWgNztxaBFzwiL2KP1hEmNzoyXAJ9ieQZ7xPSThi1dOUNR1ggK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150103; c=relaxed/simple;
	bh=ITOsRUv/gpIqDBEdizhmXVk89pHlZvPr6byhsL1UAq0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SjQ4+d2UDaTdFAAoYI3vKwwCmUMOrM2Wpq1bw4H8vNS6o8vb1X2RKHmg0JsiIUU5Nf/XyLpi8fSJWdF+3DoU6hN0L/QbSd/V+bQCFtLARh8sPge7m3DzwvwzQc7qBOKXabM0CBWa2k1wpAI4+vqrkz6ruYa6np6mqIUzOVI1HOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=DQN+d6tv; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="DQN+d6tv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=hCtEuQG+9jeFUOyxUOTXiB3NQXn+MQwveuXXc0UrGak=; b=DQN+d6tv3YoHofHWu8AaI4O4pY
	04Rz6F5/bnbEKqVt0baZR8fgFClOm/8QHAUp1lpDlPCxZB/JjmPpqsI+OoNyp83G30s01WssfxGkB
	5WatxZcIG44cNJ6/rd0IV31WyCt95P0SjJd0mZCrsFgMQIC6FFYhQmd2QIZKApSvc0sUZv5iA+lkS
	H25X8ypqG8WpTgnvrzttMtWIQVRhMw+rsQ1VIkM4F6QJSEKTnelOW8LHRsQAKTYoHaRn+8v18WxFK
	2R4twFfV0k/+LvH40ujvzrcJeRza/hCobubAciSzZFkvcvQz8JAt+PNul+xoHHZ3qvjm0+OM1uuDQ
	P/aMW0mw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rs0Rt-000EAI-9f; Wed, 03 Apr 2024 15:14:41 +0200
Received: from [178.197.248.12] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rs0Rs-0004gh-29;
	Wed, 03 Apr 2024 15:14:40 +0200
Subject: Re: [PATCH bpf-next] bpf: pack struct bpf_fib_lookup
To: Anton Protopopov <aspsk@isovalent.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Naresh Kamboju <naresh.kamboju@linaro.org>
References: <20240403123303.1452184-1-aspsk@isovalent.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <db09243e-c313-f26c-a10d-ab1ef41d2ac5@iogearbox.net>
Date: Wed, 3 Apr 2024 15:14:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240403123303.1452184-1-aspsk@isovalent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27234/Wed Apr  3 10:25:27 2024)

On 4/3/24 2:33 PM, Anton Protopopov wrote:
> The struct bpf_fib_lookup is supposed to be of size 64. A recent commit
> 59b418c7063d ("bpf: Add a check for struct bpf_fib_lookup size") added
> a static assertion to check this property so that future changes to the
> structure will not accidentally break this assumption.
> 
> As it immediately turned out, on some 32-bit arm systems, when AEABI=n,
> the total size of the structure was equal to 68, see [1]. This happened
> because the bpf_fib_lookup structure contains a union of two 16-bit
> fields:
> 
>      union {
>              __u16 tot_len;
>              __u16 mtu_result;
>      };
> 
> which was supposed to compile to a 16-bit-aligned 16-bit field. On the
> aforementioned setups it was instead both aligned and padded to 32-bits.
> 
> Declare this inner union as __attribute__((packed, aligned(2))) such
> that it always is of size 2 and is aligned to 16 bits.
> 
>    [1] https://lore.kernel.org/all/CA+G9fYtsoP51f-oP_Sp5MOq-Ffv8La2RztNpwvE6+R1VtFiLrw@mail.gmail.com/#t
> 
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
