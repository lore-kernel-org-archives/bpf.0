Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944D85221DD
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202909; cv=none; b=m+wWhRdUYINxQIha6bvNNnMzEg9wM/I9gjG1N513oDghNkJOt0iwbto2DCog8n9H5MVJvDCU8I/0C5Qlx6cT8p3mH7bZsFAy2lRb+dcz/HkU+9k3byv19Vf1LHamog/oioChEMFA/hUcVgN9KT9h+2jjV5fGvSqbs57RyJSO1sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202909; c=relaxed/simple;
	bh=PwlkY4zuL9pSxrZJeDfqCxHfkPz9VjHXiQ3Gt/4J1bk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RcG57Z4ImO0O96y9NKaChMRZjVZr/kKNvnsst1OV1lTGdjN96RjGs+4J7e8JWYgY2fxB2G5LxReGCMCrkmZUqtidV+PId0aww8frEccxSemgpeEcE1ImFVnX2rmdX+FkjS9BJmLOZ4vTZ7U1EH6loQOG+tthFwOr1zNGhQYN844=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfBL1erY; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfBL1erY"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664e061cso1536899eec.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 15:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202904; x=1790807704; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oGj4zFwYkPIDIGWCGS2PIo+cvVUIpvRcs/xdF4x1gNk=;
        b=VfBL1erYUwMpoITmWooIrp+UHnMjFeq3MSWb5NnBcK9sRZ0a/WUdgYXGh9ZrXyBcs6
         OLMHYl9g1jh/6oE5Wyn0/HHu41YWtJCCvYg94voSeehuvMuvuufhaNgGjOGYpNO0/+eo
         HdSXpDCva+Lfcr9OE5fRZ7+GFekWfIu6fIBct2TcjZCqPw4jivlVmTt7IxucBa0lphMq
         srsBHncgEylI6egB6AKh0ZioP7ako6fUqbert8OFXQ2ZMvJtNi8Xqv2YRamhgZY9NQbI
         0MOLnOtJZBpiGD+nH4obVvqHLxJv9oaYBhFNeklJMA5nMWxVuUNF0av0w1Myzhvw/tcQ
         NEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202904; x=1790807704;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oGj4zFwYkPIDIGWCGS2PIo+cvVUIpvRcs/xdF4x1gNk=;
        b=vXKHZ2SKSN2dHXZX3Ubyh5T5mbDPpWk1hmhlHMAkD2aUERArk9kxKia4cnx541nTVu
         ko8zz9ofVAoNG9aab1/v6wAv/bFegz9mJSstQRPQZrsjVQ9siGwSuKQRgtuEBI+5PETZ
         VwtLIr5FlSqzVlUPGgPEBPStv1Nggudn98YzPNSTzwG78lcvlx+8aC5Y88DLvZOm8ohI
         6rKzVdsUCShaXsxUwhhW70Dfm9wHCFvvF94awf0xgDUF1FPH1LmJpv+n53tIiBMbnwVK
         awcdC6YZN5GAMDd8cdEUM6AF75xDd1GMkL44on2R0x0Y1UdrX6kO7GvvgbWtltf3wauw
         fIqg==
X-Forwarded-Encrypted: i=1; AKwUvBx6Z54GEMMGw42Gc9DndRpH0ckpFy4FodBjv1w6nYDVXYE+dwYbrrNd1dpdrwbuMab81qk=@vger.kernel.org
X-Gm-Message-State: AFuF++n/hcpsvLf4zjLbh0A9/eImOlkGTvEfZRjpTW0YERt7bhFwUrOH
	oMhtgulZT/jcQu1U0y4jqxagnalCkyr8+Io5R25Nar/+YQ0SI6tt46GS
X-Gm-Gg: AYBFou0ytuuqSQYKOxz8rwqR2YbPvfCLDN6DRjcIuc51pIVvvDfBub1w+Nl0fmnd4yU
	WRs/QpDNLHfobr9HGywPIr+yacwMtmzqbFcx2LNjohkk/8oMWQAmjRtHTS+Fbcx3TG+nYtkBPxH
	f6GTucb3jarZoKIE56H8KnpVppJBELn+s7MFYRK2l6FU6F77QO0kpcjYL6KOdGLCdhXzdIi6l07
	jQBG5PBrlnlHOAzPl6f50rwKm1XVth/r5T/4FeZHL3zKDvoaegIoGAeeuarwCvkjgE+mG5Y/Xdn
	hoqHo4eTFIkexEI6O/bHY5BMEknuYA+tkTC3Xfb0ESrin3pXlya3QNrn16Sx1CDJAnH1AkgFio8
	SMQ1SlnzSZKSn/IeV0y//3HtVMObJYX5RqVApBGd+lYgW40YLOuD8JjYehZQvfEtMmDGVrywkUb
	1asd4cllmj25LLOBsp9XkYJezY9o28Yc/9qBqfDNpACihCgKO8+BzPOtO12AhqxjAxGZcj2g7xn
	1W6KEwsGEdX9Y3w9YGGaAf7uiYnS5B2smtZxqzbEOop8PTQtharUFrlY0Ujp9przXYD
X-Received: by 2002:a05:7022:5f04:b0:144:f4a0:a399 with SMTP id a92af1059eb24-14503f2edc2mr404471c88.1.1790202903852;
        Wed, 23 Sep 2026 15:35:03 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:179a:a128:9d0d:40be? ([2620:10d:c090:500::5:48f8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f986e465sm8541553c88.9.2026.09.23.15.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:35:03 -0700 (PDT)
Message-ID: <c90dc97e7ce0362564468a3604acae7b942e4623.camel@gmail.com>
Subject: Re: [PATCH bpf-next 01/17] bpf: Fix infinite loop in
 check_max_stack_depth()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com, 
	a.s.protopopov@gmail.com
Date: Wed, 23 Sep 2026 15:35:02 -0700
In-Reply-To: <20260922011323.1298619-2-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
	 <20260922011323.1298619-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-22 at 01:13 +0000, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> sort_subprogs_topo() rejects recursion via direct calls, but allows cycle=
s
> that go through ld_imm64 BPF_PSEUDO_FUNC, since the address could be take=
n
> for an async callback. The main verifier pass limits the number of frames=
,
> but it doesn't follow calls into global functions.
> So the following program passes both:
>=20
>   static int cb(u32 i, void *ctx) { return foo(i); }
>   static int foo(int x)           { return bar(x); }
>   int bar(int x)                  { bpf_loop(1, cb, NULL, 0); return 0; }
>=20
>   SEC("socket") int prog(void *ctx) { return cb(0, NULL); }
>=20
> cb -> foo -> bar -> bpf_loop -> cb is unbounded recursion.
> check_max_stack_depth_subprog() walks this cycle too. None of
> the functions use stack and the frame counter is reset by every global
> function, so neither stack size nor frame limit is hit and bpf_prog_load(=
)
> spins forever.
>=20
> Reject a call into a subprog that is already in the chain of callers.
> Async callbacks are skipped earlier and are not affected.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
