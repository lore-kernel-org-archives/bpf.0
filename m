Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626300;
	b=wkNQR4XYxLh8LbeeklLX3DK4Cx/rJ2UzQ0ZA49ET2VMNSa4rgaj4y+Kc15t76X1E0RYV
	 AuHmm4YLhJi11tVbelGmKJJK+IZyqJc9WjEMaGgiJ27IqbIr2JzJ8UUoFtXQXyfO3CBV5
	 tgtQ510End0zkXxkHKMtRla3AmULoxscP5g4U6X7rOWIQb+GOB3UB/iJW3oA6hPe1b0z4
	 DonZ3/ESPjFf+ag8X26b08FSfZXPogVhQyfnzjVX72XZ0HX+o2VBpTFjIht2DlAsjb0jr
	 9po4ULQBrP4A3LZkS+AG6WexkCQ1RKSpbiW3CDBqX3lbTWS04OCwe8mGgOsMx5CYQAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=XDu0RE2qLqkN4F9FMA5I580EwKMJWPCFaxCVS6yhsfo=;
	b=ntW4AI42lyKQX+GPnPUuWKmidruHJ9eLZX01ViFZg2suzwIoJKt9BqvPeMbROijtmv1Y
	 iv8e6Ge05TQlsL61LfcW6c1VGWD6YHuijRppYekIsBIklDMLcDabQzpIxlqM61mSgUEG+
	 ZSxVpnveYVCa2MUWxxOTdwhXMKMKuYG+xRuXCDGZOW78Bak3jx+PUShYByXryl9f0C18z
	 0O6u//043FDE9lyD46dc748yVUTixOfuqZHXeEatv/8MJh7ePGM5QvWV2e78+D4a5T/gv
	 5iHE/B0Ki78ZrZUKkhp5m1smR50yM+hqRsv1pwtJMQST2GfUbserfPCZPSTnsU0lpug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dlI7NdZ6;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50C5606A32C
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 17:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B50C5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dlI7NdZ6
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-382afece6d8so1210725eec.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 09:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795626299; x=1796231099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XDu0RE2qLqkN4F9FMA5I580EwKMJWPCFaxCVS6yhsfo=;
        b=dlI7NdZ6HZjf1sqzJlDb5DOKhlVyFKple/gNDaS6e5XwpFA6jde3ic/2XTVBd5JpH7
         G9fLQ4zVM0COeUqOPDuUl1sop/G5hkHOCt/77+E8W1EeXCaNBRUZbPyBdMsIVtZrduao
         rdQj7Ik9foTfSEFMy2h5jmwJYxgAAQzB3gkHFRY3sD0v7vqgG6bB/Q+YvVR1yamfzzY6
         Hm1fku2bGC0M4ziUerbRDW3puxBZT3la5acEp54YUBPKHjv4xkw7iVxaYpqcG6Jc9QKS
         CrWbmHtCQB6DV6W+lu23KQ8nO66s9fAebnkMPYOPxxpWG0NK0QsGzRVFTAbx2HbCT35L
         JIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795626299; x=1796231099;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XDu0RE2qLqkN4F9FMA5I580EwKMJWPCFaxCVS6yhsfo=;
        b=TU9I+HCkbH61ESkNlDkbEhsSNmIZbBEp5JRV3xyuhbLMS4pEfpFtzWCjHRJopSixJQ
         MFHWLSWb3Cnh7jazl1jLQLwaYV4BhJaILY+d2XGiUZt8pWN5d40ZDcP4EzVw8rFx+ktg
         n8fZadSULup8ZE5F2MF9VWr92+lNezrxJTLwXpH3kIscH5Lp5huQ/QtFaVZA25r7b4h2
         AiRYQ/LOqHVP7YIW9ROErghYtGTmGJ3RpR1VZLUlV33AgqndFEHwQWKUL5tq5GPLd8Yj
         NQ2mYdXaFIszCJ44vcsX1Kua/u27nUkAsSxrmNL0fcy7CRMQCpnzPV7bd7y8/bYgv9za
         k06A==
