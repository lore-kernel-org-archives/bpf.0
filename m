Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6463BA220
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773168737; cv=none; b=EnhP+E9K2400BvU/D5gUeykCb8NPbTZtJc+d/kKLIEXacj4lprt/mngpZunqLMcLZIz6Bn5aUORW91EYc+RkBGX7o9mspkMjSfayTIKiyyZFxdWvfshKFIYkhxb0ESTp3mxIiK68gHLmGZfjeWybbOn/D6EEvZWjuEKAf0VEOQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773168737; c=relaxed/simple;
	bh=cb5vktLgb8+u8LhhDYTc4ioGL2nlsTLIl/ZZClDfKsM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ulq7/LH74r89HU9qvIiIL6+SDvQH/QXTjCGiD0wk+NVAW/Z3Zf6jH0JzqmBbVK4wZ5k+9q4awjhDcw80/KRJ6hRuuLbXCv8plfPseV5GvH8RL0/QtLbR7Az+sqMXd320V/HLG3jThu3DDEE1TJ4gcOx7tc/mRupvm7fF+WHg9eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOY2KNWv; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOY2KNWv"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2be27fa54feso11407507eec.0
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 11:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773168734; x=1773773534; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cb5vktLgb8+u8LhhDYTc4ioGL2nlsTLIl/ZZClDfKsM=;
        b=DOY2KNWvcHQHytzw6Y4QAMtTweRRjfaQCmy3C3eTjzVShGj3EV5Qsv4UbzAgprPmM4
         RCd6i4n0/ViHK/FDxltfb0VBT7+nxhbuk2cdcpWZGNlNaFBnSN9vXdVUl4lgJZ2Ay1sN
         MbFalp+d4M6b5eT4fA1tmP0CVqW/aGeK36l6ZROv4kfcaWS4jS9uy5YLnTnhJLBYwSGz
         39tNFL4ZaKpOnWO2haSeW8m8vASnnvsqEbBDu6+XQKfg0lBTFztz6XgQVy0UKkbFSNnn
         wpFeQx3r2px1p5MI/o1fjyCQIgdawfpQUei20cYYQHHdHb6JMC7+70468GH0V1ILcLA7
         +rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773168734; x=1773773534;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cb5vktLgb8+u8LhhDYTc4ioGL2nlsTLIl/ZZClDfKsM=;
        b=H9/78qd38OxpxT4tj4dTWl2xg+u80wpbREqPBwSnTQOFkrB6ksYxmtxF2VYEZydbm9
         gsTyDWIdcaktsGMeFhNWLXILA6j6wORe6aMenE3son6P2HuR5zPx/mGSEZMSq3T4baW+
         8RDbHsyShYwGMccDNpIk8OkfQH6k1qY1ZXoy7fouJes2wnbRkmeBfPv2B63cFC4RJ5WG
         qP/VYihz6NKui0IiGPgd+Y+4gEu1uO9/QTpaGwE80oj9ZQV/fA0+TWc55zSJgcZnPh8/
         AU7fYO2yvjne1wHcjZu8KcUYmgqnj6yL6f5znAIYVMEY5Ty64vxoJtcVxjD3TaG7JAIo
         Wc6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTuNfVS8Sd0khl+ZsyvuO+hAMoed1BI9GpA8QtxCxLGMsLPMqhWZq8WdAQNssYzNh9nHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9DSPhYKFVBMiUtw7dF87ZmmociiuLk+onbwttD8zm6AB1BCCM
	dUVwCsVTe2Gb0e3hPe/xQ19SQRiGKPnKP6dQYcqUCoOv4O/MsuqWnuQz
X-Gm-Gg: ATEYQzyVFmWrETJsJOtptuHiAIa+omafEq6BoQB99vAJuCZiPo6tSeZl1yLBvRoFfNm
	r51S99YdcxdkYN+K1lVyyQMTmuWwijOvwM0iJqN7YNfVCvKo+0ttuwqhTW+BI3IvQlSE7J6tYQy
	0yQqib1d7t22ZuRUSs2WP7WGNjNXowPB0TI+8kEcvhbvRay75hh/ZDn5wgH9ytlYB4QbLlvI0Rq
	HHfY4bsg1KUbW33zwg8gHlEY5nbw9PvByZkXzWcxUhO9UqgQYudPh86+TJ6/7WlbARYuNkTDUtq
	P6nII2fpD2BBR+34aPV+874uSyPyc64PdIHLWEXgMgeuDw6sGTewXK0ySj0nH6jZTT1j3kuxsHh
	ZheprWNlkrll1n2O7vbnsCowaK++r7DS/h+xjGyNiDd4HT1JkMsKWcJU5jAXRRq/Di2EjtKXHee
	8qCNLgT9j5BkgvBZgnvdNuhdFBhil4h91bCL+KsrGkVBuZB+v2DJQxNsNv6iUJSnv3iqGao4FFu
	zypkhVM
X-Received: by 2002:a05:7300:a985:b0:2be:10a6:647e with SMTP id 5a478bee46e88-2be4e055786mr6302882eec.19.1773168733632;
        Tue, 10 Mar 2026 11:52:13 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9dd5:5c94:8add:da1f? ([2620:10d:c090:500::1:641b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f94823esm15789597eec.20.2026.03.10.11.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 11:52:13 -0700 (PDT)
Message-ID: <979c7539ac475b3c428f609066e947844b6dd8b0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Support new pointer param types
 via SCALAR_VALUE for trampolines
From: Eduard Zingerman <eddyz87@gmail.com>
To: Slava Imameev <slava.imameev@crowdstrike.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	davem@davemloft.net, edumazet@google.com,
 haoluo@google.com, horms@kernel.org, 	john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-open-source@crowdstrike.com, martin.lau@linux.dev,
 netdev@vger.kernel.org, 	pabeni@redhat.com, sdf@fomichev.me,
 shuah@kernel.org, song@kernel.org, 	yonghong.song@linux.dev
Date: Tue, 10 Mar 2026 11:52:10 -0700
In-Reply-To: <20260310121659.25801-1-slava.imameev@crowdstrike.com>
References: <c4f4e99f83a98179c3413dd7afe5e7e73a98e4d3.camel@gmail.com>
	 <20260310121659.25801-1-slava.imameev@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-10 at 23:16 +1100, Slava Imameev wrote:

[...]

> I verified whether PTR->FUNC, PTR->DATASEC, PTR->VAR can be passed to
> btf_ctx_access() in the current mainline.
>=20
> I added helpers that inject PTR->FUNC, PTR->DATASEC, PTR->VAR as pre or
> post calls to btf_check_meta(). In all cases, the BPF program load
> failed with errors "arg0 type FUNC / DATASEC / VAR is not a struct",
> which indicates that btf_check_meta() can indeed be called with
> PTR->FUNC, PTR->DATASEC, PTR->VAR.
>=20
> If the condition for pointer check is changed to
> `if (!btf_type_is_struct_ptr(btf, t))`, these BPF programs will load
> successfully with arguments set to scalar().
>=20
> Do we accept this change in behavior?

Kernel validates BTF before loading, see kernel/bpf/btf.c:btf_resolve().
Validation is applied to kernel, module and program-level BTF.
Does BTF containing PTR->DATASEC and PTR->VAR pass validation?
If it does, validation should be updated to reject such cases.
For PTR->FUNC, which one is legit PTR->FUNC or PTR->FUNC_PROTO?
The legit one should be allowed and invalid should be rejected
at validation phase.

You can craft invalid BTF as in the following selftest:
tools/testing/selftests/bpf/prog_tests/btf.c.

[...]
