Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793136494;
	b=QXVPoW6+TSQJlPQG2067fKGo4qzsCFZNfjMriIFW9GqR1u5WMG2b67s6xnbnOCEsJNGI
	 rYa1gU1mMQIpGOckiqI8G3JgeSyukZxhjpwv6I/On5cqt78QmLRsno2QPJyoUJtxLERDk
	 vauUzmu1VMkTKpRw5ZHuL9lHEVfDk8x0iX8kWhOM3MATZpR4VDW6N2edbiXDwweCWiaQN
	 GlNAwkgJFZBEHRo/CKgzjLbmFhojH6hCBsj8/sxY1E95zfY1YyHiA+wLwf3afVIjzru3i
	 GokBRDlEmistOs1t3KeZ+p2IusFahIzwe/Jfr+2wcMXRMvEZYEzBURV1evpy/yTE5dA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136494;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eIFZRU7Tutrt2R68Uk3b6IrEqVRrUu/EsPjcqejrhNc=;
	b=KZJo5ZYe2a/tT1jy5AbD6b2ENmBf+SG0BZ2qSV+f47sfoQ1OGowrZn0KduCbXj412zO5
	 CwPqRlqyPuZf7YEp7flMHn1Rda841OVlt9r/xejBGXcV58k3ssVUVbWNwES8KSwmpue3n
	 fQ/fymUfhoIWeY6o8rLqNwDvZiD9vy0Dw+bDwdJxKtu9LtllWDmZ28B9OgarcRJzOcM7q
	 nCOrcL26P/ycP8PKWW+JcB2HLHxhIjqvQuhh+X2Ve7dPHDCUqz8sS16OPIUemZ8qin5aD
	 wdLcxqfwVw+NeDNTvE9TpGCad8wZ2xwQRx92QftTz46irLAd6A2d2PeL0xcGJDuNvPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z5N3n4qs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B86B606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 21:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B86B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z5N3n4qs
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso179561a12.2
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 14:28:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793136494; cv=none;
        d=google.com; s=arc-20260327;
        b=YBdY5kV6n/whfnwV/cBwnGVSGqqNhMnRI1xlOgNYsZraysWNIdMXRvIeegDPphngqQ
         IdDsu4c3vsyb9EaY41HDDACnd3zDRJ5h40L241pC7eapImDxO5/UfH9t5Z5ST9wcCLBU
         VJEhfqXs3GvStDBd5wsE7+6O3u8lXd9RQPrnJfm+XzSPhw/CiMBUcA4UGP/4hTcxLABM
         k5NnnN+81gT/j+B/1f8KnN2bMYkCE4yvf1SqipnpbxENEg2xjqmDKYQDh9IszCqv0jsH
         MFfE6ktKjuxmKSyLCE6iA7nI9QEjgws+f3WESgcS8d0A6UAIkKqO8czKmY3TwPZflHGQ
         3Cgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eIFZRU7Tutrt2R68Uk3b6IrEqVRrUu/EsPjcqejrhNc=;
        fh=+hGU3jSH5+tWcOdxmR9lpCy6JM3XWCA5gcPnbvW06j0=;
        b=qYcNo42JVGDkc9h10YclR40HxG0yejzPgQrBWtJLtbK8BV3S6EjL4vpwoz11q/q/i/
         uicwsXPgWXTjZtgz8VU4ceBY2cdYdRXChfi4OHSCjy+CNiL2WgJJlx4oQf5XC1rZertu
         T5UIcylzYuDYWJJAqDTLJoSUBm6H5y2BeyDG35akgNoalXpWH8iVairQO/qoMwsSGXYX
         MlrSl7echsOR37H2IVQyf0R4lSNWMGrAac7C3kl4ZAclL2U4WHUYDhPH5H2OiQAnDVrJ
         +jKXrPLw+2KpDtJEaYtePpSKS5mUD1p/qqFdiq7Q4sOAE1VppLUJFOUUjyUQyGD51BlK
         yRPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793136494; x=1793741294; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eIFZRU7Tutrt2R68Uk3b6IrEqVRrUu/EsPjcqejrhNc=;
        b=z5N3n4qsFMf8XD6Kjioy+dJzE2Nt/1u+/nR+nP/Tl5PjJ61ZyN6IJvZwbiNMmMXnd/
         p/N235/ZqqT1rku1SHoAKWsT8nfBL0KTXR9l7lyBrlCfh4ry1koC/B0UM3apyyPdd/81
         f2/drDANzbQM+49Jqrp3OkCDwGvU0r22usiqf83XJXEr4mizyPOK0/9YmbD6dbNqNjtg
         /m628ifpC65ldICVpqC/LAP04DpM4aYrPHPi85b+fuUjU3PuzJ0tXW6JS8VaRXS9+6yy
         ywJabHqt0AGNrPp/AU0fsLiKZ3gGbnC8RApEmS7C8hzk6ISjQIqVDf0wPdU/qlcKJkOn
         OaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793136494; x=1793741294;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eIFZRU7Tutrt2R68Uk3b6IrEqVRrUu/EsPjcqejrhNc=;
        b=BbmW5ZUJi8kb6cW9c8sR9U75yT2XjIaYzj/q4HRaqeUkbdCcb3L1PwFnLXx+ST9HDh
         tCBYeo9XEOfeRbhMqtz2jyv2dXb5yiGf/a8Sk0SV2N6Mzctp29YXUsZHgb2cmDBrzikq
         fTRALs08QGEG4BsTV/JLI3VjWGKkJoDpDTQBpnbGrq1aRhW6XFhheIHKT5Gtxm9GvMYe
         s5HvhkR3AWEUZrVRhExb2OiorB9A3gTGgmjpIlY8HOwQ4RZKGe3WlR5UUJEPBecAzUGy
         /XVO3WmP+VKvVOzcL5aLduPEzZ6FIsbY4HqoOE0vzSJKhSbMdn+AwLqHojH7DjgoHHZN
         6IfQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5T0Q9u4kZezwbz466hf3pLDMsF6FywDZ928V/5ZuycSXQNfjazETDRx+1kmWK34pJsRQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbSB28yDDSUQi6z6FwF7HoRVueqLqwZoM2WwSemYbun/ai4hdc
	23x1oxwf3MkreqphmWUX41zVFddGMOzcGY/pYkVVpuhMwTBH5ixHb0mNsCe6BQAx31yNXMv15jx
	5XSbztwUDx1zajVrxSLy20NhLIHe7WE0=
