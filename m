Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C3F353A9F
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 04:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791780810; cv=none; b=o5emqUOaS7zGiNB3t9Bf7ipFpVkC6jVbbnqtpDtfWrfva0RBeCwXG4RSm0ewwY4D9xfI4n1gOt7OsmbxgBy62LE+xUTu2a2fteA8DcflaWC/XKjsgIUOcseMSXWacz+7aRxwqAtCYlGaTw23DNu7dNjaOJkHliUJAW5Z0uyenc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791780810; c=relaxed/simple;
	bh=+zV7sFiMSvN0UbgFYqMAE/i3qFVYLZt2GxL4VcuKrGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLwFbajC7kg+hUJ58vT4wts4zPznf3C5xJMiw7oVTlVzAOsdRWtfq7TLsid5ngxKV1baJ6Qcuu0derBMiPCoyP4LR8GX+vgSbE03xEYUoMscjFXQHgcu16mGwp1bFUADFG7qnZOpRbAdb3HUYcjUgfwxMc7ZS4rVyYRPcSCzwMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D84sYLaR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D84sYLaR"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2dd76b1361dso8393195ad.1
        for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 21:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791780808; x=1792385608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q+hTqAW+4rixFX4ZbUNxn8AzXmHJNOSXE7y5h2vkHY8=;
        b=D84sYLaR4YuGJ3Tl+CCeHEOrE/swfnapvDTcgX/UlfMyrMB9l5Od1taZsXL0YYbE9W
         AA1bZaJuZ2l1tvvTcbzDsUBOa0vdQWoRWD8xs0u9G2kU+3CxN/sKFzeU0UVxOO7MssXh
         1dsj+HXLnPChNW5S7Zc8kkv2u0XMmZ1lFP2rhhAT9MMqE9tHmyLjyO9vmaOgtGIT6Rim
         KbN5YeG9UyVbejodzFAn8XNp+HHjxQTt/J5tHamoaiK0GQV4dlHAvmAPsCgvDBZA6bHN
         xPfh1kb/LoDqfvSc8RBRPCW+qYT05RptmKrRjb7Vgxp4POx8s6FD35EIyF0oFm6lH+Kj
         T02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791780808; x=1792385608;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q+hTqAW+4rixFX4ZbUNxn8AzXmHJNOSXE7y5h2vkHY8=;
        b=JrH/y0myRx1sgeQblj/qmfF+qr/6s+A9BL4C+LXkNhfe+bFXoGOTnYq5PqyuaHCEHC
         6iwwRLKZhHlWQtMD4OGQ7J9uDhynVA2/mW98ZQAnbl+l26vls1R3r9Pq7FXcUqRy3Qws
         1RxHgRVuF9i0fyUX82lt1kKu/Tk3BoUCfEZmZ+IAyRVqHZhoMqCUXFzUUT/KsFqj5E/T
         jRPLZOAIM9xlryrKBTEX9IuDEHVaYNfDrttQ6KCJQZlvVffZt9PEBGo3bJPeCPBI0cgj
         w4TaQQDTFgYRBmHXGQKrhU2KBFADRkoVtnGNhNHOpR00Au9/0k8hI648cJ2re85S0Ec5
         /gCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxvENvB0RmA08T1aS3aRfmL805cnNCvT9sZ+NHnftO86O1NFhQA6GICE21WkSE9YCAJZtM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJenpojTG8GfsO5IHk/xC2w2JfmIF5Q+vjVoJfoTsX247YdnSkG
	KSHMA1Wu4FFy+cXZFooHlAAPHQ9uHsJNGe9ldOF5Lkd3zUHnyEO9LPXH
X-Gm-Gg: AYBFou3W/TB8vY4S/jLxU0mK2Cb8XeXViJlyYtSDUpmrpy7oUubx8OtPip+8KsMJ84s
	YdWVgCgkZHIVraS3/NMRvnCqZlG55nxIyihD0cxt7aRF/hponnXNlTVu5zBSP8RNsDLD4xFT+oM
	3LQq3gvVbamuXVmu58h+xGAZxGKzZEYsyHKfBByl/cpmYPlPSQpe9jVV+fSZd7Q2UiY3u0QFJ39
	ig/FstquvWGVj1Z9zcQjDP8YlGo+CXuXkDmmw86ZIGx3UHnDQ2XjYVBe1z6zYt4rrBmavZgOV5b
	ejdTmG0H6E6BFZ+vtlio3gyoW5IAm8cvwMPY4uUJCRVVl/fSIUH5PAKnOPzFEcyvWLPU4svTRiL
	3s8jivg5SuaKVRcho889Kc+yqPT/aRDERYUJlqOtW08s3z71AvU+CFCKTcnmu/9GS4IXS6kajr5
	5JXV6yCOTJrJJtd7+5fT3XgHSYhWq/54smR7v4oyhhy/i9LLfndHijFIqHU05Geu/APACECBg=
X-Received: by 2002:a17:902:d50a:b0:2e6:943:39df with SMTP id d9443c01a7336-2e842bc7e0bmr68793605ad.25.1791780808097;
        Sun, 11 Oct 2026 21:53:28 -0700 (PDT)
Received: from gmail.com ([2a03:2880:7ff:5b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cb6sm38358745ad.60.2026.10.11.21.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 21:53:27 -0700 (PDT)
Date: Sun, 11 Oct 2026 21:53:10 -0700
From: Narcisa Vasile <narcisav.kernel@gmail.com>
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shuah@kernel.org, toke@toke.dk,
	lorenzo@kernel.org, hawk@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: [PATCH net-next] selftests: net: veth: test own ndo-xmit after
 peer GRO toggle while down
Message-ID: <asxntk6HV+jmAlKe@gmail.com>
References: <20261010192914.83651-1-tianyi@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010192914.83651-1-tianyi@cloudflare.com>

On Sat, Oct 10, 2026 at 08:29:14PM +0100, Tianyi Gao wrote:
> Test that a veth device advertises ndo-xmit when GRO is enabled on its
> peer while both are down and only the device is brought up.
> 
> Commit 7a6102aa6df0 ("veth: Update XDP feature set when bringing up
> device") made veth_open() set the flag in this case, and selftests were
> requested in its review [1].
> 
> The block now ends with GRO enabled while the peer is down, so the
> aggregation check that follows covers NAPI enabled by veth_open() again.
> Commit c017800af5c7 ("selftests: net: veth: test peer ndo-xmit after GRO
> toggle while down") had moved it to veth_set_features() [2].
> 
> Link: https://lore.kernel.org/all/155aabf8b873bb8cdcafbd6139c42b08513e5fe6.camel@redhat.com/ [1]
> Link: https://lore.kernel.org/all/179165459278.434549.1711113374323842550@kernel.org/ [2]
> Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
> ---
Reviewed-by: Narcisa Vasile <narcisav.kernel@gmail.com>
