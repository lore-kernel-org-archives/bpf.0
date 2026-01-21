Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFB147ECD1
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988965; cv=none; b=gUAOlAWf6qh+eGm+NkaWoo8Adsnx6R5rqwr0Nh7KywrxCbndySJsZcEJ/qZ1Mjqwj4ZBHWHWP4I2Q7dqp/RPxjh4AeOI75G5x9ZE3J7ebN/LzajVqlfcPCUm6Q0ay/J0MxS421arImj1th+YcEtzGvJxrrffOKvjU2Wd/dPFzhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988965; c=relaxed/simple;
	bh=0sxY9/hbT9jAvcK9hvO6t82kEcRLh2+R2jzBqHhBPE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uUPzT4wOWkmm3Tb1Jfke6uMWjYux1bQBFu71YiBuHmDDws/iY0zzihPeHt15OtZhxxFey80NzyYQYnibriu0fCG8moSOT0pg/mxp9vtsmyOx8etHk8UvW6mykRxLxr86ijA66rLFoiA/9VRlJaNdEoaP69NT+/rXclQW8Amg0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eXUPOhno; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eXUPOhno"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64d1ef53cf3so8667608a12.0
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 01:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768988962; x=1769593762; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0sxY9/hbT9jAvcK9hvO6t82kEcRLh2+R2jzBqHhBPE4=;
        b=eXUPOhnoJ51DmemQ2dvwrDxK4Yfw78ZBICyI1xXQgexfhd8EMzoGShsQqFKRi/NleP
         mxqsV2pcHW3aJATMZqerU8Dop0ZM2ZLyWehzMa8rcpCGUEdfvovNStli7hbz/LjIxgrp
         r2QbD4/bay/iIycBXP9LKVm4+xZ289SNcbP0G6qACDttWLVLnZGGgIl8YSOdP9bvuSXG
         Eg870u7iC5trubXs4E+xeHe+V4TEwwSDWtFoUBGnK+UtU8QElQfvSG//VCwIOd41qsSZ
         kz4FndnD+KAodc3vhStkxYyY31HnZLl/3mCw7XA0X3mW+F6OAh19P+fNp54nt/6BbQbF
         QgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988962; x=1769593762;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0sxY9/hbT9jAvcK9hvO6t82kEcRLh2+R2jzBqHhBPE4=;
        b=K08ccB5h9EwBSo8+vPUke+lDW8wzmifjAmZNyqzisBGLtlOEqcd2Zcd641INCAN1eB
         pfreZSTBhIsHoiVmnGas9EsnU2/AXWkUWmSuquNb2sgMLoZJ9Zbf8t7TPI2SGBfLToaH
         7d7jpt8xAQo+PH8qOwLitzOEMAfPx4vtT4F3wijMNSIdrHPG+GiaUGCaiWQePYVg8Hsm
         R37NoWeQOcCJuTd7yASgL4aLv7TugSzxRVLuOfLdw/UPri6NMkRtRmxupLBSVa1cj3Or
         ZvW+NPHRwC1+IXSQZGKWDXsQnX2ljNDu6emvWiQnKf3IlUTOeyRJZ3JsS6g3WekhGBo1
         fF0w==
X-Forwarded-Encrypted: i=1; AJvYcCWD+CMQa3m64sVUqGNwVqG0ONRQyg0ReEqMVF6BdLM3ugN71UPSpiFU+fzN0ECcjZbnSQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YygHZjoxYkyV2U0BktxHauQKNyODW33KZdtFjJkg2MLGyPSdIpM
	F2nlKjXGJ/CZfqV8IOur/XZVYLaaFQU4naVnq2p9HUXspZK9Ve4bDZsH2rLrWNQE1xA=
X-Gm-Gg: AZuq6aKG/JaQf9IUfZAugUrI4oRdv1cuTgSjw9j+FdF3EqxmU6xAJwJc2UhSPeSG24P
	M1cH3G2MUfpnEf9SDcQv1NQgcnfEgDcFKt00fdYBM4TZ0j/Ow5MDQQLlFZGVHnNDc9mGHP/E8Zi
	4CEcOAdZkFsmtjByjZ/cVV1xdMDBzuS+PuMHiMMINL/ZV4CJSJYhhBXAWTwRxlwIgw5RQSrdzoV
	t53+h/xYtS8pmfZillkCPHQppnHmqhjKEP1URA9KupnXd15KviI8+h9adrRpzEKd4Dh5lUNy/4e
	J2tox40TVG4L8p6XGtAGS7UeNLHro4X/ZxvRIR/WvAHdOcFErg9G+e+6AOFwrQN8AhYehKH8HAb
	xiHpuVtBNlKaOOCIV4qBC97NpmCTmIlR10KFJEonApc7QYeqNct/4b/BfJnceFnhAaAHa5cF4kv
	mwVAnEr5PGcwxh
X-Received: by 2002:a17:907:980d:b0:b87:d826:8113 with SMTP id a640c23a62f3a-b87d8268b60mr760209066b.54.1768988961653;
        Wed, 21 Jan 2026 01:49:21 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a2f1a3sm1521409366b.62.2026.01.21.01.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:49:21 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>,
  Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Amery Hung <ameryhung@gmail.com>,
  netdev@vger.kernel.org,  kernel-team@cloudflare.com,  bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Remove tests for
 prologue/epilogue with kfuncs
In-Reply-To: <d4563561-c507-4876-8a03-40e4dca2a34e@linux.dev> (Martin KaFai
	Lau's message of "Tue, 20 Jan 2026 15:48:06 -0800")
References: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
	<20260119-skb-meta-bpf-emit-call-from-prologue-v1-4-e8b88d6430d8@cloudflare.com>
	<d4563561-c507-4876-8a03-40e4dca2a34e@linux.dev>
Date: Wed, 21 Jan 2026 10:49:20 +0100
Message-ID: <87o6mnthwf.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 20, 2026 at 03:48 PM -08, Martin KaFai Lau wrote:
> On 1/19/26 11:53 AM, Jakub Sitnicki wrote:
>> Remove pro_epilogue_with_kfunc test program and its supporting code in
>> bpf_testmod. This test exercised calling kfuncs from prologue and epilogue,
>> which is no longer supported after the switch to direct helper calls.
>
> Is it easy to change it to test calling helper in pro/epilogue?

I gave it a shot and the obstacle is that bpf_cgroup_from_id and
bpf_cgroup_release are not exported symbols, so they can't be referred
to from bpf_testmod. We'd have to move the whole thing to lib/test_bpf
so it's a built-in.
