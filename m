Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895173FF1A3
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781714320; cv=none; b=mQg9O+XDkNjgpw5oF8+mWZdmtepapfRTo2mJG8cYKAMaZZcMgqA+plSaCvgsbXaCdJw9uIs8RhY29YqTw4q8DZyDq8JLv23Y/7l6sdss3OXpkxUtm5tKGphIx1G1z0yCB8ytn8FojpwDOIv9w3cph3GyyNApKVYgjnY0xMKfgBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781714320; c=relaxed/simple;
	bh=RqcCKAu4rGW0Rng1aFB27GH+AJVkesltfB3I4L2CrwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXO+bF4uEgjzXL5IhtXDWjS1AxmmGWJX+kWP/UE6Va0dseAPeJ0qh1El80XRmXQUaXYNkGaPvJFod5xL6YEJU5hWT65O2hOOwXluO2WzxOMIpZyVSPEKW3GOj3L6ivAaG6eHhvCUodQTnonxrsgeEEEIFf3ji4KaVjtzXStGM48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+c5+hOZ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+c5+hOZ"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36ba706ab46so4006006a91.1
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 09:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781714316; x=1782319116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lnbf9ZuiS/M8BYSOEmK8rpLL1BSfduaFpA9xEOwFXng=;
        b=I+c5+hOZ44pl1HU8Je3QuxnIIg80o0buNwkoEX2AUAnla37g2/jr4JrYQbW1ePn1A6
         B6tmwghuxHA1Mp+IIk7YKvREGn/2hf6bxgrO6vC+kJXAHNm3MeoucCHKAFRZtzIXr7vQ
         w5yyHfUVFpbXqXzUogdnrEvILXXLlXww18X9nvqtP7VuCQC0VR0n2Eh/748/qJvXvmdg
         riB/DaZxeyzmoox/Aq/aUNUEBL5BTIRlgxf2NdZWT3+Z6FROKz6gbe/ikSzkN7++sLkJ
         XYaJJflkLwItSX2NnbzmWQgA+zUEpsqEpWVb+T7K/QPd5kuFr8iej24bk9eVx8qOQw3g
         pOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781714316; x=1782319116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lnbf9ZuiS/M8BYSOEmK8rpLL1BSfduaFpA9xEOwFXng=;
        b=qY0ZngiACbL/f5TxhO5vFC2c5JySp33SvrWTynB9aAR7TNv5nohnTHmlHUqqRsV3hs
         HyyZW2aPMyD+QmOzGhc1ETo/8ODf/8o2c694wjsirvJV9hjGkON9kc+qYUGzMXcBcVnz
         8sZ893/TDNbL8vF+SuNm5/LQdEmWNPjpCGvZRscV1bwHXqNR1tr+qccVUHyzfRGJi0yB
         jxqLe2vmhxh1UD4zjMfXcRCGaV6HeuHvnjpihk2kk5SNO4oAdq4GEp0K9DfU5jkjA/1U
         ZnHSmkZtKdl4HvB3jDX+AuMXjo8gjWaLikXizt67Sjz2KorSi7TYxJq9Grl24etp4fbD
         UBjw==
X-Gm-Message-State: AOJu0YyFScQ7R0F4EZ2Mi1pMQhpQ++Yk0u/SJ/rKwPxmg7E6PfX2MmAM
	xRRfZ5D4/bAGvTn8ayBhvlrzcmb64el8e3h2yBL6rWMtVr/rZvp+XGvw
X-Gm-Gg: AfdE7clQ68KMiMEiq1J0Z/IvVgFxcnKIqSH2ymt1LqIs3bL94E86iQ70wTWMfl0qY9x
	dXsLPYZ9ShS88H+lI65HkGfwaaA4K2pxfkmenozTSNyQbzCEjvjeleEt5vYaKpII+MarBXT9+ij
	IylUITfjZguFuVTmJ2vw3BQYyE/cafMn86Fovo9ULaEIU2oDKVUZiC88/hFrRxRv3qP321K589M
	7vYkqchklyFL/FEFJ3oCYoxZp8Bn+vCSBaI0hWdmOUnH1VONHVYD+glGSLcpmls5w95b/T1WLP9
	kCGKYR6GNy6+Z9PL9ryV/K4/d1ukFM7RIN6nSOb6j37WFuV0dGxcBtdfMK0d2I5UR/MHYEnaFjU
	YCsJtfynPbrxb9kqnCadpOXAawWIwMzNieRlw2lbHF4b4PdmAvRNiAydFPPuPWWGjTWDdX55WI9
	KI3n08stKzGNKA0isdPJnm
X-Received: by 2002:a17:903:2b0f:b0:2c6:6424:c79f with SMTP id d9443c01a7336-2c6bbf98e47mr49625115ad.8.1781714315619;
        Wed, 17 Jun 2026 09:38:35 -0700 (PDT)
Received: from john-p8 ([98.97.43.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432d86501sm161597635ad.61.2026.06.17.09.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 09:38:34 -0700 (PDT)
Date: Wed, 17 Jun 2026 09:38:32 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 5/6] bpf, sockmap: fix integer overflow in
 bpf_msg_pop_data() bounds check
Message-ID: <ajLNdIUwrQTNq37u@john-p8>
References: <20260615021959.140010-1-jiayuan.chen@linux.dev>
 <20260615021959.140010-6-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260615021959.140010-6-jiayuan.chen@linux.dev>

On Mon, Jun 15, 2026 at 10:19:58AM +0800, Jiayuan Chen wrote:
>From: Sechang Lim <rhkrqnwk98@gmail.com>
>
>start and len are u32, so
>
>	u64 last = start + len;
>
>evaluates start + len in 32-bit and wraps before storing it in last.
>The bounds check
>
>	if (start >= offset + l || last > msg->sg.size)
>		return -EINVAL;
>
>can then be passed with an out-of-range start/len, after which the pop
>loop runs off the end of the scatterlist and sk_msg_shift_left() calls
>put_page() on the empty msg->sg.end slot:
>
>  Oops: general protection fault, probably for non-canonical address
>  0xdffffc0000000001: 0000 [#1] SMP KASAN PTI
>  KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>  RIP: 0010:sk_msg_shift_left net/core/filter.c:2957 [inline]
>  RIP: 0010:____bpf_msg_pop_data net/core/filter.c:3103 [inline]
>  RIP: 0010:bpf_msg_pop_data+0x753/0x1a10 net/core/filter.c:2984
>  Call Trace:
>   <TASK>
>   bpf_prog_4cc92c278f4d5d56+0x1b1/0x1e8
>   bpf_prog_run_pin_on_cpu+0x107/0x320 include/linux/filter.h:746
>   sk_psock_msg_verdict+0x357/0x7f0 net/core/skmsg.c:934
>   tcp_bpf_send_verdict net/ipv4/tcp_bpf.c:420 [inline]
>   tcp_bpf_sendmsg+0x766/0x1ae0 net/ipv4/tcp_bpf.c:583
>   __sock_sendmsg+0x153/0x1c0 net/socket.c:802
>   __sys_sendto+0x326/0x430 net/socket.c:2265
>   __x64_sys_sendto+0xe3/0x100 net/socket.c:2268
>   do_syscall_64+0x14c/0x480
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>   </TASK>
>
>Widen the addition with a (u64) cast so the bound is evaluated in
>64-bit and a len near U32_MAX no longer wraps below msg->sg.size.
>
>While here, change pop from int to u32. It counts bytes against the
>unsigned scatterlist lengths and can never be negative, so the signed
>type only invites sign-confusion in the pop loop.
>
>Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
>Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
