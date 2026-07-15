Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7691E1FFC59;
	Wed, 15 Jul 2026 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104828; cv=none; b=RN7llOm82qbMBOzG+YwbWsyHWytRSP7I1ryKu7c5CEedYZ/CdpD+v3XUBZNYRWDeRqlxj1IhYVKhPm5zMzpQP4HNeEQrJQjAtrZXo+lUeobxK9thMfi3HhT/73HsEuL4jORNYU6FBN/7jJEfHDD1NWO1sr8pll6DhjpSyUwLiEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104828; c=relaxed/simple;
	bh=hp4wGoiMuSf5ESHSQUuLBbzx5AGsLAQdP+753sT5oyM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=UmzS17CtEDozdm5CJkA1/+ckbM0fSxlbuBx7/7JYYN68yE3pKQU9OCwnYRr+D6VX1QNUQbu9y5OXPztpWd7eocLTYXsEpifmFf1Qb0eME8jCDUhwL6EO4WagaZrod8LdVPlgGK3RX4yHKPVGp8e+n1itxLrJOGtDrvTa4KRUFcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHFlrS1a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHFlrS1a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B30A1F000E9;
	Wed, 15 Jul 2026 08:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784104827;
	bh=nllSsj6f5DuFXpV7qe+Z+Uw/UddY70NaVDwY4vJP164=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=YHFlrS1az3uoddkX0JoP+Wbvv1pXY+2LijXmZkgWmByNJpSerHJsSZUWr3nw8RQ2g
	 YdXLmj2KTUMjoXNwhah4solNpQiupXaD4Agi28vyvY8TXNGHk557Kah+qA6wPIKKhv
	 1edyvvOIsTiq0JwcFdokbugWKI5IdwpiIRkLG/UgCroLgYRqLypTVWCgC3EIueoNy2
	 OAl1iGzcqzCGuKgeyXek3hZApoYnPAxA6UNl8MGGLYFmArU2tvA8vthW0TlI3AquNh
	 bD1NEQka0eKAEMboC+GRl55d4NtIWmb/f98tfR6+w03+rQG5zqKX8ZvWgHHajsNPa6
	 xG3p7GHUyorrw==
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
In-Reply-To: <178407531866.2243172.12944140194021045628.b4-review@b4>
References: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
 <178407531866.2243172.12944140194021045628.b4-review@b4>
Date: Wed, 15 Jul 2026 10:40:15 +0200
Message-Id: <20260715-reorganisation-umtausch-radiergummi-8b38ca81ebb0@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1826; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hp4wGoiMuSf5ESHSQUuLBbzx5AGsLAQdP+753sT5oyM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSFuxfXB73d8dbkkWjNhisv3edWXHnYMc1VccMPkb/7l
 OUPH+uc0FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARgyMM/0xvPJuz5Vb6427H
 bbee2pmf6hTLDpvX8Or8qqrH1h1WNVqMDHPEEpsNimo/Fm33mveyyE1jIteWE4EpVonbWRdffPv
 +Ci8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-14 17:28 -0700, Farid Zakaria wrote:
> On Tue, 14 Jul 2026 21:58:05 +0200, Christian Brauner <brauner@kernel.org> wrote:
> > [...]
> > 		.load = (void *)nix_load,
> > 		.name = "nix",
> > 	};
> > 
> > Farid, this should slot underneath your qemu demo from [4] with the
> > program ported to struct_ops. Feel free to take it from here.
> 
> Thanks for the recent update.
> Is it still "take it from here" or was this left-over from the previous
> series.

Leftover from the previous series. :) Sorry.

> I think you've done the majority of the work here with the validation of
> the few selftests and mentioning the gap for shebangs.

It was a nice joint effort imo. I think this is in general an
interesting idea. I'm also working on some glibc loader patches. One
of the patches in this series allows for "transparent binary execution"
if the loader supports it.

In this mode you can pass AT_EXECFD to an interpreter and don't change
the command line. An exec like this is indistinguishable from a "native"
exec.

> Please let me know what you would like me to do next. I just tested
> reviewing the series with b4 + AI -- pretty cool. Was a little clunky to
> get it to work but overall a good experience. (I need to tinker with it
> a little for NixOS vim setup etc..)
> 
> I shared this patch series at my workplace as well. 
> I think there is some interest in the work.
> (If you are curious as to why, I can elaborate on that as well).

Sure, happy to hear other use-cases. I have a plan to make it possible
to pre-open a set of interpreters (pin them essentially) when
registering the handler in binfmt_misc and then bpf would be able to
select from a set of pre-opened interpreters but that's for the future.

> I hope you are enjoying your vacation.

Thanks!

