Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB67335555;
	Tue, 21 Jul 2026 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648748; cv=none; b=JQ4NGdAV/9t2dm0yOP81aV/8h8pMheii0PdhN/7Ow6QCAkDiZsM54X1ktjFBZIxTuN5JtYbZQF+uwHW+zbIfmk3au3pGe6xQe7vqdUCz6w1u0nRTIs6EoyO/DImfN5lgZCqb1rrp6Zm2A8K2td/8MrmIF6rVKb98TvLPPT80g9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648748; c=relaxed/simple;
	bh=qnNzO664jyPsGf8GvrzcxD0p/uKH+lZrfh9TZOo8J14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsQgOIVcKVDQ3QLQzDtYmBNPt9gHPbs7m+MGoM4tHXUv5AS6Ti9jrvlFq7wqDzThCY5cbodN5AMTs8Qizu7kmMKZu+tBJDCSvbZ5h+qwl8lKcJC9V6tbRhb/fLb9JCX3XBVoA5+eVI8Sf6Ek9j3PXRfQHf/wHZ7iVmAWu3ieOjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BV9d6Ono; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BV9d6Ono"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03AE11F00A3A;
	Tue, 21 Jul 2026 15:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784648747;
	bh=qnNzO664jyPsGf8GvrzcxD0p/uKH+lZrfh9TZOo8J14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BV9d6OnogsZEeS3/hAkdX46oxO3DDEoDO2qFQ69A8LwYfy4HSdZVBvppewVRPrBIC
	 /ltRndxnASjGRL/gWPnejXsR6oY86MWuvX72rYIsmXe5+/j+6llue1EZkj/BvoIzfc
	 +23tIMzjCzEwvKH6VU6NQ7fKmf8XDgp0JfNmCyPDmxWu+wOrpRfQV61NfJrxhK0drp
	 mAf1ejWvFW+WFu3EtzKPxfDwsJXYqtTRo93bG1L5WfZk/CZA6M32InRuE1mfjjpsrY
	 F2uzqv0D2Nthet34+KDT6u/+BPFEbcV1YVWLvG1sB9y1rO3a+O2dFvFYXhi3u4AvSb
	 kptDDOjI4iHgQ==
Date: Tue, 21 Jul 2026 17:45:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v2 10/21] binfmt_misc: add transparent interpreter
 dispatch
Message-ID: <20260721-weltweit-feind-aufrechnung-e8468bb1c56d@brauner>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
 <20260721-work-bpf-binfmt_misc-ptinterp-v2-10-e57866e4ae0f@kernel.org>
 <20260721143156.0F3E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260721143156.0F3E71F000E9@smtp.kernel.org>

> If the transparent loader happens to be a script, won't binfmt_script consume
> this updated bprm->interp and modify argv by replacing the original argv[0]
> with the loader script's path? Does this break the untouched argv promise for
> script loaders during transparent execution?

Yeah, but that's binfmt_script's whole job. The point is that
binfmt_misc doesn't touch argv, not that binfmt_script doesn't.
