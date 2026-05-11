Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDC835E947;
	Mon, 11 May 2026 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517989; cv=none; b=TkThGcnfqHQzitTnNxos2tXmTy2pQwaJZVRawJIm0MF4hW0FsyYji3lmCPFZyzA0IbNwiBNhRPRVzzF5r0GZ5cVi+Xu3nHDViwrG20qYV9dR6T/8qOsEQUSXHWlmtjFxN0rfx+57UeO4ZQH5iO4uzxxHYncHea6MRDtMBktWuN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517989; c=relaxed/simple;
	bh=nfGZyB3lIB5f08Ee0kES/jnnz7msQNlVXJZAMyvmW1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4KBjxqBItyPpdURwwSQ9OOQICGJXWH0neIJm3apiF1H8KJEVp2GfTrJvnqJAOUSL2DlXyLbhHlbH9Vu6DyacMIzZMpHFOrKpSZ6kyH3F54cFrJnOjFand5oGD5SkanGj6KF8DMh7HlEwVA1U196UTBIh6ZrvwwxjmkzE1h6kDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4Nc/7bq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4Nc/7bq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0895BC2BCB0;
	Mon, 11 May 2026 16:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778517988;
	bh=nfGZyB3lIB5f08Ee0kES/jnnz7msQNlVXJZAMyvmW1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a4Nc/7bqf37wr/PjEC4C0fjC9bgziU7Cleu217BxjD0P/QDeVa/+7rUW/V0yYT4pg
	 2BGvJvlkBBqZ0NGT/MOp6IUZYa227baCEjOwgaJWTP5Dlu0JvT9R0XJO4IjACkTEF0
	 wTidiB0zBTynS39nY72Pt66YkbvmGKyRc2j8H8MKDVZ/IpqGv1vgyvOsypcJlo/4yD
	 j0/u3WuzkQTwgpsJNKXhPck9iTP56dQUrS0mpRkNcTd4Ub4ywcXUQMLJbjp6V/CwwI
	 zQR9XqyPU5Dq6k6p7EdEC4g1F9L1pVTEXzUotjVEZTSgfQpMAyP3r5ARr1vQez4sbL
	 ejE+4PqpDayGw==
Date: Mon, 11 May 2026 12:46:26 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Indu Bhagat <ibhagatgnu@gmail.com>
Cc: Jens Remus <jremus@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 bpf@vger.kernel.org, sashiko@lists.linux.dev
Subject: Re: [PATCH v14 07/19] unwind_user/sframe: Wire up unwind_user to
 sframe
Message-ID: <20260511124626.03637e05@gandalf.local.home>
In-Reply-To: <a51c45c1-852b-41a6-ab59-9da186350e36@gmail.com>
References: <20260505121718.3572346-8-jremus@linux.ibm.com>
	<20260505185528.8E529C2BCB4@smtp.kernel.org>
	<05adaec0-c2cc-4a16-b2da-ba3ed7437e7d@linux.ibm.com>
	<a51c45c1-852b-41a6-ab59-9da186350e36@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 May 2026 16:07:27 -0700
Indu Bhagat <ibhagatgnu@gmail.com> wrote:

> For malicious num fres, should we add a check that a function's num fres 
> is less than or equal to func size (available in the FDE index entry)? 
> It is an approximate check, but should provide some boundary check.

Yes, something like this would be needed.

Thanks Indu!

-- Steve
