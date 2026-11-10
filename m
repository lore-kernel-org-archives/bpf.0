Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316305;
	b=HVL8OP+5K1trj84xvVsIFlHeNEZ02fa211GpgEi03wKZtnTLphubBdauOU+Adaw7sRUT
	 oqUYPGfjol+f6dJSgrfzOQrDYYUU5MuLVVoq6yA+Ka2n7d7luxhf5cVFWoBIsfov0fQ/3
	 vd9QpgaKG4bP7RKWD3NIqFJA6my/5w9lYrAuERNt6oaB2q8N61TQfC9G9/wAyVzFFTnRD
	 EC68/Xiif7QF97dWlrAUtUcmFj064/3aVNIXhdznSExTMhDlXywfmKbaD2LG1QB7Oajud
	 X6HrRrQedlYHK9ZYBfkJsjAeAkeNID6KXIUk886J06KZgXvh5T5vqnDw8mZkmtbuG5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=v/SgEZWrzJNE/7WZqBg/ymw5X2Lr4Ksekr/q2IUMa7k=;
	b=Lsj3gA+ge4gD8HiZqZrLU1LMzhRJ7yethqsgq8OB8JWK9YELryS7DoQ1sbUHSECAs+Tc
	 H3fJic4URK9KMZtbbujq5PZgu+4T7qdSCJQzTRCxqfckfMcU5skhatHSz7ppLGsWd5dT7
	 M7RLMrloo6a6Ib7mN2RNHhwh2b2c67Wlp0ZGDpxD9MGFajXtDHQJ6VWy0kd0JX7a9ec1S
	 99tF4zSDfkSZHlA6zxpvFIaKk56GIhF11UtFvHgRy2hLDLosOTydkaTsG0fyRimQYlpGt
	 QwmLHg/4q3c0lnFhidCZJbbtDjxQb9wcgK8BaKFee0wswR2s1JfUIwVYpN2S2yefb5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=r1B8XoXU;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B324F606B2EC
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 13:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B324F606B2EC
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=r1B8XoXU
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91ec14f4369so21015746d6.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 05:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794316303; x=1794921103; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v/SgEZWrzJNE/7WZqBg/ymw5X2Lr4Ksekr/q2IUMa7k=;
        b=r1B8XoXUdorHTQi31T4QZzQwAdYf3h4O94kZGC3jv3T+Jx5SRjr7FGsuqI5cXgJbuy
         a4Xskj7A4wrzvSdZS9DExIDq+xyu5tsy3fACq1w3Utv6FY5LAMCxJeTfUYkugkcSURlU
         ZCsjXXPIL/Z4QaKPsiHzP2lVg8s+DaMURXSk3YAO5StGiFfPs8XaEn7HvQAQmDVOxF0K
         +4cgcOZ4ZUGxBpTRrk2YwTXg3RkeaX+BRNaRbxPTB+Kw+TPgMU3P08XiJN88xbwrIvpc
         FnRFR4osjUJ354D/5xgkmgEk6S9jGEccJMRKmxluZ4XdNRRCNAyQv4W0zz3bSKwk1CMz
         suvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316303; x=1794921103;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v/SgEZWrzJNE/7WZqBg/ymw5X2Lr4Ksekr/q2IUMa7k=;
        b=tOEwV8+xDK/bCQEqQbr4j2ef3ezKBHO1tffOfGa/S3Hque5ORMwi/JIPK//cSlLavV
         IYBAK82tsPJENEFhX6O2QRy6v2qg9aHmSaR+Hg4Bl/shWftwY7N2tv+V+2rvahk6h/pZ
         zdVpxwlvJRQ1sLQjjkcDTPec5k5fNyNJ6w9TuKfqOnun22QnUzSZ2jlgDan7zlZknnq5
         nNx5jPOEIFlYkb/PED5vhL9oMqKytPoNz0HaBM4BtUI9fBpMs1UyQXk07b0Lw7lGyjQE
         Rwg2EJAIEPpfO/kg0XmXw9h6N9vJ4+3zcGdCx5KYH67Y3eShu36/o9cK0Uwly6ayDujR
         SqXA==
