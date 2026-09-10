Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6347C4A2623
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053279; cv=none; b=TwpTd94hL2SRjHg1jvOHr5CEw0aFpYjCgnlTb54hu2NrZQ5JgVO15/IWcGO6aUh3N24YOW+ow93OswPJhGYsI/DubSRRfoXKRQAiZOiRM3E5gO3caqXahbVeqv1loYDbQp1GzBo70O6pTAQCXGJUolwzRg27HkEnEKXA4gzYKs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053279; c=relaxed/simple;
	bh=MuvCfBGrpiMokNLw2X70H7wAoM2pSZ0bAcmXjWR4v5k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eTxak/vU6qzTVQxhJgZY+KGfb+6cmUpYFU80Q00AsTlNtjaEv04oibYq4BYrqEqe860HLiwn3dP9IGzMyC7kIB6bOyGQOCOaR2RpF78aLllea17oA7l9W2I6sP0VE7dEBpC3tLwfNo396c1Fo99zGxFqdaYNddFSoYmpLE2LC2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGxzaRJQ; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGxzaRJQ"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so40139645e9.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 08:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789053270; x=1789658070; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CLHEmEXnxpW1Ptm76l16XHUNIxt+SG6NikWZasVRlWc=;
        b=JGxzaRJQ6FJeIMLaHpboNNujvb1XUBwoia7HSZBiS5WfvVMnFNs9w+ktm5sKyzCUok
         taYf9/lKSH6fbbKmTDsh4KR0O+khcW3ihgTNkF+nNcXGhlitX7dA65ZsU31r9HojoXZg
         OXi04k6h+k2zWfC+deCyRoli8d7GQdbodjbd+BF9y8U4H0AnKJVmemVsuJGmgsnMh3XJ
         aCGwZWB+8EAiHBnBSf592RX+G6ZoNb0OFUoU7KUW2Jb4i1vgTywnPp2gBUcoWP1sA7bv
         URslHxA8l3s7dcgNAfhnbnRGy4mZvtyHUMCT1l4tNGA8oOvDgYxrnp9ZKrMpiNo9bVwd
         WPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789053270; x=1789658070;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CLHEmEXnxpW1Ptm76l16XHUNIxt+SG6NikWZasVRlWc=;
        b=Yk3ySXBL2TR0Y0uKF1UqsbajXddQ+fjQbH/AtLUNrNU3pWLF5YxKIWmqB66mVRLjsV
         njQkfN4SSE9MLcQiZmqDrAqLzL9sVVsfbPsrGePLbsTcoLoEsbQrK8kVenEwecQiJRiC
         jgpVcarDtxGfSznvYLc2IP7y59RQqIv+FnA/cAiDwwAq/MnnylaM6BhoSQuJjWAJCyU1
         uvb9jlAQm4gGh33LJpeJNy657HNs/7I26ZViMo/lctFJhJNkLyXMV6pYW1HEApbk5Sp0
         kgOw2y0NQxBtZq7qwBExZel8zhAaznH2lapfl96Sg+J1ebMQKvzapflQUc+hrySwPzJP
         sXSA==
X-Forwarded-Encrypted: i=1; AKwUvBzXfOTNrje/2PSrNMiXQNU3OtapNSji20NqpxR0hs+aV+cMEwusc7RXVs+i6DUxQYGTKvs=@vger.kernel.org
X-Gm-Message-State: AFuF++l8u7pWDIJ/TqlI+K3O/5DFwWSMCDtVKYIzEhlB1hCKiQzgk0qE
	yw7Q9WdQpPSrtOTwJ+6AP4Opw4pvflgB42B1pL5xJcenC7UOuhvXvfqq
X-Gm-Gg: AYBFou2RmLcy5NH3pNPY7oIXBywKd87NQe55xikH/7Ss1o9DkgBCwXnilkq/vf/5tT+
	nOPE/ukmmJkaPOxCDMdDsnUOj4kRzT13jPIBnqx4EsxB3d3sETVazRdEzfClorVxiwO5KthR3Ek
	KuQsfmNyXLcMBLKpbQNCMEfHZui+KOQNsihhjW8P6KhP1qvwcIegTCQWKATKyxB1hoB5UZ8pEsV
	IJmCa7Tl+vvS8dTG79a81Et0lU0qB2HtTWWgCeFRV2GGhgR738imvQiUFYlqVVwz4WPaYw6XGo7
	xJTNjAjoXN6Oiq2cFQvdfzdHGAaLKsDq8PfjeGEJE6ziISBuLPw0XUF55CPTi3KVMca/yAVyQ+n
	n9koQ/JdESi28O7crUhc4+DQtTlW1S6DfVqyt18Rcyy+y3maAklsn7gW2x/zjHcDDJ3waigOBQC
	td/mMhDXOLIc9WQPrvRtd2Ph20RTb+rwehIoyAtzN56O5zqyXDEyDxKnI6LeaTrJ4hU1zi49KW9
	6P+I1tjYnVnQibmc+1tLEcVRO2Ikj+ugoe4jvMg0wS3u0Rsu+qTqm3RiuXazGH4AWDyv34DOx7p
	zLsJnZtEmWFrbLwjUV27g57zTTFdyE7yM1DqTwA=
X-Received: by 2002:a05:600c:548c:b0:49c:c96a:d36b with SMTP id 5b1f17b1804b1-49cf8267dd3mr435083895e9.12.1789053269706;
        Thu, 10 Sep 2026 08:14:29 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883acd33sm52207742f8f.18.2026.09.10.08.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 08:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Sep 2026 17:14:23 +0200
Message-Id: <DLBQGB3CXTSB.EXQVL3ZIQ3QO@gmail.com>
Cc: <eddyz87@gmail.com>, <info@starlabs.sg>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf 1/4] bpf: Add KF_PERFMON kfunc flag
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, <ast@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260910142107.40582-1-daniel@iogearbox.net>
 <ea68b32c-1af2-47ae-b168-4fd6791f607b@gmail.com>
In-Reply-To: <ea68b32c-1af2-47ae-b168-4fd6791f607b@gmail.com>

On Thu Sep 10, 2026 at 5:03 PM CEST, Mykyta Yatsenko wrote:
> On 9/10/26 3:21 PM, Daniel Borkmann wrote:
>> Tracing related BPF helpers e.g. under bpf_base_func_proto() are gated
>> behind CAP_PERFMON. However, the same is currently not true for kfuncs
>> and they are accessible via plain CAP_BPF. Add a new KF_PERFMON flag
>> which can be used such that check_kfunc_call() ensures env->allow_ptr_le=
aks
>> is permitted. This follows similar pattern to existing KF_DESTRUCTIVE fl=
ag.
>>
>
> This problem has been reported and patch sent some time ago:
> https://lore.kernel.org/all/20260615-f01-07-dynptr-probe-read-cap-v1-0-e6=
26cd61a381@mails.tsinghua.edu.cn/
>

We ended up discussing this and decided to go ahead, since it's a bit weird=
 to
continue to have the discrepancy against helpers that have similar restrict=
ions.
In practice it won't matter much to actual users, but easier to just fix it=
 and
put the thing to rest.  This one is also a more comprehensive fix compared =
to
Nuoqi's.

> [...]
