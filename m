Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792456507;
	b=C6jnrnq2nrh4i9A+88Dimd68Nk3sZgLjFOQHpqnPuKfROlS7LigZ1j6O9EJFc5+q4XN6
	 xnCbSf7rTsyz4NUUHkwQ7gdXgwO6fsKr7JMMjoJivVNAb4gESXjq6/usfvCNXj7Nk/Z+Y
	 K/3Zx27eQnDMq1LK6JfUl04cv3cF5YbtUfhVT7tSWHg+FfBEERFIQGkqT+dEmJwvYRkw5
	 6tkf/qv2fV6kS9LQyGFQO9NwKvBG5nimYgmX70WQYg97YFi4YaUuhGVUega5z/hM70g9B
	 8NBAK8euazvnxPqOjjDMMjgzp/pgs/On4otSmh80ej8kcFjBKQA52rERbKsSboUiO8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792456507;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=IB+xe6Gxh7dy0buYRUiX3GdOwy5s+dYQLk4bAMzYgHs=;
	b=kT2Wbzjs47q+IDAtCVAzmPzZDJhqwglX1XOPkCVE+mh0Mx9dW7gfubYV27ymNrl83uqr
	 MIquJ/vnP9AZOE5999bHIrq5NxPDb492eqx5iCD3zTeYSmeMRIDOO4ZeI5+ikxkAdMbbQ
	 hF6ZjuUNPegwISatn2TJnpRgVxkeHaq3wxKNsYMHmv13zeEKXLIXGmw6t5tW7F+Hq2Eaz
	 y/sF+vyYZGTjeIcxAHmFV1OAZtsySIJeEfoWz4jhQUE0qnldrybUriT8aLEyIsxg9vkic
	 vUCuK37EPJDSR+iuoADHn+SGQIl0nBUvbotvtlrKryxX56WfdhVLZ5kBSDxXEII+iYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dBImtXx6;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECC2606A31A
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 00:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ECC2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dBImtXx6
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a06ca6e8f4so983856b3a.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 17:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792456507; x=1793061307; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IB+xe6Gxh7dy0buYRUiX3GdOwy5s+dYQLk4bAMzYgHs=;
        b=dBImtXx6WjlRqgV2/6x7hKqgSh6+TUrjDkme3sIl9kic1Ei1LRv2HJ7lU9JUK8/3nj
         n55SniSRgzcGAh074Wa7HYQey5Pd0CfLtJk9ETV+CGVQ7hafxKWnjczWDgrIyDpSr8gE
         E1iCvKQ5PACxi8SB241Ft/2Gc1AvxOymt/C8K+CCWBm2640xStQN/iQ2mrx5eJ6+NBGZ
         fha6FTUAhCK6rijwI1P4HPHMbc7nHryXqpnejAflCtgsZIvi4+00V+kbJXjOrKZy4Qfm
         jLPDiG4PZPU3uEe4O8ujnD1/5iTELNHnUp4doV7Y+JuU/4vZRiKTiycAvbYmAAw+JHfU
         Gk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792456507; x=1793061307;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IB+xe6Gxh7dy0buYRUiX3GdOwy5s+dYQLk4bAMzYgHs=;
        b=Gu+6tx/jUNemFLqAH1J1Jfr01ca6fHFVMBwvGqJpfxRM1s9M0v0ikPPc3hsUdjKxTd
         iWE5/Ad2FjkAJ9fR1HAnU26gkB/9um5LswJwH+2SJxblFVZ+w4mOkFOJobvJ+RfIHDsC
         bp1GLCr6Qt5gdrHZdMSAxRL9lGXKw4f3S2RHqanCSXypkCSdJPid8fu6acDglDfEO49G
         RXDaLBom4UrVM/04siAGEul96XOL5X0F7+fxvtkn4662qHWCCALLs5Bh+jbNg+kK43vf
         QVzRL8fxTqOAz4WxLV8wWSxS3eLS68lu+HywYLtjbpfD7iYF0Qd6bQWcXkzh0qPoiHMd
         v2dQ==
X-Forwarded-Encrypted: i=1; AKwUvBwDYD106EJf2o2T4Z5yzzVdYKDbIzOKcE5+AsbhRfS1WznbOdTvieQ1HW2bDhN0ZvCg6Zs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+LiLT+G3VmPROy3ILAXbUEclFPt0bML3VvXXFTTbKeJwMVs8k
	NHaZp/I0X+kfqNcDi2eMaGe08Os6FZSZdjjSLRYILjLS16hy/9HKJ7IHzFNKAQ==
