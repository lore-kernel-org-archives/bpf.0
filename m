Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14C972623
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 01:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770169968; cv=none; b=XjvGdF7g/IM1KAUKxvnqIEGAYtnFgJoIwH7cxnvU+v03nsaWcd1w+xYUD1xIshul18ALECWEXO0zLrl3N1UlctbuJEWbuxgqgM4BT3Lo5dzpHHZsIH1/mdBvSGm5hAi0Cnc6niuA7UW6mgrks2PYpi130o1cHokfMo46hA0lA+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770169968; c=relaxed/simple;
	bh=xCzE0Y3OO000bosLJmxcX1n2MzMgRCxF005/YWzI5U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jU6YcCxsN22tJ/x10IxUWwHFIs8k2Rkwwt4WkHck2UA96IlsjASeP6I1DgHLZ/TW8tHIPNjZpXLTKtuSxXFRIlaLrf8rggtnphEPryVJTE1Ybeztc+FsWoAXu8s1I41O5dcWfJDzW4QRR4sqTCI8byNH1u1UkVpHJ+7YSj/q2U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6Zr9sZk; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6Zr9sZk"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b71320f501so3249920eec.1
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 17:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770169967; x=1770774767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aHB0JlFtO1wcn5puUC4vdonwKeMokaoWrp5YTUAcgvo=;
        b=K6Zr9sZk0fMcmAPY/R5MlFCBHPmac7sIwRRVnUOc9CXqpYM2J5wEh7ST/8316vBkLO
         45HelDJq6eZp2vAgtY4XzVzY1mQguiEzCbtE7ksmpD32SqhKLnP2QC7/q2JiBLcCw6Tm
         jW7PMNBAQeIfvlx44CQrjh+qkpRTlCSLirxp8PCjwlUCewzEfx8cJUMI1Jgzgk557+fH
         +C+jeVms+3Qye+UwF7lpDVOHtUi7TTBpZEFI7d8Mg3bBJNFB84XjJwSDbVAafdLPUszB
         Yxgdas6OESFNbK/RsYijEEYy+To8bQTsIYTYSRbKvn3GOy6uSzBRHVqTpuRbSnzv6ws2
         dS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770169967; x=1770774767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHB0JlFtO1wcn5puUC4vdonwKeMokaoWrp5YTUAcgvo=;
        b=dIStlzl7t7G6prB1YUiAlI1s4zKzLyUKMdHnilI7xDYFpAZAQchANUJNe2GKERQFl+
         yPTU3YS7nIismGxFifmSiDCgawkPFPMBR68NO7DNy+uiA8Hx97Ki1uxS2A81sOBLihzC
         as4i7U3Tl+Eubo5+/Sb9fc90iVMiklxfCMr7bKTbFn2TDjyXK7rCYKRfqJgito53hILF
         MKgjw7e4wdyF/r6kyHg8CyAVMUfFvdlxw6Mc22DRTsF8lOhK78KKZtV7zOXwtnhSbum8
         d9bSE4O4GYTCF9V0YijvkQD7BD7aTHyPKq3SP66Aj1xMLaPvF7nq/849BsExTftnLS+L
         kEYg==
X-Forwarded-Encrypted: i=1; AJvYcCXbc621vBRZQoh/jPZeXkCWLMYMM4Mb+XCG+LywPdENTFaB37LghZ9gWE521LEdKko3ZPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvGudq4JXUw/cztQ6O+W/SU3lFWPN0hxqqwRGy8hlqw09Nfp6P
	HP8cssQCctOVlzItXboMkQxReK835PMab+PPJMyRpGILpFqFF69EJ7U=
X-Gm-Gg: AZuq6aI25BgchrYoo/+VTl6SY2isd4NxmycvUR7uzfIlSN1bgZTSmM9FCW3HFVa2fxj
	8ZNFwk6qQC9sKwRAFkSh74U6rCLoyIfNX6hIw0i2xn8QjAS/f4/hi1vBUcR5CriT161H2MQtqPi
	N8PINBoP/PuO5UpUz54qR7t8VS4XjLwLdzGjr+rZk2fiSnzNOyjxtYpVdVwvR9DbwJ17jlnZilS
	iq2AfenPJexW72oYCYPFkOfre76pOBSG5o6tmbTD6vkDYK8LZm59rV4yU5AnlLoUG957yT6ZZda
	kfn8y0cmKaw38yPHefZAftCR/SHm3UsKHaCXNl70jrL86zfSo6G4wHOYpXVM03pnjjIoiQKEZfO
	9iObQ/clgpe2lrHolDNqeyIRNE5oJGsXAnw5fUihxFCSsnKqQzWegeRH0uxwwI7LLa2KpZfrCMA
	v8Gpstn4Vk6D92C1L6PLB7J85KIkujnws45cEd5z3anZvQI4F+x4Il0sEe642x5BEYM7ALHSYsM
	ij2uA==
X-Received: by 2002:a05:7301:5f89:b0:2ae:5fb4:c5f1 with SMTP id 5a478bee46e88-2b832a563cdmr648161eec.22.1770169966539;
        Tue, 03 Feb 2026 17:52:46 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832e56c25sm731551eec.14.2026.02.03.17.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 17:52:46 -0800 (PST)
Date: Tue, 3 Feb 2026 17:52:45 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 0/2] bpf: Misc changes around AF_UNIX.
Message-ID: <aYKmbQ5tU6ClZg2M@mini-arch>
References: <20260203213442.682838-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260203213442.682838-1-kuniyu@google.com>

On 02/03, Kuniyuki Iwashima wrote:
> Patch 1 adapts sk_is_XXX() helpers in __cgroup_bpf_run_filter_sock_addr().
> Patch 2 removes an unnecessary sk_fullsock() in bpf_skc_to_unix_sock().
> 
> 
> Kuniyuki Iwashima (2):
>   bpf: Use sk_is_inet() and sk_is_unix() in
>     __cgroup_bpf_run_filter_sock_addr().
>   bpf: Don't check sk_fullsock() in bpf_skc_to_unix_sock().

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
