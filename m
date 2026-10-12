Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CE0306B1B
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791032; cv=none; b=b/XTSvOp3Ew5NMo8RQI3YdJILmBfa3SCY5S/aI2wNYmF5cMEtNrftNGJLBrgIfiedkyC0oP7aacwfCFmUhpuxOP3UvUIPjXNgM694y9q2ah1C9bzkjVeUe1aY6RfdoeqPkXCTdxBOrOed1042vwAMBUHYM8oYTkXQqTMckhFWsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791032; c=relaxed/simple;
	bh=s4EuUlD807bnxeScR9jHr47Ctn6TStTookbXVJY346s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M1HwdaZe6ve75DDavKS1IL2fJ4qATnGjEIiccODN3QacX2TBqVoen1Ss0j6B68h8icD8vc8JoAU8EZbH9UDzO2riJvVU9plNJTMBm8QmikBT55IdIgMacAnzIbqpaZZRoDnITBq8KabbtoOrGvgSEgxdjx2jxiCr5bWnzYIoR7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWBiLJS4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZzZ6yYnk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWBiLJS4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzZ6yYnk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791791030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s4EuUlD807bnxeScR9jHr47Ctn6TStTookbXVJY346s=;
	b=MWBiLJS42G1ZmLKEpw+9EoyJOaRCG9vP6VqIN3A7WbMmUUCl0mY7Av/Av/tLlEliYbVFMR
	k8ay1MyZiqCJRl7alX2T5cXAQxbuW9ZQ6r3S7YHyHbOfXGve3j8wALjtyVrmWt3sAXBVOj
	6cResPpx6E2nnbVyd+XW/T7RpDsPhjs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-HT7SSwCXNo2ipWFcjS2J-g-1; Mon, 12 Oct 2026 07:43:43 +0000
X-MC-Unique: HT7SSwCXNo2ipWFcjS2J-g-1
X-Mimecast-MFC-AGG-ID: HT7SSwCXNo2ipWFcjS2J-g_1791791022
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a17e77c5b1so12311515e9.1
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 00:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791791022; x=1792395822; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s4EuUlD807bnxeScR9jHr47Ctn6TStTookbXVJY346s=;
        b=ZzZ6yYnkf89PlxLAuq28YvUirFjtjdY7n/p0cQo/ZmtZJL5tbGW8t2qnaJt1cN1adv
         uT1+UQYFvdmoBNb/JDn9kbrvT+zLLSeTLAKGjkqo54B+4hMZlN+9l4cCJF+FsXhU2uQf
         PshGemPUQYPmpybiygdJkcifbZOz3ulERWJAwiypU6kKA8PlYz8K68kkwYD5FnElSCPE
         gPGjqBjdmGGIUPUyKgraCOnsHEqyU3W+22w0GqGFMkPbuf1VJA/TgUqRNa+iNQUBsSj5
         kL9289jcapErxAVoIkMFqDGqGWU37BJjdbm+UNHhGslfiobmU7mNOPILvX/W6BRHHizp
         vAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791791022; x=1792395822;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s4EuUlD807bnxeScR9jHr47Ctn6TStTookbXVJY346s=;
        b=KSYb56t3r6JYN9qaaONUzRGimttT+MB5P1w9Agmb8bOwGZrG2DkLq0LUT+TjnxcV4C
         qgzPgf4JcgRBu563aKhLIV64ZDb96u/Jue2gXH2yV2LV+eM9vKyDbV5wC6tWfpdc1SEo
         AypSLNK6wxzQ1PHJDNBEhB7WgfpyXjjD2Se0J5lAQDyN613dPwvIIlKtzPBbInZgG/nQ
         4MHHs6LIIXe8nrsu5UrSSRcObwXtdKVltCIpGofVweXmwQKzvAqXgYHbnWyh06+40jif
         ZsYEa+1eOj0QTBL1I2xn4+fZlt0hEtI9v7ODBXPEbYKTswZK6306ScCart2dQfqFEDQr
         o38g==
X-Forwarded-Encrypted: i=1; AKwUvBxpmv4H+7ZYfSipTh3hOKWBg30hNybBBnSXBwpix88/j5rFJcLh1Vlzdg8TKV6mXNEz3Ac=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCKjGH7mF/FT4NYB1nt1Oj6kwcGqCgnZcmy9h1qIxEgJ7EnBFp
	ZD1gYc1q/O2s1HCwLYPBsmIPBNid3bvPlsoYj8b87vaguFQpLJUPoUEoZUm5O1Nk4HXXvPONKVA
	9q7kcJza9CQHHs2S3cUh+j0SgWPBHWwmae8z9qInH/FAMjJGtbXlnWw==
