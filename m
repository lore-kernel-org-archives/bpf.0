Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8372E8DEC
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 20:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529833; cv=none; b=PM1Fw3DaLGUertG4WPl/6nqr1Dfs5HfV14bm3SHzvhUS9VBhgQKMR628NS0jUomBqUc/S2J7imcr3lBnpQm6V5nI9odTPrQQM1Qx3qWG3I3cYHxJu3zHQ/o8vqAbxK+TqpCxElkSiNO5O7SlxoiJ6K7WXdCIvstSXc4G8S0M6Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529833; c=relaxed/simple;
	bh=uvoT7KywqNP+V02uvCecmLtPoPNcDrG6DOvQJQ+l9Qk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RsS2vHWP7IX+N3+MjmIYT7HeTrCmRAkvvHs8PFxFm9HLtYMoCVNsHjFEvJ1R4nTi38ebaWoNSWu84XFDyvAQ0foYAqGxAUX1DRw/XG7fG1slvz08ZzcCBORqlPUktgyUFAVvQ8a264eXKzrbUnpeO4fX3+QTa0Rk0ei1Hu1H+y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkYZa5BM; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkYZa5BM"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8379e010b01so1945985b3a.1
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 13:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778529831; x=1779134631; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KDiRP/+kkoH0Z40Pl5IRdbDYWccpFBsqt+YMfO8tx44=;
        b=QkYZa5BMHdzfqgZzfaXDA7socdDszASub78vEdRE5hbmwdOg3y9E9mbQMXDDMBPWq6
         vZOa2LRcjAkiedKkcyi3Sj30yk3Jpmecjs4oq1TEEVMXCFlvx+Sg2M1nCcWmcjDvDM81
         VHh1y8hxdEx9AW2/OvUux3qXiu+CRfOfGlGlKuiTfk6yBX1QUpiZTS13eMQBidLCXuYg
         Zj1N9JjWf5iyc2Yfllwr8NPSobbxk9JrzXeUja5Mg8Dpr9swHLdvOxEQdKZr+wGJQ+2O
         IWy4ijkStx5H3RMikQf1auQddB00K/YnvpDgxyKvOiV41BsfZp1qioiah/o1mhT1lnx8
         wX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529831; x=1779134631;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KDiRP/+kkoH0Z40Pl5IRdbDYWccpFBsqt+YMfO8tx44=;
        b=C4blsnPqlH30ODM0ylkJBpkT0IenLDO6VraSGj1+ii9AE1p7cJP61VChyC1AxL6mq0
         qiyxp42Pi52KE3Bm6fX9egyrn8IyJuF2cwTG+cPBXEReAoPshokoelHna8TfNfVc6RSS
         JJVy/3WMSIXWmawUZWigZVChK4rBl0+JFLfIQNcWvQjSE9d87psIKzV5pVvjX7J35BSH
         VGZYL7j20UgVxNyg3I3yFjPL7jP7w2wilKtU7cCaNF9iNTFLK8+eVWjacfvQUm76Wwp+
         LrJqIak8fGqt+7TdeYJCWihVtBTSKuaioOGh5CJSbDfwdDHABOSxYOE0NGd07HScUEl7
         GeLA==
X-Forwarded-Encrypted: i=1; AFNElJ+vyU2jftjH64xeQlBnUDvC/RNUYb6WuA8M37dbxcCG6+t8cDhy2kZcVnvV0x6PUYIlwnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAj06J8XI/B451hvYutZ2pUeVvv4AEOxH+4MqKJoFyMjMrIo9d
	cS+/mcWvvunxh8CA23/iADgCd01HnStCO2CaRoUJ+PfcOy3kcySWkmyN
X-Gm-Gg: Acq92OGfOlJXXYRWi3sTDbtgkwJ+UX0pC4+nBEzChtHts75buWfNe8qCoUPWs+oGSab
	R4CHBKLGajsj0t632A54HFytjx7phso/gPjcxZz8HJxP4PrYYXNeesW6RSm+LuocDoTfWA4Otrv
	5ymhGPwz0kSVbJOYHBCKbZFY8d2/p5aPDi5oA7Tg5O82yhqo42K7TNQCoTWGn1fPBJ+Sc5CMWA0
	I17t8QPoQD7PppBIh8iwLzdWxNzxX9hV32nBZCYcnCllDf5ya3TcaSovfluVmh39DgxoGB78pFP
	GUogKog5IYQ2GdwZ0Hn/CdLm+VN7+m2X3y9MGhAEVXtGLWiJTPC7FDQzYk2safJ5lbpvS6l7S9s
	4opEQDB8BtR4LhHwa/YQwqaGIMPosED+UYy6D4SDsKRDT8QC1F20eKwXvqveqRNDdDzuGB/Lac4
	lrCph49NrSvwo6YHUopdhPSre2ABrLTAdDaXwcQ8BP/FVwA5OBr3id
X-Received: by 2002:a05:6a00:12c7:b0:835:3f51:72f8 with SMTP id d2e1a72fcca58-83a5bae01d5mr25059102b3a.18.1778529831417;
        Mon, 11 May 2026 13:03:51 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965646254sm21998536b3a.10.2026.05.11.13.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 13:03:50 -0700 (PDT)
