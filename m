Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8951DC198
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790120231; cv=none; b=OhQ1qwnnU9SEeVZcwIpT43DhJbLa1m6S+KIhB/Z7Q83/nb9muNloKt2CkYyyVWJ2VLLYFPWodyOqrBGM5zwr46gyvkrK+vB/CQuPbS4Lu02X5CnsE4WgGC1o9EqqJ/D9DqGO1oVdqTGSTnH0D3mIIEfa5+yqnHIL/O7D29qkIaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790120231; c=relaxed/simple;
	bh=GCvYNmGYHOLHoDUfs4h6AT8Pkm+tjXnv07qdzOUFNzc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=etoibC9jVYMqpaSh9X6MIJvgpE2WTSTHYP5zTGCLxOorik1cXBvHf6ncliho8YKOeKnrztIIG9Arkdf7KXqMycK+JTtZR4gf/ReSgO8RJ/gt5aoq8jqNqCQ/ikUSb31ZOgtBZND83iMwxQrZe+Ixyrs9ZUjAZF5HLb0ufxMJ8Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FU7N6WBW; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FU7N6WBW"
Received: by mail-pz2-f42.google.com with SMTP id d2e1a72fcca58-86e6d007703so260048b3a.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 16:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790120223; x=1790725023; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GCvYNmGYHOLHoDUfs4h6AT8Pkm+tjXnv07qdzOUFNzc=;
        b=FU7N6WBWnzysNnmr0SoGkUTVaGTvTjHHyteLYb2w69hq+YFqm3K3Y5dZ+YLavMTD2D
         ScaMV7ETPz3PCi0kSjF97ItPPH8Mrhla7zCLPIVbDGTjb5ql3wwjXGrcatf9Xi7hq37A
         7GOPQG4GrotuGQiM9ZHz/slnQwF8j0l77A7ywATh5ezS9F59Kjc3gU87AoQmaUrH0UTM
         6DxqcPjt6pIUoiq92RLaMZIMu5J8vxtGOfSjt2mQC5YHqM44b7sdYLrHA43iLWIJPPBf
         J8ANO7FRPCLoWeLQXNlljflmx8fqVApSGf9QM4374IOqtCNQHM2Y5WxHDGlN+/Z6bVr4
         xHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790120223; x=1790725023;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GCvYNmGYHOLHoDUfs4h6AT8Pkm+tjXnv07qdzOUFNzc=;
        b=j3dQ05HR53zxWIic+CCOaTZPKGnCLHPjAPzjlrg++3DhewsyImjUnW8amxcOsd1aiM
         p20oYd2aXkgPs7Q8cYvAcb2t9mg9k1r6HsdgOdaT8weXjjon8ZNmiC9+GJyTfwgfaYXX
         0Di5aql7aQRh32DH59uMWSU3RNJYVRqIHTIZ1ehxZk97m4ECkt4GQBwzat2O5iPBTGrq
         R/9tWm4tPYnMcf86VTtw4va1KDzj8Oxgp58njDgw4d7bqxCAHstTM8c13n7B+hPYD7Gq
         vewbpDUyQkRH1DQfqd8hIZYsKLCchxf0ZHscBfi7NDDsNjbKH1SmVZXEbpIoEVjmcDqK
         mGbw==
X-Forwarded-Encrypted: i=1; AKwUvBxSP2nRLqEM/ituR2zpt9JHMWX1r08TUrgeActHSNS7HEBdQAtYJTTkyNMxZcTc8RlgsJs=@vger.kernel.org
X-Gm-Message-State: AFuF++nvLgFZrAw1BA4JInAZcB+lyzBpT8vim9HgGORWxPr4sMmn0nX4
	xUqnbly/jnkNgTqRcI/T8qPg2uU5dS8cHHH4V4OLsw0UGbINGJ/a4Rn2