X-Gm-Gg: AYBFou0ESReL00V3WJhTrnVEMoZ6IiWMxbny2j6XMSCvvJziSEHaFpHIVZjMvtDdzOD
	MsgimaxK7vrQlQLvFhQmUv3os1FPlkAxeSii0mS1V0RiN6zL2raZZWm1XdCvHydWYaJ/KFNX7+t
	log7Wh5cAqPiPDL7AvXrlOKnM27Rtem++D7xdRDJ+WmmduLo40juxzRWJl8KV0w0zio+06CwyQS
	c3gN1K2kSNp3Dw1py2yAVSX8zNFcVB2hY6eBdARkYNn8TxOmV49nUdnS7DlEwLlGTL/tdNQjShu
	kH7BIgRzOTtS6f7rlJqiquPNZiJEMXbK8djqqA/iDs/dmZr3rnzqsw5GT0Hwy0pB9RICdQie7hO
	HwWO0Rk/mmMNE5rhehpXMmoGsEswg
X-Received: by 2002:a05:600c:871b:b0:4a1:a2f3:e6f7 with SMTP id 5b1f17b1804b1-4a1a2f3e8a9mr14219085e9.29.1791791021707;
        Mon, 12 Oct 2026 00:43:41 -0700 (PDT)
X-Received: by 2002:a05:600c:871b:b0:4a1:a2f3:e6f7 with SMTP id 5b1f17b1804b1-4a1a2f3e8a9mr14218605e9.29.1791791021306;
        Mon, 12 Oct 2026 00:43:41 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a199e5db12sm147510625e9.2.2026.10.12.00.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 00:43:40 -0700 (PDT)
Message-ID: <daeb0025bab5302505fe64379c0882f3b20b4c74.camel@redhat.com>
Subject: Re: [PATCH v2 09/15] tools/rv: Copy stripped bpf_atomic.h from
 libarena
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>, Wen Yang <wen.yang@linux.dev>, Tobias
 Schaffner	 <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Date: Mon, 12 Oct 2026 09:43:38 +0200
In-Reply-To: <20261010204327.0656cde7@226.227.38.69.naturalwireless.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
		<20261001152042.124445-10-gmonaco@redhat.com>	<87ld89wtrx.fsf@yellow.woof>
		<4F009BB7-58C2-4AB1-8FEF-61FA4B5281A2@redhat.com>
		<87fqygl9we.fsf@yellow.woof>
		<76753c2dd66792ec6eb94d00741e61366df426cb.camel@redhat.com>
	 <20261010204327.0656cde7@226.227.38.69.naturalwireless.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Steve,

On Sat, 2026-10-10 at 20:43 -0400, Steven Rostedt wrote:
>=20
> Please keep both until you know the BPF side can do everything you need.

I agree. Also, complex monitors like timed automata won't be as easy to mig=
rate.

>=20
> On Fri, 09 Oct 2026 12:09:42 +0200
> Gabriele Monaco <gmonaco@redhat.com> wrote:
>=20
> > There's a common belief considering BPF a prototyping playground, where
> > "real"
> > things should eventually end up in the kernel.
> > Now, I don't agree with it (look at the many sched_ext policies used in
> > production), but I'd want to assess if dropping kernel support could dr=
ive
> > users away (e.g. industry/automotive which keeps popping out) and under=
stand
> > the various not purely technical reasons.
>=20
> Where do you plan on storing the repository of BPF programs?

That's something I would like to refine better. But I'm planning to keep
"official" monitors in-tree (tools/rv) and encourage to upstream monitors
nonetheless.

We could come up with a separate repository for "community" monitors, with
perhaps a lower bar compared to the ones in-tree. That'd hopefully encourag=
e
collaboration where possible.

> One issue I have with sched_ext is that it did exactly what many people
> were worried about. There's a lot of schedulers out there without much
> collaboration. It's the "copy one close to what I want and tweak it".
> When I left Google, I heard there was 20 or so sched_ext schedulers
> doing various things for various projects.
>=20
> One of my main motivations for scheduler governors.

Yeah that's a good point, though I'm not quite sure how to prevent that.
People could do mostly the same using kernel modules as well, however.

At the moment I still didn't figure out how to build monitors out-of-tree, =
that
might encourage a bit more working in-tree.

The difference with sched_ext here is that this BPF implementation requires
little to none kernel support. For all we know, people out there might alre=
ady
be running something like RV monitors implemented in BPF or whatever else.

Currently most of the logic is supposed to go to the shared headers, but
monitors can implement some custom logic too (you already need to touch the=
 C
file anyway). I'd like to reduce reliance on custom logic as much as possib=
le,
that was already brought up by a couple of people. This way, hopefully, peo=
ple
would rely more on the "library" and share/request any improvement.

But again, I don't have real answers to that, and I'm open to discuss more
sensible solutions.

Thanks,
Gabriele

