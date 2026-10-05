Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF13231836
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791227610; cv=pass; b=Zn6C0pcSgqXcPDPb6dUt24saZCesGTb49D12SSBWrjtD8sD9wyUYZWwDw3gn240RGxhsK1KPxVFxsH+rOtPPotj20jeSQ5l+dH4h+NpZfFRN81KJQlIfTFeAYwIg5XnHLptQrqLzOtjA3w341HUNS6xkeWTtLPc5FTgNkWViMhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791227610; c=relaxed/simple;
	bh=cf3Wz/E9ru8iJy0m3FqCXyB0QpVmE6CICJ63f9iirrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bphTX9RcL5iC9olDhCBbSBlHVdPk6WlDg+xl3Ev92OTkc1RCT9lHEsZHOlfDu9VSpn8yiMWmyilgGpIcNXCXp0ylY8uPIxY+4me1sABo5UwYxj5y33vUcitaIHtvWIAsVBNTjXyPr7rfvx8l7t1n7BygSTTm5oAsYJhPSadyd/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jih4jQcQ; arc=pass smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jih4jQcQ"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1560523a927so169181c88.2
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 12:13:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791227609; cv=none;
        d=google.com; s=arc-20260327;
        b=OQFPWg9tMsWVdFtSE5UqoT3Iw6Qp4aw2IDP8m/XAqmzoD2wyYx0D2e4TL56z1ZuqsV
         KwmnxxdsbSXaUoVTSwWzaBWeVxmT34QNH93FnXUlcsIar9kuJaPs9uy7k97/agPYZcuH
         vS/90qVXrBtUqD/jeT8SGz2ooUDaMPk5tQnLGe10dZA0Y4/0v+vrNOUWfH+eskBK0qVy
         JXUjwvH0CajHST6C9IQZObm1kHFtKONbwI2igHEF6CEEnNBhcM8DobQ6Kf+6ezXwOOJf
         8RDn/ry64fYVG+lVXA6Jg/bcUo8JdOXrurgwCiSLr50b2/LrnZYI4OkHnMgDETf+c9rO
         OxPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Jb/wYrDSyqwwKuUWfY9kUnNka8L6Lv74gF1eaUvm4I=;
        fh=2vV/+FtLjaFN6BvWJte/2CBXIJ5gOGx99tmV+KiDzcY=;
        b=pdfEfAu44VQwJMSpJcQMu2LPZUZk9UEsCJKIJuF6B0Ewr8F1vgrUloB3D17OrhVg1I
         40IuC+oPpER2iDeU7W2CI7tlmYCIDBjgCjX8RgEe7ywweG0Bh0LAGLvb11mGLoOnSsly
         opYurPvGeEk6IdZa33qQz5WBWhepSR5nDv+atnS5w6NLO8K47TwG9zD6ruU1qZqZjlEJ
         YWcUwzLYHHnRUNsTfhHd+VySjFBmBpRamPrVbvGNaC4C3ZMs8KKnZGG/rHXJUyP4XKrl
         TxUROgbCXH5p89rUkMzYF7jGVJw5e/GxXHwyZKZTmC1UnZqimGl0Gav5wlr5GE45sk1w
         OMsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791227609; x=1791832409; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Jb/wYrDSyqwwKuUWfY9kUnNka8L6Lv74gF1eaUvm4I=;
        b=Jih4jQcQly9/nBx328X34bfHGEgP24W2jwh35N+U0irBsxcx5AggGRLtu3jVUI4ZJ4
         Liq9zO/L50TT2W0hNiRIRAgjGQp0zO8cZSNi7Wa8jwKVrZqaflo6vSQqeXxr+g6impiD
         tcz7TAG5FN087J7RoYN9aKqrHpqe/bxEgQBCYaUpd2zYTv6ik/TGkiXDCeckr3w2mboT
         Q1eD+a49yoZ/RJSaN6d6f8f2fez7HNAGLVHjF9RpHMtG2s+KPpakh27NRIPVPuavOa60
         nWwy7VHSyq1T5ntncoJrE8Hju7wZfZTtxTnUoolz91EQxYhuBOR2yCZk6Z1b9IoeRwki
         BJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791227609; x=1791832409;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Jb/wYrDSyqwwKuUWfY9kUnNka8L6Lv74gF1eaUvm4I=;
        b=SO4fUlSK/rJsGvcKO9t8squZEuJ+yLqE/KgGcE690vp7C7l6dZRyYLPBvLZvGwn2zf
         X0fzOOiv2qRuExYpWMSudQfqPNwE9206x0+C41/S3BfCyTwqWE5YiYpLG/I7JgKnPa4V
         WdTzDI/9gOSqkYIqIQjkHJaf2hb2lWiZvXTNbUkFKyuqV5k9HlC7BF/tkqZqkjVyu1fx
         /IMWVQFtRAfeEFSBkXJIbyfGUkmyXLOwpuOqRvmQGPKnXVggjB1isYcHZHRjLWtHoA6v
         d5DIlmAg6ACXLibVDQRhyYZxBKGO9IF5EKhCiPk9AbTN2GU3AR7NslOrufySmgLQ+e0O
         lD0A==
