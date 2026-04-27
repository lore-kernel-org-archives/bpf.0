Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2523CB2F0
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297391; cv=none; b=hhtF7mXKuPwuvzWOga3Qe5GqRLHj368+LHr+Wb3kRwT8wZoLU3YmzXyM31UwBn/5tgntyqZYqLSzvZLRPJbZ1NM63OMsvlnQuQ17tSLA1hzahU0Kt+cX6hQviwEIyQvtuaaR8LZOZgHL0qNHXBJH/3yqzY0FkuSEKOLHGo1jdTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297391; c=relaxed/simple;
	bh=DqIccDUEqkT+S61ET1aKsMoj8zwoWWNFtRI4HdFOBNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pr40SCihQ4hygT5SiGK2/cYH0Fp++OX6B4fKC79eMkm0HcqhZfOObR32Kv3Nm0RAdOtAvn2ro76xM4nBgXXE6PWtZQnmCQI49/ZuyoYOJY61B0OHwgUqfn7ufsWSzupZfm8lc3BmUpQxPoivcpKDBBb96VtgFyR+sYAypmMN4os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oGxfSQzB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oGxfSQzB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B551C19425;
	Mon, 27 Apr 2026 13:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777297391;
	bh=DqIccDUEqkT+S61ET1aKsMoj8zwoWWNFtRI4HdFOBNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGxfSQzBA1TqS8TKTnfripieYZqh1lvHAMttHaN8GJkLHtYm7f/pRPO2anBEXjVLr
	 2Nhrvrc1rFNKNAYdwh9bpMluSJu3Dw+tfySnn5PGM0q/bFGjvO7aYdKOEKa59cqQcI
	 mVDxzVGHeUVmgQrxqHMGul0QYw4Avfk8LsZUKe8I=
Date: Mon, 27 Apr 2026 07:42:36 -0600
From: Greg KH <gregkh@linuxfoundation.org>
To: "Xavier Brouckaert (xabrouck)" <xabrouck@cisco.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"security@kernel.org" <security@kernel.org>
Subject: Re: BPF: writable uprobe pt_regs context bypasses lockdown=integrity
Message-ID: <2026042709-rush-unaligned-ba8d@gregkh>
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
> Summary

<snip>

When sending stuff to a public list, there's no need to cc: security@k.o
as that's a private list for security fixes only.

thanks,

greg k-h
