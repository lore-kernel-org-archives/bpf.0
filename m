Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D837C4963B6
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025295; cv=pass; b=ki9JV1vMBXNdJAxPwB6wivLNkBHPhPNpNnO2cOrr3MoX7vHkrT2bXIePede+FqYW0dP86PhusP1OPav4SZzC6/TpMsgohL1VEIGrjYKTO/eh29zVVv8wAqmxlE4RKxOhK8RDyeoR+bGrG+l6i3B36LgFkdw25psez35tVuf0mYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025295; c=relaxed/simple;
	bh=uEmI5xWjbsRJZ1CrxCtcNunqVcmNADT/o8HWSzvO/Zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wk03LXqFLrnlxjZkkv9r8M8GuzLirupKaKoBS+KA7fAgqypksKCsNSQSO2mF6PkmOHpkRGulQZY9g4GvPKmyh96nRTuwP/hppCGTnpfqJvI6su1QqXpMeeUJPu8P6v5N8XUhkqgLl30KvtfhZSsw2JCawGDj1/pnotef6axniQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b0rMbT1E; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b0rMbT1E"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-137335bc3caso7160213c88.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 10:14:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781025293; cv=none;
        d=google.com; s=arc-20240605;
        b=hBSmYsGOLpZh7CqcA4/Q8hIVSbZcfXyOMMZX/0nY5VzTMuOe4E1cS/eIYDCIGecmPu
         v4SK/E/S+5N/1Rlzh5DBCsOru5b/cuj8bOvRlfRezYRr0xRpapV8kL900oGUn7MmKqUr
         rdPbIKTF9HG21guTgolAWn0Qnuq90VZ3yr5fHnUAofRsRsAAsvX00IVTEWQbLmD4kYlk
         XSfY/4hQvJxa3Gu04RuiPUcbgVlkGDPl9MP6LJIHaFBveDCejpavgQiN7JLuf8GFKKtR
         0/AUdjXSssV9hUWiMjxRV9YndeYSiW5WXZELK96vG/tdpHW32OU6gltRJwfyTgV3mrco
         1Y/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uEmI5xWjbsRJZ1CrxCtcNunqVcmNADT/o8HWSzvO/Zo=;
        fh=7fzmUMYgFriPOXZVQ1f3exEHrUVSVuADjr1V49OxEfM=;
        b=EzQrEISNO+lvGcDT95AJd0L3e+zfmuhJMlLdJQdBgxazJJWw0h3BrQbfjEN0G4fEXf
         9WJvwKnRstwyJfz7h4dYDOZaXrYJDZsWYlk4wdgAPKjKkIyzlgbMISozr/qbDUAGsfX5
         eYCAn1ege6G0fUJkZUTx5ES2o+zkHp39/K/DgqvpeZAtcaf54icMDKvHEKXtWd4tLuGW
         WKDfY5SVcLaA/TKTff7QEvffEjUbCuSNCw90ileeUk8OVobo7zwq7O3gtAE4owQPMEGx
         TTP1PXhzExBqwRhi9fnLH90WGrfV0VlpkXB4plpdEF472xqEcstrlUDbFo/wlxitY8Ry
         zWEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781025293; x=1781630093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEmI5xWjbsRJZ1CrxCtcNunqVcmNADT/o8HWSzvO/Zo=;
        b=b0rMbT1EYBkozeO7X4b6HKQQyaiZA6zDG9qsJym95lRSvE55qHWJrNvAccj/CtItRe
         NW5ThQElREuHxHtVPEvWDu7o+Mut2fCIduepMhZ64CReUnRxEXoudU+pbzgflpiVvE73
         X0NcHq8fA5mvA7EK9CkKajfhCQsWcEeLDXQRoKRa4rNcwd1/lrclITJFjUS30JiksLPQ
         lbx5VFX01U58iDqpppIKGtKfx8t9w31CaOBsJPP/CnKYhSeHwa9r3Cw7Sh3POhYrT1wh
         s9AAMLyM8tqT4RSuHqMulYfqqKKR+Hi10pVsAowrRJpFTZzC1TZbnyT3Xq+RfQU5cBo7
         mFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781025293; x=1781630093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uEmI5xWjbsRJZ1CrxCtcNunqVcmNADT/o8HWSzvO/Zo=;
        b=ZWtwhfNp7xx6LaxWSnY6V3hGCM/0nNGVXDU8JmouZgNmvT6o+x3GH7TbmoySS3xSzG
         6WtS9baMGJCXvGijuPYhbrWHE++aCJ6eGNyAlHJXnSVBBl+SpA1QBfOzfSiKlFzaEfLF
         fCqp86mtnCWIbmq7PqeawPM85KVxEta36AnD2dDBpXg5dW+/LWtjXnrj7jOsg9gmev/s
         TxCLPEZepTCsgqkVUgNsR5y7SZNBPcm19tWH8hQ/TumeZXqM8iE6voS3tCh5iEs60oAp
         M4eO4smpEvFtvm5u/cKiDkwn8MYV15mKTJxojQqQS3QUwmN3Mk83d2+jCijkzBFfFKj1
         Qf+w==
