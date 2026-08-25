Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4923F9A04
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787655619; cv=none; b=btcJNyo/+lQROpKpLCUZV1PGgYNBg3dOsxrFztb+Rhgd/CVtrh71T5IUTP3vLb5tPtaAYZvPqEc1jWXHfhf1duKq17G/d4njQ2Ncx087oDmXyI8HJntaQkW13EfuWkdLbT3a8jwR/k27cdRAgFqnU8VrkWxfUJnCeo1NGEp5J0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787655619; c=relaxed/simple;
	bh=5kMey8NK9KqCWl/6jlWc6c4AggQEi5YfxR/B5tENa00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvP4HARlbYNUdcfZRqsnf/pQmOOOKSZI99WwrodqDmpa0CJSyiOyOtiofOqTQFiEkHxTssuVZToA5zyT6Lx7TG3GKTWliO7a5LSAl1XdzlZydXh43Ag2ymvXNlE/jQ2zz+v090vm82O0td1AFNimi91fI8NSeUdPN43uXWypHEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jl7FyPrU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jl7FyPrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6251F000E9;
	Tue, 25 Aug 2026 11:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787655617;
	bh=5kMey8NK9KqCWl/6jlWc6c4AggQEi5YfxR/B5tENa00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jl7FyPrU2zhvdvDNbGFJ6ZH+ha+tpUfj2zNSpRJaVuB+7PI1EtXzoDHe5p28n1jdz
	 SESln0QX76Ym9YwhMnvOc6KiIS/iju4vQUWBhd14AW9EfQIAz0tmDcv67VD3nv9T43
	 wTX1DC++FjC7xqjLMQZjqssAnr5CN+ZlEYWU0gyg=
Date: Tue, 25 Aug 2026 10:43:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: gandalf 4a <baksmali404@gmail.com>
Cc: security@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, andrii@kernel.org
Subject: Re: [SECURITY] KASAN global-out-of-bounds in BPF disassembler
 (bpf_ldsx_string, kernel 6.4+)
Message-ID: <2026082510-splashed-spoken-31a4@gregkh>
References: <CAOHg6aBPdesARUtOwR9NbsWT77L+GqTmfLGsdAQ=hf1YAGOitg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOHg6aBPdesARUtOwR9NbsWT77L+GqTmfLGsdAQ=hf1YAGOitg@mail.gmail.com>

On Tue, Aug 25, 2026 at 04:37:48PM +0800, gandalf 4a wrote:
> Hi,
> I am writing to report a KASAN-detected global-out-of-bounds read
> vulnerability in the BPF disassembler that affects Linux kernel v6.4
> and later (all versions with BPF_MEMSX support). I have attached a
> minimal C reproducer and a one-line fix patch.

As this requires root access, just post the patch normally, in non-html
format, to the bpf list, with a real name for author and signed-off-by:
and the maintainers will be glad to review it like any other normal
patch.

thanks,

greg k-h
