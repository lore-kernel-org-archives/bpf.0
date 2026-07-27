Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5011D233949
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 04:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785127906; cv=none; b=oErvudj5LUkjJjbf9G6jIraDqjonb/5uGibygTTAwroVftSc0Jfqt8WImcG/e2k47r+5lq+gHr86wHxnaAfqxt7I8IKoYNOKKYPS+54Ch4bI3w0oVeRfFfDBbIUiRPi+NgjTqg6wNyVm+gt/SQ5Pnr/dTaqik9/U4AjJRrlXFqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785127906; c=relaxed/simple;
	bh=Xx4jV0rum8vU53Dy+ZPhTgbMrD3HKy9fM4hdnsWrXUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FT/7lwFsiAC/Bd74sbGZOuWU2CF+num+7g51H3q2YqztFELekYrcSar5caXfgGl07SyK3KbHQl6XWFyaDsTIJX3v9q0icEiXCMI1PTxT//nEEhDH1ysEF/aUs/hoaBetQa2s91XD0qPbzdXAmNULWWIY1ahDWWlvJnGSwPuU3UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=OZYmifP6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b9//d64q; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="OZYmifP6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b9//d64q"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0CEF37A0044;
	Mon, 27 Jul 2026 00:51:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 27 Jul 2026 00:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785127903; x=1785214303; bh=tTkdT0xF4A
	G2OH9kWh2RwMmtPvwl0+Wiu/K4nKfY9Ac=; b=OZYmifP6GtIakx0jFWAAUOgfpS
	k8WSUbC0a0+02huP/YXV1/PFAeEUZFqpmm8qfMAAgeSYjgPEF6ZHTI9W7HRh2TaE
	WfqHkwHybJUXNLwBKh13s2/k4i35Cd6IVV9Xbq1o7HqxQEtx9FGkbiKny3NMD2bO
	JKnV0bNsBIqsq7XqChTBl1Qcb0Qeqeoerxq7CGgs5mXFVc0JWv2O0S7AkzdHEWCS
	Tx6Q1AFcJCnJbM9iu6nuHCDmwXaN9sn+DUKTC0uJCERi+MDME9Nggy9vnAwseFbn
	vbfmnX9Pgap4ZboEOKGaF1vEKYbnpV3jsRb0O9IAKa0cFcp4UZezH4cFutBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785127903; x=1785214303; bh=tTkdT0xF4AG2OH9kWh2RwMmtPvwl0+Wiu/K
	4nKfY9Ac=; b=b9//d64qNA+2Cqt2oNFcDQu4zdrg4CDGVVqPKLb2XFmyumRVPJp
	F3tcFtgVjcfRiovFyIda524SfTFRUUcLQ4Zuq7XKQMlGdWCVGoMiKUkYcJjkd4+A
	RANnEhBL5owRPG5BeZi7e8eZjkTdIciwQvF5XFILxKrwFuR82xUSSKSASIrrNFKd
	4AC1S6Ib+tq6IpMZe8U6SWNoziVQYuBKDrUskNZNMXDeYalfLh4xgsf29sbDDDOb
	uE8Bol70zUd6UUfwfXRMgbibhjGh2IKQOuoe/4SrCnwfnHLzluEqMcJ7XkyWllTw
	2NTHYpBeZtA12yX/F98sGTUC7K8ydbSV+Dg==
X-ME-Sender: <xms:3-NmasZvfHv97PxnlkTKAs6QyhIOpyidWZcsTWHiYMLcQdHfB5y-Tg>
    <xme:3-NmajU6NGg9QfNLmTwAwR46YGikp7A1E8jb4HZcLCOtj0WhxJxU6wpmkxnhYsONp
    orvXT4UDqGKBIZVFqzlczQKQ-alC1acAh6f_8xB6B3jA4aXTQ>
