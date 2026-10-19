Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792451805;
	b=heb68do1edvWtwjRHTSqNa+SnmDcnJwIu/FYE2cp0enRxw9FeloT+4x/FS+4T1uQ+rPc
	 GPsdz4ADb65w7G4kax8Lj+V49kS+f3nSQUYPW2fKsE1gH/u1bRJ+B+MBRNBRqB7YjeAGR
	 GFhOuIUEAhPL1G77wTi4TZN5nT4gFotNIjd5Sg2LbU29K/33AUeH5bWt2Iefa4vuuwGEK
	 TIxoI+YgV4vYu7Pjh8q4IA/81UAzyh0tRJzMqEZ2ZKattPXxAqpdrRGfuenILwx7MEcp9
	 4r6N9X5LnGoxYXRdkfViq+tybHK7fR223tRWmbEEQAj2IRpKM17v6vAEqW0IBll+oCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792451805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=It+ck8nd35giJ9f/s5woVqaK2BP0dqpDizWPCzMcFLo=;
	b=rDEpcYsnrERsfFqgI8PPF/9Y8Xj4KjV+Z4ZEzsAqyezSs7ITinmJYuH+ZCdFNPaCcdrP
	 YusMhyfX/s5v8HvGlqCDpdTLx5oML+yM1uZchN1ywQD7pO8t5WO48kd5B04uVd/lbR46f
	 R1KR0UM+F6xI90JF10RkCZMm4PnHKXZwBNo3mHJVd8BGVUeYh5rCTiVIQAMNEDDnyrhvk
	 0Tfd+pqyFFBavYFhV1NIGpdMEkXfpyAqpCNpahrhhNDyY5FtythchglZiXGlhdGbhRDjo
	 PEpfUrpEp45MBhfKHb4sFZLdTEGpYrmpeJ9a6Dak/hzJs6OoCe8Tqtz0L3P2zFfuMfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AVksGCyC;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C3B606A31C
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 23:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43C3B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AVksGCyC
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a01933b584so18687365e9.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 16:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792451803; x=1793056603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=It+ck8nd35giJ9f/s5woVqaK2BP0dqpDizWPCzMcFLo=;
        b=AVksGCyCTJpVQwQYlBtACBlni6R/2km4VkXUbpuS5HMnMzcp2+QblpS8GSkwayTo+3
         eJsZ6LWx3b7vmNBbL6ce/E1nmRdP5R9GwAmwKaM7gT+LyKI8i79oZhamElbcYptEhqHW
         P1VBk2Z9OH38d1PiM8olJPEdexYY7psHF/TEIE8H5eQStvtD4EMRiyyN3Uw7Vh8lg7NO
         HLLNztMyK/T6nHsytQzKwZVWAaxFlW5NVGujK9CxHZGCbNu0LNlHcdcPGxg+xm6wQxoW
         Oe0klOUBEAIyXMSFxQjxVwYDsYKxT6647UpGyAUst2bYYbEPwZeOHYhQFKt8kP/4i6YE
         1m8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792451803; x=1793056603;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=It+ck8nd35giJ9f/s5woVqaK2BP0dqpDizWPCzMcFLo=;
        b=Sby1Pj3lVfDtr3v/Tg2lzitp4Exr1Q/lt7Ya5LDHvNLY751xyVd4P++LKRDp1yCR8r
         4mqhP57Ooa04o95TUxrrEyzDNn3Y8qCMBujQRPlmQCik89wVVTldkNyAq9+g4wUVxh8z
         rF6lVrwlGdC/HvGYgWdDJObpuOCRJkJdvXqMOZxSDaTfP1V4JcH/MB8iVxjuQQTFZdo6
         sZRh38CESrfcjCLbWUiW2GopDBw0Zh+WMiEcboC80sFjChjEse3TeZIscEmooBX7618I
         1/ZkoEpx0czjiQeUlk8tI8yT1ilelTZmWzmDKJR8culM9E4h3K1TxlqwreGkqudi1Yhf
         cJ/Q==
X-Gm-Message-State: AFq9FYK1D19DMuYY3CTeliu3yB6xA3ETZ40tARQRlF9veWbxqKBidxmq
	wKORjAOJeRjAmz9b+/f4ud/G55oQlzY30E9aunboZSbKEj5uXcECLdGxHXnLeiGEX3g=
