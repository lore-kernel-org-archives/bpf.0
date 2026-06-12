Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7EE331EBF;
	Fri, 12 Jun 2026 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275459; cv=none; b=JWXpAV4Eeef2nZIZDPu34U7dzvAN2qpM9Xb2P6OSlRw/Dndp33AjBb+Skkcnh2f7lQQTPLZxEcWqzxhaYtDtl/Gegc6JSClWI5weLUxWP80UbjlL/mgQr32GXJKQodB67BSl1XUGMhsaTN8cIHTX0aFj02Djjnmha00RlUfpEAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275459; c=relaxed/simple;
	bh=dxFtqWQ70XB/DaGOcbVC90PMg8yesbWzoM+TwcPqJdU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRIuAVhC5uhMJo+LVJQgq7nhrUDF+ViJCjNr/AyUyMtLI76+XJ0M1+FHHDEpn4EBEqsx9oecygBMHQ0avZYVHDhWzV253Oj1Bb56ntARKOOgi8polxKCLa2lp6/xR8N+V9R91zfpq7hcg1FHT/LBG4bep01CImf4Yfho7ZIJkjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3Xlhxzd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3Xlhxzd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE041F00A3A;
	Fri, 12 Jun 2026 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781275458;
	bh=n9aTJjJwU1L9XEBdVRGWsY/1ImnvN4E/KMlZX2tVWDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=E3Xlhxzd+m3y5iDwefNy32rmo7fIhHyKTP4J+ETI+4nN5UWbMN9N8KoDF3xr3hoJ/
	 r99CC64PSLdS7N4IVizA5Gaom73abuvDqkM5GzT3e4uK1ImKx5Cz07EOMuWLcBsnyg
	 am7YwIZO4+cLhii4drTRF6JmPt8TQwgMXj2wCp3CAjleMMh6UQ0hgnNIQaQ8DPrPbZ
	 7OxwrRP/c83qNQEXs28AO74N2kOVhmk2wPnLITfKtYVMbMjjbBoWnx9mFCVxsOrMCh
	 yf70RRBgKb7PPh1vI9icfaouNq87BxuVK+jnf3gOO5xxuZselitvQc4jXWgZGyVZ00
	 SeXPRAG+hfPBA==
Date: Fri, 12 Jun 2026 10:44:15 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "bpf" <bpf@vger.kernel.org>, "linux-trace-kernel"
 <linux-trace-kernel@vger.kernel.org>, "Martin KaFai Lau" <kafai@fb.com>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <songliubraving@fb.com>,
 "Yonghong Song" <yhs@fb.com>, "Menglong Dong" <menglong8.dong@gmail.com>
Subject: Re: [PATCHv7 bpf-next 03/29] ftrace: Add add_ftrace_hash_entry
 function
Message-ID: <20260612104415.0becd517@robin>
In-Reply-To: <DJ6EGJ8S87HP.2WOTGYK374XKI@gmail.com>
References: <20260603110554.29590-1-jolsa@kernel.org>
 <20260603110554.29590-4-jolsa@kernel.org>
 <20260609102922.3c489f76@fedora>
 <DJ4LJUWPD2BF.1TY4Z3WY2V0H5@gmail.com>
 <20260610113536.77172ad1@robin>
 <CAADnVQ+RhRiUp8FeptdVKZimGd-Wv8C+NbW5U4hh+7Hi5abQxw@mail.gmail.com>
 <20260611094648.04622890@gandalf.local.home>
 <DJ6EGJ8S87HP.2WOTGYK374XKI@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 10:35:11 -0700
"Alexei Starovoitov" <alexei.starovoitov@gmail.com> wrote:


> AI finds things to consider, but when they're considered and postponned
> to future it doesn't understand that and keep reporting the same thing
> every revision. So it might look like that patches are landing with
> outstanding AI complains, but this is not the case.

Well, if someone just asked me to give an ack then I would have. But I
have other things to work on. Especially since everything I do at the
moment is 100% hobby related. The chores my wife gives me now have
priority ;-)

I'll start a new job come Monday.

> 
> btw since patches touch ftrace from time to time should we add your
> ftrace testsuite to bpf CI ?

That's actually a good idea.

> How automated is it?

Very. In fact it's public. Although it's been a few years since I
updated the git repos.

I have two qemu images (currently private, but I can update them and
share). Where one is a 32bit x86 image and the other is a 64bit image.

The 64bit image hostname is called tracetest and the 32bit image's
hostname is tracetest-32. Both with root password of test0000.

The tests loaded on the image is here:

  https://github.com/rostedt/ftrace-tests

And the ktests I run are here:

  https://github.com/rostedt/ftrace-ktests

I would run the ktest like;

  ktest.pl -DPATCH_CHECKOUT:=<SHA/BRANCH> -DPATCH_START:=<first-commit> tracetest-64.conf

And in another window

  ktest.pl -DPATCH_CHECKOUT:=<SHA/BRANCH> -DPATCH_START:=<first-commit> tracetest-32.conf

For example:

  ktest.pl -DPATCH_CHECKOUT:=trace/ftrace/core -DPATCH_START:=b5d6d3f73d0bac4a7e3a061372f6da166fc6ee5c tracetest-64.conf

And that will run 40 tests (I added some more since my last push, so
github doesn't have 40) and build, boot, install, test on the qemu
64bit image. It starts out testing commits from
b5d6d3f73d0bac4a7e3a061372f6da166fc6ee5c and going through to
trace/ftrace/core. Note, the PATCH_START needs to be in the history of
the PATCH_CHECKOUT otherwise the test will fail.

If you want to run these, let me know and I can help with the setup.
It's what I gave Masami to test as well.

> 
> >  
> >> 
> >> While at it, please review Mykyta's set:
> >> https://patchwork.kernel.org/user/todo/netdevbpf/?series=1096695
> >> 
> >> It's also been pending for almost a month now.  
> >
> > Have a better link? I just get a blank page as "TODO" is set to what I have.  
> 
> Ohh. I meant this set:
> https://lore.kernel.org/bpf/CAEf4BzZFjsEv3aLktwdCZF6EXoCL+eefX+6xa3XGrhBmfO1SqA@mail.gmail.com/
> where you said that you'll think more about it after pto.

I came back on Tuesday and have yet to catch up on all the email I
ignored while away :-p

> Would be great to land it now for this merge window, so we have
> discoverability right now and if better approach comes in the future
> we can adjust to it later.
>  

I'll take a look at it.

-- Steve
