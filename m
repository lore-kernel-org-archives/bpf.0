Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898A92D1913
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782162885; cv=none; b=DMLFjdh6Yz37rcBVBis2T1xX4pIumk/dnGRIhRP6EmCq89qGWSQ0KTS4d+IKY5al8aCS35OvNh3eUoBEdahn2UYIzSUBczWpjQMJmbB0/zulrYUe4tqUDyB07dX7MQyNdcNPGel3ZFOjFwf/j4zwdHSLBIk9aKC8fNqnyS55etw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782162885; c=relaxed/simple;
	bh=4QpHET2PlnHGKSjfg4/JEeSeBPHmDHAP0rMqRYjUH8A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XJprs/IChkCt4hZIOoGOlRZ15GKi7RuiqVRPPJ+lv/xYM3zd723F01zNOrJnPC90Hofv+b3axUfCpR0K0CTnfWxp6nlX3+j2NXezeVirF3wvZwV7mr6Nug/IXdqt6LNn49y4BwMOux+veGjUDSUWVZ2VxHI10hyNuiY0lo9uUnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8jFJje/; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8jFJje/"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30bf132969bso6109212eec.0
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 14:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782162884; x=1782767684; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4QpHET2PlnHGKSjfg4/JEeSeBPHmDHAP0rMqRYjUH8A=;
        b=P8jFJje/9s9KXyH4tedgTCC9xPz1kcHfrDFaEEv4mCpOzbL8I3Xf322saGR13NpCo8
         AzmNqNfKXiJe7nmuBUQtmwXa0BzB7JAdryKgEQ4oroNSc4hO2s6t4Eo3IW2ruWEN4KXc
         PZg7gJbWV65vjKxaLGgKaEdZyHF7ppoGx0vo/MDAVXz0gV/R0PANx/6PwsmPV1xVOUh7
         y+mAa5zu1D5/Jwe7zNXqq1PUX6Zto7llY4HC/58oWQlFOlHJ3fFOsgwU1OkrhHPqJKxN
         tEeXyPpZbeofcgksrPft3Tp0Mfkl/wv6JDrEKmLdmqsSl6/u1GoXykmbhJfTLrrUCKWG
         7JWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782162884; x=1782767684;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4QpHET2PlnHGKSjfg4/JEeSeBPHmDHAP0rMqRYjUH8A=;
        b=kV4n2kU3rFmBvudaAASoHHNgOFcM4767UBhtv8pfelw8zb8i27+8z9D96fbl/WIbMz
         UwVGobBVOai8Kww1zNJDj/J4czjI7ATMuEDQVLgn5vTAMBTdQN952feutToqWe9iIXjL
         9M4TF2kK/8joTsk2CLU03RVEnRvV1hN+LG2dJ7QlMNZqGeLzt9U9etvSTckItGdQ4tiG
         uJivRypTgKuXcy2kG9k8YY+EOsylQeGdo0NNsGZzAPEZ3fJWqycG1CJ7t/2UK4O+w3r9
         SRgyQYJKmYg23BwD99jxVPP4yGt6clLDdiUHL3Jqsrg5do0MseijH0cefeaKMoMBQXOR
         RppA==
X-Gm-Message-State: AOJu0Ywt8eXHfnILHIlXUQFDkhjrCz2rEywvKvECkj8l3hSrByeY5Mi2
	6Bp6wdQiEKzKblghAdkvcQiRk3RotOnLoezmZdyMFULXDTGJyRsBtl8K
X-Gm-Gg: AfdE7ckez3xPbo5wyoxtNOVfR3t16ev+ppy2M2jVdXgRx9F/NMCVCPgTJtXGG6vVcM5
	t+3BVAU3aIHg7BT+GKBi8wBsNVOb13jSwHBHVYzJGXDxAvfumcm7j28mxTohLbwZFEUGEfwNyWL
	19cVV4+exhSXjXFFOlz448hkdN52fd6XH1NXg5VQnnBJF8/VAO0lQYrMz7EiFfZDCXwjG5+wiiS
	4FiXe08EyxqJGTnw+PUOqqlN0dhdQ/1OULm8a5gTf9sGSy8K2dCEA/Pdw6heYfUFI1/JLJcWw66
	/uDndZOpyCCvxe3EuA4xm/hY2TTbA9zEsh2Ms7tb0TrSa6/w5QXhNKSw+9wtKTgwhzWz1QDTcgn
	v3HzhZm2FaynnI+u86qZ7+vWiQh4yy+8a0BUVNe0lYRog4llD/52vLyv15dIzH4eIwL1fWmSTHt
	enJHXNzp9eF5v7VuZ9QoMeVMtw9EJgDe30M3eQXsTI9lO6BKKwa0lz022wvR5d2wXxz/F7Wg==
X-Received: by 2002:a05:7300:1491:b0:307:26a3:75d2 with SMTP id 5a478bee46e88-30c06fb352bmr10436488eec.7.1782162883593;
        Mon, 22 Jun 2026 14:14:43 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:e520:295b:47ea:ebb1? ([2620:10d:c090:500::2:e7b3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba91120sm11783172eec.13.2026.06.22.14.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 14:14:43 -0700 (PDT)
Message-ID: <2b7a203caafb902a694f6dd17faae52e22ed5ab1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Preserve scalar zero spills for
 var-offset stack reads
From: Eduard Zingerman <eddyz87@gmail.com>
To: Woojin Ji <random6.xyz@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu	 <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, Jiri Olsa	 <jolsa@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>, John Fastabend	
 <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org
Date: Mon, 22 Jun 2026 14:14:41 -0700
In-Reply-To: <20260613-bpf-stack-var-off-zero-v1-v2-1-a324af0f00ea@gmail.com>
References: <20260613-bpf-stack-var-off-zero-v1-v2-0-a324af0f00ea@gmail.com>
	 <20260613-bpf-stack-var-off-zero-v1-v2-1-a324af0f00ea@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-06-13 at 20:16 +0900, Woojin Ji wrote:
> Variable-offset stack reads can read back bytes that belong to a
> previously spilled scalar constant zero. Today mark_reg_stack_read()
> only treats STACK_ZERO bytes as known zero bytes, so the destination
> register becomes unknown for such reads even though every byte in the
> read range is known to be zero. This can lead to rejecting otherwise
> valid programs once the loaded byte is used as a pointer offset.
>=20
> This pattern is not limited to hand-written verifier tests. clang
> 22.1.6 at -O2 and -O3 emits it from a small helper-based BPF C
> reproducer; the resulting program is rejected before this change and
> accepted afterwards. No deployed-program regression is currently known,
> so target bpf-next rather than bpf.
>=20
> Teach the variable-offset stack read path to also consider STACK_SPILL
> bytes backed by a spilled scalar constant zero as zero bytes. When a
> zero result depends on such a spill, mark the contributing stack slots
> precise before accepting the const-zero result so pruning cannot reuse a
> zero-spill state for a later non-zero spill state.
>=20
> Keep fixed-offset stack reads out of this eager precision marking path,
> as the new behaviour is only needed when filling a register from a
> variable-offset stack byte range.
>=20
> Assisted-by: opencode:gpt-5.5
> Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
