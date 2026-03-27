Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529C339281D
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642252; cv=none; b=jq1VswPx48P/RVdcFP1z/OdvZOB11TjU8QR/RNH98g7sWrrUOzPaxAmTt9SA8IePLl1kFICiOjbcqKBJSLK/PHTYap8amy6K1kVv8sylXkONPQl8VTOIc1l1R+N0l/XAqy49ZEPprP1QADmb29uyGiMj71DbaP86UtoHKG75Eko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642252; c=relaxed/simple;
	bh=cjwvC6DpGB6F+IhwYTkQibnXoTgIlSoZ5s6FstPCdJ8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tlNlHoShOn8mzltEY2vYeeEEMG5hd6GakFjOWthaHT2l1Egr6mtj4MZ1/mvpPXQLruGdF/6B+LUaYdDZ8h9+yuorteEH/aLSXUZYCXdwr46wTibXaNRl85in4hNKxnr7RvKNJtlfhQQ1tqFhg/EYuW5PBdnCDrXEE8ymBnVhQZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=phsLI7Gj; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="phsLI7Gj"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1270fc2bdf2so2399c88.0
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 13:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774642249; x=1775247049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BQXMcJZlhgWXg1pkqd3gJyYMusvRkk8dxSKycTyHYB4=;
        b=phsLI7GjMIi97fRaf++H0zP5WbzGKFihHk/3mKSJc6mdg+N9uHXJBKOQSsARvKCJW5
         QJb3/X+SweFl54kfIwwWLwOKyLB/dXg0Z8sl9qQUse1wRel9DGivLfJj5V3uiKvL7+XD
         TySr2IeQe5KcLbbWaAMJ8U+Fa3AB7ZS+yZN+KYWgRCY66Eankq+4rm6twrGg8ATvmOCk
         GRKsTA2U8FzywK4skvtqQlahxbJcTzVXtA9DHOk/gPj6V5N7L61xprk1r5jVSFhmUfv4
         9YKFwnpCsVJcsi/8MNPW1A/3yApSGaH8yvd1ALdf19LjnOBcbQ5GGkczlvABFdRz/Tjz
         Y7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774642249; x=1775247049;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQXMcJZlhgWXg1pkqd3gJyYMusvRkk8dxSKycTyHYB4=;
        b=luQhSDetqHxWTXVfG6MeBLVCbRjqdYB0YdDXleh+wGTdG+DMujWOjFxe6JOFLPOmII
         kGm/yGFITqQwvlvjhD+szEznv2i1W0Bv9PKIt2w/wKQdOFi5maU6qFlxXVrbvyfXYDDG
         wYZKwaaiaXxOO3QAx2JUM7MkGlnjNhVCdnzR1NgWU7CdWJAyOjVJYemBaNimVatteLvv
         +U3VF1pwF1COcfK0/LON77Jard+KYT+AqEVVNGxFGOTdI9vNxucbNs2AbWmzGHdxozsH
         VOQl43Qc+sFuUNlCqDqi+kJgvRhD2tFah0bHTkKZA6cv+QSE3IjL5VmhRfVFhE8YbVoB
         Xvog==
X-Forwarded-Encrypted: i=1; AJvYcCWfrn+byKZGYpuv9pU9kb2a0eR89NwSFH8PcCuqJp2jWkyLTGWUMV1qIPFpZQT9nNsm6mE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7dCMLQ7lpOgO5Tu0snaHCUINRD5p3Q66OsaBJEV7n6N+CCqih
	AWzzDiO9VFqIUnCvO3YY2zWx7x099H6I78oaIJzWN/EwpqJJar/mrVp5wvIz2tKmoYE2LXq9J5S
	1jWY5Y+uyd7Y=
X-Gm-Gg: ATEYQzw/1aFisoTAkS51CnRJT9PmUYWMKGzNrNlDN1e14VWhau/JqscyyC9Srk38RPl
	tUddqGhaqclkZdL6tMunMZZBb7PMibo2mwCiIGgANELxUak0GecX7Too5dWBvnkJhq7P+92KDIm
	9lVLmWr/Xc4897k9f3DLUb4jIQaG1pccQ2yIt6+5DJBaP4eYDcb/1h2FhhH4wFYmk/MbYLLvibx
	NKsfGp/TjKyO3kzXyVafn3B1CMgVaqLa4EcVZUHSwPsoEIJwaHiLfX46NrzGvfnzwN4hXlrHiNO
	+6Nm0fth4NGoFwwyM/GAolp8xap6eOCU+wKJunyqTZZi1euc6nSYMcrYlo7Ja/F5UKyLYXMO6mI
	vJwhnrLi5mQsTxi6fTfcDgm+gc7o/vzZ0naJgYI5Po6MyxovZH1maxUPy3ITlP1ksMNUaYaAt66
	IOZ0JqS0j0iThzD8F3ef/BnDNoJcjgGG5e9L4dd3p3ETRWsc6mpbM/bVvA
X-Received: by 2002:a05:701a:c96e:b0:124:76e1:5dc7 with SMTP id a92af1059eb24-12ab9d255cemr1068c88.5.1774642248374;
        Fri, 27 Mar 2026 13:10:48 -0700 (PDT)
Received: from [100.72.9.77] (63-158-47-178.dia.static.qwest.net. [63.158.47.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c79722e0sm311001eec.31.2026.03.27.13.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 13:10:47 -0700 (PDT)
Message-ID: <1c7bfc3f-c327-4777-a70f-48144aa0864f@google.com>
Date: Fri, 27 Mar 2026 13:10:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] bpf: calls to bpf_loop() should have an SCC and
 accumulate backedges
From: Barret Rhoden <brho@google.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Levi Zim <i@kxxt.dev>, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev,
 Matt Bobrowski <mattbobrowski@google.com>, Josh Don <joshdon@google.com>
References: <20251229-scc-for-callbacks-v1-0-ceadfe679900@gmail.com>
 <ed857a23-bd73-4915-b080-558b5934bc8f@kxxt.dev>
 <79ac0188db82c675e62c36c8ab036b45cef3f3f7.camel@gmail.com>
 <9a418287-f8e3-4064-8364-ff85793de74e@google.com>
Content-Language: en-US
In-Reply-To: <9a418287-f8e3-4064-8364-ff85793de74e@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/26 3:41 PM, Barret Rhoden wrote:
> are there any tricks with this new SCC stuff to help with verification?

i was able to work around it, at least for now, by taking the guts of 
whatever i was calling from within bpf_loop() and making it a global 
function, thereby making the loop function easy to verify.

hope i don't run out of stack space or depth...  =)

please let me know if you have any other tips for bpf_loop().

thanks,

barret
