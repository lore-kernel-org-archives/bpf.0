Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF7B3C343C
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785267444; cv=none; b=hFoSiLDXOvgRzdHBoLXD7eUcvDiUJDn9aNWv6e79e+KylhnQBVfW+F62TpW8M1iKUkrXQ2IyNWZeK7yEhLQboXulwvppWfbDAbKI3GkRNw5WGy0tXBYUA6fpJ9+0M4AHU5n7mw1nJA7aB1JNi9jpHgHL8hl9C2S7IoKkOWCEKB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785267444; c=relaxed/simple;
	bh=Vemh+A1Ttb+nEANl+/KldGRmQziFXMYhDi3qgKJ/Uic=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q12usbF0QBDj+/c2Mkgk5dhxKc+MWGFaCndcYcmJwqsJW6ZvN28W7Sb/8UO7IPFwUdQac+2yRggUEgWINfKmL/TAIbbgyTJEOxykLhAhs9lg4irszUxIkYnw1Kc3x3/+8p4yPLYe6Vc/JUDyLKlpNnh1l4ZQLvF0p2xWblhZXEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTuoPcHm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTuoPcHm"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ce98cb8165so2170095ad.1
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 12:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785267442; x=1785872242; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Vemh+A1Ttb+nEANl+/KldGRmQziFXMYhDi3qgKJ/Uic=;
        b=JTuoPcHmDmXmkQ8/KU0kPezzBlROhECeH8cjkMzYR9dFLWIwL2NKGB1sqjoLgVIP8l
         abGVRVpL33xKq2Vr2GbUjV3rsqU75Wj2VZXn4RjanSkwNsx2FjGTfaH8hNXItzXkK1Hf
         1b8JEOMP7BgkLZzE0iL7QSVhqmS1fAm/JS6HId2/dDj2uC683M8DUsu92uvlZ1q2g/Bz
         HD/yDeVut0gY6vGmsla+3TfuNf7jX0cGUXV+ZY4ckoJiPHKcA9OHDgbhHeAzFuQ9ISZ6
         Nj1m1CGtu54sISjJbXqa0m7I9TrJN/RR4lahiwyYvlhagwLk029lgeT9AAbsUsPQRXqI
         ElZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785267442; x=1785872242;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vemh+A1Ttb+nEANl+/KldGRmQziFXMYhDi3qgKJ/Uic=;
        b=W4Cb9yGF0zm1jqKPJ6Pb8kiVAI71ZY4JjCU+bLQ5cxeE3tp8YvBz9oKC7G2SVTAjYe
         pB3rOiZWCgpkzuCvh2P3/TzFVwtr8+MRPm6FfBbphXVFS+YVMJ85JjlfYNjx6F7NNhEr
         BoV77owdK0hSyj7PUGCHeIQ9q62L95EvRY3wL0jQP5nycbQLr++tE77B8kH2xpTnKbjf
         qxOcN8Ym2dxvnBiXU6Mdbu3gkqBoRrv1wcplQyzcPytGgeSPSFcnZ46UIw6t8HohDhao
         NR6RyoNXCb7F5KaqtF3mxeOehJoOrWn2XU8NE3LMHJcIhvLiBEod+pMCBOqV05KvL4FF
         5qEw==
X-Forwarded-Encrypted: i=1; AHgh+RqeeIeaWo74gmcO/P9T16MlmVJ31Ncd5nS95AKUVPCzspNdU5QlUMKDAp3gaqs/QcuCWsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydbkD8BpCUnHBPtQlXQneqUs1JHF13WOSrPmQ61osKZDqBum5Y
	6LGEJKYvXQCqAMVis86xtjzAaCfLV+AvTrpRyU1kZ6JsP6oaPGKUtRPz
X-Gm-Gg: AR+sD12AKrq6lwflhOCrGJjgt1qizAIaJf9M5XoUPvgnZY9EsaRtZy5FkacOuBIZ4dY
	aROBsefVNRIJV+6p9HUXl7xZ+W+5oaams+FxXtWbT2+tex6DQ4oRKlougbQNS+4wvL48Ar8XZ7/
	zJz3Zo4a1W6vr4T/zpyaK6s3Kfnif7ygAUTnuu4qlTq2eScKZJKlFdSLKWfqwUnASa9jLAtKwJj
	UcG7mW6O7iOHERwt5/wnKRhBkAn//T594fk0Qe36tmq2v8Rz9LDA+tKQPUHYIoL4toEaKlnuPzF
	Odzp5YRXunFrb/fouBrLf5YAGgL7bPQwSeSJFs8GH6tDOmnOtqhdCBY+3thyAGXSLMdC19ezVYt
	mc0DqtEhkNyH+NtnXr1o/wPH0223pcRFzUyZiZ+l1Q7AvGfrdOWw/6oW27TubXi3EID5s2nikfw
	nxBfaA4ayAtZwqmVQg62yhYyLzCboXffaVWOko0QMYUkJzEoIlxyKUE35sMrh3f5qH63f9YlGRx
	loaHro5C2FGmFWuxaSALWcwn9lNv7rU3CgZ8JurAGkoiA==
X-Received: by 2002:a17:902:da90:b0:2cf:b23a:3e68 with SMTP id d9443c01a7336-2d015eec531mr39762695ad.25.1785267442199;
        Tue, 28 Jul 2026 12:37:22 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5258:1ab6:44ba:7529? ([2620:10d:c090:500::4:c456])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b15f77sm1665249eec.4.2026.07.28.12.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:37:21 -0700 (PDT)
Message-ID: <794ec5fdbc3acb46526164a47ce5b44206bfdc1b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 16/18] bpf: Tag nullable kfunc pointer args
 with PTR_MAYBE_NULL
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, kernel-team@meta.com
Date: Tue, 28 Jul 2026 12:37:20 -0700
In-Reply-To: <20260724190813.1458271-17-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
	 <20260724190813.1458271-17-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-24 at 12:08 -0700, Amery Hung wrote:
> Now that get_kfunc_ptr_arg_type() classifies a kfunc pointer argument
> from its BTF alone, express a nullable argument by OR-ing PTR_MAYBE_NULL
> into the classified type, and resolve a NULL register after
> classification instead of before it.
>=20
> Previously check_kfunc_args() short-circuited a nullable argument passed
> a NULL register with a continue placed before get_kfunc_ptr_arg_type(),
> so the NULL never reached classification. That kept a register-state
> decision (bpf_register_is_null()) ahead of the BTF-based classification.
>=20
> This mirrors how helper arguments carry PTR_MAYBE_NULL in their
> bpf_arg_type and is a step toward describing kfuncs with a bpf_func_proto=
:
> the nullability now travels with the per-argument classification, so it i=
s
> captured when the prototype is generated at add-call time.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
