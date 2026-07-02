Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDF73CAE74
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990111; cv=none; b=Gki6/in/EQYMNj8dVBMgebMKreksLvH59kjQTlt6gaYxgu4uU4jsA/UfEF7zNU4bRwnOW3KOo6JsN4FcgvLn2WqWD6z2muKPWgqRIb+HZEscbpEui/TNZHR0lWYECGl3l82GcXYANITaoaziBpiScn2JjJ+FptJjuLURkNhem1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990111; c=relaxed/simple;
	bh=LwEPgX1FY6tnbKgNNa9uz7DXSwqHQTt/mWky3yxefIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nvpCdkR2uAyCyMD5m5MRtAOGwPvm+MIievCs9ZSqJ7RGKPu9awj2HoPdV8W5sPHNDZzWrlLE3FlWRvn7EdWovZs7leR1JS+Kd8ori5tzqC2Fs92dYba/tk3+L38petwyqf+elkyB3UW1w/t+xfcSDXiWqKleNuYRktXL4yfAf/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HvZFPlHF; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HvZFPlHF"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso752509a12.0
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2026 04:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782990106; x=1783594906; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LwEPgX1FY6tnbKgNNa9uz7DXSwqHQTt/mWky3yxefIA=;
        b=HvZFPlHFyhoAJ8FrjePE0xaYc4mFklZFB1RWox4O9w9CfG/RksLzltT9Zi6h+J4DFh
         Kp7hfdPjQCblSbOwpn2ZLjOYq//ST5qEi7MtidCDzmn2mgI21+cRVERl1qynWIneOwDZ
         vuEwrkNaBhov3sey6qsvOLsVXgvVhzMeM0xWNmItIF/lAiJ+FBdAlVtCweBvw7tYamMW
         JOktd+4izVljnBpQS+zrawAR6hZEbIDcPrvoDmvU002R2DYeKIB5FOtGmgqDj03ydkJm
         xC4AsMzUpURojkp2Mrq9TfvZh7PJrV8+wWLIKaP5u2Z+7g3QKhFhBF4/JGlS/cbK2Wts
         5Tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782990106; x=1783594906;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LwEPgX1FY6tnbKgNNa9uz7DXSwqHQTt/mWky3yxefIA=;
        b=XWcBM/MXkxmeGGTH7usSnWg7WrZvaCiPSJRVWKejjJMYMsuMdvIh+c4j3e2StacWQc
         4gKqWnVBIP/+XNfrbexwXlEhQ+cvSJyyvXmEx3wzgBIYBNO9U9g8KoVc0eNuzdmdvSsQ
         I882mvDerleGtzHUAfj91YxOM82vKkpnycaZYB1Mw2sxu5YNwbxhRZrxlC0pCp7tz+Q5
         /58+o5AJISGPznXsA9IM1Wldlh/PWVSmBYFy5HaqljrinXOZpfc/Dm2IZQ3e9pWqzC6N
         tOX6K5QAqQbI07wPXe6Xwak9rBIAcFLbGNlVbVO532LVck+h4xbtptG0tasEYF3p85P9
         dzxA==
X-Forwarded-Encrypted: i=1; AHgh+RpgHd77FrG19LNLSaPTo/9qcQY49KjBzfGyzEL5Df6i1b4fHd8Go2wHqPSgU6Nkd0kzGdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwybEXFjQx5++8YnbvhxFrtjk6xgAmgtfFLtk04EhfWcm7p8a/y
	MIqg3aV1tbnnwGL3Q9yBSDjBlHQd8eNgrmF3QFMYPJNXm1EQENZ4P65+APKajcL6J6E=
X-Gm-Gg: AfdE7cnC875oaLwZ5Pk0STqmODDppsEp0x7fz/Laup3z8EXSJ3GfhKjObbcOtIERm0w
	k9X9RuiNTURFtSeIkjFLBmac9s3bE+eG+6CyP3sKF0lEDNIuxNhgfHx+cVFdK6o4AISo2RpcZZA
	ilYwSn4ROXBKIrC7xR5bCitGRPu0n1ZYOpFWWiXI7LnzEepDvG6D3sjPkOUJGL8quJb/68moAdE
	mZG9guA4HvC99QSldsS94c2VCB/5XDcjebJt1/dp0smlDl34KdYPr46IN0qS0qlrvkNgbLpEW0H
	9DL6vzRlXXnnflzUq18zebkhnl2PmPrGAc69nTy0A45itLfWK8sJxevf74cbo2zaYuyyYhoKJT6
	mqygB9Q7/JMQ9zQXmsjjm/BxvMddzWTm0JV8AI8ToEp/F4zk+TKmkX12goc1rGYtIyqIka11Cze
	x32f10Vfsk3Y5Bl08=
X-Received: by 2002:a17:907:3f1e:b0:c12:7b4f:cd5c with SMTP id a640c23a62f3a-c12a7b4b3f9mr274460366b.19.1782990105568;
        Thu, 02 Jul 2026 04:01:45 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b60f5e1asm108533566b.27.2026.07.02.04.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:01:45 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  Jiri Olsa
 <jolsa@kernel.org>,  Emil Tsalapatis <emil@etsalapatis.com>,  Shuah Khan
 <shuah@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,  Jiayuan
 Chen <jiayuan.chen@linux.dev>,  Eric Dumazet <edumazet@google.com>,
  Kuniyuki Iwashima <kuniyu@google.com>,  Paolo Abeni <pabeni@redhat.com>,
  Willem de Bruijn <willemb@google.com>,  "David S. Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,  Simon Horman
 <horms@kernel.org>,  Cong Wang <cong.wang@bytedance.com>,
  bpf@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH bpf v3 4/4] selftests/bpf: Fail unbound UDP on sockmap
 update
In-Reply-To: <20260702-sockmap-lookup-udp-leak-v3-4-ff8de8782468@rbox.co>
	(Michal Luczaj's message of "Thu, 02 Jul 2026 01:28:22 +0200")
References: <20260702-sockmap-lookup-udp-leak-v3-0-ff8de8782468@rbox.co>
	<20260702-sockmap-lookup-udp-leak-v3-4-ff8de8782468@rbox.co>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Thu, 02 Jul 2026 13:01:44 +0200
Message-ID: <87wlvd1wpz.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 02, 2026 at 01:28 AM +02, Michal Luczaj wrote:
> sockmap now rejects unbound UDP sockets. Adjust test_maps. While at it,
> check socket()'s return value.
>
> This effectively reverts commit c39aa2159974 ("bpf, selftests: Fix
> test_maps now that sockmap supports UDP").
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
