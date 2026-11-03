Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793670444;
	b=4LAaW/QF7m2evspJkZsdGhdlxPVmhB6rT27XF2EgRIk8/5Z3yOUad+Fh+rGnwP/RENXd
	 PWUG/ZQKjTlL6h+d1WX3Kgwybl6VC0lEWwTjokHwCPhNHwq13ishEL7PIZznqsdci+JTJ
	 VsIF37CY1ZuZS5HRyySK6ip7UAFMTo/7ujkooEEJMj3CvfyybmHAcbwEhChaZhcIXhVJs
	 BoUmSwIlL1TcjeeEDN1fjw2DeAn8iOlMoLXrmpKxtasc58TKH7GjxVkiGrRJ2/4ceShI5
	 hnuPd6eWQ9xv47/Gp4FM/Fx8pSPILyWkVcPFA826/dJdiv09vPJigajWFndloGZwMrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793670444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=0n9lMGW1sVKzw3HmKLjrZGL8pys2XInZez3bJmOScBs=;
	b=Nh0QQHBWXtc1QA/itYk4Twp78TV3fMxaWdYTSMZcCjty8Md9GfZX0YGuZL1YzP6TUfoU
	 sbh+UGpelVbxU5x2/toO1NbeSLi75RHFhrsmiRs4Nd9DtIgJYhO1HvpyzD9hEChOKxKN1
	 tbXlYZbp9LBxp4S7tskg28jabp0oekQOZ8KII5/iQ6/HE28bc7QFb07dHUQx6iDwBuDgD
	 8hEPWKfh5dF5Lxz9s3VbK+B2xdgBAyhyLr+AupIFBwtoj4WSACUFNwED4oWTpJTYoTKp9
	 UELw3JlyI96IFdQGhizzjgB7ImZIukvS4PcOihSPjQT0YbWBEoaqpPB7g/vsJu7ml3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MvvuDtF2;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11555606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 01:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11555606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MvvuDtF2
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e9d7791b00so28905165ad.0
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 17:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793670443; x=1794275243; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0n9lMGW1sVKzw3HmKLjrZGL8pys2XInZez3bJmOScBs=;
        b=MvvuDtF2QUWEtPVt26mUsyI+vEiTKwI2jIqsyURw6To2Tg9/MIVQXdOu8eXhoK+TSV
         JJgHEyqpmo6BQfPcxM6elQlYleQCTndpHhcGnP2SO1TD0vhSahWPjzS9WlnTwoXvtd3t
         x9a8Ce2VhSzfYJxogcHMZJnx8y4rYZWdpZxP5DE9/vzSwwlLcPw7BHuu86mpFrn1n0+R
         AgmoDmJhlrRVyXBVDHCnr8LLcBdePp6i2q+lq31UbEfR1/CfIU6FNm+yizziSptG+PJe
         V8xEtLLPbsSI0YWZfI2qqfIorPUEcVQaBRF7MBGpUqo6Bj7ES5o8QuRM3naqqdm5fbGG
         tr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793670443; x=1794275243;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0n9lMGW1sVKzw3HmKLjrZGL8pys2XInZez3bJmOScBs=;
        b=gRiK4xLS9crU/geGMvypbAfkF6gcjC2wriojsGRAvJFF9h6RlECYshiEE9QyuFQ0bX
         p1o9ZRcaduqWRli13KkEq1G54jne4ppKRuwc1ttzS6QJTA9OPRrgtF+3b4B3SROHcNnP
         jJPkzScaWop26FYnoE5EvqP0OB2lrHsQ3viHO4LlVuyPi4dbOpxHxNpJyd1gyg67tgda
         ruKPXbVVYxAnJKtElFr2TalKJkkCceTJy/C4Z30ZvkDYVKbG69pWsikRrzw/+QmCCvOC
         NpYevR+IwOH15WfY3mFfn2VYt53OKVhqjQKf5jerPbbHBwYxvigtC4v/DHhn0IA3bOzo
         lZLQ==
