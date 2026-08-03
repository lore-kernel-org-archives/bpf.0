Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F24370ADB;
	Mon,  3 Aug 2026 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766016; cv=none; b=iS9JxAt8X7KcZIRw9Xpd6LRSJJFBNcpxDXo7itjHF8NeVFEhA2vTvOBNHI4RKmjTZj/1NMq+z2ZOprsO7i3TfE4eyFP7USZAbGzoFzOvzjOCdwT3Ld9PNoci/TTO2oz2VlRYSUyVXone11Kwb1bxzG9t3zdK9HGhw2AllSmfMRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766016; c=relaxed/simple;
	bh=avGgW2fZtl8cTglM1+kp+JA88zneHl+JKpmiSzxp4qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGyfa+VqxoHdaAyJJxMfTqrIVyZd7Xg0j6bQQ1twcfUgKjAbrj6WeLUMk6BMXjyijuerJoFx0+ksC6OPwAZMYmEqDz58YozKlGVhlTn5Om2wuqXVAgOSNhPixd9VnMQWQdqjs/xNHp6bUiJKQU3RYzj27C9FDkP23eirGCbYfzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcohoShT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcohoShT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6631F000E9;
	Mon,  3 Aug 2026 14:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785766015;
	bh=avGgW2fZtl8cTglM1+kp+JA88zneHl+JKpmiSzxp4qY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BcohoShTlq1ZV5sSnfUJGxtIqC8bX0yrGtwlIbXT4tSYzQ1jI/d28Enk/ymW0ehp3
	 4o0iiuvhdxzUwzSKJEaTJ0Y8eif3B4ANY7UkvfE7Oc4N/dLDhPObFd5dxXyNk6av7t
	 GRk+YV+7WMQAfXG3+3cdhlzaYy5FINEY6LpDwhnZkxOYDAcxkE08jfxqptwgoPfSKF
	 d/cfzniTOxLF1uc55IGAk5KxaPt/u+8JUMPvko+FguvdtXoAcJ9lamRdEkPKmrpHct
	 JIh22myhkN2+7iZ7dfuGI0QfOGLDPZqVt3YfvWCTHU87ng2je/UtMHbtzZ3Tdzc2JR
	 Juuk5sYq4XUGQ==
Date: Mon, 3 Aug 2026 16:06:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH 3/3] binfmt_misc: document the pre-opened interpreter
 limit
Message-ID: <20260803-fankurve-zielen-sehen-8fac60d616ec@brauner>
References: <20260803-work-binfmt_misc-interplimit-v1-0-4a2435500bd9@kernel.org>
 <20260803-work-binfmt_misc-interplimit-v1-3-4a2435500bd9@kernel.org>
 <20260803121843.BBABD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260803121843.BBABD1F000E9@smtp.kernel.org>

> which seems to have been dropped during the rewording of the limit behavior.

Intentional.
