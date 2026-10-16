Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA37649429A
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 23:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792194283; cv=none; b=nhxjZCk0XyO8izXvv2SLx1atKek1AcWoDRnd8qb97PQtiE3qLDYaqAGPeNnwrvInZ9oMZoEIA9yAka2CKDW/sTeGjLvOPbHpg43UUvrgUmn19FHklWlFh5KLFcv90GuCCyMF9d9W8+lQNiJMMk0lADRZgfv4T9N2XQ4KMhqeODQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792194283; c=relaxed/simple;
	bh=CmeRw5+WUgSKSINZPWvg3oa3A7BctId2SJ83EFr0CwQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=AUQ1uO0sh7rbUZJryzq5ZHhjO9Y4oDalr2Y8hcU5TrreaALlLXpfc701MyL+gp6mysbE1IpdypZF7DJwiqqcFJ1yIQKufcRPoVNWzJUl8Kh9YYca5r1tfOA4hdOD82jd4LK9RF89+chGVYLZHpcxVtgwwotlmWZ/ji8K9OmUn5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nw5fmf5y; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nw5fmf5y"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd5e6f0a22bso242421a12.1
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 16:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792194282; x=1792799082; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CmeRw5+WUgSKSINZPWvg3oa3A7BctId2SJ83EFr0CwQ=;
        b=nw5fmf5yzm03xj3RbAtXq2lR2HJ39tb+HbuO5PgFGeb+vYDdqZ24PyvPG/jxLjXX0N
         XBStb4OHviDtEO2strMGHRZQoKGzyae8uw2y0JCFN0niuzY+GJO/T1/7pC+8Z16ZHXDg
         i7lvOdigJNB5vxJuz7sKp2cknav4KOjXpnprjftqlHc9n9xNrKh0VBTffMhk46AnyJa/
         A1OOGlFrd5+wqvmQ7imq3/QRMlOEuOqQNPrDqzJvsr+WD2cAajIsQxxD3QB/gxFShOhu
         pNMGETMOLVfTTLHY9H6+H0fxfJQ1B31yZPxpN0eYGti66wk9MPKg+SC4qg1I1ABjReHn
         Lv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792194282; x=1792799082;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CmeRw5+WUgSKSINZPWvg3oa3A7BctId2SJ83EFr0CwQ=;
        b=sdKSg87tqz2TSxH6S2VeEwlroEbxUeOEglJXTPcjNeGTk+zKpf07wIF0h8XWaZRofC
         vqusttpyF02ingaNxpE7VBsc92LaDPYoxpkY2QL37O/h8mdNbxCUMizC06QvIAlrHKxX
         UfdSFpUlyN6DWK1+eIUdYs5rHgG1ze17rpuPvC7Fiil6OoP4ZUfnec36refAH+q2kfNa
         YmzYPqB0GzkOZysostXLI3+duEAA6JlEbBTXa1OWmqoGF5yjFhOMxHBpQbpKUIxY+MIp
         S7TGxTmF7bNd44mw0FV0kL6Lb8g9IzrJQnutBOeOL1lvqhALQVdKSii+pirDnZjSIr8R
         LV7g==
X-Forwarded-Encrypted: i=1; AKwUvBy6EQzRhRF2AVwOgMq4C4uaE8HVCXoVvernA1UiQ6+lUxz6Wrq5SOIvSNp45mCc3fwWIsU=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1074p70KmCnb7nP0fabEf2IgrJnXA9G90+a6FcImy9fJdkZjF
	4/LCjHFMNumS0AyRWaILoZAdtrsBnkzBUyBp1RZFKY52CALM6rPF3PVumZzLGw==
X-Gm-Gg: AYBFou2/EyXcUPrFi11tEuxuEb5UoAprYn+zlCpjpmMH50Uc2y4lyU+rBdSdWa20XL+
	vgABw7+AsYRSsdquHRtlF91g7L9lj1qEGKzEyd2JgyN2BuRJwQaVywpjgx8bUZG0JLvwIv1hmEH
	53FuP5Js6tHcvdLGaj41h0+avS368rOsk3nBQlXOZpnV3o7h+PZ3CdYiHXkI4mhXuRfJBbEPf4d
	KATqaW6MRn/fMcdvrNFUEOq7mw2NLAET7ZJBgbJVR03+ZrhT+fMax7M68NhbUme1IdFg1yJG/dh
	tzNz3e5Euy+LF/vJWfIw+p1606Xm8j+Ua+O7xVWSNy5AQod5gVSaieGVlqV5nqMWDX+VqCavmZs
	Wyei1pJvbBXs6DrCjvbbPfhvUr9dOT/BSP63tOei9PLwr2hDzXbeRXu5+1P0cUTz61CX25ah5WO
	x9rkxMDgWYWup5+H4YHdvyOFU/AAdJtA5kMsz1QnVq5Fhnoe7ZFX1vegjTbUxcQ8wVuKIsnIcNb
	Phwzp2IQUJf6MCK5pG28a2r8SW45ItqpHZIVsB8pslQoI1RSqwJpoMNGT32EIUsdJKtgQjmhQ3t
	xwM=
X-Received: by 2002:a17:90b:4fc5:b0:3ac:aa8d:19f2 with SMTP id 98e67ed59e1d1-3acef5e0c58mr1042419a91.62.1792194281950;
        Fri, 16 Oct 2026 16:44:41 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc492fa54sm5918306a91.13.2026.10.16.16.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 16:44:41 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 23:44:40 +0000
Message-Id: <DM6NUM6W1OKT.271LZCOD13KT7@gmail.com>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v5 4/5] bpf: Retry arena faults when the arena
 lock times out
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261016193703.9203-5-emil@etsalapatis.com>
References: <20261016193703.9203-1-emil@etsalapatis.com> <20261016193703.9203-5-emil@etsalapatis.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 16, 2026 at 07:37 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> timeout means either contention or a deadlock among other CPUs that
> the lock broke by timing out. The faulting task holds no other
> resilient spinlock, so it is not part of such a cycle, and a retry
> can succeed. A timeout should not kill the faulting process.

was it found by code inspection?
if so, drop it. looks theoretical.
