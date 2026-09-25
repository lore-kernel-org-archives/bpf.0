Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C98D1A83F9
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790296802; cv=pass; b=Cw3wFpFiSt4ftKHjF2kA0fyBDpYx5rjtKkVcxfXB1VaZwAjgyNII7FmYJyWvXjTPFqRfDRjYIlg23jrBSB1mnuN0IB6HrRMnh01l0LIMReku2yvDBV5i0lnenfsd8oT9jQe/WwWOfR/gDhfD9jTugm/ZEXnlq1gb8JeSRt/Yr+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790296802; c=relaxed/simple;
	bh=ftxDqU9XlFwz6e2iit+lB9vVqjsOV4WsGNNi9lM6TeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bm9uK45vHVnrNRjUcq2KB5osMl3ah68Ie/kSeAMAeRsOGFoj5aSTto7U5qE7u+bsKb93Nw2My7VoXbV85Dm/zFJLYJC420QU9r1eK9N7D5EuYpfiLExx/CJWV6dV/el5yMVqbHFpD+qzSsz8HAdJIkUV3xr4zyvTRUGGNSFEXQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B8j0cCxI; arc=pass smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B8j0cCxI"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144f089b1e3so362004c88.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:40:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790296801; cv=none;
        d=google.com; s=arc-20260327;
        b=lrJ0PqHSk/RFgEGC7x5gLUaPa1D71qBdyPwKWCMfCWXRdOPmiImGY04T2TSWyhDkyF
         8Ni35CiQHlubsXpYJjfsE7fsT5ihU6G1RLp+V9MTTxYy67h0z8OTRp7rmlBvsDGDJgA4
         QplLUCrqgu7ROy6HNbaKiCSAGu75jpuvIvnXKgR3e7Tqa2sUkZbWkEokPrbCX365560O
         uXoQsacegvpop4U49kX7o6+k1GPBpnxLawqSP06KmTV1OGRJPBWM9VWc/lzzoSC7BKVD
         uC6RPI8BtDDhBl0uiY0jxT7zo2sVaInOIyN5TqdWjEOnILE7xdcVqle2cURW56+v3ss6
         NSAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ifhmGNF90wvvVdVpuw9Aasse7UJ+lz8YulJtQDHPaE=;
        fh=kzttu3BlO5bcALGxBlQqQC2fj75yzrbtYmXaeN24zPk=;
        b=Hj9MrGXkxkWbdM3b8IvGdUgTws7W27lOoZbMnbsAuDukinlqMYn1VqrebIjvFVXLDt
         Xfm7Nc8TxOZMUvXx2ktbsDwjKzCgbMtG+VPBRSGSP1zfDUWgS3lksJoqT5a3Gyrjo24n
         k86yFvoBCdkMFdKRB/32n05wbkDzL45va3KoIMGrDMrLafFNF9jxgNwU+v9Ryod50L91
         6FQm2hSfhYql0aFdMlIrgJ+IfTzJ8O7BqIilcOasFOrcQ51uuUVfoef48WT96G/XaGoF
         LFT/mOmZ0c1d0sX/s7iTpACpFIVxotHIvaCDUQjYuWDgJCvWjYuL42LKVqBmL7yQX7qw
         2Dkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790296801; x=1790901601; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6ifhmGNF90wvvVdVpuw9Aasse7UJ+lz8YulJtQDHPaE=;
        b=B8j0cCxIE2i/w8HAo3m/0JyYMsOT24Evw/agNLF7vomY6OKN9pIo/qGjqovgNP7S1s
         usVcLDiqxs/rIZ3jEBCrf2KHA6DIXfxWztIMXQcedVfu+bUel3VTjArGKKorq4ZovLC+
         rRA7tmUVBn54GyKFcbF2gnlKUno0egjXoqMDdqiE6NSiIgSeFg8top7S0cVwMmx5EnUw
         JFh5D3wpaPtLOUvM+LUrbfTy1sYHO9gL6e2Y0B8PCc5VmfDfsRnvo09yh7ZuTlBowXg0
         lW0gu6T3WHnwIBcvrkP+IXMp6CIvZ4mv49UGUM3DAo9gzjivhA9CJMiZ0jfyDeTLmeX7
         raRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790296801; x=1790901601;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ifhmGNF90wvvVdVpuw9Aasse7UJ+lz8YulJtQDHPaE=;
        b=D6hM4bQSR3P5Vxj9d90MVX3yabKQ66kHZ358/RT+95S5ATNPcNTIpVtsD/U1fCS+xt
         yPeak0Bab6Jtba18H2/Cj8nQ88/yAASKWnDyL14ay0vljcq0hupT4lRggouDfO3EdeyA
         oELtAW19sfYQB83Wo4gL6e9SHubGPs0wLL/jOdefzYh4OHm62SROiYwwNDdtuifrhnyz
         yi6wVFFxf42MFEsW6ipLZ4g65WjvIv0WpY0uWdJ+zVxC0jM3y07F1BExvO230xeBXBQ6
         Hp2nCM7FT6DDiX/HdSfF/qBFBQBJ64OATdZKM53DNHVCEQDGnbwuHU/NtYrLDlLG5NVL
         LcDg==
