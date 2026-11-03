Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711721;
	b=YsC2GeMQg2IiJRlnWZrhOPpP8+54j0tlFdYvFyixnADGmZjh8dE1f7gM26wnquhCKMv6
	 ZwvW3E1pMlm8UmJ/KLkNqZITA9RTVx1kCujROFUCy5DmqOdbg5eEBKM1Ek24tlopvU1Rf
	 P9VecRMBOUlYuU4y27GVU3XEPinRyzP3iayE21qNpu1ytl2wM7k5Ndlx0TECq7aKJorR5
	 b2GckcpEjZ+jx7QSyJrP7Xv+gfJzofUAJW6tu+0PGRGl3L8vAcBg4qrsRi+AhO/izxirZ
	 BE1Ub5BjUHTQAjcZ4L+YIvMwxIoCtwoqq6p7iQRD2PlHmepF1b3XzPcKvJecVDrdmDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711721;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=XGaC5zH9OxLWbOnVWqOsicmnD/ROA9cCyPla5J5sibA=;
	b=bE5NA0UR6Kvm6XDj7wx7YFvHCfHyMfdL/J+pvxqVVRSpBh4oOEjANCmar3xD0AIKJBBs
	 AsG3Q//o/qIbeVBDfKhmnbqVO5FF/a4bvXqO3Kmn70wODGhH2dOAACXMIabN4mMo5uKGa
	 2EH+VUeNDv8rP7b5GSD3hxBPmn+q8cXUoCMtvLvZYa7LfdU4066UN5C/G+Bwnj1J1v9BW
	 K8gQEYW4A9g3nNPUOO7sQ63kH1gm//kXEMWSY1ET/EVraecVtJ1CRGeS1f0ZHSSGdUdzI
	 eQoMwP7xJzGyZRlbRKTDozekZF0dDPtwpbuXWq9tovYiOUqnPDWtD6AIbze+FxA+o6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=cKngH5sx;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79922606A33B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 13:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79922606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=cKngH5sx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XGaC5zH9OxLWbOnVWqOsicmnD/ROA9cCyPla5J5sibA=; b=cKngH5sxugia5AaK5ewJBigBrJ
	X44+kfNWiKBjFSa2wAav3eE0+r9rEZ0P3lXMYnuH5LiSpbgH8YKVpHnAjDGH4KvhgQ7Vlx/gdWfce
	rYZ+RuFVVom+BrtxfMMJeO1e6+MHSRiYurO5YQezqgTBvUKLw6UeQc/Zbr3pU/y7dsbSFkPJch7OJ
	uDd8sfG9Wg37xSa9M8DXciXbfqMWUPEz4eHWe6gVTXKuHny6HpU39oh01cbHR2EQDbcIqcuoFxv7s
	Z6OJlg+dbQrI3GHaO2MTpTWn1uHVlmWvoG2UwgUc7yGUxUVxdQM8eJZtgfpGOvBDZHSwP+YkBd/SR
	lNRp8C3g==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xOEM5-0005UD-0t;
	Tue, 03 Nov 2026 14:15:13 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xOEM4-000EJP-0c;
	Tue, 03 Nov 2026 14:15:12 +0100
Message-ID: <41b4e2b6-ea57-4483-8e06-142e09cd73aa@iogearbox.net>
Date: Tue, 3 Nov 2026 14:15:11 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 20/20] selftests/bpf: Extend the JIT
 instruction tests for arm64 encodings
To: bot+bpf-ci@kernel.org, ast@kernel.org
Cc: puranjay@kernel.org, memxor@gmail.com, xukuohai@huaweicloud.com,
 bpf@vger.kernel.org, andrii@kernel.org, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, mason@kernel.org,
 ihor.solodrai@linux.dev
References: <20261103122733.1383002-21-daniel@iogearbox.net>
 <eadd9b884e7ca42ebd241f55d6bfd3dd1c9628927b1425e46db2f7197efaeecc@mail.kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <eadd9b884e7ca42ebd241f55d6bfd3dd1c9628927b1425e46db2f7197efaeecc@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28173/Tue Nov  3 07:27:52 2026)

On 11/3/26 2:06 PM, bot+bpf-ci@kernel.org wrote:
>> selftests/bpf: Extend the JIT instruction tests for arm64 encodings
> 
> TL;DR: Test issue: test_tail_call's 8-byte XDP packet load may be rejected as
> misaligned on kernels without efficient unaligned access (LoongArch, MIPS,
> some riscv64), failing the subtest; BPF_F_ANY_ALIGNMENT may fix it.
This can be added once arch folks run it there.