Message-ID: <966863ca988cff74c06702c26d318e8d6e2327f9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 10/14] bpf: change logging scheme for live
 stack analysis
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, 	kernel-team@fb.com, yonghong.song@linux.dev
Date: Mon, 11 May 2026 13:03:17 -0700
In-Reply-To: <CAP01T76nb17=8eugBG9tPgTY5p-_G4Y9=cq16eiCkFdVujChKw@mail.gmail.com>
References: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
	 <20260410-patch-set-v4-10-5d4eecb343db@gmail.com>
	 <af0gXEqD3FPFYZDj@mail.gmail.com>
	 <639f1b0f97330c98668c00244c0a7bae19e30e3c.camel@gmail.com>
	 <agIVpXzC_bXgJ44N@mail.gmail.com>
	 <b063ec89e7ab548d93a892c44ede2824040ebf10.camel@gmail.com>
	 <CAP01T76nb17=8eugBG9tPgTY5p-_G4Y9=cq16eiCkFdVujChKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-05-11 at 21:20 +0200, Kumar Kartikeya Dwivedi wrote:
> On Mon, 11 May 2026 at 20:54, Eduard Zingerman <eddyz87@gmail.com> wrote:
> >=20
> > On Mon, 2026-05-11 at 19:45 +0200, Paul Chaignon wrote:
> >=20
> > [...]
> >=20
> > > > > I'm wondering if maybe there are other opportunities to reduce
> > > > > verbosity here (besides [1]). Maybe we don't need to print the
> > > > > fixed-point iterations if we're already printing the results? Or =
maybe
> > > > > we could put the more detailed liveness-related logs behind
> > > > > BPF_LOG_LEVEL3 or BPF_LOG_LIVENESS?
> > > >=20
> > > > Had this been a normal compiler or jit engine, I'd vote for
> > > > BPF_LOG_LIVENESS log channel, I'm not sure what our stance regardin=
g
> > > > user visible ABI here.
> > >=20
> > > IIUC, it was only released in an RC and the logs themselves are not
> > > really part of the ABI, no? Or is there some other concern I'm missin=
g?
> >=20
> > I mean the valid flag values themselves. I hope log is not an ABI,
> > given the number of times we changed it. If BPF_LOG_LEVEL2 is considere=
d
> > a kernel development only thing, then splitting it into multiple channe=
ls
> > would actually help the developer, imo.
> >=20
> > > > Regarding BPF_LOG_LEVEL3, I think that the original idea behind
> > > > BPF_LOG_LEVEL2 is that it would serve as a "debug log" that regular
> > > > users won't need to consume. What is the motivation behind collecti=
ng
> > > > level 2 log on your CI? Is it to infer clues regarding programs
> > > > hitting 1M instructions limit?
> > >=20
> > > At the moment, we collect this (1) in case of failures due to the 1M
> > > limit and (2) to compute the maximum combined stack depth using the
> > > per-subprog stack depths and the callgraph. (1) is not expected to be
> > > happening often and isn't much of an issue. For (2), I'm planning to
> > > send a patch to have the verifier report the max stack depth itself.
> > >=20
> > > Overall, this isn't an issue for us. We're just using a bit more memo=
ry
> > > and disk space. I just though the sudden increase was unexpected and
> > > thought I'd have a look :)
> >=20
> > For 1M instructions, I have the code to identify loop headers, so
> > error reporting here can be changed as follows:
> > - count the number of times each loop header is visited
> > - when 1M instructions limit is hit, identify the "hottest" loop
> > - print info about the loop
> > - if loop is supposed to converge (e.g. it is an iterator based loop)
> >   print out the samples from states cache, noting which registers
> >   differ between samples.
> >=20
> > Alongside your future patch to printout stack depth this should make
> > log level 3 not needed for now, I think.
> >=20
> > Kartikeya, do we plan to do something about 1M reporting or are we now
> > pivoting towards rust2bpf vision?
>=20
> The main thing I'm changing is more context around an error (by
> relating it to the source), categorization, and mitigation
> information. For now all of this will just be appended to the existing
> logs at the end, once I share something we can discuss specifics.
>=20
> I do think convergence failures can use more summarized output, right
> now, the huge volume of information makes it difficult for most users
> to figure out why the loop fails to converge. If you have something
> lying around for that, you should go ahead and share it. I was
> wondering if we could avoid emitting a huge volume of info upfront by
> identifying cases of failed loop convergence, instead of logging a lot
> by default and then pruning it later only when the 1M limit is hit.

I don't have anything specifically for error reporting, just the code
to detect the loop structure. But I think that 1M error summarization
should be easy to bolt on top of it. And this is an avenue to start
landing scev related things gradually. I'll take a look.

> Rust-BPF stuff is orthogonal; we will have and still need useful
> verification errors from the in-kernel verifier with or without the
> Rust frontend. It is just likely a lot of the errors will be caught
> ahead of time by encoding a lot of invariants into the Rust type
> system, but the specifics of the solutions there are too speculative
> right now.

The reason I am asking is that Alexei wanted to eventually forgo 1M
instructions limit completely.
