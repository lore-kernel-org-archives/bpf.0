Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425179;
	b=Vbzgg0wixdAsqtgpqvxA4qO6HxzAm8H40Gtcep00AKJ5eWJ1vxrXLkLBFQyETKmT3Pm6
	 /sdB4x7tRhieECdMIJTuJFwHwJeJEoQ4RtlWjvK0QgHz3143teKeFNNdsh6Rv/3LEQ2Qc
	 kTU+uFR3bCJXCRVgE4IhFFoSk99ansWgh7ufbxi787TpMwx4XXqtoAP275VPmijPcxsUu
	 +qzkn1Rv32GwbzMlMx3LyQzkWrfe9zqp2gZs/cctGVJC1i34RH9WTBdoLMuA+SLjcly6K
	 dWlI0vYg2SK9KArhlluQr6qYv5dxkUjOMeUkwET9WNAQ2qNTkxfkYuyFiL9kgXA1rMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425179;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=dAJhdu3xWfKg1jyCP9rn9WCEcc1htmiaSuaUjrTuy0o=;
	b=0vOt+YkkvozpELfvWfiIUI43upWopWwH1v8IKu3KNWeJncpgSfLRvU2TviJQzF2kjfXd
	 eWNjjC7VIXHuDWQfbvxb6fWBgL65384lK1kHEs+tgiPn3asiEhCzKqn0jx5FWtvJDGrUg
	 NJsl89WHzQIC77E8xGEIjxHKSOmzaZKRJ/zapYwcWOqsWJ16cXr8geHUHSMeXUGyQ1B5L
	 1yG3/hTibXYeKboh+cbuvBsCSAl/buSJOBUnpcAoKSnGJ9i9ux2b2OAzC3IHtxclN2jfG
	 6QZXzElJEoc0Rn5TPyWYMuMqrzLBNdK9FkF4jgZw2HDGPkY1z1UyKI+r3+qPmfwZrnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=q4chukfl;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD2A606AAD2
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 15:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DD2A606AAD2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=q4chukfl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=dAJhdu3xWfKg1jyCP9rn9WCEcc1htmiaSuaUjrTuy0o=; b=q4chukflo4qGTE36Ct63gtcSRG
	cLiwV7l1IrDirRhdqYArGzUbz2bW5qRuK/jVcywPBZihFGtWik9BcsP07tFSot+GJe07RfydWVvEP
	dU4V1k9mQTENUkGEPuavei43r7zpHRRKMyKZlfqYuh4vot4coTNef+YdCT5AKVmTssaelaKkS6E7r
	cI2q6jhMjwc0hYATuPIjmHljoKk6bmN24lAfIRlbbtdBG4IL7XqVZsCYxtI1SO47e5ET/zszUJnKb
	kTaqUIFy+TRlKojFngH6a/XnMygm+ky7MuxEuqdt0BZDnPeu6rqzP/uW+42DcsC+bLra9XbXjQGGJ
	gjCWXtGQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xIpfM-0007Nk-1y;
	Mon, 19 Oct 2026 17:52:48 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xIpfM-0002Uf-12;
	Mon, 19 Oct 2026 17:52:47 +0200
Message-ID: <8e7fd9bd-a970-467f-8dca-8dffc7071c7c@iogearbox.net>
Date: Mon, 19 Oct 2026 17:52:47 +0200
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
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Test that a signed program
 with CO-RE relocations is refused
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 kkd@meta.com, kernel-team@meta.com
References: <20261019144851.4052056-1-memxor@gmail.com>
 <20261019144851.4052056-3-memxor@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <20261019144851.4052056-3-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28158/Mon Oct 19 08:26:01 2026)

On 10/19/26 4:48 PM, Kumar Kartikeya Dwivedi wrote:
> Load a two insn program with a junk signature and one CO-RE relocation
> record, and check that the kernel refuses it with -EACCES and the message
> naming the relocations, before it examines the signature. Without the
> check the same load gets as far as the signature and fails on it with
> -EBADMSG.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
