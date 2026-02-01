Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430892E92D2
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769941500; cv=pass; b=mZngRrdD8R68hqX/C3YpwSfp1YDCF1F3q6Q6wWRgpGMfSnaQ5z8vqEsxxgyp48HMAnImVIwlip9ZJlFG5tLtI4ELxJDjVqpGFBM9RmqD1Itn8MZs/R2W6CWHuOAMFi9CPbQhLhyafr9gKghjDRpWhe0aWJ6jdTM6IZiiX5uawr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769941500; c=relaxed/simple;
	bh=c13X9iCoqEMpER2AIG5Pt/jrhfKFm2Mm4FnRZDWIDoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCCCu3HkSjVEpVKFXdhYTLMy0jRtI1XQPdvbZf6w5KD43rKpKnQGElX4lziHqR3s+xr76cf4+QFQf8MvQ+S/D7DDyBms/tIeVq5NiEC+pxCDvfy/ZrPJkx8MIIdbgtfs18xl5MuLCh/c4v8l4o2rN0uExy5qA274P1kkTpcQTPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MIjfYEv3; arc=pass smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MIjfYEv3"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c655e0ee70so388771385a.3
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 02:24:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769941498; cv=none;
        d=google.com; s=arc-20240605;
        b=S4+y0TLe/PEdyv7ufieAlc/tyZI/ftJ9K1Ym1sMsc7NnbaxzfRdNynJlE8X7IiBVEm
         9ex/bvYcdKtgIgC8XSzWM85+Czhdq32XwiqwZC2jJq3tLlm45vHYQvs790+xE/LXIs5P
         zjvpi/00BU1PKqtWCVvJtW82Q7L1pj0DPRX+IHf9H/5jXTXl/+nNjov10IvUjkHxbvBb
         2vLiEGGWBsV8VMBKJzD1p+ev8t1Jh/4hvI/AUDj6bePye+LmZl2tV6R9aUcrZQbAQf37
         F20pXgBhnpvsJ6+u20ZoIrzamzfIMnJ0Jrfe1tWx3yVzozqa+V4p1HcI8sI6gpfGAMWf
         fw5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c13X9iCoqEMpER2AIG5Pt/jrhfKFm2Mm4FnRZDWIDoY=;
        fh=WIxRSTkKC1eayiPKt6cJNY1L4XNIn5PqKbV2Wrt979o=;
        b=gX/ABg53oD9qH4U1Nl90FCZNL2a1luyZW4xbDH/wZ5+TbFMxBzXG2hPjoP89v7poCF
         RMC0Zmb8SxPtAMTUKMp34bYPLOcfAIm9ZbyTp37VIvWqIgVy8BCG7mXoR+AO1Meof6yM
         o3ORWigkPjcqt3svVTZcRrVpnNzD28zJqNBMhlWBKsBIZen5l5Iq09aMyJkdvO6YwPdL
         t/y2lkFBQFQ645CVsN/gP8RMk2cTGutLxMBBT6tIDvRHJtkhzmj4pflViJ+UAMGmlIjL
         +bBLaafpAZyIaXNDPOgsA2aYUPOPPEA0KwnVkK3YtQUZp60070dwD3sCXwh+ZALKVFn9
         i+ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769941498; x=1770546298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c13X9iCoqEMpER2AIG5Pt/jrhfKFm2Mm4FnRZDWIDoY=;
        b=MIjfYEv3Li6hV8HO6FS2uLcjF2ZAWGHiV2K89t/jxIh7U/LFzvM7tuO2Vr0/5fAJn7
         W1lfRwlTpWXhXqgkDo9uwtizhOwQRPz4HZdv+l/cD4zGjTfanmdcnduR+P22Hu5jZ7RI
         R/U9Zjx5A/YmVYq23CZNHb+ZCaXbCBvoHivYaqTxjcCCrz8ZCx6XpzR+TveF3oVJgxAP
         KSlevuxG50TfBx/Sb1MP1A9Cnj7QJCoMtBAKEl/rhCE8hMbQTz5NuwYkuJqx5vHQQ0hU
         RacLMLDg/KbdMT2Dz5cCfjeZF3CWGCPZVJVJJnnPi52nFe5T+rxN62m4NjSRllgAiQ+e
         rXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769941498; x=1770546298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c13X9iCoqEMpER2AIG5Pt/jrhfKFm2Mm4FnRZDWIDoY=;
        b=uibjAGzfRMuI9SzcYh9qI7xk8B65itSXH4AKAEUQDLAmn5v0+df5KOXz/xWThlyTak
         XYs7OKIngRfc/5tLwp9nnCrBQIfDW0mv5tFcL4hti+N0JdcovRPre3TM/cj6XD0ZLoOs
         hKeeJSrkAyurRgsbw7nqJU+W5DTujCCQK/mGCJsFmCBaMthphI1kxXA3VL79135P3y6Q
         d0IPhljmnombsRQOycwvvYoAmwzusJaJ6ifeVpxVKoiaHIS5csvgx+rLmay+hcSz+pce
         tGTf92jyO6nLA4UAaIF+25gn2xicBISX0wBnNe6StYx1AwqS6cU5GA/pIXI2GLB4DPy+
         o+0A==
