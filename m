Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA433245031;
	Tue, 27 Jan 2026 23:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769556692; cv=none; b=PsmrN3b+rS0m5bEQzlOihHnLiEHoW1tY8xVom4irGo89bhh6bJFL6rdl9ZW3sv0NWS+vm2u1M1nI6RhEpeUMDP3eD9qGblV9hF0gvPeNi+uhX5h1/lHshaOj/oz5cirXORykpoZpCy8kWyQOb6gnomxtezhoOaElTqCwEfnYfn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769556692; c=relaxed/simple;
	bh=UBN3NOPFd85zheM/xL5AgOtZaOFrFdo5tpzL1YxcB7Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=suARuOZo7PbsBA//Fh1s7P3LPa0pSUtCnRA3qMhgtdqN3x5tZsEEs4koi8Tz9Uax/mF/JxuAj+72xja0abJqCrMgxzJ0dQIlukYcey2C9L6UgbhyS0sL+AzDruX0ct4mD5L7pS9lJY6WgmWsQfrbL+Uprslt86QSYd0LX8lOe1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eHqGwJnV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eHqGwJnV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1BFC116C6;
	Tue, 27 Jan 2026 23:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769556691;
	bh=UBN3NOPFd85zheM/xL5AgOtZaOFrFdo5tpzL1YxcB7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eHqGwJnV1EQEhnkOrvVHX9jrufBbyrq5CI07GU4V6mlMf9v9hAn/+cL/Q8MP9UTXG
	 3MNuHytU8/GjS1cij72Gz3cN1hjHI2OaKn0YKNad2DCFiHh6mktkk85JJniGFZKJtQ
	 G590jVQ4GkEtCDCULZ6yqWs75qI01JYwX/eR7PMw=
Date: Tue, 27 Jan 2026 15:31:29 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Marco Elver <elver@google.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, kees@kernel.org,
 nathan@kernel.org, peterz@infradead.org, ojeda@kernel.org,
 ubizjak@gmail.com, Jason@zx2c4.com, Marc.Herbert@linux.intel.com,
 hca@linux.ibm.com, hpa@zytor.com, namjain@linux.microsoft.com,
 paulmck@kernel.org, linux-kernel@vger.kernel.org,
 andrii.nakryiko@gmail.com, yonghong.song@linux.dev, ast@kernel.org,
 jolsa@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, bvanassche@acm.org,
 nilay@linux.ibm.com, bpf@vger.kernel.org
Subject: Re: [PATCH] kcsan, compiler_types: avoid duplicate type issues in
 BPF Type Format
Message-Id: <20260127153129.2ca728a4550375a4172e1351@linux-foundation.org>
In-Reply-To: <CANpmjNNoDHQOfH+bUqjpHdzYDxLwG7wA9qEywfWFNamt66Ziyg@mail.gmail.com>
References: <20260116091730.324322-1-alan.maguire@oracle.com>
	<CANpmjNM=w46BDuLsvAW6oM7JbPvrhN1ddaEUNSvsfZVU-514cQ@mail.gmail.com>
	<CANpmjNNoDHQOfH+bUqjpHdzYDxLwG7wA9qEywfWFNamt66Ziyg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jan 2026 00:08:10 +0100 Marco Elver <elver@google.com> wrote:

> > "KCSAN and KCSAN_SANITIZE objects" doesn't make sense.
> > "KCSAN_SANITIZE.. := n" objects?
> > Or just "instrumented and uninstrumented source files".
> > Anyway, I know what you mean, but others might not. :-)
> >
> > > Fixes: 31f605a308e6 ("kcsan, compiler_types: Introduce __data_racy type qualifier")
> > > Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> > > Suggested-by: Marco Elver <elver@google.com>
> > > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >
> > Reviewed-by: Marco Elver <elver@google.com>
> 
> Which tree do compiler_types.h changes go through these days?

Thanks for poking.

compiler_types.h appears to be a free-for-all.  It's best to view such
a thing as a KCSAN patch rather than a compiler_types.h patch - that
the patch affects compiler_types.h is incidental.

31f605a308e6 came in via paulmck so convention (which perhaps only I
maintain) says "Paul", but whatever - getting the fix merged is the
important part.

So I'll grab Alan's patch, shall drop if it pops up in -next via a
different route.   Aiming for upstreaming in the next merge window.

It's unclear whether a -stable backport is required.  Thoughts on this
are sought.
