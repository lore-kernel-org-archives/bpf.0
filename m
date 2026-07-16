Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FCB3F86E9;
	Thu, 16 Jul 2026 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195312; cv=none; b=dzUyv1kRjSpSmn6D7mYzd0MarhvXq7t8Q1xLp4G0N/fnruwAnq1/WYtN14nzWD0nAGaquSlFBsDRbxtqUy9DfOS3iJTQFspM7U8KOP81wk+ER/2C+nqZZ70CK3TzLFJmCkG+HLAeOnGwa1r5PoU2Yq35Ms2vO65jjbvA0aRIV4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195312; c=relaxed/simple;
	bh=8yuh+opiCsDkPTL5pkqnqBFQxrdtHzHLqSHtGi6/ycI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=YDOpjAiqEjzycelkuOFvNpOTFfBXZdrRuTx8kopjD0htbFrmAkir+oSevsoK17CUMHH//CIxOCflmamded2tqSvfWvT1QFOPMsROjBzZ+TeqYK4SXUV2ETwLoe0fGhT7fPNTPj0Azno2Bpbb9STa0svFZa8BCFpxJHGvJYOUwsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeHGnwYE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeHGnwYE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B93A1F000E9;
	Thu, 16 Jul 2026 09:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784195307;
	bh=JxyOXYLeSk9aQ/yGDXwmvBgNik5N2JsMm+0c+1mv1zg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=FeHGnwYEkmf1xTZgTj8sCxCNE4YOWYp2cV5kMQBDCCdv6QwPWdErbpTytuRJN6QrA
	 yBqcCL96BabBofLUvcAp1u9kXDM6o8N5zO0iRefDZN8Gl+5ZJi1EJZtGg9AAPFFfJe
	 5U+NanCBvYfUdJ/3Z6IpLom5V3jmbB/jZxfvRkf5/BSZqrdrr1aTrOvpx5tchO/+C8
	 izhtSVzJxuFHGUQ90EPfDXpG/+LQBYYbol7hLconYVK4BpjBM2rW2QyNBheneZbYDd
	 3jtg+MUaD38BynL0Sv7Ah7k97euRPJcv4uq/T2uIzCOsrH1VD/Llo2LIesNqoiSuCP
	 xoFQCAOqNfDQw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/9] binfmt_misc: bpf-backed binary type handlers
From: Christian Brauner <brauner@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <DJZK5TY3IXQC.2XKA1X9IEGJDO@gmail.com>
References: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
 <178407531866.2243172.12944140194021045628.b4-review@b4>
 <20260715-reorganisation-umtausch-radiergummi-8b38ca81ebb0@brauner>
 <DJZK5TY3IXQC.2XKA1X9IEGJDO@gmail.com>
Date: Thu, 16 Jul 2026 11:48:21 +0200
Message-Id: <20260716-wacholderbeere-zahlt-beraten-e872c3a4f59b@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1811; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8yuh+opiCsDkPTL5pkqnqBFQxrdtHzHLqSHtGi6/ycI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRFrHj+Wi+G6daXyuu6k+3WRMttPvy56IWeabU6v0fHQ
 /PJMka/OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZySJCR4drMtXNf6cXs2TX5
 L6+lU12BkPrEKi73vmV2jN0XTqv8dmb4Z+7/yz1Dq+j9wtqZglxerBmzSiaYHX+QemjX56kfVV7
 8ZQAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> > In this mode you can pass AT_EXECFD to an interpreter and don't change
> > the command line. An exec like this is indistinguishable from a "native"
> > exec.
> >
> 
> This sounds super interesting (orthogonal to binfmt_misc and BPF work right?)
> but a neat feature nonetheless. I wonder if this makes it easier for
> tools like perf to attribute the correct binary or they have already
> handled interpreters in the cmdline well enough.

If you do gdb -p on a process that went through binfmt_misc it will load
libc symbols by default. With transparent mode it will look exactly like
a native exeuction and gdb will just work. IOW, if you have a loader
that knows to consume a binary just from AT_EXECFD and honors
AT_FLAG_PRESERVE_ARGV (the extension I have patches for) everything
looks exactly like a native execution (ceteris paribus).

> >> Please let me know what you would like me to do next. I just tested
> >> reviewing the series with b4 + AI -- pretty cool. Was a little clunky to
> >> get it to work but overall a good experience. (I need to tinker with it
> >> a little for NixOS vim setup etc..)
> >> 
> >> I shared this patch series at my workplace as well. 
> >> I think there is some interest in the work.
> >> (If you are curious as to why, I can elaborate on that as well).
> >
> > Sure, happy to hear other use-cases. I have a plan to make it possible
> > to pre-open a set of interpreters (pin them essentially) when
> > registering the handler in binfmt_misc and then bpf would be able to
> > select from a set of pre-opened interpreters but that's for the future.
> >
> 
> This is assuming that in prior calls to the BPF it returned the path
> string to be pinned?

It's easier. We just need to extend "register" to add interpreters to an
entry.

