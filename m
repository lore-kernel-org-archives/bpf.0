Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698953;
	b=ojFWmnBi2LkS9KlDxV8j/G3BRLZTqcbTseISGqnZpNToU48lqNhf0RZN9H6ehYvR1ksX
	 Fh5tqpk6PjiOejnRU86RZStfiXIngYSk+LswaEmVck9dlWLeNgu6d7n7+9fxsIjVOg0c0
	 SeCxzGwdpNKxS31l5dovNEKHRjrYmiQSvS859Ip2aVG6D9pTk6LtIuvt5/M4LKWK/lFbF
	 rU0HCeH3Y9+FXkwhVa5ES3e0/Wi6AtZ42FfW9XxTiUEulcSByGZrPJu0nukTaZJo8RzO7
	 VZZZyzIukP+d+tbP4zMbyBFr/4Tt7/XL6GuFREoLG5+Z7FCJA8GJbt3/uNa3ezqKzNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=vuErX9b/1HqZZWQiS2aiX9fKXKZfo4KQ8+WC7eQ3Pqw=;
	b=uY284MXnv1qHpp4FsBwQg7YtLbLWQxOeNlOVGcLXSFmMiG09fjdYruJ6SXjmhPwpxHdN
	 QIeYVrWuy8aHQ+QaGyHDhpXm4TfzcktZij7cmxsrfZnbMrazfooIf2cGcyS5GzRASmr1N
	 V8AM48mmT11kK/RFm4hGJzp8u693PF65zOy2uljrARcoNmW2jJ4A4MqlOp4L27CeQIhlT
	 7xQTQTwHnAymvl1rs9FMdfHkHDmroRNLHMWpeZmdt56bWTxRJ8l7TpPPAIiIPw6vzuzYA
	 j8mXOpeYHL0b+h53p8d2fLGVESDXvqGolJxkSfH/+2GrhTjqm3KMPCH7IcWNRE1hzDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VgS0MqS+;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0968C606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0968C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VgS0MqS+
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b4cd193b50so1867703a91.1
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 05:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795698952; x=1796303752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vuErX9b/1HqZZWQiS2aiX9fKXKZfo4KQ8+WC7eQ3Pqw=;
        b=VgS0MqS+cYIhfwHs8IXM1FVncD0caK93zZNu/oQUyDhQOhTAY5i7Y05HoJEGRgDzkJ
         DoDlZ/k9sBYVEbo4jLey4ykjoB77MWT0dPYa3sD/U6HqVgNIHadtT7tu7Q88b7yDeqbT
         nMoQc5/A+DUyUbLtaKkbkeAY9Em9tWQfvs7UeqLGHNNrlcILSZAetaXUnYKLf3pqqqfF
         0FFQrq8bJyCSMKrgDzdoJtCgvyvT4nRnn3HYQxwy7+ygcmhgRPXToJoEoWdMqLQPxpYP
         6qv8uBLt+Uw7hC7dKTcaeY571p8f0DBgNu45Aqcru6n41Fg4M2Wckv5/Llgz0bFp/k52
         kNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795698952; x=1796303752;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vuErX9b/1HqZZWQiS2aiX9fKXKZfo4KQ8+WC7eQ3Pqw=;
        b=b0AFUWJcKkgRlR4y7mZiXMh2S4BcO/E8lYntbbZdZ6UK5/f2oKOLUJrYxoPZP2HY3p
         OChjqKLKznfqFjr6V5H2cBSjFOElecUR6hEPMCT98MoKXn8TYDlIfT59kw6HdQ74JIdL
         pvU/TbJgbWQL+pdT1jr1CNymwWipvp9nKY3DFkCn8IPmkLAaEC+qQy+GeaTzR1wgec7n
         VaPQXqn5gN8ObLLmkt3OENfewET6HR21trHg44Tn3zOShxNIp+CSuC3n/T6RgC8fab5y
         tu7JAMgXKsmyu1tNUnDc0aHpucOPz4bI4XnB7drWrPH3klqS7gOUOcGAWkrSrJp6OZgG
         dHhg==
