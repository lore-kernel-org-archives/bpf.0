Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207333;
	b=JiqKjfzMsgVDxHfdRV1fWWcmZHMpjkD8SZlD/sf+7alrYKLJmR+fBMIStx1w7Gvv8MTD
	 Tp2Bko80hGSL67GFaBCGqjPuSlP7BvNGCYKYmkVWaQXE4xT3YrPpV1bghJ6c+PQlB54K5
	 40ZwWY8fE8gho398LtVsGUgTOFYQvJD8c8TUIsvTQb66TgjnG4rUqIcgIASaWSOG+1qqG
	 YEV1RXOem9GWWPqu41BXdO4BxiiiGHCBXMVPbURliEkzkMP0yXtgt3i7Q9LMjdjdjKz6S
	 cgj5Xr5Pi15oqndoK2wr1XOtx+ueJd/g6OqgaxE17pP57Re0GekilnJApPw2y1TKXWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207333;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding;
	bh=shmJAbGA1MISsC+6N7az7V5nNrP0Lt5U/4QpgbvguTg=;
	b=h4aP5tVyAYLYmUDh1XvSF1tzjViK1S3hY2UNxAQZZLvBew080P6taN08oCosSmkjWc9x
	 HqGh5SLOs9cxCuWqg1R3pPTuw7+982GsRM6O2qTB1PAu+BeeOty8aKsjbEO8QifoYUtkJ
	 bvg3g6fCDPEzqUpCCcON2rK5BVj/xtLb6Rj8+PtJJeFzwEAFHwxH/uU9//RohDcxWz0pH
	 oVL38rils145zQ6fSXZAC7u1XNEGxdTRiwGmw/VNLFjEL308jLeqtqy2Y3ME7juN3zkiE
	 Cp79hzXm2y200lO+vkQVIvGZerqC2u/wPhPLPFNUIRJbZHd0ReokpbiOljxNYIxPpeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11915606A6D9
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11915606A6D9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93f3c616c84so108779585a.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:42:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207332; x=1795812132;
        h=content-transfer-encoding:content-type:references:in-reply-to
         :mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=shmJAbGA1MISsC+6N7az7V5nNrP0Lt5U/4QpgbvguTg=;
        b=WFL/1gJAsRxwPJOHBdPgMv+TENDl5kXE5Ksv84x0LIRHMUTQzhxcj8q/5d9THzHKxp
         ukNsPLI/9VCl/l58XsJf7WzUf486IjzS1uw6di/LbU4zfC/UhkjV7GFk4bLaWSfEpU0j
         AZTCXLwIV+voR766IBdGpnyqK8cy9McTCQBzpcAz7s8Kxgosx1hx2tBzKM1D7N+NhkE6
         VNyqfTV2EODsQn/MH9iz0EhbE3UAPGSveAYBvyYCfQiAMesIzw73uNdRGFNG52qYXCFg
         tRpMGE1odCRZ6BRkwnoVSBKR9yLdaVLp1n+4A/dw4MpiUgIUpZDKPDWy9lMEWrm0FleI
         V3sQ==
X-Forwarded-Encrypted: i=1; AL+hErF0EwP2zhbIVXM6KZljQIVbLvXEn9StnVqL3ePzM16XnLNSK3uFO8Wetv5BANW2jCP0Lb8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9m2rxu9ljBU4vHFRRocHMKZpR0Jx1sGZ67glKSVEw2t+LJcKq
	4+yjgulJfFReCCFQUB46Q4iIg4QyBttAqUIsM3XeNQrbjcIaf8P2QIr4
X-Gm-Gg: AYBFou3wJ9koZBSz/hPUPpxA8Wz+ryxAg76mi5TW6MlhsZz7+6+Tx0izSbWiJskBE2I
	nND/n5NsjhenAhEzwWjd5pKOd9KGxGu3WnFdy6f2bGV0wbRlxhprFAnjuYVNxQl0gbOScYIHG3v
	hNGQzAqGghf0QlWm8o3mNMHzvHlvRcQWF/tepO8M2lIs2nG1aGpFYP7LUILJm4243kKJ6+LY6v+
	VBOUCWCO7kjMP5AiSLO6D++pRoOlFZHCITmPMe756OnsUzgorZe7JcyrsVPvNTmNSnPVR6oP9KO
	bkGkcIGImNy4aTbT9HUQ2qnIiZN/q8g99zi2LbewNZVO9eJRxdE8xpIz12jyLVow12i0SgCNC3a
	nQUqHS+ucv6LrzMIOgchfkuRbS3GYsRGzaHh7LsqOErFEB4F+nglB+Ge/0IJcnnvM9Uu/409+ik
	zzl/f2vSHipbLfX4akgVxSothALFR+O617LKT2etcl7C4WETUjbLAhvEAs4QvNTeZvlto4YOatz
	6mi+0emNK6Ojx+rjd+44UP1BvC5xqPmnmeV/FC7pue8BRfSHhJ2TCN8ewzG4GX7IlThvClNxCcs
	YkkCNnSP4CY6Ya+AJ79p9KHkRMQOWCV4o6+v/Q0/bi2haUNxy3DMi4wDWe7QeJQ2cjL8hUx3Wpm
	CTkp7hVKFW8YoJJNQFghiytJaAc3x29Ui3aGdvNtaqwleM3OFc2ki
X-Received: by 2002:a05:620a:17a2:b0:949:6e15:e1ca with SMTP id af79cd13be357-949ba965b33mr726231885a.19.1795207331941;
        Fri, 20 Nov 2026 12:42:11 -0800 (PST)
Received: from localhost ([199.170.132.196])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949c555faf9sm158988185a.0.2026.11.20.12.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:42:11 -0800 (PST)
From: Tamir Duberstein <tamird@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Andrea Righi <arighi@nvidia.com>,
 Xu Kuohai <xukuohai@huawei.com>, Andrea Righi <andrea.righi@canonical.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Andrew Werner <awerner32@gmail.com>,
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf 2/6] libbpf: ringbuf: Prevent NULL callback crash
Date: Fri, 20 Nov 2026 17:51:54 -0000
Message-ID: <179519711424.18576.15326586614235160874@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <DJAWPR7RA9VX.2LHJ0V3EVGR7S@etsalapatis.com>
References: <20260613-bpf-ringbuf-fixes-v1-0-e623481cb724@kernel.org> <20260613-bpf-ringbuf-fixes-v1-2-e623481cb724@kernel.org> <DJAWPR7RA9VX.2LHJ0V3EVGR7S@etsalapatis.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Can we just prevent a ring from being added with a NULL sample_cb?

The NULL-callback fix was merged as c0628a0659b6, so it is omitted from
v3.

V3 adds a caller-owned iterator that returns records without invoking a
callback. Rejecting NULL at construction would prevent iterator-only
registration. The constructors therefore continue accepting NULL;
callback consumption rejects it.
