Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84C3257845;
	Fri, 16 Oct 2026 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157677; cv=none; b=n/YoP2O7wCRUUX9eYUZvMQdTbVLw0sLwwv6mP1nQ7Yuu+xuCatiXpSS5Zn2VTpCi6Uh0ReP0IiWs9g0m6RncgppOgyphxEj7Qc1MKA+P8DD+/DhsJ6Lgu3jjKKrRaFSdY96Smcd4sAPlMaWlnmDeBTEkcKG/MFFXoYCfMgnIWoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157677; c=relaxed/simple;
	bh=XW42QnhWDic8dS551hKWNpt+vNwC58Qk9xk8pYcU3ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BTQmyKwZxn7aI3HaU/uBDJe6VPcwTZ7t7q9YtbjWvkwCfN49fhrI7aliepC8oyhgBuJ+09JGb+32cUJMHADPQtpM8RhJYvHqCaq0prBdFKPNXdBz5qpH8aig0/LNBcBF37W013z9+LlqLg2ShkhVP5efGnrmZ0IkjHtWIlglP5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=i8OEiZ1H; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="i8OEiZ1H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=rnVFGLMLcNNuhIR8pXHMwYYFl55NqqSkqiJxhHwRBQU=; b=i8OEiZ1HA2HUIX30MbfZljb8EO
	ErRkl2o0t8/OLm4cyAthkyhB3jDtBnT8hDp8KVxLY8x8YUsK1Ij5AY/NDhps4Eu0eyXKF0549jzIl
	2LZrhElezia8dX2CHj6p/UyoJyqBEZGbI/0q58RUiPs2/JdOkAGsKr8OXcVUTU1/O1wLadSgMbRq4
	/SCVNP65wDo+BJWER8fJ3A018ve1JUZ+Q0D1tSpy1C7XhcCcRe38wNCV0UejDQvvj2ctJXI3DrPxN
	gIOo9FpgOcZRljqW0xe4dQ8BAGgGjAuzwLw81i5SjsUVIv/ZskLCZ3RjxddgqYsuCF99M2QCj68Hu
	cdMyfLWQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHi4u-0004CY-1O;
	Fri, 16 Oct 2026 15:34:32 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHi4t-000EMZ-2M;
	Fri, 16 Oct 2026 15:34:31 +0200
Message-ID: <471a5989-721a-480c-8b48-4aeb6ec6aa62@iogearbox.net>
Date: Fri, 16 Oct 2026 15:34:30 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: remove unused duration variable from
 cgroup_attach_multi
To: pdsj2807@gmail.com, andrii@kernel.org, eddyz87@gmail.com
Cc: ast@kernel.org, memxor@gmail.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261015175022.1370503-1-pdsj2807@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <20261015175022.1370503-1-pdsj2807@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28155/Fri Oct 16 08:24:17 2026)

On 10/15/26 7:50 PM, pdsj2807@gmail.com wrote:
> From: Palak Raval <pdsj2807@gmail.com>
> 
> The duration variable is not referenced anywhere in the file.
> 
> Remove the unused variable.
> 
> Signed-off-by: Palak Raval <pdsj2807@gmail.com>
Stop sending untested noise...