X-Forwarded-Encrypted: i=1; AFNElJ/zPd+e67gtaV9i0cnQKrvu0VUFlXkdeUPByrOM6VxU97zaUjZUUUN15SKN7MxH+HO9OKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvTQrCRmD2XXD8zgWTBGZKuyQuiuP/F3H49FcceNJEovWwV+vh
	1Z9+m9uNG1Uh9OH9Y0D64lzJBPjN2De8k+eeM0tfjwOn2CZjtWOd2nBsTYf5FZAn5UpSlH/sAaB
	nZrowS794ObE9BXMLbWcm7l0EbkVGYU1OP1V2WqFm
X-Gm-Gg: Acq92OEaFJ15x1isCAVrNxIZl0pE0dArJIxvD6F+h6P0Ae65HRQIsKs3O3vGQNdoN4b
	TmHnHy/mmg5sOYwwxgmxzMUBLlKTGcjH99Ct2bVOaWKxl1hbp3iyPnWF86Rhdi4hKkhC+2cBMId
	S+jL6GahklKp/8pumA3TTNR8xUwx+6lfmGpR+bKZUYoyVp51B3+JC4xBFw7dVZj57Rm+UJvfPzM
	4Eg7Xz9aZRvZxJpaFGzQYJWZvu6r5JrYKi1vxrV9z6UAd5dtRs220QbAwd2zNdWdXMxTRmLfOlf
	iDyJYgjMsQfi9a2QIos+/LowWRmiKrf/17zNjILdqWLR/07C2Z5ix51IFD+bpKBL5t/MR1gfu/g
	YAdAbaAE7qB9yYg7OHraBDB6ITi5j6iUaddvekHUTTksFal+A62Gbr6c8rdEL
X-Received: by 2002:a05:7022:510:b0:136:83f5:c80 with SMTP id
 a92af1059eb24-138066608abmr10538613c88.4.1781025292274; Tue, 09 Jun 2026
 10:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608125846.157004-1-jiayuan.chen@linux.dev>
 <20260608125846.157004-2-jiayuan.chen@linux.dev> <CAAVpQUDZoEVEX1kXok-29dzVHk=ZK_2MkZyZY8kRHCJCfAWVFg@mail.gmail.com>
 <DJ3XPJA746S5.NYKZWY1HBH8O@gmail.com> <CAAVpQUATP7S7OEZw4P_7fp5zmQO-T5jByxAfp0+YsjRENeWscg@mail.gmail.com>
 <CAADnVQKa2Z2HKKZMhyD1HrurQ4LTcCS0Mm0YPxtisGKwVfcxmg@mail.gmail.com>
 <CAAVpQUCJH3iknHSfNwMqvHVc_V09zNDK-YbXbqa-=K159PTqiw@mail.gmail.com>
 <DJ40JYME18U1.3RA3TUXB3MH3M@gmail.com> <CAAVpQUC1Ot9vr09gNoe+vxgLoqU8Wwn2DV+CQZYYpAJUATJiWg@mail.gmail.com>
 <f0468cb2-1b52-4216-9592-ceb204f6ea41@linux.dev>
