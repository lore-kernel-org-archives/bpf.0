Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F0118658
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709398562; cv=none; b=N5n+XZqIZl+fZn93/zIaYRH/PH/Ne7dh5sWwyXclHnH6vOOGPT3/PbRV22XS9ErUT5sof857DYIb7KACFGkS0bz4PrafjNoVvjzkWDSFcjMRUtMZ3TYHCTvzJ0SpXPm+oJyDEt6mmz1RJ6Ryo4CxQKGC0L5copMD0eVPW54tpkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709398562; c=relaxed/simple;
	bh=Ls3aDXQFmveWOoilMlzJbUCkg66QOHJ0ghynyPKrNiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDXY6KSw5BU5HSfh+G3LatZEXIjvBKzwAXDVPalQNQBu8qnc68DEwsD6w26nyyioOKgEF2ae+22k9mWVNlFWKSODTir9QooON6et3uMcUWmJsXGH9P1ylgy2I+2QtjZrKP/9c4FWyQ63VME/1CZ1S/Xnxr7JQe47Odc9QjYl8Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UqDzsc4r; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UqDzsc4r"
Message-ID: <a1c433d9-c49f-4a53-b9a3-66794a55fe58@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709398559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ls3aDXQFmveWOoilMlzJbUCkg66QOHJ0ghynyPKrNiY=;
	b=UqDzsc4rOZhZOXS6APymNWR41IvWreTjLvi4FnFwYPrryD88GmEchWgpfb/8ibKWXtpUa2
	1Uah8o9ml2jgnJ98nTz7LsXf5D6gi3kk+YAh5dGZSRIKEzRM/YQibluJFunhPiJHrixL9s
	DHVyYdau3/6OruX5H6SZIDNFEFaZMD0=
Date: Sat, 2 Mar 2024 08:55:51 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] libbpf: Correct debug message in btf__load_vmlinux_btf
Content-Language: en-GB
To: Chen Shen <peterchenshen@gmail.com>, eddyz87@gmail.com, andrii@kernel.org
Cc: bpf@vger.kernel.org
References: <20240302062218.3587-1-peterchenshen@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240302062218.3587-1-peterchenshen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/1/24 10:22 PM, Chen Shen wrote:
> In the function btf__load_vmlinux_btf, the debug message incorrectly
> refers to 'path' instead of 'sysfs_btf_path'.
>
> Signed-off-by: Chen Shen <peterchenshen@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

