Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2663EBF00;
	Fri, 23 Jan 2026 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189617; cv=none; b=Dzc7SWsemshi4nM1wlM2UOnRNRg1TexnS0czHOH0ZaDOdtYI/sn53Yb3EAcLuNcd+S/0Uvr0vKRxj+fLc0RknZVMgLv1WsliJfkbEMCYVdgh9irFY251kNTLX5iksDveT3i6JX1J37NHredIhdwj0yBVirXIC0KJ5HgMyWsIHRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189617; c=relaxed/simple;
	bh=QOYVt8e/lNugpEsLMp6/WTZBmgTGIqKY2TiLxeHbyvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kx166YtyGTJLYlR7RIU0mzwOCRMcs1vFcSCVQqufvBJ3l/fHcvWm3fuCfuV/ZYfYXEr6nrPcj6o5U1ztmxrJcex8BqNOunEohSwwJPKYPeTnqNCATp3wX3w6X7gVZKSJpVBspkMIJ1YAX1tKeDDXOyMarkoaonpH2DrihctC36k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Hjr0bARw; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Hjr0bARw"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vjL2H-00FKU7-8l; Fri, 23 Jan 2026 18:33:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=f8Lh5bMo8TR792aKYfrMvKafH1vRBqOQKGUa3YEqhLc=; b=Hjr0bARw/KHP88JNS/WmZiynEe
	F159QqgCghTccEAxlAvF8Kk7aUQ4Qirf6C3mNOJsDQDHYVL0VQIdZgM718ZUZDcnbl3NkySX23gXa
	9krLOiJb3v3k+Gtn3ncd8y6Fd2btRTigvBLr5LczsIU2+KwyvHtLODHZBVluFpEvItV86Vd6txd2b
	4FkkapMYTFMREFce4knaecYOJCLmi3Ggl6wiO/VhBOS0zxNwmPs2sGhQ2Oikgn/Y4IK5iKoZ7jr42
	sZGNjiCGpW5rfj4WVnSQP+nwn3Kjz3T+yUNnEkfsiaNQEQofIFa7ih34rTjBRjTF1aPvtSpKj6fuN
	Ibxzvx2A==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vjL2G-0000cN-OF; Fri, 23 Jan 2026 18:33:28 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vjL2F-004IwG-Jl; Fri, 23 Jan 2026 18:33:27 +0100
Message-ID: <19ba918f-d8de-4aa6-881b-47f7e0e10b7a@rbox.co>
Date: Fri, 23 Jan 2026 18:33:25 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for connect() racing
 sockmap update and signal
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 kuniyu@google.com
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260123-selftest-signal-on-connect-v1-2-b0256e7025b6@rbox.co>
 <45de7914fd90da6c4940d1c299282eb40d5921ab1f3b9953a120e59a7a9f907c@mail.kernel.org>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <45de7914fd90da6c4940d1c299282eb40d5921ab1f3b9953a120e59a7a9f907c@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/26 18:09, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_interrupted_connect.c b/tools/testing/selftests/bpf/prog_tests/sockmap_interrupted_connect.c
>> new file mode 100644
>> index 000000000000..aa48ae483dab
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_interrupted_connect.c
>> @@ -0,0 +1,200 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> [ ... ]
> 
>> +#include "sockmap_helpers.h"
> 
> [ ... ]
> 
>> +void serial_test_sockmap_interrupted_connect(void)
>> +{
>> +	sighandler_t orig_handler;
>> +	struct context ctx = {0};
>> +	pthread_t tid;
>> +
>> +	orig_handler = signal(SIGUSR1, handler);
>> +	if (!ASSERT_NEQ(orig_handler, SIG_ERR, "signal"))
>> +		return;
>> +
>> +	if (xpthread_create(&tid, NULL, racer, &ctx))
>> +		goto restore;
>> +
>> +	test_map(&ctx, BPF_MAP_TYPE_SOCKMAP);
>> +
>> +	if (!xpthread_cancel(tid))
>               ^^^^^^^^^^^^^^^^
> 
> Is xpthread_cancel() defined somewhere? I see sockmap_helpers.h defines
> xpthread_create() and xpthread_join(), but there does not appear to be a
> definition for xpthread_cancel(). This would cause a compilation failure.

xpthread_cancel() is defined in patch 1/2 of this series.
But apparently patch 1/2 is still missing from https://lore.kernel.org/bpf.
FWIW, it's already here:
https://lore.kernel.org/lkml/20260123-selftest-signal-on-connect-v1-1-b0256e7025b6@rbox.co/

