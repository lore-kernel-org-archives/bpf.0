Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CDB4A13B4
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 18:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029362; cv=none; b=kQLU6JQS35nzQC2c7aayUuZJnRF7u/7ktc7oR3nFBDgrUZjw53ITIXoKjY8PGdlARStafHt80Dimg1AleN0Le1GtvdG9NEsmv+GsOd+Y1PidBreKy5uk+oIarvLqOuobenzr7EUuK86map3Nc28CtNnh4O6e73c3LiOBsaROK4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029362; c=relaxed/simple;
	bh=XzNJg1IpCmsuEUEFCWtTqn0Zr2CcmwUU2sOkkD/wJoQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Xb4/i2Liq3eHQrG2LsXfQYV0emg7oCuBivvpEC4JRSCl8u/ur5MigWDM/F00Ni7aDrO/JXEhLEIAx3UbX9w+HrYHliCBmP+BodM3fVb12yJda76sDIbjFBL5duA24uML104fyJgoTK5TdR71V67JyRlp4IhujB9OP2xFjzIzkgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sc+W1nWV; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc+W1nWV"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4864abba33fso4284258b6e.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 11:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781029360; x=1781634160; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfnJLI4mrhAd5VJXzKaNr0dvlKACGH5qWGqPnjlFHSs=;
        b=Sc+W1nWVFgSm6Sq74k1xQnhK9CfRNMhrPwciqQeC+vGZ7J2W2lUakQ/XM9dI6llN20
         2p272mGGHCs1L4glyq8jzF18DqK2/CCxBWX3ko7Xou/5rVmLLbuBEL3mwNbYQGkMN2nF
         EJVugoVcM0gbj13Fq0II1jjJ5y/EFhlITEs9NdiyYvEiF2YwS6dUStqxvVrQheNQK1sA
         a6SNdgmTj1Oe25gyeyXpVlBxa7N8QGa0bRPEfzsqpmuDRk/1B5pNecrN6iFI6CtR8SPz
         zL41nI3z6WVDN/MmBTzDIiuopQUkLVhyD9GSC5KMKeJySjnX/5ZuAt+cNCfthutWa1J+
         r0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781029360; x=1781634160;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pfnJLI4mrhAd5VJXzKaNr0dvlKACGH5qWGqPnjlFHSs=;
        b=Ei2V1FWKcH9hd5IfOwyAXQ4Fp6BdoJFU2hTo6iHKQ1MXP+4XM6cTy1HIfT2OynwulT
         MuNCY1VPdV+TX9fYEQ93SZWZoDL3ComJScTKwr0oZ6hRifRko/PFMgvp+Bln+9a7eaoL
         nPfhnLbyi+cd7jGrOvGpemgoJw8YAXlpFHDxZbVvL8j1gZWNM/VBqDqoPpkgIVL3eIwD
         ZNJBzRuNYWM5gIK5+mCcLki86/DpoFtlh09T5DXb96KcvhL6djbBdFArSHVK4yOwwvdh
         MTpIsYFaUnD4S8LxRTT5AIB7jisO/eWHuo96BkWEo7pmf4YAiNLQuRxteIz693xaLMKq
         Wp3A==
X-Gm-Message-State: AOJu0YxQ11Q4QmzV8aT0EzWruLZ3sNSAWoysLwOij2GvKOBRFFy0PwgR
	QgNn0EW1/UwvxGU+ZNl0IdEgCPSbrKfhccc3p9VYTyBgSBx8UBcZ1i1S
X-Gm-Gg: Acq92OFleU5jkGTXxaHUuydwnWXnzn3FhUbk62nGZHo2oHbldTour7xxnhrpJh9OGho
	bNfu6OVhBc8AeZYW9/sGse3iwBI8/s36N5s1gijxOw40jTJivVh3RCe3okMExz0QnC2cFlA8vy3
	q1g4mUjpjGWlc7Z1r0C81NQKjZ7L64YQ4UBpwXaJMoE3zm0whSQ7C7o8kMJ1A65PHbjD6S7Cr04
	8xMjs5lvqrY5BIfSqjVHeTxqk88/MUurQNUJ7q7oJXztWBXK3AO1h1bXLwviYY0/p7RSeBBlPhf
	S58mkORINcAyWuee3BRmeL5AV/guA6t7FCrVmzpdD54k2ojCqdlcMDYbOzHbNhZMDLoE5LwpQnN
	HYJGueI8M7uuroYjkiY5KuGb3YWK+FCsThGVYOQBToPj3ksXkQjqF4GvxSd2uSsbxuZs/GacLlw
	UcZJ0lcFZkq804plnVghaWjn5zHWIyWcnXCD9Am1rjf3qhPO31jtQo54/SBZfCHCcA1rRjlYIDP
	InM7O0aGANGeZD4FU8E/5wb9DKoBNLhpGRlFQ==
X-Received: by 2002:a05:6808:1921:b0:486:4b79:12b6 with SMTP id 5614622812f47-48692cf2aa6mr8622837b6e.9.1781029360263;
        Tue, 09 Jun 2026 11:22:40 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d7d4f449sm18634164fac.8.2026.06.09.11.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 11:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 11:22:38 -0700
Message-Id: <DJ4Q7RSSY0IT.1IDOSQBEWUQ6I@gmail.com>
To: "Jiri Olsa" <jolsa@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>
Cc: <bpf@vger.kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <songliubraving@fb.com>,
 "Yonghong Song" <yhs@fb.com>, "Oleg Nesterov" <oleg@redhat.com>, "Masami
 Hiramatsu" <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next 2/6] bpf: Add support to specify uprobe_multi
 target via file descriptor
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260609104244.588321-1-jolsa@kernel.org>
 <20260609104244.588321-3-jolsa@kernel.org>
In-Reply-To: <20260609104244.588321-3-jolsa@kernel.org>

On Tue Jun 9, 2026 at 3:42 AM PDT, Jiri Olsa wrote:
>  	flags =3D attr->link_create.uprobe_multi.flags;
> -	if (flags & ~BPF_F_UPROBE_MULTI_RETURN)
> +	if (flags & ~(BPF_F_UPROBE_MULTI_RETURN|BPF_F_UPROBE_MULTI_PATH_FD))

In addition to what bots said, pls run checkpatch on above.
It should complain of lack of ' '.
