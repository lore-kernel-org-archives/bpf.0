Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFDD4F4729;
	Mon, 19 Oct 2026 13:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415782; cv=none; b=f0mJQmaZz0/qmcsUqbyQMTLWqYrhdiiu/WWV0TO5snJzY5joJNFt0NoVaGDhIA1/JBBpCKfye2rBdP9ofDSaxKGkzyahpgO2IKMy/hSIHPTbvrzyHDNzFgg07YImpdSqd4OXp+d3U/ezJeKXV0cSuOQP/4xZoanofR5joA8sfxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415782; c=relaxed/simple;
	bh=UYZkjscYlvJrGL4MOMQy1TLF67ANDmMiNKFbA4lDxIE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFWsi8iFGhdaka/Du2JhWXJSWAijgxyMmIRq9dsP3CwL6N6nEawPPBfYz+yM04N+owc5b8Z5iE/h6229k41wWxjnBSakbND73OfJfif15i7b8ul1DSdvqvOTg3arV4f+PI2TizGF1dXsPQOKp1lIjqqe9lDuw8BIzaj1pkx9wVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=2G21fCwk; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="2G21fCwk"
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 5AD80A06F2;
	Mon, 19 Oct 2026 13:16:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 28CC318;
	Mon, 19 Oct 2026 13:16:10 +0000 (UTC)
Date: Mon, 19 Oct 2026 09:16:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Nam Cao
 <namcao@linutronix.de>, Wen Yang <wen.yang@linux.dev>, Tobias Schaffner
 <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
Message-ID: <20261019091608.1990a4e6@gandalf.local.home>
In-Reply-To: <87y0buox9f.fsf@jogness.linutronix.de>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	<20261001152042.124445-11-gmonaco@redhat.com>
	<DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
	<b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
	<DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
	<878q3xtptq.fsf@jogness.linutronix.de>
	<8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
	<87bj8s8ih9.fsf@jogness.linutronix.de>
	<DM78SVMBI2XW.2XHVC67VON48A@gmail.com>
	<87v770uuyr.fsf@jogness.linutronix.de>
	<DM7I2PYHNKXE.3AYY3N1HATXLW@gmail.com>
	<87ik2zryzo.fsf@jogness.linutronix.de>
	<0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com>
	<87y0buox9f.fsf@jogness.linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 28CC318
X-Stat-Signature: yftfmptywaia8souzeyih17qrpida7ya
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+ggX8o75464mCS2UhdC/fNpXOAJBDjlbU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=UYZkjscYlvJrGL4MOMQy1TLF67ANDmMiNKFbA4lDxIE=; b=2G21fCwky4/3zlULfLr0aYCywU6uIi8qghOo5x8GCvD/BRBRI3JFIwfKH6HL7d7U6+MRM6uiVU+dYrufmYb72/OhiiqQRNAYS9kzasGtECrz8I69igN/oYFS3itXswxN97AJ9Fj4hjsUpy2YGqSQmPMprXwO33CUv5zanZEa9Xo=
X-HE-Tag: 1792415770-775354
X-HE-Meta: U2FsdGVkX18YuBIW56dm9fcfes23Ts79xS5MsyNGez3UFo8VOR4SYVkbP07eYHZj2Mcn/sCYO3R69YS/2W2GaTgUIhHUe/jkbxHLri4a/8s16RHKgMnm0o7SXAF/NFv+KMTrj3fubNzGimV9SFsr8/KzX69Mq1RyV14AMHts8k15E1ZkYWtOBtaSMJ3p+ytUkDywjmnqIQPRNBqdc/+veO8ryNRAXmYjNJXqSszzwVRnQYWBUDeRGgGN+kBTfrEVoQkRXMrpEqchFkHzs5b0kwp7nFO/Y0HsurhrDDsBeDQ9A9xi5TJlxvDH2GTuAwdT

On Mon, 19 Oct 2026 11:33:56 +0206
John Ogness <john.ogness@linutronix.de> wrote:

> Are these trace_printk's available without getting the scary kernel
> warning when kernel code uses trace_printk()? We do want RV support to
> be enabled in production kernels.

Note that if internal tooling uses their own trace instance, there's a
trace_array_printk() that takes the instance as a parameter and acts just
like trace_printk(). The difference is that it cannot be used for the top
level instance and it doesn't cause any scary kernel messages.

-- Steve
