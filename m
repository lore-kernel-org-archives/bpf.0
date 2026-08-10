Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7038C437864
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786387927; cv=none; b=RRAeJEbmhmcnRMl9Xj8z8nDNINu4/2nFI1BI/Ai7qfNM0gJvNxHyNJ2aRInLysVJO1vU20117TcYgmMPbETKv+i+Fbzp6berlJBNtbRv6ztuTpQmyF3fis3X8wRRqLTNPF2/U0rplC4454DgHoAjPM5cYX2AsSAcjYHLpJ2jjII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786387927; c=relaxed/simple;
	bh=dMiO4dOD/vIiMeabHVo0bAzr5ifDt0MEbglqo/V5daQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4GVXQ6HMbOavUbgnfMrneoJCixloy0QiFtG7mbB+uZExWNcrsOs0hWo7cifbZjX204byw2zY+WUCavyKgYxJiUD3oI6ggmbORTomqoZKoQ3PdU3AspQwoODeDYiFpfOC7Qo6Z1avE5giKW+01KLglvPviy8qJXS9tUoplg5OXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqgSrocS; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqgSrocS"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-c96739a46acso1137539a12.1
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 11:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786387926; x=1786992726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l3aQ3yKkswTs7S/iYzRYJHZ1Z5dQCtJeegu/4/CsFd8=;
        b=MqgSrocSaUowH2gjxBr3netAVwSMrI7Y5fWNlfPyDbKyU3Zt3TUFLgNEGm9fBchld+
         yEDMnSn6dXAZRToOExw98d25lzrKILAH9CYR+pGW/lfkXBAqv0EzxYu3xKrNhkU8FEiU
         k3Muzt2Gx8XiQfyW2sbJyMtmrAAAqm0m6ek+Gk3No4ueOQwD+eLpo+bD2Zl5JiDa79NZ
         KAiz5dvwC0w9pMUVR45fMf4AFxWfF/iE1inp47Q6B8jFp+/82N93D510xX7+B9NsmHmr
         06OscIhFWILFBmWuQG5DuNlM7cO62XjT/0Hfh40GWt2SQWGs2Y/p4/df/xEj+n40bSTn
         1FfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786387926; x=1786992726;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l3aQ3yKkswTs7S/iYzRYJHZ1Z5dQCtJeegu/4/CsFd8=;
        b=R2OznTn5NGZRtOf1XiIyBoWS/S5SGTNU3ar699+dNmqllud+zTlmwFLZZGqa+80nIG
         9Z9mJ//VBDZca/HfIYtXuxTEZ+FG0/WHrRe3XNtxHA6x/AaUk4J858eZ146s1Riv3cJr
         hTekGsOrjew7DMxUiSj+/ANRpNctYIdW0PpUfqZTYUbmgooxyPUJNzW2Leew7/voSWgW
         0jhkYr15+0KW5+e/q0zUTB5jnWUFRZ2E0QBUIOooycaC96C5JEiO6Eg1n3WM/EW2Eslh
         BmR4VbVxup02KaY7gElCv8q6POX88OYSBFDuVxJ57cZyuBhWgh3pGazT2vEMcVJ5n7Cy
         iTGA==
X-Forwarded-Encrypted: i=1; AHgh+RqXWgK8/7PaARZkBkFGn3lX7Rf2Jv8OLdcJPskqF+L13pA2N6ai6cHlA4YjEgE8q3CiowU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWc934WGsH1BMC//Na/VvcYYe4IiNah26nZXcLFgpNpTWgfZti
	aDrQY6S5Vta1aOthNECy7G0B/8xYzrIgSWkBK5bn2CaUqC5d18aNlTwX
X-Gm-Gg: AR+sD10lxxsRUUXqcmh8LzuQe91+5I9oaJ8szk30YgwPoldQjMSq5Ly5PW76ai+Gmfg
	tjRX8wvH3PPxHlG6SPogiNzRW3UuPGEQAhCSNFkEqEo2+tsyz9sGfr6gdXhpCMeZGH7+pwTtaMW
	V+36IoxWWhJ5ogBFBDFcbz/7CDgb3YODsCdp/uL5qnTlQn4cfwO8NJHgiLlP6GIBQvJPy6Tllkj
	1NTVv0AKQZTj5MPkJkDiFCZcfu0ATHeJRVWskw+tLJ11NzKQgco2BCsxfHfRZqqE/J9zIcXUdpr
	u9AyIUPFtKj5f4chtqo7TdD8iW7+GKc0Jy0kI3Yn3oV+XkaZWsHfgzUeYslesi6Ww6AM/wCQn3r
	sNIxKHktAm2KbbORyWuiuQw0NUkg+xhWMu5fTVzjBtRsJQ2ANbo/w1EELxK7F2b1bjGrjttyEll
	kvLZLLEFpIPHcWt96Epz5HB0rrFgXjCB+FdR9xTcODus8KCMMlYbjIXg==
X-Received: by 2002:a05:6a00:12ca:b0:84e:2722:5d9e with SMTP id d2e1a72fcca58-84f9c8da5a1mr3553132b3a.1.1786387925682;
        Mon, 10 Aug 2026 11:52:05 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:52::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a58e6c4sm4386298b3a.59.2026.08.10.11.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:52:05 -0700 (PDT)
Date: Mon, 10 Aug 2026 11:52:01 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, 
	maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	aleksander.lobakin@intel.com, horms@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, alice.kernel@fastmail.im, 
	dtatulea@nvidia.com, witu@nvidia.com, martin.lau@kernel.org, 
	yoong.siang.song@intel.com, rohan.g.thomas@intel.com, intel-wired-lan@lists.osuosl.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	leon@kernel.org
Subject: Re: [PATCH net-next 0/3] xsk: pre-existing AF_XDP TX metadata fixes
 from Sashiko
Message-ID: <anodof8GsDZHZb-S@devvm7509.cco0.facebook.com>
References: <20260810184753.135756-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810184753.135756-1-sdf@fomichev.me>

On 08/10, Stanislav Fomichev wrote:
> A few fixes to address pre-existing issues from Sashiko review.
> 
> Stanislav Fomichev (3):
>   xsk: align TX metadata layout across ABIs
>   xsk: honor XDP_TX_METADATA in zero-copy path
>   net: stmmac: skip queueMaxSDU check for AF_XDP

Ooops, this should've been targeted to net tree. Will resend in a few
days in case there is any review feedback.

---
pw-bot: cr
