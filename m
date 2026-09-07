Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ACE3B0584
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788810834; cv=none; b=Vq0KvHRF9vdpN8ONeNJ5pua9rzuA6Zj/BSzHHTtC3ZQpAk6vOB3+6ch0ipC5Xxc3UsBH4aWoy43XyWF3Qy8Xzn1DEASST4e0BFDHhOegTw2WIrMLBKdTN6SSEbVofBrS8oKscGnZ8N/VfvBzEiUUrLLP8xLZ9BgZuBH6vKos2Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788810834; c=relaxed/simple;
	bh=I3c0oIC1eIG9gyarKmr+vC5SuggorGRryd0CWT7ZRBA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Hb5dEsfA/lwMw6ndCWx8lOZlu39NeZ/sMZdTcM7TWHnHcZkTtJrBocrUjiXPzFj89ejTGe5Swu6EchAfYtIwv30mrcUbmqjXiYv3Ed9iInNf5sTgYaEkfK7jI6OUmmKaRKDgr9e0hFlHkSe116AB0wYd+r8lCT+DURg16mO5h28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pGVt7z0Q; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGVt7z0Q"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6aa9606ddadso2724361eaf.0
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 12:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788810831; x=1789415631; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iteiCnihd3zHTFa6ZUKS6xmLP72CsgzAuDTMuCMC7TU=;
        b=pGVt7z0Q/c3a6+iQVr0jpoawyrLTU+z7fNKTeM7m5fd71UXHi7n0WV5JXVnjq3eNJZ
         ZI39IFpB+o0Pr4eq65BJXACLMHah8ELJckvP3OuaTKw4TSQLiOoATdcyB/LhTZtr01wW
         OLNnPZIzdkKpEfk5+YXzhdsVhR9O52gnb0sCef/ed+FvUn0qxfQj/a7JAqLITbzCGYxv
         p/XVKSXvlfmYg8kH92x3GtApo0UK/IINl9/hAfDJ4nNB1HcdhyuGA3OhLAnKf7/ri7mM
         EOSTIEhJZxBMkGWor3lx9M7DwVFLEkeNe1B9LWalLLPSYMwnVrjPyMXE1laCw3ofIRBT
         ZdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788810831; x=1789415631;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iteiCnihd3zHTFa6ZUKS6xmLP72CsgzAuDTMuCMC7TU=;
        b=UVFAIhdPVgfRWRhk7vvRHegtUzk0cmslv03ij/DVDJYN7gMNWkgbYIdeZ+nqNGUzIW
         HhlUmSImNKleXrJboLkzaKeloyDNU9RTFY8HbKjF7ia/ucp2JGetL61bKrdC4pxcqvDu
         rzkhzEfVLQ2mxFhFGiacNnxW46ekTNVgLztzAC2vhYqj+6N52ExgcqWcD7ysJ5Tvz/rg
         AA4nec6hQDefWTCAGlOrmQFNx+xl3axwAbfBybDcFo6joWfARZumjKNJi+HCbbV3+RQn
         mhX03spgU+AW2FuIJk1OPkR+qtDzwFpWCDi3/N33gho8eVm1IT/D699xTZ1bpmn33pI6
         gwuA==
X-Forwarded-Encrypted: i=1; AKwUvBwZjM99iVuMJ7snn7eK12LwdACj/Y6UhrggxTs8aq5d7CUpShA1w6aW6Za5fdgUx8vn2Yg=@vger.kernel.org
X-Gm-Message-State: AFuF++laEHvZ//NDvoDdGFR7GGzmYIyu4J4rcGkPX57Jo2MzeLab8lEa
	PBsVxvrhnas3zv98wf0nIo7mrl516mwZ7sqqkD7x0c4kfTqLVKtnoy7Q
X-Gm-Gg: AYBFou3zThY9ZvyGpMhaLwZ0vh1neO3umiFz3Qy1+r6An58C6NP2wE7urkE2iy0SptT
	HB3TSr5hv0P5Xx1bvso06BVIIp9X62gykl0zGLPQgMVdQyJxXLnoUhHKD99YtPcq17LZhfzFPIo
	17LKHOQGO1w7XCOZLmDfqPJAx2IA49J7JzxaCuMjHgr4nJ7HdVG+MkhZl7UiXcbBNC3FZZysdgg
	1JyfOkxAPFrwhkfw4/+WYDvtkyqIJytW+PoyoYY+qG1VjLuojjpnKT1TgPGZqrZoFtNaPndw7Hb
	MbVYJnnSm6cPTsFcVMY8DDS6g1iXdhE0CgQ9JFUQetME+IO9J+rn2cPT02coPZ1hjZyI8JVD49i
	KKbpsupds6a6PLhnS12oJq9IdR9mc4cHQU6zowZwzwwVUBtl6SocECeD682qeJdgqpzR1Iiez+1
	mRvEzrAJWdklbUh2Lx8fqGwdq0+POplVNk2fbMWWJun9DKHucbOFcqg87So/YafSN2Y93m1xcMP
	gkRxhvbfIzjcnf3Vs2K+deuC8s3VOxmUhioZ4QPYWdHMpNiEDIsoLs=
X-Received: by 2002:a05:6820:179b:b0:6b3:1864:18ac with SMTP id 006d021491bc7-6b6fcbdc9bfmr15030867eaf.25.1788810831572;
        Mon, 07 Sep 2026 12:53:51 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:50::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6bab80ba74esm4617992eaf.10.2026.09.07.12.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 12:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Sep 2026 12:53:49 -0700
Message-Id: <DL9CIMDBZWIQ.2EXQYQI34DDCX@gmail.com>
Cc: <daniel@iogearbox.net>, <john.fastabend@gmail.com>, <andrii@kernel.org>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
 <jolsa@kernel.org>, <tangyazhou518@outlook.com>,
 <shenghaoyuan0928@163.com>, <ziye@zju.edu.cn>
Subject: Re: [RFC PATCH bpf-next 3/6] bpf: Reject UHMUL/SHMUL in unsupported
 JITs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yazhou Tang" <tangyazhou@zju.edu.cn>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <eddyz87@gmail.com>
X-Mailer: aerc
References: <20260902070534.2141812-1-tangyazhou@zju.edu.cn>
 <20260902070534.2141812-4-tangyazhou@zju.edu.cn>
In-Reply-To: <20260902070534.2141812-4-tangyazhou@zju.edu.cn>

On Wed Sep 2, 2026 at 12:05 AM PDT, Yazhou Tang wrote:
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
> index 3aa3ea0bc30b..dc60a931c364 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1325,6 +1325,9 @@ static int build_insn(const struct bpf_verifier_env=
 *env, const struct bpf_insn
>  	int ret;
>  	bool sign_extend;
> =20
> +	if (bpf_insn_is_hmul(insn))
> +		return -EOPNOTSUPP;
> +

Please add arm64 support in this patch set and may be one more like riscv.
Just x86 is not enough to see whether new insns map cleanly on other archs.

