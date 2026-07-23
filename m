Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA64748C8A2;
	Thu, 23 Jul 2026 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784813555; cv=none; b=RQAR/89i8z56eAQNoP0RjDFSXzsXKQvpe4JtH89l/sWvvoBFdeQhF9yww90UAVwoHVqWxPWU8zCy7zy2kdt+4hIsv8JXEA21yOHz7C9vJ0DXONukXPAz6diN0zAMTIsf+anCSl4bU/seg+x2EdQApVGwA7MqaBrtFIn2zxKkZ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784813555; c=relaxed/simple;
	bh=pmGT3faBfzPliMxibFwp5n4R6WM3SvhEchhx/+niCQk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ng/amBg1uFnoKsAuM+rdO35y1mUFCqXgPX/JzjWJE/1g0uvI7/FsRSFzUfYpA6ui2pcgeC539E0ENJnmSuHx+A9b7uj0uBtOLKotZel9cgV/GRthSQHxIBKhZF3gtd5n1yPVYw9WTg3YHO1L03dntqNmmQ/dbJE56QLmuUr+0/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxKeUhdm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxKeUhdm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90D81F00A3A;
	Thu, 23 Jul 2026 13:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784813552;
	bh=NAWPQDEwgUQenFjlFjzBd00tOhMhEOyT4kNXUGq7gfw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=RxKeUhdmBj4gJ1n4H1BRQDxOeHFg7Em7lrvFM95dPVAlyrqEEKogQVYaETnHVeev2
	 geYcv0RmFhuu30Q+RaFN0kQfKqIorfqhzFt4g7mFnEVulsghRfHaTqiNVaGt7etaac
	 yAOmy68hWehWYt4nkKVWJ2kxMoEhr02NkP+XMMIuVI0R6YdcnySFDuLWa5DkjWhY6K
	 HaG0+YdObuc19bGQxK/pVLT2mIkZ4k5w9ZEs5Fy2atEdxVgbj5m0PGVjXzM43oSEmL
	 6++8JM05scF/b7faXlUJId7oQljZ+E6hJDH6MWykOW5GRvZ88g4cNhK7sakvQFRiXl
	 FyRSSS3WdVMrw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 00/21] binfmt_misc: transparent interpreters and
 PT_INTERP loader substitution
From: Christian Brauner <brauner@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
 linux-mm@kvack.org, bpf@vger.kernel.org, jannh@google.com, 
 mail@johnericson.me
In-Reply-To: <178477872729.254289.15918342296936455606.b4-review@b4>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
 <178477872729.254289.15918342296936455606.b4-review@b4>
Date: Thu, 23 Jul 2026 15:32:09 +0200
Message-Id: <20260723-entmilitarisieren-respekt-lehne-5db75924c69a@brauner>
X-Mailer: b4 0.16-dev-0e65f
X-Developer-Signature: v=1; a=openpgp-sha256; l=692; i=brauner@kernel.org;
 h=from:subject:message-id; bh=pmGT3faBfzPliMxibFwp5n4R6WM3SvhEchhx/+niCQk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQlib81X/yro9uX6wzT4+aHLBEPXf2fbNT/97/Xvf3F5
 risLLmgjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl85WBk2MB8ZUJZ64Y7+1pc
 DH5eufWsnX+Fh+Wq13alRYI1v3cz6zAyLJ06c8vDJ0cCLGqrLF/U8/f6mok2TlI0mm4VeeCTyNK
 XTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-22 20:52 -0700, Farid Zakaria wrote:
> On Tue, 21 Jul 2026 16:13:42 +0200, Christian Brauner <brauner@kernel.org> wrote:
> > [...]
> >  tools/testing/selftests/exec/loader.bpf.c          |  56 ++++
> >  tools/testing/selftests/exec/transparent.bpf.c     |  57 ++++
> >  19 files changed, 1823 insertions(+), 303 deletions(-)
> > ---
> > base-commit: 6cea93ff6fe97df34b63fe94487473e16c73b74b
> > change-id: 20260719-work-bpf-binfmt_misc-ptinterp-e6ee99ff6ba8
> 
> Started to review (slowly); looks like the first ~10 are mostly NFC / refactor
> / documentation.
> 
> This b4 thing is so slick; I want something like this for GitHub now.

You're not the only one. :)

