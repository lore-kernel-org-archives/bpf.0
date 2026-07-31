Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D6435C19B
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 05:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785476387; cv=pass; b=D4DKXAlYLi1rc13158AN5FsBOCwt+5xDVodZlTuDDeLGmLLy/T7jgFV3DCKXGM5uclv5KCWtdJr9PNBAD70g5OLNKWbB7gMHaR4K5sJ/gmRgckyS+rjQSfvx+RL/T4zB5G1mHi9EwVvidj+qYdSQOIfXFU2a9tLHV46XAwhPa0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785476387; c=relaxed/simple;
	bh=YV6LY5U5Uupo/A5L4Qsrdwx+wBINDhZH9IMMf93Yq04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAn2cH7yuAXS61D9+39Vbhy6s1cefzH+t/gMUICMkz/cg+pFrXL+L6OLlROluPBDsJhSQIU9qqXRdXnPD2pFAmecRjmlCacX6PTb9Tp5Qw7zYKLIAuKEEBoEt1j6CZolraZntn8XJ71ZCoi2+tBMsMaRQWbhF5xQ6645SYxsAlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AiyAxg26; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AiyAxg26"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca80d708489so283168a12.1
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 22:39:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785476384; cv=none;
        d=google.com; s=arc-20260327;
        b=gEBCyM2MdWc2VuwBBXr3CXFQu6v/TCzPt3GJZ2Ny7c6NbsuA2P4HbxXVZ8l96MO6OT
         03KK0a22o1knauuoNd4ja7Q7K8UD9iKp0mFCGclqB6Tu2L/RtNb116EVYCATBN53rWaE
         X7FMhCWDsn68Xgo/LuZbZ1+J3ZSLiT8eXOWEGwNvDNxCSSZSqd1g3LNW8nSzn8P+gYoD
         ySdlvnMIDP+RhCohMbaT/tZlro9xxufn63OHwHNufF35VxJNhGrUrfS2E61caqK+PsRv
         4m/k5vWcZWylETQvu1ZXOvHBKpx6P710IUfHMhcV1GxovSxF0EWWINM0wp1/UtjZuK2k
         iIng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DZKGE5oBKOH3b3bcGD4auMb5IliGML6SzVDN+KS2CDk=;
        fh=/FOQTdOBFy9NnngJDVvPDq/1jfNosPkvJM7WDzTmUz0=;
        b=eDj5dyENWwGIEjHaMOvzwmIP/CMR1UNYizwyPVIqv3ybDsFVnKm9FHrgvR0fzwzzK4
         RIhdBEnjpso0RLIjIRjAscLUIS+5ZoQ3rUia0C8Tlm1emdcOvgUV/3cIH/0zPw71lrZ3
         dGXcNNowsoMo0GKgs7TGWX0Ta4kwrV2PWzV5QNhwzgA9KEtRPcnm3husddgukQ1BDIAY
         PAYYPmD5QumMnzvoWBB2tEyMXsdl6i1RgIFKqwpdqYIKWQL/VD5CFDZFMLwsG3jR3F8U
         7pzndG+pfN6iMi+Mk2YT2m3SAPwZE2VcF8z/Zh1zUK4Ux7UyGJqE0N1fPxS9t3eBXIfT
         GGkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785476384; x=1786081184; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DZKGE5oBKOH3b3bcGD4auMb5IliGML6SzVDN+KS2CDk=;
        b=AiyAxg26dmVYY0x/c8RfMvsUDsgpBG/uk0ymiNw7JdZmSEYMjQ13wj/tfnew7+0b79
         6ueOai3jMgzzw8WKNpciuNRwUW9RqPKm/cA73riOngMFnghcxMLNDwvAhzvbZ+oX4OhG
         al0SU0LznsJrx0YYrwUfVZk4ROfVQnM7AWMC07k2KEkq03HCBhbIXFdluqHvdtuPqhoW
         f7wuEOzwUZYIkzRJ4MMkfRmj5U//YHbILaq/GhAOD3AucTMkY5bS8TMXc4IcRUVUntjP
         ca2luj1rDj5vNNF+Y8kGCoys/CKCi3bIAALwoCi1CBqHAEFrRD366u6nknJv0Xf1R5/X
         A2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785476384; x=1786081184;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DZKGE5oBKOH3b3bcGD4auMb5IliGML6SzVDN+KS2CDk=;
        b=YRg3Jn5E+kqu0Ecuz27CTQ+HR3xCQYYtjo7HAmQHCnFl04DawwHzlc11iBndnwPNYp
         sEop0naKHeHykbtImv+jYDlP5U7CbKZPj3Nse6FLAcYvub1SbCKyR0IJR2RCjFTtoSCH
         xE8SqnLLEsNnh8GE9QZPTFjoDUzh1TlwoD4+q24j9lPV6IO/zK5yy++23QzmkWD272la
         lZqXubv1vQsfe1wAXE59KOR8DeuTupFj0YJbLBmjcN7RS3DFjaHD98+/fCr9Z42VWPgz
         htMe2iUfMJyJYEqnkyzK7k8v35GusWSkGLh/kzYmwAMgK3dPRUTeBQxcNe8JlqQdYN7i
         SEKA==
X-Forwarded-Encrypted: i=1; AHgh+RrRWUR0mUlBxSACLJIEKWYkXk8AzO+34c/3uKrm52oiDq2iLm1YbvxOlKWUty2jTYJ6Ywc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVirtqiiqOImiczadhgn556/puOL/Isn7ngBeZRWEMjRQdUUcd
	vjrxddOYsmOVNBKEp6v2Dj6VnjCEZZMVNf787R9fj08b7zFmC0KXAmqaGacKIgOJ5pbi833GNZg
	5ucvkk4G/h8L6/NY8al2PPnKANcCk9QiK8PnEUGCq