X-Forwarded-Encrypted: i=1; AKwUvBwgQYCm1z3FpbO62zSdb5XVj64CvoreKVJebMmkW6S8q4YE6IkWjytJdwLVkIE3hVstTe8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JBcHXl8ztz1s0gjnceQMCvgx/17sKpetCx73QsUgA7uWlZw79
	Q4lRM2V0tnZxCuUZrp8PJXo1Ng0dNDAmqDaX9jSVxL6TTzrvOuVcQoap
X-Gm-Gg: AYBFou1SCYNU60Ic+LbGeyuQh9S9HvsHMVODvICmj7reFT2WjUPyzNdUuBgq2njDxp6
	LzT3KOktiownEAG3ZU2V2IUG6Yx7hDTMI2cmM2mN6HPAuq9LWlmoy3qSWzLJDUNxxVRf9NVTUZN
	hKtBiAYMz5gyhwRSAKiaVl7KyadzUnCKcxB9/7U69teJwYVt+eT3ELFtUJjS1QHRVLhiNDNUkQC
	hXLO7z7Id8osxFyxDb2/qU/OEdrxlFu/bzs/RG3e0kw5MOlDmACI1vSScv9qBZdRHG0rBOc2Tnl
	U2ZNAOAmvRtUEo6KDKx5rSGasY+y5+zgNVopIwKlJ/+MW1b/ZsadrxyQYhImXeBD1q0V4MSizja
	JWa354TxpzM14SL22SLVhGRE2n3ev2A4dv6qnmdT4IQJipq0iemDkCTeLuO6baqfqYk7qXhb8gi
	Q2jyiH6DFmZbz2UJxo2QACHO064tiugJVNhFlaKVxF2HCuZIeOlKsclCWwgDT/zoz3y5rtneITd
	oe68OauYLboSQ557oRVEaOc47vbOPYOMM6WrVKTpGqdzLcCQLOWV1MGryigeYLoCi12eSOV5+ey
	GXGNewpjaVkKKt5ZhGAegdFURWOBUWl5Tt6HhberI+F5sUlpRt5t2g1mDuFJxF7Vu4RELMWr4hU
	69FnQMi22ru01rFT+UPwmlS4wQeWJJA2ZEg==
X-Received: by 2002:a17:903:906:b0:2e9:401f:f0f4 with SMTP id d9443c01a7336-2eb364961b2mr122770945ad.16.1793670443134;
        Mon, 02 Nov 2026 17:47:23 -0800 (PST)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392965fesm33422135ad.59.2026.11.02.17.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 17:47:22 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 01:47:22 +0000
Message-Id: <DML73TNAFORF.67E0ZRLWONC@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <daniel@iogearbox.net>, "Tejun
 Heo" <tj@kernel.org>
Subject: Re: [PATCH bpf 1/2] bpf: recover page faults across all arenas
In-Reply-To: <CAP01T77fBRqfCM=VVjq0Vo8zFYzBLL9Adw5Wr8ar-fb862L1RA@mail.gmail.com>
References: <20261028015141.10710-1-emil@etsalapatis.com> <20261028015141.10710-2-emil@etsalapatis.com> <DML3ICCA0NOI.3NTJHPQB0ZF29@gmail.com> <CAP01T77fBRqfCM=VVjq0Vo8zFYzBLL9Adw5Wr8ar-fb862L1RA@mail.gmail.com>
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

On Mon, Nov 02, 2026 at 03:35 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>> > -     prog = bpf_prog_find_from_stack();
>>
>> This has to stay. If there are thousands arena. Above should still be a fast path.
>> Only for sched-ext arena access it should search link link.
>
> We cannot rely on this, there might be a different program in the call
> stack. That's why there is an equality check on the arena when
> actually reporting, to make sure it's going to the right program.

I meant it as a fast path, not as the only path.
the equality check is needed, of course.
A different prog on the stack will fail that check and
the handler will do latch search.
