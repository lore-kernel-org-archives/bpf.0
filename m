Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207379;
	b=zBkfiWQ72Q4z/pkHphxjulk06nWn+rKXaSi2ub4dlo+w0isS7b6Q09ckc7HMMq+DTSc7
	 kWXhqmUYwJxQgMYKt+XRWAQWV7wN0+DP0jx8ATbyHAJw/CJqas4EDWRkwmBt5R8EhRRel
	 Dvb3LA3C/4Mhn+T9Emk+dPi98uQCBPTZmMSlS6zfuh0h1+Y3ukeqfWCC+6Ma125Joump4
	 LbkzjTrwAwyRIbGm35cC0KFJdFUKUFJbsHfITKlp7e9kiPqnuBalUfNiJOsD+atl5TBNZ
	 Y2hUv1qkkBE27HN6PlcXcpS9Gx5uj5y0gNlvtTdYM+5nHtsvbQWLmJOWhddKn4c6ryQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207379;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding;
	bh=zmRf5gxjlnJH9lvYWVVBAgX4Un3YFttD1kKPZfXFXn0=;
	b=UYFgj5WJBzNuvDJhxeB83oCdNLeXcYNGjfWGhDXOiSCkvLgCNoJf+bB6bxtu1AuPFg6T
	 Lb4eqSaD+CL8sW/NGf37qf3ul/7uIjzFpF3j20ZhPFn0FrXsj9VqurK8x6m6Maic8yZJc
	 nsDAqGIHCy/qO7wuXJOrLspqXsxT9QQ+ensL6UpbqqFm1Y4DSWz6/UmPBF+q7aRpay3R5
	 gIHF/vPYBT2hBXCES7pWfzx9iVzFDp/zDKr9K1r9p/6qB7/+ACDkItoFSn6CQLJAVr+P+
	 SpO4kqDcpKijBt1pE0JzKQUh93ln4u/9bjvQ29LITDzfwGEf3dgahXXih/4Vx+MecKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB196070A55
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DB196070A55
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f269e335eso159653085a.3
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:42:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207378; x=1795812178;
        h=content-transfer-encoding:content-type:references:in-reply-to
         :mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zmRf5gxjlnJH9lvYWVVBAgX4Un3YFttD1kKPZfXFXn0=;
        b=2qvL5YFX9TeKWYz+CldJ3F0LpoJJBjnznRwGo5HkpJPeKPiPWkhLNBO597jjvhIp5Y
         1RvY7zzq/GLXJZ/UR1ITCW9w10t6ZD77HeafJrdq//OzGY1dYrKtvJiSYm09D7f1+klU
         CJAUp7O+mkl4r+t4MZl1fugnGuF6+6+5mqJjeksuoQso2om2jZgthqpUsQnVML4Yp327
         cfVCMNrY5mNPIZcNunoeYS7lUi+0hjiG6LKb2MprwP9Us1t4vdZbMd8do6aklLqSGnCl
         mxOf5v4OKFUUGBPajKFOvYGS7WvNacrONjxnmD96IJOOPodDlZVrZ4w3KvNRI4lPtDga
         fBDQ==
X-Forwarded-Encrypted: i=1; AL+hErHXLOKiVQbZBYI9gdNRV4JGQq5zkVObcSNTeHOQL78wyidib4bxbdN+2AJ4aKzn9qBVzW8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+k0GJtgUrbIByqod4i5NQsNGZLa4lq3tWa2DfD1pKARExp8pOT
	2fp+zfiEII2v2HDmBbUnVuuGJyrqSoTsXy4JclXSxGImwYEQnncU/J7g
X-Gm-Gg: AYBFou1VkdlV+H5CnOzR1kcnsAp+XExtuFvXYTKIMpLGB8e2zc7UwtaS6zKGEyGzmkT
	dWbqTEAYmprNnLMnRvopmPhLtkz9DHTGiLKuHnMRTnodtV1vI9abZ8ViGJ//AXetlA1cPszt0T7
	MZYpPUjgSjDFVgw49vyWc0pfCHdkG9maL4GbGkdP00NouD81HuoAVmUUjnKQv5tlGdXhjVNedm8
	A7iNx0OoLr6e3MoiWZ/hyl4rvr3I7OjgXsSuorpyf7OW3xlt6EWLPD5bh9r+qI9gxtBRqiMhShV
	9fYQc7O71BRRAdIQKgbD7edqR0qmf0qdAKC8FIGgxaAXyphvRCORW98S/3sG1+H7c51/U9Av96v
	gzO3xwyC9n9gsz9Z0aFUr4FduClfNTScLJyGkZkpB7JcckDbv6rx0P/F4W43iVSsoa2dguqNqGn
	DGFMA8VxJTlnj/WrZRqKaufN7ZlP3t8Xo+TlN1cke5aLvmo66K9o/vPgRrV7uBoMBiXY2ZzQ033
	S0IaGCZPUuCe2I8vCE9kTO48I4g1M9CLvsLHYe0IBmByz6Gn5pgAlpsJz5WadRw67cZDeOK0R4Z
	mKMDgo8bkh+5GrvRfYtmXbex7NXG8dOPfxHBCqEZRXSIiVR3LhQEaxOuN10Wk0igqwodqqeDfeM
	B47GjIhbWlgOFhCeJOCWcWW3O7cbgB8if/HxrQisFzdHqGCxeBSFC
X-Received: by 2002:a05:620a:8801:b0:947:8230:5328 with SMTP id af79cd13be357-949ba9cbc05mr698548585a.34.1795207378346;
        Fri, 20 Nov 2026 12:42:58 -0800 (PST)
Received: from localhost ([199.170.132.196])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb40ea12sm278707885a.35.2026.11.20.12.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:42:57 -0800 (PST)
From: Tamir Duberstein <tamird@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Andrea Righi <arighi@nvidia.com>,
 Xu Kuohai <xukuohai@huawei.com>, Andrea Righi <andrea.righi@canonical.com>,
 Bing-Jhong Billy Jheng <billy@starlabs.sg>, David Vernet <void@manifault.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Andrew Werner <awerner32@gmail.com>,
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH bpf v2 6/8] bpf: user_ringbuf: Handle position wrap
Date: Fri, 20 Nov 2026 17:51:54 -0000
Message-ID: <179519711468.18576.11537240668767230400@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAEf4BzattX9GherSPJ7DBeKksfxsX_uKz4y4tYNU=gUjqkJP_A@mail.gmail.com>
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org> <20260618-bpf-ringbuf-fixes-v2-6-33fde039ddf3@kernel.org> <CAEf4BzattX9GherSPJ7DBeKksfxsX_uKz4y4tYNU=gUjqkJP_A@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> should we use long and then replace cons_pos >= prod_pos checks
> with `cons_pos - prod_pos >= 0`

I kept an unsigned native-width distance for the empty, ring-size, and
record-window checks. Would you prefer a signed comparison alongside
the window validation?
