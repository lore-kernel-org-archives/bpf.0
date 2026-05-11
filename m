Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ECC33F589
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517515; cv=none; b=JJ9dQQ/UJHuEjjE2kPLN9quwJiU3/c+SVVGzt4acxHleUx2UtHwa4gZVCiA7dWqxIsyyHkcbkpZQokSJAPfdT7uUZMz34cydHrE+xSOr6TaE2+3UE9B+J/45+U4DOBqVCClaPXmb+qm8ysobXqhZU5i+bFztSwQHCGqITDOH0+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517515; c=relaxed/simple;
	bh=W8+uraJ36aN5Wh9Tfma8uvw1D12emmPgIKXCAb9pwP0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tOFtYrT/XGl3eTSY3BsaTtLX5LSG2q509DLGTwlbiLfoWd29ypctMXuF0edNgBfBwd7/fA1b6VpZP34g5JKm5eYPjkTagc2HUFkIkh3MG+gMXTk7s/2Sog5zsx7LjTbx00hN+HRlStk8Nx+lXc6W7vlRk1svBpjj0azA7KEznu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oatap8NY; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oatap8NY"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-48270f099d5so936994b6e.0
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 09:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778517513; x=1779122313; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTSvgwj6yn3FEpgL8rfphWMetFJdjyouN3lrWKpKTKQ=;
        b=oatap8NYeN78AEuwSOtbLF2RxrW1bQbhiNxp5IKTxhvVnh4TShVo4cNK7FmfIjzmWP
         CeQo+CEVIiK9NZfpZetsNwHVVs9qMvM+kkiFkE+LkXGVAzq+l+UvDa6J4nLn9WDBxIpD
         dqiD3jQQucfjeEQcnCWzYCxNnB4k78NEpWxvseNl9seTMnd4sJulF4no+OmZhgjpm8gc
         Z11+giVdF+4gQ1LRVG7aKs84EPFyKl8qXm08uga0O5B+q6syQdqY23IDTfxq5G3/Gxzy
         BZRSDkjXQc4aw/qv0d7gsnVGZxXCgV/pLliEwKLLmmWbFPpR1xFN53Qodc97a1ZsJ8aO
         HfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778517513; x=1779122313;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WTSvgwj6yn3FEpgL8rfphWMetFJdjyouN3lrWKpKTKQ=;
        b=TE4W2VgarcHrzkYKa6bvzHMeYAqPSxmgAFawIaWL6zp4+CX7ht3SMfG/p762pZlsoZ
         b04Ij81S5Eg94JbyHuSFOQ5+6R3OFKGpV5r05yE/TNufCA2tu+DIIXs1LN1chY3kftPb
         O/DHRqc3caOsoRfZHCi9vfQXP2pbDFSIE9hAE/uUqP3HBrNRk+iLrsCnWj5NX534R8q+
         IVtaj2zJhMKQef77mShiEJkCSOru7xKFdnOvIvSjrZDG6AvXZ5sLB7dupSbgfVzhldzA
         qZ3RF04D2KO/D5PA2v5IWXl/3WJQU9TcYlKaNm0BUXPNOzHi9/bbkgl4E9Y0rYJW8L22
         RtaQ==
X-Forwarded-Encrypted: i=1; AFNElJ/MXXoBbTwNNqDQSa0iXoLqWinNmekQL6hBXCUmh2pUfz+5vC8GdfScNXL60BHeQKWtlkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmLeVkt7ftWLdvREQfog8D0vQc2QGUXUd7N9OG3zZ/wc5P3L9I
	QxF6MjhgCABjAPKRh2D061RSGmzW0dfwY4nXgkh26/viUe9nhujThqL2
X-Gm-Gg: Acq92OFNV2TI7iCYF0m/PVkh9jV7lCXVqjW093JPx9OyCVQilXmO/kiTm/W1y/RTYdD
	aShpjUBQGMNM37FZZAZRT1BA0ynGVpa+U2HKeWikW5Ot4j9pZ/O+Fa8HkK394t/woKcclV2HKxr
	TmFx5ROmKlnQaUHA47RnuEmBDy/1gOolbNZIOPW0bJncC454EngLM/5xAbo6wp86B5vK4Amm4oU
	hPGKGLG/OLnbpvwVLOi6CmrwsLBeZdb4IBQoFOBuBQgh3Rqv9O9A7Y4CMlthrrn2oqLgqVUx/mI
	fjDmiBynCMYC4+zVIsJy8PQ3sU4v/7vLYg+KXkNIO4ZdV4HvMDyu0PR/IdKEWNt5lVyMNUD4IUx
	Z2QK3X0Ircs+q70xBp20r8N/zimHhRFej2sE+ZFRqrnKKp9173UPRrG5i4yVBULA2WSCh8w6mDy
	yTP3r1A1IbFvQU4+XOBrurVwXkfwL14JGdufnaxSF5pVSVwM4FYoVvlETN7kEztkIf6Fc3a6Ejb
	Qv98NRUGTFR4w==
X-Received: by 2002:a05:6808:50aa:b0:479:da60:7dd4 with SMTP id 5614622812f47-4804247aa0emr16145772b6e.30.1778517512989;
        Mon, 11 May 2026 09:38:32 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76936220sm20579592b6e.10.2026.05.11.09.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 09:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 09:38:31 -0700
Message-Id: <DIFZU9BF7H2L.2C6L1A58XG5B3@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, <kernel-team@fb.com>, "Martin KaFai
 Lau" <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v3 15/24] bpf: Pass bpf_subprog_info to
 bpf_int_jit_compile()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260511053301.1878610-1-yonghong.song@linux.dev>
 <20260511053418.1888759-1-yonghong.song@linux.dev>
In-Reply-To: <20260511053418.1888759-1-yonghong.song@linux.dev>

On Sun May 10, 2026 at 10:34 PM PDT, Yonghong Song wrote:
> -		func[i] =3D bpf_int_jit_compile(env, func[i]);
> +		func[i] =3D bpf_int_jit_compile(env, func[i], &env->subprog_info[i]);

Touching all JITs is too much churn. env already holds subprog_info.
Figure out how JITs should see which subprog they're processing.
See bpf_is_subprog(), for example.
