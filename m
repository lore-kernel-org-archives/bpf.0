Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794804712;
	b=H4Wb2G9cy0DySi8ULpEYogZaiwE7IGU/kNIJV8e0ZTQor6XIMd3x6CsDC0t3L0oTy07Z
	 vU0XidLRQY9I0aEqOwsEok1gfPehJjQJEd89XtSop8yVAm9MuUEwYWWl35FZvVP3TkjJK
	 OzdLsaqYowy8VfIcIYzsOL6und/Bk01OYNMWuiH58O6qOTM5vWFQ0TOb0wtlfnljr+k0P
	 flomWyIl8Oy0y3bHdXriJ4BWhTw558f/f49bOTcHEUMZie+CnsrQFOnRNG7aaxx9fnsPU
	 ya7lKXJfckRsighXVDddVl6wpBJJRhpDgl7WdW6iop5QZowoO8VQ1ocX04aPxZC/tiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794804712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=I4t5XE20i/gJJgLpBrJ+KezC2CeSfioWQ5iCK7ep1kI=;
	b=2Lq8AKv/pr7llYk1uhlJiYTdcl2BDSoPrvTpzc2F+ZKL4nuTdkwgrR8wmLKE41du6AaP
	 c2bfRIdTdfIWqu2wviRO1CfOufjaxhml5v6HdQPCVp57DpAptXnFVv95PoHRg+cg9TZTR
	 qaWeDx2WjoDYUfpqN9rcJM54zUsmOWHrIJZBO7HOWhqQ7kp4oCT51Z1ZdAJHOwxd37AOK
	 +cnM1z26keDnigRZDzxe+8ABset1XAAtH8zHAgE1p565GLbb/BJsVJc4CD0K9ahABH5JS
	 xjr4Qqdbp+7m0TSkOA60bouBOIc1Bgo3Z60LfB7QqjjeOgQ27CsmRpiOQZeibsADeNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q9uMG0sh;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B83606A323
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 04:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39B83606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q9uMG0sh
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc758830601so2994831a12.2
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 20:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794804711; x=1795409511; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I4t5XE20i/gJJgLpBrJ+KezC2CeSfioWQ5iCK7ep1kI=;
        b=Q9uMG0shsjQL+u25gEioGMriGdkjPwXQL+5xFLs3BpJN9/lu5iNK6xJCTRdqzaVo5n
         d9qIjaheY8Sw4SNzemMBpyXWzwDpGL+2DUGvdthUsK5bqlxbmvwhXPby7xVBSckSGUx2
         A5P6dOPRHR449xae40tDEHvQSxWdGTApunX4iuvlVkVkbcPFv2ympFYjpBuLBdHbwFPX
         hHsSi0ExiGK17YBMPV+Tk6EimN8j7iNHmFYj4JUle+Z++KdZRzpbA0dPu4Aphd4h4wWm
         3ULZboBKGMvR28nAEPHHojGsL06gRTFhRBEOrNIKjXaFHRhi/Pc4ukzFpYurIpprgR65
         N9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794804711; x=1795409511;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I4t5XE20i/gJJgLpBrJ+KezC2CeSfioWQ5iCK7ep1kI=;
        b=vECdThRNWa3yS0B88WX1POAZa0NLGpm4AAxbmhTsgdoKOXeFzhTxgWZRn5ygBzHMph
         wcwDYK7o2Ebz9KZ9U+KNKF5ZNN5/C2035syyEemogURGseExX/pikJ46k/uNlJCeyTPI
         JDfujR6JCtyzVAXGwrFlt9lT/aTOfOp8z9i3SpLqzah0SOWVxQ4eBDWOB+NTaiKEgJsZ
         5qJ39is1OTpALP0+FJL3JXqiYKbLuO4EPYmmiKapGk78VrNAbiQmgbfoLnECUpZqOLSO
         u3zUkf6S25DRDk/2q1kjm2qtYS7XWasQu77EwxCFqM9geMg2+VDVwysgFPxkbiY5VQ7R
         csnQ==
X-Forwarded-Encrypted: i=1; AL+hErEIeuIZddwmBY0dmpDj49yvVwQSFlmT01lzIyZqdiV6aGOTfauY3KM2pr16Wz2c2QNjCHg=@vger.kernel.org
X-Gm-Message-State: APuU4Z83/wuKGqW5l89BCjN6CQlyG3VKKuJhZSlVsjZS8FjhT9WMqry6
	JuLkePUav+aibOOaRf+K9CSuSv+rguSxBDnSAL2fa8vIo8Gk5s0/fGHj
