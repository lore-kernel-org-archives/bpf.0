Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BCF30D40E
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408601; cv=none; b=eza+1KVfNaEy6qxbbYPJROIOHKIefpujTRQ1mCi38y6XsGx8Gax3zA0lvbd2cgcHtzMfNGommPKfUwJN9WBE6ShpXhUkukWQNgRWsQWz+v1L+XEd8tNSRY4TsImHG7rq8kWVYZ837Vu39LN//9Jg4DYJiCsbF5r0p9ryTvo16RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408601; c=relaxed/simple;
	bh=EWf5c8ljj/09dklnGXsFMrD980MsIpsyxtjkVc+RqkA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VoAD3pXdyMZp6Ay1LjmqMlq4RDUYHjEKPxIV9HxGSzaQh31/NdrRIJaM1/BBf9MnyG9cirocFQOM5TdF1XvM6EtYoDg+abXj5gewBcOe97jrprQHAtWY3d24V4ML2OA8Qo3QyUaie/jPwqNaL8R8bXclZaimoJ9w8HADOp1wfJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XoDmMQKE; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XoDmMQKE"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso3117374a12.3
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 04:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1792408595; x=1793013395; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fGQ+9YD2bGTiX9CIhcjMfZ/cpyi6knaOi/h3v5oGsFg=;
        b=XoDmMQKEOQKqUxk8KfM0lWSk6tqVxd/OrMnljANod2AjeUj+ZKyXMVx4I0bXDBkHD3
         IwaI2WsPta3UXoWumUv3TC/4dqRwd+ebqIAa10goyWn4YwO+y+hVRL8KqF3t8q8KfXjk
         CLXs+bFc1Ow1OVeedSxzDlp+/eWkjCDGLy3vF+gMqamGqMOY73czyqvqJyEI6J4UNldg
         JHRIEJgAEiXQgiHVMt3dWgJEhP4Jv3nFUbLCE1s+giLKgIUMf3YmhRmL9hY9BDZisoET
         oJXY8DDcy5is+2ytLJVIWp7mxmEGNIOJMR7JjdjEprBOqkAMZCecX844al4AdPy6LG0c
         F+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792408595; x=1793013395;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fGQ+9YD2bGTiX9CIhcjMfZ/cpyi6knaOi/h3v5oGsFg=;
        b=AoQZsfCYgQV6zpWkT4uv4p5Y7y2Q6rEAH9DhMZcxcbCKqDSVPEvRnny/2tjJ2G7VW/
         TEf1lCfLsilKIuY7k5+h6KZ0iEbjRO2ALKcy6Gwch72CTZ0YnPZ+h2aor8O+V7zoYpN9
         QorY64jMEyspknb6cCblCI4ZOpXtH9ffwqzCOXdPXmU0cSs6uLXW5h9t2a3jkScdIFxV
         BLi3yxj4Ds3u53/ao7C0XmBPEltLmqPhj2y/FYezVW10R3eOhogQfZEjctOGj69tmSq6
         nXTxbMHvXaitmkgxxrAVhheiRJvNoCpnOsdjN/iNEOZSbmWSJzMaZ482m4DLtzQidAou
         PEzA==
X-Forwarded-Encrypted: i=1; AKwUvBxUFBkY2KsKg+mjmxfYSEEvcNBZ/jF8YMJGzKVwVocKqoqsmfgEEq7+K/WN9JT5Bjh4HlM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5v+ZYXWWYhJe1YHNZzvZuUCjNPTfg8x44dIcTipPCdy+jSV58
	XOq3Vm43NPK1LZo+ujD2IubY/739nEvMfIK4UD0rKVZSO4pMLSblGW1ai+CoE2CPOxs=
X-Gm-Gg: AYBFou30AX+VtsYOMmsS+SpQ9sCyIyNoylipPcrAfllMtwt7ANTLBgZ03r5kuRMHBQ6
	JFmRpJgv7ISHbVCm5BrlF4yvIjiJ1j/HHmK8Eyk5pOykxNzbhfQDEgqmpAjall7lNV6+cwIHnBC
	j6Pu9PNn85udwfF4lSyNpXax4HK+3Sw5rheBx0US3vTnkQ+fawxpzaCxKJjFp7vZ29drBBNhtSS
	rXTTThXeL18t6JhlCWxNdsDEfyQe0aBtawSXZiB86vlloil0QjZKYAuOH40Iro4edNwfBGe8D+D
	qlvx2GA94xX3cVd8C9XPiL3eHf4XiMLoLr6GOoe4hrGytjcu3MU/vIMXiMe0gQQ1BpD7dItNyGS
	u1kh1dfX3qt5Q4For0koBk8AENRCgCfe4cdbS95d23W2hwGpnH52akABujYOidh9n6eu52t2Isy
	6mOj98zTsCg5M/WBSju9qxXcPwYAFHMiJN+Bqub/qevT6j/KSobNdoWAwvre7e
X-Received: by 2002:a05:6402:270d:b0:6b1:c7d9:b631 with SMTP id 4fb4d7f45d1cf-6b3a8191a46mr4712969a12.23.1792408594035;
        Mon, 19 Oct 2026 04:16:34 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:5067:2dc::49:220])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1e9e44sm3663824a12.32.2026.10.19.04.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:16:33 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  Jiri Olsa
 <jolsa@kernel.org>,  Emil Tsalapatis <emil@etsalapatis.com>,  Ihor
 Solodrai <ihor.solodrai@linux.dev>,  Shuah Khan <shuah@kernel.org>,  John
 Fastabend <john.fastabend@gmail.com>,  Lorenz Bauer <lmb@cloudflare.com>,
  bpf@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf, sockmap: Restrict iter-context
 sockmap updates to iter/sockmap
In-Reply-To: <20261016-sockmap-update-limit-iter-v1-2-23fa946db59e@rbox.co>
	(Michal Luczaj's message of "Fri, 16 Oct 2026 23:09:14 +0200")
References: <20261016-sockmap-update-limit-iter-v1-0-23fa946db59e@rbox.co>
	<20261016-sockmap-update-limit-iter-v1-2-23fa946db59e@rbox.co>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Mon, 19 Oct 2026 13:16:31 +0200
Message-ID: <874ieiey9c.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 16, 2026 at 11:09 PM +02, Michal Luczaj wrote:
> @@ -10341,7 +10342,12 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
>  	 */
>  	switch (type) {
>  	case BPF_PROG_TYPE_TRACING:
> -		if (eatype == BPF_TRACE_ITER)
> +		/* iter/sockmap only; type check rejects a freplace of any
> +		 * iterator's bpf_iter_sockmap() subprog.
> +		 */
> +		if (eatype == BPF_TRACE_ITER &&
> +		    env->prog->type == BPF_PROG_TYPE_TRACING &&
> +		    !strcmp(afname + strlen(BPF_ITER_FUNC_PREFIX), "sockmap"))
>  			return true;
>  		break;
>  	case BPF_PROG_TYPE_SOCK_OPS:

Explicit bailout when prog->type == BPF_PROG_TYPE_EXT might be more
self-explanatory.