X-Gm-Gg: AR+sD11n1z8T/dGGIGv8at8QAu70ae+p+1NxyUecvmDXg4bwLMyqIyR+Hf7hmB1GuzR
	wrqP0US+kE/j3oNjxIAWtJT9kNDySMzCUIMiTv4xixcbF+zdiEjzvARi0KiGZSCOf1YS2Mf1IFo
	jkEFrAPFhWYPw1u3yRBgdZqO7YqSEpMmK3XsNnLrcKtyKEl2OWanmTC79Dc56iZbl0vev/IMWnW
	zfQXW9MW2MuIs0IeKcbRRSevEAbPaDd/knxTdA+cWFsKObM2jQ01dw8FY3rnELzxYOJ9601gYxX
	ETzH+RXYCt4+rfG92DeUu+etw9iMD+oMDopvnDjCoOZYmLpTPMuXNBuZZIP7Gjrut9m3IXBrLPD
	dOv34p0cTEXT7AE3WyKWzjD7jrCKd/1XDbWda4V5nc+YMwfE+9b9o5maBXnKp2AhLZrXhee1whM
	RulFO3lTBXgy7N6w==
X-Received: by 2002:a05:6a20:da14:b0:3a0:c246:bb98 with SMTP id
 adf61e73a8af0-3c91a986ba0mr689991637.29.1785476383794; Thu, 30 Jul 2026
 22:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-bpf-iter-tcp-refcnt-v3-1-754b9c8a6717@linux.dev>
In-Reply-To: <20260730-bpf-iter-tcp-refcnt-v3-1-754b9c8a6717@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 31 Jul 2026 07:39:32 +0200
X-Gm-Features: AUfX_mxoiNAZ2_4GQT37uXq_pM18fA3M8ZQOQQVR0wahW-fHgJsC7RX5hVgtgCg
Message-ID: <CAAVpQUAoxyhmfbfCGeMUyQK7F4RifMsFDM0XyDqO9SOMZmASvA@mail.gmail.com>
Subject: Re: [PATCH bpf v3] bpf: tcp: Fix use-after-free in bpf_iter_tcp_established_batch()
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 12:33=E2=80=AFAM Jose Fernandez (Anthropic)
<jose.fernandez@linux.dev> wrote:
>
> reqsk_queue_hash_req() publishes a TCP_NEW_SYN_RECV request_sock onto
> the ehash chain, drops the bucket lock, and only afterwards sets
> rsk_refcnt to 3.
>
> Lockless readers such as __inet_lookup_established() handle this with
> refcount_inc_not_zero(), but bpf_iter_tcp_established_batch() uses plain
> sock_hold() while holding the bucket lock, on the assumption that the
> lock guarantees sk_refcnt > 0. That assumption does not hold for
> request_sock:
>
>   CPU 0                                CPU 1
>   -----                                -----
>   tcp_conn_request()
>    reqsk_queue_hash_req()
>     inet_ehash_insert(req)
>      spin_lock(bucket)
>      __sk_nulls_add_node_rcu(req)      // rsk_refcnt =3D=3D 0
>      spin_unlock(bucket)
>                                        bpf_iter_tcp_established_batch()
>                                         spin_lock(bucket)
>                                         sock_hold(req)   <-- addition on =
0
>                                         spin_unlock(bucket)
>     refcount_set(&req->rsk_refcnt, 3)  // clobbers saturated value
>
> which surfaces as:
>
>   refcount_t: addition on 0; use-after-free.
>   WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x48/0x90, CPU#1
>   Call Trace:
>    bpf_iter_tcp_established_batch+0x14e/0x170
>    bpf_iter_tcp_batch+0x53/0x200
>    bpf_iter_tcp_seq_next+0x27/0x70
>    bpf_seq_read+0x107/0x410
>    vfs_read+0xb9/0x380
>
> The iterator's stolen reference is lost when the publishing CPU's
> refcount_set() overwrites the count, leaving the socket one reference
> short. When the last legitimate owner drops its reference the reqsk is
> freed while still reachable, leading to use-after-free.
>
> This reproduces in seconds with tcp_syncookies=3D0, a handful of threads
> doing connect()/close() to a local listener while others read an
> iter/tcp link in a tight loop.
>
> Use refcount_inc_not_zero() and skip the socket on failure. A skipped
> socket is still part of the bucket, so keep counting it in expected.
> The reallocations are sized from expected, and a request sock whose
> refcount gets published while the lock is held across the last realloc
> must already have room.
>
> A skipped socket is counted in expected but never batched, so end_sk
> can be short of expected on a batch that is actually complete. Decide
> completeness by whether the walk left any socket behind instead. The
> WARN after the locked realloc checks the same, replacing an
> end_sk =3D=3D expected check that could not hold on that path since
> commit cdec67a489d4 ("bpf: tcp: Make sure iter->batch always
> contains a full bucket snapshot").
>
> If every matching socket in a bucket is mid-init (refcount 0), end_sk
> stays 0. Advance to the next bucket rather than returning a batch entry
> that was never filled this round.
>
> Fixes: 04c7820b776f ("bpf: tcp: Bpf iter batching and lock_sock")
> Assisted-by: Claude:unspecified
> Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks !
