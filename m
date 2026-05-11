Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDB928A3F8
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778525695; cv=none; b=Zz+aOwr9ZFenvHoS5fWX8yBJ+z3D9XSpCO7xPC0OKtdB7zVD7c3zXLullyG776CMA8J4Dq7cyc1EJ1Q/hUFzIxKyzhTwkZCRk9D2/56wk+GI7HHg+wP9wNnhceczTksKs0yEae7R3YymaZBgp/qJ+XWRXdVjbxK/9MQBQjg7dws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778525695; c=relaxed/simple;
	bh=OvbmJAG2oCrLHNE9Oqn7qwrKdk2TZrcwYl20xLorLx4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gzm27p06CWXjnyqnPEzTOh+1OxqwFcXXDxTtAhOhMPpiAC0JXDLHPrwJU+jkz9E1OLIWPsjPTt+0lLH3gCohRhafFlmMHJh1CEr0HU6Aq1A5v8D95SCgc6f++mz7uPQqGuLg2sFZ5L8zfT8IXFoVKhfZhbhKRnGjPJslhvS+Pos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRixDDOc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRixDDOc"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b788a98557so34942615ad.2
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 11:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778525693; x=1779130493; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7T/97TruJEbqR9l5aE9KNSKlQDlMhwDKO9JT5H/SUXc=;
        b=bRixDDOceQ6NIYenO+rBdUJ8SmwbK8pnoPRdmGcjxHMsL8VPjzYFFdck3C20XrbpO2
         MP5L0fkYu6+6OZFGqE5IivtNC65kONnwTo/DD9nz2MTYg2kHQp+JOJsN6NyQLTqtfTcv
         w+fx9/EvGvircV6a/W3meC6gXpCpjLmtnbj+6ylqoB/DkjtuJR0NjZbhsFVVGj+g+Zg+
         YQySLwHNKzBIqo83skSuL8u6SqA5myDiOsZAqazFlSIY1YWFlRAi8oQmUyyQngF77D42
         A0sCH6vy0JfOIm5Kg2TBO4cE0TvsZy9r8lnc0lDoXffGOmrDsa+Dickxt7vYy2P6bNtu
         clIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778525693; x=1779130493;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7T/97TruJEbqR9l5aE9KNSKlQDlMhwDKO9JT5H/SUXc=;
        b=i1xdPNgA9BmzfJzyKmRBT4R3OJIwW2tGCYQr2MzpMv/nRb7DOLmPrg9gr1Qw15Pl3N
         XzKUsX9UvdmoJRKdHfvlG92PESa9GaQNCXuGNAT6PbESLLTzruYqRdxLWBRxUXX0Yqkv
         cMdjV5haNeSIHdG8boEjmP210j+WaH7h7OsKe2Pc3kWwZfDupjFMAqqoCaVngyEkP9sG
         CyvbMLzzsjN8b8tq4otjc/0uaOF+7y3mWeDVh7U4plPvJC03vC7xPGDQ1GQFg2RG+JbI
         0eqkOmQosvRdJ9c2+Lzmx1AJRu4c3qnGORDhTIpzzHFD6W5IQVgOeDrBinp+j1YqH9OO
         N55w==
X-Gm-Message-State: AOJu0Yy+BD0WWKVGuS8tqCzztRz5CDIsGuIQWmKDRZnFO67rUJeVVRx+
	YOwzNnGNmT1Lowr/z83P+FfeHkAqoj75IQQwiFXKKysKoB71CDIUts25
