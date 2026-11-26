Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795683607;
	b=q3j04OOeKLYk1/9fOBjDwlagt++9R+A0xrviTQuza56QIhNSFAciVFJE7RJmWqtRJ8jx
	 kSXAKpxtASJdb44E6dkBYV9T4WsU3WKwiCJTuiL59UyNqTAIFpLF1YHKLvxCr5hd0yrFX
	 dJYXp1L0ZjuFbTy747DOmlN9jAYakvGNVsRLhImsf6iCyW369+3AC1RnCN/yOyzyyh6xB
	 aCPR2i4bRI7pWlcLMq1OwIMTwnzn0VEBr8D/KnD91Q9v6hlA3jzjodsh4PjiioXiAuZR1
	 DFNxlHQBUxXnm7uXMa//1fG1SeDlNL4VjQ37yMw/zpfmUTIKuDlXWz0IazvJSIwiSbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683607;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=XWc9l/n/H7bJbx3lHtPUl0s9E8oVNwjrUifrHkjo15w=;
	b=BYuX6leynWyPEguUqNURZVZJrSoZagqo9zLfCFydJTQV0suGdirbWENUM0h8j1piArXE
	 8iaECzqlbpSK+EP0foo5gWbpzDgZ237w8elRRaFH0sobQluowo+ZKaZBi2grE5mKwzJyl
	 hLlf80stfJavOWuTsMyGV2NMLJJ9V1eXE6Ipo7WTvOf7329U3xfCN+N3tjVnvF1ZKjy8H
	 oCa0rya1uXvl4EgRmuRgiMus/g3X9x1BSt6gizttxkyTQjyafjxzOHqFQ/veNUpHZ4bbQ
	 /LJnmGqi/Qrg7CJSi416js81lQBe8btQw44QGBf8VqYCzighv5DIZldIoO0wQc3v+tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=M2L5KZsd;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B6F606A33F;
	Thu, 26 Nov 2026 09:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40B6F606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=M2L5KZsd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XWc9l/n/H7bJbx3lHtPUl0s9E8oVNwjrUifrHkjo15w=; b=M2L5KZsdrnmfbRl80iyvgmxeWb
	U3LQxUY91LKVsYI29qjR1fqJkA9krQhZPbEAdCOHkkYN2I2Yn6vr92ia8k+d95w4hKvIELtdJLqPJ
	Z2XrXoZZqUTf7KubU1cQ+3EmU0yO41Ecg2FnhdjEAxNtPQdPcBEpg/AwMK5SP8iyY3DKCMspU+QMq
	5dTpllo+qB9z48OPBxZsPyLjqBSBMjLCPPVu6NZNG78wNMG1KLdASVjagdKQH9RlQ6vXYlItDR0aO
	5Q5fOF3/BTQSWt2XNvDkaUJ6GzwmogvY51ymg+bmur5TFAvhmS4DUFMItaRa0kA1u06jPYMrJWhQ6
	NlXEkbCw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xWVKa-000KWE-0N;
	Thu, 26 Nov 2026 09:59:52 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xWVKZ-000ID5-2L;
	Thu, 26 Nov 2026 09:59:51 +0100
Message-ID: <365029b9-785b-411d-859b-1f06c2b51367@iogearbox.net>
Date: Thu, 26 Nov 2026 09:59:50 +0100
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
Subject: Re: [PATCH vfs.bpf] bpf: Read security.bpf xattrs without caller's
 permission
To: bot+bpf-ci@kernel.org, brauner@kernel.org
Cc: ast@kernel.org, kpsingh@kernel.org, dwindsor@gmail.com,
 bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, song@kernel.org,
 andrii@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, mason@kernel.org, ihor.solodrai@linux.dev
References: <20261125211928.3481451-1-daniel@iogearbox.net>
 <6262e5090a78f9ff8760d62be7c78067f4daa988ab01fc6659c5f60ece1d7d1c@mail.kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <6262e5090a78f9ff8760d62be7c78067f4daa988ab01fc6659c5f60ece1d7d1c@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)

On 11/25/26 10:58 PM, bot+bpf-ci@kernel.org wrote:
>> bpf: Read security.bpf xattrs without caller's permission
> 
> TL;DR: Skipping inode_permission() for security.bpf. xattrs may let a
> sleepable BPF LSM program send FUSE_GETXATTR to an untrusted server for
> disallowed tasks, possibly hanging root's statfs in D state. Should FUSE still
> be refused?
Hm, fuse was not on my radar, I'll take a look how this could potentially
be solved.

Thanks,
Daniel