X-Gm-Gg: AYBFou2jmlD+TzTuPyzSmgR1RAJDTPLdxfoES7H3TDafMv7jmMonDxEj/1lM/VObGZD
	WyGjSTe5f6sGoBeQebg/6755Ot0W+3XzJROCtpp2LybQVUYRdVB/Ck5kBtCR502y2FtJjK0SnK3
	qmuDkquwglcM8KPHiEsmVbKvmIdWwTqnBxEu3XpbMI4GDzKN93zhXQ7ZYDpzNimVga4mTjuEoUl
	ZI/L9sPYIAwpvT0wBcvvoQOvg1jYgLrARShqFoSBXfbKJ+LXzsILHrmpRvckbjaxpV6/SX3ARPv
	xzRMQ/vcmULc1mtttgPJ5i3p0xW+F2ZbrSSHFS1fymhb0SWL/z670XBaqa8iaiC1QwIizt+0dq9
	j9c8WUkJtb6EfZsqlRELYYGWmYeIggtJR75BWC8KTknCaA+Wj8UHyAzxFAv1rI/ZRrYDCTDluW6
	hrIK9qKYGzT+iX1gUsBp3naSsAGic4yOCsWf+BSn9hn5oBaivguaL6PE307/n3yiInBruEGbRHL
	KYNrlUSZLXPzO2NJ07JvYWYpOiJuushxOZqfkvh4/uIYe7iaGL9rCCDau+KrqrfV3gHUntsCbiw
	Ry4=
X-Received: by 2002:a05:6a20:c904:b0:3dd:a196:9071 with SMTP id adf61e73a8af0-3ddf8305118mr955808637.59.1790120223260;
        Tue, 22 Sep 2026 16:37:03 -0700 (PDT)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f404588sm196230a12.28.2026.09.22.16.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 16:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 23:37:02 +0000
Message-Id: <DLM8NP9S8A4E.1YIS9HRMSR62@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v4 00/20] bpf: Run exception cleanup landing
 pads when bpf_throw() unwinds
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Yonghong Song"
 <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <7e7076ce94e803403bcee003569d4b2ac7bc4e2c.camel@gmail.com>
 <DLLHFJDS6G5L.2B273FIKF9A09@gmail.com>
 <7eba4eb055e15d5c78f463d013fa98bb21d7b494.camel@gmail.com>
 <DLM6BVU1G0V3.29T5BPPZTZ77Z@gmail.com>
 <37e53199dfda608de30a31fc51d22ed2b25d6d2e.camel@gmail.com>
In-Reply-To: <37e53199dfda608de30a31fc51d22ed2b25d6d2e.camel@gmail.com>

On Tue Sep 22, 2026 at 11:08 PM UTC, Eduard Zingerman wrote:
> On Tue, 2026-09-22 at 21:47 +0000, Alexei Starovoitov wrote:
>> On Tue Sep 22, 2026 at 4:27 AM UTC, Eduard Zingerman wrote:
>> >=20
>> > Total size of executable sections for all Meta BPF object files used
>> > for CI veristat testing is 10Mb. Of these there are 30K non-helper
>> > call instructions in total.
>> > So we are talking about increase by 8 * 30K =3D 240K ~ 2.4% worst case=
.
>> > Note that the instruction encoding optimized for size already hearts
>> > us in src/dst registers department: we have no room for virtual
>> > registers, which would have simplified e.g. register allocation task
>> > for ARM64. Point being that optimizing intermediate IR for size is not
>> > always a right target.
>>=20
>> I wasn't talking about increase in bpf ELF size,
>> but the amount of the verifier work necessary to double the number
>> of call insns.
>
> I don't understand what you mean by the amount of the verifier work.
> Traced program paths would remain the same, only the encoding of the
> information about exceptions changes.

Any new insn requires plumbing through out.
imo ld_imm64 encoding FD inline was a mistake.
We should have went with relocations through out.
Much cleaner to extend.
Same philosophy here. Landing pad is a metadata.
It's not a good idea to encode metadata into assembly instruction.
bpf ISA is not a high level IR.

> Do we have a working toolchain somewhere? I can work a few examples.

Please send SCEV upstream asap. This is way more important
then arguing over this bits.

