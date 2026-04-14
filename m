Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A32B2DEA6B
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 05:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776145099; cv=pass; b=n55eQTwG3K2BogmgR+jTzuZhKVIxwldfQeCWpE0g5qCCa6kW0W6JBBdbF9RsFl1gpClppVUausXKKdHjnEVEOI28D6eH69j+e4jKmdmTE08ZUi4WCtgNB7Y4ZmIHCx+8HF3rPrbMwMqJDuTXofTQLUOLZCjtQ27HYma1LAAYMDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776145099; c=relaxed/simple;
	bh=SEgP0fceE86DFC9oMMpK1J7dvL8jcergkUr0WSq3DWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqXRuZsPY4Ccb4oNZCTvTnLKJxMmacStoGnYTxiEUWivClrVKz9soDYBfqrlh/yGEqrjN0oEFSXqLEIYDQmGiIMqc9sNB04YL6w5VmnrR6Uw2uaKAA4WTFrJbvXsIrBgo7ov8kGNh4xvw+XJa/WLN6PMqmOtRErtYAEZOo19tGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EECnFpuC; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EECnFpuC"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12732165d1eso15402766c88.1
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 22:38:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776145097; cv=none;
        d=google.com; s=arc-20240605;
        b=NH9uqIlvh7RwOWn66dYjWrAdiiZKKIbpEsZKCX/lRIOM+jUaK8afIRdyMcWYdS4+sq
         zNUUHJapuF/nGCd4CA8qi8hFDBeWfifGgucuZP5voRdMlYqAPOm81NK9XNuyLHVJIjRn
         AMm6lsOPj/djvCIBpQSPhuQLQKh03Am49jbevRC+gaT/olKQ8frbdrmGnfFUW/dKVRMk
         VhrM+Mb+gMyx869rH6JtNC3F3Ud3o0l/pakvAocISsB/jqYOtVLYnLCf369r30QIX/n9
         q8CfhKHk8UepRx8rNOv+U2NhEtHPtVMvi9eci5JWa7qhNpCp0Od0XCsCUhVfJQLp2Gsf
         ZfeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zXWo2P9ezVXwa5LmBlwuFL6gAkMCnXORmCYFdzrnPqA=;
        fh=IHrzvupWAg4RXYP99oE+fl+QJCvlqLN4NVQ+algbK8g=;
        b=e0gglLy/Z4+xJLI8n08liQDs5MfoPzFioQgMs8HIwk6ow6Lk6oE9idYk9t0Vge6ap8
         ofSRFFWXzoZp3EkI4jHJiW0IM6QMjHJ2BMPhTsfTwXGzVZIEfak2op3718Kh9CZUL7aD
         ZN+UHCboh+C1NRrsvUtgAder9VNdPdTGPue73Q5jIt9NG72VT0zormFt5VQmCy49pgdo
         cJFyWCVKVsmTreesmsL3xspG+mj0IoDJSsNTxN1DlIZ4QMzK55WcqEXkWwVBl4AlwRtM
         pjhtiPO0h6u7OXwvZe0TtUe8ns8RgVL1ePzIrnF3214y/jMXk5u2jeDKfg8fwpKzaSeW
         PF3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776145097; x=1776749897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXWo2P9ezVXwa5LmBlwuFL6gAkMCnXORmCYFdzrnPqA=;
        b=EECnFpuCM4sgtbnXwfpLTi7lZFQBehnXL2My/7EJ6oh4vIv7pelG9p8n1jjmGg0LU9
         yR+vkNnlH0mnwYQXrptgOdslKht1B8W4h8rC9crgoGQ2lsVapIAVAg5IhIx9WluIAXB/
         Wihjp8vx8xE9n3FDoS+jD+fuSEvgHdXR9dZ6DqVLRob+usgi0IeuHLh3vM0KTHdKuE67
         Lu8BCYLVMggEob0L0xhlxsC4Fhsqa9jLP+Vbq+88jNP4b5Qwq6ctx4Rab4eBLwOjQJ4R
         9ttVldDmEjppu9mUwWWV6NijcwI52gYLS/4ifUX7SmBmwCClfSAVBmNlO2xE1W7FZDM6
         TK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776145097; x=1776749897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zXWo2P9ezVXwa5LmBlwuFL6gAkMCnXORmCYFdzrnPqA=;
        b=d0W+xXRZ4dnJjqvX13PNGOFepCFWZsdsBiggBd8wZfOsQ09w0S5ESFQnfUcXERMHAj
         bfQsKqk8CNTLUHte5S31k/RZ2w1f4hA1RLMU7t98cpfi5dVF+4NnC757YjxPkF1LulbV
         1uq51C48N43QFsaVrmGu6F3j6AEN+V/PVwsSngAbC6zqUH6xvcJwqL+G8pU1cof1N0eR
         4tF4Cx+QnX+X+mXWqqjP57y8m6jmkrquZu+MqjufpjRMoQhHpU9rwaBWTzLO+BP6cdhW
         cIFAmnkChqinux+u2lVaPgXo8gHQLzWuQoS6PGSz5Q2UupOKxaOy6ExFxvuh9wKeX17A
         kLyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+9V2iuLfGPrpe1vbZ5FHyD+hQyuc3skcdY3KhR3uiL1Ck7U5kt4UjJP7sRCrgaMwBky0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV1X64LimAjYxseghjBJjkLeY+Ua2xIPyWo6BnRiC/Mf6Zde6x
	zI+TPSa3CW3Q08XoGSxHbA1sgm/siL8yDybMkgjeHTHZdVAXwsywq3IoryF2tpwJte4N+AVKsFJ
	8qXP5Gyy07ZQbD43FpcuU5h1IrbV1g4cJEJutoISv
