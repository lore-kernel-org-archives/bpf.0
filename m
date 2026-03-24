Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C94C3A0E81;
	Tue, 24 Mar 2026 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369424; cv=none; b=AgDi7mTAtojLpudjPrZQouYg/xpFbJQa/I1MyqKfK/s6lM09/OWOx0MUfdSCINMW+m8Y6q9gqEEbp+HWPs8iAyiSivn+FlJeNMWM9jW9JcPBvy7+HKOBI+DEfkCnm3bV/Gm172C7FPLY6ako1pUlyuoOznOGH+x7JguNBpP6Y0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369424; c=relaxed/simple;
	bh=WQ1A8b35lF7Jv9ylYLhpyHOZ6n4C5LJ0Rc2K5iNsUD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrAY0+fY+GcpzWEgokAc/sB0cerIWTm1UtiO9iez+LM6WzCFvIRtwSJohy7+ving0qXr+pBZHJLvR8nlKaGkw7zZRkVlX0hFuKVNethplkJHSC5QWdOxKMN5bUGdEETGWJEK2TAIi8HmY2II1ziIdQnAPECbJdxOCB9K3cwjq0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfgJFV0X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfgJFV0X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C97C19424;
	Tue, 24 Mar 2026 16:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774369424;
	bh=WQ1A8b35lF7Jv9ylYLhpyHOZ6n4C5LJ0Rc2K5iNsUD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CfgJFV0XxugbAMVRakJTh3ANfvm9yIhKA/ucPhw5VKcgSqmTJ359JMD+eABCpTvoe
	 7M2Zs9uA9nGLFo9vGZcBjFHYxW7ZNjXNKgoiA2AkPX9OTzxzGByZGzAwrg/rf9PdIN
	 yuq5TYR1gxobpzkdVvq7VR6xJJsFMu9F62ChoDEDAdHtzbNYuDPzUaB2T+Xyrq3O09
	 R+P1Awee3rcYLxLAf6ccirJYBoY8VkF+KDmCwStpxMzVetiXnaxKWjTFPzjFgNJpNU
	 KTYQs1fNaCvELzv8VDQDnY++OBxekLX7u7KeXE+fVcfMO8jXmVoMce0ofgN8ds0LT7
	 at/tb+dxHGzqA==
Date: Tue, 24 Mar 2026 09:23:43 -0700
From: Kees Cook <kees@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] libbpf: Replace strncpy() with strnlen()+memcpy() in
 skel_map_create()
Message-ID: <202603240919.D248D71B48@keescook>
References: <20260324040535.work.851-kees@kernel.org>
 <202603232224.C1555BF@keescook>
 <CAADnVQLhWURvQ=gBYQvuEa3pTxabYQYhrPm9QG0gbxL9ee=vng@mail.gmail.com>
 <D53376BA-4772-486B-A18A-6858C1732723@kernel.org>
 <CAADnVQLA3K6v_+_7-+BDVEeZ2N=6229FL6Ko=3ywDWsPVOPLcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLA3K6v_+_7-+BDVEeZ2N=6229FL6Ko=3ywDWsPVOPLcg@mail.gmail.com>

On Tue, Mar 24, 2026 at 08:38:48AM -0700, Alexei Starovoitov wrote:
> On Tue, Mar 24, 2026 at 8:28 AM Kees Cook <kees@kernel.org> wrote:
> >
> >
> >
> > On March 24, 2026 7:42:04 AM PDT, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > >On Mon, Mar 23, 2026 at 10:25 PM Kees Cook <kees@kernel.org> wrote:
> > >>
> > >> On Mon, Mar 23, 2026 at 09:05:39PM -0700, Kees Cook wrote:
> > >> > While the original strncpy() would have copied a full 16 bytes from an
> > >> > overlong name (producing an unterminated field that the syscall rejects),
> > >> > but this wasn't a reachable state. This replacement will instead always
> > >> > truncate to 15 bytes and keeps the NUL terminator, which should have no
> > >> > behavioral changes with the present code and avoids potential issues
> > >> > with future over-long string literals.
> > >>
> > >> Hm, I got a failure report, but it *seems* unrelated? But nothing else
> > >> fails that way recently, so I will try a v2 with the "unterminated at 16
> > >> bytes" behavior restored and see if it passes...
> > >>
> > >> test_progs_no_alu32-x86_64-llvm-21:
> > >> https://github.com/kernel-patches/bpf/actions/runs/23472955268/job/68300440546
> > >
> > >Don't fix what is not broken.
> >
> > strncpy is broken. ;) This is one of the 6 remaining uses of strncpy in the kernel. But it needs a v3. I'll add explicit rejection of over-long strings and validate that the bpf test was a flake, as suggested in the other reply.
> 
> Don't. it's not a kernel.

This is a very terse reply, so I'm not sure what you're trying to tell
me.

Do you mean to say that this header is not used by the Linux kernel
build? If so, that's a misunderstanding. I found this case due to 0day
complaining about it after I removed the kernel's strncpy implementations:
https://lore.kernel.org/all/202603240325.rd8gRV6s-lkp@intel.com/
https://lore.kernel.org/all/202603241330.vmNnBWvZ-lkp@intel.com/

(I had originally ignored tools/ since normally the files there are not
included in kernel builds, but this didn't seem to be the case for this
BPF header.)

-Kees

-- 
Kees Cook
