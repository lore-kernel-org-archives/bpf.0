Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA6881724;
	Fri, 22 May 2026 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438931; cv=none; b=S1VBTDm/Vs8zIsWDUhPSZQuo/nAQNaZnSxtRSPuAF2FG+L9Gsxx04gB5snsBgTd90180YUsxVRD4ZmJQMxRnwN4hoIWGhai4vrqzPvayAB7EPkzgFFlXxqFRGjHFNMX/CgkbTaCfKp3qfM9qJVZuOhDOfW7VRSOue67cdgwTB1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438931; c=relaxed/simple;
	bh=LmAISd4ebyhJ9FVXp8zS8g49akLmSgWRCgJZkG99Ad8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=Vea0CFloWwILlKPZrzZihppOpG1KJckdZwkpjIl6Ko0w7FEKM8mJLlMWTPRjm1ZvUhBSwc9Aq5x8FrD8DcOAS+PuJvnglZKuxOKT86d/CnT9QRFIqbjcbnGl1gVdIORGtKQy4ut3WBJYerFl/qbQlG/GI81BUiTfichMdnQ7/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iSWlrrrf; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iSWlrrrf"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EB7DAC2C658;
	Fri, 22 May 2026 08:36:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 605016003C;
	Fri, 22 May 2026 08:35:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 112AF107E8C99;
	Fri, 22 May 2026 10:35:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779438925; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LmAISd4ebyhJ9FVXp8zS8g49akLmSgWRCgJZkG99Ad8=;
	b=iSWlrrrfXmy+lWXhawqaGpYEiJ30wtFRKRUfb8mhYrOMLLPuo/cYatFTxvnUWyKLxGVrBk
	TjYj3La+MguZ1oomkRcsMD29RefU8hX3ZxXrkAsDlLz4L4iUSLfS5PBaZQyi6/X87uM1cu
	4HxyVKGz0QXF9F2qtWmFVFttLnU5C4ExBS+8bZmKaCfotkONfBqKs45dJwmqZmLnoLK0/v
	pj4Ltp67XP6oIuMFumNyToPVAZ333lRCpFZn4zIhgrFGgw/fnbTpkm7gv3CSVkzryxasu5
	I9TcJxHAu44dOq4QXvDTcBGOkK3YvKE4pv1GX8Z+CPY1VrRXMQ8eIIopHiITDg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 May 2026 10:35:20 +0200
Message-Id: <DIP2GAUG3O18.29B8U0FOVEVET@bootlin.com>
Subject: Re: [PATCH bpf-next v2] bpf, docs: add LOAD_ACQUIRE and
 STORE_RELEASE instructions
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan"
 <skhan@linuxfoundation.org>, <ebpf@linuxfoundation.org>, "Bastien
 Curutchet" <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>, <bpf@ietf.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "David Vernet" <void@manifault.com>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260521-bpf-insn-doc-v2-1-8c43c037d599@bootlin.com>
 <iulf7fwwvfrvvspg4e5xyx3tcxe2yonfjllnze2phgfgpynrlh@kodf3fy3l32q>
In-Reply-To: <iulf7fwwvfrvvspg4e5xyx3tcxe2yonfjllnze2phgfgpynrlh@kodf3fy3l32q>
X-Last-TLS-Session-Version: TLSv1.3

Hi David,

On Thu May 21, 2026 at 4:17 AM CEST, David Vernet wrote:
> On Thu, May 21, 2026 at 12:09:11AM +0200, Alexis Lothor=C3=A9 (eBPF Found=
ation) wrote:
>
> Hi Alexis,
>
> Thanks for working on this.
>
>> Commit 880442305a39 ("bpf: Introduce load-acquire and store-release
>> instructions") instroduced the LOAD_ACQUIRE and STORE_RELEASE atomic
>
> introduced
>
>> instructions modifiers. Those are currently not described in the
>> documentation, despite being used in the verifier and the various JIT
>> compilers supporting them.
>>=20
>> Add the missing entries in the instruction set documentation.
>>=20
>> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boo=
tlin.com>
>
> Alexei et al -- if you plan to do a subsequent RFC, it will influence
> how this document needs to be structured. [0] explains the process for
> adding new instructions. To quote:
>
>> Once a conformance group is registered with a set of instructions, no
>> further instructions can be added to that conformance group. A
>> specification should instead create a new conformance group that
>> includes the original conformance group, plus any newly added
>> instructions. Inclusion of the original conformance group is done via
>> the "includes" column of the BPF Instruction Conformance Groups
>> registry, and inclusion of newly added instructions is done via the
>> "groups" column of the BPF Instruction Set registry.
>
> So you would have to create a new conformance group for these new
> atomics -- you can't just add them to the existing one. In general it
> might be easier / advised to snapshot this file to RFC 9669 and create a
> new one for the new instructions to make it easier to tease this stuff
> apart later. If that's something you want, I'm happy to get us started
> with a skeleton file. Again, though, that's only necessary if you plan
> to submit a new document to the IETF WG.
>
> [0]: https://www.rfc-editor.org/rfc/rfc9669.html#name-adding-instructions

I don't know how heavy/long the process is to submit this kind of RFC
update, but your point makes it sound like it makes more sense to just
go directly for the proper way, ie adding the conformance group and then
adding those new ops in there, rather than updating the kernel doc as my
series is proposing, and then later reverting to a proper conformance
group.

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

