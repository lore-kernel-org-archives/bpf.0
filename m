Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2136D3FDC00;
	Tue, 19 May 2026 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194528; cv=none; b=lqu30hmjqLT/pc25HaBI4bnX3gchJNiHNzMIFjRZ1r0aOpJ5AHqIcNBKHmiEJu7KmzQIFt2M/SdQi3Vefa8kCX2rlvhzype+yfRnfo25TXfjSAMAOgUy1Hm/nJJguU02FdHq3dBnYLRIPvalBRUnB7AnM78kL+isT714Uy6Dstk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194528; c=relaxed/simple;
	bh=qOXXZ9yzVhvLot9OaPgWL6JZb/u48T7roL0N6m+QX/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCkwsrGb+GyzMhhwAyt58WDO+6OqLQ8xUFiBoReU/FFQCud/AO1W9ms1SOS1/pkw/hApDGCdJ9hIFjo3v1waM5poDCOLb1yztghxblr+ZmbuzBWnvUeHgtevYSwChQPtonIxmD2FH4PtuKCwXhGDzkINT5QhNoOkbVxGCubPKhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ck07aEsm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ck07aEsm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C98C2BCB3;
	Tue, 19 May 2026 12:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779194527;
	bh=qOXXZ9yzVhvLot9OaPgWL6JZb/u48T7roL0N6m+QX/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ck07aEsmHU7fV5T5L58xscd4PYfA/P6sM/fjDbaF5ay3tGheBarLbqKt5+JI/2RAF
	 SZgkRqbGTUUa8PHtkuznYcAehX8WHDPVZlWBHeRFEwWuTndHdM2IspE7EchqX+2mQ0
	 ntXidbc7bqSqjXoEEBkIv71cUkcTaaPKXK4KzNrB8NkZeS7tbdrayfRdumIezWHEzE
	 Pa+JWJHAJwhN/RpSq4o6eMZH0jPr8qXd+ySYja/x0ZFjCr5RuLAFPCP9nQtPgkSjzr
	 jAgl7290M+OMhddTFYKPu1hv0SduOiJTrbDdxtpkY9tg85nJXplQbpG90RCfNX6cfw
	 FKtMCxEhc0WPA==
Date: Tue, 19 May 2026 08:42:22 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev, Indu Bhagat
 <ibhagatgnu@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Dylan Hatch
 <dylanbhatch@google.com>
Subject: Re: [PATCH v14 13/19] unwind_user: Enable archs that pass RA in a
 register
Message-ID: <20260519084222.4d34c8b4@gandalf.local.home>
In-Reply-To: <4838400f-209f-4e78-b41f-04b61d129ee7@linux.ibm.com>
References: <20260505121718.3572346-14-jremus@linux.ibm.com>
	<20260505183531.C9EE8C2BCC7@smtp.kernel.org>
	<8761b037-d8f8-4142-9091-cc51d0d19df8@linux.ibm.com>
	<bd711f74-a1f3-4410-975b-64e9009aaf30@linux.ibm.com>
	<20260518123112.20da820b@gandalf.local.home>
	<4838400f-209f-4e78-b41f-04b61d129ee7@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 14:24:34 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> > How can this be triggered? Does it require an architecture to implement
> > only partial sframe to trigger?  
> 
> On x86-64 it can be triggered from user space using forged .sframe that
> incorrectly specifies no fixed RA offset and thus causes the common
> unwind user (sframe) logic to recover RA from the RA register using 
> the dummy unwind_user_get_ra_reg().

OK, so if user space could trigger it via a invalid .sframe, I would do at
most a pr_debug() (may not even need a 'once'), and remove that this task
has an sframe. That is, as soon as a sframe is discovered to be corrupted,
it should be discarded and never used after that.

A print could be done just to inform the admin of what happened. And since
the sframe would be removed, that prevents it from spamming the console, so
the "once" isn't needed. We may want to show it for other applications.

The print should state the comm and pid of the task that failed.

-- Steve
