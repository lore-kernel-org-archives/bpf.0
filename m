Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D32F439327
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386956; cv=none; b=hGjc1c65rxAlmGU0FCFBTLf2Gv2g+EFS+99Zqafesqkdt/ca6aNUPsrA483g6zxx2u4r3sFY4+yNfzc93dXyQwGKMyydx/aLg1V7Pw+q1It6VWYKXSKWkS6zDssSE/by6VexGrWfSvP/X+meVd+OGpL29dhfzj2Ap9iiI112X9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386956; c=relaxed/simple;
	bh=u/ZlLPGpmJ9soPTzlQec+KW0FcY0DZEckmXLcHjc9wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cc5rn1vw1CVQNxu4SpIIsMlcdDTWpdYaHwRNK1rwMt9EZTUhYt0CXrNlAlaV+fjd65vkpvV6197DNS9fM7gs+w5MOevGtE2EkpaortSwDj0HNSi73EzvSqMWwmbg7swLEOFFSLJi1E6a1SqckeJKuGB9Pm+GucTBgnFK+UEmk3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoPAwQ6F; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoPAwQ6F"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cabfb70501so6608475ad.1
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 11:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786386955; x=1786991755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+CgjfkJ3BqGdDD31dfl8GGagAYvFHOGZHmn5T8XCVl8=;
        b=FoPAwQ6F6Q5win5tViTMVav7TJyPFgNB3KkjY++JRgNnhUy18h7x9oinC33ETXvEmi
         f4o0+guqe+KErcw8OLUiwozWMVW03H3wPxhFt60Rknr1uDp+wPNSgFfOhKKOkiuch1nz
         5Cwy0ybE02G/GNlSZvBzd/ELX7DcUo4fRCB56Gpt6HKnHUn+ZfhM1PsT/7hqwzBaHmxg
         ZEX1lgoyUCPjc22x2hd6n2wUGcZegDiJ5gr2XBvYKgxVBMIweOAlIj11XFHdQ/cUXD7n
         7f8QotX0k58jrEqnkgyDEgUb36x/hhnTQzzLbScdypCJIMzUO2K0VRQCmkX0pSPh5UWX
         tEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786386955; x=1786991755;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+CgjfkJ3BqGdDD31dfl8GGagAYvFHOGZHmn5T8XCVl8=;
        b=UJLm8rrXrSqFvskGYxZ0jpQlh7p5Xx3AM9dA4YeGOauIj9gkxYfNITTPr9OrNnMcsI
         NL9gVHfu6g0rOrs63Bj799A3CHJAVAu1ADUSh4qhM0IypEU6znE1OePtffZi8G+Qwyaz
         4DO4FUXeJd+SXKDaqdZHfv+vS9CGL6rkO5UOGa8a2FhzdetqS+9+CBzYX8pBaa8aghF3
         mjC5URZpFDXnXA7UPzUIuD+B2NRFlBX3ai3+EMEXV5Qwdw9bDnI32a/Iawb7sBobCfcs
         9SzRJrYZUypMqjoAeylUsB+v2694RJg34CRnbimCRCc/GBkAFa7+hod7kanfFmK4Ujz7
         c9dA==
X-Gm-Message-State: AOJu0YyLpWXFIoxlhezgE4rKjf7bC9vZ5ZByZMsbsHOsBHfARgwJnKE1
	6wQeWp+coNwPdJSPnyaG4fD5xyf3xd1QGV4ORvssSkJQhsvxu89Lwyo0
X-Gm-Gg: AR+sD11U9Pnkt75Q+UmleNiJceBEW6dSZmYhq+GLwYVKKxuxPBZD/akp1qD/glQJ8wc
	zThrXGVpNN209vTAo5bcVR98vuj4amuj1bWXtjhB/74yuJMnd3kC2hgJceQGibEMaG9dCyF3/6o
	FyZRKn/GE/yqttjmx+qhUxyzZcYuBGyTk+JHwiu0E30xuxpgyDBMdU/rd03nIP71OaxHSXqi7cP
	LMiIIu5OqOJbvpYou0A4kCwqAB4kICpkwHuBKt0BCwvq+hD/ScrqpCQ5wsOhDao1RO4DNJjxpAk
	JBmkB5Qw419TmzAtOTexQpmEDdr7eGWuMoMX3kGNw/Y5fwaXtnhoAmFPLN+YBnpBzaOVoOsmeZP
	0WYPyM0wRoL2gjmS88T6OyJzZ/mfqFvgVtACLHTuvigHIkVNjhGPaYINMC1cerRVkBs9dqOHLnt
	AHYoW6PUkYZ0GDXhki3BWJ6Xr2vLRKW6kyzy5c8k4rEJmPwwFKPgK6wg==
X-Received: by 2002:a05:6a00:908d:b0:848:8027:cac with SMTP id d2e1a72fcca58-84f9c9b680cmr4243488b3a.23.1786386954840;
        Mon, 10 Aug 2026 11:35:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a3d32b6sm4370238b3a.13.2026.08.10.11.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:35:54 -0700 (PDT)
Date: Mon, 10 Aug 2026 11:35:19 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, liamwisehart@meta.com, 
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org, 
	ameryhung@gmail.com, kuniyu@google.com, memxor@gmail.com, jiayuan.chen@linux.dev
Subject: Re: [PATCH bpf-next v5 3/5] selftests/bpf: Add ksock kfunc test
Message-ID: <anoZ30uUOEvaOj8j@devvm7509.cco0.facebook.com>
References: <20260807171532.125149-1-mahe.tardy@gmail.com>
 <20260807171532.125149-4-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807171532.125149-4-mahe.tardy@gmail.com>

On 08/07, Mahe Tardy wrote:
> Add a selftest that exercises the ksock kfuncs end-to-end. One syscall
> bpf setup program creates a ksock context and connects the socket.
> Another LSM sleepable bpf program looks up the context and send test
> data. The userspace harness creates a network namespace and a new socket
> on loopback, run the setup and send syscall bpf progs then check that
> the userspace socket received the data from bpf.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
