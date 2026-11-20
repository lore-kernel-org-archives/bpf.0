Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207336;
	b=imVsPOwf9ItG4IT/f8p9XYBhhpqdupB0aXIdij3C57KysBH+R0DUky9l81rUXqSetRV1
	 Lsuw+dsWTM15L4UK0J/DWhc2IMkbQmDzMzu3V3JElKCXNI9nCkfdnjPJ8hhHbqaHIbHEv
	 EPkJbTXtK/O9zZwE/3na9PT2I0bsOiwYm4XUdHD9Ar0c16FUjNUuXVjBvzbhEs/1GTC/N
	 37g2jMWcODcrPRAIA4HWxf7neorjXpXXJwKFM4gJKVRgBBjityduGSk0ofd9tcr7S5yZC
	 PHv93r44FbJ280JKCuvqMmk0hUqsOVMHU6wjPuHUSg+EOKIOiZWn6AlAVE3VHnjmqpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207336;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding;
	bh=M1o1LqMhEI68Ps8j5jmIHuqxqlG+VGNC6ppq+rvyi8A=;
	b=AhDOBjr+bbTxzcfiT8ClFCGJOgmSaRQVW3xAdj1/ShiH+nF6t7rKVafbiCA2VQQ6AZd/
	 OnWKZENyKHdYx7wphAfndnFK7A4UQ45DgBDCjWvSsg9VYE2Dt6wyPOlCIkISh0Gq1cY5u
	 cxApppX+0yAhsx1Ttns2+L53FbSeXESJhXqe5fcQWTqhiRWKDpaHKkUzMWFbL5Sybxv/l
	 cwhVuWVMrKaquMWjcZeJfFMEGYxySA6vRNmODGw4xDTc2FDZDcnj7niQwjcsS94Iga3Wn
	 xynKflbufuH/llGRkyxesQww9cgXvwYCijtBSu/EL3ODH2maqZlPe3rzriuqy0zwo6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BEC606A6DE
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55BEC606A6DE
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9495f083657so163321085a.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:42:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207335; x=1795812135;
        h=content-transfer-encoding:content-type:references:in-reply-to
         :mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M1o1LqMhEI68Ps8j5jmIHuqxqlG+VGNC6ppq+rvyi8A=;
        b=CqF9UfoU9J+I0YPvxe0XxbZRWl0LRKYIXRMOyvY+U7OrPkl30DzWm1VrSFkkBY/t3N
         DrGASjOt7J0wY3z/KofIt88d3P3Ue0kCG8xZN4PoV71NPjydFbb51ISknZljRHOGasmG
         rr3/8XHGJmpwj9CRHq8082lzvjN2+sPqUBeUYUm4x64FpIuDHi48iAKiyIV0xE63aOwa
         BCe9DPP8MhSlLFXfd+sG/PGzRyeasMI4fsYsrZnhvLvSgRUPHLzBVehQ+nU+izsHscLh
         kF2XDpc52sqx+B6YBdAvAjiDIl/wGdzgVxuAmXq+8YI9gl5IfwOSLLZooLqe2q+2elzD
         4SkA==
X-Forwarded-Encrypted: i=1; AL+hErEjkkF0qP/X4sNKoEX4xGv9sulM9XshHI1abmKrnuNF5OdFWT0u4FBO7AwlddM6EVDwOng=@vger.kernel.org
X-Gm-Message-State: APuU4Z9humEeoW6EsyjUBvldrgQz6RtrJd98KWaJcGccRHCqHBBm2T6F
	QiBhbEhk5bXb2fFSYAHzbUY3yVSc6UX0q8/izM3hOxm4AgXvcCw29ZJa
X-Gm-Gg: AYBFou1GJSRkiy1/sypCpM9MTb1d3YZujruUZnHNfplsMp1FqjHPNTnzegyN/ZBMXL3
	t4Ra/0Sj1Ias11wJeZKXJW5YTC/oBfjQFR4TjvUZfXUgqzlFgDuq7xxMJbUyDNaV3LtljE5b8ck
	AFjqziz1aZAPTt+sx3Ky4zbQqxxM/buZmWqGVVgdFPcz74Q/KnfTcupnf3MsCFs2f5nqs63mCzd
	Noy8pVqJqvhmMxZPCQJgMvUh8FLKNBpBdzwe7+0u242ZKxYf0LJHP9kUkCIktYM6L2deFahnxBS
	iboZknoGl3hshkT3ErYZiC6qE+/0lqjAFhzHYNMBxduo8OJO2yYsiveBy3hcs2Ha3XKrX8iBD9O
	x6TqXM2vde3rudtBYNdTK0ZSRET1t/bqrKnR3QNDpdzXUlSHtsOxJCH/WJ7KEvE3+oznlpislfa
	9O4iIHB6M4/c+0J5Zl6EJZ/ZIGLtptbhwsElxTEhv91Kw6/9JMSNwoS/xpxgtOovSbpudajONMj
	FXXtDfXiLwui5B96s3s2aY7SGUXc/E84rryRb5FtE6t0OBk1NrmeI2aNzAdW2iF4ZyjfunkqLYs
	nB99no9Mmv1+UKWP62YCdmkQ3IP9h+j6Z50WHPG5itvzLO7AHhohY7oeRXsoIvpxhW8aUFvtlRs
	KEyxb/tA6uSdkYeIueE6V+yxZSZUCRV8vpIMgf23+vwqnA99v/U89
X-Received: by 2002:a05:620a:f0f:b0:949:57b4:388b with SMTP id af79cd13be357-949bab0eb6cmr787060585a.41.1795207335160;
        Fri, 20 Nov 2026 12:42:15 -0800 (PST)
Received: from localhost ([199.170.132.196])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3f5c31sm278786485a.30.2026.11.20.12.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:42:14 -0800 (PST)
From: Tamir Duberstein <tamird@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH bpf 3/6] libbpf: ringbuf: Handle position counter wrap
Date: Fri, 20 Nov 2026 17:51:54 -0000
Message-ID: <179519711425.18576.13916601537797650655@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <DJAXGXLF4NHZ.17HAW2R1YDK7I@etsalapatis.com>
References: <20260613-bpf-ringbuf-fixes-v1-3-e623481cb724@kernel.org> <20260614020552.022A11F000E9@smtp.kernel.org> <DJAXGXLF4NHZ.17HAW2R1YDK7I@etsalapatis.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> if we're going to modify one let's also
> modify the other.

Both are now fixed independently by 6ff5b56a50c5 and fdd4fad0bbbd.
V3 drops the duplicates and retains the user-ring drain fix.

> [...]

> they're a bridge too far, we have to draw the line somewhere.

Agreed; the mixed-width ABI issue remains separate.
