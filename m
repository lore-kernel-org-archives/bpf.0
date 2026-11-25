Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=131.188.11.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626794;
	b=aLds9mMcifQW9LRT+9cqNMZNAKe9OS7AqB7dBkUJ7QkVeAXS++egX6GMhgsdSnA8Fb5z
	 PY9x3CFFPSCBMsZ6DXG+zD/GPopqA5DzlorY6HKJ3mPJ5heacJySP3wQVhfb01Pywr4nN
	 fcGxzbc9WujAoUdc3GZ/78z+5Jd0ql4EwD4LTySa1JpeJUTMpbHmqtZJnxUYAdzqa85ZT
	 3MERVn/+TKaqc7ZycOqaTuIZU4BCLhJkKKeVtx5Lwjl6YgL5upCFNdT1bOqP20+vt0tON
	 JIsBZf0hKu4TIHNUwhSA1qpcjbfjmOH0mU1qKblcXlcfJu2CCms4GelOU6+kiRoSJ2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626794;
	h=DMARC-Filter:DKIM-Signature:Received:X-Virus-Scanned:X-RRZE-Flag:
	 X-RRZE-Submit-IP:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HglYw1w0jeDMCJ/kQ4WTqUdDVdHZn9HMm68hKLdPgfU=;
	b=g3dZFjfQWKVjAOuosbCgI56x++hVG+L6UAr1q1uLoDIXMPbZTBdRJRbouZvJQC2txrb6
	 ueLrriHAZIB8mFZcr87tNtdNiJiJDEUP6LmcG565X6NWBf0OO1zTJIMoXD8bxm4lrKs37
	 Tc0/m7sQfPaAR1ybP6IHoNWpEbb97Jo/CplmkrpFkQScjXSaPhg2iwzrf3q9+tEcW/1Uw
	 ol31arZtHC+j8mTh3DyE7cxHGlGsl2b4A41+MV6E737znPfKoRTSUfuY/bfhXxpC8ITAj
	 OhMVPouZ3AcfBarCkCFrrIXuNmEPc1ShDG12rOuz2aJOjAbNi3iu0Oi1k1dGmv+8KLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fau.de;
	spf=pass smtp.mailfrom=fau.de;
	dkim=pass header.d=fau.de header.i=@fau.de header.a=rsa-sha256 header.s=fau-2021 header.b=zuf1IGnx;
	arc=none smtp.remote-ip=131.188.11.22
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95571606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 17:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95571606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fau.de header.i=@fau.de header.a=rsa-sha256 header.s=fau-2021 header.b=zuf1IGnx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1795626786; bh=HglYw1w0jeDMCJ/kQ4WTqUdDVdHZn9HMm68hKLdPgfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=zuf1IGnxcK+axuzyzcg1Af8Ac0kQMIDRDJEF/oINAqS5VI2m0W+1FHRr9Fqc6+ajY
	 w3eBIrxPipNvl+0IkUexj1mAF1EQPd2hpiVWrya0Yo0iq3uaCJmPY91gfHN86VzFOY
	 nwBdDJhIVkoD9jqfYNt0gZQaIq/66gZWeWa1miAOenLox1TP/VN1W5SzhPovt1IHM9
	 MCKJ5LDWoTNhn9Vd5JUTfaVjnXRHWVbTDcR6aLL1i1s+RY9/+Khhb1cdmTRzGVltnM
	 43fRb+aa9iwwhq54G6ZaypqqIJjgT4SQr+m6qZCO4wtwnQOeJhSfC8BnPMO/CmXP5y
	 CCqBmQalF7Xpw==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4jZR8L1Rdmz20Q9;
	Wed, 25 Nov 2026 18:13:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:620:618:5b8:2:80b3:0:59e
Received: from luis-tp.epfl.ch (unknown [IPv6:2001:620:618:5b8:2:80b3:0:59e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX18LP+6FR0a9y68HOCOKPW5OsyBqjCc//iI=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4jZR8H4xywz1ydB;
	Wed, 25 Nov 2026 18:13:03 +0100 (CET)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Luis Gerhorst <luis.gerhorst@fau.de>,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: Re: [PATCH bpf 4/5] bpf: Emit nospec after BPF_ATOMIC stores to the stack
Date: Wed, 25 Nov 2026 18:12:47 +0100
Message-ID: <20261125-nospec-result-reply-d60fdc6da8ef@fau.de>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125040820.947816-5-alexei.starovoitov@gmail.com>
References: <20261125040820.947816-1-alexei.starovoitov@gmail.com> <20261125040820.947816-5-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> check_stack_write_fixed_off() sets nospec_result for BPF_ATOMIC insns
> too, but bpf_convert_ctx_accesses() emits the nospec only after BPF_MEM
> stores.
>
> Emit it after BPF_ATOMIC insns as well.

[...]

> +		} else if (BPF_CLASS(insn->code) == BPF_STX &&
> +			   BPF_MODE(insn->code) == BPF_ATOMIC &&
> +			   env->insn_aux_data[i + delta].nospec_result) {
> +			type = BPF_WRITE;

Would it not be possible to avoid the atomic/call-specific handling of
nospec_result? We can patch in the nospec after the call (next
patch) and avoid the speculative path analysis there. Then the design
would treat all instructions that do safety-critical stores the same.

In response to this you find a series that implements this idea. Main
downside is that this requires a new instruction buffer in the
environment, not sure if this is desired.
