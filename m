Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793562549;
	b=FDfMSzRa2C7Ue3HPe1JKP2EeiUrhOrdIUUFO5giolyMdt640DrprwKyS9svjLJZe/HLU
	 fepTGrTQAwKmuCBs6jrAu+i4aPq4ALhbucZus4zYs2a8zNBY/iXdtY+vF1Cr/oGJYtY9/
	 Op505kxaedjwt4B/xhuDA/7l1+7ByqIvgS+SR+DL2FpASYmEeX1z5xySNrXyXBjQJ/kgr
	 iqVAaLG6CerAGdbxe8MnPfLVKLbhWWUgdxIgK3XaxYjXSl7yxCLSADUetnqE4Fhl4cY33
	 htvE3ok7uYq8uHqUqnUV3TCnGwEUwTlkY1U88AVZQoJbC0iO5ybWyIJliv78gqql5CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793562549;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=5H8YDSVPky7sI/GySBb3y52yLDRg3S1UFGL4pg2isSfldF8+9iqX3MqihdNu7sIU8Sdo
	 EX2zwVMX9+06mXYqsEdA4jZTKeVuRc+Ct2L8EKwUXDhiBGNKPAyIhzc62E/g9a84hVuv3
	 qbwyGEmKCBsYkxi4x6PPzMUD4kMhyJC42gCMiiJiAj2hxob3ua/dNRgi5yR0Zjnm24EB5
	 DKG/a5x5KPl2k+VV4BrshKNxg89b2TDuWUYh7XwhRZunuxM213kHTeuJumAPeVthJs8hl
	 soRKforHXaZ7eEeExO86gN9kpKk5g/RURmKtkBjMJwRFJlZUynYDCEwWSwq5zsNxG5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4xICeLv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32605606A324;
	Sun,  1 Nov 2026 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4xICeLv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DEA1F000C1;
	Sun,  1 Nov 2026 19:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793562548;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N4xICeLv3Wwz+dmmIZCBXNx300TKBJqYFLC1gGs3J2cUP4Y3j7JY5MLya6+t9mBCQ
	 qr5KXmoTHxB7gycV/IUmWKvvnIpVr4IsSMi74wcmRLIyE44UCyWZt3FAymyFXOFrVL
	 2ROQoDWnW9FuPhvsjbRDH+k2it30Gq/gD5nvwuBTqkxz+nmeRzn/mpYr5YGw9YkSKm
	 ulpsj1t5xyldvoBeCkQOUkDwyKFihz3quhZk9QssazT5CIXQkzzMmqIJ9okd8O2lOl
	 njUHRd60oSTfEmC9esXfAzTxolTx1KEy99E8nhkdnNB+dN6f3RseYX6h/OYsNhB9/N
	 MKJ7ChMHGAbTQ==
From: netdev-bot+sinfo@kernel.org
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dongchenchen2@huawei.com, bpf@vger.kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH net] net: reject a negative TCP header offset in
 qdisc_pkt_len_segs_init()
Date: Sun, 01 Nov 2026 19:49:07 +0000
Message-ID: <179356254767.3286.4767136450753949543@kernel.org>
In-Reply-To: <20261101194433.2637113-1-alexei.starovoitov@gmail.com>
References: <20261101194433.2637113-1-alexei.starovoitov@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