X-Gm-Gg: AYBFou18KB8MB7uk5LV6b4v4Mhscvsh5shuyCg1DfwsHE0yAkKQH1xtPjwg9TMsnO1Q
	rHhGfEb7BUcRvKrnx0UVV8QHFesPXUX72qVKcVAhM9NbyjOMvmi5FkvpBCEDPEyi79WqFD4uqlJ
	8QKluWgfMsKTJFe/glsjYMYZo9F9vBygeTZbPFFy+QWsxOieqwursljGkdyQElDAGCrxkCJxRa/
	pHjAmhlckJLKjbjDngGJikF1DcDSLv/sRn3m+10AbuNlwDxn2/3uIg5f4YOT4ykYOfLSPBxLLtw
	86poARAbtj9RekpMErVOxhHqREN2G35dPJTpWaqgGk1vLtonqQAcNKorAheTHeM0UYPSyNi66me
	ezyX7W1dqhLIhVgvQXMb7rXcsgd9GW8L8gEV4vwg9oCxNg/nUudQoyAqJ7Ldq3ocBATIHZzM3LX
	VIpZybRqEc5xe0Z5IhkJqe5WDSoVsG+NftwzQa3wYMzQU61ND6TmIWCHKwZ/5ikJFBAE479PL2G
	q3qwoic428FfLdkovjR+T5dz7wBs2W9UbqJgeXSafntLY3MVWwoTQBOT5D/Pj3xnJlZkhm4a2tL
	ytU=
X-Received: by 2002:a05:6a00:3d13:b0:89d:e6e2:b2a6 with SMTP id d2e1a72fcca58-8a04ce4e86bmr7640659b3a.45.1792456506727;
        Mon, 19 Oct 2026 17:35:06 -0700 (PDT)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a06b4d1a7csm1496547b3a.45.2026.10.19.17.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 17:35:06 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 00:35:05 +0000
Message-Id: <DM98SV0GW8PZ.30OUT4OGNRX17@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <memxor@gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/5] bpf: Unwinding with unwind_goto and
 unwind_exit
In-Reply-To: <a54f8bb126343e4606dbc46f0dfc7c48f6a08c0e.camel@gmail.com>
References: <20261019051846.3012089-1-alexei.starovoitov@gmail.com> <a54f8bb126343e4606dbc46f0dfc7c48f6a08c0e.camel@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Oct 19, 2026 at 01:32 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> As far as I understand, the main difference from what was discussed in [1]
> is that for nested calls of functions that can unwind, each function
> in a chain must be called as call/unwind_goto pair, right?

Right. Otherwise prepare_func_exit() rejects unwind_exit of the callee.

> LLVM IR does not have such limitation: `call` and `invoke` calls can
> be mixed in a chain. What the limitation buys is an ability to skip
> the loop like [2] in the verifier.

It buys more than that. Every frame returns through its own epilogue,
so r6-r9 are restored by the frame that saved them, and there is no
stack walk at run time.

> Is it planned to add an LLVM pass that converts all `call`s to
> `invoke`s for unwinding functions?

No need for a new pass. The llvm PR does it already: a plain call that
can unwind gets unwind_goto to a pad with 'r0 = 0; unwind_exit'.
does_not_catch() in patch 5 is such a case.

> If I read the series correctly before the replacement runtime control
> flow would follow `unwind_goto pad`, but after the replacement it
> would follow the normal continuation flow.
> Is it intentional? Seem to be a surprising behavior.

Yes, you read it right. An extension is a main prog of its own and
unwind_exit of the main prog is exit: it's frame 0 in the verifier and
bpf_is_subprog() is false in JITs. So the exception stops at the
extension, and the caller continues as if foo returned r0.

> Commit message says:
>
>   > So is freplace: an extension leaves with exit and
>   > the callers are ready for that.
>
> But I'm not sure I understand that.

foo can unwind, so check_func_call() made the verifier explore both
ways out of the call. The normal continuation is checked with an
unknown r0, so it's safe whatever the extension does.
Works out of the box, but maybe it's easier to disable freplace for now.
