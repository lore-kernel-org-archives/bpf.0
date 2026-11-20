Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795217031;
	b=rPTw458iPrcsGUH9ov9QSkasfb91ZV/m5EOGKtYpLR1aZo6L9PVj/iuSY4gwdvWOo6qv
	 nRW0OquBzRiMhuIFqmjFv6ITsO6DpThssAY23hIJ7oimA7nDLwWFZi3Pb2miDcb5UwEKB
	 cBMfZMeFOiyAxdO7bDFlsnk5ut+j0/8OxNvYVxSiQe6VAefM7agktxkVT4hcgJQ6/rDa6
	 TD1EQKAsfe6ifpLW97stX8e/x/MrwGwitG6zjzBW5Jq9kiO3lmymWq3yQsEeJYK6jD3Xv
	 +Rs0R6ws33umwRQLRrmoMPmLiUADqz3hiqlT0OyL8vdlOOXiDHiS5MXdfm/1pdtvNQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795217031;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=yBWwAFCqhl1MWyd1pGrfSRfgr3arX7wZtYBN4Lqn+rU=;
	b=sRbEi+SQ4o0W95TL6fTekM25/x9KmFDVQJZtNACuMw/+kDogCkm1A9vfjJrcS9XwB29P
	 wtx1i2LdFispYpayPwSbMGjY95cbZKw9K59LfhdXfZMSTXN7aUvWwGi3WXSF3F1Pr8VRA
	 AIcPGqz9lvY69OL5SrVb/+QzW/iRpFlZfVVAuAjP1g8cB1KxNC7srMzsDyITMjDv0MM2/
	 OoA3cB0ciky3gX2DRzSR4tC1zB2zIiPJk9AOJ+/2s4hpapCHOZoOteCvdqm4W4iwg87ot
	 pv6yHF3GRLUP4tFmU1aDz/9FWv4j/TygRL4bvmhcjSUYRwV+YmvtZ0+Qu+g9QdZqzng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FC8606A33D
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 23:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30FC8606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-94999a08973so146547085a.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 15:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795217030; x=1795821830;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yBWwAFCqhl1MWyd1pGrfSRfgr3arX7wZtYBN4Lqn+rU=;
        b=qbvuDZpUJ13sV7B0irsPz7TynhKi0CMFQuJayip1Gm4HJhJO/DemphPvTDweHZgPkN
         VJGtWJNw5/i0LyDu4UFHStiRaBbcepXRJyTg8c2xDWhHrCnzV6N8SQhUmBJVf9XNN5sv
         lIWjFWQnyG8azykPNnvHf5qiP2RmWTEwXn+nBx43BQE4Wur3V88xloHIzKzzcgK1c+bn
         b5aNJVNt4DEnk5b6N47uwidg9+KKIjCI/HHUqQOXX2sOo2THhaOQSp/fVnR/COSXAp+P
         1TDnFhFt8HKC95Db7iEcGOaI+FBd18zBSIBgYlogO89xUhmTZwHO2yNi2w6HgiXZE0AS
         D1bg==
X-Forwarded-Encrypted: i=1; AL+hErFOo7RrZVSwl+MGef6F5P893fi840GPhrlyY9UfS7/fkq0O9j1hYtfM3Y57vEHZaTBOiRk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8r2OSJzbLTbBBVvSj5ZT/3nnww45QWRmNG+PaQ4wu/1ZuI+Yd7
	nuF4+8Zyoxn54zUD9+HTLjopQmgcmOARUL9YUNdWq1JhOkom8SAcOM68
X-Gm-Gg: AYBFou0qZlLdgT7EyzPlEp6tSH3TqBwvkSag0AI0crDhnwyB54UHMgcClHLrL9ndJ+s
	Enumor3KoQKblwT2uKVhANSeef1aX1lOIwvipx/JjGNRsI0lGUJ/SOr2rZtuMR+Q30UksbV03iZ
	YlKbVhhb8+GcKXCG6zwgTP47PXPcgVw14izzCf+LfX/x9s5DBDn585biNVSL1BRqYj/GyjePALq
	YHYob370phXmIQHwSF0ulAizpppKKnEiy7zpGjLpZ/EchManrkpWtu6zdDk6Iuev6nbGjC5rciM
	qxNLY94aD22mq0TnkG4qMFvltuCDu/qa4wghRmo3lv7hc4WOmyWslPhlMrqZq26cXZqDkMUeIle
	Nm2NHorA2+kSvkJmnbNAzFSYVEhV/pgs7ASbQO6fnimXGighoBGz3yK39RIpWAfoQhM8MJAAVgf
	FGK38G3Y8IaI1JQz+NNGWnOlClPoDOM1K/Nwa16zR5x3HVZIcX0/XQ55UvP5qB4V8hxZF3sZsKd
	MBCtJPe37eAWI+uuro1+q3tGELY/XwTYxVYAWmWhPfNS6tysstCeBPDWoq1IDZC8pidHGR1wgB/
	eT7AqD0QQElEDZNQgEB4TrfMtVh/bGo8VP6CVw/wf+94J9Nt8L18tO4AZS6/qtArotPkiEjW7Zq
	B37oCv2thJHlRheK4PW4CC/7ry9LbEBc/5iWDDD0Mj0Jcs7bXEVa7
X-Received: by 2002:a05:620a:46a3:b0:949:7069:3fab with SMTP id af79cd13be357-949bab3e9aemr842214185a.83.1795217030196;
        Fri, 20 Nov 2026 15:23:50 -0800 (PST)
Received: from localhost ([199.170.132.196])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb34ac1esm304475985a.15.2026.11.20.15.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 15:23:49 -0800 (PST)
From: Tamir Duberstein <tamird@kernel.org>
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, shuah@kernel.org, arighi@nvidia.com, xukuohai@huawei.com, billy@starlabs.sg, void@manifault.com, ihor.solodrai@linux.dev, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, awerner32@gmail.com, andriin@fb.com, martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH bpf-next v3 4/8] libbpf: ringbuf: Add a caller-owned iterator
Date: Fri, 20 Nov 2026 17:38:22 -0500
Message-ID: <179521430208.33161.12109136474224844730@kernel.org>
In-Reply-To: <879cbd5d4fae85a5ccdb53e5e89ec64f6039e1017b62e548daecbee9bc05e900@mail.kernel.org>
References: <20261120-bpf-ringbuf-fixes-v3-4-ff7ca15d6c37@kernel.org> <879cbd5d4fae85a5ccdb53e5e89ec64f6039e1017b62e548daecbee9bc05e900@mail.kernel.org>
Content-Type: text/plain; charset="us-ascii"
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

> Should these three names follow the libbpf naming convention for object
> methods?

Renamed to ring_buffer_iter__new(), __next(), and __destroy() in v4.
