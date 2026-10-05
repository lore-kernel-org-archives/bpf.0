Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C57318BB8
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791225056; cv=none; b=kTrPZGke7ISdeGhAs8sr+wZqyinibIoJQXCA5vxTfTChrUyDpvDMOQVaSvF09T+bllIb5LiP+zhLsNKl4f6aQEAzwlEs2HH4ZDRAJcurIuXHaoqmZ4oIYR2juxRf+3lPRPpAVw8EbVbj9PofBnwowNNQ2WUjc+qF63pYByxAoLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791225056; c=relaxed/simple;
	bh=LHMwDqlcXSfkxv44u/ZvcB9y/jElzy1xDWD2jp55OCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZDgYeYYyNInz9QDAOqmyQnu9KLq1agG9aaV4iKUWIpK2AF7bW8D5yaOSHBk49nI2kYixtuZu7W+F2Hd1FK1ok6miL2E8EHgobKQJCyHASagGguZ4F4BOMeAt8ODhYeLHngAj+ym8xtR0b90CWDHg8ND9lQappgUr5Wai5fHUNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjsuemS/; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjsuemS/"
Received: by mail-pj2-f0.google.com with SMTP id 98e67ed59e1d1-3a4883304bdso510516a91.1
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 11:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791225055; x=1791829855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xS5HF65LoVsFRjbOhyoQkdS88ZjBoG/dqtGiSK55d78=;
        b=cjsuemS/06SA9o9og9VYoXpUdF7N11RNYrc03KPI9eeguId1oKSnC4J2OfMVE9k58w
         zdpm2d2YueSBAEHkfIyQYdYByVBzF/gxIGM+8OUkk2VbjONVB1kEQwQ3T/F6MpufvJzu
         DYPTNEDLna5aAAk1dCOMxfm8R1VknOoFwfJGmYQhov4LNFSyUPUdbKxDqqmAiBAYOFHs
         9ZTuNFRpfkNMl8lgoRa5ylpZcxVmHfKNB7MQJWPzYZkyuwY1+eHp/G8jh3GxhdzUzyzb
         /wK3lG/2I+D3pKnIiUCrDfQQudw6wilOsJMENmA2r9sfIuADXKy4FGde5WDbpCAx28RA
         vqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791225055; x=1791829855;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xS5HF65LoVsFRjbOhyoQkdS88ZjBoG/dqtGiSK55d78=;
        b=xGFwCx9V0fOxBN3YE7DOj2Oy7sywfvPT9C6wZcWXwYv2CuTscX4mmzh8EHvcQ1Dhlh
         l1Fv+ZlRq+F8PLYP7nNwlVMGgqAg4gogZGOHeYLonojWE0/ZNDGXRrvozLS/Zlcs1KP7
         oCH3KKEwrsv8F8w2LjC5XrEV01x13HurP4iuSfgoEJtPsLCU1IwONN0e6KkDJA9mx0qE
         6bLUt/6sm0/E3mcQRWV9a5J2N/F6+Swktg6LYxuyLUzq1QZ4CIwGi3H/DkiASI3FVAC5
         VjPCA9/TD39qCAlLrE3S9Q2T+8AEfVrdD5w0UOQ69e3sG9snOW3/Oh/awKHp0/Ul8+uI
         nCiA==
X-Forwarded-Encrypted: i=1; AKwUvBxrjn7j9rp2aWUTPUSjqDbHDepvX8OND8TOFbMM5rUdXIqAcWXsJqzklr9UExIxRD8tA+8=@vger.kernel.org
X-Gm-Message-State: AFq9FYISbrCNtCHzradEht04CR6+iq/bsb3dYBHdfmtQPAl5qYtmJXkT
	Ymjh6tmmSgKfMvtMQ/3GrxHCyFlzVUasl36CqtzXsfhEX9barzXRvrsN
X-Gm-Gg: AYBFou3EmD5Mi2bBjmBAWwK/XHdy8yM4NcI3Z9BztaGutXuQfPIZc/49Z/3hoko7DQq
	+niEO4n5r2LoIHkabRL9fk/UIyUcyDK5kniMj/tB/3giepNc4sl76q0xGEs32DamkvhHfhCqpuY
	H977TfM0c/ca8y4Of8XI+ULUETcmbzasQq5LY9jzQ0Vj4BnoySBXlqjbzPk7FSu8qxyb+ow6JR2
	n40IVXRjdvU18A/LO4itAqOkzHoa7sgZsaCMGBaCX52ktGk1QCEOwTIZDHrSw3MP1VCZtR2bK0F
	fOCPe7dcMVlr7eOtRV4KvNdX27ZnGldn955gq2dmxaUlQN/u75gl462W2lXPnq5jvIocDXYKOcV
	XFXO14NoB0dmTDzTnoZcC3EFMAEcHs1ffKkObZ9fVUozbD2lfFwKdeZkijDBPs9ERHznUupZ3TU
	SO5O5FymwXYjtefE97CVAb7ASb0uuq9m1D5HLivMcqCrVhk6tz1E/a+Yxyd8Urq97H
X-Received: by 2002:a17:90b:4a86:b0:3a7:da33:ff3d with SMTP id 98e67ed59e1d1-3a7da34065bmr4683519a91.46.1791225054557;
        Mon, 05 Oct 2026 11:30:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4c::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853cea0f1sm646225a91.15.2026.10.05.11.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 11:30:54 -0700 (PDT)
Date: Mon, 5 Oct 2026 11:30:46 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 2/9] bpf: tcp: Add a new per-socket flag and
 kfunc for bpf_tcp_ops.
Message-ID: <asPsATnTIr0Fxa_b@devvm7509.cco0.facebook.com>
References: <20261005154533.4147685-1-kuniyu@google.com>
 <20261005154533.4147685-3-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261005154533.4147685-3-kuniyu@google.com>

On 10/05, Kuniyuki Iwashima wrote:
> The legacy SOCK_OPS guards some hooks with a per-socket flag,
> tp->bpf_sock_ops_cb_flags.
> 
> In contrast, bpf_tcp_ops was initially designed without per-socket
> flags so that users can simply define only the callbacks they need.
> 
> However, it turned out that even attaching a bpf_tcp_ops with a NULL
> callback incurs measurable overhead in the fast path. [0]
> 
> We could reuse tp->bpf_sock_ops_cb_flags, but it is u8 and has only
> 1 bit left for a new opt-in callback, while not all of the 7 existing
> opt-in hooks are in the fast path and really need a flag guard.
> 
> Moreover, tp->bpf_sock_ops_cb_flags has two bpf helper functions to
> update it, both of which require sock_owned_by_me(sk):
> 
>   * bpf_sock_ops_cb_flags_set()
>   * bpf_setsockopt(TCP_BPF_SOCK_OPS_CB_FLAGS)

Can we return -EINVAL from these when used with sock_ops?
If we keep one flag we can presumably put both tcp_call_bpf_Xarg and
bpf_tcp_ops_call under the same if conditional?
