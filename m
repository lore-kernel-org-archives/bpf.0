Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A2930AAD8
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791227431; cv=pass; b=IvuS4BYzkwqTa57MWToB+6Yep2W4D2jziHSDvFYDDjQgsLg6lgmCv+V0jmveaG9ZcmKZhKOvjC7s13nAGq1VarNokCKVSQt0SFCsEmk/3D8fDSN0E3oSBpsOrR1Lqup+BxEjywz8g13eLQfhAVjifr8flCUvDj8RWapakGmMzqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791227431; c=relaxed/simple;
	bh=20WXjzJT+PbMKu2GbgSthOHdONEfZvO9MLXB1Gc08nQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVrUbkcmaaPyIGdDgJy/utDoDynC/cC7Vt0jmZMlvCAGu7m2kVLSVTLSoD4IuK+CtrwvbukTu3pr5uV3oEWliUovdyNTV6aKLfK0R00rLD2RiLywAJJTf9LtbVxHue1p1LfEVJxQ8wwarKhCeU/P057hPckaZ7jHIZ51ukJ60ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7MurOY9; arc=pass smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7MurOY9"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4c9859ea2ceso1465633b6e.2
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 12:10:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791227428; cv=none;
        d=google.com; s=arc-20260327;
        b=e5RrhulgmW9AuusHfpLblnUT6GYkY7xVi2YC78IczYuBndwraecJN3hjZnbOizbLts
         cjeTcuAmpLkv21RJJh1Ma6/EVfucP+JnGMdWHwLkRKFyNaQVmOgvMIN6m7gwzQM5ou/r
         /HlqCK7ytTHgEUBU0V9B08EtCxQTR71aqWwnM2eMmDhZa58NPVtK8HPHSoLAsLaegOws
         RJpYdqRV9jdnaX061ZpqOavKvu9l/bdYIoG1/GUv7Tv2FLTb4f+TDHaMCn1sNQZDzBdA
         DgYRe0WGoDbgR+TW5HbUoM3/MIZd98GzxRB7aWQfSbuKnZbEGwXiWe5ehRApGbCEJqmP
         ZfUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sZ3adpDGT261XkCW8nTjunmv9uU6/6OcdwlNEH7xpts=;
        fh=CKEK3OnmOW1XMdvU0WhVHt0tBWg6FgJ9BHranB4/+yI=;
        b=KU2I0v1GR+/AoFrJlG+qbR20zvspAcoij8a0qxC/3V61lupaikCvGUiYf+v4Rb/PJW
         +JHLmDqafllcDO42qdNGJBee6qK4jIRUU44bM/wRzSJneNFBqwvoEcs+qc24tHcv7JCP
         o7fnRAdQ8SL4TXuNo4ne/KbxYpnj0eZHJrJb5o3KpxUThtQucPQV/EWakPsoj3+WEt+V
         xB3nFTlzK2WebNHxFJqPrrOfpn03QWi0ZwcWtKbxFrW84WW3KoVBOW0BN3xefCqkm+bE
         dR/T/9Hrnx95pE0O8Z0WYA4XmCXnrQZc93Kq7BsvHmH7ktDGV9R8QJMXLDIWMQV9kQIk
         iUSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791227428; x=1791832228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sZ3adpDGT261XkCW8nTjunmv9uU6/6OcdwlNEH7xpts=;
        b=r7MurOY9qaX7Ko3JHJ/rmuMnq4fCSsq3Zs1UVa0JTxvWjMet7V0geG0bl3VUyA3s/O
         poH1F4N/ObmMOftUASLPYU/Q0mJ7HJdxSk0GXhhtdUtcYVpoXPFcSuaXCRVdpCz0U06p
         PebWa817y8IylwjvTEkda7cjHDPpzdx7/uM0S/rF/mDesRuR6I6N/XrUoHqJkGugiFRV
         DC8M1vShRN6sD63jsZ6GZRYIsLHoqT13kh9lkU+CYHreZcu2nLN4RGUTshbqUPfuVGDW
         NWOMuCMoU+pa8LwlChSlTv/qPyxuPshcLv0GMYCUSxsfhXcxY+RVq2dnMYcOYnTaF5Ur
         o9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791227428; x=1791832228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sZ3adpDGT261XkCW8nTjunmv9uU6/6OcdwlNEH7xpts=;
        b=lp0U2TR99/HbKMSdrf6hIcpz+lWuXgzty/Elt8CWups/apwjR5di33ezGAaPrI6p6+
         BU5y8YmGt0bWV70zmupXv5P64kAy2IcvHeQ3hBu8ZrImk7MkkSJT1z+DgUuqH1JwqG+G
         Awze/IYflFDyd9MfGRtP3gJ8ZUYRu/C0KzrZsc5y9DmyTSUq08qW2ys3KSOMg5AjMEY7
         1xWDcTCdar3BQfZjT/Lc6erBMWozYVM+ili61+ZfVSNCs0Btj9iZQfOf82kk9zip+w4K
         oHbs6zti6KTWn4+3k8+Z49UuzIMfJNk6n085jkyBlqumN2MaNB60XuKuBY62ZwvSJ3TE
         NVhg==
