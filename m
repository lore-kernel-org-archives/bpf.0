Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFC93FADE4;
	Wed,  6 May 2026 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082057; cv=none; b=V242A4FPOSBnnkbz7t7Kq7sPoCMcGDoopop7yiVUZ/fls3x/AWyr3dnDobrA1tBHifOZOc6Ne99ICVdzYOslZyCEf0Sq1FWaVmVNT8evuwLxhDZvKgpOdK5kNlKw5gO1OpT9/d2RhA5x72nfXvMRpJiNAYjyPCXSsFGqBeowJwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082057; c=relaxed/simple;
	bh=dlxLmgGb8nCdwOSRTyhXedJPsGlePb0Qp3dxWpwgRq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjgZTUjrSGPioyNxXqyjmc745WiibLuq+nTNvjWA98f0t/aUHNhCXxhsyLYU2R/7V2bJZcPUg+sWvQp/Kez3tL8lJ16BhDbnpdRJKWY46LdT0fGB87kwy88pNU40UrMKraxjGnx7Owu9ZLjgKymOCoLUqU1lVsQrMV85u23zaRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeIttpqB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeIttpqB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F745C2BCB0;
	Wed,  6 May 2026 15:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778082055;
	bh=dlxLmgGb8nCdwOSRTyhXedJPsGlePb0Qp3dxWpwgRq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KeIttpqBcx9U8me3tfGHREl+p6fDNAswSYhQmzIeRELU0kQmHqx+QtShwEXG/VP8v
	 srDwTysUpOI6YAVLOpIPThz18zsd5tsIN3Hf/7hR8sBAOWaXgGaT9JkB/9/Wx7olvr
	 1UED8k4efZaF0T6480C4XebSuuNqf+b/kCAhQx2HHnyi77M4e983I7RFiq8vANWLWx
	 kAss0mZv10Tpx1QcYPjZH/tGft4c/QgVOVtEF2ossQ293lRvqvyZDOvvmkQCdE4Qqa
	 Cy+o+hKYLg8RGfdkTtHkZD4n4QUuffC3KQEpu9jloUuGonMMEt+Xyxv+OrCl2ZC4Fb
	 LE+hZWjg7kM7g==
Date: Wed, 6 May 2026 11:40:50 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, bpf@vger.kernel.org,
 sashiko@lists.linux.dev, Indu Bhagat <ibhagatgnu@gmail.com>
Subject: Re: [PATCH v14 08/19] unwind_user: Stop when reaching an outermost
 frame
Message-ID: <20260506114050.5497b61e@fedora>
In-Reply-To: <05f795f1-0c04-4b49-9051-beb6c146991f@linux.ibm.com>
References: <20260505121718.3572346-9-jremus@linux.ibm.com>
	<20260505124034.B339EC2BCB4@smtp.kernel.org>
	<05f795f1-0c04-4b49-9051-beb6c146991f@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 17:01:17 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> > I note that this is fixed later in the series by the commit
> > "unwind_user/sframe: Add support for outermost frame indication", but
> > introducing the uninitialized read in this commit could break kernel
> > bisectability.  
> 
> Or should I merge this and the following commit into one?  Or disregard?

Sframe isn't even able to be enabled yet in the series here, thus
bisection should not be a problem. The only issues with bisections we
need to worry about before sframes are enabled, is compiler errors.
That is, every patch should be able to be built.

In other words, you can safely disregard it.

-- Steve