X-Forwarded-Encrypted: i=1; AL+hErHWUrm7FjgeqeWk4mTdo8AZX7UvYAAZ9oE8UZeDPN+5Nx+qztn10vhJq5ZRxa4+1bghD9s=@vger.kernel.org
X-Gm-Message-State: APuU4Z950MuBc7GXkuweEoJ9eAIig9BaaGHrdmfMxQpL9UUuL2p0/AZw
	+vv6Wl98yo9p1UVkvzH7amxISjCu96xsDBz4oBPLFXaVhcOvy71NLuO/
X-Gm-Gg: AZFdTZf1GH4vBpllJ6iKOA/VIJC18YoFw6qs/inPTBw5rWfXFnggvufxrbEQs+i8Cn2
	dMUKmlRQo3nLqdW/NMMzytpSLzrryXgpaoXO/9Z2d6y5JYQUsKz+nt4vEwLt18VYPBn1aBygqCz
	vgrqriNV0UvuMeJ16z25t1h/v7e9gOG5uqzIzfPVup5YM9M4BLJY8eZkMr0fDNww58yUSn/mH91
	iC0512Nry/BwLA3tWb5XhM4/VC/YobypTRmL57EhmKdD8LICJyRvTdcJFhxFILM6FEcKK8ky1Y5
	0HT/knIQ6lo4a3Vsp/wtfz6kHj6wJpxNUq/xw55kdMXXXu+i3fZxfteH2Md90P5PqRymE7K87pV
	EWzd0JPijVusxC6sssnNKd2K6tOls/xHdi9j/Li8s3g4oVtgx6zq6Uu2vndhi+DYu/lJCqEqSb7
	rMkzrCvQtoDbVDZf9z0WOJY1QYBWut/L1kinJk1ZUkXToWcGpe5J7yP/o/6TYV37A1WSKRztf4o
	0E5sUGQcwO9MGUd/7We2YKvf9SYHUlDA3cNnujYeqMb3Mn0RWtI5IWn3htiisCAIdst1IjVtslb
	ZnUyvQGvp/a8UsUGLbEpaIxc5VQZSgQZAi6G2u9G5HVXY9bdJdgbPA==
X-Received: by 2002:a17:90b:390c:b0:3a7:9e3d:b3 with SMTP id 98e67ed59e1d1-3b41c9beafamr18976263a91.66.1795698952271;
        Thu, 26 Nov 2026 05:15:52 -0800 (PST)
Received: from srsys1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4afeaaa84sm17021676a91.10.2026.11.26.05.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 05:15:51 -0800 (PST)
Date: Thu, 26 Nov 2026 13:15:45 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	willemb@google.com, horms@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	sdf@fomichev.me, tehnerd@tehnerd.com
Subject: Re: [PATCH net] net: xdp: Fix skb->tail after bpf_xdp_adjust_tail()
 in generic mode
Message-ID: <awgxAaMpICtLvDcJ@srsys1>
References: <20261126125558.2032158-1-rhkrqnwk98@gmail.com>
 <179569793062.3294.6946658046125535159@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <179569793062.3294.6946658046125535159@kernel.org>

On Thu, Nov 26, 2026 at 12:58:50PM +0000, netdev-bot+sinfo@kernel.org wrote:
>Hi!
>
>This is an automated message. This series looks like a fix, but its
>commit messages seem to be missing some information:
>
> - How the issue was discovered, e.g. hit in production, hit during
>   development, syzbot report, manual code inspection, LLM or static
>   analysis tool scan.
>
>Please do not repost the series just to address the above. Instead,
>reply to this email with the missing information, so that reviewers
>can take it into account.
>
>*IMPORTANT*: If you do repost (for other reasons) - please include
>the relevant info in the cover letter or commit messages.

Found with a custom fuzzer. I'll add that to the commit message
if there is a v2.

Thanks.
sechang

>-- 
>The evaluation is done by an LLM so it may be wrong, if you think
>that is the case please reply and explain.