X-Forwarded-Encrypted: i=1; AKwUvBzBWIawx/Yyie9rQGZhJPHJe46POwGlofEE88sCfvQ0na0QayJUOrqkJgZWpvpxnapODek=@vger.kernel.org
X-Gm-Message-State: AFuF++nXh0T5T9TBoOAbgYmNvpLxguLiPe7L7VWcJMBAHxjHQ5+DoZSR
	/svKb6b1Tx23Rz70PYj0WjctQlopD1JijKVlKpkRtFliueTCd3vrJJdm9hpSyg4Xu//eshEkI21
	ERlFtSMCjEVxEhVby0dobAqZ+EtZ74woyuIL7wk12
X-Gm-Gg: AYBFou2jzVTBQ6GKdXuFz4Ib48LiJiHCBE+cZKutlTSV3vPAhUW5QhPsKPdaqqYAkYq
	bjOTETv7mIBML/E0xubd3VTojzZ5V6qfYUqRuHZYXfsZ5p+63I0n4kpxgl336GHfXIekC/5/iyV
	3pUKF7vqZRpLhiM3kmHMhJNAwA9AADXzI9HTMiQqkXcwq58V3Y+CENBlDBCdgvw9nu08mz+82ab
	AkxRmtQhS7oDU4pRHSLkiq324e0Vx1/rgnHPXd2Ya4gHx2OSFaC4GryEgatgMAW7Fi05dxUDNrU
	++UZoNgxbVfpHYuxzM42KX9HMDTaE1EVMXUFa16b11XoLUQCWVmOWkmesmVRhwa/ZZECOQXpuuP
	3x8/IDy3YGjlnOaK80sQVOI+8Ocyl4sXA3TsDg5OuVRTy6zJ8IKhb4vcqXqx2O92Ruz6NcGPWYR
	h9fr4EXYv5c04gjBsw5EtI
X-Received: by 2002:a05:7022:7e0c:b0:144:f089:b189 with SMTP id
 a92af1059eb24-14f5cfbcb83mr15242930c88.36.1791227607704; Mon, 05 Oct 2026
 12:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005154533.4147685-1-kuniyu@google.com> <20261005154533.4147685-5-kuniyu@google.com>
 <CAMB2axM9iTXqAGkQ3LDB-BRtqs-dVrkoHX1DkXT72KVYjrHQbA@mail.gmail.com>
In-Reply-To: <CAMB2axM9iTXqAGkQ3LDB-BRtqs-dVrkoHX1DkXT72KVYjrHQbA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 5 Oct 2026 12:13:16 -0700
X-Gm-Features: AclHuK-To4WN7JywD27eGj94zp4mI8c4erhwTAfXHpFD_z2LeT6hzZf1l8OM1-w
Message-ID: <CAAVpQUC0QRn6mTenuct=urshPg4yA5dxWKNGHrU_sOPTS9Q4vg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 4/9] bpf: tcp: Guard fast-path
 bpf_tcp_ops_call() under per-socket flag.
To: Amery Hung <ameryhung@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 12:10=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Mon, Oct 5, 2026 at 8:45=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > bpf_tcp_ops.{parse_hdr,hdr_opt_len} are called for every
> > incoming / outgoing skb.
> >
> > bpf_tcp_ops.rtt is called once per RTT, which is every
> > incoming skb in ping-pong workloads like tcp_rr.
> >
> > Even attaching NULL callbacks in the fast path hurts performance.
> >
> > Let's guard them (and write_hdr_opt) with the new per-socket flags.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  include/net/tcp.h     |  3 ++-
> >  net/ipv4/tcp_input.c  |  7 +++++++
> >  net/ipv4/tcp_output.c | 20 +++++++++++---------
> >  3 files changed, 20 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index f69091f5e01f..48487135c076 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -3142,7 +3142,8 @@ static inline void tcp_bpf_rtt(struct sock *sk, l=
ong mrtt, u32 srtt)
> >  {90
> >         if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RTT_CB_FLAG=
))
> >                 tcp_call_bpf_2arg(sk, BPF_SOCK_OPS_RTT_CB, mrtt, srtt);
> > -       bpf_tcp_ops_call(rtt, sk, mrtt, srtt);
> > +       if (BPF_TCP_OPS_TEST_FLAG(tcp_sk(sk), RTT))
> > +               bpf_tcp_ops_call(rtt, sk, mrtt, srtt);
>
> The new per-socket flag load happens before the static-key check
> inside bpf_tcp_ops_call(). Thus, even when no bpf_tcp_ops is attached
> anywhere, every RTT sample (and other similar places) now touches
> tp->bpf_tcp_ops_flags, whereas previously the path stopped at the
> disabled static branch.
>
> Can we add something like bpf_tcp_ops_call_flag(op, flag, sk, ...),
> with the static-key check first and the flag check before the cgroup
> lookup/array scan? This would preserve both the no-attachment fast
> path and the flag-clear optimization for attached programs.

Makes sense, I'll add that in v4.