X-Gm-Gg: AYBFou3XKTymTj9sNqDz0gA3xlchSXPsYSGHt4niq8bon+WSybQ/BsW7AlTZkUkF5x6
	KGG6FUDaGD7OvsMT6a3dwmLIMJc/bXqWS0nyGjiPqsrLr+Za/2FVRGzbaZbXmU/pykcGiU3dedI
	Whv4bgJGgwYkbrs4ESCw1VXWBFOT5RST9gwia8G2MOTDhtLl/grqobsDhV9OZlwfrUV73N7xIdi
	FiO13okFCVgBUvc1Bwn+HFrsj8kgUcyt8hKALQOiAlpH1LVrCki3dc8GhSlUx7KyoPuSvpt+r8q
	7QSqStjSL87208BHt1SNdz9PJOuP45SJfVcbUxheo11uC5K5XHRHgQVBzR/eKdP2Ie0/cienraN
	DPwri+6viLR6FwNNjItAvSKOCU0m0HXK1RrqQtQ8kUJRuMlL+1RS4jX7i1fo0qxyk9AyabUNBXh
	yH0GA/Ur9GKcXOtG8YliC11NqD4YKiKbrFGGSadqcQ7X43swteCkvUH3zU0F3q85wRyCKi5EgCV
	8HfaTeLNL9RkDcFoGPh
X-Received: by 2002:a05:600c:6290:b0:4a1:6af4:c6be with SMTP id 5b1f17b1804b1-4a1d7622364mr193940515e9.34.1792451802906;
        Mon, 19 Oct 2026 16:16:42 -0700 (PDT)
Received: from gmail.com ([2a01:e0a:bc7:8550:7c78:34d9:2b13:9a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2c1e0e6sm31068045e9.0.2026.10.19.16.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 16:16:42 -0700 (PDT)
Date: Tue, 20 Oct 2026 01:16:39 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Eric Dumazet <edumazet@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiayuan Chen <jiayuan.chen@linux.dev>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>,
	Leon Hwang <leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next 3/3] bpf: Fix ksock build with BPF_LSM=y and
 SECURITY_NETWORK=n
Message-ID: <atak1wakfuKz3ZYi@gmail.com>
References: <20261019211006.2574350-1-sashal@kernel.org>
 <20261019211006.2574350-4-sashal@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019211006.2574350-4-sashal@kernel.org>

On Mon, Oct 19, 2026 at 05:10:06PM -0400, Sasha Levin wrote:
> bpf_ksock.c references bpf_lsm_socket_sendmsg() whenever
> CONFIG_BPF_LSM=y, but the socket LSM hooks, and with them the BPF LSM
> socket_sendmsg hook, only exist with CONFIG_SECURITY_NETWORK=y. Without
> it resolve_btfids warns:
> 
>   WARN: resolve_btfids: unresolved symbol bpf_lsm_socket_sendmsg
> 
> and since commit 201a454df948 ("resolve_btfids: Fix the --fatal_warnings
> exit status") that fails the build with CONFIG_WERROR=y.
> 
> Only reference the hook with CONFIG_SECURITY_NETWORK=y, and use
> BTF_ID_UNUSED otherwise. The ID stays zero, as it was when unresolved,
> so bpf_ksock_kfunc_filter() keeps allowing LSM programs: none can be
> attached to socket_sendmsg without CONFIG_SECURITY_NETWORK.
> 
> Fixes: 7ae4eb14c5f9 ("bpf: Add ksock kfuncs")
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Acked-by: Mahe Tardy <mahe.tardy@gmail.com>

Makes sense, thanks for fixing this warning.

> ---
>  net/core/bpf_ksock.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
> index 7bf796193ab61..48a2e2327acef 100644
> --- a/net/core/bpf_ksock.c
> +++ b/net/core/bpf_ksock.c
> @@ -258,7 +258,12 @@ BTF_ID_FLAGS(func, bpf_ksock_send, KF_SLEEPABLE)
>  BTF_KFUNCS_END(ksock_kfunc_btf_ids)
>  
>  #ifdef CONFIG_BPF_LSM
> -BTF_ID_LIST_SINGLE(bpf_lsm_socket_sendmsg_id, func, bpf_lsm_socket_sendmsg)
> +BTF_ID_LIST(bpf_lsm_socket_sendmsg_id)
> +#ifdef CONFIG_SECURITY_NETWORK
> +BTF_ID(func, bpf_lsm_socket_sendmsg)
> +#else
> +BTF_ID_UNUSED
> +#endif
>  #endif
>  
>  static int bpf_ksock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
> -- 
> 2.53.0
> 