X-Gm-Gg: AYBFou1VPrDgrq63Ymg1rnKgKJKXx7Rgz9ZVmuGRbhcvHBAw6K5sammt3ytbLGz2Ktg
	JymYLZhcJjx6cBqF+L2MLwDEtfwCbvJl17U1szm0pWDzevIK6fPVTfRu3jnluPeI3apLFqrBpjQ
	2wMqZ48PpAzq9rnASjPlPtySt6GKxbN8zENLFaqFLouO0ZxdsQOBQRRsMOG13Wbj4kB5xGCzIga
	C+Sh4T0lDO2HA+lgFBu1SNXQkR3weISfdThip9fyj3JeeIMz+5gdM3YGg3u1hBUNi1vRV+UQRXE
	ixWJw7lMr2lvcocY6uB+Uf2lk3adg9byRAeuQqEZhg8uH/lkIy3hC3is+B3aHMTsj13aKcwBMO8
	Lav3GRRhbIX5dwAHeSWiT4awasEZD7Qqot8rbU6grzF4yb1WNo2G34ONsGWMpNuywojrrv8xCjv
	X9qfvPLChbLlLyiFDe4nHFXTRVP7gRpT9Mvw==
X-Received: by 2002:a17:90b:3b85:b0:3ac:9259:122c with SMTP id
 98e67ed59e1d1-3ae58241dccmr219464a91.40.1793136493560; Tue, 27 Oct 2026
 14:28:13 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
 <20261026025943.404450-17-alexei.starovoitov@gmail.com> <CAEf4BzYrpYHS1V=VXF0PTRXkXQo6FnseWirR-ka-O9wKTv_GcQ@mail.gmail.com>
 <CAP01T775XCUmtK97tBcWsvOvUsGxR7AKCGqfOCgebf+-_WfhkQ@mail.gmail.com>
 <DMF6PRBIH8GS.3LZZSW3LDCMWQ@gmail.com> <CAP01T75GQRJWXWVNhxxYH6w21QfFVvi_eBV-ob0uEHLmx4DQrg@mail.gmail.com>
 <DMFXPRARP7T8.JRCWN1DA8NWL@gmail.com>
In-Reply-To: <DMFXPRARP7T8.JRCWN1DA8NWL@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Oct 2026 14:28:01 -0700
X-Gm-Features: AclHuK8W4yiM-KNzdiqfOkDcdSa_3Si8RzGbdPJMd0bORCV_LnVckdsjBPQCDYE
Message-ID: <CAEf4BzZdjCVsEC2QzYtCqPRXL-tN_4mOnR4XY8zNoExin+e-rQ@mail.gmail.com>
Subject: Re: [PATCH bpf 16/81] libbpf: Make arena 1 Gbyte when max_entries is
 not set
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 2:22=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 27, 2026 at 02:11 PM Kumar Kartikeya Dwivedi <memxor@gmail.co=
m> wrote:
> >> The reason I didn't go with 4G since 4k pages on x86 need 8Mbyte
> >> of kernel memory for empty arena while 1G needs 2Mbyte, which felt ok-=
ish.
> >
> > I re-read the current code (even with your patches in this set), my
> > understanding is that regardless of max_entries, we always commit 8MB
> > of page tables, no? I don't see anything that uses max_entries to
> > decide that bit. So I think this patch is noop regardless.
>
> ohh. populate_pgtable_except_pte() doesn't look at max_entries :(
> sigh. ok let's do 4G then.
> The only remaining question is whether to do it libbpf or kernel.
> I lean toward libbpf, since it's easier to revisit
> if/when we fix populate_pgtable_except_pte() not to waste memory.

I'd do both. libbpf side for backwards compat and to not care about
kernel version, but kernel should just assume that zero means "no
extra limitations"
