Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B25B2DAFA9;
	Wed,  6 May 2026 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079963; cv=none; b=IMPCUJjcU7m9ZExABeGml3NUHI/ju/eAXNuMFGc3pYbHpPWPx3b3F1RjSpnh5aupGoUGznmecP5kn4zd6N02nCX7PFhi4lOIqXettoXrrmkGw8pEcXklWP5ova7J3zj45/V40kRbWlF3Ic0vCHjiA1nmvo78INc4oGz5oidfxaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079963; c=relaxed/simple;
	bh=h7ovwbh5DlRDa4YYaPtkLrFaSuVERIz6AHUo+5l3Jiw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sv3pd5D8qoH/2KD2jCSvje7yD06TNLwVTsOaJL/GWWsvwWo+tyVbW3QadzMamFH9IqFt5UxW5YwKfR8zqP77I0mmnZoeDRKNEsSsFrhuAEPVLkVUZ2aCOmt+XSCKxeUAk7qT1PJJbEHLhrzh2R4WVuFDNyxbPr5nqqVa9TaI9LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InidCxzR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InidCxzR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83B5C2BCB0;
	Wed,  6 May 2026 15:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778079963;
	bh=h7ovwbh5DlRDa4YYaPtkLrFaSuVERIz6AHUo+5l3Jiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=InidCxzRIrjNGULdEgBQCG41dn7eFdpPuS/Sr72cIGMHSYW1zKoGCTweajBzOK6YA
	 c7mVOy4Zj8c1KOKOsEJwUdDxzFQLRgKLNsY8+T0nxeMmqMw3417QvjVokf2mECi3wL
	 vpPDPwP+gbL5kC7vQCH+34oUw1Zq+Ltu+R5pGyU/XLCVfPuc9bOeWKTszw/2kOrv/9
	 HDYUwfP2WhdQSab02aLcJ5+90KEcAgVea8NeQ4osb16BemVcQafxQvrXVCW2qEBehp
	 1tBdeOpMxIO78HUwPyP09NL0XOjMBwiH6A+gLUaXlNrctmDyQM6ZdoArLBPiX7NKJk
	 fquu7LwnfijIw==
Date: Wed, 6 May 2026 11:05:57 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, bpf@vger.kernel.org,
 sashiko@lists.linux.dev, Indu Bhagat <ibhagatgnu@gmail.com>
Subject: Re: [PATCH v14 04/19] x86/uaccess: Add unsafe_copy_from_user()
 implementation
Message-ID: <20260506110557.46ee72c3@fedora>
In-Reply-To: <2946bcda-321d-4a17-88f2-02c5137676cf@linux.ibm.com>
References: <20260505121718.3572346-5-jremus@linux.ibm.com>
	<20260505182244.0A151C2BCB4@smtp.kernel.org>
	<2946bcda-321d-4a17-88f2-02c5137676cf@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 16:13:25 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> > Regarding the variable naming in the updated unsafe_copy_to_user() and the
> > new unsafe_copy_from_user() macros, is there a risk of variable shadowing?
> > 
> > The macros declare local variables with very common names, specifically __dst,
> > __src, and __len. If a caller passes an argument that happens to share one of
> > these names, the local variable declaration will shadow the caller's argument.
> > For instance, if a caller passes __len, the initialization size_t __len =
> > (_len); will evaluate the right-hand side as the newly declared uninitialized
> > local variable itself. Could this lead to the loop copying a random length of
> > memory based on stack garbage instead of the intended length? The previous
> > implementation seemed to avoid this by using uniquely prefixed names like
> > __ucu_len.  
> 
> Please advise.

There is an effort to get rid of common variable names in macros that
start with underscores. But honestly, that can be dealt with later, as
it's a problem with other macros in this header.

Feel free to ignore this suggestion.

-- Steve
