Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A87C35E943
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781906122; cv=none; b=ICZJ1AohCnuiTK89DkqFWc2Byb7mySTl8w1Lm1GkaaESQ7szFmjn9odyEqe0cMgWS1Va7S80gbcVIrYYRW3Kzq2+nivjNuNfyeb6D5EADqJYuNtCUhBojP+3W6W2qmMgYZcmDn/dHIFSlkBq242/rxxCOWqHjKHAekm+ODNrffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781906122; c=relaxed/simple;
	bh=1TBT000VZsjsrh2eGBT6mjiiO1fTUs34DeS+O0xeYrQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=jubo+eKIeGte60OGQ0fxhBcfpJURGvCcykFyUG714n1pdqyxvchnWS7atnSh4MP1PHCRtw6KMyCqDpwOwT4MQdme2DFZo5gG2OJ1ZlolW+7u72SVEPh4hufWsYQeEB3UPi/3tm53+RvEycKBRTX8dP3qOyrZ4aFvi9QVAGFewe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5qtjfBr; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5qtjfBr"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e93d1dd156so266675a34.0
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 14:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781906120; x=1782510920; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1D3cBmNu4YFH8WjCxOSV1D9t43oN1k/1HHsWttX0H6M=;
        b=P5qtjfBrJEYGa3WsF0ZfelJ6Urg50+QFj39AUSfTWfUoGuCBRxJsMtGMJZRmet4ODK
         a066sxrmhNEl71PCuV6g2koK5CQmLxW2KwFs3No9k2LpJi8Eo1SITjwb0I/iSVMDymCL
         PLToqUI5rpF2lzlLakExkaMXbUNoLQxTice5RMRsU73OIf0IpYU+IXmXOaWY/m0i3SB0
         qvrWch4r+0/wNgbHSXDv9koe4DjjF8YaeMJwwEGerXTryRhB6D3Z5WGlPLKbz9hceqPM
         bj/pMbA2roCYPN0EgM6Gj+xkCrVc8iVBYIN6xfoyj75dzGj/Qh80fjwki9ftaS2wNVsy
         FrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781906120; x=1782510920;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1D3cBmNu4YFH8WjCxOSV1D9t43oN1k/1HHsWttX0H6M=;
        b=mFdlveyiPUCd6bghkeqyFL9q3TSjqqLTsqy+YeEmKPWvphUz0EmlC7EGxtp13E7zsl
         RpTShhKA4DNTtj0uccQOIuf5noR8P4w/psH+xiDaZb2y90/vl7rF/L1jopr/2M9pRAE7
         9sytEajQPVpFbmBumZSKr7iHPUpq6SiSPmpMoEpDBJfD3cpwVpls8k+b+gOF4IwjE4IS
         HLQGpwPVcwmIr5eJ+xeB5Rw8jYQMYGpCmKKBbss+ov7LjtW5TjG86yx4QrYsM0/Dwysr
         EFXhmRNdhXn0ikjZ44gwphHRa2rCh0R11N+4DMFnlDPUy2UJyCBb8vyQYhkK4DSXbd9e
         dO+A==
X-Forwarded-Encrypted: i=1; AFNElJ/nuhaa9pIRdEbw5xaK0zj3+S3fDHJ6bXWla8MHDqSwXTjXxftZ/lyqwnXaQei1SkGUstM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYfXOX5gtClihvV+nWCw/1125O5yZbzQpWBl9aiQaeVVSKi95U
	2+UiU/QLlz+Skr+GXOvTwj1KSGpMtcnBRvToLmZQFFNehTK0xsvytRjZ
X-Gm-Gg: AfdE7cl7p5BsceszdFcl2Py7YJ0LRxDcf71Yxt5xSIfdYKmjRTbM6Vbz0gFYi7DaKFw
	mwZLqGeTS1j4A3oc0fFb6f9Or4t3i+8IWTxEVDPBRC7ggAn26lu+fh5CcXwnyM7+Cd1cx5b3m4R
	1t2uxHHCBllq6VBZS9YIT753tXalf+dGWlVkXM43NpOh0LSO06XmS02L/qScp72qhsk1FikEx8T
	qVpH/AoT1srT2IzXR1mCBH/BWxdt3LBxLM6GUFW4ugyvlaLhSSZkGKbWu6PK6otHm3ZaFRIGl97
	oI/cqRCITxoj01zGhEAFJ4SONJONOqSJs8mev1idzjb0WkCkxSRKBFUy6xZp2Uesfetrs+8S5zO
	2papBY9W7Ipc14okJu4PwQXcF+H93sOksQGsVr51EU7Y4qkOrck9nn0tMXnGpyA3IMRPf2exGCS
	6tzJnXt/nd4I3nw3Z5xwBRGQLxgN2n7IMWkdxm/aWD//aM70rWpYbYNqN77o4ZlJ/HrtpZOtVPi
	O+QOtU=
X-Received: by 2002:a05:6830:620b:b0:7e6:cec2:a4a5 with SMTP id 46e09a7af769-7e92d8aec54mr4035312a34.20.1781906120073;
        Fri, 19 Jun 2026 14:55:20 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:47::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e94424ca09sm293111a34.16.2026.06.19.14.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 14:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 14:55:18 -0700
Message-Id: <DJDD01YMA1GE.3G7B4LE5H780G@gmail.com>
To: "John Fastabend" <john.fastabend@gmail.com>, "Sechang Lim"
 <rhkrqnwk98@gmail.com>
Cc: "Jiayuan Chen" <jiayuan.chen@linux.dev>, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Eric Dumazet" <edumazet@google.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Willem de Bruijn" <willemb@google.com>, "David S . Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Simon Horman"
 <horms@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf, sockmap: fix lock inversion between stab->lock
 and sk_callback_lock
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260616091153.2966617-1-rhkrqnwk98@gmail.com>
 <575a878e-6d37-4337-a821-4883d3dd3a63@linux.dev>
 <jxrrwhfd5igwnlo6v5y3l3grqhqqpiedfnsqzg62cmwxwaa7xd@qzthhuahjm5f>
 <ajLR9CRn6O27Ound@john-p8>
In-Reply-To: <ajLR9CRn6O27Ound@john-p8>

On Wed Jun 17, 2026 at 9:59 AM PDT, John Fastabend wrote:
>
> The bot also thinks it found another locking issue. I'm not sure
> supporting 'tc' is really needed here. sockmap is much more easy
> to reason about from socket layer. What about just blocking sockmap
> manipulations from these prog types.
>
> My current thinking on sockmap at the moment is its has sprawled
> across so many layers the locking is overly tricky to reason about.
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d9bdc3b32c05..5e08d3e03453 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8567,11 +8567,7 @@ static bool may_update_sockmap(struct bpf_verifier=
_env *env, int func_id)
>                          return true;
>                  break;
>          case BPF_PROG_TYPE_SOCKET_FILTER:
> -       case BPF_PROG_TYPE_SCHED_CLS:
> -       case BPF_PROG_TYPE_SCHED_ACT:
> -       case BPF_PROG_TYPE_XDP:
>          case BPF_PROG_TYPE_SK_REUSEPORT:
> -       case BPF_PROG_TYPE_FLOW_DISSECTOR:
>          case BPF_PROG_TYPE_SK_LOOKUP:
>                  return true;

+1. Let's disable.
