Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27233CCA1F
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297450; cv=none; b=VC+avDFaKkzXW0Wn6LtrKS4d5uMj8n3KUGBwcrFb6Z4kcOEzlCHGZafc+xOcWfEuJa0k80QqBS8Y3E8dNbFRQuRKIhACQQbMABQUUj3e+98/F38rVVRlPSvBvB9JP5jFCu0RAghAD13X/DHXrU41ZInXHeYRZiKTPbxz1+Pn/Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297450; c=relaxed/simple;
	bh=6OM4mktb2etLivZNItVXNbXsC8ty9GIqXGMZlMVxJF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtzmlEGv/KDmiIBef1tcduEYx+KMLx3i1En6PqKjMEl72Aegpgr9IJnzbe7hylIEAPFmOQCWq/ReyS/emHplfHLTiHCEQ4of1iCUiz6RFYOnKTctYZiHcLgv8CAa2PXt82mY/DU4guyBntRpqO0ASqpm8nkQIvTf5kyleQ4r/VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r+UyB9iB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r+UyB9iB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9238C19425;
	Mon, 27 Apr 2026 13:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777297450;
	bh=6OM4mktb2etLivZNItVXNbXsC8ty9GIqXGMZlMVxJF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r+UyB9iB1RX8MAJoLcGFUQ6YBcB9BapK/v/Jx6Wup74k+eQCMJF3GTm1XlpAnaW1N
	 VEkK/7RQJvIeDEh8ALwF4QyZsL02iFzHLbwQGjO/xK6fRp0//1FFBCw07Cz6oeICw3
	 Qti4hvJcrXFz70mmciqN7MT4mGuZl+xGRNEjJn8o=
Date: Mon, 27 Apr 2026 07:43:34 -0600
From: Greg KH <gregkh@linuxfoundation.org>
To: "Xavier Brouckaert (xabrouck)" <xabrouck@cisco.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"security@kernel.org" <security@kernel.org>
Subject: Re: BPF: writable uprobe pt_regs context bypasses lockdown=integrity
Message-ID: <2026042745-washed-effort-3dbb@gregkh>
References: <DM6PR11MB4722C282C0F20BB23F54A87ADB362@DM6PR11MB4722.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4722C282C0F20BB23F54A87ADB362@DM6PR11MB4722.namprd11.prod.outlook.com>

On Mon, Apr 27, 2026 at 12:39:33PM +0000, Xavier Brouckaert (xabrouck) wrote:
> Suggested fix
> -------------
> Gate writable kprobe/uprobe context behind security_locked_down() at
> the point the verifier permits the store. Two reasonable shapes:
> 
> (a) In kprobe_prog_is_valid_access() (kernel/trace/bpf_trace.c),
>     when type == BPF_WRITE, call
>     security_locked_down(LOCKDOWN_BPF_WRITE_USER) and return false
>     if denied. This reuses the existing reason and matches the
>     intent ("BPF writing to user state"). One line, adjacent to the
>     kprobe_write_ctx flag set.
> 
> (b) Introduce a dedicated LOCKDOWN_BPF_WRITE_REGS reason at
>     LOCKDOWN_INTEGRITY_MAX scope, for clearer audit messages, and
>     check it in the same place.
> 
> Either way the check belongs at verify/load time rather than attach
> time, so the program is refused outright rather than attaching as a
> no-op.
> 
> Orthogonally, a CONFIG_BPF_UPROBE_OVERRIDE knob (mirroring
> CONFIG_BPF_KPROBE_OVERRIDE for bpf_override_return) would let
> distributions opt out independent of lockdown.

Please provide patches for this report if you wish to see it addressed.
LOCKDOWN is "funny" in that only a very small subset of users care about
it.

thanks,

greg k-h
