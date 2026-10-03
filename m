Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5318941D648
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791030393; cv=none; b=MUUA46RE83exk20zyZOVk/SzMKkc1z40Q+ZoWufRbq7bUEbUSh8rxSOFAB7IY9ZaZZTMV46NbfOJgzcxqIAMvehoMUgv83jGorRn/FdfOg1YZvRiDnEkJf7CaeAH4xy1GBuwkDwc/6kQxO30PNOPPSb0B7vnXwYDN+uWUG05bFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791030393; c=relaxed/simple;
	bh=tMNk9xXn/8/QLwLZhGeYbz3KTI0eZs3dJXEFJHR9kaI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=UProV442EgQmNnvUFII1qTlbB1fJkEuhqKCNp8Q5yLw/v7umirRuoPWUajw62JZ16/T79rPUehdtWP1bTAVmwpTCWK4uXZfOmoQ3sxBUcbmkYBCdcoW3FNxZC8o5VDiQoZDx9MWB3078bVqJw3JXuBN9s2t4pYwwokOCMgbRiyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilmqjpcY; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilmqjpcY"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24afso90525a91.3
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 05:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791030392; x=1791635192; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KEFakFLXqE1dz/kBByjhcvN1VdcTzWWCXJmwn3Pv+m8=;
        b=ilmqjpcY9Zt2We9/oimBsO4wmplULLB+pMErBsJQVWjWJvVN8Upku4/+Yw+5B18kwf
         rb7XXTG/253VmdlrHPcL2kbhvVnUPiDDRqPu9zEyhmDH8M0KwF1lcOlKGQvzxjM+Cvf7
         H5iYbI/I6lChrnGyt0MUhecH2hjOPAw4Vk6qF73SWedGpC71fagGWOSXVrU5RgmSi+eu
         BcOlOlI6wbX77Fv5LVTNFRp+pxqUPL4ZMKD4mr8Xos8MLLB1UpDAbdA9k/fOhLdmRuHt
         6FjQZlzbvPIsj9Yy1T0AgdukhdZK0zokfH85iAnqOpMAQePyN2yWWo/7NPbEe56yJVcz
         A7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791030392; x=1791635192;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KEFakFLXqE1dz/kBByjhcvN1VdcTzWWCXJmwn3Pv+m8=;
        b=lEfC2tkiocGgMO88Kk7BPeN1N70ve7Mo8pdLnwJQJvZ49KO9jSCtDJ1B1W+3wWzLxs
         rWXI2evXUOzgz+D8qtpHwly92FAklRbn3zUbq2iuVuNd9ZU2xqo73QWGNJlEa3x5qsdn
         VIsSPj1geG7FOrnAWI0Hw6NBe/boUEz6xazeYD7IG9NXHeVGs22bYm/7cImKYF5rGBwz
         3VEmU0ZISuykgfws4ankSdZVB0OdJgcGPXqPIb/UxWE5hPHXu3axFSlf4L22Lr3haveI
         D0GikOa8alvgJ1QYWYLo1T2XYwGqRWro8qlHYC0si4J/1eh5UsXsHCeSdo5A0xBPEeF/
         thxQ==
X-Forwarded-Encrypted: i=1; AKwUvBzlrtWwqMCpIosoLb4NsLt1YeAc470tkLBnJjaABXpRri2OkRiHB3x5BTz3aaVh4nKkqWs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLG5mHPHQij3ye5SJtu2Ugg0R20MX2wsGDMlXr4OMavnKk0txdG
	mNcnkfHFdxd/5IRHpieO2kNTS/hO3d51FEiW34rNoBkJa02LjMAFC8QS
X-Gm-Gg: AYBFou3LNaO1TDSyUXJFjxK+h22r/I74K/olaZMWNDtiYXBHS8D7aktg6CRaUE8zzVM
	7aO744ZfHQ0idXu79nvYbcjjCtAiNYKl800g+a+aSM1lQnCRvM9oWi0YKqH8Ps2i1giz/W/LyzM
	uOt5RPjd1NDMgElmJbj8km9yQAmYJy4TjSe2fqlWFOFom+dEUXnozz20IeywrgGIa6PAygQbT10
	+ttaFvTPT0PdkTaTdPosxPN+Dr32/1nwdDDh4/12eNrOD931mj3Oin3e99ftVUWyaeEZE5sceMv
	YKxPfBmZTgqoruqe7BplgDD4kpo2m1y9vAA5KE6QNzf/6ef01Pb5jIIwdWkXho4P00Tzc6vQzIh
	GW1SqVHd/jrNFqgvTVQv010/MH6iirvRpufCXwdWbW6cdDubZ7SQOosfx+7DH9bSRdU09aNEdUq
	YfD+rYeagKZooXvgbWNdXMQymM3BteiZ7BZ7GxGulatbropNIFfsRpn7ojnZBUmdV27uKbCOLPY
	b+ztXIOT6PGVI4Pp5VGSkvbTQh4zelogUZrSENDFxP2eiSUR9wHUugXpRZ6ZP9rhkTn1V+FP9zb
	dNg=
X-Received: by 2002:a17:90b:3846:b0:3a0:c717:2db with SMTP id 98e67ed59e1d1-3a6ce7913eamr2502055a91.27.1791030391511;
        Sat, 03 Oct 2026 05:26:31 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d6610a2sm2991731a91.6.2026.10.03.05.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 05:26:31 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 12:26:30 +0000
Message-Id: <DLV7AATHIGX1.2HXVWUG223ANC@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v8 11/22] bpf: Dispatch cleanup pads by
 rewriting return addresses
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <20261001133103.1340994-1-yonghong.song@linux.dev>
References: <20261001133006.1335369-1-yonghong.song@linux.dev> <20261001133103.1340994-1-yonghong.song@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Oct 01, 2026 at 06:31 AM Yonghong Song <yonghong.song@linux.dev> wrote:
> +	if (!bpf_prog_need_blind(prog)) {
> +		ret = bpf_exc_attach_main_prog(env, prog);
> +		if (ret)
> +			return ERR_PTR(ret);
>  		return bpf_int_jit_compile(env, prog);
> +	}

bpf-ci is right. The table of a prog without subprogs is never read.
Drop bpf_exc_attach_main_prog() and these hunks.

[...]

> +	rcu_read_lock();
> +	prog = bpf_prog_ksym_find(ip);
> +	rcu_read_unlock();
> +	if (!prog)
> +		return !ctx->cnt;

fexit attached to a subprog in the chain stops the walk here.
  main -> A -> trampoline -> B -> C
C calls bpf_unwind(). The return into B is rewritten. The next ip is in
the trampoline, bpf_prog_ksym_find() returns NULL and the returns into
A and main stay as they were.
B returns 0 through the trampoline to A at callsite + 1.
The verifier didn't see that path, or removed it as dead code.
