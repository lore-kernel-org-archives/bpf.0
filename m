Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCFF283C82;
	Mon,  6 Apr 2026 03:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775446056; cv=none; b=aydUvMPeDvvled3RUVQ3m1JVw7j3918RoxPuGK/TcK0dySe6Ho7liqGU6hxZkunEc7P5zo87zJbFxNTJXJ2qo7fhGDX4Dd+xVJo/GpZfwEIqzw29TXnAEiNvOA4g5S/tfnfKcmH2+pYCOl2F0REjAiCiHPxIRpfWyJUhMZj7cQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775446056; c=relaxed/simple;
	bh=1dVZhx7NWfZtsaqKnARXSq5UNb8tfSjOajEnYqOCrAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qunG6NdxA9lkSdbd8OU3cYbDZ8qxwXUuP6fZ00ylyS8qEu3q1SqYIK8M9cF6smwsVJVNn2hwnZhkesHHIg4H/cnxe+qm9eFjWJwyscfSu1m7JEHJCL/fMj7oyGxZ6GGwNlA+tf1UJI9QOgwhdGTea0PN4qcJWU4jy4Z86CywqHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYaGe//J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYaGe//J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A59C116C6;
	Mon,  6 Apr 2026 03:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775446056;
	bh=1dVZhx7NWfZtsaqKnARXSq5UNb8tfSjOajEnYqOCrAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GYaGe//JV/9N1tzeEJsTfSL2ujLmvnJHd26C6Ef6lJJTWcCNujW3cW2ResW5fEj1i
	 VEXujtmKoJDdd+8LiQSO3Dwv64M6Hu6+RhVSqdly839g2jlZX/skvjyjJmBxMt1E8W
	 7BKuXWsa1cUWDK2fOPSbtrXcLh+bdHDz2y7ZjFBpAlWCYMyXT+HpAHdYe9LXYnyFmM
	 LgOC9zD6Nxi101Zy/h8mZ4wODvzBN4mBOaRf4Br61muA5PrSVF+dTqjruSymGVkIvm
	 4e8NPb8BuGILnBhp1GTczknVl70r8e+JmnEYQ/IGYKWxgGtTNGUyM0Ra5ger7RYEh6
	 9U0/WU76LNpUg==
Date: Sun, 5 Apr 2026 20:27:35 -0700
From: Kees Cook <kees@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] bpf: Avoid thousands of
 -Wflex-array-members-not-at-end warnings
Message-ID: <202604052007.4EF0560F@keescook>
References: <acr7Whmn0br3xeBP@kspp>
 <CAADnVQL1kaAZE0L2k6svR4FK8UZvw44WXp=g+Df+SseMkc7xGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQL1kaAZE0L2k6svR4FK8UZvw44WXp=g+Df+SseMkc7xGA@mail.gmail.com>

On Sun, Apr 05, 2026 at 07:44:51PM -0700, Alexei Starovoitov wrote:
> On Mon, Mar 30, 2026 at 3:39 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > Apparently, struct bpf_empty_prog_array exists entirely to populate a
> > single element of "items" in a global variable. "null_prog" is only
> > used during the initializer.
> >
> > None of this is needed; globals will be correctly sized with an array
> > initializer of a flexible-array member.
> >
> > So, remove struct bpf_empty_prog_array and adjust the rest of the code,
> > accordingly.
> >
> > With these changes, fix the following warnings:
> >
> > 7659 ./include/linux/bpf.h:2369:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> > Changes in v2:
> >  - Remove struct bpf_empty_prog_array. (Kees)
> 
> Kees,
> 
> It really bothers me that you ask people to clean up
> warnings for the sake of removing warnings.

It's not for the sake of warnings; this is to remove the ambiguously
sized objects (i.e. structs that the compiler cannot reason about the
size of).

-- 
Kees Cook