X-Gm-Gg: Acq92OEMK0ALftioULbknx0zidJJeW2dj1WID5RVO9Lo0rqybtpyhbgKss+OZna+/B0
	0/ARdQEXLbOIQpkvouztSiXOYbUdzIsG2NSP9vPs4NF/M26j0Ch8SbzrZ1wHxMA6t/jtqX0eKIH
	+PJv4ibYKvqMBcWYoCrX7mIDRqCm2lQFQdTKyrOhCqXJfSv+Q56nTF0Fxr1Y7RKDPe12AiekXS+
	1CGqtch0VnhSAAv9YGsepTEIT6yZqzEX0gbffiCAg7OvsHl6iDu3VSzxhLtcuK77Qnz5xb/Wb4t
	eLUkqkdHyaCT+PiZ5pGua3WbQOZWClEITlpSafsmmfOfVlPf2cEJjN82A8/SN/XIw/eTec801Ui
	hED8rjs0fPnyFsf1oEZGKxwGT+8tDBaZJub3XifP6KzyRmcKJilNIIL/ieXRex2pHPzf1qAi2sk
	d7Ke9ma0qp8EROZg5068z1+ux6dYmft9AxZWnu04X6rE1BUv/4Do4T
X-Received: by 2002:a17:903:32cb:b0:2bc:8ebd:af71 with SMTP id d9443c01a7336-2bc8ebdc245mr99672815ad.39.1778525693058;
        Mon, 11 May 2026 11:54:53 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d4057fsm107358095ad.21.2026.05.11.11.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:54:52 -0700 (PDT)
Message-ID: <b063ec89e7ab548d93a892c44ede2824040ebf10.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 10/14] bpf: change logging scheme for live
 stack analysis
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, memxor@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
Date: Mon, 11 May 2026 11:54:19 -0700
In-Reply-To: <agIVpXzC_bXgJ44N@mail.gmail.com>
References: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
	 <20260410-patch-set-v4-10-5d4eecb343db@gmail.com>
	 <af0gXEqD3FPFYZDj@mail.gmail.com>
	 <639f1b0f97330c98668c00244c0a7bae19e30e3c.camel@gmail.com>
	 <agIVpXzC_bXgJ44N@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-05-11 at 19:45 +0200, Paul Chaignon wrote:

[...]

> > > I'm wondering if maybe there are other opportunities to reduce
> > > verbosity here (besides [1]). Maybe we don't need to print the
> > > fixed-point iterations if we're already printing the results? Or mayb=
e
> > > we could put the more detailed liveness-related logs behind
> > > BPF_LOG_LEVEL3 or BPF_LOG_LIVENESS?
> >=20
> > Had this been a normal compiler or jit engine, I'd vote for
> > BPF_LOG_LIVENESS log channel, I'm not sure what our stance regarding
> > user visible ABI here.
>=20
> IIUC, it was only released in an RC and the logs themselves are not
> really part of the ABI, no? Or is there some other concern I'm missing?

I mean the valid flag values themselves. I hope log is not an ABI,
given the number of times we changed it. If BPF_LOG_LEVEL2 is considered
a kernel development only thing, then splitting it into multiple channels
would actually help the developer, imo.

> > Regarding BPF_LOG_LEVEL3, I think that the original idea behind
> > BPF_LOG_LEVEL2 is that it would serve as a "debug log" that regular
> > users won't need to consume. What is the motivation behind collecting
> > level 2 log on your CI? Is it to infer clues regarding programs
> > hitting 1M instructions limit?
>=20
> At the moment, we collect this (1) in case of failures due to the 1M
> limit and (2) to compute the maximum combined stack depth using the
> per-subprog stack depths and the callgraph. (1) is not expected to be
> happening often and isn't much of an issue. For (2), I'm planning to
> send a patch to have the verifier report the max stack depth itself.
>=20
> Overall, this isn't an issue for us. We're just using a bit more memory
> and disk space. I just though the sudden increase was unexpected and
> thought I'd have a look :)

For 1M instructions, I have the code to identify loop headers, so
error reporting here can be changed as follows:
- count the number of times each loop header is visited
- when 1M instructions limit is hit, identify the "hottest" loop
- print info about the loop
- if loop is supposed to converge (e.g. it is an iterator based loop)
  print out the samples from states cache, noting which registers
  differ between samples.

Alongside your future patch to printout stack depth this should make
log level 3 not needed for now, I think.

Kartikeya, do we plan to do something about 1M reporting or are we now
pivoting towards rust2bpf vision?
