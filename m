Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.47.207.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312672;
	b=lDw9JdDApu+XRSZfrlYGF25pJ7JScDBpc/pqlaSycyqPIvSkPecIFHNnzx+AhonG+kgH
	 9cHAJlymiBMIncpbcoZTkiJOlOhpwBLNeR/wN4yHVSx0qVC3KtrG0LgLEUKuViGZazK5q
	 1Pq+KgKqzccLIQOBH8rd/ejH++4q/U2rCrlnvakx4iyqIGSAetTqk17oeKM2vTHeB+W+7
	 j+e9rFofwtkOdiq9BJmZ76erW//f/DaLRot8YiQnffFxGnfqPMS9k0HocC5NTId+vxA32
	 lIS/V5KC9/vzw+v0bwEX7JAbc4QQni27R/kHienZJIJ/0aVmN2XsFJvCdJ3UV7Izqzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312672;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Received:Received:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Smtpcorp-Track:Feedback-ID:
	 X-Report-Abuse;
	bh=dyT+ihmZRHBjmheITrRDtgrZmMUouv6nHmymzXaKw9Y=;
	b=0t0FX3/NIe//7rkr/2J4DdR96kq3n3qYeNW0WqvNwgE6hIeUzVzL5xpP9v0SwJ1tVQXJ
	 PSvnwsuC0vAGNp8xVGHC/SwL+ibYMR2FN6Nx7pK792A1rXkkEd93G/8RHhmhdlmbPl/NJ
	 ++Zqhfo6mPH03k87w2brNuM+TzcmE205xLxbPyIScU6ce5ikrv6h1xbrQOMHADmZqlkwH
	 Xpae6UUQPvL5mPk28H9ZuHqkjo2OTKcYgNPv2+NaxGNQRYKVzUWgyJJYRbfS9kPftkQlb
	 dv78+B3EKttOsi1Ybuy6FyzrvjhevhZywPjfRxoKgNrehZJwK675PPSnA/yHV6IqpjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shangen.org;
	spf=pass smtp.mailfrom=em879706.shangen.org;
	dkim=pass header.d=smtpservice.net header.i=@smtpservice.net header.a=rsa-sha256 header.s=miusa0.a1-4.dyn header.b=qedIvTJK;
	dkim=pass header.d=shangen.org header.i=@shangen.org header.a=rsa-sha256 header.s=s879706 header.b=MWmSFQzi;
	arc=none smtp.remote-ip=103.47.207.181
Received: from a2i949.smtp2go.com (a2i949.smtp2go.com [103.47.207.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8D0606A31A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 22:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C8D0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shangen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em879706.shangen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=smtpservice.net header.i=@smtpservice.net header.a=rsa-sha256 header.s=miusa0.a1-4.dyn header.b=qedIvTJK;
	dkim=pass (2048-bit key, unprotected) header.d=shangen.org header.i=@shangen.org header.a=rsa-sha256 header.s=s879706 header.b=MWmSFQzi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=miusa0.a1-4.dyn; x=1793313571; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=dyT+ihmZRHBjmheITrRDtgrZmMUouv6nHmymzXaKw9Y=; b=qedIvTJKE3yMjhN5TOW9++MiF2
	weyk2uvsvbv/0esDf4/nrTtt04HPOkKZB6TKXCf3r4t/JAeSLni4+cR+XTR9bBvrHMgWv2sgpTrzz
	BGYGK/H5ttYCUcwAeplJ7eXeP2ErOn3n6mKd7aSF/bZaXCIH119QB6G7O3b1NmVL2s5OkM8pwfHJb
	WQonS9CG1raYh2YeYxIWUWw8Ni4BjT57c8W7MuhaLQ2DcaA38xXsdac50iVenIHduQZzSW5SySSk+
	maroitWUt7vmViCbhIw+ZVdKTBlmpgo31O0sFeDcogIMI1UHpIZvCgE4DeiUfALnWvpfJYMeQJqWP
	+Iwb9oUQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shangen.org;
 i=@shangen.org; q=dns/txt; s=s879706; t=1793312671; h=from : subject :
 to : message-id : date;
 bh=dyT+ihmZRHBjmheITrRDtgrZmMUouv6nHmymzXaKw9Y=;
 b=MWmSFQziP9EQ6ojrz6+8W0rZVviHhMz7wrJ5NsUFNpStH+IzXWkD9qBJb68Tt/eSWaAZm
 2Ssiy7lA0B84jUuB6tae8W88bLbFuRsX+SsZJpW9/sHKRD1eIIspa6sTAZqPccvy26gXuwp
 eQdgpC9vIq5TBD9Pdj4jl8001HSJm9uurWstdUbimKbUIccnOTYm9PehNy0/qUNiK72yDFn
 a9yfbvV32ZvCtCgTDSCLtMwIQVn9T906pKupsOGP1fiZhMnj+CM/TPHb0uyyZaqDDLMIXO1
 7jpvsU2y8YXgmMPQa1ud51y6n+YWqgaF1ja83tk3AOxEGBu62aeKGryq3x/g==
Received: from [10.45.33.53] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <sim@shangen.org>)
 id 1xMYXQ-gL4TgZ-AO; Thu, 29 Oct 2026 22:24:00 +0000
Received: from [10.195.244.224] (helo=sse-laptop.lan)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256:X25519)
 (Exim 4.100.1) (envelope-from <sim@shangen.org>)
 id 1xMYXP-4o5NDgrmO6N-dUpy; Thu, 29 Oct 2026 22:23:59 +0000
From: Shang En Sim <sim@shangen.org>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Shang En Sim <sim@shangen.org>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Mykyta Yatsenko <yatsenko@meta.com>
Subject: Queue "bpf: Size backward jumps by the insns they jump over" for
 stable
Date: Thu, 29 Oct 2026 17:23:38 -0500
Message-ID: <20261029222340.870378-1-sim@shangen.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022-jit_size_fix-v2-0-4bee6921b218@meta.com>
References: <20261022-jit_size_fix-v2-0-4bee6921b218@meta.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: CnWv35rIuPYp.9xtLHVJKvIHd.aGvO_A7sl5k
Feedback-ID: 879706m:879706aL5FzMA:879706s0ZNmKxbwB
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Hi,

Could you queue this fix for stable?

  commit ebf0ab370bcdcd17f4faa204e1d2cc8e817ca6b1
  bpf: Size backward jumps by the insns they jump over

It fixes the x86 JIT stopping its sizing passes before jumps converge, which
makes a valid program fail to load with -ENOTSUPP and "bpf_jit: fatal error".

I reproduced the failure on 6.18.59 (CONFIG_BPF_JIT_ALWAYS_ON=y) with the
selftest program from a938f51d3522: the load fails with errno 524 and
"bpf_jit: fatal error" in dmesg, and the same program loads with the fix
applied.

Thanks,
Shang En Sim