X-Gm-Gg: AeBDieusnHIPYNEmGZR65rvS1X2L/Q8svxVb6JQ8sLcpHrARTUVSTo9S4MaMAhvtiTG
	YEpNbZplL1X4ZzNMsUe795meRaNA2MkCqsmQ41YPlABK3A5GVrDfpqHQGO+zPwcMT998Wd9lWzq
	HqFcsMeTcTcxBQfPuoSwPYJCq7ZtSpmzYbyXtLC3vRpbZD3nOWOQKsQX4GOWtWbQMD+KZKTuhr0
	mWb4KZmlPTkhWMIiXYksq5u1j+6NWV4i0uFDY68ocp0aGfs/qRPatGOFSCh+8dFVo/Y/JvwepLT
	JQH9X+XUS32kFVG+r+eBhgVUMCdEFLlmreS0MgmjpOF6+u/4v7LPZcn+VV9GCZEilOby5M4st/u
	GvZCzS+75Fl+s2HqbMXyPyo+Qx5AEi8S+rWFxvIdPHM1GxrWa/1GS1MU8sipvvTMjgdnVQP6Xfg
	==
X-Received: by 2002:a05:7022:5f0b:b0:12c:4931:c2c1 with SMTP id
 a92af1059eb24-12c4931c48fmr3119961c88.17.1776145096772; Mon, 13 Apr 2026
 22:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411013211.225834-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260411013211.225834-1-jiayuan.chen@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 13 Apr 2026 22:38:05 -0700
X-Gm-Features: AQROBzC27SzddYjwc9fK9yY-9esB3ZsjrFKLPKh5IEaWO3wNOlhHf7godPh6RSE
Message-ID: <CAAVpQUBWSHG77Az0uXODq50q9Ys7H8a+v8qkSBG-PLqBUx68qw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: add missing syncookie statistics for
 BPF custom syncookies
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 6:32=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> 1. Replace IS_ENABLED(CONFIG_BPF) with CONFIG_BPF_SYSCALL for
>    cookie_bpf_ok() and cookie_bpf_check(). CONFIG_BPF is selected by
>    CONFIG_NET unconditionally, so IS_ENABLED(CONFIG_BPF) is always
>    true and provides no real guard. CONFIG_BPF_SYSCALL is the correct
>    config for BPF program functionality.
>
> 2. Remove the CONFIG_BPF_SYSCALL guard around struct bpf_tcp_req_attrs.
>    This struct is referenced by bpf_sk_assign_tcp_reqsk() in
>    net/core/filter.c which is compiled unconditionally, so wrapping
>    the definition in a config guard could cause build failures when
>    CONFIG_BPF_SYSCALL=3Dn.
>
> 3. Fix mismatched declaration of cookie_bpf_check() between the
>    CONFIG_BPF_SYSCALL and stub paths: the real definition takes
>    'struct net *net' but the declaration in the header did not.
>    Add the net parameter to the declaration and all call sites.
>
> 4. Add missing LINUX_MIB_SYNCOOKIESRECV and LINUX_MIB_SYNCOOKIESFAILED
>    statistics in cookie_bpf_check(), so that BPF custom syncookie
>    validation is accounted for in SNMP counters just like the
>    non-BPF path.
>
> Compile-tested with CONFIG_BPF_SYSCALL=3Dy and CONFIG_BPF_SYSCALL
> not set.
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
