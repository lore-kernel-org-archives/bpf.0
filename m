Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705263BED06
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792150407; cv=none; b=H7rJm9GH7EdC6sNRAs347x8LHbsPnC081jPgiTWyYIyzkDeTxEDk6Eqp987UygicTyrvL4h53E2TO63C+uV/8qVtVr6ijhEasYqmZ/c31Agr8H2Uno+uudTdaFzFufhIqsfPhAltzuDuTN12GHcZpROqmUSDFtInaCC0Lc6KZ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792150407; c=relaxed/simple;
	bh=ekWZ9619M6Jgny09WoH9hfp1hoGe6MXvEdzqt7/1+Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uwn4AN0EJ3rYqiKYcAqGOtRz7gWDZu4ZtOQxZKzDGogbSnHUMrlLcnmTMk3T3C3yesRA3sfhjVg5+W8BRtPu5F7G4RIkVr5bDT3ABl3F4rIohpcNaDFUwHCdU0P7TgnqCHeEiqPCMQUCw7q2wl6TaF8EJOzh4Vd6rUbNKHwLxXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=cuAo1LfJ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="cuAo1LfJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=NUQbL6WgeKWsUX5CW5NItdoyd/8lC7KKnWZ5WVfcCjA=; b=cuAo1LfJltPzJIWF4EOz13UKYO
	8hcGqyWYSRKwx4K+gDbBAcNKfOXWxsYc04XRSHLTyBypKs4iDzSc6DfNuedjWsh4V22K3SNs2yS+k
	uKTfdby2UQemxyHWI17wOogOxuzSoLNOZuGuxFJTiWzwqsdwAqfvYiUfeTeJ7TqhEXA2evy97fHuQ
	9sHGM8XdaSLPuH01JuhjNbBcax8crmiZ6MBg33balW1X2vSRymMh5zlc6L6wFsIX4oqdCHkbrjSil
	W6og4CxlVSZniO+9ojdG1C0GoI4UwpPY8U/CAaZLx1TW1IlJjMPfc6bT1XIwiTfoMEmocfmWXIKi6
	RoJb6VzQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHgBb-0002nd-28;
	Fri, 16 Oct 2026 13:33:19 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHgBa-000GU9-2p;
	Fri, 16 Oct 2026 13:33:18 +0200
Message-ID: <bdba78ad-003f-4d70-a4be-42b6c729711b@iogearbox.net>
Date: Fri, 16 Oct 2026 13:33:18 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Follow-up to JIT
 instruction tests
To: bot+bpf-ci@kernel.org, alexei.starovoitov@gmail.com
Cc: memxor@gmail.com, bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20261016101822.632891-3-daniel@iogearbox.net>
 <38e4699fafb53396f8df8aefc589d88c948757b6514e6caae14a84152463b448@mail.kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <38e4699fafb53396f8df8aefc589d88c948757b6514e6caae14a84152463b448@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28155/Fri Oct 16 08:24:17 2026)

On 10/16/26 12:58 PM, bot+bpf-ci@kernel.org wrote:
>> selftests/bpf: Follow-up to JIT instruction tests
> 
> TL;DR:
> - Selftests: acq_rel and helper_calls now fail instead of skipping on kernels
>    or JITs lacking load-acquire or kfunc support; intended?
[...]
> With CONFIG_BPF_JIT_ALWAYS_ON, a JIT that does not implement BPF_LOAD_ACQ
> and BPF_STORE_REL fails the load with -ENOTSUPP.  Only the arm64,
> loongarch, powerpc64, riscv64, s390 and x86-64 JITs handle BPF_LOAD_ACQ;
> sparc64, mips and the 32-bit JITs do not.
Intentional, in such case for specific archs they can carry a DENYLIST entry
in BPF selftests should they get added to upstream CI until this is addressed.

Thanks,
Daniel