X-Forwarded-Encrypted: i=1; AL+hErFTUKy9LP1p5eV1LMQiOOs12fF0S4KhbhI/g0jraTpzlc/G24x2UrBYcgbNcxvGrdWehUM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YQPZFFWkZghrXLp2w+43H4kpjUxHi8T8xgdwz8l3UB2e5Ct92
	tNvHdFKqt/4EHExnYoT2y1Jak6lJb5UhRZPg1W5lG4TCIjwgBLNmnyvBG7UWdJzH6GQ=
X-Gm-Gg: AYBFou1TbbDKc1UQBkgwkapxF5/fdcrFqo92ohbiueYHW8cPZcyhyNXKijdfAkC4jW7
	evXHBr2SGriaciFU8K6esYWA/4IISFvre7b9ptWWFffRCcErFLfqTftor8vOC9ZPmf30hPZuLoa
	ffdDkUY2lJmIOapI0BPB68RVGVvgXqxRHwuDEjAQ0dkE7kHs3lbpQ/97BVQhMDnm/q0C5nFNO/k
	EYaI3r3C4Omx1CrVCAD/cwR8ycRDbQq0+e/CeJfm3novpK1lSwk4TeOi3inOBie9s95HydaXA7h
	lEIB2szHYMQ8JkIORsS7l3FloKRgSCMTu9EkvqmVOjrSO0ATWg3sIYNdmeLqAQD390+sb8EAa+m
	UcSfEOgGUbOuThxjiyQPvL+tAIE4SMhXH2YPg/SJJZjLq64wRYIaLb7GH2ysB1haZT0+aFDPRNA
	5YjA3MwQAXQ2+q6ZQloKyQT8YDaGqkVlFrzkYZO1r3tmfMhCHf2LPDEOTdoZSkDb/69j+kBRXNW
	XmTULy1sKXMVgV2ccxrUbzBBS5zSo3aCLiM2HfXVpeiMpyjI0yMsGV6HXkJvEhbqciEVjx/u933
	TebvtHrR3B2Zfl1ay/V9S1YNc/6zzkD15WIUa5y+fSHmrgPVQNy8N8Jnz0Q0/T7JeM7+K8JxdjS
	I4POcSi4=
X-Received: by 2002:a05:6214:2266:b0:91c:7a0e:3385 with SMTP id 6a1803df08f44-91eef9b7adamr41656946d6.49.1794316303415;
        Tue, 10 Nov 2026 05:11:43 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef04ada03sm20492646d6.7.2026.11.10.05.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:11:42 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH bpf-next v4 1/4] sched: add helpers for numa
 balancing
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
 eddyz87@gmail.com, memxor@gmail.com, mingo@redhat.com, peterz@infradead.org, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org, 
 akpm@linux-foundation.org, david@kernel.org, gourry@gourry.net, 
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, shakeel.butt@linux.dev, 
 roman.gushchin@linux.dev, yu.c.chen@intel.com, zhao1.liu@intel.com, 
 tim.c.chen@linux.intel.com, lizhe.67@bytedance.com, ziy@nvidia.com, 
 mgorman@suse.de, bpf@vger.kernel.org, linux-mm@kvack.org, 
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261110032913.71974-2-laoar.shao@gmail.com>
References: <20261110032913.71974-1-laoar.shao@gmail.com>
 <20261110032913.71974-2-laoar.shao@gmail.com>
Date: Tue, 10 Nov 2026 08:11:41 -0500
Message-Id: <179431630193.789062.16833460142171738145.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-10 11:29 +0800, Yafang Shao wrote:
> Introduce task_numab_enabled(), numab_in_normal_mode() and
> numab_in_tiering_mode() to replace the direct accesses to the
> sched_numa_balancing static key and the sysctl_numa_balancing_mode
> bitmask.
> 
> No functional change.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: David Hildenbrand (Arm) <david@kernel.org>

Agreed with Zi this can be picked up separately.

Acked-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