X-Gm-Message-State: APuU4Z8BOaA0zpO+6Z7RVoyYj58l9Q3l4amk3UCFnuC2A/RNeEyIlk0Y
	NogiwrSYze1yYzhWScVVDw5/ZFcdTtc9ngeG1v/60ZEG/Pscceurf+B7xsMp2OTN0Fw=
X-Gm-Gg: AZFdTZfzZuaK7NrHsy75JzvY16ha20On3qskO9LIGSTdw+z5LAo0ViKwdlvB9JjdgRC
	NQJaLoaY7uuQjRQuFqPfBrmpw8HOAy7QFX2cJdmjK+A88hsiTOhkWgPjAIze25OIR7sRqL2b7IO
	jEjQRqRKMgewvRijS6Uo6Ql16AV2iacU4xkcT26Xm78um15XpiMvuNkIoCD45mDGbXehNTyuIcK
	ZJ0V7OGg+sC4MufDJZLlPyXJ8/VhIgcp068kYT72T6hpibYX3L+Ilcatsxsg0tu/yxzcAAAw0Q9
	QtYdkzdGSemYvttxfc3GW1UJXujHZgnax3IxcTlTOBwxW8Fq8mHc1/QaFkRPD1rwxKw1IK99PcX
	U3Ick4RwHHjNhITAuKjiIT5utB7AAWstFcJzjrrfDVg0co/C4iaPQ6ERl6Zdw/UgHCjGGmS/VRU
	b9pmsG/pasnxk420Z8YZhnkGc25ONPtbvF5g28rle2L7QClo84ey60Y31gmzZt2u5qjzLA0cXd7
	n9+higWsgwZ7JR69Q+S/QwIEmZOV1LXIM0ScArkHGj0giB8ks6eo7FSN89nbaLdhWpuxoqiRpPX
	6Aw2m1Wuj4LyqVxHlsPqEOc=
X-Received: by 2002:a05:7301:182d:b0:386:b801:cd06 with SMTP id 5a478bee46e88-386b801cd3bmr7888146eec.40.1795626298644;
        Wed, 25 Nov 2026 09:04:58 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:43::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm53837321eec.15.2026.11.25.09.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:04:58 -0800 (PST)
Date: Wed, 25 Nov 2026 09:04:13 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, kpsingh@kernel.org, matt@bobrowski.net, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Xu Kuohai <xukuohai@huawei.com>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf, lsm: fix bpf_setsockopt() on a half set
 up child in inet_csk_clone
Message-ID: <awcUm4PvuYb3nGxM@devvm16445.scu0.facebook.com>
References: <20261125070330.16625-1-jiayuan.chen@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261125070330.16625-1-jiayuan.chen@linux.dev>

On 11/25, Jiayuan Chen wrote:
> security_inet_csk_clone() is called at the end of inet_csk_clone_lock().
> The child is locked, which is why the hook is in
> bpf_lsm_locked_sockopt_hooks, but it is not set up yet:
> icsk->icsk_ca_ops and the ipv6_pinfo still point to the ones of the
> listener, and the timers are not initialized.
> 
> So bpf_setsockopt() from a lsm_cgroup prog is wrong there for:
> 
>  - TCP_CONGESTION: puts icsk->icsk_ca_ops, which the child holds no
>    reference on.
>  - IPV6_TCLASS: writes to the ipv6_pinfo of the listener.
>  - SO_KEEPALIVE, TCP_KEEPIDLE: arm the keepalive timer before
>    tcp_init_xmit_timers() sets it up.
> 
> Options considered:
>  1. Remove the hook from bpf_lsm_locked_sockopt_hooks, as commit
>     5416c9aea832 ("bpf: Fix the kernel crash caused by bpf_setsockopt().")
>     did for socket_sock_rcv_skb. Not done, setting options like
>     SO_PRIORITY on the child is what the hook is used for and it works.

[..]

>  2. Make these options work. This needs the child set up before the
>     hook, too much for a fix.

What is too much? Moving security_inet_csk_clone to happen at the end of
tcp_create_openreq_child? Or is it more involved?
