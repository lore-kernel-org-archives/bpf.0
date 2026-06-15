Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3680D3A7F7C;
	Mon, 15 Jun 2026 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563115; cv=none; b=qnbnWo4758pU+uPcYnWnrtjMqnXBEZAAP65ygACl2hQqeHhIyxtJEoX1IpBYcRc9oRmwYK/BbOeb1uVDvxURjjrgLyUhJKArW8cRRLs66FrOhJ1BdZ/W/D4rvjlwI5abPJImIgxX7LexpYvLk+98V3azJsh4NsewX5WVfJ/gDAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563115; c=relaxed/simple;
	bh=DFiobPSyQnoHucHgf6MiVtg8PJPuq6txzSTExVUUuWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omf4nzEFG4SyrgiAv3ShG9kKh7n6D3SZQpBN/jCsgI6bhnGIG3tRRJ08F5wPzuokOX80kDBQNBOHvuYGMfEWvbKphqNf65OdI+7JmRH+U8WIJJPRiL3ijujIsI5XuFz1QXicJPz1FfY9FxGyPMZ7QVA6IE4jjblKtuGCSRwplQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFMCllS6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFMCllS6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D772C1F000E9;
	Mon, 15 Jun 2026 22:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781563113;
	bh=s19auisx0OTxl3Mwb/7oihK9l6ttYY312/kiRjwUppA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GFMCllS66TyLC6bQx5hGxJJIsyh9aoC+pdYyoga9uD6KH5Ubidkb/KdgbRR1tx2VJ
	 9lf1V4FRk4thWHOyZiqojpPL5/111B1LBQs4Wc5mA+Tbnza7wk5GH3ivoId7w7sjPh
	 758ZS5h4Izq+ucC2A2Dof+ibBnZAFI8gkptx6mE/yO0aaFpc8GvHXojzQdOVQYE9c1
	 +3sgz5KZwy5AAOSnWu/co3Xp32sM55q/fPAlRv/R01tvPQ3qmUdhTXtiQe0XsRNxn5
	 4L2FnvOhpbGKQZZhXXPXdHjN1sEnCE4F1Pfe0qMj+u2JmaggvL1l0NAqxYHaOA3XFR
	 Cxnxth46AnqTQ==
Date: Mon, 15 Jun 2026 15:38:33 -0700
From: Kees Cook <kees@kernel.org>
To: Jamie Hill-Daniel <clubby789@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
Subject: Re: [PATCH RESEND 0/2] seccomp: Allow using `SECCOMP_MODE_STRICT`
 with `SECCOMP_MODE_FILTER`
Message-ID: <202606151535.F32ACD538@keescook>
References: <20260526-seccomp-combined-v1-0-304b1cc3ad24@hill-daniel.co.uk>
 <202606122110.28245E2D@keescook>
 <CAO1UbGcbueeqLPOFA+=cJKjQxgXr1pW1vGFR-zNOT7rqsUqs+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO1UbGcbueeqLPOFA+=cJKjQxgXr1pW1vGFR-zNOT7rqsUqs+w@mail.gmail.com>

On Mon, Jun 15, 2026 at 05:23:53PM +0100, Jamie Hill-Daniel wrote:
> On Sat, Jun 13, 2026 at 5:14 AM Kees Cook <kees@kernel.org> wrote:
> > On Tue, May 26, 2026 at 04:32:14PM +0100, Jamie Hill-Daniel wrote:
> > > Link: https://github.com/moby/moby/issues/42082
> >
> > This doesn't show any particular application, just a demo program.
> >
> > I'd *really* prefer to only add complexity to seccomp if it is
> > absolutely needed.
> 
> When I filed the original issue it was attempting a minimised
> reproduction; I was trying to run some legacy binary in a container
> that I unfortunately don't have the context for any more.
> I've submitted another series that should hopefully address some of
> the concerns raised here, including complexity.

Right, I think I'd prefer the legacy binary be adjusted instead. And not
adding complexity to seccomp given the issue isn't actually a problem
any more. :)

-- 
Kees Cook