X-Forwarded-Encrypted: i=1; AKwUvByyY+ulaxLqYAIuOJwBZPrnFN5hwGIWQKfiktiFp3jx8+OrbY+pweWgKu8J72aZLAkDbCU=@vger.kernel.org
X-Gm-Message-State: AFuF++nFIfpNK4lpRYY8xnlHfjLgYCyOPJVOblE8RtkT5IOZl+Gqhclh
	WwlOLN7fgACdBaNvAKJqw/N/4pYbKOL0sl3ub/GWgHiUjYsC62ELadvbpyaVxtxoqK8Gq/FfF23
	piwWm6I5RAtcPcAv/j8Tklph5z/cq1vWmmUTR6FxT
X-Gm-Gg: AYBFou3M/eFhmjAoFWZsEgTv8xxUhA5iTn360oO3OY9XTJsYCmGvFWwOCVcvYa7xDCj
	Ebdy0SeUaj3bxGcjOkj8sOLFeKuEmZS7NoY/hG6qCOvmc40uhR3NHLaLl//8s6dlHSC/g6wJAFW
	LOkp8cc27V0fdjoTp88nP1NovA90lDOHBtd9dfNZPlKHkLZwBhKvsfDFIz4cb3vAGnuLuKnnacs
	DoQfYPUJBEidI1gqqrYUuXDUSjuEZkaIi6t6deHuNnWdZ/wCyY2ynMyYX9PTtt15vKXiZUsI539
	k9hMdiHJkWpEb3wsOj75dFRczDgErqEkxgiLHqqdePeSzhF7g9otoTIeTQNQ9F0uEQMTHaU9GWB
	KRNWROT0UTXT3mQPcL0tLjqBDKxtiIoJkKBh715ITiBQ+wj4U6BLIEd/eobOQaC6iQbSZa/aZxm
	bhTPxa0B0kqSuemX+Mg0HvKg==
X-Received: by 2002:a05:7022:1e03:b0:144:f85a:a188 with SMTP id
 a92af1059eb24-14503f2d6ecmr5121732c88.2.1790296799688; Thu, 24 Sep 2026
 17:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923213719.224838-1-kuniyu@google.com> <20260923213719.224838-4-kuniyu@google.com>
 <DLNYI40PF2Q3.1KYC8MHZU2VJ@gmail.com>
In-Reply-To: <DLNYI40PF2Q3.1KYC8MHZU2VJ@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 24 Sep 2026 17:39:47 -0700
X-Gm-Features: AclHuK_Qwt2GMVGY4hmLeMVx26fLamZTuVjIH8k3C8fGyjWtdVLuVOM-Awl3giY
Message-ID: <CAAVpQUBGSahLGEqGQCD2_0Ro2e-=59W7mhVyxOnoFU==LAK9tw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/8] bpf: tcp: Introduce bpf_tcp_ops.{enqueue,dequeue}_rcvq().
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 5:04=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Sep 23, 2026 at 09:35 PM Kuniyuki Iwashima <kuniyu@google.com> wr=
ote:
> > +     /* Call bpf when the TCP stack enqueues/dequeues payload
> > +      * to/from sk->sk_receive_queue.
> > +      *
> > +      * Only bpf_tcp_ops is supported.
> > +      *
> > +      * It can be used to adjust sk->sk_rcvlowat and suppress
> > +      * unnecessary wakeups before sufficient data is available.
> > +      */
> > +     BPF_SOCK_OPS_RCVQ_CB_FLAG =3D (1<<7),
> >  /* Mask of all currently supported cb flags */
> > -     BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0x7F,
> > +     BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0xFF,
>
> can we drop the flag ?
> hdr_opt_len() is called for every tx skb without per-socket opt-in.

Oh, I assumed bpf_tcp_ops keeps the same behaviour.

We have a bpf prog to turn the hook on (from cgroup_skb/ingress),
only when ingress rate exceeds the allocated capacity, to signal that
via a custom TCP option and turn the hook off from the hook itself.
(and I planned to post another patch for that)

Anyway, is it because calling bpf prog is not very expensive
or per-prog switch is preferable to per-socket flag ?


> The prog in patch 8 already returns when the socket has no
> sk_storage.

Yes, but this is only for bpf verifier.

>
> The flag is one bit per socket shared by all bpf_tcp_ops in the
> cgroup hierarchy. When one prog clears it the others stop getting
> enqueue_rcvq().

Just an idea, would it make sense to add a kfunc to move bpf_tcp_ops
callback to a shadow pointer by allocating sizeof(bpf_tcp_ops) * 2 ?


>
> Then sk_is_mptcp() check in the kfunc is enough and there is no need
> to touch bpf_sock_ops_cb_flags_set() and TCP_BPF_SOCK_OPS_CB_FLAGS.

It also works, but I wanted to move the dead check to the
control path instead of checking for every rx skb / recvmsg().

and now I think we should move bpf_sock_ops_cb_flags to
a better place (maybe tcp_sock_read_txrx) in tcp_sock.