X-Forwarded-Encrypted: i=1; AJvYcCV2QLn2fmiKypSGClUKDn34aGZSPc0XXE/hhZxxBnxoORk8cQtJ1hPmVN6r/KGRaqFcbig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9u3fBgWeboCAQkSEBxoChPlBRIaBYA6P+XOMT7/QDGLTkLKJv
	KhfvY0tF19uJsLEEV1ZAoXCKDS+ad8pr21+IlryuixD7T8f96KOJzu5t3OvJ7mqBZrximonDnwn
	jf1yVb5EHFTnB1/n16gHXfA6IiHLbqh5qhA/MBgmq
X-Gm-Gg: AZuq6aLU8HvcLlxsabx4rW7GyItsApjczuBaQqbXN7QubhP0bV4U2iLAV3XY0txjrU5
	3vA+wqv4a0Pb3tH9/mjxO1BcsoxSGU4tNSXZOgYAEUyP5co2DdCUptstfW7DjsSetu4ObvFmzfQ
	YQlL3Ye+cPlI5vqrtd7bgLQEZPoqRfhMuPVFaTgL58714C4f08Nnwa/X7Yq+m+9k6NxEbUoK6Fe
	CeAQJ84Xzsy8Z+weTuq/4UPwT8ETPbbs2zb7sLE6A8AwGnU47pchEGHhvJu0cF8apP4hRI=
X-Received: by 2002:a05:622a:510:b0:503:36ba:1315 with SMTP id
 d75a77b69052e-505d212dc92mr105121131cf.17.1769941497854; Sun, 01 Feb 2026
 02:24:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com> <20260131222515.8485-13-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260131222515.8485-13-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 1 Feb 2026 11:24:46 +0100
X-Gm-Features: AZwV_Qje-4lGonBagy2Li1XCvjDteYMc2SXNllbyqn7JUJVP33Ro8aW2ZhSaRR4
Message-ID: <CANn89i+8vG=DiXrd9tbv2PCH_ALpDYUKsj5jm4Jk+G7Qp+2EPQ@mail.gmail.com>
Subject: Re: [PATCH v13 net-next 12/15] tcp: accecn: detect loss ACK w/ AccECN
 option and add TCP_ACCECN_OPTION_PERSIST
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 31, 2026 at 11:26=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com=
> wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Detect spurious retransmission of a previously sent ACK carrying the
> AccECN option after the second retransmission. Since this might be caused
> by the middlebox dropping ACK with options it does not recognize, disable
> the sending of the AccECN option in all subsequent ACKs. This patch
> follows Section 3.2.3.2.2 of AccECN spec (RFC9768), and a new field
> (accecn_opt_sent_w_dsack) is added to indicate that an AccECN option was
> sent with duplicate SACK info.
>
> Also, a new AccECN option sending mode is added to tcp_ecn_option sysctl:
> (TCP_ECN_OPTION_PERSIST), which ignores the AccECN fallback policy and
> persistently sends AccECN option once it fits into TCP option space.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