X-Gm-Gg: AYBFou1DA2yZxtRncKjaec5/vI9Zha2/+GI1lLz/0ZZaxDzPG0+nhXjIZb5WdMffYgS
	XYtX9q5jiVCF+SgSbIkQSxFap5we9g2x6XAI/d+paKMgFfU9XroiVfIb2vphUz92hZnxm5RH+ss
	nIvlem5qFyNkRKTmbCAqa34q19KctBC/XuyumSkzAZAKVy8RViWuOxQrEhuR9e3/T25gD31d5gN
	+rRmpm/okfsWRM90FbEkofX9Lsq7kdzWngTwQJJ0iH5Jc1cvs4AR/KkfY2Q63qGeSJdQK8OQQn4
	FcEz68r0SzTeGJRbP8XpM0HojR1oh2niPxCkHA/OuEYsgCIFMlFhzOPAEJZHcMWKLA6hHc5GW1P
	cBdtVhG5P1TNfVH+8hlIiBlK//BYh9He7ZamMgTE0spNj1KqWvXqBfM2wf8UnLbzfrxIPcLCSwC
	bAf0QDRUiIHMbQtxfyAaCciGxWkKSWxpb5X3oSLbJzv10ujJjuJfM+SZtA0o1oNBH7OSPgzP2bf
	SPtxbxC5+a21xMpWTy6yiG5M5bUKXozG1aGzzGzcs0ajqWOCfOP8Ibz83mBEOEYg89O9mUBly89
	bV184XCjPSaXHyHqhbRPzTst4Ftb3mAlrs5bc7HkHUm6eVSW8LAtRz/9zSsugrUiWYVrrEASmip
	D9dZgrnEuikE9CiA+92yO0X7LcDWp4MB/mQ==
X-Received: by 2002:a17:90b:2247:b0:3ae:2969:9031 with SMTP id 98e67ed59e1d1-3b1b0d08f2cmr9948935a91.54.1794804711394;
        Sun, 15 Nov 2026 20:51:51 -0800 (PST)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197ce460csm19648688a91.5.2026.11.15.20.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 20:51:50 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 04:51:50 +0000
Message-Id: <DMWD65CI6NZ6.2V1UCWL1FUM8K@gmail.com>
Subject: Re: [PATCH net 1/2] udp: fix reuseport rescore fallback
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Zihan Xi" <zihanx@nebusec.ai>, <netdev@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>
Cc: <willemdebruijn.kernel@gmail.com>, <davem@davemloft.net>,
 <edumazet@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <benh@amazon.com>, <kuniyu@google.com>, <shuah@kernel.org>,
 <vega@nebusec.ai>
In-Reply-To: <8c46325c4a433f02fdc7241c0c3884126cb502af.1794759652.git.zihanx@nebusec.ai>
References: <cover.1794759652.git.zihanx@nebusec.ai> <8c46325c4a433f02fdc7241c0c3884126cb502af.1794759652.git.zihanx@nebusec.ai>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Nov 15, 2026 at 07:55 PM Zihan Xi <zihanx@nebusec.ai> wrote:
> When a reuseport group contains connected sockets, UDP lookup rescored the
> socket selected by the reuseport program. If that socket did not match the
> packet, lookup retained the stale selection while continuing the scan. This
> could deliver a packet to a socket connected to a different peer.

Not since 6.13, unless CONFIG_BASE_SMALL=y.

> Link: https://bugtracker.nebusec.ai/f/net/ipv6/udp.c||udp6_lib_lookup2||socket-hijack||m7q

That's not a hijack.
udp_reuseport_add_sock() lets only sockets of one uid into a group.
A member of the group attaches the prog.
The prog picks a wrong socket of its own user.

> +		if (need_rescore) {
> +			if (score > badness)
> +				badness = score;
> +			else
> +				result = sk;
> +			continue;
> +		}

This makes it worse.
The unconnected sockets of a group have the same score.
So the score of the picked socket is equal to badness, and the patch
replaces the picked socket with sk.

Sockets A, B, C are not connected. A is the first one in hslot2.
has_conns is set:

  reuseport picks   today   with the patch
  ---------------   -----   --------------
  A                 A       A
  B                 B       A
  C                 C       A

Nack.