In-Reply-To: <f0468cb2-1b52-4216-9592-ceb204f6ea41@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 9 Jun 2026 10:14:39 -0700
X-Gm-Features: AVVi8CfkVjeAeUk17kjk2s6wRYeo3MTRMX2aePnQQmjsoDb5ybrS3XbXLwOcaFw
Message-ID: <CAAVpQUC=AJvJS1yppw+aAVpmRhB6GganrUKMsKSo7WUKNkZHfA@mail.gmail.com>
Subject: Re: [PATCH bpf v8 1/2] net: Validate protocol in skb_steal_sock() for
 BPF-assigned sockets
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	bpf <bpf@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Joe Stringer <joe@wand.net.nz>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 6:55=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
>
> On 6/9/26 6:34 AM, Kuniyuki Iwashima wrote:
> > On Mon, Jun 8, 2026 at 3:16=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >> On Mon Jun 8, 2026 at 2:35 PM PDT, Kuniyuki Iwashima wrote:
> >>>> btw is earlier sashiko TOCTOU concern real?
> >>> Yes, the selftest in patch 2 should reproduce null-ptr-deref.
> >>> (I tested one in a prior version)
> >>>
> >>>
> >>>> iph->protocol =3D IPPROTO_TCP;
> >>>> bpf_sk_assign_tcp_reqsk(udp_skb, tcp_sk);
> >>>> iph->protocol =3D IPPROTO_UDP;
> >>>>
> >>>> as far as I can tell past bpf_sk_assign_tcp_reqsk()
> >>>> the networking stack only looks at skb->protocol,
> >>>> so modifying iph->protocol will only mess up
> >>>> things on the wire (if this packet goes out).
> >>> ip_rcv_finish_core() uses iph->protocol for early demux
> >>> and ip_local_deliver_finish() also uses it for demux.
> >> ok. Another idea... we can keep the checks on bpf side and
> >> teach the verifier to invalidate packet pointers at bpf_sk_assign_tcp_=
reqsk()
> >> and introduce new concept of "readonly skb".
> >> So after invalidation the reloaded sbk->data will be read only.
> > Yes, this is exactly what I had in mind in the other thread :)
> >
> > ---8<---
> > On top of L4 validation in bpf_sk_assign() and bpf_sk_assign_tcp_reqsk(=
),
> > can't we mark such an skb immutable after the helpers and catch
> > subsequent writes to skb->data on the verifier ?
> > ---8<---
> >
> >
> >> There is no such thing today. The verifier only understands PTR_TO_PAC=
KET
> >> as read/write. So it's not easy, but probably good thing to have
> >> for this and other cases where bpf prog shouldn't touch the packet
> >> once it called some kfunc/helper.
> > This would be useful and we could (re)move some validations from
> > the fast path.
>
>
> Hi Kuniyuki and Alexei,
>
>
> Thanks both for the discussion, it makes sense to me.
>
> I'll go back to fixing this in the helper itself, like the previous
> version did.

I think even the previous version is the same type of change
for intentional misuse.

Both bpf_sk_assign() and bpf_sk_assign_tcp_reqsk() assumes
sk_lookup() in advance, meaning the bpf must have dissected
skb, and bpf_sk_assign() relies on it and has no protocol check.


>
>
> Then, as a longer-term and more general solution, I'll try look into
> marking the
> skb as immutable after these helpers so the verifier can reject any
> later writes
> to the packet.
>