X-Forwarded-Encrypted: i=1; AKwUvByGi2gpvw1+97JNKnoBZatEG9mt5KEMvxWX2jbw3QQ31Ixi2F2y+Frapss6aTiSOajUd8Y=@vger.kernel.org
X-Gm-Message-State: AFuF++mD/RKTdFdqMDggLN2iPuonVG1Xzmws39EOMxJplvSrXAJTmUrh
	RvQzqvftel5DpQsr5KE6AmYR5VZHVsZOwybQg7PbG7zQht1csPdKEfznU/yybaS0qbFQKSbo086
	K7ugfxmp738gCdVpakeXUC0ulzwRO+LM=
X-Gm-Gg: AYBFou0REYM8gMCKIys5lXo4+Y651niSuYYuZ5GjSDI+vazCxXDQbcGEBn8iJALaBEZ
	8ICjZdjPQST9AvjcE4dIYjUCi295Q6WdquRCktQY2O1KA+YD9m/eodngAu+AlV+P6W8ljYV5nBX
	HraBNAyMm4AyJksrerpBn+7XwhCG12PTY8JH9bIZGKIzG5SrS8wftHEE8p58aN64KXorbxLf3Zm
	QWkwB+U4/U+mePH9gl1reQLoXqNu43cuQeZBcr/gUMZjD4CYWxD+/KoJKJqxriPqeIwweyONZ8b
	jN0w10uJKbkYeRmquLa9SH2ortdNJMrsoY/R+lxm84f0s2sGdkUy+hDsHyUB7zjyU/4aTEc=
X-Received: by 2002:a05:6808:10d2:b0:4b9:e6ab:d088 with SMTP id
 5614622812f47-4f67a717bd1mr9488930b6e.40.1791227428596; Mon, 05 Oct 2026
 12:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005154533.4147685-1-kuniyu@google.com> <20261005154533.4147685-5-kuniyu@google.com>
In-Reply-To: <20261005154533.4147685-5-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 5 Oct 2026 12:10:17 -0700
X-Gm-Features: AclHuK9xBuDSZmtHYBnaJWw-Pci852n_5XSt7zgTnXSPvmgFC3rvtB2s4zNdbNw
Message-ID: <CAMB2axM9iTXqAGkQ3LDB-BRtqs-dVrkoHX1DkXT72KVYjrHQbA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 4/9] bpf: tcp: Guard fast-path
 bpf_tcp_ops_call() under per-socket flag.
To: Kuniyuki Iwashima <kuniyu@google.com>
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

On Mon, Oct 5, 2026 at 8:45=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> bpf_tcp_ops.{parse_hdr,hdr_opt_len} are called for every
> incoming / outgoing skb.
>
> bpf_tcp_ops.rtt is called once per RTT, which is every
> incoming skb in ping-pong workloads like tcp_rr.
>
> Even attaching NULL callbacks in the fast path hurts performance.
>
> Let's guard them (and write_hdr_opt) with the new per-socket flags.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/net/tcp.h     |  3 ++-
>  net/ipv4/tcp_input.c  |  7 +++++++
>  net/ipv4/tcp_output.c | 20 +++++++++++---------
>  3 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index f69091f5e01f..48487135c076 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -3142,7 +3142,8 @@ static inline void tcp_bpf_rtt(struct sock *sk, lon=
g mrtt, u32 srtt)
>  {90
>         if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RTT_CB_FLAG))
>                 tcp_call_bpf_2arg(sk, BPF_SOCK_OPS_RTT_CB, mrtt, srtt);
> -       bpf_tcp_ops_call(rtt, sk, mrtt, srtt);
> +       if (BPF_TCP_OPS_TEST_FLAG(tcp_sk(sk), RTT))
> +               bpf_tcp_ops_call(rtt, sk, mrtt, srtt);

The new per-socket flag load happens before the static-key check
inside bpf_tcp_ops_call(). Thus, even when no bpf_tcp_ops is attached
anywhere, every RTT sample (and other similar places) now touches
tp->bpf_tcp_ops_flags, whereas previously the path stopped at the
disabled static branch.

Can we add something like bpf_tcp_ops_call_flag(op, flag, sk, ...),
with the static-key check first and the flag check before the cgroup
lookup/array scan? This would preserve both the no-attachment fast
path and the flag-clear optimization for attached programs.
