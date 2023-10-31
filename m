Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595666133
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 07:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0fBjrX+v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47ECEC433C7;
	Tue, 31 Oct 2023 07:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1698736437;
	bh=ihBb/lVXboH89ob3fZyGIpsnxg/8LJtQ2ZU6SETkzP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0fBjrX+v3BLTMF/B1XAzzm2FKwybRhNhv7r9q7VU8YxkP1maOVznQL62gyyEq/Mdn
	 9SvNJytUhWxQe7AHQXvuiDgkWvQ6HmYYcth2ngtHhfC33QiKlSdHi4axE3vkjt9QVF
	 3Q6CP79SyqK0G8zPKBDqQTALn3y8p5tD2VmftWnk=
Date: Tue, 31 Oct 2023 08:13:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nandhini Rengaraj <nrengaraj@google.com>
Cc: memxor@gmail.com, andrii@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, daniel@iogearbox.net, joannelkoong@gmail.com,
	martin.lau@kernel.org, void@manifault.com
Subject: Re: CVE-2023-39191 - Dynptr fixes - reg.
Message-ID: <2023103120-shakily-recede-3617@gregkh>
References: <20221018135920.726360-1-memxor@gmail.com>
 <20231031070556.400813-1-nrengaraj@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031070556.400813-1-nrengaraj@google.com>

On Tue, Oct 31, 2023 at 07:05:56AM +0000, Nandhini Rengaraj wrote:
> Hi,
> This is marked as a fix for CVE-2023-39191. Does this vulnerability also affect dynptr in stable kernel v6.1? If so, would you please be able to help us backport the fix to stable kernel v6.1?

Have you tried to backport it and tested it properly?  Why require
someone else to do this if you are seeing the issue in the 6.1.y kernel
release?

thanks,

greg k-h