X-ME-Received: <xmr:3-NmatECRqylpr5U9L2gqFdMFoeMFGh_ELWPgiBvteQF9BDP-KHyJ0VJVwZT_c_jUTG6y3J5U4f6gqknTK_C3_Bkrw>
X-ME-Proxy-Cause: dmFkZTFxeilg9ubKwvjSqKnFAmLcNMtXncN/7+yebJi3u7zbmlqNOGN1JOB5Tkuj/2k9aw
    CH/pIiN9hUCaqTnv6Kr//ppdOFWPwImXKph8+oK0YAZCtriPrCvbnYgdmyWn+iQqsv/mTi
    gkNIYZ/BlIHOVX1XThLY0m0Vk4r7CDBNfCRbthiKSDcLfy6IhepnRfQxOZEfsAFG2hB91F
    wyTfdm981oz9aiXyHtSQad6X+7PP7iPa4um7AQVTq57S7br1ooTBlFJvo8G/NTwWjjjByG
    y/W53KXB99CP078l+b2Gy9eGLAFi/45Fk9qBTPdLjYE8JvSX+kGEwg3ZI2asqDospp+WZq
    wWmwCP+WnGFQbmLxg8g0VcohBLeoEBt/Rvwzj9m09PR0QItr3605kCltcO7ayHNkcXY5/l
    3nQA3XCaFzxk7gNAoI0sAL04FPDPZvtBaveYQffrT9Win9F1RSJHoGmahoxi/lHE0SHhkX
    NkKB4xOUzhEzA2aahLV3jvXDx5nKdx4IAUiEalpRBvTUey3u5+oe+2A46bKl4NfbMa+9/I
    vgDqz8n6ximuHTx8+R6D5i2IrdDJswY9DQ/Fu65kwPkCpAR+/vBGge0vEUFOozb0+FOD0F
    uJDzLdsnKRv/TzmMTfvHOf1MeKJ4FPiYZdB9bN0dGtYCS3E268Ezr/yMuOtg
X-ME-Proxy: <xmx:3-NmatDRqDkrW_eVV0JCSSSyKFT0VLz6m1sMMnYJ3nYNALYZnbe-kA>
    <xmx:3-Nmalzo4RFA8vKh1zTLlpso9N93zp8QQgq8lWS7VTNRtFSaI3zjzg>
    <xmx:3-NmauAy6y1-uImr1CVJL1GUBYBQpRbUaQr1TJizYXIX4Aw5xEoJUQ>
    <xmx:3-NmauAI-U0_ZxBab5R8idK9yvnKp9viLM-uzhQdlzrB599ar9_QHg>
    <xmx:3-NmauvFlmUmVYdUni7Kfl3jjHJqzIcs5bBloiqM9yuVNWfyUidQGrD_>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 00:51:43 -0400 (EDT)
Date: Mon, 27 Jul 2026 06:50:18 +0200
From: Greg KH <greg@kroah.com>
To: Ning Ding <dingning04@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	martin.lau@linux.dev, davem@davemloft.net
Subject: Re: [PATCH bpf v2 2/2] bpf: Reject untrusted pointers in
 refcount_acquire
Message-ID: <2026072707-each-relieving-4f72@gregkh>
References: <20260726235030.1152542-1-dingning04@gmail.com>
 <20260726235030.1152542-3-dingning04@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726235030.1152542-3-dingning04@gmail.com>

On Sun, Jul 26, 2026 at 04:50:30PM -0700, Ning Ding wrote:
> After bpf_rcu_read_unlock(), a refcounted map kptr is marked
> PTR_UNTRUSTED because it is no longer protected by RCU. The
> refcounted-kptr argument check ignores PTR_UNTRUSTED and still allows
> bpf_refcount_acquire() on that pointer.
> 
> However, if another thread removes the object and drops its last reference, the
> stale address can later be reused for another refcounted object. A
> CAP_BPF-only reproducer observed bpf_refcount_acquire() returning
> non-NULL through such a stale pointer.
> 
> Reject PTR_UNTRUSTED refcounted-kptr arguments and add a regression
> test.
> 
> Fixes: 7c50b1cb76ac ("bpf: Add bpf_refcount_acquire kfunc")
> Reported-by: sashiko-bot@kernel.org
> Link: https://lore.kernel.org/r/20260726021304.97ED91F000E9@smtp.kernel.org
> Assisted-by: Codex:gpt-5
> Signed-off-by: Ning Ding <dingning04@gmail.com>
> ---
>  kernel/bpf/verifier.c                         |  5 ++++
>  .../bpf/progs/refcounted_kptr_fail.c          | 27 +++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
